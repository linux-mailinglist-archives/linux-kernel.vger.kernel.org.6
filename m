Return-Path: <linux-kernel+bounces-324232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C79749B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A1F1C21BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777D54277;
	Wed, 11 Sep 2024 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="PKMiEgHN"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96F2F30
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032394; cv=none; b=WrdR287QAIyMOZt5PUfMg5KV7a5UHPEJjIYOWPOhxndmC0VA/iT2YzOaGt8dtV9ndx1OO3Mey/UU8fB3Kp/jt/IydzDVRB7zM8ZY/fK8msbK/10XWaDTyEu9DI31EhXUIh0lVlHyFVUCBaa56E6aFFlVRq6TqZNr5NgmH/uOuGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032394; c=relaxed/simple;
	bh=BwFXt01g8VUnMEpIR369KCA2zGq1L6PVbfUTZ5pGTBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sp1hS2ih8r5UGeNjdFf55u9QT0s0BsY/kByAV5eo8mrAuWWEMEtDx3h9C0dyadLpyhFh+hknnI/7qyFJL7wEChFUWhKa1Wsq0Pcy0V5c0p6sTbXNFAmARXOWtw4fOPG8wZs4H7+ybN6dVztXbYwhny2hLo/NTysNHfBqWDA9oFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=PKMiEgHN; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=PKMiEgHN;
	dkim-atps=neutral
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 3CE8692C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:26:31 +0900 (JST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7db1762d70fso76232a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726032390; x=1726637190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFtWCQSyPet6eFxeavAaDGTVVxcUmCqeV03FdoDNs+4=;
        b=PKMiEgHNVpg9P+luWB+M/+XG+oYj9agnbsC3OdFwOy8Pu4l+9GQvSzSp8l0y2Q7SdH
         xY1gimbnM1ZCy0KH4v0cB3ZA87KJErczjSB4V6+9poP36Emuu0h54954ek1Hm3FZSNbl
         fwu5WgqYRVZnTPt3nwROYV+ibKxzDLEf5RabdzZg8Bm4wVUR3+dNHm0ud5nG1aq2Nafn
         UFwnOXFfUiGIqii4jfw3BqIIQuUREwEKMso7D2lgZRBDixvepIgInq7sf954+qPbCWdJ
         UB5D8ZFwBs12SLf1KKJvNkh1q198IkpQISVbTXLuoMXzDzDYrfTCzzNwpZxCOnyNbkbL
         lftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726032390; x=1726637190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFtWCQSyPet6eFxeavAaDGTVVxcUmCqeV03FdoDNs+4=;
        b=gdol+kuWVY7XbJ9cKIFnvSCSBBhhW1+UcbRGsp+/usYzFsVUpTnODCL4cEAOYfqRZe
         o+LkQQxmYTQvcjaBS+wrqCmWd3RjUkmOtyRtaZNoUaMJ++56Hx3k9+d0DmfXixditIPM
         dFki2YpAmOMaaVR4fiVFdPqzThi8R38JK4cRJsiEyun6rZDkzRM36b5auWu46CGoiV/u
         b/CWpiPaFOP4BhO/jLXVSDm1zyWf5lkLlJRg859ovlG1eyNmuDx14yt/C3vXTOAc0h3g
         UgytM4J6aRwkSYyV/PwzJ1MVFMZUitGqdBgZ6maIppKsMQTAsKKWCMVWQ2QQZGpxumzm
         YwXg==
X-Forwarded-Encrypted: i=1; AJvYcCWQx6FHgP5O5CGUdcc6WhB1ru7xVaSPb61xjSEEG18JDGMim9PBmiloJ2cPbiqPp67qvTZQDsYOOm/fUfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsl+YvEwHHmmymo6EoH6bkVWY5vZYM1k3vhEeKtEZ+4a47Tzb
	q9ndweG51srVvCOI4W1xEKFHGFlVGrjfmVVWmg6R3W1pAWK3A12gObhysIhzKXjxHhR1U7KytOl
	dOn2q/aeqgc92rz078L5QjIFOj3olVzaCfmWmPrQIJEEbMa+NhTt7ap/aR+afMl8=
X-Received: by 2002:a05:6a20:c793:b0:1cf:4fa8:49f2 with SMTP id adf61e73a8af0-1cf5e1c5999mr4457016637.49.1726032389799;
        Tue, 10 Sep 2024 22:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+VD6iJpBBeFJDyNMRtOJdjiSxnzZzJrxP5hRXLWUfNm2oOmBrmmqRP9Gx7w75ezTPeqhKFA==
X-Received: by 2002:a05:6a20:c793:b0:1cf:4fa8:49f2 with SMTP id adf61e73a8af0-1cf5e1c5999mr4456964637.49.1726032389095;
        Tue, 10 Sep 2024 22:26:29 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8237362casm5564655a12.2.2024.09.10.22.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:26:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:26:17 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 3/5] xphy: freescale: fsl-samsung-hdmi: Support
 dynamic integer
Message-ID: <ZuEp-QhnlV0byzVa@atmark-techno.com>
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-4-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911012838.944630-4-aford173@gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:28:09PM -0500:
> Subject: ... xphy: freescale: ...

the 'phy' gained an x

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

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> ---
> V7:  Refactored much of the code to create smaller helper functions
>      to eliminate redundant code and improve code flow and comment
>      readability.   Any t-b and s-o-b tags removed due to the
>      extent of the changes.
> 
> V6:  Fix comment typos and remove an unnecesary extra calculation
>      by using the cached value.
> V5:  No Change
> V4:  No Change
> V3:  Change size of pll_div_regs to include PHY_REG01 (P)
>      Create calculated_phy_pll_cfg to containe the values
>      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
>      Make the LUT primary and fall back to integer calculator in
>      phy_clk_round_rate.
>      Check the range right away to ensure it's reaonsable rather than
>      trying to find a clock only to learn it's outside the range.
>      Overall added notes and comments where stuff may not be intuitive.
> 
> V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
>      the integer clock PMS calculator.
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 371 +++++++++++++------
>  1 file changed, 265 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 4f6874226f9a..49317a96f767 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -16,6 +16,8 @@
>  
>  #define PHY_REG(reg)		(reg * 4)
>  
> +#define REG01_PMS_P_MASK	GENMASK(3, 0)
> +#define REG03_PMS_S_MASK	GENMASK(7, 4)
>  #define REG12_CK_DIV_MASK	GENMASK(5, 4)
>  
>  #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
> @@ -38,281 +40,296 @@
>  #define REG34_PLL_LOCK		BIT(6)
>  #define REG34_PHY_CLK_READY	BIT(5)
>  
> -#define PHY_PLL_DIV_REGS_NUM 6
> +#ifndef MHZ
> +#define MHZ	(1000UL * 1000UL)
> +#endif
> +
> +#define PHY_PLL_DIV_REGS_NUM 7
>  
>  struct phy_config {
>  	u32	pixclk;
>  	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>  };
>  
> +/*
> + * The calculated_phy_pll_cfg only handles integer divider for PMS,
> + * meaning the last four entries will be fixed, but the first three will
> + * be calculated by the PMS calculator.
> + */
> +static struct phy_config calculated_phy_pll_cfg = {
> +	.pixclk = 0,
> +	.pll_div_regs = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00 },
> +};
> +
> +/* The lookup table contains values for which the fractional divder is used */
>  static const struct phy_config phy_pll_cfg[] = {
>  	{
>  		.pixclk = 22250000,
> -		.pll_div_regs = { 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4b, 0xf1, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 23750000,
> -		.pll_div_regs = { 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 24000000,
> -		.pll_div_regs = { 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 24024000,
> -		.pll_div_regs = { 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 25175000,
> -		.pll_div_regs = { 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 25200000,
> -		.pll_div_regs = { 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 26750000,
> -		.pll_div_regs = { 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 27000000,
> -		.pll_div_regs = { 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 27027000,
> -		.pll_div_regs = { 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 29500000,
> -		.pll_div_regs = { 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 30750000,
> -		.pll_div_regs = { 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 30888000,
> -		.pll_div_regs = { 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 33750000,
> -		.pll_div_regs = { 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 35000000,
> -		.pll_div_regs = { 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 36000000,
> -		.pll_div_regs = { 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 36036000,
> -		.pll_div_regs = { 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 40000000,
> -		.pll_div_regs = { 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 43200000,
> -		.pll_div_regs = { 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 43243200,
> -		.pll_div_regs = { 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 44500000,
> -		.pll_div_regs = { 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
>  	}, {
>  		.pixclk = 47000000,
> -		.pll_div_regs = { 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 47500000,
> -		.pll_div_regs = { 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 50349650,
> -		.pll_div_regs = { 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 50400000,
> -		.pll_div_regs = { 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 53250000,
> -		.pll_div_regs = { 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 53500000,
> -		.pll_div_regs = { 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 54000000,
> -		.pll_div_regs = { 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 54054000,
> -		.pll_div_regs = { 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 59000000,
> -		.pll_div_regs = { 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 59340659,
> -		.pll_div_regs = { 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 59400000,
> -		.pll_div_regs = { 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 61500000,
> -		.pll_div_regs = { 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 63500000,
> -		.pll_div_regs = { 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 67500000,
> -		.pll_div_regs = { 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x52, 0x87, 0x03, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 70000000,
> -		.pll_div_regs = { 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 72000000,
> -		.pll_div_regs = { 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 72072000,
> -		.pll_div_regs = { 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 74176000,
> -		.pll_div_regs = { 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
>  	}, {
>  		.pixclk = 74250000,
> -		.pll_div_regs = { 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
>  	}, {
>  		.pixclk = 78500000,
> -		.pll_div_regs = { 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 80000000,
> -		.pll_div_regs = { 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 82000000,
> -		.pll_div_regs = { 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 82500000,
> -		.pll_div_regs = { 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 89000000,
> -		.pll_div_regs = { 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 90000000,
> -		.pll_div_regs = { 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 94000000,
> -		.pll_div_regs = { 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x32, 0xa7, 0x10, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 95000000,
> -		.pll_div_regs = { 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x50, 0x31, 0x86, 0x85, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 98901099,
> -		.pll_div_regs = { 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x3a, 0xdb, 0x4c, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 99000000,
> -		.pll_div_regs = { 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 100699300,
> -		.pll_div_regs = { 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 100800000,
> -		.pll_div_regs = { 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 102500000,
> -		.pll_div_regs = { 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 104750000,
> -		.pll_div_regs = { 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x57, 0x32, 0x98, 0x07, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 106500000,
> -		.pll_div_regs = { 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x32, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 107000000,
> -		.pll_div_regs = { 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 108000000,
> -		.pll_div_regs = { 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 108108000,
> -		.pll_div_regs = { 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 118000000,
> -		.pll_div_regs = { 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 118800000,
> -		.pll_div_regs = { 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 123000000,
> -		.pll_div_regs = { 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
>  		.pixclk = 127000000,
> -		.pll_div_regs = { 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 135000000,
> -		.pll_div_regs = { 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 135580000,
> -		.pll_div_regs = { 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
> +		.pll_div_regs = { 0xd1, 0x71, 0x39, 0xe9, 0x82, 0x9c, 0x5b },
>  	}, {
>  		.pixclk = 137520000,
> -		.pll_div_regs = { 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
>  	}, {
>  		.pixclk = 138750000,
> -		.pll_div_regs = { 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
> +		.pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
>  	}, {
>  		.pixclk = 140000000,
> -		.pll_div_regs = { 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 144000000,
> -		.pll_div_regs = { 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 148352000,
> -		.pll_div_regs = { 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>  	}, {
>  		.pixclk = 148500000,
> -		.pll_div_regs = { 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
>  	}, {
>  		.pixclk = 154000000,
> -		.pll_div_regs = { 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
>  	}, {
>  		.pixclk = 157000000,
> -		.pll_div_regs = { 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 160000000,
> -		.pll_div_regs = { 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x42, 0x12, 0xa1, 0x20, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 162000000,
> -		.pll_div_regs = { 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
> +		.pll_div_regs = { 0xd1, 0x43, 0x18, 0x8b, 0x08, 0x96, 0x55 },
>  	}, {
>  		.pixclk = 164000000,
> -		.pll_div_regs = { 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x83, 0x82, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 165000000,
> -		.pll_div_regs = { 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 180000000,
> -		.pll_div_regs = { 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 185625000,
> -		.pll_div_regs = { 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 188000000,
> -		.pll_div_regs = { 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0xa7, 0x10, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 198000000,
> -		.pll_div_regs = { 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
> +		.pll_div_regs = { 0xd1, 0x52, 0x12, 0x82, 0x01, 0x88, 0x47 },
>  	}, {
>  		.pixclk = 205000000,
> -		.pll_div_regs = { 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
> +		.pll_div_regs = { 0xd1, 0x55, 0x12, 0x8c, 0x05, 0x90, 0x4b },
>  	}, {
>  		.pixclk = 209500000,
> -		.pll_div_regs = { 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
> +		.pll_div_regs = { 0xd1, 0x57, 0x12, 0x98, 0x07, 0x90, 0x49 },
>  	}, {
>  		.pixclk = 213000000,
> -		.pll_div_regs = { 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
> +		.pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 216000000,
> -		.pll_div_regs = { 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 216216000,
> -		.pll_div_regs = { 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 237600000,
> -		.pll_div_regs = { 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 254000000,
> -		.pll_div_regs = { 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
> +		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 277500000,
> -		.pll_div_regs = { 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
> +		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
>  	}, {
>  		.pixclk = 288000000,
> -		.pll_div_regs = { 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
> +		.pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 297000000,
> -		.pll_div_regs = { 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
> +		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>  	},
>  };
>  
> @@ -322,7 +339,8 @@ struct reg_settings {
>  };
>  
>  static const struct reg_settings common_phy_cfg[] = {
> -	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
> +	{ PHY_REG(0), 0x00 },
> +	/* PHY_REG(1-7) pix clk specific */
>  	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
>  	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
>  	/* REG12 pixclk specific */
> @@ -415,6 +433,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  	       phy->regs + PHY_REG(14));
>  }
>  
> +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
> +{
> +	unsigned long best_freq = 0;
> +	u32 min_delta = 0xffffffff;
> +	u8 _p, best_p;
> +	u16 _m, best_m;
> +	u8 _s, best_s;
> +
> +	/*
> +	 * Figure 13-78 of the reference manual states the PLL should be TMDS x 5
> +	 * while the TMDS_CLKO should be the PLL / 5.  So to calculate the PLL,
> +	 * take the pix clock x 5, then return the value of the PLL / 5.
> +	 */
> +	fout *= 5;
> +
> +	/* The ref manual states the values of 'P' range from 1 to 11 */
> +	for (_p = 1; _p <= 11; ++_p) {
> +		for (_s = 1; _s <= 16; ++_s) {
> +			u64 tmp;
> +			u32 delta;
> +
> +			/* s must be one or even */
> +			if (_s > 1 && (_s & 0x01) == 1)
> +				_s++;
> +
> +			/* _s cannot be 14 per the TRM */
> +			if (_s == 14)
> +				continue;
> +
> +			/*
> +			 * TODO: Ref Manual doesn't state the range of _m
> +			 * so this should be further refined if possible.
> +			 * This range was set based on the original values
> +			 * in the lookup table
> +			 */
> +			tmp = (u64)fout * (_p * _s);
> +			do_div(tmp, 24 * MHZ);
> +			_m = tmp;
> +			if (_m < 0x30 || _m > 0x7b)
> +				continue;
> +
> +			/*
> +			 * Rev 2 of the Ref Manual states the
> +			 * VCO can range between 750MHz and
> +			 * 3GHz.  The VCO is assumed to be
> +			 * is assumed to be (M * f_ref) / P,
> +			 * where f_ref is 24MHz.
> +			 */
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p);
> +			if (tmp < 750 * MHZ ||
> +			    tmp > 3000 * MHZ)
> +				continue;
> +
> +			/* Final frequency after post-divider */
> +			do_div(tmp, _s);
> +
> +			delta = abs(fout - tmp);
> +			if (delta < min_delta) {
> +				best_p = _p;
> +				best_s = _s;
> +				best_m = _m;
> +				min_delta = delta;
> +				best_freq = tmp;
> +			}
> +		}
> +	}
> +
> +	if (best_freq) {
> +		*p = best_p;
> +		*m = best_m;
> +		*s = best_s;
> +	}
> +
> +	return best_freq / 5;
> +}
> +
>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  					  const struct phy_config *cfg)
>  {
> @@ -428,13 +523,13 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
>  		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
>  
> -	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> +	/* set individual PLL registers PHY_REG1 ... PHY_REG7 */
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> -		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
> +		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(1) + i * 4);
>  
> -	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
> +	/* High nibble of PHY_REG3 and low nibble of PHY_REG21 both contain 'S' */
>  	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> -	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> +	       cfg->pll_div_regs[2] >> 4), phy->regs + PHY_REG(21));
>  
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
> @@ -459,33 +554,97 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  	return phy->cur_cfg->pixclk;
>  }
>  
> -static long phy_clk_round_rate(struct clk_hw *hw,
> -			       unsigned long rate, unsigned long *parent_rate)
> +/* Helper function to lookup the available fractional-divider rate */
> +static const struct phy_config *fsl_samsung_hdmi_phy_lookup_rate(unsigned long rate)
>  {
>  	int i;
>  
> +	/* Search the lookup table */
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
> -			return phy_pll_cfg[i].pixclk;
> +			break;
>  
> -	return -EINVAL;
> +	return &phy_pll_cfg[i];
> +}
> +
> +static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned long rate,
> +				    u8 p, u16 m, u8 s)
> +{
> +	cal_phy->pixclk = rate;
> +	cal_phy->pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
> +	cal_phy->pll_div_regs[1] = m;
> +	cal_phy->pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
> +	/* pll_div_regs 3-6 are fixed and pre-defined already */
> +}
> +
> +static long phy_clk_round_rate(struct clk_hw *hw,
> +			       unsigned long rate, unsigned long *parent_rate)
> +{
> +	const struct phy_config *fract_div_phy;
> +	u32 int_div_clk;
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the clock is out of range return error instead of searching */
> +	if (rate > 297000000 || rate < 22250000)
> +		return -EINVAL;
> +
> +	/* Search the fractional divider lookup table */
> +	fract_div_phy = fsl_samsung_hdmi_phy_lookup_rate(rate);
> +
> +	/* If the rate is an exact match, return that value */
> +	if (rate == fract_div_phy->pixclk)
> +		return fract_div_phy->pixclk;
> +
> +	/* If the exact match isn't found, calculate the integer divider */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
> +
> +	/* If the int_div_clk rate is an exact match, return that value */
> +	if (int_div_clk == rate)
> +		return int_div_clk;
> +
> +	/* If neither rate is an exact match, use the value from the LUT */
> +	return fract_div_phy->pixclk;
>  }
>  
>  static int phy_clk_set_rate(struct clk_hw *hw,
>  			    unsigned long rate, unsigned long parent_rate)
>  {
>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
> -	int i;
> +	const struct phy_config *fract_div_phy;
> +	u32 int_div_clk;
> +	u16 m;
> +	u8 p, s;
>  
> -	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -		if (phy_pll_cfg[i].pixclk <= rate)
> -			break;
> +	/* Search the fractional divider lookup table */
> +	fract_div_phy = fsl_samsung_hdmi_phy_lookup_rate(rate);
>  
> -	if (i < 0)
> -		return -EINVAL;
> +	/* If the rate is an exact match, use that value */
> +	if (fract_div_phy->pixclk == rate)
> +		goto use_fract_div;
>  
> -	phy->cur_cfg = &phy_pll_cfg[i];
> +	/*
> +	 * If the rate from the fractional divder is not exact, check the integer divider,
> +	 * and use it if that value is an exact match.
> +	 */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
> +	if (int_div_clk == rate) {
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
> +				   int_div_clk);
> +
> +		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
> +		phy->cur_cfg  = &calculated_phy_pll_cfg;
> +		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> +	}
>  
> +	/*
> +	 * If neither the fractional divder nor the integer divder can find an exact value
> +	 * fall back to using the fractional divider
> +	 */
> +use_fract_div:
> +	phy->cur_cfg = fract_div_phy;
> +	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> +			   phy->cur_cfg->pixclk);
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
>  

