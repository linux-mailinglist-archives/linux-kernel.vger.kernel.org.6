Return-Path: <linux-kernel+bounces-324206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B7974980
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A37F1C24DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048857CB6;
	Wed, 11 Sep 2024 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="cyx1Aq/Z"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912E43144
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031586; cv=none; b=YnGC5cXa0ZsN7m40PsiqjvUlD1V0I+CcLGJRp/zagzoGc2NuB1yMee4Y4FiBC4azn6JNyFC/nNi7SFRpAtiz+RqdxjuCG9yWMUhYYI6PBdJGLSqODiSg+RQ9YPe0jUEJ0swF9zUokQIc6k8FsZPuS5pAZdISdy2mQwGhsLX1Uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031586; c=relaxed/simple;
	bh=FHdMe+Nl9/lmmWPR+hF5VJPtmxkef1/bzcIIYGOQtaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM4BBIKJ/ROtxiKoc+16faFbVaKMk1W1298Hk8/P22Agp2fh3U3kv7FX3rdabG7IGm6dnH9yg4nrh3FoytqFZ3Lk9Gqa3+YL9rZwk+Rycwzlz7MmsUzh46pX1ObCI2cRT0UQaT7ugiXTe55qqFRLlA74WT4Wvf2jcz9Rjwkr9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=cyx1Aq/Z; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=cyx1Aq/Z;
	dkim-atps=neutral
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id CE13E92C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:13:03 +0900 (JST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7d50c3d0f1aso5313532a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726031583; x=1726636383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M72DOsqFVTnrcHoK2U9FFgneRCYV3HTdRRCjNnLI+Oo=;
        b=cyx1Aq/ZDgTXY3NAsImrLerrXtKkASwp9n6mzPgDnkQMCLji2HSUQqZMag/YHStsSu
         MDncNZkMfj8hGcs7YHLpsrr2WlywlYd4mNwqm5iQoGQPIXHUByq4mRWO1av8+AAFgfbH
         PBEYVj+s1yqH+2qQeRlnkd0uo7NSRZ8iyVY4Awi3PNyeOWjcVWKNFWKgwYR3UnOF47AB
         FkOlkYWyWB+iOth1jHwWx8H7xy+WiAJozTjuyFZlkrGOVdbUr4sTrO7DtEO6iD2e9yLc
         OboucUSWDfqRAHZJ6OTcRFTeBKpzH9ajBYCSRToQgNwbPInXrQ44m/MFOOZ3BNzIUekD
         tsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726031583; x=1726636383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M72DOsqFVTnrcHoK2U9FFgneRCYV3HTdRRCjNnLI+Oo=;
        b=o/EGUoa8A6vNcz88ycTPUTQQpVZE/6b/M8J3OZWyji9MSLfuaeFS3gd2JpH1Jdnbxg
         P/G9uJS+L3XhCEN+xUgcTwjvJ8slHviwp1uKINXyGpE9oFP7LHFGGrCy+lgkN5aO7UR1
         l7YAWMN7TQYTI0fjMkgyU9hm0JqlTQnET6h+At3ofNhNcbLxBqWOalEzxGLe0U7JoV2M
         Dg0vnJKdgJZQuVvNhh16ZIFli6BPILdzjXnGbvAjjldyPda7y0DO/bffPFvIjG+DL/fd
         W3FN6Qj75as2Tpo4+hH2PVDWmSj/54Bp3XYDzLHJY3gGqIAMsARSs2Hro3dtmTrT6SVz
         06Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWDuTmuvim5a3W9LkLJrHD7W0KM53cArVYI7OS+7O7TPjgMWu24ew7N2Vnqni0xSVgnn35k9/w19+fcJPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWhGL5albyoVz8z/VoBp5HD3wvWC+j60N3dfw+L6uNbSL5O7H
	Sjd1HnXXFFMOl8unsEcJAlXlNHMaE0EvYsxX4DaDAQvAvpQMrNbWFlsJm/dPtVcIf08HyDVD5/v
	eqGOVD7kkE7UgE6nPZ/vFI7YV4uzbdhniU+jg7Ff7xFpLpBu+bqss62pDN7bKoR8=
X-Received: by 2002:a05:6a21:393:b0:1cf:37bd:b548 with SMTP id adf61e73a8af0-1cf5e19a2b3mr3944120637.37.1726031582668;
        Tue, 10 Sep 2024 22:13:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLTqARgcsRts1O+Mv9NbupTsXE0tf7ZCPEC92Erkmnr9ct7YtJEGFnhPlItc/mapUBP/swmA==
X-Received: by 2002:a05:6a21:393:b0:1cf:37bd:b548 with SMTP id adf61e73a8af0-1cf5e19a2b3mr3944084637.37.1726031582212;
        Tue, 10 Sep 2024 22:13:02 -0700 (PDT)
Received: from localhost (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8256d0750sm6563261a12.75.2024.09.10.22.13.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:13:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:12:50 +0900
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
Subject: Re: [PATCH V7 1/5] phy: freescale: fsl-samsung-hdmi: Replace
 register defines with macro
Message-ID: <ZuEm0t7HgA5dxe0n@atmark-techno.com>
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911012838.944630-2-aford173@gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:28:07PM -0500:
> There are 47 registers defined as PHY_REG_xx were xx goes from 00 to
> 47.  Simplify this by replacing them all with a macro which is passed
> the register number to return the proper register offset.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 133 ++++++-------------
>  1 file changed, 43 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 9048cdc760c2..acea7008aefc 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -14,76 +14,29 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
> -#define PHY_REG_00		0x00
> -#define PHY_REG_01		0x04
> -#define PHY_REG_02		0x08
> -#define PHY_REG_08		0x20
> -#define PHY_REG_09		0x24
> -#define PHY_REG_10		0x28
> -#define PHY_REG_11		0x2c
> -
> -#define PHY_REG_12		0x30
> -#define  REG12_CK_DIV_MASK	GENMASK(5, 4)
> -
> -#define PHY_REG_13		0x34
> -#define  REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
> -
> -#define PHY_REG_14		0x38
> -#define  REG14_TOL_MASK		GENMASK(7, 4)
> -#define  REG14_RP_CODE_MASK	GENMASK(3, 1)
> -#define  REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
> -
> -#define PHY_REG_15		0x3c
> -#define PHY_REG_16		0x40
> -#define PHY_REG_17		0x44
> -#define PHY_REG_18		0x48
> -#define PHY_REG_19		0x4c
> -#define PHY_REG_20		0x50
> -
> -#define PHY_REG_21		0x54
> -#define  REG21_SEL_TX_CK_INV	BIT(7)
> -#define  REG21_PMS_S_MASK	GENMASK(3, 0)
> -
> -#define PHY_REG_22		0x58
> -#define PHY_REG_23		0x5c
> -#define PHY_REG_24		0x60
> -#define PHY_REG_25		0x64
> -#define PHY_REG_26		0x68
> -#define PHY_REG_27		0x6c
> -#define PHY_REG_28		0x70
> -#define PHY_REG_29		0x74
> -#define PHY_REG_30		0x78
> -#define PHY_REG_31		0x7c
> -#define PHY_REG_32		0x80
> +#define PHY_REG(reg)		(reg * 4)
>  
> +#define REG12_CK_DIV_MASK	GENMASK(5, 4)
> +
> +#define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
> +
> +#define REG14_TOL_MASK		GENMASK(7, 4)
> +#define REG14_RP_CODE_MASK	GENMASK(3, 1)
> +#define REG14_TG_CODE_HIGH_MASK	GENMASK(0, 0)
> +
> +#define REG21_SEL_TX_CK_INV	BIT(7)
> +#define REG21_PMS_S_MASK	GENMASK(3, 0)
>  /*
>   * REG33 does not match the ref manual. According to Sandor Yu from NXP,
>   * "There is a doc issue on the i.MX8MP latest RM"
>   * REG33 is being used per guidance from Sandor
>   */
> +#define REG33_MODE_SET_DONE	BIT(7)
> +#define REG33_FIX_DA		BIT(1)
>  
> -#define PHY_REG_33		0x84
> -#define  REG33_MODE_SET_DONE	BIT(7)
> -#define  REG33_FIX_DA		BIT(1)
> -
> -#define PHY_REG_34		0x88
> -#define  REG34_PHY_READY	BIT(7)
> -#define  REG34_PLL_LOCK		BIT(6)
> -#define  REG34_PHY_CLK_READY	BIT(5)
> -
> -#define PHY_REG_35		0x8c
> -#define PHY_REG_36		0x90
> -#define PHY_REG_37		0x94
> -#define PHY_REG_38		0x98
> -#define PHY_REG_39		0x9c
> -#define PHY_REG_40		0xa0
> -#define PHY_REG_41		0xa4
> -#define PHY_REG_42		0xa8
> -#define PHY_REG_43		0xac
> -#define PHY_REG_44		0xb0
> -#define PHY_REG_45		0xb4
> -#define PHY_REG_46		0xb8
> -#define PHY_REG_47		0xbc
> +#define REG34_PHY_READY	BIT(7)
> +#define REG34_PLL_LOCK		BIT(6)
> +#define REG34_PHY_CLK_READY	BIT(5)
>  
>  #define PHY_PLL_DIV_REGS_NUM 6
>  
> @@ -369,29 +322,29 @@ struct reg_settings {
>  };
>  
>  static const struct reg_settings common_phy_cfg[] = {
> -	{ PHY_REG_00, 0x00 }, { PHY_REG_01, 0xd1 },
> -	{ PHY_REG_08, 0x4f }, { PHY_REG_09, 0x30 },
> -	{ PHY_REG_10, 0x33 }, { PHY_REG_11, 0x65 },
> +	{ PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
> +	{ PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
> +	{ PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
>  	/* REG12 pixclk specific */
>  	/* REG13 pixclk specific */
>  	/* REG14 pixclk specific */
> -	{ PHY_REG_15, 0x80 }, { PHY_REG_16, 0x6c },
> -	{ PHY_REG_17, 0xf2 }, { PHY_REG_18, 0x67 },
> -	{ PHY_REG_19, 0x00 }, { PHY_REG_20, 0x10 },
> +	{ PHY_REG(15), 0x80 }, { PHY_REG(16), 0x6c },
> +	{ PHY_REG(17), 0xf2 }, { PHY_REG(18), 0x67 },
> +	{ PHY_REG(19), 0x00 }, { PHY_REG(20), 0x10 },
>  	/* REG21 pixclk specific */
> -	{ PHY_REG_22, 0x30 }, { PHY_REG_23, 0x32 },
> -	{ PHY_REG_24, 0x60 }, { PHY_REG_25, 0x8f },
> -	{ PHY_REG_26, 0x00 }, { PHY_REG_27, 0x00 },
> -	{ PHY_REG_28, 0x08 }, { PHY_REG_29, 0x00 },
> -	{ PHY_REG_30, 0x00 }, { PHY_REG_31, 0x00 },
> -	{ PHY_REG_32, 0x00 }, { PHY_REG_33, 0x80 },
> -	{ PHY_REG_34, 0x00 }, { PHY_REG_35, 0x00 },
> -	{ PHY_REG_36, 0x00 }, { PHY_REG_37, 0x00 },
> -	{ PHY_REG_38, 0x00 }, { PHY_REG_39, 0x00 },
> -	{ PHY_REG_40, 0x00 }, { PHY_REG_41, 0xe0 },
> -	{ PHY_REG_42, 0x83 }, { PHY_REG_43, 0x0f },
> -	{ PHY_REG_44, 0x3E }, { PHY_REG_45, 0xf8 },
> -	{ PHY_REG_46, 0x00 }, { PHY_REG_47, 0x00 }
> +	{ PHY_REG(22), 0x30 }, { PHY_REG(23), 0x32 },
> +	{ PHY_REG(24), 0x60 }, { PHY_REG(25), 0x8f },
> +	{ PHY_REG(26), 0x00 }, { PHY_REG(27), 0x00 },
> +	{ PHY_REG(28), 0x08 }, { PHY_REG(29), 0x00 },
> +	{ PHY_REG(30), 0x00 }, { PHY_REG(31), 0x00 },
> +	{ PHY_REG(32), 0x00 }, { PHY_REG(33), 0x80 },
> +	{ PHY_REG(34), 0x00 }, { PHY_REG(35), 0x00 },
> +	{ PHY_REG(36), 0x00 }, { PHY_REG(37), 0x00 },
> +	{ PHY_REG(38), 0x00 }, { PHY_REG(39), 0x00 },
> +	{ PHY_REG(40), 0x00 }, { PHY_REG(41), 0xe0 },
> +	{ PHY_REG(42), 0x83 }, { PHY_REG(43), 0x0f },
> +	{ PHY_REG(44), 0x3E }, { PHY_REG(45), 0xf8 },
> +	{ PHY_REG(46), 0x00 }, { PHY_REG(47), 0x00 }
>  };
>  
>  struct fsl_samsung_hdmi_phy {
> @@ -442,7 +395,7 @@ fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
>  	}
>  
>  	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
> -	       phy->regs + PHY_REG_21);
> +	       phy->regs + PHY_REG(21));
>  }
>  
>  static void
> @@ -469,7 +422,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  		break;
>  	}
>  
> -	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG_12);
> +	writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + PHY_REG(12));
>  
>  	/*
>  	 * Calculation for the frequency lock detector target code (fld_tg_code)
> @@ -489,11 +442,11 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  
>  	/* FLD_TOL and FLD_RP_CODE taken from downstream driver */
>  	writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
> -	       phy->regs + PHY_REG_13);
> +	       phy->regs + PHY_REG(13));
>  	writeb(FIELD_PREP(REG14_TOL_MASK, 2) |
>  	       FIELD_PREP(REG14_RP_CODE_MASK, 2) |
>  	       FIELD_PREP(REG14_TG_CODE_HIGH_MASK, fld_tg_code >> 8),
> -	       phy->regs + PHY_REG_14);
> +	       phy->regs + PHY_REG(14));
>  }
>  
>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
> @@ -503,7 +456,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	u8 val;
>  
>  	/* HDMI PHY init */
> -	writeb(REG33_FIX_DA, phy->regs + PHY_REG_33);
> +	writeb(REG33_FIX_DA, phy->regs + PHY_REG(33));
>  
>  	/* common PHY registers */
>  	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
> @@ -511,14 +464,14 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  
>  	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> -		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG_02 + i * 4);
> +		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
>  
>  	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
> -	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG_33);
> +	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
>  
> -	ret = readb_poll_timeout(phy->regs + PHY_REG_34, val,
> +	ret = readb_poll_timeout(phy->regs + PHY_REG(34), val,
>  				 val & REG34_PLL_LOCK, 50, 20000);
>  	if (ret)
>  		dev_err(phy->dev, "PLL failed to lock\n");

