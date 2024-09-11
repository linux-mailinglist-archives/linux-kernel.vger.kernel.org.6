Return-Path: <linux-kernel+bounces-324230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05D9749B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806731F26D34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035454277;
	Wed, 11 Sep 2024 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="WqKnPAnk"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878F1F951
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032208; cv=none; b=UgtjjbzGXObGLFsj0e8wXI/5xFAvF2phHQ0sGGmqEC79m7BmcYqFt6ht5wGSPz6tVtn6aepUZ1JskPvGiG6R0FUjEmjbT0DeNHMaLvRzRvQYqB1cZc14BDD5syn+VUKyK1htPYsSEcrrnG6z+rWiZOv8ileGiI6rnpg2Zeg+Uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032208; c=relaxed/simple;
	bh=eflwuOZhvkiGaNR7e8aONxG1bPI2oO3GTM2HcdkH7j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDW3uYi7p3VSteQzIL4pSJwFSC9qYVzotff4brjUxDpNXNAAoASV+T2J/x6SaT5WEySo5Z/C8W+0zj8c2kK83PuBY94lTHG5OQ50Xh/8pl0s8Bdi3b5NB3vXWdLn9/NslQqmQebWuqWWsms+ewG35BG/jFhQwYFGf2eDzsENbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=WqKnPAnk; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=WqKnPAnk;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E5E8A92D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:23:25 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d87b7618d3so1839225a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726032205; x=1726637005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4rKrvLsgg5fFp1W35lEovNaFCVsL+TLW+LTBGqI9Hx0=;
        b=WqKnPAnkDJUJyPp17EB4j+4ZEr5zuYAW8nDjlBX8l4Lv7+BeBufwJ9xUFbN/coBLg2
         JeKybIkEbB1PAKCr5YVzjz03RKE8SxrhY3OW+Hh/cfXf2sby3k9h+gxU8EeToyGQqhkM
         QuzulxQEcM8mEP8mX8xTPba2h4broZ7lroj6TF0YfX87c6o1xpk7ZJjufxVo0mZaSF8r
         i8EK/Tx/U+N1rXUDJOfMythNWAu9OzSUcvWmzdJ9mpWSczPZaufAFZnAXr16dIPMI0Po
         R9o/FlRGviTvrvuYL6vdmdreUyUa/Q43RegjqH7//qOJoNQ0p979aVSqwQ8DBWxxF2P8
         NGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726032205; x=1726637005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rKrvLsgg5fFp1W35lEovNaFCVsL+TLW+LTBGqI9Hx0=;
        b=IAhs6ndrlD0dT1PuNVB7DR1XcHFwa9XUkGZ8xPnTelm5YTdtdpCQUNBhLGoiA0wqVP
         DEbsaTK0wJhhKBL29YD1PMvCNpvMcnqwLm9OZlRIk3c+h0woyU4ZEO2lulfoTHOzmm14
         WmlGYXYr+5TVM13CH2PY6Jp56XqTpWjrCBDwj3UCk7t1zoyWAqQlhD/nUcFpBO7mMBNW
         JStrMhnUCYixBZStZxowWueXyw8QW7aW216GUsP2JwnWST+tjd9++wKOcClfwTc2CVf7
         PwK6R95oQOpdS++GNyL7gFGcGJ7V8HlsVKiBYybYLwadHHozrtNPKU56VVLXf7xpjSLZ
         Nu6g==
X-Forwarded-Encrypted: i=1; AJvYcCUQOHmoH8wOyyuWgZ8Av5wGfKRlSjitgZq+QLKEiEIWJOflziaoXrJ2kPyY+O0dD/fNQK3VdoeuJjURi5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY/cXtGb0sm4BhXWQJ9pEQ0pmszEJMRGuoZo2L/lkodiwQApW
	x/NE3N+pkRjbEa7VMYMhOAcGduZYZmGtR5xTS7DI74AxnjTY0L/qwCiYJVr0oTNhj0Jn7xGCB9T
	mCF1g7zrX0NzDn02kOwNq+oEmgzUCBnKpDX4CBhUAF44lpE/rPIepRiyx0ZRlmWo=
X-Received: by 2002:a17:90a:983:b0:2d8:8fe9:b015 with SMTP id 98e67ed59e1d1-2db83083512mr2250652a91.39.1726032204918;
        Tue, 10 Sep 2024 22:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqQIj3JaREdQYsYKYcmjKKHJ7g+pWzJk50vdT2Uw6ikKf2ECT/imB6goWf1DaHFPrCOuXZ1A==
X-Received: by 2002:a17:90a:983:b0:2d8:8fe9:b015 with SMTP id 98e67ed59e1d1-2db83083512mr2250625a91.39.1726032204512;
        Tue, 10 Sep 2024 22:23:24 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0213a7sm9600929a91.18.2024.09.10.22.23.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:23:24 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:23:12 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Marco Felsch <m.felsch@pengutronix.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/5] phy: freescale: fsl-samsung-hdmi: Simplify
 REG21_PMS_S_MASK lookup
Message-ID: <ZuEpQLcDQ8pgMTUB@atmark-techno.com>
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-3-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911012838.944630-3-aford173@gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:28:08PM -0500:
> The value of 'S' is writen to two places, PHY_REG3[7:4] and
> PHY_REG21[3:0].  There is a lookup table which contains
> the value of PHY_REG3.  Rather than using a switch statement
> based on the pixel clock to search for the value of 'S' again,
> just shift the contents of PHY_REG3[7:4] >> 4 and place the value
> in PHY_REG21[3:0].  Doing this can eliminate an entire function.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 39 ++------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index acea7008aefc..4f6874226f9a 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -364,40 +364,6 @@ to_fsl_samsung_hdmi_phy(struct clk_hw *hw)
>  	return container_of(hw, struct fsl_samsung_hdmi_phy, hw);
>  }
>  
> -static void
> -fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
> -				      const struct phy_config *cfg)
> -{
> -	u8 div = 0x1;
> -
> -	switch (cfg->pixclk) {
> -	case  22250000 ...  33750000:
> -		div = 0xf;
> -		break;
> -	case  35000000 ...  40000000:
> -		div = 0xb;
> -		break;
> -	case  43200000 ...  47500000:
> -		div = 0x9;
> -		break;
> -	case  50349650 ...  63500000:
> -		div = 0x7;
> -		break;
> -	case  67500000 ...  90000000:
> -		div = 0x5;
> -		break;
> -	case  94000000 ... 148500000:
> -		div = 0x3;
> -		break;
> -	case 154000000 ... 297000000:
> -		div = 0x1;
> -		break;
> -	}
> -
> -	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
> -	       phy->regs + PHY_REG(21));
> -}
> -
>  static void
>  fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  					    const struct phy_config *cfg)
> @@ -466,7 +432,10 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
>  		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
>  
> -	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> +	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
> +	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> +	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> +
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
>  	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));

