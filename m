Return-Path: <linux-kernel+bounces-234212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF091C3CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7528403F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291A1C9ECF;
	Fri, 28 Jun 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r/NdUP1g"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D327713;
	Fri, 28 Jun 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592574; cv=none; b=C9XyeLT3IG8CLooAPAAwP4xcyLjNERhwb7vbS7C9THauRIgOG91ZPKJcz0fFbYY3bN8NJWeIN4dts0667jhp9SbblWa5AeV0Tmo9ZrGoTSkyUo4Kl4nccorvdkl1BEKRIuGFxBxZ1HSwMe5qDAqLmBfyVfTsRwsB3GnbKGrjKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592574; c=relaxed/simple;
	bh=/52/WLbssjzaYP3luUHq6mcVPe7d0kKFMpPOqcGB31k=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=KMSuZ02LmmqXZK4Df+nX4fwCgHcGAwbherYf8IkjDVb9fTGBtX3P7xA6bSYdA5wRf7LZNuCm5OoilFtTPAlgQoDhlH3M6L5I+HkzAxP4QBBic6a/vD2h7fBgxuml6VTwzBSlgFwJ3DrZJNz5oa5oDe7UDjybum/A+0eyawDQU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r/NdUP1g; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SGZwWA084301;
	Fri, 28 Jun 2024 11:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719592558;
	bh=/52/WLbssjzaYP3luUHq6mcVPe7d0kKFMpPOqcGB31k=;
	h=Date:CC:Subject:From:To:References:In-Reply-To;
	b=r/NdUP1g971HvB1ie9Xd06teUJiN22MzVCuCGuY+oOBpr/rQGv4C//Kna1WHbLX3K
	 NChYaJWbp436nKG54rKg03h302tK+p4KAf+XkMX9F4gPCa6tDjbZQ80y/pOOJo01qQ
	 C6Un7XNN+jTuk2LPu/urEKLGi+vaGkoZu1j6EAcU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SGZwq2099079
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 11:35:58 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 11:35:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 11:35:58 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SGZwrZ084049;
	Fri, 28 Jun 2024 11:35:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 28 Jun 2024 11:35:58 -0500
Message-ID: <D2BSORIL5C7T.3B8EAANVQ7TX5@ti.com>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, "Khasim, Syed Mohammed" <khasim@ti.com>
Subject: Re: [PATCH 0/3] Add global CMA reserve area
From: Randolph Sapp <rs@ti.com>
To: Devarsh Thakkar <devarsht@ti.com>, Andrew Davis <afd@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240613150902.2173582-1-devarsht@ti.com>
 <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
 <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
 <64b78ba2-776c-1de6-4c13-001d11000ff0@ti.com>
In-Reply-To: <64b78ba2-776c-1de6-4c13-001d11000ff0@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri Jun 28, 2024 at 10:57 AM CDT, Devarsh Thakkar wrote:
> Hi Andrew, Vignesh,
>
> On 24/06/24 22:03, Andrew Davis wrote:
> > On 6/14/24 12:58 PM, Randolph Sapp wrote:
> >> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
> >>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
> >>> These SoCs do not have MMU and hence require contiguous memory pool t=
o
> >>> support various multimedia use-cases.
> >>>
> >>> Brandon Brnich (1):
> >>> =C2=A0=C2=A0 arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global =
CMA
> >>>
> >>> Devarsh Thakkar (2):
> >>> =C2=A0=C2=A0 arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of gl=
obal CMA
> >>> =C2=A0=C2=A0 arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global C=
MA
> >>>
> >>> =C2=A0 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 9 +++++++++
> >>> =C2=A0 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
> >>> =C2=A0 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
> >>> =C2=A0 3 files changed, 24 insertions(+)
> >>
> >> I'm still a little torn about putting this allocation into the device =
tree
> >> directly as the actual required allocation size depends on the task.
> >>
> >=20
> > That is the exact reason this does not belong in DT. For everyone *not*
> > using the most extreme case (12x decodes at the same time), this is
> > all wasted space. If one is running out of CMA, they can add more on
> > the kernel cmdline.
> >=20
>
> I disagree with this. The 12x decode for 480p is not an extreme use-case =
this
> is something VPU is capable to run at optimum frame-rate (12x 1080p it ca=
n't)
> and as the AM62A7 is meant to be AI + multimedia centric device, per the
> device definition we were given the requirements to support a list of
> multimedia use-cases which should work out of box and 12x decode for 480p=
 was
> one of them as device is very much capable of doing that with optimum
> performance and I don't think it is right to change these requirements on=
 the fly.
>
> The AM62A7 board has 4 GiB of DDR and we have been using this CMA value s=
ince
> more than a year, I have never heard anyone complain about out of memory =
or
> CMA starvation and it suffices to requirements of *most use-cases*, but i=
f for
> some specific use-case it doesn't suffice, user can change it via kernel =
cmdline.
>
> The kernelcmdline suggestion doesn't suffice out of box experience requir=
ed,
> we don't want to ask the user to reboot the board everytime they run out =
of CMA.
>
>
> >> If it's allowed though, this series is fine for introducing those chan=
ges. This
> >> uses the long-tested values we've been using on our tree for a bit now=
. The
> >> only
> >> thing that's a little worrying is the missing range definitions for de=
vices
> >> with
> >> more than 32bits of addressable memory as Brandon has pointed out. Onc=
e that's
> >> addressed:
> >>
> >> Reviewed-by: Randolph Sapp <rs@ti.com>
> >>
> >> Specifying these regions using the kernel cmdline parameter via u-boot=
 was
> >> brought up as a potential workaround. This is fine until you get into =
distro
> >> boot methods which will almost certainly attempt to override those. I =
don't
> >> know. Still a little odd. Curious how the community feels about it.
> >>
> >> Technically the user or distro can still override it with the cmdline =
parameter
> >> if necessary, so this may be the best way to have a useful default.
> >>
> >=20
>
> Unlike above, this solution is independent of distro as it should be as w=
e
> want that all the supported multimedia use-cases should work out of box. =
This
> solution is nothing illegal as CMA region carveouts are not a kernel
> deprecated feature.

Right. I support this change for at least introducing a usable default. 32M=
 of
CMA is barely enough to run glmark2 under Weston once everything's up and
running.

As I said before, the user or distro can still override the dt CMA block wi=
th
the cma kernel parameter if they aren't happy with the default block.
Unfortunately this is about the only way to have a usable default value to =
fall
back on.

> > The most useful default is one that doesn't eat 576 MiB of memory "just=
 in case".
> > Needing that much CMA is the exception case and should be the one that =
requires
> > adding something to the kernel cmdline.
> >=20
>
> I disagree with this, I would have agreed if this point was made in conte=
xt of
> generic device, but we are forgetting here that AM62A7 is a AI+multimedia
> centric device and customers expect multimedia use-cases to work out of b=
ox.
>
> We have 4 GiB RAM and if carving out 576 MiB is helping achieve all major
> multimedia use-cases then what's the problem ? What exactly is failing fo=
r you
> ? If some specific scenarios are getting hurt then in that case overlays =
or
> kernel cmdline option can be used to override the cma.
>
> I feel we are over-complicating things here and going back-and-forth each
> cycle even though there are no competing alternatives present today.
> And this blocks out of box experience, as today even the basic HDMI and G=
PU
> use-cases don't work out of box.
>
> I had also discussed around this with community on last OSS summit as
> discussed here [1] were it was suggested too to use this solution as adop=
ted
> by other vendors.
>
> [1]: https://lore.kernel.org/all/0eee0424-f177-808f-3a86-499443155ddb@ti.=
com/
>
> Regards
> Devarsh

If the community accepts it, it's fine by me.

- Randolph

