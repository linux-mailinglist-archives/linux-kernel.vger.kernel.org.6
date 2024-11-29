Return-Path: <linux-kernel+bounces-425789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5ED9DEB08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BA1B23CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852BA19C566;
	Fri, 29 Nov 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF/4ioTr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DB1991CF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897761; cv=none; b=NviCgPO3dHUFkSVMRTpB5A/Zxvgax9043l/gyZMjENKIwe5rps711sBCLFzLh5Me5lcP/uRugNsAsvrdEp3KlqFTF2T2qAPV9u5KqHfKFvDpC2BxGmxALeMTY1zXHFI/6oPTRnqzJ/LUI4Sy7pR6MPsR02gy/yOrOx/tT40MlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897761; c=relaxed/simple;
	bh=a+JXksBolTe4J4hQL4bPo5qxtspU7rydl4gWOzG4f1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN9tV3bR+1xvI/KwQoS1IKyNXkb9IOPERJtqootNm4csGzLV+XzqEBHVk8ZCbfVTlPePdlHfrJ/GHXpaweBUo/QDvVw3mITnOwUcZJ7Urf4hdEenhcZD5QO/sFVz/dTsOkM9xiF2m+zv+nux4zYqKnKYIA0TboJsz7Q1PRRRoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF/4ioTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319F3C4CECF;
	Fri, 29 Nov 2024 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732897760;
	bh=a+JXksBolTe4J4hQL4bPo5qxtspU7rydl4gWOzG4f1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mF/4ioTrQsHHDuHLfI+AbccmnbJPHxnpOgSbt/2TW6RDhC1Z4nlssBu+qc+zRhNuf
	 azpb9VplKB5TKLxwhjrQjVOpxsfwi5JGCEdbXjOWeeetItaqhRmP0hm8TYP63EC/HU
	 B9qjeMvij5IqZNUc0xoOccuZ8DlsQ0gXArvgwl0O+NhgyyCAWzJsK772O2GkH7/6uC
	 SaGtY9AdB+eRNIgnZMBY93KnfDPJfRYv9swo9a7GhHV1WT9E1ePZaPlCymS3ierTKF
	 KETz7i+QSiwgyD8lwhGAUa34J3QM5JGuF+/7S9pF9QTqCqy80/HqYAs4gs2ljcxov8
	 4XPcNebPs9M6g==
Date: Fri, 29 Nov 2024 16:29:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Aleksandar Rikalo <arikalo@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrea Parri <parri.andrea@gmail.com>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Chan <ericchancf@google.com>, linux-kernel@vger.kernel.org,
	Djordje Todorovic <djordje.todorovic@htecgroup.com>
Subject: Re: [PATCH] riscv: Rewrite AMO instructions via lr and sc.
Message-ID: <20241129-antivirus-blunderer-efcbd49cfeb6@spud>
References: <20241129144319.74257-1-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vVGz3+wDfGrf1ixl"
Content-Disposition: inline
In-Reply-To: <20241129144319.74257-1-arikalo@gmail.com>


--vVGz3+wDfGrf1ixl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Nov 29, 2024 at 03:43:19PM +0100, Aleksandar Rikalo wrote:
> From: Chao-ying Fu <cfu@mips.com>
>=20
> Use lr and sc to implement all atomic functions. Some CPUs have
> native support for lr and sc, but emulate AMO instructions through
> trap handlers that are slow.
>=20
> Add config RISCV_ISA_ZALRSC_ONLY.
>=20
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>  arch/riscv/Kconfig               | 10 ++++++
>  arch/riscv/include/asm/atomic.h  | 52 +++++++++++++++++++++++++++++++-
>  arch/riscv/include/asm/bitops.h  | 45 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 16 ++++++++++
>  arch/riscv/include/asm/futex.h   | 46 ++++++++++++++++++++++++++++
>  5 files changed, 168 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index cc63aef41e94..767538c27875 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -715,6 +715,16 @@ config RISCV_ISA_ZACAS
> =20
>  	  If you don't know what to do here, say Y.
> =20
> +config RISCV_ISA_ZALRSC_ONLY
> +	bool "Zalrsc extension support only"

I don't agree with the naming of and description for this option.
=46rom the description below I'd imagine that you only care about a
platform where use of AMO instructions is only undesirable, but overall
the option implies that it can be used to build a kernel that can be
used on systems that only implement Zalrsc, which, even with your patch
applied, it cannot. I think, if we are going to merge something like this,
we should go the whole way and permit platforms that don't even emulate
the a extension. If not, the Kconfig option should be explicitly clear
that the a extension is still mandatory.

> +	default n

"default n" is the default, you shouldn't need this line.

> +	help
> +	   Use lr and sc to build all atomic functions. Some CPUs have
> +	   native support for lr and sc, but emulate amo instructions through
> +	   trap handlers that are slow.

Since you mention trap handlers here, it sounds like it may not be the
CPU itself that emulates it, but rather firmware?

Cheers,
Conor.

--vVGz3+wDfGrf1ixl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0nr2gAKCRB4tDGHoIJi
0oDIAQC22X6HOobFscDmH2YDTVKivr2V+8UnvrWq6oOIysNcywD+KCxJG6vXWGFX
6Raj5sGgp+Rrb5dVs50w6j0woXcWwgk=
=Yjqj
-----END PGP SIGNATURE-----

--vVGz3+wDfGrf1ixl--

