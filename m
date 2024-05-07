Return-Path: <linux-kernel+bounces-171623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFBD8BE694
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85E91F227F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E715FD08;
	Tue,  7 May 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqg08yEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679E2F50;
	Tue,  7 May 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093552; cv=none; b=WHvbF69zwonjNQDfVuDG3X2Bcgn3CZf9NPJOpinYAC3ufphmnSja/2AfKPA/XfNrBGJCOS8Movr5NkxWvMt09oEC7Rqu929r5vXJfaaxhBuZSr/yjsE8/lFUAEcp/4rr8CwLMA+ObB3Vl/7OCYxrLRldf0J9+00dsaenstWlTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093552; c=relaxed/simple;
	bh=vSiOef6zREmkg4TqEAN44W/J4gfMWJYXzNIB8ov/k3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJleFDMik0TbaQv6S/1AvCAYZFpYOrIog89eYvE9xCVgGYguJQ7dhW5w7lM2+nDxKTSkdxyoRI3IB9ZdARCDkDmBw3nQSGodE5zV1inT+/weRX5CZdleH18p04LjspaCAegGwHaRsC6QNbZ4UcFKf7SSSXztVdsCHFv79M8Q704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqg08yEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EA1C2BBFC;
	Tue,  7 May 2024 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093551;
	bh=vSiOef6zREmkg4TqEAN44W/J4gfMWJYXzNIB8ov/k3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zqg08yEy7OEo5mBUxP4QVS+dnbvHJX3CbDzRG0ecZ67agq7Yj2WuqgbHMWHspUvAl
	 uTZLeX5bhQXLYYHDHN20+1i43+uOwgxsodurDXtrKLunDhSG9kWNFeP7+GbD+Ab3bj
	 wGuEfwC8RtngRPl9O29Gmo52+IBqmYy5Aei98qwTVMsDGoxFi5McMaQ+kxffdJ7Svu
	 S7oWthQtpk7uTHwzxbcP3tmZS1w1jMHpAPORjZ50APqUABxC76/kKQLoh/2AVsTXeX
	 vDWaE3iWq3RWuRXvFO6YcEvgiaFghEiyr22o6m7SVMegjoMg96rNYpGFkAb/76W/qt
	 Ipg0gcL2+rKIg==
Date: Tue, 7 May 2024 23:52:28 +0900
From: Mark Brown <broonie@kernel.org>
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	tglx@linutronix.de, ardb@kernel.org, anshuman.khandual@arm.com,
	miguel.luis@oracle.com, joey.gouly@arm.com, ryan.roberts@arm.com,
	jeremy.linton@arm.com, ericchancf@google.com,
	kristina.martsenko@arm.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, akpm@linux-foundation.org,
	bhe@redhat.com, horms@kernel.org, mhiramat@kernel.org,
	rmk+kernel@armlinux.org.uk, shahuang@redhat.com,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	sumit.garg@linaro.org, frederic@kernel.org, reijiw@google.com,
	akihiko.odaki@daynix.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 1/8] arm64/sysreg: Add definitions for immediate
 versions of MSR ALLINT
Message-ID: <ZjpALOdSgu-qhshR@finisterre.sirena.org.uk>
References: <20240415064758.3250209-1-liaochang1@huawei.com>
 <20240415064758.3250209-2-liaochang1@huawei.com>
 <ZjUKMWPknEhLYoK8@FVFF77S0Q05N>
 <Zjjz-tzLRC2nH51A@finisterre.sirena.org.uk>
 <cde4d448-dc9d-eaad-4a2d-a6d34bda4449@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l+aZ4APLeGcXdXqx"
Content-Disposition: inline
In-Reply-To: <cde4d448-dc9d-eaad-4a2d-a6d34bda4449@huawei.com>
X-Cookie: Accuracy, n.:


--l+aZ4APLeGcXdXqx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 03:41:08PM +0800, Liao, Chang wrote:
> =E5=9C=A8 2024/5/6 23:15, Mark Brown =E5=86=99=E9=81=93:
> > On Fri, May 03, 2024 at 05:00:49PM +0100, Mark Rutland wrote:

> >> +#define set_pstate_allint(x)           asm volatile(SET_PSTATE_ALLINT=
(x))

> > Hrm, those helpers are not ideally discoverable, partly due to the
> > system register description for ALLINT not providing any references to
> > this being a general scheme (which is fixable there) and partly due to

> Based on the Arm ISA reference manual, the instruction accessing the ALLI=
NT
> field of PSTATE uses the following encoding:

I'm not saying the suggestion is wrong, I'm saying that between the ARM
and the way the code is written the helpers aren't as discoverable as
they should be, like I say from a code point of view that's mainly
because...

>                     op0  op1   CRn    CRm    op2
> MSR ALLINT, #<imm>  0b00 0b001 0b0100 0b000x 0b000

=2E..we only have the encoding for the MSR and don't mention the letters
'msr' anywhere.  We should improve that to say what we're encoding in
the code (in general I'd say that's true for any __emit_inst(), not just
these ones).

--l+aZ4APLeGcXdXqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY6QCcACgkQJNaLcl1U
h9BivQf/QjNOMgHqmu7UcLWTGZ4Cdsxv0NPRW008VrPJCXISVIc/pWczJCP9gm1S
DZVr2Mp961MBiWixhmEKzLXogx29ALEBhBL5ImpgAfipQA64gzcbD2+S8F3JGTUb
V/PJF53nqhJd9w9YDs9TukxVmstjG6TYGMi28fdCOOsjd4QfMxq1MIHXmobPqm5u
eyt1WHI1eqX5+/y3AIytni/LoyzglsvZ9V15GnBVTAFlMykf+aeWX0wWxTmydEXS
OxulKo1wpSxKQDd9f9oNCiPLY0m0ZRqXRunt0/4ICmy2nvV0VVZ4Vsi41W4KA9AN
4ORObDb31r07sFNa8JRKkjBgtYKA9g==
=OEcE
-----END PGP SIGNATURE-----

--l+aZ4APLeGcXdXqx--

