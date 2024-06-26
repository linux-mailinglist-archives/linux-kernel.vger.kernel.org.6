Return-Path: <linux-kernel+bounces-230982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D39184D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DA5B2AC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB318732C;
	Wed, 26 Jun 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPmIAY7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8C185083;
	Wed, 26 Jun 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412600; cv=none; b=QDT3yO4JnvTDdRrSu45ub9TO+teVQp58aab31R3lEKEXESZQy8xiQ+Pia0U2UVW6luL9NNMQ7pLAWCRukbAYDtEbDRFdlI3Gs9o6DDSar/ZP107iz8BCqTj7yPztV6mKeJTnxLxbeiqdsaLMmbP+Ysa4Bt2dqkV1ZgaKPhlykDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412600; c=relaxed/simple;
	bh=lN4o+TpGwEdAHXdvn6W7jWruWVfTSWp81Ict7yYXA7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxvSFJPSh9+/yr5jNaQ8rBZC1oxHDmpvwkkFsxQ08GXd18jK2gOFU509VoLCLrKIxnO5d+w0owr4PuyqRyurwxbuuZOJYpejBeBWumgNUns6FsX4g4GdPsDo/B/us0PKnTMg9iDUtdabhxzNIVVBSTtisxgdjkN4gEkvGI+8VUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPmIAY7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474E5C116B1;
	Wed, 26 Jun 2024 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412600;
	bh=lN4o+TpGwEdAHXdvn6W7jWruWVfTSWp81Ict7yYXA7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPmIAY7C/8HZgLS33QwM53j5BrHpIUyrvhf1la7K/QkKMO4z/Cghds5/vnHGA3+qJ
	 YU+RTOMIeMknGJ1H3/fheBZrdpnAL7bmcFSIOYbGxXKdUS8Ubb20RIPXZ6Fj79+s29
	 k0gha7WFN+zb5v+nj9cwqSteVW0RoXNexPWSxfZZ+OVD1Fkg97gUW5NPGqaNgHkFUf
	 umKQzkwdLic6Tb+b5ORlHwALwnzw3VnlmW6kehkqoA7drMnQf9S0RsGSvn2phkneKS
	 77+MsP+q2rInQPKdHaHAa45mAxlxqr05r/5tqPS2w5k5ps+BeQnCYga5Atx3C2yp+5
	 R1lHZAs7Q3W2Q==
Date: Wed, 26 Jun 2024 15:36:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Yangyu Chen <cyy@cyyself.name>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] RISC-V: hwprobe: Add MISALIGNED_PERF key
Message-ID: <20240626-aide-nickname-1ef5fef000fb@spud>
References: <20240625165121.2160354-1-evan@rivosinc.com>
 <20240625165121.2160354-2-evan@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="943UgLD4rzYd2FOi"
Content-Disposition: inline
In-Reply-To: <20240625165121.2160354-2-evan@rivosinc.com>


--943UgLD4rzYd2FOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 09:51:20AM -0700, Evan Green wrote:
> RISCV_HWPROBE_KEY_CPUPERF_0 was mistakenly flagged as a bitmask in
> hwprobe_key_is_bitmask(), when in reality it was an enum value. This
> causes problems when used in conjunction with RISCV_HWPROBE_WHICH_CPUS,
> since SLOW, FAST, and EMULATED have values whose bits overlap with
> each other. If the caller asked for the set of CPUs that was SLOW or
> EMULATED, the returned set would also include CPUs that were FAST.
>=20
> Introduce a new hwprobe key, RISCV_HWPROBE_KEY_MISALIGNED_PERF, which
> returns the same values in response to a direct query (with no flags),
> but is properly handled as an enumerated value. As a result, SLOW,
> FAST, and EMULATED are all correctly treated as distinct values under
> the new key when queried with the WHICH_CPUS flag.
>=20
> Leave the old key in place to avoid disturbing applications which may
> have already come to rely on the key, with or without its broken
> behavior with respect to the WHICH_CPUS flag.
>=20
> Fixes: e178bf146e4b ("RISC-V: hwprobe: Introduce which-cpus flag")
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>=20
> ---
>=20
> Changes in v2:
>  - Clarified the distinction of slow and fast refers to misaligned word
>    accesses. Previously it just said misaligned accesses, leaving it
>    ambiguous as to which type of access was measured.

I think if we are gonna be specific, we should be exactly specific as to
what we have tested and say 32-bit if that's what we're probing/testing
with. That'd be consistent with jesse's proposed wording for vector.

--943UgLD4rzYd2FOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwncwAKCRB4tDGHoIJi
0oHJAQCzuhaQs1e0sxDKyRbQx1Rt3W33WC+yta1V3tlS1n8VRQD+MaOHndFJ4ty1
lFeNRZdVv2EK2WGBoxfn3SN4uzjXTgg=
=iNiQ
-----END PGP SIGNATURE-----

--943UgLD4rzYd2FOi--

