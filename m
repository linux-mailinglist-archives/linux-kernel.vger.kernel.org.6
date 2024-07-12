Return-Path: <linux-kernel+bounces-250715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DAD92FBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E228B228FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3717166A;
	Fri, 12 Jul 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6UHG8RJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2BF17165A;
	Fri, 12 Jul 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792131; cv=none; b=n2bH+WOZme8R34vgjKMnB9yuoVA5kJ697rkcG0Q8lAnSSvol9KD/wKJ0KzrXriVhpu/o4IpzzKvH4ARWZCnR4K0Z+5skvqVAqyhtMiYwjVRMICCH0/hXIYwyM766R3ka8EjYxPiVZC0z6ArKdSa5MckaQY5BrpR61g+wY6DmmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792131; c=relaxed/simple;
	bh=UAVO/gXLGNIHoqILwVTdS3n2/0dHqnDhY4+Q6hSW59Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfI1LuohUHJxJSisAKFD9AUSIOgM4lQXtteLQXmlbge09Ss3GEdeMzReJYOEOmLY8+LD854V5U5/2KuvdYB4WxVwYHZxp+uD7WgUoY3u0fVwAQaDlkdopi9rz2XmNwPKGhOctUbRVOTjlgOFfdYK8lwAvJPcCdH0GC1FZtfhTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6UHG8RJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A787C32786;
	Fri, 12 Jul 2024 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792131;
	bh=UAVO/gXLGNIHoqILwVTdS3n2/0dHqnDhY4+Q6hSW59Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6UHG8RJDoFnnQ1f++vKtWyN5wGmHFUPPQu7B06L3suYJ9aksheWYADKe5WhqdJVH
	 hFUGrkLQy5HxvKtSAJfXm3D3SGLWQtgdjBcltgTJNcjzp1OZjYCfN7JITz9ozBySVb
	 m1wdwky67VAbo9fTQkNNVXJK3Awq2l1vvCkmbhou5D65gyV8FqwMy5JcljY0BldpgE
	 G/WB/8MLfZDIVIwmTu0J4+bag+/Vsgf5X8klPWJ4YDOLhxUr60/gBgdOxQboyMrPxo
	 SeBjRkCOTCyBDAzQ9qpwQnlNIxF+Vyhw9l2apKyqlxk3bva98RqGfjtdcbZ+0E7VcE
	 sgvrTu5KvZo4Q==
Date: Fri, 12 Jul 2024 14:48:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Drew Fustini <drew@pdp7.com>
Subject: Re: [PATCH v3 1/1] riscv: dts: thead: add basic spi node
Message-ID: <20240712-denote-disprove-ce271b70c78c@spud>
References: <20240705093503.215787-1-kanakshilledar@gmail.com>
 <20240705093503.215787-2-kanakshilledar@gmail.com>
 <CAGLn_=tT08KUX0J+WURq=EXKDPj=--Wg3qmCjnzGxNeMcz3NOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TVaUuin2MQ5RhBaQ"
Content-Disposition: inline
In-Reply-To: <CAGLn_=tT08KUX0J+WURq=EXKDPj=--Wg3qmCjnzGxNeMcz3NOg@mail.gmail.com>


--TVaUuin2MQ5RhBaQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2024 at 02:11:18PM +0530, Kanak Shilledar wrote:
> Hi,
> Any updates on this patch?

It's too late for 6.11, it'll have to wait until 6.12. If Drew has his
tree set up already, he can at least queue it.

Cheers,
Conor.

--TVaUuin2MQ5RhBaQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpE0PgAKCRB4tDGHoIJi
0rtMAQCWJsLbWrTJXYut90rqVRHP9fRSrbjQdZDQo5ZoXTEV1QEA/54A9PCC3MiB
dTITiySq8lWR2Wr/Z+OPHYT1jvO59Qo=
=ocR0
-----END PGP SIGNATURE-----

--TVaUuin2MQ5RhBaQ--

