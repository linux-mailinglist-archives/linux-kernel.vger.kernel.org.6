Return-Path: <linux-kernel+bounces-309572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F92966CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394611C227EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324FC18FDBA;
	Fri, 30 Aug 2024 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gSWt9G2w"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10E189B86
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060938; cv=none; b=mzdoqaZ/kJy5wGVY5Nby+uQ+c/kqfnzITcSJXW+K1FyaFIRNTPccS2o8SSL+IDjkS/ZNi/KQY0dhEdsxEE/AHRYYfenRxz6Yhp1+/lA0s8bV1D82gIiMYk7Da98ttN9g9Z+8TO1MVSei9tDDilklLT/A/S6xYu7uismybk9qOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060938; c=relaxed/simple;
	bh=LQQNZA2lQEoRi9GKKSvucUr0JF3ARJYIkZ4ezaTKJvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCrjqoBq9QLlRpLATpkqHwcHGIVjoZnBxCyiIJe5WB7aUpZN/apVmubh0TqVOl4oSpy1prsWgZMUYHfxiC4U/gyh3mZ40QZKgTEcq80sF6Q5UmDu5ycib/8en5Lzt6xkcaKG5xiWj7eAHY1HOnF5JuACJ2oSQmbgA12bIGlmOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gSWt9G2w; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1568539a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725060935; x=1725665735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGZJFABiiwQ/JcxTEIMxL9o5eO7pEFGecgwfYFoEAXo=;
        b=gSWt9G2wjAgZ3eQ2eeljuCOT8KL8FvDMW50RDgoVVN3O2NZACd7Iqicb74p5S0mriK
         TiHUPgUIEWPGlpcMIcPB+C2AeMiMx22Sc6SG2QSMSh1mEfXaSajxGL1/zRGW5IHmPWuT
         f2GDrHkZZTDTXdnzh6/Oi0m8mAnmWihFEi4tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725060935; x=1725665735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGZJFABiiwQ/JcxTEIMxL9o5eO7pEFGecgwfYFoEAXo=;
        b=sC7bymWIJ+58bf9NBptxoHoPG7Xit7o9Tge8rHSVDZGD0lpL3d9z+OyPW/2pLFcwrz
         mdt7cLlex1JqhIYrDE6ylX/HzEXdpuKjCEXBxfTSmYBonntSGURhWhO5XFfsmotZvVe8
         H5n47a55ixC/I56wxlYIpmiY6rfiBr+mPWzpy1n6/CibPkiFUPcNTYJJOi02eLKIAmAt
         tDaaF8Li4b9KIW1rMhc1FacVn9sG2c/mOILaNOm4i8ZexbU6GWwkeitrEWY9VRf9erSn
         fN3NEpoje8glbbSU2j5mN+iDoHQ5Zb0M34HvKvkbnKd8Mp0p4LUTKCw8F7HHBbFLPV/0
         /wuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdEe3SC5OOmWKbRl/sZx0LvW4QzNg+zleJOytnt4sbg54TiunsunCywuCN8n9kHdX1JPOd4+erSRWqHh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvyE2lPTmhMaEwGZ81MRh735iCDW16RMdNX6sXiR332wNJg8i
	P7so4dcITc0cw7BaaMn51XumdDG269KDY/Mr9gqbgrcAkwh+7bYXrJ+ib9ynpfDlUHC5JFdTsUC
	oJGaWb4khqejLNXnu058EoNPD0INBOtaW+KGX
X-Google-Smtp-Source: AGHT+IFO2EmUFEtOMUYJcEffOgckKQVp9+l73ByoEm+F4H4tX/gdEvT2YlZRRuejeicxCLqYfNh//ZKxuQ+5NID+Eao=
X-Received: by 2002:a17:90a:e16:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2d856b047f7mr11126610a91.12.1725060935251; Fri, 30 Aug 2024
 16:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com> <vxpwwstbvbruaafcatq5zyi257hf25x5levct3y7s7ympcsqvh@b6wmfkd4cxfy>
 <CAMdnO-LDw0OZRfBWmh_4AEYuwbq6dmnh=W3PZwRe1766Ys2huA@mail.gmail.com> <li75hdp527xa3k23za3mfnwgwdcs7j324mlqj3qcxto6t5f6mw@yvhnpxlvlt5c>
In-Reply-To: <li75hdp527xa3k23za3mfnwgwdcs7j324mlqj3qcxto6t5f6mw@yvhnpxlvlt5c>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 30 Aug 2024 16:35:22 -0700
Message-ID: <CAMdnO-K8CPMihDwJnzy1KcTXNT51FGeTAYRQFHMdG6fG45wR-g@mail.gmail.com>
Subject: Re: [net-next v4 3/5] net: stmmac: Integrate dw25gmac into stmmac
 hwif handling
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

On Thu, Aug 29, 2024 at 3:52=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Jitendra
>
> On Mon, Aug 26, 2024 at 11:53:13AM -0700, Jitendra Vegiraju wrote:
> > Hi Serge(y)
> > Thank you for reviewing the patch.
> >
> > On Fri, Aug 23, 2024 at 6:49=E2=80=AFAM Serge Semin <fancer.lancer@gmai=
l.com> wrote:
> > >
> > > Hi Jitendra
> > >
> > > On Wed, Aug 14, 2024 at 03:18:16PM -0700, jitendra.vegiraju@broadcom.=
com wrote:
> > > > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > > >
> > > > Integrate dw25gmac support into stmmac hardware interface handling.
> > > > Added a new entry to the stmmac_hw table in hwif.c.
> > > > Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25=
GMAC
> > > > device.
> > > > Since BCM8958x is an early adaptor device, the synopsis_id reported=
 in HW
> > > > is 0x32 and device_id is DWXGMAC_ID. Provide override support by de=
fining
> > > > synopsys_dev_id member in struct stmmac_priv so that driver specifi=
c setup
> > > > functions can override the hardware reported values.
> > > >
> > > > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > > > ---
> > > > +     }, {
> > > > +             .gmac =3D false,
> > > > +             .gmac4 =3D false,
> > > > +             .xgmac =3D true,
> > > > +             .min_id =3D DW25GMAC_CORE_4_00,
> > > > +             .dev_id =3D DW25GMAC_ID,
> > > > +             .regs =3D {
> > > > +                     .ptp_off =3D PTP_XGMAC_OFFSET,
> > > > +                     .mmc_off =3D MMC_XGMAC_OFFSET,
> > > > +                     .est_off =3D EST_XGMAC_OFFSET,
> > > > +             },
> > > > +             .desc =3D &dwxgmac210_desc_ops,
> > > > +             .dma =3D &dw25gmac400_dma_ops,
> > > > +             .mac =3D &dwxgmac210_ops,
> > > > +             .hwtimestamp =3D &stmmac_ptp,
> > > > +             .mode =3D NULL,
> > > > +             .tc =3D &dwmac510_tc_ops,
> > > > +             .mmc =3D &dwxgmac_mmc_ops,
> > > > +             .est =3D &dwmac510_est_ops,
> > > > +             .setup =3D dwxgmac2_setup,
> > > > +             .quirks =3D NULL,
> > > >       },
> > >
> > > This can be replaced with just:
> > >
> > > +       }, {
> > > +               .gmac =3D false,
> > > +               .gmac4 =3D false,
> > > +               .xgmac =3D true,
> > > +               .min_id =3D DW25GMAC_CORE_4_00,
> > > +               .dev_id =3D DWXGMAC_ID, /* Early DW 25GMAC IP-core ha=
d XGMAC ID */
> > > +               .regs =3D {
> > > +                       .ptp_off =3D PTP_XGMAC_OFFSET,
> > > +                       .mmc_off =3D MMC_XGMAC_OFFSET,
> > > +                       .est_off =3D EST_XGMAC_OFFSET,
> > > +               },
> > > +               .desc =3D &dwxgmac210_desc_ops,
> > > +               .dma =3D &dw25gmac400_dma_ops,
> > > +               .mac =3D &dwxgmac210_ops,
> > > +               .hwtimestamp =3D &stmmac_ptp,
> > > +               .mode =3D NULL,
> > > +               .tc =3D &dwmac510_tc_ops,
> > > +               .mmc =3D &dwxgmac_mmc_ops,
> > > +               .est =3D &dwmac510_est_ops,
> > > +               .setup =3D dw25gmac_setup,
> > > +               .quirks =3D NULL,
> > >         }
> > >
> > > and you won't need to pre-define the setup() method in the
> > > glue driver. Instead you can define a new dw25xgmac_setup() method in
> > > the dwxgmac2_core.c as it's done for the DW XGMAC/LXGMAC IP-cores.
> > >
> > > Note if your device is capable to work with up to 10Gbps speed, then
> > > just set the plat_stmmacenet_data::max_speed field to SPEED_10000.
> > > Alternatively if you really need to specify the exact MAC
> > > capabilities, then you can implement what Russell suggested here
> > > sometime ago:
> > > https://lore.kernel.org/netdev/Zf3ifH%2FCjyHtmXE3@shell.armlinux.org.=
uk/
> > >
> > I like your suggestion to add one stmmac_hw[] array entry (entry_a) for=
 this
> > "early release" DW25GMAC IP and another entry (entry_b) for final DW25M=
AC
> > IP, in the process eliminate the need for a new member variable in stru=
ct
> > stmmac_priv.
> >
>
> > However, I would like to bring to your attention that this device requi=
res
> > special handling for both synopsys_id and dev_id.
> > This device is reporting 0x32 for synopsys_id and 0x76(XGMAC) for dev_i=
d.
> > The final 25GMAC spec will have 0x40 for synopsys_id and 0x55(25GMAC) f=
or
> > dev_id.
>
> For some reason I was thinking that your device had only the device ID
> pre-defined with the XGMAC value meanwhile the Synopsys ID was 0x40.
> Indeed you get to override both of these data in the platform-specific
> setup() method.
>
> >
> > So, in order to avoid falsely qualifying other XGMAC devices with
> > synopsis_id >=3D0x32 as DW25GMAC, I am thinking we will have to overwri=
te the
> > synopsys_id to 0x40 (DW25GMAC_CORE_4_00) in glue driver using existing
> > glue driver override mechanism.
> >
> > We can implement dw25gmac_setup() in dwxgmac2_core.c for generic 25GMAC
> > case. But, this glue driver will have to rely on its own setup function
> > to override the synopsys_id as DW25GMAC_CORE_4_00.
> >
> > Do you think it looks reasonable?
>
> What I was trying to avoid was the setup() method re-definition just
> for the sake of the IP-core version override. Because if not for that
> you could have created and used the generic DW 25GMAC dw25gmac_setup()
> function.
>
> One of the possible solutions I was thinking was to introduce the
> plat_stmmacenet_data::{snps_id,dev_id} fields and use their values in
> the stmmac_hwif_init() procedure instead of the data read from the
> MAC.VERSION CSR.
>
Hi Serge(y),
Thanks for the suggestions, I will implement this option since the
code change is mostly local.
We will have to add following check in hwif.c
@@ -313,7 +313,10 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
        u32 id, dev_id =3D 0;
        int i, ret;

-       if (needs_gmac) {
+       if (priv->plat->snps_id && priv->plat->snps_dev_id) {
+               id =3D priv->plat->snps_id;
+               dev_id =3D priv->plat->snps_dev_id;
+       } else if (needs_gmac) {
                id =3D stmmac_get_id(priv, GMAC_VERSION);

> Another solution could be to add the plat_stmmacenet_data::has_25gmac
> field and fix the generic driver code to using it where it's relevant.
> Then you won't need to think about what actual Synopsys ID/Device ID
> since it would mean a whole new IP-core.
>
> -Serge(y)
>

