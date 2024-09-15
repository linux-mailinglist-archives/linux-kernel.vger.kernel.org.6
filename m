Return-Path: <linux-kernel+bounces-329839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC0979696
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C6C1C20F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038A1C57B8;
	Sun, 15 Sep 2024 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XAZOisIj"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86D13DDA7
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726403137; cv=none; b=Uk++xfVG1vQlzqhlfpla5Yk59XDeVzRdqxUoAU4s8jytK35ImGz5A6BKF9hyebYZI6/ILTm7wOl1sbQmej3tVbqATsK4MFu3qyApe4pbuOyfONqUVcnjkdrEkZ/xdhuop5cE1qZZQghMxOfUBAwD6TIcAwmbEC5DkqzDbW1AbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726403137; c=relaxed/simple;
	bh=8PJTPIBa5bZwJbOzVWXJHDJMVVUpft1y4CUxWssOzs0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8zamhiasnprerckIUzK7+io2QXDqaiPr/Tnyt+IJN973/NN870J9sbdiLwQwEROIPkenf8PDYuh/Vm+FZ6nkyP5tKLxV2k7yhdKg/CgI6vnHFDkG8In4MPNqomWdvrcSUHuIaZiVKogVeXkFm+abZxlfMNp7Fy9j9CK0eaXU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XAZOisIj; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726403130; x=1726662330;
	bh=ohuHPs8uppnIZ5YHqXrpeVgM3lV+MvcBIFytkXKJ1jI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XAZOisIj0RVAkX3upqZA77IxipbkfJFEHmEyT2O8QbcqluQTw0+e96PP9qWodle0A
	 pVXjWc6vKxh8dV4wdCadDycjqeKtPpNGLLzOVYSWQ7yC/RdsjDtznwa2RKaduQAM8H
	 ZGgHvDLHkb6/trZAPTaKih5Nca53g4uaDDL3H3BoLXlAv4wyT9a9DzV2ErmX8iaFLO
	 YyOYAfmVf8Di4OqVpg9+tkHhzSWUYAaPqIlzITctws3HoufC8eNWrelSrWn52EbVps
	 lSNWyzyt80eKdPNne9QZpo9kQTReba86ahkDxuFLY6Aq+YpVQa3Ot3afdeUhiZJyBb
	 y2FZEcnDzsQeQ==
Date: Sun, 15 Sep 2024 12:25:24 +0000
To: Dave Hansen <dave.hansen@intel.com>
From: John <therealgraysky@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <OCPUzm9NO5UcsvzQfzIazzMh7nymvY5oz3pBojDqEOlhVrYTdYZ35Il0oi8WkwFN7N-1HpCIPXFgQ3MGT7108YhjiBWWv7RqrC40mlW4ak4=@proton.me>
In-Reply-To: <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 6137b1e7108cd70a963505ea14e063583c153b0e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, September 15th, 2024 at 7:40 AM, Dave Hansen <dave.hansen@intel.=
com> wrote:
> If these are going to be exposed to end users, we need some kind of
> help text that helps end users select among these options and what the
> pitfalls are.
>=20
> I actually don't have the foggiest idea what an "AMD x86-64 CPU with v2
> instructions" even is. Even saying "AMD x86-64 CPU" isn't super helpful
> because "AMD x86_64" is kinda a generic way to refer to all the 64-bit
> x86 CPUs, Intel included.

> Why are there v4's for both AMD and Intel that do the exact same thing?

I did it this way to selectively include the AMD-specific and Intel-specifi=
c membership in the config options below.  For example, the AMD options sho=
uld be included in the X86_INTEL_USERCOPY config.

> Why is this copied and pasted six times?
>=20
> + depends on (CC_IS_GCC && GCC_VERSION > 110000)...

I believe the version requirement is needed for each of these new options. =
 Please correct me if I am mistaken.

> Alternatively, anyone wanting to do this could just hack their makefile
> or (I assume) pass CFLAGS=3D into the build command-line. Why is
> something like that insufficient.

I believe this would work:
export KCFLAGS=3D' -march=3Dx86-64-v3'
export KCPPFLAGS=3D' -march=3Dx86-64-v3'

> > config X86_HAVE_PAE
> > def_bool y
> > - depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUM=
M || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM =
|| X86_64
> > + depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUM=
M || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM =
|| X86_64 || MAMD_CPU_V2 || MAMD_CPU_V3 || MAMD_CPU_V4 || MINTEL_CPU_V2 || =
MINTEL_CPU_V3 || MINTEL_CPU_V4
>=20
>=20
> is rather silly when M*_CPU_V* all:
>=20
> depends on X86_64
>=20
> right?

True!
=20
> So, taking a step back: Please convince us that this is something we
> want to expose to end users in the first place, as opposed to having
> them hack makefiles or just allowing users a string instead of using the
> existing CONFIG_M* Kconfig options.

This was just the logical extension of the already included and now antiqua=
ted options, for example pentium-mmx, k6, etc.

