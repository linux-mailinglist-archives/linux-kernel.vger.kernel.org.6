Return-Path: <linux-kernel+bounces-177926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484A8C464D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15691F24C11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B338394;
	Mon, 13 May 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YaTPZ0a9"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE836120
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621940; cv=none; b=A1wlgAHJd+6ifg2dMgFjNt4A6z4gkjUAYsq63nQe9z2nJvSXxB5jmlUA/4UXZonanY1s0n6+flJzbea4NBbfEa+S9P11Z9VL7EQ9Nv/lKBLCbLlSeivWPNxwYk87x4simf+ipyU7kJMVhYb7mQutzq+2js1Dp1QIzcWKacmOD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621940; c=relaxed/simple;
	bh=cq/OXbZCJx63DXhmsaS/NtZwHorfQWD5J95epM3720M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5+tqotiBydmsGGabCC3QXeBFa0ZM2lOHDI6iw7T2k+BZmcDG+xnyuabeCteDSONycgdPH3mZUiagAUOPTu7fuQ9RrBbQSSGz+H1k464aJ7f5eERPV66FqZcqaS8sy+Cd0LGvt6Yqe+SNwYM6z/tEMluax1sFFVkgSDcJn8KStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YaTPZ0a9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36c926b3fc7so17437665ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715621938; x=1716226738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E13Anx86bMNjoddbW8lkh0a87kpa/TTWPj+bkKM8F5o=;
        b=YaTPZ0a9nBXkqd4cS0iEufbRF6puH90vN06QBY1NXghjozLu833vEKXXmjAgl3QuwL
         Nu9zATTsJmJyIlPiIMClB+G+FrS8TrBV1Ov0lNXdsW6yBkybFl8fmowItwKIJfEBNRR1
         yt1oXHfPJHLywAlG4+9jr6ZyOz/gLiEUyppkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621938; x=1716226738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E13Anx86bMNjoddbW8lkh0a87kpa/TTWPj+bkKM8F5o=;
        b=e3lEtp1vgIe1jb9rKR2x9QI86vp83tQHHyIsSGf1oqkbopUvRr81nZfO5BGyuhS52A
         LQ3Xzs55gxZCnWazRYGYxIv6UtTkDUFYOqwF3ndPhtqgnbeSDrMWo3mTMIqWGpt4GoHU
         taUyEG59dVHJNCZBMuelFu9v/9b9ohIRQA7bdi8YGLD4+tuN2wOpxY7GkfLUslRv0g2r
         r64yVRVs66y8ESJM9NaNRZpLNAyFFdmgvrsKANll7DjlX0xu2+eZX9iNdBjms6OFkH4v
         +I6a7s6F19uZ0dd4rUCnD3AZ2cqWUwPa0pgMl22Vz2MnEa6KGYRtbogz+svojL2ISt8c
         8fOw==
X-Forwarded-Encrypted: i=1; AJvYcCV+BNec2B1ltbUsUopX/kovQzCTI0atP3oLbsu5dmqXUs+C4Ba26zYPiMbzsWE/dH4kd85Z5EmALGbTUhgiH6rLrW7CD8sdhjY33tOL
X-Gm-Message-State: AOJu0YydEU6Xqs7WEZU8SBRyMpwmgvrfQKJVGtt03nFHtw/IGIomVBuA
	73eTmDK1Ic4vgQxaLSfzaEmm64LvH9Lu0WOALq3SPtm0n4NhDmW71NFFYn7gcEJqwayYBhT4epL
	1b4mQEhe+5WmVwCLCy6f4OhaJa/6vmI1b48wr
X-Google-Smtp-Source: AGHT+IGeLTULutWAy5kyMHyDUYP7f3tlidCiwxM+L/Py1x4cinO7yuSx3qOu8fESXEE5y9oh9geTgy17aKqRm673hh4=
X-Received: by 2002:a05:6e02:b29:b0:36c:7eb2:50c6 with SMTP id
 e9e14a558f8ab-36cc14df6fcmr128906625ab.20.1715621938097; Mon, 13 May 2024
 10:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510000331.154486-3-jitendra.vegiraju@broadcom.com>
 <20240511015924.41457-1-jitendra.vegiraju@broadcom.com> <Zj/IPpub11OL3jBo@shell.armlinux.org.uk>
In-Reply-To: <Zj/IPpub11OL3jBo@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 13 May 2024 10:38:46 -0700
Message-ID: <CAMdnO-KCC0qXEsE1iDGNZwdd0PAcsRinmxe8_-5Anp=e1c5WFA@mail.gmail.com>
Subject: Re: [PATCH v2, net-next, 2/2] net: stmmac: PCI driver for BCM8958X SoC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	richardcochran@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing the patch.
On Sat, May 11, 2024 at 12:34=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> Thanks for the patch,. but there are things that need some improvement.
>
> On Fri, May 10, 2024 at 06:59:24PM -0700, Jitendra Vegiraju wrote:
> > +static void dwxgmac_brcm_dma_init_tx_chan(struct stmmac_priv *priv,
> > +                                       void __iomem *ioaddr,
> > +                                       struct stmmac_dma_cfg *dma_cfg,
> > +                                       dma_addr_t phy, u32 chan)
> > +{
> > +     u32 value;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > +     value &=3D ~XGMAC_TxPBL;
> > +     value &=3D ~GENMASK(6, 4);
> > +     writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > +
> > +     writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(cha=
n));
> > +     writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(cha=
n));
>
> Please use "dma_addr" not "phy" here. "phy" could mean ethernet phy.
> I personally dislike "physical address" for DMA stuff because if
> there's an IOMMU or other translation layer present, what you have
> here is *not* a physical address.
>
Yes, we will address it.
> > +static void dwxgmac_brcm_dma_init_rx_chan(struct stmmac_priv *priv,
> > +                                       void __iomem *ioaddr,
> > +                                       struct stmmac_dma_cfg *dma_cfg,
> > +                                       dma_addr_t phy, u32 chan)
> > +{
> > +     u32 value;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > +     value &=3D ~XGMAC_RxPBL;
> > +     writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > +
> > +     writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(cha=
n));
> > +     writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(cha=
n));
>
> Ditto.
>
Noted.
> ...
>
> > +static void dwxgmac_brcm_fix_speed(void *priv, unsigned int speed,
> > +                                unsigned int mode)
> > +{
> > +}
>
> If this is empty, do you really need it? The method is optional.
>
> ...
>
> > +static int dwxgmac_brcm_pci_probe(struct pci_dev *pdev,
> > +                               const struct pci_device_id *id)
> > +{
> ...
> > +     /* This device interface is directly attached to the switch chip =
on
> > +      *  the SoC. Since no MDIO is present, register fixed_phy.
> > +      */
> > +     brcm_priv->phy_dev =3D
> > +              fixed_phy_register(PHY_POLL,
> > +                                 &dwxgmac_brcm_fixed_phy_status, NULL)=
;
> > +     if (IS_ERR(brcm_priv->phy_dev)) {
> > +             dev_err(&pdev->dev, "%s\tNo PHY/fixed_PHY found\n", __fun=
c__);
> > +             return -ENODEV;
> > +     }
> > +     phy_attached_info(brcm_priv->phy_dev);
>
> As pointed out in the other sub-thread, you don't need this. If you need
> a fixed-link and you don't have a firmware description of it, you can
> provide a swnode based description through plat->port_node that will be
> passed to phylink. Through that, you can tell phylink to create a
> fixed link.
>
Thank you for the pointers or software node support.
Since the driver is initially targetted for X86/_64, we were not sure
how to deal with lack of OF support.
We will try out the software node facility.
> > +     ret =3D stmmac_dvr_probe(&pdev->dev, plat, &res);
> > +     if (ret)
> > +             goto err_disable_msi;
> > +
> > +     /* The stmmac core driver doesn't have the infrastructure to
> > +      * support fixed-phy mdio bus for non-platform bus drivers.
> > +      * Until a better solution is implemented, initialize the
> > +      * following entries after priv structure is populated.
> > +      */
> > +     ndev =3D dev_get_drvdata(&pdev->dev);
> > +     priv =3D netdev_priv(ndev);
> > +     priv->mii =3D mdio_find_bus("fixed-0");
> > +
> > +     ndev->hw_features &=3D ~NETIF_F_HW_VLAN_CTAG_RX;
> > +     priv->hw->hw_vlan_en =3D false;
>
> Basically... no. Do not do any setup after stmmac_dvr_probe(), because
> the network device has already been registered and published to
> userspace, and userspace may have already opened the network device.
>
This will be tied to the above topic.
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

