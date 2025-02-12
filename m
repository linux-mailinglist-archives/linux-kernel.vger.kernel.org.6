Return-Path: <linux-kernel+bounces-510694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B9A320A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002453A5E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E0204C3B;
	Wed, 12 Feb 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RbWHpu60";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f8FcOgzt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE222046BD;
	Wed, 12 Feb 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347873; cv=none; b=ZJWxhag1AtNCl8B/tjimmy5to/AzCBDeYxIQQpT3cgTQ27hn3B9Zc/PcCTJ9qLd4Yy/iSq2JPIKS1jhbRCsUQwNdlpeiWEB6klYjH9OSuxPCgyj7kihctPUEIE597CUUUpeHtFQNMO/YFt8CfPw8U5SJriqDA+lU+ZrRERARE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347873; c=relaxed/simple;
	bh=KHu1LdPZoLMMLxxmSOmSC9NR1LGDoVJ+Fu6Ve5qXRFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRHEd2Ow41FEkTjIenzW51Yni1uLjFaJZjN1MTt5ythLEBd51L73f3eSufZpcLzJ9Ik2CIRgMq4YE9kjz5kOvMK++wr8fvM+EsIqZdJmLB41Gree7UCJ0cJtbisuD6BN/c7pmgnsNLdf3s/IbzeYSkq2XbyT8nee9cZ2dBbiaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RbWHpu60; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f8FcOgzt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739347869; x=1770883869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ebrh2pOj9a+WCHOfQy3AldxKt0RQJILfJP7w8ELhKWs=;
  b=RbWHpu606HdXmJ61sRtYN50snFrkOys6KiHMu5tniiFHbV7J0hWnA8jT
   HDOvQwGaycSkJes2Rr0+HSy2QUrPwpkKMFLrEGYtrCWiB7W1YnioNyoaD
   SYrS2oN/EWNzB4G9xMp/NOl7IXz5Z2IGxI8YCcqceS1KLH3jDOpwc1RXy
   JaEpzr/Eb6XsJq3oHdNgaNbupiQyplzcDlFwH140VPF+68axcwR6bh3XJ
   Y3HitUQr9kcgdc+HCrGbLsIBzfnzXx2qImd9EEJ1mWAii/+FlloXWyw93
   X7eHJlkajJsFGyqmk2dQQtot0RhIis4t8vftsMATiAmyuJS8vQmSFvKXc
   Q==;
X-CSE-ConnectionGUID: jp/xOS/UTUmFNhbEqlMSOg==
X-CSE-MsgGUID: IFthUYPIQ0O5JgMafUVjGw==
X-IronPort-AV: E=Sophos;i="6.13,279,1732575600"; 
   d="scan'208";a="41778546"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Feb 2025 09:11:00 +0100
X-CheckPoint: {67AC5794-B-C21CC984-D1047F1F}
X-MAIL-CPID: 70FDB8AC22B42A0ACE772440BDA64D6F_5
X-Control-Analysis: str=0001.0A00636F.67AC5794.00CB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09E9016A031;
	Wed, 12 Feb 2025 09:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739347855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ebrh2pOj9a+WCHOfQy3AldxKt0RQJILfJP7w8ELhKWs=;
	b=f8FcOgztq6fes3vM/7CvY2rSKSKOMniJdix9XndFkfY8RpufORB/SLLs+nI2s41/ZQCu/X
	yqni/qQKcZAo010dcy/NUnvTPHKNeam83NjIoojMkIVhNDGltYI/emrhg0ODzfsGML8Kh6
	0BwTljpycstH0lQYYyp8bp/rUBd3SqaHkFN3t5CJrwpfw7/X1XDuD7RasNQWTuZvUNX8CS
	MgNLRwSIOQZJ1iSHhPGZ/gLmcTdi/o7spHz8fvL/bQI0J5rwkiYczQMBkjewlYWoPJ/Gjv
	84qK0gBDf7e8bS1+Omt288PbcPWN97XySBTm3NItO0vbkbFtwrHbCsX74vqwrQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-controller references
Date: Wed, 12 Feb 2025 09:10:53 +0100
Message-ID: <10618164.nUPlyArG6x@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250211033340.GA13109@localhost.localdomain>
References: <20250207083616.1442887-1-alexander.stein@ew.tq-group.com> <2222299.irdbgypaU6@steina-w> <20250211033340.GA13109@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 11. Februar 2025, 04:33:41 CET schrieb Peng Fan:
>=20
> On Mon, Feb 10, 2025 at 04:48:56PM +0100, Alexander Stein wrote:
> >Am Montag, 10. Februar 2025, 03:36:48 CET schrieb Peng Fan:
> >> > Subject: Re: [PATCH v2 04/10] arm64: dts: imx8mn: Add access-
> >> > controller references
> >> >=20
> >> > Hi Peng,
> >> >=20
> >> > Am Freitag, 7. Februar 2025, 13:02:13 CET schrieb Peng Fan:
> >> > > On Fri, Feb 07, 2025 at 09:36:09AM +0100, Alexander Stein wrote:
> >> > > >Mark ocotp as a access-controller and add references on periphera=
ls
> >> > > >which can be disabled (fused).
> >> > >
> >> > > I am not sure whether gpcv2 changes should be included in this
> >> > > patchset or not. Just add access-controller for fused IP will not =
work.
> >> >=20
> >> > Well, I was able to successfully boot a i.MX8M Nano DualLite.
> >> >=20
> >> > > i.MX8M BLK-CTRL/GPC will hang if the related power domain is still
> >> > > touched by kernel. The pgc can't power up/down because clock is
> >> > gated.
> >> >=20
> >> > Well, with GPU node disabled, no one should enable the power domain.
> >> > But to be on the safe side I would also add access-controllers to the
> >> > corresponding power domains as well.
> >> >=20
> >> > > This comment also apply to i.MX8MM/P.
> >> >=20
> >> > Sure. Do you have any information what is actually disabled by those
> >> > fused?
> >> > It seems it's the IP and their power domains. Anything else?
> >>=20
> >> In NXP downstream there is a patch for  drivers/pmdomain/imx/imx8m-blk=
=2Dctrl.c
> >>=20
> >> soc: imx8m-blk-ctrl: Support fused modules
> >>    =20
> >>     For fused module, its pgc can't power up/down and clock is gated.
> >>     Because imx8m-blk-ctrl driver will pm_runtime_get_sync/pm_runtime_=
put
> >>     all power domains during suspend/resume. So we have to remove the
> >>     pgc and clock of fused module from blk-ctrl DTS node.
> >>     Update the driver to support such case.
> >>=20
> >> But this patch also needs U-Boot to update device tree nodes,
> >> I recalled that U-Boot will remove gpc nodes, but not update blk-ctrl =
nodes.
> >
> >Does it work, if we add the access-controller as well for pgc_gpu3d
> >on imx8mp? There is nothing in blk-ctrl AFAICS. But for VPU there is.
>=20
> Adding access-controller under pgc_gpu node will not make fwdevlink
> work for the pgc_gpu nodes. It does not have compatible, and device
> is created by gpcv2 driver using platform_device_alloc. Same to vpu.
>=20
> >Which clock needs to be removed there in case g1 is disabled?
>=20
> Take i.MX8MP VC8000E as example, the vpumix blk ctrl, the vc8000e
> reference under vpumix blkctrl should be removed, including pd and clock.

Wait, so you want to remove the last entry from these properties?

> clocks =3D <&clk IMX8MP_CLK_VPU_G1_ROOT>,
> 	 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
> 	 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
> clock-names =3D "g1", "g2", "vc8000e";

This violates the DT binding.

> So for non-blkctrl nodes, it is fine to use access-controller and rely
> on fwdelink to defer probe. But for blk ctrl nodes, it will not work.
>=20
> For pgc nodes, it may or may not matter, not very sure for now.
>=20
> For blk ctrl nodes, we need provide a generic API saying
> access_control_check or directly using nvmem API.

Reading access-controllers.yaml this should still be feasible for
providing the necessary information.
But I'm note sure where to implement this. In e.g. imx-ocotp would be a very
SoC-specific API.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



