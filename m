Return-Path: <linux-kernel+bounces-220885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8590E896
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76935B22B86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514282495;
	Wed, 19 Jun 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYPkCoIR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2978C7F;
	Wed, 19 Jun 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793910; cv=none; b=AuOMVqDG1qqVbRG5o/ZPIpG+BZipPf9NuZd/Pt2rJaZtaQe3HppKUs9j981NhiRlIiYm6lVwSg4OumDsyj2dtHzkby2dbhd88HOADmb7AYPYenfdoAaIeTZmBMjAq6RisHkUaHJCVcsWBAVrMd1Q4xXEzRFm2blR/m3gzE9KnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793910; c=relaxed/simple;
	bh=m/42kz6hNTn6MqTGY9qBPMBvXRlNx8ar0bAXDpWRTU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyVPI/l7yVYtbfACfaFVbV/2td1Xw+4+/QQHWHNF0Y24qsUc3trjTyPJxGFPDei4mZjp7IIZJXP1iCO+FlZ87f4E28oq5fh95cMjsFSIlicAYpl9xPqxm7EXQv923BcbzGQXG9PKc/nrvMHO4/VUyik7jEsx7k2mbAquiONzjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYPkCoIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0EBC2BBFC;
	Wed, 19 Jun 2024 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718793909;
	bh=m/42kz6hNTn6MqTGY9qBPMBvXRlNx8ar0bAXDpWRTU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hYPkCoIR708kJkT8Wq3wHe7CVObj70KadAEHmK5gDGDjGeONeSBM7tts/4s0y8M7X
	 4fkxwFCorNcneU5wfxB083IpqAOYbpopDbACxgrqvwLbUEP5r+2TdSVjJdmgs7u9b8
	 bRfiwWoqmovccVIvMXlVonjVMPmO3OqxypkzoQkPFuNhDvs/5pS0x99IzCN1HjfcEl
	 HKbvld0um/3pkXpd6O33RB9sanLb5MVWZFG+oSGXMb39NFsWqUsvzmfcHJP97xEsc5
	 18LLHWSFGoqZhf0QFNygkPyq4yj0jR5VQxQvw0b0ClNpOW9pTvnS9POo+MBu7eU/wR
	 8iB7DwjRYqBKw==
Date: Wed, 19 Jun 2024 11:45:04 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org, Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v8 0/6] riscv: add initial support for
 Canaan Kendryte K230
Message-ID: <20240619-hammock-drum-04bfc16a8ef6@spud>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
 <20240410-unwoven-march-299a9499f5f4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tviL4D2HBG1f+vga"
Content-Disposition: inline
In-Reply-To: <20240410-unwoven-march-299a9499f5f4@spud>


--tviL4D2HBG1f+vga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:30:25AM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> On Mon, 08 Apr 2024 00:26:58 +0800, Yangyu Chen wrote:
> > K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
> > support for it to allow more people to participate in building drivers
> > to mainline for it.
> >=20
> > This kernel has been tested upon factory SDK [1] with
> > k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
> > locked pmp and successfully booted to busybox on initrd with this log [=
3].
> >=20
> > [...]
>=20
> Applied to riscv-dt-for-next, thanks!
>=20
> [1/6] dt-bindings: riscv: Add T-HEAD C908 compatible
>       https://git.kernel.org/conor/c/64cbc46bb854
> [2/6] dt-bindings: add Canaan K230 boards compatible strings
>       https://git.kernel.org/conor/c/b065da13ea9c
> [3/6] dt-bindings: timer: Add Canaan K230 CLINT
>       https://git.kernel.org/conor/c/b3ae796d0a4f
> [4/6] dt-bindings: interrupt-controller: Add Canaan K230 PLIC
>       https://git.kernel.org/conor/c/db54fda11b13
> [5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
>       https://git.kernel.org/conor/c/5db2c4dc413e

After some discussion on the k1 thread
(https://lore.kernel.org/all/ZnEOU7D00J8Jzy-1@xhacker/, https://lore.kernel=
=2Eorg/all/ZnA6pZLkI2StP8Hh@xhacker/)
I am going to drop this series. It's not very useful in the current
state and there's not really been any interest from people in getting
the platform to a more complete state. Jisheng made some good points in
the k1 thread about the missing clock controller stuff, and I think I'm
going to make having basic things like clocks and where applicable
resets and pinctrl the minimum requirement for the platforms I'm looking
after.

I've thrown these patches into my tree:
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dk2=
30-basic

I do have one of these boards, but I'm fairly limited at the moment between
the various linux-related and work demands on my time, so it's pretty
unlikely that I'll do anything with it myself.

Thanks,
Conor.

--tviL4D2HBG1f+vga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnK2sAAKCRB4tDGHoIJi
0tt/AQCA4RD8d7i4TQVvgD4RhBPFMD7pePzjZ5RQ4rDUwNy27wD/etB+0gFOr1td
x05pgSRoL6NCjHdw/hCWjnc1HnlZigI=
=fu4g
-----END PGP SIGNATURE-----

--tviL4D2HBG1f+vga--

