Return-Path: <linux-kernel+bounces-216432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3AD909F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB501F23929
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813D45979;
	Sun, 16 Jun 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7bp7BwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D8149632;
	Sun, 16 Jun 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718562934; cv=none; b=bGDJiHTtGNySHLyJsY54G8fAbfOczl07rRQjMUqKyEYiLgGQm213dole9cKkssJ/EqJ9uW6LKFF7qzT9CIZWAsA/b2/1YwisVr6ZzFif4ZEy0Dh03T/hVWAYtTGgrTQdpx01MK6SExLTaN5jrgCDm58yq65NDLwDa//OKrrIQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718562934; c=relaxed/simple;
	bh=cCKxq9tl4NR2OLs8Y2/gZJnVAyUm8QjK2yLyN/vAu8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcUlKhUmmfrb6bKANizKZskAejWAHW20aze1CRPY8hrBETY/4zDOr5hoBMZ86IehrMYAag8vCiv00hX6tcfjFjeJL/BU1qXnnb23kLUcMpxsWVI1ededmeqYDankBtb1yfrCnFl2Y76pbQc2sSOkWHN3NW9BN7UCaa+MVMek9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7bp7BwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4654FC2BBFC;
	Sun, 16 Jun 2024 18:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718562933;
	bh=cCKxq9tl4NR2OLs8Y2/gZJnVAyUm8QjK2yLyN/vAu8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7bp7BwVBB+vOxSNNOqc7w2dV0jNV26la3je0nwV8+sOGAfTTTSN6fWzPbOZ1r9LN
	 F5YDnRrFg/9VqG2pQ5kSXyp5SFUti5qSJmKACyDsEoJkFfth8j1rpkrl0kKH7L+Wcc
	 K+zAsBuCfGvqbzCK5OodepGgGt/ZfKu2N7/uikAJ0r4qDnpYxgAxMOLopxik5AewCb
	 CMlEUkR18HKUnS//JSaWImZtEqqn02KAo0H6Jhaf3ThjSXySyUUoTZSUoerLAykQPh
	 +CqyiSBJscTVpketohBAOVWXUTG6uXGow0zuEzBe5aTaKxbQhLW2WOWScoLBvrwFhZ
	 KhZckyCD1a4tg==
Date: Sun, 16 Jun 2024 19:35:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240616-exorcism-computing-e11e26084a62@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hyrkTx1xiIXK1tLb"
Content-Disposition: inline
In-Reply-To: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>


--hyrkTx1xiIXK1tLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:

>  .../sifive,plic-1.0.0.yaml                    |   5 +-
>  .../devicetree/bindings/riscv/cpus.yaml       |   1 +
>  .../devicetree/bindings/riscv/spacemit.yaml   |  24 ++
>  .../bindings/timer/sifive,clint.yaml          |   4 +-
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/riscv/Kconfig.socs                       |   5 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/spacemit/Makefile         |   2 +
>  arch/riscv/boot/dts/spacemit/bananapi-f3.dts  |  19 ++
>  arch/riscv/boot/dts/spacemit/k1.dtsi          | 281 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |   1 +

No MAINTAINERS update, so I figure that means you don't want to maintain
it going forwards? If there's someone out that that does care about the
spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
look after it.

Thanks,
Conor.


--hyrkTx1xiIXK1tLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm8wcQAKCRB4tDGHoIJi
0ullAPwIwHO7QvY8o2OTJfZuxL1RvaJtHCpIEcjp5JGF6SHaDQEAyVpJmVs0wZpq
20DChxYrgBQSB7yAGtbtrfsQI4j+5gE=
=dj44
-----END PGP SIGNATURE-----

--hyrkTx1xiIXK1tLb--

