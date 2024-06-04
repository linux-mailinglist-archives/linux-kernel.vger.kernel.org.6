Return-Path: <linux-kernel+bounces-200524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0148FB140
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30861F22031
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA11459E9;
	Tue,  4 Jun 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="mATr4jO3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="r5qBjm68"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE944145355;
	Tue,  4 Jun 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501134; cv=none; b=JBa0dgBQxD8d9RTYrU/ZfvmOHugPe6iHP9IOdCC/iptkuazgrCRbDLfMlmIuZJSvsUj1iCsTJmaY+kAaHRpbVFfWfZcSSPcaA5r1vVLaFnMcQchIhSqr5IFrvebmEhVSJt+tazqOXtZG7Y5BKBF0+b1n0M+iKVobI0U20ZAYWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501134; c=relaxed/simple;
	bh=s6qioyU4njlSo4EIOtr5CBGBzfDq1zmq6Y1XUhJQ8vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrxmFWDwSbRpChVjD/XNetT4Zk2WrvjTTuTff6xX0VYPyUifaNvkWqtaJaooPbO8f8rVL6DSXbDmULHqL9slsF3NwkOLSp6FmnavX99M89zyvg2e441j8/wYU/MFrKOXbY5P5pgUxshxTq5ujUD84ze5ymDaaX1Dlzf2/pA1szs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=mATr4jO3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=r5qBjm68 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717501131; x=1749037131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YoxkqmfgJqrdmMv5DLLQpdpTV2RJUZno4i80lbGS60s=;
  b=mATr4jO3TVdOLp5QjA9N4l+eKyTxLmWenx2WZsVsdf4RvBlpyxdkGjCE
   bbR7YKDbav7Pxk4hhUUccy5Tstg2ypk2ZNKkIHfxQ1uPUY8OvsMXdLsDR
   2RicLJAqULGzTGpQ066SnrgCH8OdH4tv0tMx+Zq5nIkZN4H1I/CYAUD0x
   QERlHB4zvCiV20UhsNv5eOxmP63eZe7Kzm5swD1rN+7XcrARAp8PJNgq7
   a+YgQCv5CudOJo7oJB8p4veB9oJh2eXek+N4NuBOowu69S4Ait32bHvV1
   mURT6qjEXHXd/d5+wyIe5yogOHYIIqIwlbzbP48gBDRnlxylQincadXBQ
   Q==;
X-CSE-ConnectionGUID: h+LefQ3sTim9ik3KwuncDg==
X-CSE-MsgGUID: 5Gec9Im0QGOZRFKomEOW5A==
X-IronPort-AV: E=Sophos;i="6.08,213,1712613600"; 
   d="scan'208";a="37211903"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Jun 2024 13:38:48 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E313717166C;
	Tue,  4 Jun 2024 13:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717501124;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YoxkqmfgJqrdmMv5DLLQpdpTV2RJUZno4i80lbGS60s=;
	b=r5qBjm685dOtjc6FD4lUdJt7rlTowc5KO+i81zeaMU90LW2v9BDRmTcUe6EGsQMboZAO1u
	55UNFXCiLeqloK0YO3ItfKflWEqSMeW5ubwBOUo84pESALlDkh4b54ZsHYmhRm1DqYXFvI
	Wma5yCg5IHfL2gJ14IDtfRpZmDhcqRMmHEFHEfzgZMiO7YbpxUrEs0VM9M172oNoJ91cdw
	4qUZMzqeY39HKrbSBe9Jn5sNRiv/iY8VXy0I2SPf4h4dO2KannKd6D5oPD7uZtNgHVnOB4
	Ig5+nIbHqi6sP9Mw8ADY/iUtYXCx5iRYJk2z0VLr32gfRPukAODI9dcgXY6cBQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
Date: Tue, 04 Jun 2024 13:38:44 +0200
Message-ID: <8425529.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <87ttiem4de.fsf@geanix.com>
References: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com> <5987259.31r3eYUQgx@steina-w> <87ttiem4de.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

Am Freitag, 31. Mai 2024, 16:40:29 CEST schrieb Esben Haabendal:
> Alexander Stein <alexander.stein@ew.tq-group.com> writes:
>=20
> > Hi Esben,
> >
> > Am Freitag, 31. Mai 2024, 14:20:02 CEST schrieb Esben Haabendal:
> >> Alexander Stein <alexander.stein@ew.tq-group.com> writes:
> >> >> +			brg-frequency =3D <150000000>;
> >> >> +			bus-frequency =3D <300000000>;
> >> >
> >> > Mh, aren't these values depending on your actual RCW configuration?
> >>=20
> >> Yes, you are right. The QE bus-frequency comes from platform_clk which
> >> is controlled by various bits in RCW and sys_ref_clk.
> >>=20
> >> So I guess it should be possible to derive bus-frequency from sysclk
> >> clock-frequency attribute and RCW. But fsl,qe bus-frequency is a
> >> required property...
> >>=20
> >> Max bus-frequency for LS1021A is 300 MHz. But it should be possible to
> >> set it lower, although I suspect that many/most/everyone is running it
> >> at 300 MHz.
> >
> > Thanks for confirmation. I'll let DT maintainer decide how to deal with=
 this.
>=20
> For reference.
>=20
> The existing DTS with fsl,qe have the following bus-frequency property va=
lues:
>=20
> arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:  bus-frequency =3D <20000=
0000>
> arch/powerpc/boot/dts/fsl/mpc8568si-post.dtsi:   bus-frequency =3D <39600=
0000>
> arch/powerpc/boot/dts/fsl/mpc8569si-post.dtsi:   bus-frequency =3D <0>
> arch/powerpc/boot/dts/fsl/p1021si-post.dtsi:     missing!
> arch/powerpc/boot/dts/fsl/t1024si-post.dtsi:     bus-frequency =3D <0>
> arch/powerpc/boot/dts/fsl/t1040si-post.dtsi:     missing!
> arch/powerpc/boot/dts/kmeter1.dts:               bus-frequency =3D <0>
> arch/powerpc/boot/dts/mpc836x_rdk.dts:           bus-frequency =3D <0>
> arch/powerpc/boot/dts/mpc832x_rdb.dts:           bus-frequency =3D <19800=
0000>
>=20
> The 3 non-zero values are most likely also not guaranteed by SoC design
> to always be the right values. But I haven't checked.

PowerPC might be completely different. Apparently that's the way it is
done until now.

> >> >> +			fsl,qe-num-riscs =3D <1>;
> >> >> +			fsl,qe-num-snums =3D <28>;
> >> >
> >> > Current bindings defines:
> >> >> fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
> >> >>   defining the array of serial number (SNUM) values for the virtual
> >> >>   threads.
> >> >
> >> > So '/bits/ 8' is missing.
> >>=20
> >> Ok, so you want me to add an array for fs,qe-snums attribute?
> >> None of the existing fsl,qe devices has a fsl,qe-snums.
> >> And qe_snums_init() has a fallback, so I don't think it is correct to
> >> specify fsl,qe-snums to be a required property in the bindings. It
> >> should be listed as optional.
> >
> > fsl,qe-num-snums is a deprecated property, so IMHO the replacement
> > fsl,qe-snums should be used instead for new device tree entries.
> > qe_snums_init() supporting 'fsl,qe-num-snums' is just to support
> > "legacy bindings" as stated in the comment.
>=20
> Figuring out the correct array values for fsl,qe-snums for ls1021a is
> not so easy. It is not so clear from the reference manual, what it
> should be. And the default array used for fsl,qe-num-snums =3D <28> does
> not look right in any way, but seems to work.
>=20
> It would not feel right to just copy those values and put into DTS, as
> it would imply that the values are truly a correct description for the
> LS1021A hardware.

Maybe copy the currently hardcoded values and add a REVISIT comment or
similar describing these are copied, apparently working, but unverified.

Best regards,
Alexander

> >>=20
> >> >> +			};
> >> >> +
> >> >> +			muram@10000 {
> >> >> +				#address-cells =3D <1>;
> >> >> +				#size-cells =3D <1>;
> >> >> +				compatible =3D "fsl,qe-muram", "fsl,cpm-muram";
> >> >> +				ranges =3D <0x0 0x10000 0x6000>;
> >> >
> >> > Node address but no 'reg' property? I have no idea if this is okay.
> >> > Also compatible (and possibly reg) first.
> >>=20
> >> It is done in the same way for all existing fsl,qe-muram devices. So if
> >> it is not okay, a tree-wide fixup would be in place.
> >
> > I can't finally say if this is okay, but at least the compatible shall =
be
> > listed first.
>=20
> Done.
>=20
> /Esben
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



