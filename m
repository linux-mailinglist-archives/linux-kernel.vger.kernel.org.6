Return-Path: <linux-kernel+bounces-216829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A096190A71A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C441C23CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19FB18C35F;
	Mon, 17 Jun 2024 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ph1k+oPf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72681188CC2;
	Mon, 17 Jun 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609358; cv=none; b=NbJizANCpWSWIvS0aUoXQH6zWT/Z822FuuJ25Vq48TqJaPJId/RwFfRr8QkU4uJuCvBHMLN4+87aYm+P4sI2Ur+jCD2YBauEUpgDiSqfdlR+AZGKDbdgbFZepeA6eEfhpc05pqCIj/OYNGrQ4MhdmDZ6nIWlhprMn9s2h5TaVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609358; c=relaxed/simple;
	bh=/LyDENuvfYDBXxhDzgEz448XxUjV1uQrB6Iyg0sw2yc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9qjEXPzYXMi0zSSAkwTe5/2YHUAfXUIYWMWDA1Nhc25Xk4U+k9oMIJi0L9VTRHRxHTZmeE6+mdj/4dw6T/fjXHw2JXXjX7SrfP8tTtfFOw/KTn6pwZv61fUaE8jm1F4PFtrLqIN0eotr3hQumAd5gLzkrP16fv7FLG2tYJc368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ph1k+oPf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718609355; x=1750145355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LyDENuvfYDBXxhDzgEz448XxUjV1uQrB6Iyg0sw2yc=;
  b=ph1k+oPfcoFKcdhOnAANf4n86RQJ04Oj7ssSTzKyuSpy4szlpKB/Rs5d
   9xuz+hP7+kckhrF/0bbGUl2ylQyNalBVWh536ljWOQ0eJ2w54FhViCll0
   RgptoImv/77w2TUey1LW1nBejc9T2aT49NeaiTLzySqHWRf0TmukV63Js
   zTPuTwddkoWNHO3T0oLtdCaZnVPIo0T7yf0AaVvhwBaC/1AhB7feXovBH
   TdLBkdQ0GYQ5nYUf7j95CAd3s2vk60eyBbloNZNMYXP5JJ3lArTYpOse4
   ACoZ3s2pA3dQutkn/c6TiRwBZwIGxquHXpaKmFGC4tikxdDoxqrO769MG
   A==;
X-CSE-ConnectionGUID: BQubg5HpRrqbLaHVDWvPoA==
X-CSE-MsgGUID: Dt7ztb1mQzeZfIUWRBkoQg==
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="asc'?scan'208";a="28483707"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2024 00:29:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 17 Jun 2024 00:29:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Jun 2024 00:28:59 -0700
Date: Mon, 17 Jun 2024 08:28:41 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	<linux-riscv@lists.infradead.org>, Conor Dooley <conor+dt@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup.patel@wdc.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<devicetree@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240617-margarita-alongside-255cbb09ef59@wendy>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <tencent_2ABAC5E885F8354EF1F9084A6B5B398EE00A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sUdZtwqJCkgb0H8C"
Content-Disposition: inline
In-Reply-To: <tencent_2ABAC5E885F8354EF1F9084A6B5B398EE00A@qq.com>

--sUdZtwqJCkgb0H8C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:00:32AM +0800, Yangyu Chen wrote:
>=20
> > On Jun 17, 2024, at 06:48, Yixun Lan <dlan@gentoo.org> wrote:
> >=20
> > Hi Conor
> > Thanks for bringing this up
> >=20
> > On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> >> On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> >>=20
> >> No MAINTAINERS update, so I figure that means you don't want to mainta=
in
> >> it going forwards? If there's someone out that that does care about the
> >> spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> >> look after it.
>=20
> Actually, I don=E2=80=99t know how to be a maintainer. Should I have to
> provide a new git tree and all the new patches merged to my tree
> and then submit a git pull?

Yeah, in the ideal case :) I wrote a document with information as to
how this all works for new platform maintainers:
https://docs.kernel.org/process/maintainer-soc.html#information-for-new-sub=
maintainers

> Or reuse the RISC-V mailing list and
> just give a review, and the patches come to soc misc tree? I would
> like the latter one.

If you don't have the time/interest/whatever in having a tree, then
sure, I can apply the patches for it. I'd rather have someone look after
a tree themselves, but this option is better than me growing another
platform to look after.

> > Yangyu kind of has limited time, too many stuff for him..
> >=20
>=20
> True. Maybe I can have a review and test the patch in one week.
> However, providing a review and test in 2-3 days is sometimes hard
> for me.

It would be unreasonable to expect a 2-3 day turnaround :)

> > I'd volunteered to help on this if it can fill the gap
> > Also I'd be more than happy if anyone willing step forward to co-mainta=
in..
> >=20
>=20
> Thanks. Really appreciate it.
>=20
> Should I provide a diff like this:
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..718d30996f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19306,6 +19306,7 @@ F:      arch/riscv/boot/dts/
>  X:     arch/riscv/boot/dts/allwinner/
>  X:     arch/riscv/boot/dts/renesas/
>  X:     arch/riscv/boot/dts/sophgo/
> +X:     arch/riscv/boot/dts/spacemit/

If you don't want to apply patches, drop this hunk.

>  RISC-V PMU DRIVERS
>  M:     Atish Patra <atishp@atishpatra.org>
> @@ -21004,6 +21005,13 @@ W:     https://linuxtv.org
>  Q:     http://patchwork.linuxtv.org/project/linux-media/list/
>  F:     drivers/media/dvb-frontends/sp2*
> =20
> +SPACEMIT DEVICETREES and DRIVERS
> +M:     Yangyu Chen <cyy@cyyself.name>
> +M:     Yixun Lan <dlan@gentoo.org>

Jesse mentioned on IRC she was interested in the platform, so maybe she
would like to be involved too.

Thanks,
Conor.

--sUdZtwqJCkgb0H8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZm/lpQAKCRB4tDGHoIJi
0rjzAQDObDEqhK4rTAoVhenfAwjYqm4LfpWxPSOh3FiikvWIoQD/QzjEI0jSU9iU
eybCR5sSqTxdUVDBKVOrOoamqv6EQA4=
=6IiD
-----END PGP SIGNATURE-----

--sUdZtwqJCkgb0H8C--

