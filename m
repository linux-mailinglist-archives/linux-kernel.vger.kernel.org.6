Return-Path: <linux-kernel+bounces-272285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3DE9459A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B741F2151C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AF1C0DF4;
	Fri,  2 Aug 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNViO4vI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD91EB4B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586234; cv=none; b=q2c1Ynhuw9AEuSKUAGLeFHO1ENZ099qeszWK9Dj/waMu8nyYVKtAuj5JeKKsJQKVS4n1sMukTtuTgZLZwoCxVBy7/eRG8uyEjypyqagZ7SErc2qRddNO4etLZOmQICGox/WGqiaKxCPlrVLkwAd0JSZjKIuVQ+pZd3T3yFqbUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586234; c=relaxed/simple;
	bh=b3da8a47roN/8v56A+q+bWCYVlxmLmnqVAMz16h0mho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpNTQdhGEAEU5N3cHI9pGk3XmvDi5pAjGPJ8yvdu/b6knH9X8XUXGUSpSfbZeKNs4WDM2OzBL9AY8NQWAXBCKfKflc1rc6XdIo9DfW336af8HPdrq3nKeuk5lKxpDP/VHJwsY8YeKcJMSBSijUgy2UOSJyRL677vE3dZ+v4agE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNViO4vI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69B6C32782;
	Fri,  2 Aug 2024 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722586233;
	bh=b3da8a47roN/8v56A+q+bWCYVlxmLmnqVAMz16h0mho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNViO4vIMbLv2dEIASvpAvSodp+9Jn2znTiyROAbAoqhbOLuIwVa8SLD2qA2Vr0xt
	 RabLRwu9RWRHDK1PP0vQMlitEukABpKOqwPxlB+rQ81rljw54pcwLi6VZhI8bwua6P
	 aHO9CbChmxmf74n+yz+E/r9byZ2o39p/ufWn8pqS7uUe7lnFwBoZTZDfdYan7nBIsY
	 VrU/Pl5avi3ouPvqm1nljHU33c5d7z9YLoC8TKoYvdzVaOGdKmRLxowuvya187/NeA
	 m7LgAjbljbTpchzru+Drmhm5r5dgdRNFTBpu74UqQ/rPQ0QzxIASFSwJNsjR9hzXBz
	 k4r2vVonllGvQ==
Date: Fri, 2 Aug 2024 09:10:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Qingfang Deng <dqfext@gmail.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: Re: [PATCH] riscv: support KASAN instrumentation of bitops
Message-ID: <20240802-showpiece-uneaten-7920dbf75aa8@spud>
References: <20240802040506.712-1-dqfext@gmail.com>
 <16be871d-a52e-4b1d-b579-71ec03a0c81d@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/dkjSIa5W7jBqLZ"
Content-Disposition: inline
In-Reply-To: <16be871d-a52e-4b1d-b579-71ec03a0c81d@ghiti.fr>


--N/dkjSIa5W7jBqLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 07:45:38AM +0200, Alexandre Ghiti wrote:
> Hi Qingfang,
>=20
> On 02/08/2024 06:05, Qingfang Deng wrote:
> > From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> >=20
> > The arch-specific bitops are not being picked up by the KASAN test
> > suite.
> >=20
> > Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
> > headers. They require that arch-specific versions of bitop functions
> > are renamed to arch_*. Do this renaming.
> >=20
> > As most comments are identical to the ones in the instrumented headers,
> > remove them.
> >=20
> > Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>

> Samuel has just posted a similar patch here https://lore.kernel.org/linux=
-riscv/20240801033725.28816-1-samuel.holland@sifive.com/T/#t

Additionally Samuel's patch has the advantage of compiling :)

This one errors with:
include/asm-generic/bitops/instrumented-lock.h:80:16: error: implicit decla=
ration of function 'arch_xor_unlock_is_negative_byte'; did you mean 'xor_un=
lock_is_negative_byte'? [-Werror=3Dimplicit-function-declaration]

--N/dkjSIa5W7jBqLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqyUdQAKCRB4tDGHoIJi
0lS/AP0dN95j4sYFCbhJuqhsXwejhUpB8X3RfrpkwX8DZ2W5VAEA34wRBfnGo0Hs
Td1o6RjF9h/BP7ghwMllDf714Spo4Ag=
=+vA2
-----END PGP SIGNATURE-----

--N/dkjSIa5W7jBqLZ--

