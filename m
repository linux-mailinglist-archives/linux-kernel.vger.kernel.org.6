Return-Path: <linux-kernel+bounces-266317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558B93FE12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F89B22A93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0B517C211;
	Mon, 29 Jul 2024 19:09:44 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04688F6E;
	Mon, 29 Jul 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722280184; cv=none; b=i8TcbkzZybdTk040fk0zhaptg36igt76Ed2oxNikJxyFAjSAdR2y+vYyo0VrfZtG3sc/PFQ0LxeM9PLXbkCFO+DyU4sUfaMktRa7P366KnyTwRE5TCmXtJrRX1NFVu1y/sdfEDhtqpX8dhq+5ZlHggP5In5p9s3pXgBDQ05QVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722280184; c=relaxed/simple;
	bh=fvEG8IuZUXuSrOmwSWUOQopan86PdBzlFjFcPT7zo5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8qpcV1BCPyPAGaBVlqAdte7XQ4ThjnGlrfSk7MbzSGLnb2ZduUq0pW3O/MRHu4gPCt7wpl8O5nZNL0F1ofZPZv2nCv3Ntumgie5L6sPmNabcsyAe4MrXZxruy8L54zhhjZ9VJQSMAKiH+b+tv24I4hnxd5n6kpXu+zb/9W2J2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sYVkP-00079A-SW; Mon, 29 Jul 2024 21:09:29 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sam Edwards <cfsworks@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jonathan Bennett <jbennett@incomsystems.biz>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Daniel =?utf-8?B?S3VraWXFgmE=?= <daniel@kukiela.pl>,
 Sven Rademakers <sven.rademakers@gmail.com>, Joshua Riek <jjriek@verizon.net>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add PCIe pinctrls to Turing RK1
Date: Mon, 29 Jul 2024 21:09:28 +0200
Message-ID: <2401016.9fHWaBTJ5E@diego>
In-Reply-To: <659dfd80-5962-4265-836d-5761c3e41ca0@incomsystems.biz>
References:
 <20231208062510.893392-1-CFSworks@gmail.com>
 <66f413d2-1a5b-b9e3-3c86-35a1d150f486@gmail.com>
 <659dfd80-5962-4265-836d-5761c3e41ca0@incomsystems.biz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Jonathan, Sam,

Am Mittwoch, 5. Juni 2024, 21:45:42 CEST schrieb Jonathan Bennett:
> On 12/8/23 11:27 AM, Sam Edwards wrote:
> > On 12/8/23 04:05, Heiko St=FCbner wrote:
> >> Am Freitag, 8. Dezember 2023, 07:25:10 CET schrieb Sam Edwards:
> >>> The RK3588 PCIe 3.0 controller seems to have unpredictable behavior=20
> >>> when
> >>> no CLKREQ/PERST/WAKE pins are configured in the pinmux. In=20
> >>> particular, it
> >>> will sometimes (varying between specific RK3588 chips, not over=20
> >>> time) shut
> >>> off the DBI block, and reads to this range will instead stall
> >>> indefinitely.
> >>>
> >>> When this happens, it will prevent Linux from booting altogether. The
> >>> PCIe driver will stall the CPU core once it attempts to read the=20
> >>> version
> >>> information from the DBI range.
> >>>
> >>> Fix this boot hang by adding the correct pinctrl configuration to the
> >>> PCIe 3.0 device node, which is the proper thing to do anyway. While
> >>> we're at it, also add the necessary configuration to the PCIe 2.0 nod=
e,
> >>> which may or may not fix the equivalent problem over there -- but is=
=20
> >>> the
> >>> proper thing to do anyway. :)
> >>>
> >>> Fixes: 2806a69f3fef6 ("arm64: dts: rockchip: Add Turing RK1 SoM=20
> >>> support")
> >>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> >>> ---
> >>>
> >>> Hi list,
> >>>
> >>> Compared to v1, v2 removes the `reset-gpios` properties as well --=20
> >>> this should
> >>> give control of the PCIe resets exclusively to the PCIe cores. (And=20
> >>> even if the
> >>> `reset-gpios` props had no effect in v1, it'd be confusing to have=20
> >>> them there.)
> >>
> >> Hmm, I'd think this could result in differing behaviour.
> >>
> >> I.e. I tried the same on a different board with a nvme drive on the=20
> >> pci30x4
> >> controller. But moving the reset from the gpio-way to "just" setting t=
he
> >> perstn pinctrl, simply hung the controller when probing the device.
> >
> > Ah, I'm guessing it died in:
> > ver =3D dw_pcie_readl_dbi(pci, PCIE_VERSION_NUMBER);
> >
> > If so, that's the same hang that this patch is aiming to solve. I'm=20
> > starting to wonder if having muxed pins !=3D 1 for a given signal upset=
s=20
> > the RC(s). Is your board (in an earlier boot stage:=20
> > reset/maskrom/bootloader) muxing a different perstn pin option to that=
=20
> > controller (and Linux doesn't know to clear it away)? Then when you=20
> > add the perstn pinctrl the total number of perstns muxed to the=20
> > controller comes to 2, and without a reset-gpios =3D <...>; to take it=
=20
> > away again, that number stays at 2 to cause the hang upon the DBI read?
> >
> > If so, that'd mean the change resolves the hang for me, because it=20
> > brings the total up to 1 (from 0), but also causes the hang for you,=20
> > because it brings the total up to 2 (away from 1).
> >
> >>
> >> So I guess I'd think the best way would be to split the pinctrl up=20
> >> into the
> >> 3 separate functions (clkreqn, perstn, waken) so that boards can inclu=
de
> >> them individually.
> >
> > Mm, maybe. Though that might be more appropriate if a board comes=20
> > along that doesn't connect all of those signals to the same group of=20
> > pins. I worry that attempting to solve this hang by doing that will=20
> > instead just mask the real problem.
> >
> >>
> >> Nobody is using the controller pinctrl entries so far anyway :-) .
> >
> > Then it's interesting that this board requires them in order to avoid=20
> > a hang on boot. I'll see if there's anything else that I can find out.
>=20
> I've just finished testing the latest iteration of this patch with=20
> 6.10-rc2 on my RK1 on a Turing Pi 2 carrier board. I can confirm that=20
> unpatched mainline fails to boot with the same hang described here, and=20
> the patch does make the board boot again.

Can you possibly test if

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D28b8d7793b8573563b3d45321376f36168d77b1e

changes anything? In 6.11-rc1 now.

The PERST# toggling happening before that patch could've caused
issues with your PCIe device.


Heiko



