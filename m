Return-Path: <linux-kernel+bounces-538880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A430FA49E35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD30F3B18B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA11A191F89;
	Fri, 28 Feb 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Pcn4ev8w";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Yzq42jmF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8F1EF37E;
	Fri, 28 Feb 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758493; cv=none; b=Yegbsk2GFjZTgWszCaBu5uKChePnLWoxl7E9+YvuOlt/MZ28/X+xxDpWHCBxJdvmaDs58mceuB/vB0SFd6+0oz+DywjlCbjTK9JBovXbS7WjpN817HEBAtaeXMYVZlXdgqyjXzUsauaS3PEzlhO1KV5iFZZMVlaTIfpzoH76Ya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758493; c=relaxed/simple;
	bh=QemeSi9mTrqmmZbQ6ksZ9XBzqSmq2ooYNed+gSYg5R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJnezFRONtG/UGhmR4TduLoyvh5p7xISFCXf8sb4i6xT4psA1KONXIJGulpdXDinMQFagoH7hWdMOzDwZRGesdDAnSueacddP0gAEoqSZ/g94FTxP+mUgX82BF1vlGXUeIHXQGqi3MZM80WVjM61C9OCN75/Oh1b5PJXVEdsQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Pcn4ev8w; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Yzq42jmF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740758490; x=1772294490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEN9N+xKBX/C8w3WcwlKzPTpb6+Twn8dMh4CDAQ6Eww=;
  b=Pcn4ev8wU/vURGyB1/DchiAwn9FM92JhAkM5SQRkcuYT2MylSF4jPStB
   OZDwzRV5PFQS13QqEL/srtJSluEcXGeq3bwmdj2Bu1p3G07JDsRQ9Zims
   G95zI4k0Xzl+PKZgU8PHGaEBQW3thqaxP0J4Yry5R0OKUkgyMg43ivfUR
   B0wbpgxXFSE/6TOxuddn3P3j96jTeWvz7rcLEyxU7NG2LTpPzXgYYAbkZ
   zShcvciKh9BsSUAEiop0mE2arCl1qMUqXXsNUyRsee5I7PFNT8rXDooeC
   +C3HL230t3vt6GSSFXpEa4ACRmmGikNvKfQC72Fb9j7vS5pdX2DOeJFmE
   A==;
X-CSE-ConnectionGUID: z38Nd0JmQu6yzbirgsyl4A==
X-CSE-MsgGUID: 73rRz4x+Tby7mTs21ChdyA==
X-IronPort-AV: E=Sophos;i="6.13,322,1732575600"; 
   d="scan'208";a="42178670"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Feb 2025 17:01:21 +0100
X-CheckPoint: {67C1DDD0-F-97089932-E672704E}
X-MAIL-CPID: A9348A422528F1A28B432AB2F20B25A5_3
X-Control-Analysis: str=0001.0A002114.67C1DDD1.007D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2591164A39;
	Fri, 28 Feb 2025 17:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740758476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEN9N+xKBX/C8w3WcwlKzPTpb6+Twn8dMh4CDAQ6Eww=;
	b=Yzq42jmFwYn+/mjhFdW6WIRQLKyNOwl1iw9LtryqJ5yRA0P3LrbCIPou71/BNBpC2/Belf
	PJe0QXNY8o7xSA96MWCcA7Sgn1jBDKAEYfF6hZeF9u/hMEG3FIhzarLGqiWy/wQSH48DQj
	f4K8VuDJhQwFjARhwvdRhiagCSnpZcj5exUn/zpROugrlLyQdsG+py2A/wafGy0zkvrqm1
	l/iCLOixXz1CowajQMYmEjoXjtOujyWIrDMo5obfm2GZCh/k/+PDnMBtTR9etIYbzXl3eK
	nhBhWgD+P6P1ORZSrurkWE3nznHeo3hqQtCvvJv3/2GGoc/GAp+eHJBE1jRwhQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, hongxing.zhu@nxp.com
Subject:
 Re: [PATCH 4/5] arm64: dts: imx95: add PCIe's msi-map and iommu-map property
Date: Fri, 28 Feb 2025 17:01:15 +0100
Message-ID: <3661300.LM0AJKV5NW@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Z8HXIvAZcvNY72Jx@lizhi-Precision-Tower-5810>
References:
 <20250128211559.1582598-1-Frank.Li@nxp.com> <47051102.fMDQidcC6G@steina-w>
 <Z8HXIvAZcvNY72Jx@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Freitag, 28. Februar 2025, 16:32:50 CET schrieb Frank Li:
> On Fri, Feb 28, 2025 at 10:08:58AM +0100, Alexander Stein wrote:
> > Hi Frank,
> >
> > Am Donnerstag, 27. Februar 2025, 17:39:47 CET schrieb Frank Li:
> > > On Thu, Feb 27, 2025 at 08:54:13AM +0100, Alexander Stein wrote:
> > > > Hi Frank,
> > > >
> > > > Am Mittwoch, 26. Februar 2025, 17:31:26 CET schrieb Frank Li:
> > > > > On Wed, Feb 26, 2025 at 01:11:37PM +0100, Alexander Stein wrote:
> > > > > > Hi Frank,
> > > > > >
> > > > > > Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> > > > > > > Add PCIe's msi-map and iommu-map property because i.MX95 supp=
ort smmu and
> > > > > > > its.
> > > > > > >
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
> > > > > > >  1 file changed, 14 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/=
arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > index 6b8470cb3461a..2cebeda43a52d 100644
> > > > > > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > > > > @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
> > > > > > >  			assigned-clock-parents =3D <0>, <0>,
> > > > > > >  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > > > > > >  			power-domains =3D <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > > > > > > +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) i=
s 0x10~0x17 */
> > > > > > > +			msi-map =3D <0x0 &its 0x10 0x1>,
> > > > > > > +				  <0x100 &its 0x11 0x7>;
> > > > > >
> > > > > > Aren't you missing msi-map-mask =3D <0x1ff>; here? Similar to p=
cie1.
> > > > > > Either way, with this change PCIe on pcie0 is not working anymo=
re,
> > > > > > regardless of msi-map-mask.
> > > > >
> > > > > Yes, it should have msi-map-mask. During my test, I have not enab=
le enetc
> > > > > so I have not found this problem.
> > > >
> > > > Just to be clear: This is not about enetc. This works fine here.
> > > >
> > > > > > Without msi-map-mask:
> > > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-ba=
se: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 o=
n (null)
> > > > > > > r8169 0000:03:00.0: error -EINVAL: enable failure
> > > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error=
 -22
> > > > > >
> > > > > > With msi-map-mask:
> > > > > > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-ba=
se: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base=
: 00000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error=
 -5
> > > > >
> > > > > Can you try remove iommu-map and keep msi-map? then remove msi-ma=
p and
> > > > > keep iommu-map to check which one cause this problem.
> > > >
> > > > With only msi-map removed, but smmu enabled:
> > > > > arm-smmu-v3 490d0000.iommu: event 0x10 received:
> > > > > arm-smmu-v3 490d0000.iommu:      0x0000001100000010
> > > > > arm-smmu-v3 490d0000.iommu:      0x0000020a00000000
> > > > > arm-smmu-v3 490d0000.iommu:      0x000000009b0cc000
> > > > > arm-smmu-v3 490d0000.iommu:      0x0000000000000000
> > > > > arm-smmu-v3 490d0000.iommu: event: F_TRANSLATION client: 0000:01:=
00.0 sid: 0x11 ssid: 0x0 iova: 0x9b0cc000 ipa: 0x0
> > > > > arm-smmu-v3 490d0000.iommu: priv data read s1 "Input address caus=
ed fault" stag: 0x0 r8169 0000:03:00.0
> > > > > enp3s0: Link is Down
> > > >
> > > > With only iommu-map removed, both smmu enabled or disabled:
> > > > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00=
000100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
> > > >
> > > > Only if smmu is disabled and msi-map is removed the driver probes
> > > > successfully:
> > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4=
c0, IRQ 160
> > > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx c=
hecksumming: ko]
> > > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > > r8169 0000:03:00.0: enabling bus mastering
> > > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > > >
> > > > > >
> > > > > > Without msi-map/iommu-map:
> > > > > > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > > > > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > > > > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, X=
ID 4c0, IRQ 166
> > > > > > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, =
tx checksumming: ko]
> > > > > > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > > > > > r8169 0000:03:00.0: enabling bus mastering
> > > > > > > r8169 0000:03:00.0 enp3s0: Link is Down
> > > > > >
> > > > > > pcie1 works as expected. But this is only a single PCIe device,=
 rather than
> > > > > > having a PCIe bridge.
> > > > > > Any idea what's wrong here?
> > > > >
> > > > > Can you help dump more information at for PCIe bridge case:
> > > > >
> > > > > imx_pcie_add_lut(), need rid and sid information.
> > > > > drivers/pci/controller/dwc/pci-imx6.c
> > > >
> > > > Just to be clear, without msi-map and iommu-map I get:
> > > > > imx6q-pcie 4c380000.pcie: rid: 0x0, sid: 0x18
> > > > > imx6q-pcie 4c380000.pcie: rid: 0x100, sid: 0x19
> > >
> > > Can you help dump register value PE0_LUT_CREQID offset 0x101 for your
> > > smmu-map or msi-map enable case
> >
> > I am assuming you meant offset 0x101c, as stated in the RM.
> > I added a dump directly before printing "PCI read failed" in r8169_main=
=2Ec.
>=20
> Can you point me the code about where "error -EIO: PCI read failed"?

The error messages comes from [1]. As far as I can tell, this is the first
read after pcim_iomap_table().

> I tested nvme devices worked at both PCIE0 and PCIE1.
>=20
> Which PCI switch do you use?

This is a COTS MiniPCIe ethernet card [2]. If I'm reading correctly
the bridge seems to be a P17C9X20

Thanks and best regards
Alexander

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/tree/drivers/net/ethernet/realtek/r8169_main.c?h=3Dnext-20250228#n5454
[2] https://www.delock.com/produkt/95237/merkmale.html?f=3Ds
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



