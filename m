Return-Path: <linux-kernel+bounces-197251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D521E8D682B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99932281126
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7417B404;
	Fri, 31 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGf8CKyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DA80C1F;
	Fri, 31 May 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717176674; cv=none; b=thZ6iRy07nOUFNTzGaktEOia7DXAXHTjqQboSjU2kLsbQfzp2pmVLA30JWrRfWs7dQiuuXY1DPt00x01mRz9gtdshtReSdbcVX492xYJJ4l3WyzCrcO/lH+x8foirs0wSA/bMmOBey9v45NhALBJe7vSZgFIuR242Lj55020CSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717176674; c=relaxed/simple;
	bh=ugKsI1n0ps5BfECIOYx/A6IymgUIGBxwn3EHv/Id8mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd810kmF6q5Zg6VWoqIPyl8gwHH41PMPY+Ay0+pgOqfpUYY0Gz5rlDsofUqI+jO/tCBCmKmugoDf/BZbrOFOOt5iHmujs6gplCPgKPBJh0tSenX+/fGhC9H/0lEPYBqGBLLSZpsihsN+HEEYOswbEwXAS5VmTotZ1ViYEwOVkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGf8CKyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8966DC2BD10;
	Fri, 31 May 2024 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717176674;
	bh=ugKsI1n0ps5BfECIOYx/A6IymgUIGBxwn3EHv/Id8mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGf8CKyHFijgLDSqYePnQ5BCTYnBTXCTIR7yFEJknvnNOQ/hdxJ2qZAs0M7kcsxLm
	 pk76gkHxefmIVBYIrtYbxwMb5x2CbUZ7sqalM1gvrqc4uMBNY+Z7fH1UBhsXarwcxp
	 FTLaEWHCxtKiJzjjNd0CIsJJe+3tiWuqjfkoRefwjTFy3PCs6UTm7hi4YqP1XzHG1g
	 eaJ/meSnXuj1Li4yDdzDFHZ0XctqhnbxhWTcPCLffmGOaXdTeCkPH2pEnFnBHvLe51
	 10OondmOCzovC/AY9gpGpxUzdQJSI2OuorxHNORYMDnuHTBbAoNMtyYN5NLjetfX7A
	 OEaogdLCfTaBg==
Date: Fri, 31 May 2024 18:31:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240531-uselessly-spied-262ecf44e694@spud>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xt66x2nsbKVBAiZs"
Content-Disposition: inline
In-Reply-To: <20240531162327.2436962-1-jesse@rivosinc.com>


--xt66x2nsbKVBAiZs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> Dectect the Zkr extension and use it to seed the kernel base address.
>=20
> Detection of the extension can not be done in the typical fashion, as
> this is very early in the boot process. Instead, add a trap handler
> and run it to see if the extension is present.

You can't rely on the lack of a trap meaning that Zkr is present unless
you know that the platform implements Ssstrict. The CSR with that number
could do anything if not Ssstrict compliant, so this approach gets a
nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
it, so you're stuck with getting that information from firmware.

For DT systems, you can actually parse the DT in the pi, we do it to get
the kaslr seed if present, so you can actually check for Zkr. With ACPI
I have no idea how you can get that information, I amn't an ACPI-ist.

Thanks,
Conor.

--xt66x2nsbKVBAiZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZloJXQAKCRB4tDGHoIJi
0q+NAQDg7dQm4yIuqIpJJUx6xVHNdm7QHRH1oZhb6KTvKdauPAEAjlDPmXth3suH
EyUEa4xRA2F6Bpo7l3BF2i0FndH74gw=
=J8qv
-----END PGP SIGNATURE-----

--xt66x2nsbKVBAiZs--

