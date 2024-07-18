Return-Path: <linux-kernel+bounces-256263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F8934BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6D31C219BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495A12CD96;
	Thu, 18 Jul 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rlr4NHKT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A013A267
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721298478; cv=none; b=fR49ybNlsTDv8oXwXuC86qmtcIhK4BVIj15hJCNu6XYyzxlq0qIzfWSx0ju4l2O4I21ZR0326uU8LZKv4YbHbAdw76c4rBaNZNq3PnpmHlb3HxHmqGcNih+WMjTR/y/vD0k2nc37qz9nFm3t2JAi2T7Rh4Tm9PN9/i/PjnNuxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721298478; c=relaxed/simple;
	bh=M5WR01H00uzc9NacmkO2tEZbAPWjim3vOh/ANSBG7JQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RC9hvzSyfUA4/3UxRROutyRkKiMag/YmbRVPLbCi4wHSSNIr1EumRjGIkRYiotVwkAXg9exwetAooyKbXwc5LR+NlJkhfnysirnFyNRosYbySwoAnd83GmX+iuLc0m9aU09oSjrJ0RINZBCiWwjbNKqH3isBNfDCAsmjyMZk4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rlr4NHKT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721298475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KfEa36NvPbvV8GIEH7iCRs2v0dPrCvyvqueFp23lQ4=;
	b=Rlr4NHKTaWxF3e8xGW/neUaeRaCL0x6tC8vXeRNIrJtW8uoik2C3org0N/ydnEZk8l5FNS
	4IlXXSPSlPi3fA0r/lb0nE5UrftAJq7CIaYWGabo/mMn9Jd43tFvwTO6RKcA+yyC6+l/mO
	6v6iZaLXmNMD1N7dSruBAjQscqMOBzk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-LelNwpZsOQCawCOOF5Sj2Q-1; Thu, 18 Jul 2024 06:27:51 -0400
X-MC-Unique: LelNwpZsOQCawCOOF5Sj2Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-260ffc95201so27205fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721298471; x=1721903271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KfEa36NvPbvV8GIEH7iCRs2v0dPrCvyvqueFp23lQ4=;
        b=U/EzlCqe7J6z8cAfnbmJVX8c6EiMk86A6zMJmYx7CTq99X/gLzlDs6cpVZLmJ8duyg
         YCiDA658AfJezQ0+cUCkPO7HhGqe6+aaJylcOISw0fZ/XzGN23ARnjM1zR1dmGT1f0c9
         fVS6bg/M4REHegWLkuPyTPjW6P0V2PjOJTrDhEGNV8zPT0AVNlmrM98f5cxP9x3F3LWI
         y629S2GI/IZexA9w4iRfFDMVQAO/Ra3gjnbTnxuYWSPMv1Yx6I6l8Kyrveu7AhyUBTJb
         GcDGpMR0ZCrwj9FArZxWX4herKzz3kNyeLDa5W3663akwy2dLz5Q3ijdrvvxriFXqFb/
         JNKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZEA4VsdcoDaEBuz0pOFMz35PzvZE1v9u+F2WJsE66EoffYiSodhzor73soAQXKHciPr4Ee5/5S54iTbMPyxLj9Wo9OobQGEPyRwQy
X-Gm-Message-State: AOJu0Ywje/HLFf4n3APs6HLFG20lknAqRBQVBZl5d8ykVWJGNNrzr3d3
	3US6cFxd2JCF45hMNOgS0x93g0KPRE8xnq77b1Of4z1oBXLf5KALLN+Fksg3BvdwW1OjV31T13b
	OZZOcvRGUn9t4Q3V8SN1F7wK7kW0+hnfFJwIuWGKfow8IhR+N7aR1srV1PzJlBKlQ8TlT+Qiiin
	5Fby8anfkDWqDvOrj6zImV5x/0dFSqq0jF2o4C
X-Received: by 2002:a05:6870:a2ca:b0:25e:b6dc:46a with SMTP id 586e51a60fabf-260d9146f18mr3556602fac.11.1721298470614;
        Thu, 18 Jul 2024 03:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyRcCIUg7pzFZ4nVsFehGKDxGFzZA/hIY5wN16nUl8Ao2MFi1zJ0YtU3z6nRD8KarJMKCLQib4azi0eDTsyCE=
X-Received: by 2002:a05:6870:a2ca:b0:25e:b6dc:46a with SMTP id
 586e51a60fabf-260d9146f18mr3556585fac.11.1721298470072; Thu, 18 Jul 2024
 03:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615093433.3659829-1-s-vadapalli@ti.com> <20240615093433.3659829-3-s-vadapalli@ti.com>
In-Reply-To: <20240615093433.3659829-3-s-vadapalli@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 18 Jul 2024 12:27:39 +0200
Message-ID: <CALE0LRtDUbCXRQ=0uEKz1TfAZxhg42KLXnAPDoPkQ25Agk1P9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: cadence-torrent: Add PCIe multilink + USB with
 same SSC register config for 100 MHz refclk
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
> Add register sequences for PCIe multilink + USB configuration for 100MHz
> reference clock. The same SSC is used for both PCIe and USB.
>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

> ---
>  drivers/phy/cadence/phy-cadence-torrent.c | 146 +++++++++++++++++++---
>  1 file changed, 128 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cade=
nce/phy-cadence-torrent.c
> index db60faeea988..d9b700cc4dd1 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -206,6 +206,7 @@
>  #define RX_REE_GCSM2_CTRL              0x0110U
>  #define RX_REE_PERGCSM_CTRL            0x0118U
>  #define RX_REE_PEAK_UTHR               0x0142U
> +#define RX_REE_PEAK_LTHR               0x0143U
>  #define RX_REE_ATTEN_THR               0x0149U
>  #define RX_REE_TAP1_CLIP               0x0171U
>  #define RX_REE_TAP2TON_CLIP            0x0172U
> @@ -298,6 +299,7 @@ enum cdns_torrent_phy_type {
>         TYPE_QSGMII,
>         TYPE_USB,
>         TYPE_USXGMII,
> +       TYPE_PCIE_ML,
>  };
>
>  enum cdns_torrent_ref_clk {
> @@ -695,6 +697,7 @@ static const char *cdns_torrent_get_phy_type(enum cdn=
s_torrent_phy_type phy_type
>         case TYPE_DP:
>                 return "DisplayPort";
>         case TYPE_PCIE:
> +       case TYPE_PCIE_ML:
>                 return "PCIe";
>         case TYPE_SGMII:
>                 return "SGMII";
> @@ -2472,24 +2475,36 @@ int cdns_torrent_phy_configure_multilink(struct c=
dns_torrent_phy *cdns_phy)
>         struct cdns_torrent_vals *phy_pma_cmn_vals;
>         struct cdns_torrent_vals *pcs_cmn_vals;
>         int i, j, node, mlane, num_lanes, ret;
> +       u32 num_links =3D cdns_phy->nsubnodes;
>         struct cdns_reg_pairs *reg_pairs;
>         enum cdns_torrent_ssc_mode ssc;
> +       u32 num_regs, pcie_links =3D 0;
>         struct regmap *regmap;
> -       u32 num_regs;
>
> -       /* Maximum 2 links (subnodes) are supported */
> -       if (cdns_phy->nsubnodes !=3D 2)
> -               return -EINVAL;
> -
> -       phy_t1 =3D cdns_phy->phys[0].phy_type;
> -       phy_t2 =3D cdns_phy->phys[1].phy_type;
> +       if (num_links =3D=3D 2) {
> +               phy_t1 =3D cdns_phy->phys[0].phy_type;
> +               phy_t2 =3D cdns_phy->phys[1].phy_type;
> +       } else {
> +               phy_t1 =3D TYPE_PCIE_ML;
> +               phy_t2 =3D TYPE_NONE;
> +               for (node =3D 0; node < num_links; node++) {
> +                       if (cdns_phy->phys[node].phy_type =3D=3D TYPE_PCI=
E) {
> +                               pcie_links++;
> +                               continue;
> +                       }
> +                       phy_t2 =3D cdns_phy->phys[node].phy_type;
> +               }
> +               if (pcie_links <=3D 1 || phy_t2 !=3D TYPE_USB)
> +                       return -EINVAL;
> +       }
>
>         /**
>          * First configure the PHY for first link with phy_t1. Get the ar=
ray
>          * values as [phy_t1][phy_t2][ssc].
>          */
> -       for (node =3D 0; node < cdns_phy->nsubnodes; node++) {
> -               if (node =3D=3D 1) {
> +       for (node =3D 0; node < num_links; node++) {
> +               if ((num_links =3D=3D 2 && node =3D=3D 1) ||
> +                   (num_links > 2 && node =3D=3D pcie_links)) {
>                         /**
>                          * If first link with phy_t1 is configured, then
>                          * configure the PHY for second link with phy_t2.
> @@ -3016,7 +3031,7 @@ static int cdns_torrent_phy_probe(struct platform_d=
evice *pdev)
>         }
>         cdns_phy->nsubnodes =3D node;
>
> -       if (total_num_lanes > MAX_NUM_LANES) {
> +       if (total_num_lanes > MAX_NUM_LANES || cdns_phy->nsubnodes > MAX_=
NUM_LANES) {
>                 dev_err(dev, "Invalid lane configuration\n");
>                 ret =3D -EINVAL;
>                 goto put_lnk_rst;
> @@ -3035,15 +3050,14 @@ static int cdns_torrent_phy_probe(struct platform=
_device *pdev)
>         }
>
>         if (cdns_phy->nsubnodes > 1)
> -               dev_dbg(dev, "Multi-link: %s (%d lanes) & %s (%d lanes)",
> -                       cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_t=
ype),
> -                       cdns_phy->phys[0].num_lanes,
> -                       cdns_torrent_get_phy_type(cdns_phy->phys[1].phy_t=
ype),
> -                       cdns_phy->phys[1].num_lanes);
> +               dev_dbg(dev, "Multi-link configuration:\n");
>         else
> -               dev_dbg(dev, "Single link: %s (%d lanes)",
> -                       cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_t=
ype),
> -                       cdns_phy->phys[0].num_lanes);
> +               dev_dbg(dev, "Single-link configuration:\n");
> +
> +       for (i =3D 0; i < cdns_phy->nsubnodes; i++)
> +               dev_dbg(dev, "%s (%d lanes)",
> +                       cdns_torrent_get_phy_type(cdns_phy->phys[i].phy_t=
ype),
> +                       cdns_phy->phys[i].num_lanes);
>
>         return 0;
>
> @@ -3078,6 +3092,37 @@ static void cdns_torrent_phy_remove(struct platfor=
m_device *pdev)
>         cdns_torrent_clk_cleanup(cdns_phy);
>  }
>
> +/* Multilink PCIe and USB Same SSC link configuration */
> +static struct cdns_reg_pairs ml_pcie_usb_link_cmn_regs[] =3D {
> +       {0x0002, PHY_PLL_CFG},
> +       {0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0}
> +};
> +
> +static struct cdns_reg_pairs ml_pcie_usb_xcvr_diag_ln_regs[] =3D {
> +       {0x0100, XCVR_DIAG_HSCLK_SEL},
> +       {0x0013, XCVR_DIAG_HSCLK_DIV},
> +       {0x0812, XCVR_DIAG_PLLDRC_CTRL}
> +};
> +
> +static struct cdns_reg_pairs usb_ml_pcie_xcvr_diag_ln_regs[] =3D {
> +       {0x0041, XCVR_DIAG_PLLDRC_CTRL},
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_usb_link_cmn_vals =3D {
> +       .reg_pairs =3D ml_pcie_usb_link_cmn_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_usb_link_cmn_regs),
> +};
> +
> +static struct cdns_torrent_vals ml_pcie_usb_xcvr_diag_ln_vals =3D {
> +       .reg_pairs =3D ml_pcie_usb_xcvr_diag_ln_regs,
> +       .num_regs =3D ARRAY_SIZE(ml_pcie_usb_xcvr_diag_ln_regs),
> +};
> +
> +static struct cdns_torrent_vals usb_ml_pcie_xcvr_diag_ln_vals =3D {
> +       .reg_pairs =3D usb_ml_pcie_xcvr_diag_ln_regs,
> +       .num_regs =3D ARRAY_SIZE(usb_ml_pcie_xcvr_diag_ln_regs),
> +};
> +
>  /* Multi link PCIe configuration */
>  static struct cdns_reg_pairs ml_pcie_link_cmn_regs[] =3D {
>         {0x0002, PHY_PLL_CFG},
> @@ -4084,6 +4129,8 @@ static struct cdns_reg_pairs usb_100_no_ssc_rx_ln_r=
egs[] =3D {
>         {0x0C02, RX_REE_ATTEN_THR},
>         {0x0330, RX_REE_SMGM_CTRL1},
>         {0x0300, RX_REE_SMGM_CTRL2},
> +       {0x0000, RX_REE_PEAK_UTHR},
> +       {0x01F5, RX_REE_PEAK_LTHR},
>         {0x0019, RX_REE_TAP1_CLIP},
>         {0x0019, RX_REE_TAP2TON_CLIP},
>         {0x1004, RX_DIAG_SIGDET_TUNE},
> @@ -4719,6 +4766,8 @@ static struct cdns_torrent_vals_entry link_cmn_vals=
_entries[] =3D {
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_link_cmn_v=
als},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_=
link_cmn_vals},
>
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE_ML, TYPE_USB), &ml_pcie_usb_li=
nk_cmn_vals},
> +
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_link_c=
mn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &pcie_sgmii_link=
_cmn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_QSGMII), &sgmii_qsgmii_=
link_cmn_vals},
> @@ -4733,6 +4782,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals=
_entries[] =3D {
>
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_link_cmn_v=
als},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &pcie_usb_link_cmn=
_vals},
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE_ML), &ml_pcie_usb_li=
nk_cmn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_sgmii_link_c=
mn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_sgmii_link_=
cmn_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_link_cmn_val=
s},
> @@ -4756,6 +4806,8 @@ static struct cdns_torrent_vals_entry xcvr_diag_val=
s_entries[] =3D {
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_DP), &pcie_dp_xcvr_diag_=
ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE, TYPE_USXGMII), &pcie_usxgmii_=
xcvr_diag_ln_vals},
>
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_PCIE_ML, TYPE_USB), &ml_pcie_usb_xc=
vr_diag_ln_vals},
> +
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_NONE), &sl_sgmii_xcvr_d=
iag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_PCIE), &sgmii_pcie_xcvr=
_diag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_SGMII, TYPE_QSGMII), &sgmii_qsgmii_=
xcvr_diag_ln_vals},
> @@ -4770,6 +4822,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_val=
s_entries[] =3D {
>
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &sl_usb_xcvr_diag_=
ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_pcie_xcvr_dia=
g_ln_vals},
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE_ML), &usb_ml_pcie_xc=
vr_diag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_sgmii_xcvr_d=
iag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_sgmii_xcvr_=
diag_ln_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_dp_xcvr_diag_ln=
_vals},
> @@ -4783,6 +4836,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_val=
s_entries[] =3D {
>  static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &usb_phy_pcs_cmn_v=
als},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_phy_pcs_cmn_v=
als},
> +       {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE_ML), &usb_phy_pcs_cm=
n_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_phy_pcs_cmn_=
vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_QSGMII), &usb_phy_pcs_cmn=
_vals},
>         {CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_phy_pcs_cmn_val=
s},
> @@ -4818,6 +4872,10 @@ static struct cdns_torrent_vals_entry cmn_vals_ent=
ries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), &ml_pcie_100_int_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &sl_sgmii_100_no_ssc_cmn_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
> @@ -4850,6 +4908,10 @@ static struct cdns_torrent_vals_entry cmn_vals_ent=
ries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_int_ssc_cmn_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
> @@ -4904,6 +4966,10 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_v=
als_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &sgmii_100_no_ssc_tx_ln_vals},
> @@ -4936,6 +5002,10 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_v=
als_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> @@ -4990,6 +5060,10 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_v=
als_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), &pcie_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), &ml_pcie_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
> @@ -5022,6 +5096,10 @@ static struct cdns_torrent_vals_entry cdns_rx_ln_v=
als_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> @@ -5112,6 +5190,10 @@ static struct cdns_torrent_vals_entry ti_tx_ln_val=
s_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
> @@ -5144,6 +5226,10 @@ static struct cdns_torrent_vals_entry ti_tx_ln_val=
s_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> @@ -5232,6 +5318,10 @@ static struct cdns_torrent_vals_entry ti_j7200_cmn=
_vals_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), &ml_pcie_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), &ml_pcie_100_int_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &sl_sgmii_100_no_ssc_cmn_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &sgmii_100_no_ssc_cmn_vals},
> @@ -5264,6 +5354,10 @@ static struct cdns_torrent_vals_entry ti_j7200_cmn=
_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_int_ssc_cmn_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_cmn_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &sl_usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &sl_usb_100_no_ssc_cmn_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &sl_usb_100_int_ssc_cmn_vals},
> @@ -5318,6 +5412,10 @@ static struct cdns_torrent_vals_entry ti_j7200_tx_=
ln_vals_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), NULL},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), NULL},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), NULL},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &ti_sgmii_100_no_ssc_tx_ln_vals},
> @@ -5350,6 +5448,10 @@ static struct cdns_torrent_vals_entry ti_j7200_tx_=
ln_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &usb_100_no_ssc_tx_ln_vals},
> @@ -5404,6 +5506,10 @@ static struct cdns_torrent_vals_entry ti_j7200_rx_=
ln_vals_entries[] =3D {
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE, TYPE_DP, N=
O_SSC), &pcie_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, NO_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, EXTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_PCIE_ML, TYPE_US=
B, INTERNAL_SSC), &pcie_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_NONE=
, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
>
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_SGMII, TYPE_PCIE=
, NO_SSC), &sgmii_100_no_ssc_rx_ln_vals},
> @@ -5436,6 +5542,10 @@ static struct cdns_torrent_vals_entry ti_j7200_rx_=
ln_vals_entries[] =3D {
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE, =
INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, NO_SSC), &usb_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> +       {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_PCIE_M=
L, INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> +
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 NO_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 EXTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
>         {CDNS_TORRENT_KEY(CLK_100_MHZ, CLK_100_MHZ, TYPE_USB, TYPE_SGMII,=
 INTERNAL_SSC), &usb_100_no_ssc_rx_ln_vals},
> --
> 2.40.1
>
>


