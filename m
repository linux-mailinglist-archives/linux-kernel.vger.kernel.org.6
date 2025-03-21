Return-Path: <linux-kernel+bounces-571335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20AA6BBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189FE4648D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1122C34A;
	Fri, 21 Mar 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzHYr6/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160322A81D;
	Fri, 21 Mar 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564504; cv=none; b=OZ/IyqdA5RcevDbXillrWuUtdL1jQua4Z0tFq/9cO6eS3Qy1q1JDF19A/NWKKHIaMGUN7kn7WcD5Af2tYgGBOMCxOyHybbPHjDhVLz1MXBj5Up32amIPEyPz/d/6jWZi+2tWxsbp3xNoieY/q9JwmWf+CX6DGa1Mye84IP00QRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564504; c=relaxed/simple;
	bh=eq+z2NNjf7FTukWVpkQ2qGB887ccsImFLhwuR8Nvkig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lke9j9Y3onAs9/8ONHYYO+H4bGI89u8kisuHaHPIVQrXSmRrnIoGN6Ywsi7gGAHVTKmMltItzliME7iWM/HKoAnC6MDBgWqi2JuFthGTRD6j8bguCTMDvVoTgftxFw5aHN9RKcjpSyo1mnoBvB7jbW6WGWuTlKzc2uReFk16RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzHYr6/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348FAC4CEE3;
	Fri, 21 Mar 2025 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742564503;
	bh=eq+z2NNjf7FTukWVpkQ2qGB887ccsImFLhwuR8Nvkig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzHYr6/U/ZegOdlAf62w1ezW1sGmXONWKXfuFieNOPMJqwKJHtgyig3pZhX94c0ES
	 7XtlQUDhKntSUlcrVgGUPR6aLFzafbJ372aIKmdgT6aUv5T9HMVCVfqt9tV14HcYoA
	 rQs/E5mRdoOaczY4PFC6LspPLGY0caJtGl3hTwavq6fJnS71PlDL1ZS7Yx5NhY4ooN
	 5OcLK1oHBol6POy9lF5riGyC5/xFFcWQij2uaTSEO/+4YkN+C29YrNLrFyPkVLakTx
	 qK52FLMCkcTU9Jm1TdvG76AywsFvf8nVdxxIRIYYuzq9uDFE3YKTozaOHwNkP40s8s
	 cY+0AYcTmBrJA==
Date: Fri, 21 Mar 2025 13:41:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	"rafal@milecki.pl" <rafal@milecki.pl>,
	Anup Patel <anup@brainfault.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V
 SoC
Message-ID: <20250321-pacifier-varied-bbb1cae00182@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311-backdrop-porthole-440ae005e8fa@spud>
 <SA3PR04MB893164FCD6C4CB8924FC8DE583D82@SA3PR04MB8931.namprd04.prod.outlook.com>
 <20250320-uprising-couch-0af012a1fee6@spud>
 <f0dd950a-02a7-402b-a08e-015db458b273@kernel.org>
 <SA3PR04MB893147FE3E09B43DA41A7DF283DB2@SA3PR04MB8931.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jB7oSH4WdargtE72"
Content-Disposition: inline
In-Reply-To: <SA3PR04MB893147FE3E09B43DA41A7DF283DB2@SA3PR04MB8931.namprd04.prod.outlook.com>


--jB7oSH4WdargtE72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 11:29:27AM +0000, Pinkesh Vaghela wrote:
> On Fri, Mar 21, 2025 at 3:07 PM, Krzysztof Kozlowski wrote:
> > > On Thu, Mar 20, 2025 at 10:39:52AM +0000, Pinkesh Vaghela wrote:
> > >> On Tue, Mar 11, 2025 at 11:38 PM, Conor Dooley wrote:
> > >>> On Tue, Mar 11, 2025 at 01:04:22PM +0530, Pinkesh Vaghela wrote:
> > >>>> Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> > >>>> P550 CPU cluster and the first development board that uses it, the
> > >>>> SiFive HiFive Premier P550.
> > >>>>
> > >>>> This patch series adds initial device tree and also adds ESWIN
> > >>>> architecture support.
> > >>>>
> > >>>> Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
> > >>>> P550 board using U-Boot 2024.01 and OpenSBI 1.4.
> > >>>
> > >>> There's no git tree in your MAINTAINERS entry, nor mention here of
> > >>> what the story is going to be in terms of sending patches to Arnd.
> > >>> Who is going to be doing that?
> > >>
> > >> We are not currently set up for sending signed pull requests, so for
> > >> now we plan to send changes to Arnd as separate patches.
> > >
> > > Undesirable, but sure. You didn't answer the first part of my question
> >=20
> > Just to clarify - separate patches as separate postings to soc@ after t=
he review
> > was done on the lists and then you applied them to the tree Conor asked
> > below, right?
>=20
> Correct. Once the patches are reviewed, will send separate patches to @soc
> and then apply to the git tree.

No, that's the wrong order. You apply reviewed patches to the git tree,
they then appear in linux-next, after some time soaking there, you send
a PR (or in your case patches) to soc@kernel.org, usually around rc6 or
rc7. Fixes get applied to a different branch and can be sent at any
time. I expect both branches to appear in linux-next.

Bear in mind that patches for this SoC might be sent by other people,
for example me if I find some issues, and you'll need to forward those
on to soc@kernel.org on top of whatever work you're doing to bring up
the SoC.

> > > though, and there's no git tree listed in your v2 series. That part is
> > > not negotiable, you have to have one and get it included in linux-nex=
t.

--jB7oSH4WdargtE72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ91skAAKCRB4tDGHoIJi
0uEXAQCPJJkOErMXPJI1hMZw+JZzaLhhY2ew43wR9BFZRSWvTQD6A03L62ZGb0HW
nyCNJA8Q+NY5eQpX+dyXYdiMkC6QAg4=
=sX2X
-----END PGP SIGNATURE-----

--jB7oSH4WdargtE72--

