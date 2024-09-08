Return-Path: <linux-kernel+bounces-320177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1097070A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07798B21273
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E41531FB;
	Sun,  8 Sep 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjVjfc1m"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349314D715
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795913; cv=none; b=nj6od4IKpKiTTgzWINR61v2Bfg874uWnNnlGZbCFKWcMZy/968zOxsULIOQJHFIx9PGSZCna749U1d9buoF6IXQ5FKbOSNHNGN5lNCKSXQrRpO8+msXQeBtrqhRoSxZedgFsDgZ1qSV8QAddmvv3F//jbFSQ53438w/DGV7z5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795913; c=relaxed/simple;
	bh=HSnXKMQgZLXcJYUHL18kiCIOeKVxkWAs5Di1nGk0eV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awY1IBxCQiQS0wpsJLvw86b4EUeyb8nQ/ucEf3U5rt1awTajWdYmqTOAWlP8y+ndN0i7FZBpphC+nuoGTPSt0kyOl457Qv79FTrGXpXEXN4DhxfXSDfXuLbHNSvOnRW6nQtPxYYTmzW1KD2gnOOcHKQH8TiUaOwSnpzcEKQcWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fjVjfc1m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-205659dc63aso33462025ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 04:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725795912; x=1726400712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgXrTvuyZhyT6kmnMqrr/qesyKb1JNQr87bAiGPrQNs=;
        b=fjVjfc1moUjoAodWa2TLA4D6dcUwTKeInLbZB7C+GDIWLARQ5lgWbP9OYbDqVki4cm
         BlKbEpgbmPu7qE27Gv6hJgv0qXsJg1KnAjUGt13Fn8IOKtMbguz7o8pS3P2Fnubxco9Q
         f2AhgD9hESxlNzSNvphCb6O+LdAVtVsXlEyXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795912; x=1726400712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgXrTvuyZhyT6kmnMqrr/qesyKb1JNQr87bAiGPrQNs=;
        b=YcGSCdbgEV1xsDq3zaH75weQ9qvALLfSYuLH+SiuYT6crPo3YUFZIeQCbLEYMq9kk/
         vEQvPo3Z0pWi4fbkyULsgk/fccHn7+Wi/NqqS8caTfVklmcmFJ3uemtJr6ExYUdeYrhT
         R0Kyf2tvNPYCP3W7zeNGsPYE4uvyNsyz4s23VehGJftRlYyI/lKg+BUzshN2imuu0tjA
         f43VK/2QiRtDJd0z6mRaY2xbIAUvZH+25lKKh0szzX72MtgECG6zIAy0wZ9NaJmMgq5e
         T5G/u7IL0Y/rTV4s8Di/u2pNdU7r9ruHwpEcMY/C8WXirZ34wDpXgWcmc9XlEqC7U04E
         n64g==
X-Forwarded-Encrypted: i=1; AJvYcCXDOgiyqCypPGtVuDrtlEYrEJ18t68SC1KsIG+4YtKzK+HlDgIEl+xpmhe/oSfQfofSzKNn9+Ta1RSbfps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDqjA5F4dyEbcHsGDP9l1bwkv4qk4qSZOjzJWTuL7xPcaMnqz/
	fk1JCC0Od4A7hzIm6WW2cCYnddZ8i0uuQ6WeY5Lu/YsGcyQtYIhqEzIptCLOgw==
X-Google-Smtp-Source: AGHT+IEpkG7C0gtn+JFnmRlwmIzAn0lFjV4MHb5ZiSpAl6tX8TlN1ny/DyyNvDTcgmu/ZpjQPxqQRQ==
X-Received: by 2002:a17:903:182:b0:205:500f:5dcc with SMTP id d9443c01a7336-206f05e5f73mr74085415ad.40.1725795911786;
        Sun, 08 Sep 2024 04:45:11 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5879:695a:4656:45ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f31f31sm19121285ad.243.2024.09.08.04.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:45:11 -0700 (PDT)
Date: Sun, 8 Sep 2024 20:45:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/3] zram: optimal post-processing target selection
Message-ID: <20240908114507.GB2413563@google.com>
References: <20240908114223.3024872-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908114223.3024872-1-senozhatsky@chromium.org>

On (24/09/08 20:42), Sergey Senozhatsky wrote:
> 
> v2..v1:
> -- clear PP_SLOT when slot is accessed
> -- kmalloc pp_ctl instead of keeoing it on the stack
> -- increase the number of pp-buckets and rework the way it's defined
> -- code reshuffle and refactoring
>

D'oh... Let me re-send it properly.  It was supposed to be sent to
Minchan and Andrew.  Sorry for the noise.

