Return-Path: <linux-kernel+bounces-331204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5397A9A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E53DB27E09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AA158550;
	Mon, 16 Sep 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IPyYuuwQ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98678A95E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529567; cv=none; b=BngT7iy5SwDtSiKu3iDA9J5RrUT8+s1AlxRWs1pnpVKukpk226HrAXf/AO+Z98P3nKtnE1g1IC6qqZ/CyKc0HyC0I77kqwPZc5noEW6L56NQ3boWlJsELS/SkjzfEssh9Djfqf5q58I0ij4ZeUlNfv7MEj4PIQqi1nYrNJIQHSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529567; c=relaxed/simple;
	bh=SPtdiIyfNANrl9FF5m1x7BfDT/+sAltGRKt9GKfd7Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id3k4bYJyIjz4TjoBdZHMxFe8M7037U/aKKBpO4r1H5v03sPopqZEtkflkPP5aSquBoNeVR9cKKIDM5twZzYkJ31BfOU5PqgrKf8dUsLwM3oBmfdqEZmFyXneLyjtusBD6ycxxcjvzONmV/MNBXgaO+DX3WdK1dfdPZNCZ1stJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IPyYuuwQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2950882a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726529565; x=1727134365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9mUVHMAavcUxKnLNiLYFc/iky/HnjZfCcQFKHlZayo=;
        b=IPyYuuwQR365L4BnH1vgXap7IHeJYE+7kAcs1W1m5TgB4EYDNZn353fWGcJ5hC64Vv
         oCWYDM3SkaEaivpjXa+f9fXzcuCHMo6Rfk8oFOe3tTcTw9Jtgq5pkunHc7uo2uw4WD7R
         ni416nwiAi85DQZmnqaPTUmPbPZvIFXq5+zj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726529565; x=1727134365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9mUVHMAavcUxKnLNiLYFc/iky/HnjZfCcQFKHlZayo=;
        b=SFjz1m2MF+Q+14hhTCbBbU84cCYIK63gd/oBbpWPdS6ZJEHvnfGYk5BmspqmuOxa9y
         TQzOTI5krx2X/bqAqqTdTsslrZDymz8MNh4gL3K1nhO0sDx+BKOJxwoSr2gVNytyuOAC
         37sZxaQRiJIYW/kxQUjlwISzMn0iJvllrqPL0ihYi045lxWgwt2wrv3d5pW5s+GlD5w/
         6ggAL3eWW9MGRQw/INPwPu5d5GOb8lBj6ohWlAbPxTCsW23bNnwQvY6Qhj6/6a6CEfaU
         BA8LYhCkCxqd+bwVlq6l61WilGdRj/vgGYHKWJ6eNxJ2wiiAdnsim/I51fxs6Yjeye6e
         3IjA==
X-Forwarded-Encrypted: i=1; AJvYcCVFS+kuagaK/eaLpZ5G6P8VijZSkxdQOAcIEuYBl5DN8LrV2f4meLw8hikUzg8fpUTzFf0Jy89UxvsjrsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MR7WPRlCb0L3f6QlLTY7PQkgIMlKtisUjQmKvNEHCHemxIFV
	W6q9r90fumVLu8t/gnR6K/dqUsLO35bnohJ8VOzscmGb8Sw0qT4ad+ZdBTBa0Fv+F4Ky4Bnjh6j
	/oucIQDDFQal0sOTEre+5YOdISd7gG49HqQBU
X-Google-Smtp-Source: AGHT+IE72MFyllzN0ozCXMGgr1MGi103ntb9aa1icB+w7Su1bkHJaYgfDvvRt+ybuNJ1tdHngYO6KpJTNc4763XH4NM=
X-Received: by 2002:a05:6a21:1707:b0:1cf:6c65:68d with SMTP id
 adf61e73a8af0-1cf762382d3mr25137092637.46.1726529564812; Mon, 16 Sep 2024
 16:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <20240904054815.1341712-3-jitendra.vegiraju@broadcom.com> <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
In-Reply-To: <mhfssgiv7unjlpve45rznyzr72llvchcwzk4f7obnvp5edijqc@ilmxqr5gaktb>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 16 Sep 2024 16:32:33 -0700
Message-ID: <CAMdnO-+CcCAezDXLwTe7fEZPQH6_B1zLD2g1J6uWiKi12vOxzg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/5] net: stmmac: Add basic dw25gmac support
 in stmmac core
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Serge,

On Tue, Sep 10, 2024 at 12:25=E2=80=AFPM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> > +static u32 decode_vdma_count(u32 regval)
> > +{
> > +     /* compressed encoding for vdma count
> > +      * regval: VDMA count
> > +      * 0-15  : 1 - 16
> > +      * 16-19 : 20, 24, 28, 32
> > +      * 20-23 : 40, 48, 56, 64
> > +      * 24-27 : 80, 96, 112, 128
> > +      */
> > +     if (regval < 16)
> > +             return regval + 1;
> > +     return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);
>
> The shortest code isn't always the best one. This one gives me a
> headache in trying to decipher whether it really matches to what is
> described in the comment. What about just:
>
>         if (regval < 16) /* Direct mapping */
>                 return regval + 1;
>         else if (regval < 20) /* 20, 24, 28, 32 */
>                 return 20 + (regval - 16) * 4;
>         else if (regval < 24) /* 40, 48, 56, 64 */
>                 return 40 + (regval - 20) * 8;
>         else if (regval < 28) /* 80, 96, 112, 128 */
>                 return 80 + (regval - 24) * 16;
>
> ?
Couldn't agree more :)
Thanks, I will replace it with your code, which is definitely more readable=
.

>
> > +}
> > +
> > +static void dw25gmac_read_hdma_limits(void __iomem *ioaddr,
> > +                                   struct stmmac_hdma_cfg *hdma)
> > +{
> > +     u32 hw_cap;
> > +
> > +     /* Get VDMA/PDMA counts from HW */
> > +     hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
>
>
> > +     hdma->tx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDM=
A_TXCNT,
> > +                                                  hw_cap));
> > +     hdma->rx_vdmas =3D decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDM=
A_RXCNT,
> > +                                                  hw_cap));
> > +     hdma->tx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
> > +     hdma->rx_pdmas =3D FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
>
> Hmm, these are the Tx/Rx DMA-channels and Tx/Rx MTL-queues count
> fields. Can't you just use the
> dma_features::{number_tx_channel,number_tx_queues} and
> dma_features::{number_rx_channel,number_rx_queues} fields to store the
> retrieved data?
>
> Moreover why not to add the code above to the dwxgmac2_get_hw_feature() m=
ethod?
>
Thanks, I missed the reuse of existing fields.
However, since the VDMA count has a slightly bigger bitmask, we need to ext=
ract
VDMA channel count as per DW25GMAC spec.
Instead of duplicating dwxgmac2_get_hw_feature(), should we add wrapper for
dw25gmac, something like the following?
dw25gmac_get_hw_feature(ioaddr, dma_cap)
{
    u32 hw_cap;
    int rc;
    rc =3D dwxgmac2_get_hw_feature(ioaddr, dma_cap);
    /* Get VDMA counts from HW */
    hw_cap =3D readl(ioaddr + XGMAC_HW_FEATURE2);
   dma_cap->num_tx_channels =3D
decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
     hw_cap));
   dma_cap->num_rx_channels =3D
decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
     hw_cap));
   return rc;
}

> > +}
> > +
> > +int dw25gmac_hdma_cfg_init(struct stmmac_priv *priv)
> > +{
> > +     struct plat_stmmacenet_data *plat =3D priv->plat;
> > +     struct device *dev =3D priv->device;
> > +     struct stmmac_hdma_cfg *hdma;
> > +     int i;
> > +
> > +     hdma =3D devm_kzalloc(dev,
> > +                         sizeof(*plat->dma_cfg->hdma_cfg),
> > +                         GFP_KERNEL);
> > +     if (!hdma)
> > +             return -ENOMEM;
> > +
> > +     dw25gmac_read_hdma_limits(priv->ioaddr, hdma);
> > +
> > +     hdma->tvdma_tc =3D devm_kzalloc(dev,
> > +                                   sizeof(*hdma->tvdma_tc) * hdma->tx_=
vdmas,
> > +                                   GFP_KERNEL);
> > +     if (!hdma->tvdma_tc)
> > +             return -ENOMEM;
> > +
> > +     hdma->rvdma_tc =3D devm_kzalloc(dev,
> > +                                   sizeof(*hdma->rvdma_tc) * hdma->rx_=
vdmas,
> > +                                   GFP_KERNEL);
> > +     if (!hdma->rvdma_tc)
> > +             return -ENOMEM;
> > +
> > +     hdma->tpdma_tc =3D devm_kzalloc(dev,
> > +                                   sizeof(*hdma->tpdma_tc) * hdma->tx_=
pdmas,
> > +                                   GFP_KERNEL);
> > +     if (!hdma->tpdma_tc)
> > +             return -ENOMEM;
> > +
> > +     hdma->rpdma_tc =3D devm_kzalloc(dev,
> > +                                   sizeof(*hdma->rpdma_tc) * hdma->rx_=
pdmas,
> > +                                   GFP_KERNEL);
> > +     if (!hdma->rpdma_tc)
> > +             return -ENOMEM;
> > +
>
> > +     /* Initialize one-to-one mapping for each of the used queues */
> > +     for (i =3D 0; i < plat->tx_queues_to_use; i++) {
> > +             hdma->tvdma_tc[i] =3D i;
> > +             hdma->tpdma_tc[i] =3D i;
> > +     }
> > +     for (i =3D 0; i < plat->rx_queues_to_use; i++) {
> > +             hdma->rvdma_tc[i] =3D i;
> > +             hdma->rpdma_tc[i] =3D i;
> > +     }
>
> So the Traffic Class ID is initialized for the
> tx_queues_to_use/rx_queues_to_use number of channels only, right? What
> about the Virtual and Physical DMA-channels with numbers greater than
> these values?
>
You have brought up a question that applies to remaining comments in
this file as well.
How the VDMA/PDMA mapping is used depends on the device/glue driver.
For example in
our SoC the remaining VDMAs are meant to be used with SRIOV virtual
functions and not
all of them are available for physical function.
Since additional VDMAs/PDMAs remain unused in hardware I let them stay at t=
heir
default values. No traffic is expected to be mapped to unused V/PDMAs.
 I couldn't think of a reason for it to be an issue from a driver perspecti=
ve.
Please let me know, if I am missing something or we need to address a
use case with bigger scope.
The responses for following comments also depend on what approach we take h=
ere.

> > +     plat->dma_cfg->hdma_cfg =3D hdma;
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +void dw25gmac_dma_init(void __iomem *ioaddr,
> > +                    struct stmmac_dma_cfg *dma_cfg)
> > +{
> > +     u32 value;
> > +     u32 i;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +     value &=3D ~(XGMAC_AAL | XGMAC_EAME);
> > +     if (dma_cfg->aal)
> > +             value |=3D XGMAC_AAL;
> > +     if (dma_cfg->eame)
> > +             value |=3D XGMAC_EAME;
> > +     writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_vdmas; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> > +             value &=3D ~XXVGMAC_TXDCSZ;
> > +             value |=3D FIELD_PREP(XXVGMAC_TXDCSZ,
> > +                                 XXVGMAC_TXDCSZ_256BYTES);
> > +             value &=3D ~XXVGMAC_TDPS;
> > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
> > +             wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> > +     }
> > +
> > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_vdmas; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> > +             value &=3D ~XXVGMAC_RXDCSZ;
> > +             value |=3D FIELD_PREP(XXVGMAC_RXDCSZ,
> > +                                 XXVGMAC_RXDCSZ_256BYTES);
> > +             value &=3D ~XXVGMAC_RDPS;
> > +             value |=3D FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF);
> > +             wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> > +     }
> > +
>
> > +     for (i =3D 0; i < dma_cfg->hdma_cfg->tx_pdmas; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> > +             value &=3D ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> > +             if (dma_cfg->pblx8)
> > +                     value |=3D XXVGMAC_TPBLX8_MODE;
> > +             value |=3D FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> > +             wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> > +             xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_tc[i=
]);
> > +     }
> > +
> > +     for (i =3D 0; i < dma_cfg->hdma_cfg->rx_pdmas; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> > +             value &=3D ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> > +             if (dma_cfg->pblx8)
> > +                     value |=3D XXVGMAC_RPBLX8_MODE;
> > +             value |=3D FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> > +             wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> > +             xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_tc[i=
]);
>
> What if tx_pdmas doesn't match plat_stmmacenet_data::tx_queues_to_use
> and rx_pdmas doesn't match to plat_stmmacenet_data::rx_queues_to_use?
>
> If they don't then you'll get out of the initialized tpdma_tc/rpdma_tc
> fields and these channels will be pre-initialized with the zero TC. Is
> that what expected? I doubt so.
>
As mentioned in the previous response the remaining resources are unused
and no traffic is mapped to those resources.

> > +     }
> > +}
> > +
>
> > +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan)
> > +{
> > +     u32 value;
> > +
>
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > +     value &=3D ~XXVGMAC_TVDMA2TCMP;
> > +     value |=3D FIELD_PREP(XXVGMAC_TVDMA2TCMP,
> > +                         dma_cfg->hdma_cfg->tvdma_tc[chan]);
> > +     writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
>
> Please note this will have only first
> plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use} VDMA
> channels initialized. Don't you have much more than just 4 channels?
>
Yes, there are 32 VDMA channels on this device. In our application the
additional channels are partitioned for use with SRIOV virtual functions.
Similar to PDMA comment above, the additional VDMAs are not enabled,
and left in default state.
My thinking is, when another 25gmac device comes along that requires a
different mapping we may need to add the ability to set the mapping in
glue driver.
We can support this by adding a check in dw25gmac_setup()
@@ -1708,8 +1708,10 @@ int dw25gmac_setup(struct stmmac_priv *priv)
        mac->mii.clk_csr_shift =3D 19;
        mac->mii.clk_csr_mask =3D GENMASK(21, 19);

-       /* Allocate and initialize hdma mapping */
-       return dw25gmac_hdma_cfg_init(priv);
+       /* Allocate and initialize hdma mapping, if not done by glue driver=
. */
+       if (!priv->plat->dma_cfg->hdma_cfg)
+               return dw25gmac_hdma_cfg_init(priv);
+       return 0;
 }

> > +
> > +     writel(upper_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> > +     writel(lower_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> > +}
> > +
> > +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan)
> > +{
> > +     u32 value;
> > +
>
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > +     value &=3D ~XXVGMAC_RVDMA2TCMP;
> > +     value |=3D FIELD_PREP(XXVGMAC_RVDMA2TCMP,
> > +                         dma_cfg->hdma_cfg->rvdma_tc[chan]);
> > +     writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
>
> The same question.
>
> > +
> > +     writel(upper_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> > +     writel(lower_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> > +}
>
> These methods are called for each
> plat_stmmacenet_data::{tx_queues_to_use,rx_queues_to_use}
> DMA-channel/Queue. The static mapping means you'll have each
> PDMA/Queue assigned a static traffic class ID corresponding to the
> channel ID. Meanwhile the VDMA channels are supposed to be initialized
> with the TC ID corresponding to the matching PDMA ID.
>
> The TC ID in this case is passed as the DMA/Queue channel ID. Then the
> Tx/Rx DMA-channels init methods can be converted to:
>
> dw25gmac_dma_init_Xx_chan(chan)
> {
>         /* Map each chan-th VDMA to the single chan PDMA by assigning
>          * the static TC ID.
>          */
>         for (i =3D chan; i < Xx_vdmas; i +=3D (Xx_vdmas / Xx_queues_to_us=
e)) {
>                 /* Initialize VDMA channels */
>                 XXVGMAC_TVDMA2TCMP =3D chan;
>         }
>
>         /* Assign the static TC ID to the specified PDMA channel */
>         xgmac4_rp2tc_map(chan, chan)
> }
>
> , where X=3D{t,r}.
>
> Thus you can redistribute the loops implemented in dw25gmac_dma_init()
> to the respective Tx/Rx DMA-channel init methods.
>
> Am I missing something?
I think your visualization of HDMA may be going beyond the application
I understand.
We are allocating a VDMA for each of the TX/RX channels. The use of
additional VDMAs
depends on how the device is partitioned for virtualization.
In the non-SRIOV case the remaining VDMAs will remain unused.
Please let me know if I missed your question.
>
> -Serge()
>
> > [...]

