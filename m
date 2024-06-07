Return-Path: <linux-kernel+bounces-206768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF4900D75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE761F22CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823441552F9;
	Fri,  7 Jun 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrCH+MBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5971125C0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795286; cv=none; b=UJcMus6ygOPCwSek9UsA8+b0pi2ApAedVzQWGxSb4ts1m8JmMDJS3Wf2H1EgQEg+k/Rzt82MlZ0X7ebG6Fq53iJmAdKmu3GBPJ2k4qeDhjXwItOCOJY0AmNi6Z5szVj0PC21YqRymYdR1Du+jD1N00scrNFOJ0V3Z3lqHrOqUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795286; c=relaxed/simple;
	bh=4jVn0C4rP9izfuziEvxAHgC5wbR9Zw6PLZ6CYGJjwdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijcnM1FgqNCw0FSpQKUEvuCZ+hmjY8CtBNCWT9icU/kt+OmmvQ35ueoW93cPVZkNHb4nsCpXyfumM9KyvZXdHa+lIiyPqspjZ3gO0PaFMgbiOvSgEVSByZwy1nURW4Ujh55lIkRXAEyWno9V/2pkBTfzxn9BhnhC+TfzZkqV850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrCH+MBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA52C2BBFC;
	Fri,  7 Jun 2024 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717795286;
	bh=4jVn0C4rP9izfuziEvxAHgC5wbR9Zw6PLZ6CYGJjwdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrCH+MBoJS1yRbTDYvFTdCKXFdTUcuwZz2Vu/J2EMfRx7GatNZwNGhtrcxRaoUOqB
	 2rOopd1WJ5V3DW6C2/1pHzQuIyMWV33jcgWvJANTIJ9smixfH6KtFJHEMtHix/fnj8
	 /jLnRUK+bTq13jYncBAj7VKfqJFEPpTH4YgTstFS5KMbsbaPP6bxaeA43xbrq3DBf/
	 D2MET/98UnTx+g3tnVazFolQgsNtv3lyBX4f5/ZaRaTfy+8YZzdqgYY9X98FpxmINH
	 YMKkONwJ6pin9hS5bt5ltx3j0qT7JX+macyrot/+ZvJ20DytxDt6I042NaeTftxgqE
	 TT+Q3CKLzwz8Q==
Date: Fri, 7 Jun 2024 22:21:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Detect unaligned vector accesses supported.
Message-ID: <20240607-wildfowl-baggage-54f622e18c4a@spud>
References: <20240606183215.416829-1-jesse@rivosinc.com>
 <20240606183215.416829-2-jesse@rivosinc.com>
 <ZmIqM3Cuui0HAwN1@ghost>
 <ZmJCq7bsglq7olSB@ghost>
 <a16ccf51-4b06-4c6d-94a1-cb43dc3f2945@rivosinc.com>
 <ZmN2U6BDAYRXxHEi@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8YS9Sx3fQh2vamL3"
Content-Disposition: inline
In-Reply-To: <ZmN2U6BDAYRXxHEi@ghost>


--8YS9Sx3fQh2vamL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 02:06:27PM -0700, Charlie Jenkins wrote:
> On Fri, Jun 07, 2024 at 03:53:23PM -0400, Jesse Taube wrote:
> > On 6/6/24 19:13, Charlie Jenkins wrote:
> > > On Thu, Jun 06, 2024 at 02:29:23PM -0700, Charlie Jenkins wrote:
> > > > On Thu, Jun 06, 2024 at 02:32:14PM -0400, Jesse Taube wrote:

> > > > Please use the exising UNKNOWN terminology instead of renaming to
> > > > SUPPORTED. Any option that is not UNSUPPORTED implies that unaligned
> > > > accesses are supported.
> >=20
> > Conor didnt like using UNKNOWN a proxy for "SUPPORTED"

I did say this, but in the context of wanting you to actually add the
performance probing (and potentially the other infrastructure that
Charlie added for scalar).

> > Having SUPPORTED is better then assuing the speed to be slow.
>=20
> The HWPROBE key is about misaligned access performance. UNKNOWN means
> that the performance is unknown.

Right. I also don't think that assuming "slow" is even problematic -
seemingly all extant hardware doesn't even support misaligned access.
But really, just whack in the probing, it shouldn't be too bad, right?

> The scalar and vector names need to
> match up.

That's definitely not the case. A different hwprobe key is allowed to
behave differently, but...

> UNKNOWN was already merged and is supported by linux so if you
> want to use SUPPORTED here then you need to add a scalar SUPPORTED key
> that is an alias of the UNKNOWN key.

=2E..this suggestion of a scalar change I disagree with anyway, so it's
moot. Unknown should be a state that we only have internally when we
actually do not know, and not something that userspace should ever see,
unless there's a bug in the probing code IMO. Unknown gives userspace no
actionable information anyways.

> I would rather keep UNKNOWN as it
> is, but that's up to you.

--8YS9Sx3fQh2vamL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmN5zwAKCRB4tDGHoIJi
0jBSAQDIvHDI37c072Vzga9uhMAIgoc0xvFIzXF+e0LwVNEQ/AEAysNxEGOD0UHM
UlCyN4BTtw9qVQIFJcyKgqX6txxrVAs=
=4Qyu
-----END PGP SIGNATURE-----

--8YS9Sx3fQh2vamL3--

