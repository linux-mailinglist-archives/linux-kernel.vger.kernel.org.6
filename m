Return-Path: <linux-kernel+bounces-324238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C99749F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81181C24B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189E41AAC;
	Wed, 11 Sep 2024 05:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="b0vrdbuA"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AF2AE69
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726033662; cv=none; b=RMgHH3pAlqHc2diUi7t5CrV+Yecl8/IZyVYUYEXRwFbH+AwdGl0W5seOWCpYJN/jDD4/r+JIQO0oNrsx0GevFlOhJd7Zd3KxtLJOwreRAqnZRodIEofbOV0VyLCuonljJU8TNn5t247zAYHBcv0jfTPRTRI4Lp9hyi04cGIqIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726033662; c=relaxed/simple;
	bh=iu7A2xD6+XVNPium82UIVZ4evsMqRsud2KwNor2jEyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ/QC9BAe9bKrAFGH2FUm0d5jtD2LEfmybvo7bm8MMR7/vIedy4mg+d/CkboGtza0iLXgq/ZrkCGYzbkaUCTAAPNPsPj9IzNZqTAZkp2fdoCmzAacplIj6xPIOe5jK33VavANAXwGo53jCweTHqg4D2TKhjHEgQ0PM89Azbkf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=b0vrdbuA; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=b0vrdbuA;
	dkim-atps=neutral
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id F16558D5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:47:39 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-717912c8f27so7208796b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726033659; x=1726638459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ziNo+jooTu1yLXht0zW8ISeXgllh/gZGxSpk8QzQlRk=;
        b=b0vrdbuAa4E065vSPLcCH7tP3O70Lh5TimhO1ROtFTWRuTOqg3RZS1oKq+NQz6h7Bw
         WV7MEhru3oblOntcVxHERG4ErS62tXyDA3BFKL7ea9tDX5rPO0KPNklLfcAP4CagNzOM
         f5uF/t1cIUgzEfkwe/2bm/TBdV2PI9h4MLhH8YTiMln6a39FQ3FUkiiDRcMP8Cxqu3Py
         owgIXacRoAQP/dVFbvV9ykCIvlZWSmOEtm0l0CAfKQwD51fvCto8ft1i03CCEoatfPPE
         HV52NnkhSzbXMcInoMW+K+3SMkBU8a5/9/6KGovNmBc+QAVb2Hs9cWAi95+5VZ7Tch1M
         iZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726033659; x=1726638459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziNo+jooTu1yLXht0zW8ISeXgllh/gZGxSpk8QzQlRk=;
        b=ii3Go9ueVimI9ngjmt4KwGO2gcdwskYvX+nsTAF11AMf9joZLR8CQy8sNycKLzXGJM
         YhCjA8jol/+3nFKLGgIqkaSzE0RyvnsYxnhmAuv5n+59cbEmdVh/00YAcnRmGJu3/VBb
         yuMPA3cOA0wYIe9VOp+f110Q4d2yWqvIoloEGBs7thM1FV2jY/clsrxF95aGVVNJ/B7R
         uwd9fdp4mHhvlQGdYxwzseBLLP2sBMXWNBAYM4G6hx+VWAkvx1MrP1dVMtrhCAG10nqG
         wXTZvYmYDrTXEZcGTHWy2KV/aF2yhI2zh4LwEMccb+oFcnyAQ2i833+SX4I6+XpccwIi
         8Jrw==
X-Forwarded-Encrypted: i=1; AJvYcCUCrTKG7PejUbBi0cJLpBfmYJD8tNZO3TeiJFPVw9t8iq8Cdyvn7se+KKP+yGLDihIZcmxrXIkmzi76L3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrMZwivVRp/vdZC5zojAzRNhU75Rw18oNV7FSNMzvCrHObFI+
	3caf7YOA1Lp4YcBObyFMd+yZ3CZANlZowR5GmA6oWWfBCayzyxO0zFLvbmBbF7i9YnPNxaKcb9a
	0x9cVLbzG7kP0EYWTwBaXiblNfCCiSXrup/mYX2plO3/nQZFjVmlRqY9Xlllxkvo=
X-Received: by 2002:a05:6a00:c86:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-718e3f9de6cmr21488944b3a.6.1726033658610;
        Tue, 10 Sep 2024 22:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaJlkwR6zNDoYckSY7z8O/8d21hE3Cu0wd56iGZje0FCkeaHsrD2JlwFIpckDYC5/UT7Wkzw==
X-Received: by 2002:a05:6a00:c86:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-718e3f9de6cmr21488911b3a.6.1726033657952;
        Tue, 10 Sep 2024 22:47:37 -0700 (PDT)
Received: from localhost (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc130sm6514668a12.72.2024.09.10.22.47.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:47:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:47:25 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 5/5] phy: freescale: fsl-samsung-hdmi: Remove
 unnecessary LUT entries
Message-ID: <ZuEu7Qf3WkU8NnJA@atmark-techno.com>
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-6-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911012838.944630-6-aford173@gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:28:11PM -0500:
> The lookup table contains entries which use the integer divider
> instead of just the fractional divider. Since the set and round
> functions check both the integer divider values and the LUT values,
> it's no longer necessary to keep the integer divider values in the
> lookup table, as can be dynamically calcuated.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>


not that we'd have done anything different if there was something
incoherent, but FWIW I checked re-computing values for these regs match
and there was no problem.

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>


> ---
> V7: No Change
> V6: Fix typos in commit message
> V5: No Change
> V4:  New to series
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 83 +++-----------------
>  1 file changed, 13 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 67a28aac9c45..a5ad51425ee3 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -69,25 +69,16 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 23750000,
>  		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x86, 0x85, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 24000000,
> -		.pll_div_regs = { 0xd1, 0x50, 0xf0, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 24024000,
>  		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 25175000,
>  		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 25200000,
> -		.pll_div_regs = { 0xd1, 0x54, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 26750000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0x89, 0x88, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 27000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0xf0, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 27027000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
> @@ -105,18 +96,9 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 35000000,
>  		.pll_div_regs = { 0xd1, 0x58, 0xb8, 0x8b, 0x88, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 36000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 36036000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0xb2, 0xfd, 0x0c, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 40000000,
> -		.pll_div_regs = { 0xd1, 0x64, 0xb0, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> -		.pixclk = 43200000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0x90, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 43243200,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x92, 0xfd, 0x0c, 0x80, 0x40 },
> @@ -132,19 +114,13 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 50349650,
>  		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 50400000,
> -		.pll_div_regs = { 0xd1, 0x54, 0x70, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 53250000,
>  		.pll_div_regs = { 0xd1, 0x58, 0x72, 0x84, 0x03, 0x82, 0x41 },
>  	}, {
>  		.pixclk = 53500000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0x89, 0x88, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 54000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0x70, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 54054000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
> @@ -153,10 +129,7 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 59340659,
>  		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
> -	}, {
> -		.pixclk = 59400000,
> -		.pll_div_regs = { 0xd1, 0x63, 0x70, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 61500000,
>  		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
> @@ -168,10 +141,7 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 70000000,
>  		.pll_div_regs = { 0xd1, 0x58, 0x58, 0x8b, 0x88, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 72000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0x50, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 72072000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
> @@ -183,10 +153,7 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 78500000,
>  		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 80000000,
> -		.pll_div_regs = { 0xd1, 0x64, 0x50, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 82000000,
>  		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
> @@ -213,10 +180,7 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 100699300,
>  		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 100800000,
> -		.pll_div_regs = { 0xd1, 0x54, 0x30, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 102500000,
>  		.pll_div_regs = { 0xd1, 0x55, 0x32, 0x8c, 0x05, 0x90, 0x4b },
>  	}, {
> @@ -228,19 +192,13 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 107000000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0x89, 0x88, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 108000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0x30, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 108108000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 118000000,
>  		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 118800000,
> -		.pll_div_regs = { 0xd1, 0x63, 0x30, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 123000000,
>  		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
>  	}, {
> @@ -261,10 +219,7 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 140000000,
>  		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 144000000,
> -		.pll_div_regs = { 0xd1, 0x78, 0x30, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 148352000,
>  		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
>  	}, {
> @@ -288,9 +243,6 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 165000000,
>  		.pll_div_regs = { 0xd1, 0x45, 0x11, 0x84, 0x81, 0x90, 0x4b },
> -	}, {
> -		.pixclk = 180000000,
> -		.pll_div_regs = { 0xd1, 0x4b, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 185625000,
>  		.pll_div_regs = { 0xd1, 0x4e, 0x12, 0x9a, 0x95, 0x80, 0x40 },
> @@ -309,25 +261,16 @@ static const struct phy_config phy_pll_cfg[] = {
>  	}, {
>  		.pixclk = 213000000,
>  		.pll_div_regs = { 0xd1, 0x58, 0x12, 0x84, 0x03, 0x82, 0x41 },
> -	}, {
> -		.pixclk = 216000000,
> -		.pll_div_regs = { 0xd1, 0x5a, 0x10, 0x00, 0x00, 0x80, 0x00 },
>  	}, {
>  		.pixclk = 216216000,
>  		.pll_div_regs = { 0xd1, 0x5a, 0x12, 0xfd, 0x0c, 0x80, 0x40 },
> -	}, {
> -		.pixclk = 237600000,
> -		.pll_div_regs = { 0xd1, 0x63, 0x10, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 254000000,
>  		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
>  	}, {
>  		.pixclk = 277500000,
>  		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
> -	}, {
> -		.pixclk = 288000000,
> -		.pll_div_regs = { 0xd1, 0x78, 0x10, 0x00, 0x00, 0x80, 0x00 },
> -	}, {
> +	},  {
>  		.pixclk = 297000000,
>  		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
>  	},

