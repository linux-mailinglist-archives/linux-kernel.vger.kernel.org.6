Return-Path: <linux-kernel+bounces-239683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A439263F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B11F2279F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802A17D8A6;
	Wed,  3 Jul 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZXue8dpz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2917B401
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018542; cv=none; b=KFkNpmOs0dHSD2aeuTkmxNgGgcuV00XWC85F4jx95xUPHHVohxDHP5Kd36MDtLVCdV0q6v6XWCc4tP9HKmUYgmuuVinbYX+3iMqAhvvK56DAHkLR31p5ZAbavK4yE7PtjqQGpW/YG2/183bjQlYQAmyTdN71z4pwvqPl9/IXbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018542; c=relaxed/simple;
	bh=cRYZ45OF53fIrCFZk+IUAjejhzMX236LoAYLsLRpLZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuQIUuIyCv256SPGau1HXQxl5HuL8ghQ8LnZ/U9u3wE+kmyjuZ6c/1lZRu/ozg7SHcjAyTv68qDsFHf9CL/dg+BOGS5VM/LveM2NaE9slYYMZABIh9QoCdIPywf2hhoJ9dLvnypgjSbHPSTfWSpFtDGmQ6nL9+OK+63kPQ/cIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZXue8dpz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4973240005;
	Wed,  3 Jul 2024 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720018537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRYZ45OF53fIrCFZk+IUAjejhzMX236LoAYLsLRpLZk=;
	b=ZXue8dpzx9QdMyd8LRoQUb/7UbyLfMrk+hX3cf1A0pyQAyFBwnsgQKAre+XaulYP2oKdhM
	Qmr7nTOzM9UUTdkmUSw1tD7AolEcBzH3QSwGHX/ZCUFPWOyR77D7TDIrsQLORP21I/KUzx
	f6SUIdob4e14/NjRLmC7N667Px6Vi0p9KAy4SJtIOuUs4SqzBVrnxhy5aYJMvUbPa0mjrl
	MxR80FL/+pOoHz9etBHoWM2GTiu0ezQ8prsIeDdjDQQzM4EJOD0VK4DSsbhcxGHdiTQRoF
	XwIIbww8P7cLaJBqlP5zTv1f0fpVFNdUbGTwACkvdKKgni0kQqKsMfUbKGrhtg==
Date: Wed, 3 Jul 2024 16:55:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Greg Ungerer <gerg@kernel.org>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Stefan Agner <stefan@agner.ch>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arch: m68k: Add definitions for flash NFC
 support
Message-ID: <20240703165534.699d238a@xps-13>
In-Reply-To: <a9c34972-a933-49f4-98e4-cbcc321022e2@kernel.org>
References: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
	<20240627-upstream-nfc-mcf5441x-v2-1-312929d09ee5@yoseli.org>
	<20240628094511.75cc9c78@xps-13>
	<b974df45-daf5-4156-8532-cf9e2be8bdfa@yoseli.org>
	<a9c34972-a933-49f4-98e4-cbcc321022e2@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Greg,

gerg@kernel.org wrote on Wed, 3 Jul 2024 23:30:09 +1000:

> On 3/7/24 02:44, Jean-Michel Hautbois wrote:
> > Hi Miquel,
> >=20
> > On 28/06/2024 09:45, Miquel Raynal wrote: =20
> >> Hi Jean-Michel & Geert,
> >>
> >> jeanmichel.hautbois@yoseli.org wrote on Thu, 27 Jun 2024 18:05:28 +020=
0:
> >> =20
> >>> Add a few definitions, as the base address for the NFC for the M5441x.
> >>>
> >>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> >>> ---
> >>> =C2=A0 arch/m68k/include/asm/m5441xsim.h | 7 +++++++
> >>> =C2=A0 1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/as=
m/m5441xsim.h
> >>> index f48cf63bd782..d4ee1eab7c4a 100644
> >>> --- a/arch/m68k/include/asm/m5441xsim.h
> >>> +++ b/arch/m68k/include/asm/m5441xsim.h
> >>> @@ -99,6 +99,7 @@
> >>> =C2=A0 #define MCFINT2_PIT1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 14
> >>> =C2=A0 #define MCFINT2_PIT2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 15
> >>> =C2=A0 #define MCFINT2_PIT3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 16
> >>> +#define MCFINT2_NFC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25
> >>> =C2=A0 #define MCFINT2_RTC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
26
> >>> =C2=A0 /*
> >>> @@ -333,4 +334,10 @@
> >>> =C2=A0 #define MCF_IRQ_BOFF1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
> >>> =C2=A0 #define MCF_IRQ_ERR1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 (MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
> >>> +/*
> >>> + * Flash module
> >>> + */
> >>> +#define MCF_NFC_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xfc0=
fc000
> >>> +#define MCF_NFC_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0xfc=
0fff3b - 0xfc0fc000)
> >>> +#define MCF_NFC_ISR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (MCFIN=
T2_VECBASE + MCFINT2_NFC) =20
> >>
> >> I'm sorry but this feels really backwards. Platform data as C
> >> structures are already legacy, but defining these information in
> >> some arch headers and using them directly from drivers really seems
> >> even "wronger" to me. What's the mid/long term plan for this? If the
> >> platforms are still in use today and need to be maintained, why not
> >> finally enabling device tree support? I know it's harder to do than to
> >> say, but I'd like some really good explanation on why we should accept
> >> to do this in 2024 because it feels rather inadequate. =20
> >=20
> > Thanks for your review !
> >=20
> > I agree with you it is legacy. I use a lot of ARM platforms and device-=
tree is indeed great. Though, switching the m68k architecture to use this s=
ounds really tough.
> >=20
> > I will obviously let Geert and maybe others answer, but my feeling is i=
t is not really worth it to implement the dts on those platforms are they a=
re not that used (compared, again, to ARM for instance). =20
>=20
> It would be nice to use devicetrees on ColdFire, but I am not aware of an=
yone
> currently working on it. So I don't think we will see it any time soon.
> So currently all supported ColdFire peripherals are "legacy" and use the
> old platform model.

It's not the old platform model, it is older than the old platform
model. This series hardcodes a physical offset in a driver. We are not
even talking about a C structure defining platform data.

> > AFAIK the platform data is not officialy considered deprecated ? As it =
concerns a few platforms out there... =20
>=20
> Certainly not officially deprecated. m68k in all its forms is currently w=
ell maintained
> (if not necessarily a lot of new development).

The platform is not deprecated, it is even maintained, but saying that
hardware support using plain C structures and machine drivers is
deprecated doesn't hurt me.

Thanks,
Miqu=C3=A8l

