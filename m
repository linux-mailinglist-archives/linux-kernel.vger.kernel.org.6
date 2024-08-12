Return-Path: <linux-kernel+bounces-283510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF994F5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A02E1F21EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637D1891B9;
	Mon, 12 Aug 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj4B7ErO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14A1804F;
	Mon, 12 Aug 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483793; cv=none; b=hm+kjNVcpPLY3MJr4uwQWQnOhL9qxzsUwe3HgwJyV8KA4O8As1Ic0dvO3S6F1P/60ispZ/sn9ZrRENufly3vWh6MN/N4FRr2pjbqNksZlsK4VAjGFUuQb+Wq5FS/VJlKQor0SwfFzzIgcPUwY0TKpaqTQ00YbEBK5RSWsyLT+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483793; c=relaxed/simple;
	bh=ZMRNbjL+wxtlYnhgMC1O+M2KBcMWEJ4sd49/ahmx+Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgminkO2rSRIzDSqgKe3JTM52gQSn4KRbTuKWeKS6ZfTQxT/3F0Qcmx2f9AACHZTi1tLacnHkYQJcNgzFH7PSByTnLJu8T04e03PM7wSWzQIbpa00EEulMOZMh0tD8TXHnLfSebhy+ZyBhBU8LMi3hKIODDk2twueC82A5mVpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj4B7ErO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A316C4AF0F;
	Mon, 12 Aug 2024 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723483793;
	bh=ZMRNbjL+wxtlYnhgMC1O+M2KBcMWEJ4sd49/ahmx+Wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dj4B7ErO/CP6ZLdD536O+BA6aLuIyPIfsgR1Gi5jpzdsrUNydzLsFM1hTgeTNNJDQ
	 QhkS9M8zyYg9YiZZA3gNI4GQtVOQdrIIGv53+egr0WRYmqm0jK3UhbbIOud2X4o5u2
	 /X99Uwy9XH1y/9SHCn0LBaisV/HvNIdg5uRGs5d/3DbD7RRstL5qUjXSKsvsPx6Gl3
	 T31zoIJWA7Pf8Rur3ZbcEfns6XDaaQk3veMxfRESCy39mXz1ECygNh+nSig5ZkMBEu
	 askEcqSawLJ9NcfNiHiWLMJ7SJbzNzffPUZIK2hVBQcGG4a1ixvAyCk3BZNpb3AOxL
	 /hma3ZiwBmT+g==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so36323491fa.3;
        Mon, 12 Aug 2024 10:29:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/jG1I1k2lR/5397JVXQUhEDtgGxgkmT7D5A8ktSZfBpawS1Vmg+wpehWPG+ZhVxGEqB59S2HP9N6aJ39i@vger.kernel.org, AJvYcCWS7cgNWC663AzZb9niWZ02RP5S8vvbCS0J6B5p8kNwVIl+BYCK+TF7E+w5bcr2aZMtVDwUpBicsty5@vger.kernel.org
X-Gm-Message-State: AOJu0YyqchwPam46D49rz7QNGm5sl0qDBlED7agGmU50baTTPVXlqguV
	cD1vNpNv8zho2TY46vkcg2h2QHHwed8NCwOO5feD/iTepx4YZr3jouLeu2zXNUGlYJeEBFdIMiR
	3UzinQrB1p+yEcic/6jNAWfKUrw==
X-Google-Smtp-Source: AGHT+IE9wc5/vzAjDKeN2XhVueDGhex+PvvstDZfZq09zwIkHu1hg7cHE20vFxpTUw1TOpUPaqzN59nU/oMrltfDIoU=
X-Received: by 2002:a2e:851:0:b0:2ef:307a:9988 with SMTP id
 38308e7fff4ca-2f2b7178816mr6174081fa.35.1723483791791; Mon, 12 Aug 2024
 10:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808153120.3305203-1-Frank.Li@nxp.com> <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810> <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810> <20240809-freewill-compactor-4f441a4a60bb@spud>
 <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
In-Reply-To: <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Aug 2024 11:29:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzvEpXbTk0XjPuErz2nRaTXX1DP9WG8yshULcVv0bS-Q@mail.gmail.com>
Message-ID: <CAL_JsqLzvEpXbTk0XjPuErz2nRaTXX1DP9WG8yshULcVv0bS-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string to fsl,ls2088a-pcie
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 11:11=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Fri, Aug 09, 2024 at 04:07:25PM +0100, Conor Dooley wrote:
> > On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
> > > On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
> > > > On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
> > > > > On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
> > > > > > On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
> > > > > > > The mass production lx2160 rev2 use designware PCIe Controlle=
r. Old Rev1
> > > > > > > which use mobivel PCIe controller was not supported. Although=
 uboot
> > > > > > > fixup can change compatible string fsl,lx2160a-pcie to fsl,ls=
2088a-pcie
> > > > > > > since 2019, it is quite confused and should correctly reflect=
 hardware
> > > > > > > status in fsl-lx2160a.dtsi.
> > > > > >
> > > > > > This does not begin to explain why removing the soc-specific co=
mpatible,
> > > > > > and instead putting the compatible for another soc is the right=
 fix.
> > > > > > Come up with a new compatible for this device, that perhaps fal=
ls back
> > > > > > to the ls2088a, but this change doesn't seem right to me.
> > > > >
> > > > > It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, =
which are
> > > > > totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pci=
e.
> > > > >
> > > > > Previous dtb can work just because uboot dynamtic change fsl,lx21=
60a-pcie
> > > > > to fsl,ls2088a-pcie when boot kernel.
> > > > >
> > > > > fsl,lx2160a-pcie should be removed because Rev1 have not mass pro=
ductioned.
> > > >
> > > > Please re-read what I wrote. I said to come up with a new compatibl=
e for
> > > > this device, not fall back from the existing fsl,lx2160a-pcie to
> > > > fsl,ls2088a-pcie.
> > >
> > > According to my understand, It needn't add new compatible string if n=
othing
> > > difference. for example, it use fsl,vf610-i2c for all i2c without add
> > > new soc-specific fsl,lx2160-i2c.
> >
> > No, you should have soc-specific compatibles regardless. Just because
> > you got away with it once, doesn't mean I'm not going to complain about
> > it here!
>
> Rob:
>         What's current policy for this? Not only for this one. If new SOC
> appear such as iMX10 (maybe many derived chip i.MX101, i.MX102...), there
> are bunch of IPs, Do we need add fsl,imx10* for everyone, which most part
> is exactly the same as old one and bloat binding doc.

Yes, you do. Do you really know that something in the design hasn't
changed? Have you compared the RTL between the versions? The only way
to deal with quirks without changing the DT everytime is by having
specific compatibles *upfront*.

The "bloat" is never that much because the IP really always changes.
QCom wanted to (and did) use IP version numbers for the same reasons.
Guess what, the IP version number changed on almost every SoC.

The exceptions are really if different SoCs are just different
packaging or fusing.


In this case, I'm inclined to say just match what u-boot creates, but
please make that abundantly clear with a comment in the .dts file and
explain the situation in the commit message. OTOH, just adding a new
"fsl,lx2160a-dw-pcie" compatible with "fsl,ls2088a-pcie" fallback
doesn't hurt, and we can just move on from creating a special case.

Rob

