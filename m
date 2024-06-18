Return-Path: <linux-kernel+bounces-219931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 190D890DA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8761F23AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3C1448C8;
	Tue, 18 Jun 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0RpD+rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514E143876;
	Tue, 18 Jun 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730325; cv=none; b=GsGgbI2UwHDqHb9ZPqpAsVCkhzVw6UeEQbrxrltAAzAONiCEocokl94wnRp57U3lWYfvpwRtqwFK2OTpPGjSR7Ny6dY3/N/r++iZXmHCcbxI9sqKkizCoT0KI4UNjEhxYvOauJrL5WGiu8q00ud0gFxHTBf+4XII7ephdBE4yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730325; c=relaxed/simple;
	bh=JquywNTKPX5QUQzK0Z8qnVuMwB5TBtbhostjnazELj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mouhbm2w8v0ZemYRuwZ3WdbRPPAuwtJPv1BqDy5GYpEe2QxdWBP37L0rLa40wyRZDVyCYXyNkacLWITwNnxZla2nS9Kbozw6WyB9VVa52KMGZEFC4ybHw4S022r4UnhyQqjgfOg88FD0mFNKWjnG35aK3qyFDSJOkMumYwjG9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0RpD+rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B60C4AF1C;
	Tue, 18 Jun 2024 17:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718730323;
	bh=JquywNTKPX5QUQzK0Z8qnVuMwB5TBtbhostjnazELj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0RpD+rv57DLs/GLyn6oBA+H3K7Syjjxgh5bWWh3Y7ieVyQgAsw6MoH/8kqCPSRn9
	 vidbB7/rnRh2oMi7Rs5ayBKHFF3+z5Z9CM5uSWqaA2CYmcM9IrllqyQosJFd+1gH2M
	 ubyHmgkqijVZXanlgyja8ClmnuXrs+QeRM/271sgIK5IWLVLz0DOxaz6/cnGHtkxVr
	 u4SNfdzuJqE0rrhg1epUbLMmkUxwu4GS93HVPWRkFFd0sZZflqBWtyUk9/JiZAoZFA
	 ClbnoDk4Pg8OmvyzLPXdxrs0ULypOkZEYfHi2UquBJjVTIIJaGgugcqF7lV+A0Uy68
	 B0I5j8+0WuOKg==
Date: Tue, 18 Jun 2024 18:05:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/9] dt-bindings: timer: Add SpacemiT K1 CLINT
Message-ID: <20240618-retriever-outlying-e7209ff51ad3@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_2A51312A21F88DDB7C7D82A2DA8E8EE7B808@qq.com>
 <20240618-backlands-flaring-f8b8b603868c@spud>
 <tencent_895CC418D210ECC617BE44C17EED3BC72E07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o/ilq4bEQ8dG8Vw0"
Content-Disposition: inline
In-Reply-To: <tencent_895CC418D210ECC617BE44C17EED3BC72E07@qq.com>


--o/ilq4bEQ8dG8Vw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:48:26PM +0800, Yangyu Chen wrote:
>=20
> > On Jun 18, 2024, at 23:40, Conor Dooley <conor@kernel.org> wrote:
> >=20
> > On Mon, Jun 17, 2024 at 01:20:49AM +0800, Yangyu Chen wrote:
> >> Add compatible string for SpacemiT K1 CLINT.
> >>=20
> >> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> >=20
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Actually, I'm not confident about this after carefully reviewing
> the file. The "riscv,clint0" is marked deprecated, and the description
> is For the QEMU virtual machine only.

Right, I forgot about that portion of it. Probably, if this is sifive
plic compatible, then fall back to the sifive clint. Same, I suppose,
goes for the plic etc. The alternative is not have a fallback, modify
the driver, and future spacemit things will fall back to the k1's
compatible. I don't mind which you go for.

--o/ilq4bEQ8dG8Vw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnG+TwAKCRB4tDGHoIJi
0i8xAP9kPV1VZMwXtA842OYL9xVaeu9LyrHcQOF0jq6UsoggfQD/V2NZrL39HZ34
hC/POL8gHioOOkhwLfguC2ZYwPVaZQ4=
=2APS
-----END PGP SIGNATURE-----

--o/ilq4bEQ8dG8Vw0--

