Return-Path: <linux-kernel+bounces-442660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D736D9EDFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE32F188AA90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8788206278;
	Thu, 12 Dec 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySUzYznP"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1F2063D5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987237; cv=none; b=QFuEbVpZP8xJ0BKEt+/iLfE9CVJiLlGULtYVI8H61Dpfg2RJAsV9w4UFKzJMes6YdZH6yQ7YLraa2FVcZpMdxQzQnSvZJVaR8tUm7zcgqFgCW4xOmS7zP8mbLEgC39PtSn+SkEfm9UpwyadUHF9AmL4bbRXMHjMv4afD37mK4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987237; c=relaxed/simple;
	bh=xFmBnyAttvMuOzVsTjQlhULu1cgriZXvVbXqOa49GL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb4KM2P5IXN06Mi7Blfn9r9hDHiriCPMc16apO4bc3/XGXrp63p87cOwDKQfPuklrV/BG78YF6hYKhqx6NoehKj+4N9fvuhSoOjoXC8epx3jPbUA9ILRmhaWWEC6HZxNjtACUehxRBM3K4iOSTaS0x6+Y3Z6LQdatIHT4je4xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ySUzYznP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72739105e02so345226b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733987235; x=1734592035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWUSTVMYq8BWWEAYYe37DF6F5cN3F7NwUno8STAUMA4=;
        b=ySUzYznP30RE94EN/ZXNY0aNU+SKblS60dGgXPZWYhGevHzhrMgSHHZUC7SefVL4xF
         t+H3/SAKBzFYy3zNKE4FCJl3hkwV/2wj/qa/BSymTy1RhESYCoDTGRago07DiV4P9Y29
         tENxUjcDECY8CFqgVsfD7CDSafP86DcMTW0xLmtQbrpYCdqXkN7PGU+5y9kfI89PlgTD
         9ZX1G6uLFcLNHYarXHv0SmCOk51LCjx4C300fF3dsSxdyRHvw3jkFQgJjlEFF+SXpZ68
         2cA2Ojxa1g46l7uO5f0CkxXdt/FwMzsUvetl74NwUTNOdYRb0y0wGx240AfjWovYrPoV
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987235; x=1734592035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWUSTVMYq8BWWEAYYe37DF6F5cN3F7NwUno8STAUMA4=;
        b=WQbRmWJjX1+9KnN/O08Yb+UoUV8+J4fYb1BZx5raieEboPneKJnpDnIoO1FDs0aQDI
         Z2LzaFXq3EozzAnLUsJBLDPBrjpy0MqjlE4if2w1/GoSDYFzejelTmhW76cJc3nbHfYM
         T+zhct4SATvy5ILVjKqwyN2f4DUJ8TWIa0yvu3hbfFymJEwSk2J/88FivHmkLU7PO68/
         xH8WUBxiewxIU1Ma01aEqbmQh4A/fyC6fn8JNWaTy4NUDe2g0rPNycVyu5OvZjhRA1Hy
         N+KYs9zFhha0IYchrXambKEvn7NxYYvKIFgVDV0siM3zPzZ2vF08LtmllruaNmnDfLvp
         ot/w==
X-Forwarded-Encrypted: i=1; AJvYcCXc7g8JIyWsLcc9UTdgw1zkvpwGMvmazlxbzo3HU2BFgqCMrntpbTY/OCNScGAV0c9OFF1bI+NuPCaZMdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwp228nl+Pipd37m/k5HUBtd+VrhO4hkLh64lCWK9vQ6F9bryY
	wr5n6lJ3mU3wzDVj6Ly/zgYazrlVFTe2RChSx0W0YThPRSJb8A6FpgzcRLnyR4E=
X-Gm-Gg: ASbGncvDgGSoT3i2HXzjHqk4QiRe50LEWIw5uao4OoXD61zaX1RQVfijxCkXDIgeB5l
	QDXPiSWnWBP+qrondKauM6924KkjsADuw3akN+J7QBi2PpE5taoAyHbDPAaoULAl1ILLAUvbBgu
	FiyULs3bPaksJl4LcHvLMF75G3UfwNcUQpGxwh8S9n32pHRCs7CxMmtEDQLvd9v9qGAZXiRej6n
	Tc9LIPhjuDATLf4N5Ub04HHeW68+td3Kv0d+IfK5MLONvwpJq2kciXZ51s=
X-Google-Smtp-Source: AGHT+IENxoHonYKam4dKHihrFBZZ3t2m1GlwpQo36E6FIiGVq5NKmR5l1Fyzj203B0EBrt1cbsUdog==
X-Received: by 2002:a05:6a20:7289:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e1cea52e56mr3771734637.3.1733987234861;
        Wed, 11 Dec 2024 23:07:14 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d3dd4cbasm8926045b3a.142.2024.12.11.23.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:07:14 -0800 (PST)
Date: Thu, 12 Dec 2024 12:37:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: bschnei@gmail.com, Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin Schneider <ben@bens.haus>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20241212070712.txkxgmiugzji3doz@vireshk-i7>
References: <20241125211452.14987-1-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125211452.14987-1-ben@bens.haus>

Marek,

On 25-11-24, 13:14, bschnei@gmail.com wrote:
> From: Benjamin Schneider <ben@bens.haus>
> 
> This frequency was disabled because of stability problems whose source could
> not be accurately identified[1]. After seven months of testing, the evidence
> points to an incorrectly configured bootloader as the source of the historical
> instability. Testing was performed on two A3720 devices with this frequency
> enabled and the ondemand policy in use. Marvell merged[2] changes to their
> bootloader source needed to address the stability issue. This driver should
> expose this frequency option to users.
> 
> [1] https://github.com/torvalds/linux/commit/484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe
> [2] https://github.com/MarvellEmbeddedProcessors/mv-ddr-marvell/pull/44
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> Reviewed-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index bea41ccabf1f..f28a4435fba7 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
>  };
>  
>  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> -	/*
> -	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> -	 * unstable because we do not know how to configure it properly.
> -	 */
> -	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> +	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
>  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
>  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
>  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },

Any inputs on this before I apply it ?

-- 
viresh

