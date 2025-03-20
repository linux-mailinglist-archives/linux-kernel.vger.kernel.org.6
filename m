Return-Path: <linux-kernel+bounces-569659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55135A6A5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66708A2454
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD222157A;
	Thu, 20 Mar 2025 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6yGMcMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589CF39AD6;
	Thu, 20 Mar 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472050; cv=none; b=nNYm/fY+YTSENTsc779qRI38zQYCJ+X4pxJsAbyKWV6uqU6kztgucEF2iGyVN3z6B6y1w1Fvfmb1m+pu23hIwf2KdWZ7ByTtoSNgweFG/pzyVIND4CRqoErjWQUS2uiSfP7+yPpodVwjtSDD6i+NcTULBhlv8qC2UUBlE6FXDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472050; c=relaxed/simple;
	bh=I2BU+qsSWA9Jxmh2vNgtN0RHEtMSdlZf/at4dwi6RJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Hq29NrywYqhgiwUhowC8TeP+746WGArALLjpemMM+7TU6lP9jM+KVmCkLxpjxlxcQULTheV/EhNik8May2zutVk+qufd/aMT2DY0SlcUpUmY43E0rNF8zQoypNu+81DJH12fIfW7SzhbQhTPUZ5a2TlTaZhw+wmVRLDfrFMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6yGMcMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5709BC4CEEA;
	Thu, 20 Mar 2025 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742472049;
	bh=I2BU+qsSWA9Jxmh2vNgtN0RHEtMSdlZf/at4dwi6RJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6yGMcMtI495UC0u2NOvqjljFvh/k1FKhOq+4zKWZuefs2TuWkfvGS1rGKNpcGGb8
	 NdBcJR+93RLe3JKkQDr3YkmhKkXPdk1msjKXlERZpXvi26JR/FuR+Rl7Je2+aiwie1
	 1ixb9lkYYyEkkAuPhNBXnDvLa9RUSR0qH8t76Abd84UE5GS+HFISpVqA3Sq40kDkNr
	 sSERXHf+itD/iwo8qEy4QuxW/jtNXkjWdaDW3ixR3E4Jve7AiAz1NevNrzHgjooS4S
	 7fpHAWq916cJLvgbaDftt1JCwM2jz2njTTfDbY2jNsW6N7TA0ejjrR4eMSZX47H/I0
	 HgLIz6+G3dZkw==
Date: Thu, 20 Mar 2025 12:00:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <20250320-uprising-couch-0af012a1fee6@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311-backdrop-porthole-440ae005e8fa@spud>
 <SA3PR04MB893164FCD6C4CB8924FC8DE583D82@SA3PR04MB8931.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dqsjL8OpJogiK+vA"
Content-Disposition: inline
In-Reply-To: <SA3PR04MB893164FCD6C4CB8924FC8DE583D82@SA3PR04MB8931.namprd04.prod.outlook.com>


--dqsjL8OpJogiK+vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:39:52AM +0000, Pinkesh Vaghela wrote:
> Hi Conor,
>=20
> On Tue, Mar 11, 2025 at 11:38 PM, Conor Dooley wrote:
> > On Tue, Mar 11, 2025 at 01:04:22PM +0530, Pinkesh Vaghela wrote:
> > > Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
> > > P550 CPU cluster and the first development board that uses it, the
> > > SiFive HiFive Premier P550.
> > >
> > > This patch series adds initial device tree and also adds ESWIN
> > > architecture support.
> > >
> > > Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
> > > P550 board using U-Boot 2024.01 and OpenSBI 1.4.
> >=20
> > There's no git tree in your MAINTAINERS entry, nor mention here of what=
 the
> > story is going to be in terms of sending patches to Arnd. Who is going =
to be
> > doing that?
>=20
> We are not currently set up for sending signed pull requests,
> so for now we plan to send changes to Arnd as separate patches.

Undesirable, but sure. You didn't answer the first part of my question
though, and there's no git tree listed in your v2 series. That part is
not negotiable, you have to have one and get it included in linux-next.

Cheers,
Conor.

--dqsjL8OpJogiK+vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9wDagAKCRB4tDGHoIJi
0qi/AP9YKzFUiYQGiDGSwHohlkUToDB0pum+R3rZQuqFodKXXAEAk6gtT0rvQonb
1UJ5lZsOGhW0cLSxRu5z5tlnca1WJAM=
=UrIu
-----END PGP SIGNATURE-----

--dqsjL8OpJogiK+vA--

