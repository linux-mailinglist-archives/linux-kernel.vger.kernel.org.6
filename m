Return-Path: <linux-kernel+bounces-556692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF61A5CD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF9B7ACA96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC62F19E975;
	Tue, 11 Mar 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7zWJ2ue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BFA2627EC;
	Tue, 11 Mar 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716765; cv=none; b=Y+Chv6JroXMVLpLX8LxN5+NIuu3OypmEEonQevtT34Ex/bl15oyKjnFcdAVwA0T5MfANH6yuSBtwBkM+eRV913IjNPxV7AbDGGZaFNvCyzB5YFcn1l/Ixa3RKi0GO5FRxzZLdfu9KNE+VX0MV9UqQIsse+6glAdVXG06YS1z+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716765; c=relaxed/simple;
	bh=wPq2NGfQNN84hMUqF0se/g6r/peCVY5UmFIk+kncgPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pr7fOsco1zr0reBSmPhyLGw6kbXg0Ql8KsdrnUWa8y5KMBvOhpD1gOxhhB5SO2GGMEPcnOpKhR634omWcqbwW3kT8zstXhDH85l0zX5vRkZRP4ShDDoIpi1jf5xeU5SRdJR1MVQe+LYn2SAnx85cGt4jShbSlOBZJBHTNCtHuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7zWJ2ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE6C4CEE9;
	Tue, 11 Mar 2025 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716764;
	bh=wPq2NGfQNN84hMUqF0se/g6r/peCVY5UmFIk+kncgPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7zWJ2uejTexWUdWX9K8TlIX+/aRCbORV6/OlKII+cI5KcahRs17fY0VTzA7dGTUy
	 rHLmM/yMkRLNtJRH/MJiDCpd76w7Iivv3UO206j8DvgHRQ1xz+Wn6y4OEEvighIFCn
	 C/1zt0LYTuouMqwhVISC+UB7akU0UzjSx9NbzB1oILXD/dbEOyiqsa2HNQrna6I1tY
	 g9hil6+KL2MoAQrrwQiVizXwh2Wp4387MJgac9XozBkK/E7VT6uBsFB4fx6l9MQgGf
	 VWzJuPHW6jzsG9kj8cp/lskJLYbV9uZGTbp1swp5ceAmE7EG5520JUw5V3ELlx5Zbc
	 KD74n0F2J1n9A==
Date: Tue, 11 Mar 2025 18:12:38 +0000
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
	rafal@milecki.pl, Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dt-bindings: timer: Add ESWIN EIC7700 CLINT
Message-ID: <20250311-clock-yearbook-d27a09466dfd@spud>
References: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
 <20250311073432.4068512-9-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yryHYQAuCVvglLLR"
Content-Disposition: inline
In-Reply-To: <20250311073432.4068512-9-pinkesh.vaghela@einfochips.com>


--yryHYQAuCVvglLLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:04:30PM +0530, Pinkesh Vaghela wrote:
> From: Darshan Prajapati <darshan.prajapati@einfochips.com>
>=20
> Add compatible string for ESWIN EIC7700 CLINT.
>=20
> Signed-off-by: Darshan Prajapati <darshan.prajapati@einfochips.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--yryHYQAuCVvglLLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9B9FQAKCRB4tDGHoIJi
0i0mAP9FcNgiTxknoxVyenYfVlubklsRHYU0VEz0MaqFMjHLWQEAq0zSSzCax/al
dNyPFjnFMEb/jMbSfPJrc2hnYUM16gU=
=6RSo
-----END PGP SIGNATURE-----

--yryHYQAuCVvglLLR--

