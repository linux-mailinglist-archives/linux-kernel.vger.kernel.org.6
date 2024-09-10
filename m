Return-Path: <linux-kernel+bounces-323829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12A79743EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE611C255BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3601A7076;
	Tue, 10 Sep 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="qOu+N3eJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CFB1A2574
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999291; cv=none; b=YeBqLYsNgMoHSdPXxcyoNufH5KEFL+U+rfnJnkaw1aDSEir648ioYTuy5+cZOXvF7kq3Vyy24YSLWRj0kVfR6dmBuKu+96+8jCRNQ+y1mQGUUU8ibVDBaWJQulsYuYS4sSMNvsFOWbMBTWHrTtF6GjawxOmFeFJazyAe9CF7v60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999291; c=relaxed/simple;
	bh=uLqkbtaF/lYOCg5L7+7mzBordSwyiyem7pG6ozNXv6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgY77UnCeJolBd6PtWcOf9dkewCPskQ00yiPnUBsS3fGgTN2aV5o3sYPz/O02pg6b6+KospryYi//GCk17TbgJHYuJMWszP/bBp0QA+fOUd9as8Ka7BAN35p1P2G/RHraHV0vbNpIqoyBg8ft6lv7p/Zy7tUlSSFLKKX4gLrUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=qOu+N3eJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso582438766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1725999287; x=1726604087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re/RvoGbxwdzYBSMy04B2Az3HNgONOU/qvSCSe57sDc=;
        b=qOu+N3eJTxVHbmcOMlTab09ztE/iX3G95RqCy1Xi8dZUEIJmaGGIC2i9RZ1qbNP1tl
         oNxZp4Qt+TrNJ2r9RR2Z19/qAaOQZwRwAkUGxLfiSV1jty3s1d61Ztb/LSNZs81bNPE8
         rM0HzQNyy5rG/BFxWRcnrgn53svZejmvKYxCJmhtbxbA5cr/uFTAN17GX60i1hVahzPY
         KScIGmv/d4vnLUW/qMQeandTkJn5mJ3OMaxXx4v33Nfud4OUq7YQZOSSFeDkKDvcbzEI
         NpfjHYIhjaO+RWGozZh9N6phVAgEXvzt9iyrWBiN69vz6lXgKjrriyKdsZPyu5TCkZji
         4Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999287; x=1726604087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re/RvoGbxwdzYBSMy04B2Az3HNgONOU/qvSCSe57sDc=;
        b=WPd/MsXdF1uCkXgHxnSEFko2IHscIxbfw7FVCwsyHCc74+8ehcIhFyjQdTpmm+31HA
         o3smZ3vRzX/upFKzkMyJySs5pBLQ/d2AuQqgc21ExnN7dy/6mTwBqv5vzvk62HhKE8i1
         p4XMegCROurNKXe5S08MmzjBAqiV6P07iXFtvRsk1zgxvzJiLRFp7Tqxd4Al69m/HQIO
         NMUHsW/PG8YtGBYWgXyNCs0yl3wBf2Tknlz681sQvJNKKSlU2C/NgxlMdcu/TUqWej4Z
         gujR8gTe3bOZ9rhw4tiYMHi3TaeKgw4VtrNeogDZcXH7A5oUGXuNM4eq6p9hWv8tf2cg
         Ms/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJfElvVS1cREc60gR98HJl+/+5mK+OX70UCNE8GRpk6b5hun89VpyeDQ0BN66JdFxAt0uRZ35y45i9OVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcGiILIps4W+IDKYb8TtkaeVmKHIBvN7J7QIlBKp0ypWttd+4
	OyY2eb0Q+qIVWKj0fMeIU4lMPT5qbHeexLe8yDJmJVfSlu1hh0vO2+u4RGNKXpw+hhpSWj+3au7
	4O+7A1UTen5/lo5c9Tbpgu9cxvJjQ+7yUtQ/+rQ==
X-Google-Smtp-Source: AGHT+IFSy3754qdsgn+YFAz1meLOVeKD2q6UuOoxvRh0g802fr0oiEfcIphQGK8utwSUQpeBElrdfh5jrqHgOaz8vc0=
X-Received: by 2002:a17:907:94d5:b0:a8d:3705:4101 with SMTP id
 a640c23a62f3a-a8ffab78b54mr175294266b.39.1725999286224; Tue, 10 Sep 2024
 13:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909215359.780561-1-tharvey@gateworks.com> <ef218f6b-7c24-41f2-a3a3-fcd97c29886d@kontron.de>
In-Reply-To: <ef218f6b-7c24-41f2-a3a3-fcd97c29886d@kontron.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 10 Sep 2024 13:14:34 -0700
Message-ID: <CAJ+vNU0zZMcg3fFqZinx5cs0WGV4LGVByj=XEqn3mGt-Qa=xrg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice*: enable NPU support
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:50=E2=80=AFPM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Tim,
>
> On 09.09.24 11:53 PM, Tim Harvey wrote:
> > The IMX8MP has a VeriSilicon (Vivante VIP8000) NPU which
> > is supported by the etnaviv driver. Enable it.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 4 ++++
> >  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts  | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/=
arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> > index 6c75a5ecf56b..f0211a96855b 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> > @@ -393,6 +393,10 @@ &i2c3 {
> >       status =3D "okay";
> >  };
> >
> > +&npu {
> > +     status =3D "okay";
> > +};
> > +
> >  /* off-board header */
> >  &uart1 {
> >       pinctrl-names =3D "default";
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/a=
rch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > index 9885948952b4..8a04b66a4afc 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -666,6 +666,10 @@ &i2c4 {
> >       status =3D "okay";
> >  };
> >
> > +&npu {
> > +     status =3D "okay";
> > +};
> > +
> >  &pcie_phy {
> >       fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> >       fsl,clkreq-unsupported;
>
> I think there is no need for this patch as the NPU is already enabled by
> default in imx8mp.dtsi (same as the GPUs). Or do you disable it in some
> intermediate devicetree include file?
>

Frieder,

Thanks for pointing this out... you are correct. I'm not sure why I
thought it needed to be explicitly enabled.

Please ignore this patch.

Best Regards,

Tim

