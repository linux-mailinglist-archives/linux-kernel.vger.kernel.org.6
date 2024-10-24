Return-Path: <linux-kernel+bounces-379625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A679C9AE137
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E28282751
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85D1B85C4;
	Thu, 24 Oct 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxUMJwxe"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA11B3947
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762763; cv=none; b=Ut1G8lGbUW3aNkJS5eVFK6pO2+wOjttJdvj1nfFjE7g2zQybfnEB2oZqrXFUCbu9UCQepA4s93j+t31klb2IiuumO+LzGp3Ykj06O4o+v0DpLbvomsoDyStwoDeEPnu4nEgTAV6Kc8VVpetweLu9tNIBZw0snXzfSjgos7YLbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762763; c=relaxed/simple;
	bh=psIUbzYLU4wFIXrzpbnQ/vVEnWJP9SPVhMuz47ZQnSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dwtka/OY4wglx1nypSbKc8Grm6sGmmfBYf6KkSy8BvNRQdWefTl90OnjpuZb2zoxIQOxZ+PwYeqRkeJPigZAX/g84r6sCb9WvS+5h/k0tq3XvI8/oy1gsH2ssU78nQDuZ1hk6yhfT1JBMHEYYzwCCimyXC1sCSCwUuHCHMZaICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WxUMJwxe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso535723a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729762761; x=1730367561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psIUbzYLU4wFIXrzpbnQ/vVEnWJP9SPVhMuz47ZQnSI=;
        b=WxUMJwxevqeDB/jkSpz8EWP7IxD/8hYPRCGf51b6WZWGdDxaCmlTPQhZP/oNyf8f36
         OaCq+4zJlS1SYVUJCebG08o6qU+ZiARy8a8kV1jgcl0AohbnWyaAuZprGvrdt2e7ZvDU
         JwpRCuuUCIEf4obZZyvY7IvXys5jI55Bo+64Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762761; x=1730367561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psIUbzYLU4wFIXrzpbnQ/vVEnWJP9SPVhMuz47ZQnSI=;
        b=jTn+vuCGpe4L9TguVlfkC+IlkJD1e+L7MNrom5Jenr5RKN+Yule2r8J/b3+47H+kBf
         mlZ1Pjh97jriME4Ykp99ctChO8cO9A25O+ts7Ui7wyHCpAAV3F7/1ORB3Bfjr9FeDSLS
         3g0lIvrahIOhkQEfH8cJM10QXCNmk3DHUG8OaQQ104HeP+SkS5gDSKMqV2xSlFL6qXwC
         nKy8na0pYWHpRiqTSGuKRFJrGSY7127wxQxthPGgsJImo3gaRECW2RCNQBLaqYXuNXt2
         zJflxz4DqcX3CNdduE32hCSIoVwcuypWxollyvSdIKnjcL+XyMdDKnl0X1pDfAVu6yZU
         piDg==
X-Forwarded-Encrypted: i=1; AJvYcCVASGr5s9BK1t7KtblsbebxBsnXpge1A28W4baPPQTBdvgScw7cKO0FCyq7myBlZ9yVF+q0b2OsafjDt2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgCWughV4z60ar2I9ggNC6nuXmljXtjbaleMIZ85v0eXL6xKN3
	jHvXANcXFtyY2aJEoYUrmFVt/Q8v5GJbQiZ1Rrl+RWTMfwYe0SmCdnj4o1Vr4QD2ZfagJa7lBOl
	k6Q==
X-Google-Smtp-Source: AGHT+IG/IKjjlwb1UaL7FOR7rGdqnfvfZnxV4AE1xFUVjA5gLqDjXVktzbl6HM0Z4bmYO3X6wcbh1g==
X-Received: by 2002:a05:6a20:d492:b0:1d9:19a0:c36e with SMTP id adf61e73a8af0-1d978b98610mr5702616637.31.1729762761004;
        Thu, 24 Oct 2024 02:39:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c7f5:2aa6:333b:bb6d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f36f3sm69432655ad.263.2024.10.24.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:39:20 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:39:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] media: venus: sync with threaded IRQ during inst
 destruction
Message-ID: <20241024093916.GM1279924@google.com>
References: <20241024061809.400260-1-senozhatsky@chromium.org>
 <20241024061809.400260-3-senozhatsky@chromium.org>
 <4b96f1f8-e084-4599-abe9-05039bfac569@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b96f1f8-e084-4599-abe9-05039bfac569@linaro.org>

On (24/10/24 09:59), Bryan O'Donoghue wrote:
> This needs a Fixes: tag too.

Ack.

> It also occurs to me that most of the close() operation code is shared
> between venc_close() and vdec_close() a welcome patch for V3 would be to
> functionally decompose the common code to a shared location.

Any preferences where that "shared location" should be?

