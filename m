Return-Path: <linux-kernel+bounces-207914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B50901DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E660286C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51E6F318;
	Mon, 10 Jun 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HEddZOPD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC26F2E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010175; cv=none; b=Brtkolarh9+TTq01nFWiC2m9QxUjep1fEw49lRYmYoe4Z1qW4q9C5eZEd2LWUy5Kz+3jFH4koeV1p2hz+j8+wA3omiWVUWfYyZvlco7c5hixRk2q6WVXVvFXTteUDxazNe8u7YAuDqnji2sA9nJC7OBtq1emNMTksHAIJdqDGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010175; c=relaxed/simple;
	bh=05NXpM8nBmvJm7pP7VJ8kWbii76EwTm7ZQyCuYD0Wjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIwo2lXNF3L2ITOpqZ/JuSdu7NBp05DM6PK8Aa5eBUsGeaOy7s30oUxh99GBXb2J4ExWASspBOPcWnWc7Vk6mM7SFQqU+6xBiN9VBr3zlGzDo72Sk4N6N21XjTRrhrZCQ2Opk/+1aILcE7+siS3a30w12Vw+0xMNGs3EUbtswR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HEddZOPD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718010172; x=1749546172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05NXpM8nBmvJm7pP7VJ8kWbii76EwTm7ZQyCuYD0Wjk=;
  b=HEddZOPD5/t2S2yHS5+bnHlTI2/zzcEZFwmHFz7LxxrcjeLQG5ny922H
   5gh5ZSWLyaPrPMNnKuvJlCTfUjvriSsYg03clinPYAqSJx3XftQAlCKgz
   RZ0loHaXFMSFUVPTu9YpqHrwRF/je+kzujcxMwUhgVVwYQ56/8WGeWNT9
   eLwYfK3NRlEgf/StbzwuXEh0p/fuQmeBVSkVP9XD2sMFfAKMTtWBPqqO/
   aqMPImURQWU5YS0xuuO96BSMfEuqlhHPxO86iDLcTcY6DxcWzJeggJaXs
   lAzL9f9AcaMnzZfDjgxWIroNHUgvLcGBPTJ4vEDFUGPO3vYQLG6YHs88O
   g==;
X-CSE-ConnectionGUID: hKcqPKvETJCFPadg1pNHsQ==
X-CSE-MsgGUID: glZcGm/MRXy8NIsgEhKyrQ==
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="asc'?scan'208";a="29619861"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2024 02:02:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 10 Jun 2024 02:02:35 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 10 Jun 2024 02:02:32 -0700
Date: Mon, 10 Jun 2024 10:02:15 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Masahiro Yamada
	<masahiroy@kernel.org>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240610-qualm-chalice-72d0cc743658@wendy>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
 <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nVgNDjGj7iR73dzp"
Content-Disposition: inline
In-Reply-To: <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>

--nVgNDjGj7iR73dzp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:33:34AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 07/06/2024 20:51, Deepak Gupta wrote:
> > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
> >> On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
> >>> Hi Conor,
> >>>
> >>> On 31/05/2024 19:31, Conor Dooley wrote:
> >>> > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> >>> > > Dectect the Zkr extension and use it to seed the kernel base
> >>> address.
> >>> > >
> >>> > > Detection of the extension can not be done in the typical
> >>> fashion, as
> >>> > > this is very early in the boot process. Instead, add a trap handl=
er
> >>> > > and run it to see if the extension is present.
> >>> > You can't rely on the lack of a trap meaning that Zkr is present
> >>> unless
> >>> > you know that the platform implements Ssstrict. The CSR with that
> >>> number
> >>> > could do anything if not Ssstrict compliant, so this approach gets a
> >>> > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> >>> > it, so you're stuck with getting that information from firmware.
> >>>
> >>>
> >>> FYI, this patch is my idea, so I'm the one to blame here :)
> >>>
> >>>
> >>> >
> >>> > For DT systems, you can actually parse the DT in the pi, we do it
> >>> to get
> >>> > the kaslr seed if present, so you can actually check for Zkr. With
> >>> ACPI
> >>> > I have no idea how you can get that information, I amn't an ACPI-is=
t.
> >>>
> >>>
> >>> I took a look at how to access ACPI tables this early when
> >>> implementing the
> >>> Zabha/Zacas patches, but it seems not possible.
> >>>
> >>> But I'll look into this more, this is not the first time we need the
> >>> extensions list very early and since we have no way to detect the
> >>> presence
> >>> of an extension at runtime, something needs to be done.
> >>
> >> Aye, having remembered that reading CSR_SEED could have side-effects o=
n a
> >> system with non-conforming extensions, it'd be good to see if we can
> >> actually do this via detection on ACPI - especially for some other
> >> extensions that we may need to turn on very early (I forget which ones=
 we
> >> talked about this before for). I didn't arm64 do anything with ACPI in
> >> the
> >> pi code, is the code arch/x86/boot/compressed run at an equivilent-ish
> >> point
> >> in boot?
> >=20
> > cc: +Clement and Atish
> >=20
> > I don't know all the details but on first glance it seems like instead
> > of ACPI,
> > may be FWFT is a better place for discovery ?
> > https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/1064795=
71
>=20
> IMHO, doing discovery in FWFT is not the goal of this extension. I think
> the "real" solution would be to wait for the unified discovery task
> group to come up with something for that (which is their goal I think) [1]

I'm curious to see how that works out. The proposal documents an m-mode
csr, so we'd have to smuggle the information to s-mode somehow...

> Link: https://github.com/riscv/configuration-structure [1]


--nVgNDjGj7iR73dzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmbBFwAKCRB4tDGHoIJi
0sWEAQDPxN3POosNf57iZnY6Z1DcNcP3FdzrGhHkHg4ueiwu1AD/ZRj3S4UJPdS1
49Ojq7L47qyv+ZSH3aIChFHIuU+5VQw=
=ZOKe
-----END PGP SIGNATURE-----

--nVgNDjGj7iR73dzp--

