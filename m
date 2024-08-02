Return-Path: <linux-kernel+bounces-273169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA06946535
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A739E2825FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079AE137745;
	Fri,  2 Aug 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ei67T59A"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3115132106
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634998; cv=none; b=AmrQWWk93KN3s3uyhoUdBzHHysRMRifeCsJXYOy6i2e/B+8y1Ubgkp9RsSUjENWpNwUNIaXw2nOsnqkNz2WwG2xxhSExFfKVbUYsIPmWEGpEMqiQjXV7wDXhisuU9SivfarpL+Fq03wUUjrdJd084irExRh9ek4Md3uieWdjK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634998; c=relaxed/simple;
	bh=SfOTiz9UY3pucISMWMj/A6XFiE2X8f0Ut6NVQ49nh+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnTvPdIL+w70/Xx8jSYoCMEUhykiNd3o8jz4Tg3bWEV4NEQVJKEiCQXM+Mm55tBpc/ZKHubAJcLt2+qtHPWuk3pPReuPAf/RQhEvhJ805Xnky8B591ChZM1b0Qm++nmr9804FLXa0GIZaGRUkalHydnbTB2/sBJAYbqaiv40mD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ei67T59A; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so6507081a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722634996; x=1723239796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=ei67T59AhJNLsNB92VV0LsJzKYSMuFYpei/IuoB009+2g/+3vb+mfhr2qJHLCrjxrQ
         Euiy7W0129Ai+Hj0CoB9i7iX2Nn+X/NUy3+XuB1j8Ga8OUfHjlSrpRh4vwTQuQwRQ/4t
         euh1Lv6gBx2QI+lWvmXZDfYjRHtMjpkJY016Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634996; x=1723239796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=laR5ob2uIIm4+XFz3Rqsh5bNOraHC9MQlvR4vCiH5jGtCAGXAXwAGS9FQqPWStBVHj
         H/LetZRru732P6veH4FjDlVLBkT2BiW1q6BB23PaV7/AaOw7mGAPtLUxA++HaWKSziST
         HBEu+A9OZ7i1EsqUoe05DF006SQkcJo692dAe9Be0Dyl7L861SZ14q7a+19D77K71WHU
         GVuxrplTCde25tIrGwNekkVaDskGZXvz6UYBeRcRUK5E38Qksf/9LS7Kk+5AV6hQybtT
         H+fh3J1PYENROp3gQpbVD4MwzS+ZsxtfIKzAj4ZfwF3DxJRrayDkA9dTG0WSm49C84Wk
         s8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVRSsUnMize6GRAg5TNF38akY4gmO3VVIUfkReG3e/7LNz0yUgJ0dWqAFyGMmuOYZiZ91LE/+uq8Oyipr4nFQ5xS6ixThuNE678vyFA
X-Gm-Message-State: AOJu0YzZtPsUZCKsuAJPjtZiim4Cbmlot+zeyA3eoabDX0GYri+VvLx3
	8tJbnvHESOCa2x6Slkcsv6dnsQSOSeBYdQEK8vqLsdpiN1Pn+AADoXx/jxXDaET9E2YP+ggPExF
	sdss43BusjUtVA4DJRFosOf5k9zqXij2+VqZ+
X-Google-Smtp-Source: AGHT+IEtvLrcXhCLETX+9N9XQkX7L9HzPL+GHPynwB9luwQ69BeemNXYJLs+adSVkzdD9GLwGnf0wExUCNvvTJfPf+s=
X-Received: by 2002:a17:90a:f02:b0:2cd:ba3e:38a5 with SMTP id
 98e67ed59e1d1-2cff9469006mr5802105a91.21.1722634996112; Fri, 02 Aug 2024
 14:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
In-Reply-To: <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:43:05 -0700
Message-ID: <CAMdnO-+_w=XTE7TPv-b6RtAbjK1CC9jgf1kukmg9W-_0Dj8O2A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for reposting, resending the reply since I missed reply to all.

On Fri, Aug 2, 2024 at 1:21=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> > +{
> > +     u32 reg_val =3D 0;
> > +     u32 val =3D 0;
>
> val is unnecessary.
True, I will fix it.
>
> > +
> > +     reg_val |=3D mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
>
> Consider using:
>
>         reg_val |=3D FIELD_PREP(XGMAC4_MODE_SELECT, mode);
>
Thanks, I will make the changes.

> and similarly everywhere else you use a shift and mask. With this, you
> can remove _all_ _SHIFT definitions in your header file.
>
> > +     reg_val |=3D channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> > +     reg_val |=3D XGMAC4_CMD_TYPE | XGMAC4_OB;
> > +     writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> > +     val =3D readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
> > +     return val;
>
>         return readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
>
> ...
>
> > +void dwxgmac4_dma_init(void __iomem *ioaddr,
> > +                    struct stmmac_dma_cfg *dma_cfg, int atds)
> > +{
> > +     u32 value;
> > +     u32 i;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +     if (dma_cfg->aal)
> > +             value |=3D XGMAC_AAL;
> > +
> > +     if (dma_cfg->eame)
> > +             value |=3D XGMAC_EAME;
>
> What if dma_cfg doesn't have these bits set? Is it possible they will be
> set in the register?
The reset default for these bits is zero.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

