Return-Path: <linux-kernel+bounces-175369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF58C1E95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162961C20F81
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364B15217A;
	Fri, 10 May 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pgm0dJ0F"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0020153BE2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324418; cv=none; b=i1vFAIg20YNUHeyaP9d3/9atT51NFv7ACZ7LZTDm0qoYoHQV4Z3kpv9dL25BAg4Okzt9cNiMoeXu5Q9eOo+AsEHzXvSX2lscu9729B1xC11lFYmHT1dXyP1IvKO7ZAc2tTj4KyvKmAH0E2rPGOclRBrG1sTjw7OUO/DztIx4apU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324418; c=relaxed/simple;
	bh=fiMdTze04blYBNgjtZ9jLx68WaAxEZXlRKuAWqnbJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2cJe9FkKiHKKA+yxJM4+LgFq0ROKecaVrg1IKpuACHFcna9VOx93cx4vzYm8RXr9DufLo3t0gnoyyIRNeqbLHydQ9DezwIjHiOBYL69nWVr7M8h/+uJsMDFqZsrBC7kWtak+anyNv/YCUUY38KgW34rKN3IBW18McTXekA73SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pgm0dJ0F; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ecddf96313so14433575ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715324416; x=1715929216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wu4CHIE3/fZBIgCCsH77G3GxxIsG3jfzOZ7W4gSAVM=;
        b=Pgm0dJ0FvBMKZpGqEH6RntlUi9SlnLr7YLc4/wH4z6V/qCHQLT6AQR/54sqM8rpZ74
         EMKe7fL3eIl94oCQoF5l6pO0NdSgdChiWctJnzzBAqgXSF2h4E45HUDJTadHC2dHjB3c
         hwmutnYDgVH9uhsiwS2kR2gIiEP3gt5BD5e2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715324416; x=1715929216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Wu4CHIE3/fZBIgCCsH77G3GxxIsG3jfzOZ7W4gSAVM=;
        b=WHEVC41uZ3Hkj3/sh3Csw88bSpnbBuJ0pX4nLPteQOqxrR8/mf+TUzTA4b2yJ9J6eQ
         JRFiiGRCmGqtpVen1qo1e/q0Y9hOFroK4wli7QGy6YB95TuIZlFlqNN9UYNHqC0HAPss
         UzmnW0L9DgWORmoqA+8oa+u1ctWHTlK62XT1fae2FyxazF7r/qNhtU68a2XoMBHHOZEM
         arC5hgy1cjCVHP8fhuIZtVYk5BKBTtZPSIzKbq4V8XP1+CEE2M3VQqy7/i/5tka9cYuJ
         Qx4nggVwAqcoABWcSvjaLquFfHllLJ5JY+HVYoK9PVSPHlEM9aNSnOPTzt25bxxSXAC7
         WG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmLJ9Xr6h/rsuWljTixpiuVr4gGFEqcyBaLRKlNI7te205OquGmY6Km9PYn0Tie9gQNQlnj9V27TR9ennCKPQnFmVU2FA/duO6OCPK
X-Gm-Message-State: AOJu0Yz8tUbg/h91C2+MTLL1usZOkPh1MJ+JwYAnEfoT6GIOPjN/NAki
	louzo+qEIDoUGAnm21CHEai5NFd+IkFy0sqPts3qpnfrt6pI7VJb2jE9JWfZbA==
X-Google-Smtp-Source: AGHT+IE9VfE94edGBZOSRivuvAcBMgUK9hlc6HVQ5lofeqMc8TG8iJGC4ySvtTJmystPdlRYhmHMFw==
X-Received: by 2002:a17:903:1108:b0:1ec:53de:a51d with SMTP id d9443c01a7336-1ef440585f2mr28002415ad.69.1715324415801;
        Fri, 10 May 2024 00:00:15 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada410sm25189735ad.69.2024.05.10.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:00:15 -0700 (PDT)
Date: Fri, 10 May 2024 16:00:10 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3 03/19] zram: add lz4 compression backend support
Message-ID: <20240510070010.GA950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <20240508074223.652784-4-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508074223.652784-4-senozhatsky@chromium.org>

On (24/05/08 16:41), Sergey Senozhatsky wrote:
> +static int lz4_compress(void *ctx, const unsigned char *src,
> +			unsigned char *dst, size_t *dst_len)
> +{
> +	int ret;
> +
> +	ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len, ctx);
> +	if (!ret)
> +		return -EINVAL;
> +	*dst_len = ret;
> +	return 0;
> +}

Apparently lz4 supports compression level tunable, which is
"acceleration". I'll slightly rewrite lz4/lz4hc backends in v4.

