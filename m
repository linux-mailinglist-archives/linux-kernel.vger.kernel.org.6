Return-Path: <linux-kernel+bounces-449162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719239F4ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67741891311
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023A1F37AE;
	Tue, 17 Dec 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHd62dbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE581F239E;
	Tue, 17 Dec 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437493; cv=none; b=r3m+anAiK81lha+SdAXA8TXUA6oKICFq7eMUDocAgo6g3MtrwoXb6es1d0UdIynswWoYwCW5enb7tqkC9i750UdF4uVZZtiUUVWFtwqgcB3elN/VgsSKtGUs6B7pXoQ3hUfITEo/9Psdo/GautUdjNUrzM6GXekahWZMaJv9bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437493; c=relaxed/simple;
	bh=l3pO0JNjMZnsq5a7fujNN45J7lyZ4k2y+vJ1SY7TY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8MhKjrei7F8ng2gpqIYxHMAL6urSORnsZapcJKir10aOBUOL6JAWI+ri4cpNZBB29y/JhKQTtBLamW2mZZ/YqxjOgg5rN7PtdNnScxz/2nAO7UCIGOpWdh+uD1YtwyYpFl8+gbjSvWL+Fl8rZljE+ekBvOQb9JbDs/3tzhRyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHd62dbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72EC4CED3;
	Tue, 17 Dec 2024 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734437492;
	bh=l3pO0JNjMZnsq5a7fujNN45J7lyZ4k2y+vJ1SY7TY2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHd62dbSHGsMXodgZvTZzwmJ2UDPi7EacK6iYpYojnssu3rpfB35y35V5Tf89VQ1C
	 ATZ+aCCQF9kCSU83BOro9SAWJpiKkOkfUHehZ9Lk2Rtp1d3KaW8UytD2pSGKKbnWgd
	 sqgfqcWRmiGq7RF6hTnRxd3vTF08pHhSyzo8+AVMeUEYJoTuhUXUqVCgt4fe1HD4dx
	 WH09moysT5NkgBSZiMfd45xnt0zub6eumb/iPGf4vxwMIwZWWQtq9T6lu0/YP/D1/G
	 Oq/Pd+np/E0hQ3blwzCbhwFUheITRy3pmm8znrwaPdPqWPJ1Xin3UVnG52Y1xIFGSu
	 d4ky/5mZrqjNw==
Date: Tue, 17 Dec 2024 12:11:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Yangyu Chen <cyy@cyyself.name>, Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: hwprobe: export bfloat16 ISA extension
Message-ID: <20241217-fondue-candy-55e7efcf2a5e@spud>
References: <20241206055829.1059293-1-inochiama@gmail.com>
 <20241206055829.1059293-4-inochiama@gmail.com>
 <tencent_8F35B6F07D09566A873982E0E2C76085280A@qq.com>
 <sh3fu66fltjccbygbdxilbos4bi5wqk2cdiihc6ixnodsbxtox@rezkyqnpp5yv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u6IT59OqLX/3bsSB"
Content-Disposition: inline
In-Reply-To: <sh3fu66fltjccbygbdxilbos4bi5wqk2cdiihc6ixnodsbxtox@rezkyqnpp5yv>


--u6IT59OqLX/3bsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 08:40:37AM +0800, Inochi Amaoto wrote:
> On Tue, Dec 17, 2024 at 12:00:23AM +0800, Yangyu Chen wrote:
> > Possible conflict with: https://lore.kernel.org/linux-riscv/20241111-v5=
_user_cfi_series-v8-22-dce14aa30207@rivosinc.com/
> >=20
>=20
> Yeah, I know the conflict. As the time of merging these patch is
> uncertain, what I can do now is to match the upstream code.

The solution is to not worry about it. Palmer can resolve trivial
numerical conflicts like this.

--u6IT59OqLX/3bsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2FqbQAKCRB4tDGHoIJi
0gC6AP93cXtfL2os2Bs1KG8DXZDksw/B4lc/JODm5RYX+90VcgEA0/PtcD5OgyqJ
gwb0h/T9khenIvSYh9EI5eAkKgTSnA8=
=5wZ7
-----END PGP SIGNATURE-----

--u6IT59OqLX/3bsSB--

