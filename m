Return-Path: <linux-kernel+bounces-292642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C8957238
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E7B1C21D27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7818787A;
	Mon, 19 Aug 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiFRhnuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EE17BB13
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088853; cv=none; b=kcZQ5Qr0f6X6xj9X4AqCACgIT+kLaJlq5cbEYdhD38y/lZKAImZGHlEhkJfg/sdhcXRKlL3IYDmQmqQnfpvqYwwMKhg5NsG38XzpGB8jAwxFTFAAI4nWRrKRO6NUjqKgEmIxwxzEpR0o55iYFwnpvCKLV6k92PdPe4C2j1Z7a7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088853; c=relaxed/simple;
	bh=fMRu5tbYzfc0faI37PJ1BzlkxY9s1twpRQn9ugXZeE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AthYroYx1pn4fPD4ND/ZA92JsgIo+i5vFLxzgX/t5ZT7UCP1Ng8SIMS86MnzZsWHqID8Rv/SOPP56HY8qJLqoKBaLXWNlwoQb8JxykJvFLe7I+rlHpRNCv1iLGJBE72KSnOtU1ZQsJEKETQVTscMbw2IVYsKA9CQZDTlB3V8LG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiFRhnuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3864C32782;
	Mon, 19 Aug 2024 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724088853;
	bh=fMRu5tbYzfc0faI37PJ1BzlkxY9s1twpRQn9ugXZeE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiFRhnuuuYkesZa1ht7tQ29Bc7LtvxDTvnWGuny5uaNwScEGRuvEvvlSVQOi8pcmy
	 P4W+HFKmmqzNfbGP1tbhUqJlZjkdjsB48V2U2ALGI0kXjIyal4dj/il97RXLPPEMrd
	 3Lg/eNelDtTzfyN5VwA7kNUpyocpxp9tg2A5viRwsEJ6k5/2emjjbNtquAAOrPsuXg
	 3Eetkd/X1Al3AoTTj6fH7gY8laE2LhWl/0q6XHbBDl0v5xEUZR1XbuWTS1RpXowlEb
	 BGgW99vEU1sOgIGuKdEq4+qOLxcNIkuRAQxrQgYKT9dJQVWvsGVyoZUCZVlZ7xOqdW
	 bYotRoZsVtUEA==
Date: Mon, 19 Aug 2024 18:34:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: hwprobe: export Zicntr and Zihpm extensions
Message-ID: <20240819-unclamped-cheek-9b4851bed13f@spud>
References: <20240817075629.262318-1-mikisabate@gmail.com>
 <CALSpo=ZsZWNm_cXG_4GXyZ9invSS_eKH=9Q-mdoM2XV=HwzOXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wPCzj63yBK1PNHWF"
Content-Disposition: inline
In-Reply-To: <CALSpo=ZsZWNm_cXG_4GXyZ9invSS_eKH=9Q-mdoM2XV=HwzOXA@mail.gmail.com>


--wPCzj63yBK1PNHWF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 01:29:16PM -0400, Jesse Taube wrote:
> On Sat, Aug 17, 2024 at 3:58=E2=80=AFAM Miquel Sabat=C3=A9 Sol=C3=A0 <mik=
isabate@gmail.com> wrote:
> >
> > Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.
> >
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> > ---
> >  Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
> >  arch/riscv/kernel/sys_hwprobe.c       | 2 ++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index 3db60a0911df..5bb69c985cce 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -188,10 +188,16 @@ The following keys are defined:
> >         manual starting from commit 95cf1f9 ("Add changes requested by =
Ved
> >         during signoff")
> >
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version =
2.0
> > +       is supported as defined in the RISC-V ISA manual.
> > +
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extensio=
n is
> >         supported as defined in the RISC-V ISA manual starting from com=
mit
> >         d8ab5c78c207 ("Zihintpause is ratified").
> >
> > +  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
> > +       is supported as defined in the RISC-V ISA manual.
> > +
> >    * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve3=
2x is
> >      supported, as defined by version 1.0 of the RISC-V Vector extensio=
n manual.
> >
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index b706c8e47b02..098a815b3fd4 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -72,6 +72,8 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_EXT_ZCF           (1ULL << 46)
> >  #define                RISCV_HWPROBE_EXT_ZCMOP         (1ULL << 47)
> >  #define                RISCV_HWPROBE_EXT_ZAWRS         (1ULL << 48)
> > +#define                RISCV_HWPROBE_EXT_ZICNTR        (1ULL << 49)
> > +#define                RISCV_HWPROBE_EXT_ZIHPM         (1ULL << 50)
> >  #define RISCV_HWPROBE_KEY_CPUPERF_0    5
> >  #define                RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
> >  #define                RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)

The sort here, by number, is fine.

> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index 8d1b5c35d2a7..30aede1c90ff 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -118,6 +118,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *=
pair,
> >                 EXT_KEY(ZKSH);
> >                 EXT_KEY(ZKT);
> >                 EXT_KEY(ZTSO);
> > +               EXT_KEY(ZICNTR);
> > +               EXT_KEY(ZIHPM);
>=20
> Conor, do we care about ordering?

I would rather that they were sorted alphabetically. Adding to the end
is nothing but a conflict generator and makes it harder to see what is
and what is not in the list. IIRC Palmer applied the patch I sent a few
weeks ago that sorted the entries in all of these EXT_KEY() lists.

--wPCzj63yBK1PNHWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsOCEQAKCRB4tDGHoIJi
0j20AP4mn1nrlXNLBYaUZvSWhqw15lLFxowAgFyao8lH1D/nIQEA6Lhe6OFrs9Sd
6BFmOhwTeZOG6+PhDiTu4GrRp1WGRQQ=
=/NqD
-----END PGP SIGNATURE-----

--wPCzj63yBK1PNHWF--

