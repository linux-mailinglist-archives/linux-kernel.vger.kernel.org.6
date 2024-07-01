Return-Path: <linux-kernel+bounces-236816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7F91E766
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617A81C21B13
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8916EC0F;
	Mon,  1 Jul 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Uc5hw9TL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A84206C;
	Mon,  1 Jul 2024 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858389; cv=none; b=qY4a3TomwZbLHuCgF34B9r5wTXfS2vggHvKXaevbVKjnHXYgv5Gx3OyJjrj+IQXH2I83aGaqSVpTlXwcigDdjhFBpZj4zkOKVPq+7za2b243oAO1GSWRgcjDZuFyJQXIDvaFhnpcERLpjYQ3yUJ/HhxC5QLdxUPwwlJG3HGxXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858389; c=relaxed/simple;
	bh=eJuTrf0oLJxZyj0FJqRF/6p6IZeg+srqP1FrZsdO7Q8=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:Subject:From:To:
	 References:In-Reply-To; b=BE9Aj03HosIM31RW+tvkH9CExX0lde5S1om91+NGoyvCfiHZ3PFV6SZNToCyqWyPiTdFo09IMPn1ZdbmL4FkUsXR8BcQpfQiupL62qDqhrUEXnOIlRnssvtdpt+BB1ivdaEQMYY45oXq5dWBZpo7e03zSCqAI1KVxzU6F8EFYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Uc5hw9TL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461IQG9b033443;
	Mon, 1 Jul 2024 13:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719858376;
	bh=OTJBK/eXTcbCUlw13jrhouc45oqruLOebA3Tdbxp8MU=;
	h=Date:CC:Subject:From:To:References:In-Reply-To;
	b=Uc5hw9TL2yMsW1KDXtOSuNJcTMz6fjJwhzB+cQieBsVQniGiVXovoHeYlQukomA9Q
	 QEl5X14IQWj/0Z87a6ikTlc4RraEtTN9PTAIAoT/MGSnOzKx40XKTRhMxTCul+wkjU
	 EYm1yTUUpuN613GEVhfG5CZTM+VpYKdaGPu0P80s=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461IQG8E056592
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 13:26:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 13:26:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 13:26:16 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461IQG2Q073831;
	Mon, 1 Jul 2024 13:26:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 1 Jul 2024 13:26:16 -0500
Message-ID: <D2EEWUPE9RAG.26DDBH0DK0OP7@ti.com>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, "Khasim, Syed Mohammed" <khasim@ti.com>
Subject: Re: [PATCH 0/3] Add global CMA reserve area
From: Randolph Sapp <rs@ti.com>
To: Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240613150902.2173582-1-devarsht@ti.com>
 <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
 <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
 <64b78ba2-776c-1de6-4c13-001d11000ff0@ti.com>
 <D2BSORIL5C7T.3B8EAANVQ7TX5@ti.com>
 <0ca809d0-3d0f-47d1-b5e7-aa78d65d7917@ti.com>
 <2f1f25b5-86c1-4a60-8f71-519658d5f88a@ti.com>
In-Reply-To: <2f1f25b5-86c1-4a60-8f71-519658d5f88a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon Jul 1, 2024 at 9:33 AM CDT, Andrew Davis wrote:
> On 6/30/24 2:09 AM, Vignesh Raghavendra wrote:
> >=20
> >=20
> > On 28/06/24 22:05, Randolph Sapp wrote:
> >> On Fri Jun 28, 2024 at 10:57 AM CDT, Devarsh Thakkar wrote:
> >>> Hi Andrew, Vignesh,
> >>>
> >>> On 24/06/24 22:03, Andrew Davis wrote:
> >>>> On 6/14/24 12:58 PM, Randolph Sapp wrote:
> >>>>> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
> >>>>>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
> >>>>>> These SoCs do not have MMU and hence require contiguous memory poo=
l to
> >>>>>> support various multimedia use-cases.
> >>>>>>
> >>>>>> Brandon Brnich (1):
> >>>>>>  =C2=A0=C2=A0 arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of glo=
bal CMA
> >>>>>>
> >>>>>> Devarsh Thakkar (2):
> >>>>>>  =C2=A0=C2=A0 arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB o=
f global CMA
> >>>>>>  =C2=A0=C2=A0 arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of glob=
al CMA
> >>>>>>
> >>>>>>  =C2=A0 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++++++
> >>>>>>  =C2=A0 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
> >>>>>>  =C2=A0 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 +++++++=
+
> >>>>>>  =C2=A0 3 files changed, 24 insertions(+)
> >>>>>
> >>>>> I'm still a little torn about putting this allocation into the devi=
ce tree
> >>>>> directly as the actual required allocation size depends on the task=
.
> >>>>>
> >>>>
> >>>> That is the exact reason this does not belong in DT. For everyone *n=
ot*
> >>>> using the most extreme case (12x decodes at the same time), this is
> >>>> all wasted space. If one is running out of CMA, they can add more on
> >>>> the kernel cmdline.
> >>>>
> >>>
> >>> I disagree with this. The 12x decode for 480p is not an extreme use-c=
ase this
> >>> is something VPU is capable to run at optimum frame-rate (12x 1080p i=
t can't)
> >>> and as the AM62A7 is meant to be AI + multimedia centric device, per =
the
> >>> device definition we were given the requirements to support a list of
> >>> multimedia use-cases which should work out of box and 12x decode for =
480p was
> >>> one of them as device is very much capable of doing that with optimum
> >>> performance and I don't think it is right to change these requirement=
s on the fly.
> >>>
> >>> The AM62A7 board has 4 GiB of DDR and we have been using this CMA val=
ue since
> >>> more than a year, I have never heard anyone complain about out of mem=
ory or
> >>> CMA starvation and it suffices to requirements of *most use-cases*, b=
ut if for
> >>> some specific use-case it doesn't suffice, user can change it via ker=
nel cmdline.
> >>>
> >>> The kernelcmdline suggestion doesn't suffice out of box experience re=
quired,
> >>> we don't want to ask the user to reboot the board everytime they run =
out of CMA.
> >>>
> >>>
> >>>>> If it's allowed though, this series is fine for introducing those c=
hanges. This
> >>>>> uses the long-tested values we've been using on our tree for a bit =
now. The
> >>>>> only
> >>>>> thing that's a little worrying is the missing range definitions for=
 devices
> >>>>> with
> >>>>> more than 32bits of addressable memory as Brandon has pointed out. =
Once that's
> >>>>> addressed:
> >>>>>
> >>>>> Reviewed-by: Randolph Sapp <rs@ti.com>
> >>>>>
> >>>>> Specifying these regions using the kernel cmdline parameter via u-b=
oot was
> >>>>> brought up as a potential workaround. This is fine until you get in=
to distro
> >>>>> boot methods which will almost certainly attempt to override those.=
 I don't
> >>>>> know. Still a little odd. Curious how the community feels about it.
> >>>>>
> >>>>> Technically the user or distro can still override it with the cmdli=
ne parameter
> >>>>> if necessary, so this may be the best way to have a useful default.
> >>>>>
> >>>>
> >>>
> >>> Unlike above, this solution is independent of distro as it should be =
as we
> >>> want that all the supported multimedia use-cases should work out of b=
ox. This
> >>> solution is nothing illegal as CMA region carveouts are not a kernel
> >>> deprecated feature.
> >>
> >> Right. I support this change for at least introducing a usable default=
. 32M of
> >> CMA is barely enough to run glmark2 under Weston once everything's up =
and
> >> running.
> >>
> >> As I said before, the user or distro can still override the dt CMA blo=
ck with
> >> the cma kernel parameter if they aren't happy with the default block.
> >> Unfortunately this is about the only way to have a usable default valu=
e to fall
> >> back on.
> >>
> >=20
> >=20
> > Given the number of SoMs and non TI EVMs that are about to come out wit=
h
> > AM62A/P and AM67s, we need to provide a consistent way of being able to
> > support multimedia IPs out of the box. Modifying cmdline may not always
> > be feasible given distro defaults don't always provide a way to do so.
> >=20
>
> We need to keep thinking then. I empathize with desire to put
> configuration in Device Tree. DT feels like a great spot for it,
> it is ubiquitous on these boards and has a good bit of tooling around
> it. We are already describing the hardware, why not configure it here
> too? But the reason we do not want to go down that road is simple:
> DT takes away use-case flexibility. A lack of flexibility is fine for
> hardware which is unchanging, but not for configuration.

I agree with the sentiment here, but this explicit case is an exception. Th=
is is
no more than a default value. Userspace can still change this allocation wi=
th
the kernel cma parameter. That still takes precedence.

> Device policy and configuration must be left to userspace.
>
> It is not for us to decide how folks should use our hardware, and
> that is what we are doing when we configure it in DT.
>
> For configuration that must happen in early boot before userspace is
> available (such as kernel stdout and memory carveouts) we have the
> kernel cmdline. If we find something that cannot be done today though
> the cmdline, then we should add that support to the cmdline, not
> give up and just hide the configuration in DT.
>
> What this series does is already available on the kernel cmdline.
> Our bootloader can provide sane defaults on the cmdline today.
> If the worry is that distros will override this default then
> go fix those distros.

Our bootloaders doing anything to kernel cmdline parameters is inherently
non-standard. You just brought up userspace control. They clobber cmdline
parameters all the time. Unsetting this bootloader value will be the first =
thing
they do. This will be done passively, since they normally inject a new
intermediary boot stage that they can actually control between u-boot and t=
heir
kernel.

- Randolph

> > So I am inclined to queue first 2 patches unless there is another way t
> > achieve this.
> >=20
>
> Our lack of creativity in finding better solutions to this issue is
> not an excuse to add more junk to DT..
>
> Andrew
>
> > [...]
> >=20


