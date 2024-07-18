Return-Path: <linux-kernel+bounces-256264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58169934BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CF286618
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E912C470;
	Thu, 18 Jul 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANHfbg+S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C63A267
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298525; cv=none; b=OIViywWTy7x/uk5syxaX3swWOmqdMoSKT/AaTfDwn/MaVPPr8A3rrTI8EUYyK3qiB6sXZui7J7Aj4Nfhb0Jct5zD4QIGO8BCLoGkTcDcGnxCB04c+X6R+PieMbdKjwqmVBUDUYfITITDM9FjleoHyZL1L86X8dbQhgGGmqYPuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298525; c=relaxed/simple;
	bh=zVq1oQep4PfiPGVOflbRNNWoSHM9Z6gCk18HjH5A6pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5eQRu3V84UOcg9vgJzePOo6gW2XkHd6tGjHEbofU3bFtfMHudLewGBP7spz6RFG5ivO+3CC+8bxQYxSV5cs3jlg2TwmUsCFAagKRcamS0/r0rdjiwkT7vRmsWLVB60+r5JDDFlTv+d+jDPUOPM7vYadePe3KfH8GlDLcZ8jI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANHfbg+S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721298520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKUmSGCl+XqkJcVeT9f782AS0+B3hs0Tqt7OuTXmRSg=;
	b=ANHfbg+ScOv31mTdZaW0RO2uITeudnmotkMhYePh4eLpYX9rsR8fa6q58MPsXJTrpty9Ev
	J+0rGAHGQtesp7ePH8VnyamsBa6VyJLWq+p22cz8ZL5asy5GCR8Jz1TxfmM1ZDsCaDs4wE
	6QMbekx+fSkC8qTbTztfL0A16Z2vpQM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jrGEcfb5OtmAdDdfuCA-4Q-1; Thu, 18 Jul 2024 06:28:38 -0400
X-MC-Unique: jrGEcfb5OtmAdDdfuCA-4Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d92a4ae97eso552395b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721298516; x=1721903316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKUmSGCl+XqkJcVeT9f782AS0+B3hs0Tqt7OuTXmRSg=;
        b=kymycyAGMg+PPEs75HRV6sA3ZpAKxhep16iTcz6CSD+bV7CFmhyWVrp0DUmF4AUpYa
         PM9qwhzJ2bMTM4wnWWcpThOoXhVI+cx/tZ7g6RxMh06qFUXmdNtl77jBKS55u9uOwXM9
         mgUNqLJpjAvnq1fmJWhPfp+WM5FXC7Xc6BNer73vSPX2oG2tnXf5ghqP2G3zIqQB+tzT
         uN/93l5PPMzkz1hqKE75LHE9gDUrxbHa6PbdrTbIIRmdZGokJCxsNIclU3JMsZAbw0Il
         +rR/nGotJusodcR/HW1tDYltcVCqPnC1JKKJ1PpgVebgOjMG3J6bsIkTFoqVtX3o8evF
         hNJw==
X-Forwarded-Encrypted: i=1; AJvYcCXTM1hTge8EwKlkChL+c3YyM7pBKzNR/MFoqIBp2MNWo70Jzpdr+fEChPPGkqcDereHAo3XDvfjpQtxUdFLxmeUwc0bodvHErhEPKLG
X-Gm-Message-State: AOJu0YyuNuPowhs3go0g4azr6KysRC1DyTywoSyox8Fqm90BHxlMch8N
	1mIbSljrekzeuspRJa5UX8n9sjszJb6jRb+mBdf6E05R7gJEobFU0Oxm7HWyPbYI4o6UETg0QI7
	ERaLvgF1yEyFwKIEqCC5Mr7NzSCiRoU7QOwIG7NNE1ycum29Q4XczYwww/sVSgj7pJV0bSZV3uv
	PVOdLs8aHUqQQD1oV7vXabBGiFERhAQDrEvG6W
X-Received: by 2002:a05:6870:1584:b0:260:fbf6:3222 with SMTP id 586e51a60fabf-260fbf63773mr487748fac.10.1721298515987;
        Thu, 18 Jul 2024 03:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm7hCw80oesmICa4/aUZEE504nr4toU2z+fL7ihD/IKUzG8XYH6xm20TLaQEeAYuUfP7w/gbV9P8M4o2MJheY=
X-Received: by 2002:a05:6870:1584:b0:260:fbf6:3222 with SMTP id
 586e51a60fabf-260fbf63773mr487734fac.10.1721298515622; Thu, 18 Jul 2024
 03:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615093433.3659829-1-s-vadapalli@ti.com> <20240615093433.3659829-2-s-vadapalli@ti.com>
In-Reply-To: <20240615093433.3659829-2-s-vadapalli@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 18 Jul 2024 12:28:25 +0200
Message-ID: <CALE0LRuKN0fPAJX+StBn+_N0L1-MvEoVGng+8miXuEDB7uEDpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: cadence-torrent: Add PCIe multilink
 configuration for 100MHz refclk
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, kishon@kernel.org, sjakhade@cadence.com, 
	rogerq@kernel.org, thomas.richard@bootlin.com, robh@kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Many thanks for your patch. I'm not an expert on this but from a
general overview the patch looks good to me, for what it's worth I
picked the patches on my AM69-SK board and make it run USB and the
NVMe without problems so,

On Sat, Jun 15, 2024 at 11:35=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@t=
i.com> wrote:
>
> From: Swapnil Jakhade <sjakhade@cadence.com>
>
> Add register sequences to support PCIe multilink configuration for 100MHz
> reference clock. Maximum two PCIe links are supported.
>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 130 +++++++++++++++++++++-
>  1 file changed, 129 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cade=
nce/phy-cadence-torrent.c
> index 89e647bff99f..db60faeea988 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -197,6 +197,7 @@
>  #define RX_SDCAL1_INIT_TMR             0x004CU
>  #define RX_SDCAL1_ITER_TMR             0x004DU
>  #define RX_CDRLF_CNFG                  0x0080U
> +#define RX_CDRLF_CNFG2                 0x0081U
>  #define RX_CDRLF_CNFG3                 0x0082U
>  #define RX_SIGDET_HL_FILT_TMR          0x0090U
>  #define RX_REE_GCSM1_CTRL              0x0108U
> @@ -204,6 +205,7 @@
>  #define RX_REE_GCSM1_EQENM_PH2         0x010AU
>  #define RX_REE_GCSM2_CTRL              0x0110U
>  #define RX_REE_PERGCSM_CTRL            0x0118U
> +#define RX_REE_PEAK_UTHR               0x0142U
>  #define RX_REE_ATTEN_THR               0x0149U
>  #define RX_REE_TAP1_CLIP               0x0171U
>  #define RX_REE_TAP2TON_CLIP            0x0172U
> @@ -212,6 +214,7 @@
>  #define RX_DIAG_DFE_CTRL               0x01E0U
>  #define RX_DIAG_DFE_AMP_TUNE_2         0x01E2U
>  #define RX_DIAG_DFE_AMP_TUNE_3         0x01E3U
> +#define RX_DIAG_REE_DAC_CTRL           0x01E4U
>  #define RX_DIAG_NQST_CTRL              0x01E5U
>  #define RX_DIAG_SIGDET_TUNE            0x01E8U
>  #define RX_DIAG_PI_RATE                        0x01F4U
> @@ -3075,6 +3078,101 @@ static void cdns_torrent_phy_remove(struct platfo=
rm_device *pdev)
>         cdns_torrent_clk_cleanup(cdns_phy);
>  }
>
> +/* Multi link PCIe configuration */
> +static struct cdns_reg_pairs ml_pcie_link_cmn_regs[] =3D {
> +       {0x0002, PHY_PLL_CFG},
> +       {0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0}
> +};
> +
> +static struct cdns_reg_pairs ml_pcie_xcvr_diag_ln_regs[] =3D {
> +       {0x0100, XCVR_DIAG_HSCLK_SEL},
> +       {0x0001, XCVR_DIAG_HSCLK_DIV},
> +       {0x0812, XCVR_DIAG_PLLDRC_CTRL}
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_link_cmn_vals =3D {
> +       .reg_pairs =3D ml_pcie_link_cmn_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_link_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_xcvr_diag_ln_vals =3D {
> +       .reg_pairs =3D ml_pcie_xcvr_diag_ln_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_xcvr_diag_ln_regs),
> +};
> +
> +/* Multi link PCIe, 100 MHz Ref clk, no SSC */
> +static struct cdns_reg_pairs ml_pcie_100_no_ssc_cmn_regs[] =3D {
> +       {0x0003, CMN_PLL0_VCOCAL_TCTRL},
> +       {0x0003, CMN_PLL1_VCOCAL_TCTRL}
> +};
> +
> +static struct cdns_reg_pairs ml_pcie_100_no_ssc_rx_ln_regs[] =3D {
> +       {0x0019, RX_REE_TAP1_CLIP},
> +       {0x0019, RX_REE_TAP2TON_CLIP},
> +       {0x0008, RX_REE_PEAK_UTHR},
> +       {0x018E, RX_CDRLF_CNFG},
> +       {0x2E33, RX_CDRLF_CNFG2},
> +       {0x0001, RX_DIAG_ACYA},
> +       {0x0C21, RX_DIAG_DFE_AMP_TUNE_2},
> +       {0x0002, RX_DIAG_DFE_AMP_TUNE_3},
> +       {0x0005, RX_DIAG_REE_DAC_CTRL}
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_100_no_ssc_cmn_vals =3D {
> +       .reg_pairs =3D ml_pcie_100_no_ssc_cmn_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_100_no_ssc_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_100_no_ssc_rx_ln_vals =3D {
> +       .reg_pairs =3D ml_pcie_100_no_ssc_rx_ln_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_100_no_ssc_rx_ln_regs),
> +};
> +
> +/* Multi link PCIe, 100 MHz Ref clk, internal SSC */
> +static struct cdns_reg_pairs ml_pcie_100_int_ssc_cmn_regs[] =3D {
> +       {0x0004, CMN_PLL0_DSM_DIAG_M0},
> +       {0x0004, CMN_PLL1_DSM_DIAG_M0},
> +       {0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
> +       {0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
> +       {0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
> +       {0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
> +       {0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
> +       {0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
> +       {0x0064, CMN_PLL0_INTDIV_M0},
> +       {0x0050, CMN_PLL1_INTDIV_M0},
> +       {0x0002, CMN_PLL0_FRACDIVH_M0},
> +       {0x0002, CMN_PLL1_FRACDIVH_M0},
> +       {0x0044, CMN_PLL0_HIGH_THR_M0},
> +       {0x0036, CMN_PLL1_HIGH_THR_M0},
> +       {0x0002, CMN_PDIAG_PLL0_CTRL_M0},
> +       {0x0002, CMN_PDIAG_PLL1_CTRL_M0},
> +       {0x0001, CMN_PLL0_SS_CTRL1_M0},
> +       {0x0001, CMN_PLL1_SS_CTRL1_M0},
> +       {0x011B, CMN_PLL0_SS_CTRL2_M0},
> +       {0x011B, CMN_PLL1_SS_CTRL2_M0},
> +       {0x006E, CMN_PLL0_SS_CTRL3_M0},
> +       {0x0058, CMN_PLL1_SS_CTRL3_M0},
> +       {0x000E, CMN_PLL0_SS_CTRL4_M0},
> +       {0x0012, CMN_PLL1_SS_CTRL4_M0},
> +       {0x0C5E, CMN_PLL0_VCOCAL_REFTIM_START},
> +       {0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
> +       {0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
> +       {0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
> +       {0x0003, CMN_PLL0_VCOCAL_TCTRL},
> +       {0x0003, CMN_PLL1_VCOCAL_TCTRL},
> +       {0x00C7, CMN_PLL0_LOCK_REFCNT_START},
> +       {0x00C7, CMN_PLL1_LOCK_REFCNT_START},
> +       {0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
> +       {0x00C7, CMN_PLL1_LOCK_PLLCNT_START},
> +       {0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
> +       {0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_100_int_ssc_cmn_vals =3D {
> +       .reg_pairs =3D ml_pcie_100_int_ssc_cmn_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_100_int_ssc_cmn_regs),
> +};
> +
>  /* SGMII and QSGMII link configuration */
>  static struct cdns_reg_pairs sgmii_qsgmii_link_cmn_regs[] =3D {
>         {0x0002, PHY_PLL_CFG}
> @@ -4475,7 +4573,7 @@ static struct cdns_torrent_vals sl_sgmii_xcvr_diag_=
ln_vals =3D {
>         .num_regs =3D ARRAY_SIZE(sl_sgmii_xcvr_diag_ln_regs),
>  };
>
> -/* Multi link PCIe, 100 MHz Ref clk, internal SSC */
> +/* For PCIe (with some other protocol), 100 MHz Ref clk, internal SSC */
>  static struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] =3D {
>         {0x0004, CMN_PLL0_DSM_DIAG_M0},
>         {0x0004, CMN_PLL0_DSM_DIAG_M1},
> @@ -4614,6 +4712,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals=
_entries[] =3D {
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &usb_dp_link_cmn_val=
s},
>
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_NONE), NULL},
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_PCIE), &ml_pcie_link_cmn=
_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_SGMII), &pcie_sgmii_link=
_cmn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_lin=
k_cmn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_link_cmn=
_vals},
> @@ -4650,6 +4749,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_val=
s_entries[] =3D {
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &dp_usb_xcvr_diag_ln=
_vals},
>
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_NONE), NULL},
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_PCIE), &ml_pcie_xcvr_dia=
g_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_SGMII), &pcie_sgmii_xcvr=
_diag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_QSGMII), &pcie_sgmii_xcv=
r_diag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USB), &pcie_usb_xcvr_dia=
g_ln_vals},
> @@ -4700,6 +4800,10 @@ static struct cdns_torrent_vals_entry cmn_vals_ent=
ries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), &sl_pcie_100_int_ssc_cmn_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), &ml_pcie_100_int_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), &pcie_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
> @@ -4782,6 +4886,10 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_v=
als_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), NULL},
> @@ -4864,6 +4972,10 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_v=
als_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> @@ -4982,6 +5094,10 @@ static struct cdns_torrent_vals_entry ti_tx_ln_val=
s_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), NULL},
> @@ -5098,6 +5214,10 @@ static struct cdns_torrent_vals_entry ti_j7200_cmn=
_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), &sl_pcie_100_int_ssc_cmn_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), &ml_pcie_100_int_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), &pcie_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), &pcie_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), &pcie_100_int_ssc_cmn_vals},
> @@ -5180,6 +5300,10 @@ static struct cdns_torrent_vals_entry ti_j7200_tx_=
ln_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), NULL},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), NULL},
> @@ -5262,6 +5386,10 @@ static struct cdns_torrent_vals_entry ti_j7200_rx_=
ln_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_NONE,=
 INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_PCIE,=
 INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_SGMII=
, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> --
> 2.40.1
>
>


