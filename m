Return-Path: <linux-kernel+bounces-441479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF939ECEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AE0167AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C71A0726;
	Wed, 11 Dec 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTPmN5Y4"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C782191F88
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928214; cv=none; b=gdisQgRxqgyr5jvSl6zJkydjAUJlW6zDF/D4kVsuFmWd1Xn/ZWq5vBR4vQGt0djNgxtU868/vWIxf2ID7WSH3zHpcat9EJ2ehLNrEEKht1v1NJO0uIbuQWKM29FExGkNWnXWkZZXNOP9BsPqE3ZyQjX8QmDMcJARP4vTVw9WPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928214; c=relaxed/simple;
	bh=LNfbBS4JcW3bqltyDScedOWIg/0KtssJKmos97a7344=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCxAATIJ6h9v8qCwc7uPfDY//CLgWuWewNpBY2hQIXwMRzU8cG7AYdSWhrLG4LwykrEms3gzZ80ddrH6miona96YfthWv3AvAV8RMHY1y4KGi0MRNxxIXzO8CbHQmsFSsqQq8/k9hZM/QGZvc9ch1UXrKkyhuyDtFoQl59ADjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTPmN5Y4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3329386f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733928210; x=1734533010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tZ3oScaXADgh2YYICTmnLAOe1Prw/82LWnlm+aUpE8=;
        b=rTPmN5Y4dy9SAYYuHRVGTKnEpWbOm2QEtjvE6ijxP9p/6VNdLqenvTStNruMR5jcfJ
         xh/HiaFtEy8RmM2nu013svLyRn80YJ8H2shZBQf98PZEpQ4+nSgJDayRubAUgk9L5EZm
         Jbz7SHEDP3MjhMkWxJ5A+Fqkgtym8l1/LKJDpk/uFIJZhHUFG19qf3O9aMl/XBOZ5S30
         BlzI5kwnjUuZIGVlgngfNHM7y5Pu8mt1wNiGJQY1ugw72U2h3SN99M3A6JhsYerG8A2F
         y6OXQo3/rH5X3VmAkALE1UoK6uKIVzxNZSel9ZGWYZyJSZY5BePqjBIpWheFMDoax4Lh
         SuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733928210; x=1734533010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tZ3oScaXADgh2YYICTmnLAOe1Prw/82LWnlm+aUpE8=;
        b=OFPaVvc9FnCYVxYyZ4KnCwMn1H+ZiJCYbdDalk1NsUJkKX8b7IpjE93gMEfwAV6Y8M
         d4SwkXQFirVOdDEiMKzwAL7/euxwTQJfYwyU5fbnH2V9iCll7x+uaPQvnSZhMlUTubId
         hlHXw6Pt7PGdjCm36NwYx+4LtqznWCIHZUr5JMiEmLDixdkzVppEgSRVUlRKIzrWxdKd
         z9XasmJE1lM8Zx4axazFmB0K0Z4XObm4spy+w2dSOLu7TlM26Pok9+NWMg3wNYCUIboe
         NWYqTHRBRVXWucnxqal8PVnLX60eL6p8+CFoQRpWsMW4GceGae1WNSWNzRpSlJ7rSrtB
         cEhA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Cv+XSQKACXGqLk8YR4EZMZiieJHmRKjGY4K4LKpvlyeCv2m+Q3y2NT1VOKADT6+6rl5RubG+la8rdtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/UHbNzq6QPewd1AvHyVgMgOK6wlMoga1T3cka7uKfY4L/tzi
	OabaIh9PfOVK9HjZQudcA/mrZYc/wDMDhaotp2vq83h78jpZb0XhnLRPS6xNzJA=
X-Gm-Gg: ASbGncsDT+ifyrmnzH1U4twg21xK3MbWEerwHxIr+8BCd/L+HgLxmrLsw/4nCNSqB/h
	Kzl0jaUNGbWmqQyGcQ6Cy3ei/cZ/QrA35UTa36Wg35H/aqNGVF72frVaZ/PDxF4oca9vvzbWMZJ
	2gbWWx/wV9daqwQf+r/5PmNGgyDbiqd6zOW8VxceaupwnZg/be6B5yE5fQMYPJ9fPwv8V4cUceS
	Z9WCNl3LvNHfRj352laCHwS3sx+l2LhuqCtfhbNKyfBNihVVZRhQkn24Wg=
X-Google-Smtp-Source: AGHT+IGhBl9kYyiFJWrrIA36GwLyBYxcBdJzLqLa3LCOZD0jb1flkcZBqM18kbs7vv5xS6DGb2Iuqw==
X-Received: by 2002:a05:6000:2b0e:b0:386:8ff:d20b with SMTP id ffacd0b85a97d-3864ce9f344mr1998729f8f.27.1733928210457;
        Wed, 11 Dec 2024 06:43:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362039a474sm11589855e9.24.2024.12.11.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 06:43:29 -0800 (PST)
Date: Wed, 11 Dec 2024 17:43:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, matthias.schiffer@ew.tq-group.com, robh@kernel.org,
	u.kleine-koenig@baylibre.com, javier.carrasco.cruz@gmail.com,
	diogo.ivo@siemens.com, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v4 2/2] net: ti: icssg-prueth: Fix clearing of
 IEP_CMP_CFG registers during iep_init
Message-ID: <3b0b84f9-d51b-4075-9d1a-5c2042ee6c4e@stanley.mountain>
References: <20241211135941.1800240-1-m-malladi@ti.com>
 <20241211135941.1800240-3-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211135941.1800240-3-m-malladi@ti.com>

On Wed, Dec 11, 2024 at 07:29:41PM +0530, Meghana Malladi wrote:
>  drivers/net/ethernet/ti/icssg/icss_iep.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
> index 5d6d1cf78e93..a96861debbe3 100644
> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
> @@ -215,6 +215,10 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
>  	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
>  		regmap_update_bits(iep->map, ICSS_IEP_CMP_STAT_REG,
>  				   IEP_CMP_STATUS(cmp), IEP_CMP_STATUS(cmp));
> +
> +		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
> +				   IEP_CMP_CFG_CMP_EN(cmp), 0);
> +

Don't add this blank line.

You won't detect this by running checkpatch on the patch, but if you
apply the patch and re-run checkpatch on the file then it will complain
about this.

>  	}
>  
>  	/* enable reset counter on CMP0 event */
> @@ -780,6 +784,11 @@ int icss_iep_exit(struct icss_iep *iep)
>  	}
>  	icss_iep_disable(iep);
>  
> +	if (iep->pps_enabled)
> +		icss_iep_pps_enable(iep, false);
> +	else if (iep->perout_enabled)
> +		icss_iep_perout_enable(iep, NULL, false);


Do we need the else?  Could be written as:

	if (iep->pps_enabled)
		icss_iep_pps_enable(iep, false);
	if (iep->perout_enabled)
		icss_iep_perout_enable(iep, NULL, false);

regards,
dan carpenter



