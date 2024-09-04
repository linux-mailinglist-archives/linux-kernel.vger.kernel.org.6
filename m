Return-Path: <linux-kernel+bounces-314526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D696B483
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C01C20FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41853185B41;
	Wed,  4 Sep 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="AMgHTke9"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E818593C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438544; cv=none; b=Gx0hNV1BNlrpZc7QVs0zcsZbYc+kq7fK9bCYk0RjplClbzCuaq0Y/lleYJ8Ftu8koLtnNs7gxtg8qojnqfJvcdYitrSzF76dQyYEG3JrCblM3u49eVtVmuTz4NOysMvdpBSQDuMvHg2zwc5n0HJzmiAW5H+czwSxAgj1ky3TA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438544; c=relaxed/simple;
	bh=Uk497RCKhYsNExZbK6yZQOhhX+LwfPazt/slIWR/tUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkQk3vG9PnxeTWRV1x/bC4gP1e5v8fnGB5sRzP8MCRgzxotsJhNiFgRUBp5DZrwr4z7lz26gRZq9zsM48WNBp+Zr9dw8BUWgYq1pPf1x2cGcuFABwrXl+Y16rgWuejlZX9Bvt8h1N2dRNYEZUtw/W9PG3P5blnmfceYsDNSanKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=AMgHTke9; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=AMgHTke9;
	dkim-atps=neutral
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E7F31105
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:28:55 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fd9a0efe4eso67350695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725438535; x=1726043335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9BCwc1u246SzIEfXsEg7Wl2dUEH2B7BGFR7ylaNFJA=;
        b=AMgHTke9tx1Xv9AIzw0jc/Rr+82uJxnqJtSa62OhZuBXXRM1tXNR3DtAgwzti8ofi0
         lHrQZfoNekhC4wcNNObN0ufjokE2OVs6S5xHPPL8SSLIMIvDKQeppQw7HvjCbYbo6LhQ
         D9BU4XSHOzJMdvjVs+XBi9P17cmheFV470Q67v3B6kflrO1ruTTHsWt/DMcxNi601EWk
         xpSKrkzgjXtz2l06GQ7aLEZ+vvFzpW688gQbPPjk+xgWt9wuYJstd05OKBm5yDOKVmPr
         kOGTpFP8koJLsPQ/snF0tg5XpfjL2wzcxOBZCGkAtNBkRDZ5g0GJ0LvcYrWpryO9UAkO
         83TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725438535; x=1726043335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9BCwc1u246SzIEfXsEg7Wl2dUEH2B7BGFR7ylaNFJA=;
        b=YnS2XHOnwpUVpr8sajvsVbhYZ1DpX1GQKiK86sDCcC+n+1nBWxGrlmSYkWSAWyS+9h
         AAovd6LLNMVud2kPlpTGKMbhO8HzHfq2VwIDU2O3m1K4DlYo78wLCzt6WNGU2vkRHjw6
         sLe5CJ1m/1uPam5K7LCbvSEmM7ixDPNRxldZ3J6BQnvyjClJg4I2cymZ8i0fD0UXcV/D
         BGLMFWtEvAzZ8i7QLjVQ2hKoYIpJAm2xFVyg8CIthdU1OIfV2PHOJguHVzwCf0ogsfEt
         nVffEMB6aEEybpr2zPuPkZBMx9SlY1ERBXYRJpeE1JBtDRhWwD0fI6hVr98fN58NiFtF
         VhxA==
X-Forwarded-Encrypted: i=1; AJvYcCWc4qHtkIWn/pIXwhFCGKXIKKJ4AR/+/ns6NrzRh2fxeqFBMVQosl9FnCgvUWCeQ5zIovxdIkFGjHkL57Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4MMuKNlVcAHAOzx5s94FHPmbU7puV5AqCGPeJIs8SGn+Wjjo
	0+gILirTuNW97iXKx3R4IEb4hXO5E+rvMbWZCXETlo9VHXiIB591GyAVBKA2HT88TL2TuStJ2OI
	6YzEqXYiDG6fEWjQBLzgKreJcqAxnw64//UT7KDHXC15+rgNujkg+q4ZJl28+ftS+xDPJMTBRjQ
	==
X-Received: by 2002:a17:903:1209:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-2050c40deccmr203498445ad.46.1725438534975;
        Wed, 04 Sep 2024 01:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS+b8OnFANk61nL2CTN2tYlqnFgqCAT2QKrc70UflP7I3lRMwNJQtrzMre3KtyFh164q8eyA==
X-Received: by 2002:a17:903:1209:b0:1fa:1dd8:947a with SMTP id d9443c01a7336-2050c40deccmr203498305ad.46.1725438534560;
        Wed, 04 Sep 2024 01:28:54 -0700 (PDT)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3864csm9133635ad.141.2024.09.04.01.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:28:54 -0700 (PDT)
Date: Wed, 4 Sep 2024 17:28:42 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
Message-ID: <ZtgaOlHi93b_py7T@atmark-techno.com>
References: <20240903013113.139698-1-aford173@gmail.com>
 <20240903013113.139698-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903013113.139698-4-aford173@gmail.com>

Adam Ford wrote on Mon, Sep 02, 2024 at 08:30:45PM -0500:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more
> resolutions without having to update the look-up-table.
> 
> If the lookup table cannot find an exact match, fall back to the
> dynamic calculator of the integer divider.
> 
> Previously, the value of P was hard-coded to 1, this required an
> update to the phy_pll_cfg table to add in the extra value into the
> table, so if the value of P is calculated to be something else
> by the PMS calculator, the calculated_phy_pll_cfg structure
> can be used instead without having to keep track of which method
> was used.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

I've rechecked this series with abs() added in the later patch and this
looks fine; all modes I tried properly synced up with my monitor.
(except one but I don't see set_rate() being called for it so it's
something else)

(On a semi-unrelated note on my backport I get a "PLL failed to lock"
message for the first sync only, but everything seems to work regardless
even if there is no further set_rate(), so I'll pretend I didn't see
that... the old code just has a 20ms wait without any check so it's not
like it was any better... anyway that's unrelated to this serie)

I'm also confident enough set_rate() won't be called in parallel with
different rates for my device so I'm fine with the new global, letting
others complain if that's a problem for them.


So, feel free to add this to all 5 patches:
Test-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Just one style nitpick:

> @@ -453,29 +541,70 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> +	u32 int_div_clk;
>  	int i;
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the clock is out of range return error instead of searching */
> +	if (rate > 297000000 || rate < 22250000)
> +		return -EINVAL;
>  
> +	/* Check the look-up table */
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
> -			return phy_pll_cfg[i].pixclk;
> +			break;
> +	/* If the rate is an exact match, return it now */
> +	if (rate == phy_pll_cfg[i].pixclk)
> +		return phy_pll_cfg[i].pixclk;
> +
> +	/*
> +	 * The math on the lookup table shows the PMS math yields a
> +	 * frequency 5 x pixclk.
> +	 * When we check the integer divider against the desired rate,
> +	 * multiply the rate x 5 and then divide the outcome by 5.
> +	 */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;

I still think it makes more sense to move the * 5, / 5 and comment
inside fsl_samsung_hdmi_phy_find_pms -- the other caller doesn't have
such the comment so it might look odd depending on where one started
looking.

-- 
Dominique

