Return-Path: <linux-kernel+bounces-226342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB5913D47
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3898C280D39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35CC183093;
	Sun, 23 Jun 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuWYOZae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD322F4A;
	Sun, 23 Jun 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163928; cv=none; b=AS0xVuFbKQPN8P6AtSJt6Vk5fW6K/L8TT81FsfrBMorDSA68nOuqa3zqjWSR8+vCP/DzVHD9mjKwJnkOr0G2IfXWjIJ6OAKEkG3RmJEb35IBKccGQ0wdBiQ2zqeSYupkVn5m+rrwZduKtEVhQ0LDg5zQMlXo1GNUxwxQm22ZVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163928; c=relaxed/simple;
	bh=4RpJrjP+HQ5Hl1Kqa2ZS0D5BRTr/aIQgYxzQ18Gv6Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBTLbGGHAGR9EdftutUEbtuz96u6OUy0oqDX/tX7TkNVYgUrLF3HBZ6vu4QqK2XHJK+QaFfL/BrJq3mLr6XNFj9r6rflvs2wM4nIENRLgmD/CGEPCC6AR9DadX+6JctBYtvvBBN/kbBkWLME4zImGYwyXiBpMI4uRxdpDhJWnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuWYOZae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F0BC2BD10;
	Sun, 23 Jun 2024 17:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719163927;
	bh=4RpJrjP+HQ5Hl1Kqa2ZS0D5BRTr/aIQgYxzQ18Gv6Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MuWYOZaexDplPuJDc+7/dS2pRInpaHtqdO/USSBExy4BnfhHi50WuTSF3LFLSlrRX
	 tDErip4tn5+MChXWdqew174rDb9UI/7FmWF3xXZyFg1irIbp1gUfLDxXNVXUQ7ek2M
	 X5BqBF10FBSWbNv1D8rgk2b+CN2Usrh7Umi1f/nvdNyLwQZaEDnbyKmqM1n1UlhZWz
	 vifXql/SG9nSlfYNwJx8fM0INI/CGsZwmf1qpwh2tCXS8j/56v9kZlkZfGMcJyE5Vu
	 bUoGxg/KcKDNF4IRFUdyM0o86FWD06VkHC2Hz/VGxUw2cCBQnj1Q6TP8zZg8PROKZJ
	 sNJwt9JEo/lPQ==
Date: Sun, 23 Jun 2024 18:32:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org, Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
Message-ID: <20240623-graveyard-consonant-97eff0f11808@spud>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud>
 <20240619-hammock-drum-04bfc16a8ef6@spud>
 <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7CnmFpihGKPoqw+z"
Content-Disposition: inline
In-Reply-To: <CAJF2gTRYpDLij1aQoftz6ZqEgXDrfhNA39KiFVrwm7qc4WH6Fg@mail.gmail.com>


--7CnmFpihGKPoqw+z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 01:07:55AM +0800, Guo Ren wrote:
> On Wed, Jun 19, 2024 at 6:45=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> > > > K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add ini=
tial
> > > > support for it to allow more people to participate in building driv=
ers
> > > > to mainline for it.
> > > >
> > > > This kernel has been tested upon factory SDK [1] with
> > > > k230_evb_only_linux_defconfig and patched mainline opensbi [2] to s=
kip
> > > > locked pmp and successfully booted to busybox on initrd with this l=
og [3].
> > > >
> > > > [...]
> > >
> > > Applied to riscv-dt-for-next, thanks!
> > >
> > > [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
> > >       https://git.kernel.org/conor/c/64cbc46bb854
> > > [2/6] dt-bindings: add Canaan K230 boards compatible strings
> > >       https://git.kernel.org/conor/c/b065da13ea9c
> > > [3/6] dt-bindings: timer: Add Canaan K230 CLINT
> > >       https://git.kernel.org/conor/c/b3ae796d0a4f
> > > [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
> > >       https://git.kernel.org/conor/c/db54fda11b13
> > > [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
> > >       https://git.kernel.org/conor/c/5db2c4dc413e
> >
> > After some discussion on the k1 thread
> > (https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, https://lore.ke=
rnel.org/all/ZnA6pZLkI2StP8Hh@xhacker/)
> > I am going to drop this series. It's not very useful in the current
> > state and there's not really been any interest from people in getting
> > the platform to a more complete state. Jisheng made some good points in
> > the k1 thread about the missing clock controller stuff, and I think I'm
> > going to make having basic things like clocks and where applicable
> > resets and pinctrl the minimum requirement for the platforms I'm looking
> > after.
> Here is the k230 clock driver based on Linux-6.6:
> https://github.com/ruyisdk/linux-xuantie-kernel/commit/196242fd9b9b4a191d=
ab0c7c3c5bf851ed857d8d
>=20
> pinctrl:
> https://github.com/ruyisdk/linux-xuantie-kernel/commit/baf26b6622c9de2ff6=
4a6ed58eeeb98c8b2c828b
>=20
> No reset driver.
>=20
> Most of the k230 drivers are under Linux-5.10, and we are porting them
> into the newest version of Linux, which takes time.
>=20
> So, if the clock & punctual drivers mentioned above could satisfy the
> minimum requirements for the platforms, we will update the version of
> this series as a supplement.
>=20
> Is that okay?

I don't understand how that changes anything, these are all out of tree
drivers based on an old kernel. I know that there are drivers for a lot
of the peripherals that are in-use in the vendor tree etc. What I am
looking to happen, before I apply patches for the k230, is that the clock
dt-bindings will have landed in linux-next - and ideally the pinctrl ones
too.

Thanks,
Conor.

--7CnmFpihGKPoqw+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnhcEgAKCRB4tDGHoIJi
0o3gAPwIKqvtW8/ntyAJ2oP0W/Qxo6lOiR4/hpCuM7YY2syHAwD+K9UEOGv9IGnf
S+SPP1Ff/veVlNcIm6//1+yG3FV6dwQ=
=J+o1
-----END PGP SIGNATURE-----

--7CnmFpihGKPoqw+z--

