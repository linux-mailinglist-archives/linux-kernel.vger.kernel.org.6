Return-Path: <linux-kernel+bounces-229323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6082916E57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711C91F24663
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A517556F;
	Tue, 25 Jun 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JghGX+/U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F416174EC6;
	Tue, 25 Jun 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333857; cv=none; b=NWBpRgvr8hW0GHhbvzASNjBj7u4mI0k6EdZTBzrOf/lhFlK/aH3xIgzw4dCCpydgOWPIv/W2ZPx7FAHb3X4WcDStlTJa4UkLBSNbrg+2uvISb6bkX8D2jrczPcUVUQCdwpwxeF+Ah/Mo3vguQJ+m8j0DFq7jnlIc/WkwH+Wk/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333857; c=relaxed/simple;
	bh=nJLIEHYA4IU5CnCUPRio4UDoGJzwTZVSu8wm5K4Cqlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDCf9VwFpHoXXZPFL5ntWucPa+2M/8oI+aad34u2JbeFtd0KszZlYabUx0+OFLstGvhHNvNoGrINJhMZWWWEo5Tl3KIQgyVI+o9E5nJU80KM/Kui9a26MSR8E2RfRvX841Hvo+vHYeBWrdI32LJXnNfvdJwKc6k/lRCxBUQUVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JghGX+/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C65BC32781;
	Tue, 25 Jun 2024 16:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719333857;
	bh=nJLIEHYA4IU5CnCUPRio4UDoGJzwTZVSu8wm5K4Cqlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JghGX+/UzSZZ9grhsU4TnutrVjZDSoPsy7SAf2wvic+MK21kl13z6o5UAUb+raiEz
	 /foEtHGQZ5Su2iWL4nLIMqJr2anlULd3PHcIDt8od+bu2A+gsUffbxNC61eJrs0Aa2
	 UJH6V0m2xOCN1VdhlMaAqIcZfj63X3FekS53UVfmSPv6AkKIjs52zAGsMy5ejwoXRm
	 OMTtyuD05m8FujTRkvJztXkKB7S3SevAxnLj10UP6KtY+3Jz7ESvsbGmuWRSsx4Dy3
	 c3Cmw2qVJi1dZF6/Q2YKvUv2vOD7S1PIfmaZqpUqbWyr36/MtKYpebgWoKY45hDWUN
	 OLj6Uf4pLd6zA==
Date: Tue, 25 Jun 2024 17:44:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
Message-ID: <20240625-stumbling-fraternal-f7b0a9394d85@spud>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud>
 <20240619-hammock-drum-04bfc16a8ef6@spud>
 <tencent_B61C9F718362BC42F61A8BF95A046BB44D09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TyYuCF/ln5ypIBL+"
Content-Disposition: inline
In-Reply-To: <tencent_B61C9F718362BC42F61A8BF95A046BB44D09@qq.com>


--TyYuCF/ln5ypIBL+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:04:22AM +0800, Yangyu Chen wrote:
>=20
>=20
> > On Jun 19, 2024, at 18:45, Conor Dooley <conor@kernel.org> wrote:
> >=20
> > On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>=20
> >> On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> >>> K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initi=
al
> >>> support for it to allow more people to participate in building drivers
> >>> to mainline for it.
> >>>=20
> >>> This kernel has been tested upon factory SDK [1] with
> >>> k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
> >>> locked pmp and successfully booted to busybox on initrd with this log=
 [3].
> >>>=20
> >>> [...]
> >>=20
> >> Applied to riscv-dt-for-next, thanks!
> >>=20
> >> [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
> >>      https://git.kernel.org/conor/c/64cbc46bb854
> >> [2/6] dt-bindings: add Canaan K230 boards compatible strings
> >>      https://git.kernel.org/conor/c/b065da13ea9c
> >> [3/6] dt-bindings: timer: Add Canaan K230 CLINT
> >>      https://git.kernel.org/conor/c/b3ae796d0a4f
> >> [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
> >>      https://git.kernel.org/conor/c/db54fda11b13
> >> [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
> >>      https://git.kernel.org/conor/c/5db2c4dc413e
> >=20
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
> >=20
> > I've thrown these patches into my tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=
=3Dk230-basic
> >=20
> > I do have one of these boards, but I'm fairly limited at the moment bet=
ween
> > the various linux-related and work demands on my time, so it's pretty
> > unlikely that I'll do anything with it myself.
> >=20
>=20
> OK. I understand about this. I do some initial support for K230
> only for my evaluation purpose and propose this tree to provide
> information for others to boot up a minimal kernel and also have
> another patch [1] to have a USB node so we will able to run a distro
> like Debian over NFS rootfs by USB ethernet which is on canmv k230
> board.
>=20
> But I want to say I may have no time to do further driver development.
> I have done this for my evaluation purpose to get some performance
> metrics on real RVV chips for research usage since I=E2=80=99m a Ph.D.
> student focused on computer architecture. I have to devote my time
> to my research work.

And thanks, in particular, for doing the initial k230 work. We've got
something that boots without having to use the vendor extensions which
is great :)

>=20
> If anyone wants to do some further driver development, please don=E2=80=
=99t
> hesitate to do so. Don=E2=80=99t imagine I may be doing this, so you may
> do duplicate work. I=E2=80=99m too busy to do that.
>=20
> [1] https://lore.kernel.org/linux-riscv/tencent_E9B853316D217B8D1E7CDF828=
8DA5E8ED908@qq.com/


--TyYuCF/ln5ypIBL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrz3AAKCRB4tDGHoIJi
0sQWAQDfn54lFkCjyP8U5q1lfs/UhLsBZGHTbF1RRKKxih1jDwD/YuoQA5ibTmej
bxDLvE1+f2tDcTdTX+L/rwmEH0gRyAI=
=SDQ6
-----END PGP SIGNATURE-----

--TyYuCF/ln5ypIBL+--

