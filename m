Return-Path: <linux-kernel+bounces-535651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD3FA4758B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6829C3B1C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91B217654;
	Thu, 27 Feb 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOztkfhi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFD2165F1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635724; cv=none; b=WpCabxvSqyXq6WY+Fw/T29ZAMPjnE+mG2wT4wrKEJ+VrjwttA3Y7+hL2p8o7WP7MIRZ8m0LWViiCB3EhtTegoflEaephDVDko5kOFxsKgecvkb+qA0mb4QLtMkyzPsq6y1iWBxsm59iY9u/apeuDOXzCINakeV75oFkyreDiWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635724; c=relaxed/simple;
	bh=a16PvwGm4qBXlLLL+417IRkJ59dGv0+RH3qh8OGB5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCeeup7xx6dvQWdylfy/nYRHsgILfXH7YZ/qf7COk1qQZwywoe7m5zwrAG7j+xpZl1VWPqvr1lbHkxLoqmGQIV++GHb50a85v+pCKaVGWWiAhl4RSyJ77ZJgdv3ZK9N3x0dmodPRiPB8i1QE6ShcOBF806YVk2L7bw3pxn+Bx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOztkfhi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso76188266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740635721; x=1741240521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRjkJZuFXwrWKhSpmIetOy8zuA4supf8coHnaUjnRXM=;
        b=MOztkfhieG3QwCVFRhKOpGwbrP53/vISRtW6S8zjNjc15S8DLHypX7hZyQ3JgqEs3W
         TppJ1N5N8ZXmiwL/PtNNJNhFI++88dYIt7ayHF76MmZvsZ7PLwkToDbkT00CwPsPTdAk
         MbcVsagEM6IAEUh4WD7j104pyZ0BVcAF3xXNmGAp/keR6KKNds8OJ0n10ZJUaLpvqbPo
         OsQscQQ+R+wlIZnfbXa+OpCxAY7P5rEK1h2msFNdX3ZZ/5E0dIghiNXiH6tcLKcVXjKP
         SgWvp1Yub4EmvsSwCicLXX06YpnsaBLAgTuYKW03x4bNqkuIyc9dxgdmgEkPOGW5tkj7
         RcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635721; x=1741240521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRjkJZuFXwrWKhSpmIetOy8zuA4supf8coHnaUjnRXM=;
        b=uHhuDy53nKmnYD235v/tfKoeU2fOC/ddUnlun7wnWwpJFBVtDoKMmgwIQg2+XfzZi+
         L3BlAL7OaT52ENrHCnOYh7gxPOYdcuuvasDYvkdNl4QOLv5P6BZ/ayVTigXAp1t5XfCH
         FfGtZxH/QsquX3XB3lEhjHfBAYnNJobsM0sEF7ZBlbBPtO9/UZlk1BFvsv0lULDrT6Sb
         YZpkPvHenNtBDZMaPfx1ov34nLECTJgkBuhcgUAQT/qYukbvt0aSLWRzkJc7fG8VZsvy
         hSbzOMqrJOpDGZxXq33kIwN8QGgWAoyh9KgK2bAd8qitIzd4eVc8B8g9WZfrHmKG2Vch
         YSQg==
X-Forwarded-Encrypted: i=1; AJvYcCUEbCdJ4BE7FTwkxeszpKojQ/TxPdzv0SWAVONumq7RWKa2HpRU75er8q6PUKHcuAk2elYC5M/FuE7vQTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYvUfjXaXa5jjAa1H3T32l5gua4/1g3X9bNXE1oI5JerhIOoS
	WH6kQF8nPMmi1xPmU7oxWPvHwZblpbBrQWW+J1cUK6L2b2vv9WNZzlEnYJTF8d4=
X-Gm-Gg: ASbGncuyvlUEGhqRgeIHrrPI/0iYe2Y4TuM8MyF6dkvIzsuRCdngPbFJpunXSFfG+T7
	MvUGC126aTtu+NHSSR3vextiZIFm/5WUPDa64UCGjfKK23zbqhwFFZvCpZYHqXlL+iXXPjaFSY5
	JfrJWS1WzmR9pBxlS2BSbfELUsh/qygpnNyptQyp6ixHiQhHtckxO89umj3fqaeSpT4FSXPfwr6
	FE73NUMJr7dxP5f+cHJR6TvvKNuBf4fdOKXsJbx9RA09NImiszV5aSYE0SWv8JIuoerNo/bjXPb
	LRstSXm15ArLVY/OpX6UQSAVlqc987k=
X-Google-Smtp-Source: AGHT+IF7QEecXEFd6GRvVvQxUkIk6G36vs7TrNq5mJmrzU0yTJVfAsEa/DfPng5kBj+wVjn1N7h90w==
X-Received: by 2002:a17:907:d8d:b0:aba:6378:5ba8 with SMTP id a640c23a62f3a-abeeefd2b42mr753662166b.55.1740635721079;
        Wed, 26 Feb 2025 21:55:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0dc6adsm66911866b.55.2025.02.26.21.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:55:20 -0800 (PST)
Date: Thu, 27 Feb 2025 08:55:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, error27@gmail.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rapidio: fix an API misues when rio_add_net() fails
Message-ID: <9b3d1ab0-1313-4f87-9b98-15dd78ca24a8@stanley.mountain>
References: <20250227035859.3675795-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227035859.3675795-1-haoxiang_li2024@163.com>

On Thu, Feb 27, 2025 at 11:58:59AM +0800, Haoxiang Li wrote:
> rio_add_net() calls device_register() and fails when device_register()
> fails. Thus, put_device() should be used rather than kfree().
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 27afbb9d544b..cfff1c82fb25 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -1742,7 +1742,7 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
>  		err = rio_add_net(net);
>  		if (err) {
>  			rmcd_debug(RDEV, "failed to register net, err=%d", err);
> -			kfree(net);
> +			put_device(&net->dev);

Yeah, you're right.  But the worse bug is that we're missing an
"mport->net = NULL;" before this goto.  It leads to a quite bad
use after free issue if we trigger this path.

Please fix that as well and resend.

regards,
dan carpenter

>  			goto cleanup;
>  		}
>  	}
> -- 
> 2.25.1

