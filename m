Return-Path: <linux-kernel+bounces-529291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE81A422D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38043B491F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BC1519B0;
	Mon, 24 Feb 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Lx0TWNAf"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45814D28C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406206; cv=none; b=GOc+1tr4YGi68GBCr/xiL47ioYGufwKnMEmSytHjsPclBB2sIIRTrdEOeX/x02Ud+C00PNcHiCD6V74L+taD62PcQ5Ek4ml5030OOPVDgb/7RjTqJHm6smfbqME13NnNG31djzPGk2vz1ccWcaFpnQ86fGz5Xecr2rBqH1hAEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406206; c=relaxed/simple;
	bh=HnSEhuTIXi0xEJPiLl93d5orRgsQ3EAPZVCCkYSS4Lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZqOPpj6/0DaQU30cSu+lExJK9/GwCZRHo3tctxmgiIVKDWiIoigcrjjtZ/iGbRzX9kOuOJWZrpcDc1rJTXKyrE13S88se/yeMAmFtiOTUnlM5VmcdjMXhcCcmNR+0SbeogJ9UaAFcqSDJEHEDfNiDwroHTKEa2RKiL6SOctUB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Lx0TWNAf; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740406203;
	bh=7BSvEQjr8ICbU0tQIQzNSwxDzW8DS5PIxkIDb9EMHLY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Lx0TWNAfqQvVVNqNlfV2wWd85CYtCLG9tk+KSJdw4KjdTDnW7FzchpHrrc5cYJOGw
	 lcFyNWVN9aWI5Vkn1eH60J6WqIlmQlLz+JfMaf801aPMkmhXF+tt6RSNNUeER2Wj2x
	 ONRpPlCalyTuuJfPcNp2Q3J0r5S/8aaK7z4GYbng=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CB7D01A413E;
	Mon, 24 Feb 2025 09:10:01 -0500 (EST)
Message-ID: <69007e7142414d281617c1edb7444b18f53fd1f0.camel@xry111.site>
Subject: Re: [PATCH] RISC-V: vDSO: Wire up getrandom() vDSO implementation
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley
	 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren
	 <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 24 Feb 2025 22:10:00 +0800
In-Reply-To: <20250224150345-46f09b09-3d94-41bf-850c-6188d21750bb@linutronix.de>
References: <20250224122541.65045-1-xry111@xry111.site>
	 <20250224150345-46f09b09-3d94-41bf-850c-6188d21750bb@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-24 at 15:07 +0100, Thomas Wei=C3=9Fschuh wrote:
> Hi!
>=20
> On Mon, Feb 24, 2025 at 08:25:41PM +0800, Xi Ruoyao wrote:
> > Hook up the generic vDSO implementation to the LoongArch vDSO data
> > page
>=20
> LoongArch?

Oops, pasto by "reusing" my own words in LoongArch commit :(.

> "to the generic vDSO getrandom implementation"
>=20
> > by providing the required __arch_chacha20_blocks_nostack,
> > __arch_get_k_vdso_rng_data, and getrandom_syscall implementations.
> > Also
> > wire up the selftests.
> >=20
> > The benchmark result:
> >=20
> > 	vdso: 25000000 times in 2.560024913 seconds
> > 	libc: 25000000 times in 40.960524767 seconds
> > 	syscall: 25000000 times in 40.380651864 seconds
> >=20
> > 	vdso: 25000000 x 256 times in 171.830655321 seconds
> > 	libc: 25000000 x 256 times in 2913.107080132 seconds
> > 	syscall: 25000000 x 256 times in 2692.084323377 seconds
> >=20
> > Note that it depends on Thomas Wei=C3=9Fschuh's vDSO generic data stora=
ge
> > implementation (now in the timers/vdso branch of tip).
>=20
> The note should be below a "---" line, so it doesn't end up in the
> commit.

>=20
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0arch/riscv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0arch/riscv/include/asm/vdso/getrandom.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 30 +++
> > =C2=A0arch/riscv/kernel/vdso/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> > =C2=A0arch/riscv/kernel/vdso/getrandom.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> > =C2=A0arch/riscv/kernel/vdso/vdso.lds.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0arch/riscv/kernel/vdso/vgetrandom-chacha.S=C2=A0=C2=A0=C2=A0 | 24=
4
> > ++++++++++++++++++
> > =C2=A0.../selftests/vDSO/vgetrandom-chacha.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A07 files changed, 294 insertions(+), 1 deletion(-)
> > =C2=A0create mode 100644 arch/riscv/include/asm/vdso/getrandom.h
> > =C2=A0create mode 100644 arch/riscv/kernel/vdso/getrandom.c
> > =C2=A0create mode 100644 arch/riscv/kernel/vdso/vgetrandom-chacha.S
> >=20
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index aa8ea53186c0..6fdd63e15fb4 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -213,6 +213,7 @@ config RISCV
> > =C2=A0	select THREAD_INFO_IN_TASK
> > =C2=A0	select TRACE_IRQFLAGS_SUPPORT
> > =C2=A0	select UACCESS_MEMCPY if !MMU
> > +	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO
>=20
> Broken alphabetical ordering.

I'm still investigating some CI failures (at lease some of them seem not
just caused by missing the generic data storage implementation).  I'll
fix them and the errors you found in V2.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

