Return-Path: <linux-kernel+bounces-255430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDA9340A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FA0B21E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC071181D0C;
	Wed, 17 Jul 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O04iYQcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA66FB9;
	Wed, 17 Jul 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234370; cv=none; b=JJBcD96LjK9bh55vc0ZUL84MB+v+iIlTuIuox6XLKvZRUWL/xVokfQOETX68CYZzj2JyeQloAnd4h+b6r2J8bhuRodQNLFmMi/XgoU9kqeS+zj8r76ZzQqYaW7CKd7VAh1w+zW+8RD4ukWwFYHnNrOxb1ca/Ayiqe6g8OVpBedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234370; c=relaxed/simple;
	bh=YH/ejPCzozWh3/5AWbT/wAkKuaoN0u4W+macH1mMRsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRoOIiO6txLqDFzdwmaNOPSsIRw5MC2SnOu8ByZ+2Pp93jfuzj+ni/vhHGjnt9c/NMYlZ2VnJfMfQC1fLBR/TLJMT/jHVRvmp2qc9X6kWjQcDPqIYs+UDKFD6RTQaGr6NC1XFEapdz7MnfUTp46zi0FxzkRmCl60Zt8IQpwjULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O04iYQcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B36AC2BD10;
	Wed, 17 Jul 2024 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721234369;
	bh=YH/ejPCzozWh3/5AWbT/wAkKuaoN0u4W+macH1mMRsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O04iYQcHPl5FL6N8sUdE+q+FxTnXMHv1ATmczRdlil8B/W2PQm7sAL1AIzB5XEOAO
	 P0kqoQmjdD/m5QpdXW1fpweEZ3LiWrlPkyeXlDDR6oHczma/MVRYvHHYjlqsW3pl4z
	 X/BhkhsxdHoGYaquZ78lyq6hQo0jcufT9NWzuhtxg2KmqwiRIUwHJHK6E8zFGp+aWO
	 v327eLhiEMDNCP/ZVe5LFr9/YAI67NjFUmK4OFsxwdCAtP0lWx7/ka5ahwtlWUvgKd
	 tmq7jt7E7euAtjvs7lx5+WcXrCAHl4x8uZbOWzxDZNZOWL78eSdYgyvexuG3H4jBYp
	 8mRPh0OnODKSA==
Date: Wed, 17 Jul 2024 17:39:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Otavio Salvador <otavio.salvador@ossystems.com.br>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Otavio Salvador <otavio@ossystems.com.br>,
	Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v1 2/4] ARM: dts: rockchip: remove unlikly-to-exist DAC
 from elgin-r1
Message-ID: <20240717-gracious-canning-6ff715cd1b1f@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
 <20240717-parrot-malt-83cc04bf6b36@spud>
 <3870188.FjKLVJYuhi@diego>
 <CAP9ODKrpKDY91AFDYj7s++kU+=CSLw=F9mXyLZ621Mqq-8S6bw@mail.gmail.com>
 <CAOMZO5C7JknQaftquRWDetLs4W0CHMvs5PiJWBLyo0G1oo4rCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OWGW13PXE3KVG+an"
Content-Disposition: inline
In-Reply-To: <CAOMZO5C7JknQaftquRWDetLs4W0CHMvs5PiJWBLyo0G1oo4rCA@mail.gmail.com>


--OWGW13PXE3KVG+an
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 12:34:03PM -0300, Fabio Estevam wrote:
> On Wed, Jul 17, 2024 at 11:38=E2=80=AFAM Otavio Salvador
> <otavio.salvador@ossystems.com.br> wrote:
>=20
> > @Fabio Estevam can you check this patch?
>=20
> Correct, the rv1108-elgin-r1.dts board does not contain the DAC.
>=20
> There is an LCD controlled via spidev though.
>=20
> Conor,
>=20
> If spidev is needed, what is the recommended way to describe it in the
> devicetree?

Describe the device you actually have in a binding, and add that
compatible to the spidev driver. In this case, given there's a
particular LCD there, that'll work. There's nothing wrong with using
spidev, it's just lying about what hardware that is there that's
problematic.

Otherwise, when it is an open connector where you can put anything, it's
a wee bit messier... A connector binding is required then, something
like the WIP mikrobus stuff that the beagle lads are working on. That's
far from ready, at least on the devicetree side of things, though so
you need to apply an overlay in your bootloader in that case.

--OWGW13PXE3KVG+an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfzuwAKCRB4tDGHoIJi
0iuDAPwPEHiBf+CrFLYviCQhgaXSwg21qh0Iy2VX/LcKcPGr+QD+JGr9aUClwsTX
KBS41ljoVPgMP9F/i3+On6b1MOR7iw0=
=uuYV
-----END PGP SIGNATURE-----

--OWGW13PXE3KVG+an--

