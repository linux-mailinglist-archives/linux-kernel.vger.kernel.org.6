Return-Path: <linux-kernel+bounces-367124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9AA99FEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944561F26411
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6340D154C08;
	Wed, 16 Oct 2024 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABvKRoBm"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79721E3DE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046304; cv=none; b=R+0+fSW4DCVENS/fKYBCcK+yYbBhl2YH6wfjElOSIEi2tfRjRPpEoVGT3gKxKOoLz49aqLxolzGxUFD4QZKVkhQJ80Qi0C0DdoOTQz1Fpr2Uu2hFhtscO4nxWLz2hbhs7zv6b980nYKUPIb6566uO9l17v1bOJsABWniYNKKQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046304; c=relaxed/simple;
	bh=1m6PmD4KPmkmEwDgIdeDLEr6xw2JunGyKVUmFudDPRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pr1JYJ+sGu0euod/Dax4z62GlemhWG0NLx8SpzDwi/1btJu8oYReE8h+KIUynWFWVPnQa9zsSygMFKSKnShdRXq5Cpkknf5LZSan17T0LKVdWnpM5jDSonQc4d0GNBvChhrzvJD85fdpyKCJfJ9bKTApvOqshGjpbr0Jldsq5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABvKRoBm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4825520a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729046302; x=1729651102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq3rZWQImcp1E1g+Mau4dQ0TJT1mz8e4rqslITf9INM=;
        b=ABvKRoBm8koR2Z02VxMR0W10rIilWF02qzsCxLFHLkisERrehx0YikOqQO8vnrmd7Z
         jLSrrc4LxTygjllyQ/kO1BxQsODU2PI10byEtN3y6qWwwP24JgmivHPn323dhaSvAlxR
         Nx4m8eAlZx0FE+9+9ay9GUaUW/p5G6RgQ+NRnkkeNEj0RPSEo2C9QdL7nPuWLUmLWM/8
         riD51JA2qdzOgmKTETpvBNF3kp03AoZo/SkjqGSh76Vtb42MU0RNt0Hd0owGmVQJvVju
         18UL2sb2zX4sxrHi5xUy0OR4aUveiozJez/jB0SJ7WoaVVw/F/s4OBogK8eOP1eeNuop
         yPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729046302; x=1729651102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq3rZWQImcp1E1g+Mau4dQ0TJT1mz8e4rqslITf9INM=;
        b=qf9BkqzWkQCgK/xaycBQUAwfkT9vYAWfUeBrwDnrjizcxiVF9PjqljDuXVlaWQ2jrb
         Jc4lUOkTHw51STpcc5JIt0ID6vdqWts7U5NsxNvpyyIsDeUOF1FSPxMX/lMsqGT3Qe/X
         d8ZjClLQh9/OTHHQfRUScoMLQT2L3ErNdQMIh+VWvSsocKZs8ZqBqvHWgUyb9mZm85TU
         UdUO+FoXJt7kKs0+ulzbZGzwTlIRh9vKJPiwKBz803IVZ5Edlc94aRCRCAX/mbqWPH/6
         Ei2ji2yueWVCLJRWPlL9346mMqJILdRuf2UlzOQ9nHDnJSc16my7agEygi301Ksjsos6
         OtJg==
X-Forwarded-Encrypted: i=1; AJvYcCXt/NEHUlddhukQVtjeAPAJ6uLjVQSlUperk9w8q8H9Vh5Agd11PudHAu0d/JyI2mexgG1Z/LI9qkTC5Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeDnuUWekrOvpFp6VQDs67FLrvy5+E4byrcuhFlzwMAvQg0M4
	uRHoH+8lgA0dtugBOZGji1Q+gcCTlKGTjgStvm1sH3qXHr1xgbDaL7uMSdvNsGFcq7L0Cuntt9s
	LXWyQtZ7pRuq6xt21JqPG6tE5EHywrg==
X-Google-Smtp-Source: AGHT+IG1HCTrmxj+a8hD7lUcrplo1gbte0kaCDCkTsjkndYUW6qGlxT9ZOSh6sCCB3LqhrKZUCXnVrrYUaGJTH92lW8=
X-Received: by 2002:a05:6a21:6481:b0:1d6:e61d:1221 with SMTP id
 adf61e73a8af0-1d905ea1d76mr2820039637.5.1729046301982; Tue, 15 Oct 2024
 19:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914112816.520224-1-aford173@gmail.com> <20240914112816.520224-2-aford173@gmail.com>
 <CAHCN7xLk6TwQppL2baH9izZqMzOEUCc9zCdYu=DDS-tbwT0Prg@mail.gmail.com>
In-Reply-To: <CAHCN7xLk6TwQppL2baH9izZqMzOEUCc9zCdYu=DDS-tbwT0Prg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 15 Oct 2024 21:38:10 -0500
Message-ID: <CAHCN7xJokh-ziTCq=1b7Ow-kVW1fut+xmzXMnKaxObQ9rd893A@mail.gmail.com>
Subject: Re: [PATCH V8 1/5] phy: freescale: fsl-samsung-hdmi: Replace register
 defines with macro
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com, 
	festevam@gmail.com, frieder.schrempf@kontron.de, aford@beaconembedded.com, 
	Sandor.yu@nxp.com, neil.armstrong@linaro.org, 
	Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:39=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Sat, Sep 14, 2024 at 6:28=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > There are 47 registers defined as PHY_REG_xx were xx goes from 00 to
> > 47.  Simplify this by replacing them all with a macro which is passed
> > the register number to return the proper register offset.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> > Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> Gentile nudge on this series.  RC2 is out, and  I was hoping this
> might be merged to linux-next soon.

Vinod,

Is there anything you need from me to get this accepted?  I thought I
addressed all your concerns and we have multiple r-b and t-b tags.


adam
>
> thanks
>
> adam
>
> > ---
> > V7:  No change
> > V6:  No change
> > ---
> >  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 133 ++++++-------------
> >  1 file changed, 43 insertions(+), 90 deletions(-)
> >
> > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy=
/freescale/phy-fsl-samsung-hdmi.c
> > index 9048cdc760c2..acea7008aefc 100644
> > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > @@ -14,76 +14,29 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >
> > -#define PHY_REG_00             0x00
> > -#define PHY_REG_01             0x04
> > -#define PHY_REG_02             0x08
> > -#define PHY_REG_08             0x20
> > -#define PHY_REG_09             0x24
> > -#define PHY_REG_10             0x28
> > -#define PHY_REG_11             0x2c
> > -
> > -#define PHY_REG_12             0x30
> > -#define  REG12_CK_DIV_MASK     GENMASK(5, 4)
> > -
> > -#define PHY_REG_13             0x34
> > -#define  REG13_TG_CODE_LOW_MASK        GENMASK(7, 0)
> > -
> > -#define PHY_REG_14             0x38
> > -#define  REG14_TOL_MASK                GENMASK(7, 4)
> > -#define  REG14_RP_CODE_MASK    GENMASK(3, 1)
> > -#define  REG14_TG_CODE_HIGH_MASK       GENMASK(0, 0)
> > -
> > -#define PHY_REG_15             0x3c
> > -#define PHY_REG_16             0x40
> > -#define PHY_REG_17             0x44
> > -#define PHY_REG_18             0x48
> > -#define PHY_REG_19             0x4c
> > -#define PHY_REG_20             0x50
> > -
> > -#define PHY_REG_21             0x54
> > -#define  REG21_SEL_TX_CK_INV   BIT(7)
> > -#define  REG21_PMS_S_MASK      GENMASK(3, 0)
> > -
> > -#define PHY_REG_22             0x58
> > -#define PHY_REG_23             0x5c
> > -#define PHY_REG_24             0x60
> > -#define PHY_REG_25             0x64
> > -#define PHY_REG_26             0x68
> > -#define PHY_REG_27             0x6c
> > -#define PHY_REG_28             0x70
> > -#define PHY_REG_29             0x74
> > -#define PHY_REG_30             0x78
> > -#define PHY_REG_31             0x7c
> > -#define PHY_REG_32             0x80
> > +#define PHY_REG(reg)           (reg * 4)
> >
> > +#define REG12_CK_DIV_MASK      GENMASK(5, 4)
> > +
> > +#define REG13_TG_CODE_LOW_MASK GENMASK(7, 0)
> > +
> > +#define REG14_TOL_MASK         GENMASK(7, 4)
> > +#define REG14_RP_CODE_MASK     GENMASK(3, 1)
> > +#define REG14_TG_CODE_HIGH_MASK        GENMASK(0, 0)
> > +
> > +#define REG21_SEL_TX_CK_INV    BIT(7)
> > +#define REG21_PMS_S_MASK       GENMASK(3, 0)
> >  /*
> >   * REG33 does not match the ref manual. According to Sandor Yu from NX=
P,
> >   * "There is a doc issue on the i.MX8MP latest RM"
> >   * REG33 is being used per guidance from Sandor
> >   */
> > +#define REG33_MODE_SET_DONE    BIT(7)
> > +#define REG33_FIX_DA           BIT(1)
> >
> > -#define PHY_REG_33             0x84
> > -#define  REG33_MODE_SET_DONE   BIT(7)
> > -#define  REG33_FIX_DA          BIT(1)
> > -
> > -#define PHY_REG_34             0x88
> > -#define  REG34_PHY_READY       BIT(7)
> > -#define  REG34_PLL_LOCK                BIT(6)
> > -#define  REG34_PHY_CLK_READY   BIT(5)
> > -
> > -#define PHY_REG_35             0x8c
> > -#define PHY_REG_36             0x90
> > -#define PHY_REG_37             0x94
> > -#define PHY_REG_38             0x98
> > -#define PHY_REG_39             0x9c
> > -#define PHY_REG_40             0xa0
> > -#define PHY_REG_41             0xa4
> > -#define PHY_REG_42             0xa8
> > -#define PHY_REG_43             0xac
> > -#define PHY_REG_44             0xb0
> > -#define PHY_REG_45             0xb4
> > -#define PHY_REG_46             0xb8
> > -#define PHY_REG_47             0xbc
> > +#define REG34_PHY_READY        BIT(7)
> > +#define REG34_PLL_LOCK         BIT(6)
> > +#define REG34_PHY_CLK_READY    BIT(5)
> >
> >  #define PHY_PLL_DIV_REGS_NUM 6
> >
> > @@ -369,29 +322,29 @@ struct reg_settings {
> >  };
> >
> >  static const struct reg_settings common_phy_cfg[] =3D {
> > -       { PHY_REG_00, 0x00 }, { PHY_REG_01, 0xd1 },
> > -       { PHY_REG_08, 0x4f }, { PHY_REG_09, 0x30 },
> > -       { PHY_REG_10, 0x33 }, { PHY_REG_11, 0x65 },
> > +       { PHY_REG(0), 0x00 }, { PHY_REG(1), 0xd1 },
> > +       { PHY_REG(8), 0x4f }, { PHY_REG(9), 0x30 },
> > +       { PHY_REG(10), 0x33 }, { PHY_REG(11), 0x65 },
> >         /* REG12 pixclk specific */
> >         /* REG13 pixclk specific */
> >         /* REG14 pixclk specific */
> > -       { PHY_REG_15, 0x80 }, { PHY_REG_16, 0x6c },
> > -       { PHY_REG_17, 0xf2 }, { PHY_REG_18, 0x67 },
> > -       { PHY_REG_19, 0x00 }, { PHY_REG_20, 0x10 },
> > +       { PHY_REG(15), 0x80 }, { PHY_REG(16), 0x6c },
> > +       { PHY_REG(17), 0xf2 }, { PHY_REG(18), 0x67 },
> > +       { PHY_REG(19), 0x00 }, { PHY_REG(20), 0x10 },
> >         /* REG21 pixclk specific */
> > -       { PHY_REG_22, 0x30 }, { PHY_REG_23, 0x32 },
> > -       { PHY_REG_24, 0x60 }, { PHY_REG_25, 0x8f },
> > -       { PHY_REG_26, 0x00 }, { PHY_REG_27, 0x00 },
> > -       { PHY_REG_28, 0x08 }, { PHY_REG_29, 0x00 },
> > -       { PHY_REG_30, 0x00 }, { PHY_REG_31, 0x00 },
> > -       { PHY_REG_32, 0x00 }, { PHY_REG_33, 0x80 },
> > -       { PHY_REG_34, 0x00 }, { PHY_REG_35, 0x00 },
> > -       { PHY_REG_36, 0x00 }, { PHY_REG_37, 0x00 },
> > -       { PHY_REG_38, 0x00 }, { PHY_REG_39, 0x00 },
> > -       { PHY_REG_40, 0x00 }, { PHY_REG_41, 0xe0 },
> > -       { PHY_REG_42, 0x83 }, { PHY_REG_43, 0x0f },
> > -       { PHY_REG_44, 0x3E }, { PHY_REG_45, 0xf8 },
> > -       { PHY_REG_46, 0x00 }, { PHY_REG_47, 0x00 }
> > +       { PHY_REG(22), 0x30 }, { PHY_REG(23), 0x32 },
> > +       { PHY_REG(24), 0x60 }, { PHY_REG(25), 0x8f },
> > +       { PHY_REG(26), 0x00 }, { PHY_REG(27), 0x00 },
> > +       { PHY_REG(28), 0x08 }, { PHY_REG(29), 0x00 },
> > +       { PHY_REG(30), 0x00 }, { PHY_REG(31), 0x00 },
> > +       { PHY_REG(32), 0x00 }, { PHY_REG(33), 0x80 },
> > +       { PHY_REG(34), 0x00 }, { PHY_REG(35), 0x00 },
> > +       { PHY_REG(36), 0x00 }, { PHY_REG(37), 0x00 },
> > +       { PHY_REG(38), 0x00 }, { PHY_REG(39), 0x00 },
> > +       { PHY_REG(40), 0x00 }, { PHY_REG(41), 0xe0 },
> > +       { PHY_REG(42), 0x83 }, { PHY_REG(43), 0x0f },
> > +       { PHY_REG(44), 0x3E }, { PHY_REG(45), 0xf8 },
> > +       { PHY_REG(46), 0x00 }, { PHY_REG(47), 0x00 }
> >  };
> >
> >  struct fsl_samsung_hdmi_phy {
> > @@ -442,7 +395,7 @@ fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_sa=
msung_hdmi_phy *phy,
> >         }
> >
> >         writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
> > -              phy->regs + PHY_REG_21);
> > +              phy->regs + PHY_REG(21));
> >  }
> >
> >  static void
> > @@ -469,7 +422,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct =
fsl_samsung_hdmi_phy *phy,
> >                 break;
> >         }
> >
> > -       writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + P=
HY_REG_12);
> > +       writeb(FIELD_PREP(REG12_CK_DIV_MASK, ilog2(div)), phy->regs + P=
HY_REG(12));
> >
> >         /*
> >          * Calculation for the frequency lock detector target code (fld=
_tg_code)
> > @@ -489,11 +442,11 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struc=
t fsl_samsung_hdmi_phy *phy,
> >
> >         /* FLD_TOL and FLD_RP_CODE taken from downstream driver */
> >         writeb(FIELD_PREP(REG13_TG_CODE_LOW_MASK, fld_tg_code),
> > -              phy->regs + PHY_REG_13);
> > +              phy->regs + PHY_REG(13));
> >         writeb(FIELD_PREP(REG14_TOL_MASK, 2) |
> >                FIELD_PREP(REG14_RP_CODE_MASK, 2) |
> >                FIELD_PREP(REG14_TG_CODE_HIGH_MASK, fld_tg_code >> 8),
> > -              phy->regs + PHY_REG_14);
> > +              phy->regs + PHY_REG(14));
> >  }
> >
> >  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy =
*phy,
> > @@ -503,7 +456,7 @@ static int fsl_samsung_hdmi_phy_configure(struct fs=
l_samsung_hdmi_phy *phy,
> >         u8 val;
> >
> >         /* HDMI PHY init */
> > -       writeb(REG33_FIX_DA, phy->regs + PHY_REG_33);
> > +       writeb(REG33_FIX_DA, phy->regs + PHY_REG(33));
> >
> >         /* common PHY registers */
> >         for (i =3D 0; i < ARRAY_SIZE(common_phy_cfg); i++)
> > @@ -511,14 +464,14 @@ static int fsl_samsung_hdmi_phy_configure(struct =
fsl_samsung_hdmi_phy *phy,
> >
> >         /* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> >         for (i =3D 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> > -               writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG_02 + i=
 * 4);
> > +               writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i=
 * 4);
> >
> >         fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> >         fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
> >
> > -       writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG_=
33);
> > +       writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(=
33));
> >
> > -       ret =3D readb_poll_timeout(phy->regs + PHY_REG_34, val,
> > +       ret =3D readb_poll_timeout(phy->regs + PHY_REG(34), val,
> >                                  val & REG34_PLL_LOCK, 50, 20000);
> >         if (ret)
> >                 dev_err(phy->dev, "PLL failed to lock\n");
> > --
> > 2.43.0
> >

