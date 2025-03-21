Return-Path: <linux-kernel+bounces-571751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27273A6C1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C8C7AA8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B122DF9E;
	Fri, 21 Mar 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XOFO2P91"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C422D7A0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578714; cv=none; b=qHeI2qkruRSv49XtF784/gmA+MQoOqZkC6GUTXTaFrn/0wD04YYBoTs57VFD2mR0C1wmJQKVusjPiSG2nLXrIpm8+gxMQnOHz1qw6NIqXVFHAdmbQB8B5lKdVQiTMGv+Fkw9hoVmgzpXY/+n0ZjKMD9EG158cq7t9l0tC4lC1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578714; c=relaxed/simple;
	bh=xm4xze+Mgry2vsGYzxkYRwCGnwTVwFISNDnWa19prfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TjQ1uhUa70UqGpGTCBc84pPS4NUwIcE/ipV4v5n6tCn9+LnKgCgkPowYpIbwL8JiyPe9JwGAhjYqoIZUoDaGnXbyhYXK2QemlDTUZcqWBvKXWNztF2fRi7ROOLZUlRsOGHXhT0gnmTVrn3GRVHItGauiEJHTW+LpQMDnAK1XigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=XOFO2P91; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52LHZeiq2773226
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 21 Mar 2025 10:35:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52LHZeiq2773226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742578542;
	bh=9tc2rpnJVbgZT3FicrTz46vHfTy5Cfc580xXSDLi3Ys=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XOFO2P91m02E/5NSHqYVw7SxkElinMVZoMZVSeHpQIZcQoSJsd+Ys+4Ssf7+JLy2q
	 z4lEV90GvbX7Madgs+U3LHZLOT+8qF6EsWG28CV+zBUFlKEBl1OM8+qXdmOAQcZoBl
	 /sAYyTXmrzHmjTdFqytUxKAe5GvwbS7PiLjCV+XT46LbZjsffdvW6d9vp8tOmFhUOK
	 yyTP96+RGzEKp8efA7BBt3AF7GyeC9A2InfPlxSIxKAd1zBenzHbzfZNOVyufUGwKh
	 hDpb6NoBKODM8qjPas1yqghQulTn5Vql5gdBSVMwn0LOIiXiOWFYMV11+lGv6V2J2r
	 RrQuk0rOWWYMg==
Date: Fri, 21 Mar 2025 10:35:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Tor Vic <torvic9@mailbox.org>, arnd@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arch/x86=3A_Add_an_option_to_buil?=
 =?US-ASCII?Q?d_the_kernel_with_=27-march=3Dnative=27_on_x86-64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250321142859.13889-1-torvic9@mailbox.org>
References: <20250321142859.13889-1-torvic9@mailbox.org>
Message-ID: <8FDFA037-06D6-4191-8C31-3D4AC2796EA4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 21, 2025 7:28:58 AM PDT, Tor Vic <torvic9@mailbox=2Eorg> wrote:
>Add a 'native' option that allows users to build an optimized kernel for
>their local machine (i=2Ee=2E the machine which is used to build the kern=
el)
>by passing '-march=3Dnative' to the CFLAGS=2E
>
>The idea comes from Linus' reply to Arnd's initial proposal in [1]=2E
>
>This patch is based on Arnd's x86 cleanup series, which is now in -tip [2=
]=2E
>
>[1] https://lore=2Ekernel=2Eorg/all/CAHk-=3Dwji1sV93yKbc=3D=3DZ7OSSHBiDE=
=3DLAdG_d5Y-zPBrnSs0k2A@mail=2Egmail=2Ecom/
>[2] https://lore=2Ekernel=2Eorg/all/20250226213714=2E4040853-1-arnd@kerne=
l=2Eorg/
>
>Signed-off-by: Tor Vic <torvic9@mailbox=2Eorg>
>---
>Here are some numbers comparing 'generic' to 'native' on a Skylake dual-c=
ore
>laptop (generic --> native):
>
>  - vmlinux and compressed modules size:
>      125'907'744 bytes --> 125'595'280 bytes  (-0=2E248 %)
>      18'810 kilobytes --> 18'770 kilobytes    (-0=2E213 %)
>
>  - phoronix, average of 3 runs:
>      ffmpeg:
>      130=2E99 --> 131=2E15                        (+0=2E122 %)
>      nginx:
>      10'650 --> 10'725                        (+0=2E704 %)
>      hackbench (lower is better):
>      102=2E27 --> 99=2E50                         (-2=2E709 %)
>
>  - xz compression of firefox tarball (lower is better):
>      319=2E57 seconds --> 317=2E34 seconds        (-0=2E698 %)
>
>  - stress-ng, bogoops, average of 3 15-second runs:
>      fork:
>      111'744 --> 115'509                      (+3=2E397 %)
>      bsearch:
>      7'211 --> 7'436                          (+3=2E120 %)
>      memfd:
>      3'591 --> 3'604                          (+0=2E362 %)
>      mmapfork:
>      630 --> 629                              (-0=2E159 %)
>      schedmix:
>      42'715 --> 43'251                        (+1=2E255 %)
>      epoll:
>      2'443'767 --> 2'454'413                  (+0=2E436 %)
>      vm:
>      1'442'256 --> 1'486'615                  (+3=2E076 %)
>
>  - schbench (two message threads), 30-second runs:
>      304 rps --> 305 rps                      (+0=2E329 %)
>
>There is little difference both in terms of size and of performance, howe=
ver
>the native build comes out on top ever so slightly=2E
>---
> arch/x86/Kconfig=2Ecpu | 9 +++++++++
> arch/x86/Makefile    | 5 +++++
> 2 files changed, 14 insertions(+)
>
>diff --git a/arch/x86/Kconfig=2Ecpu b/arch/x86/Kconfig=2Ecpu
>index 8fcb8ccee44b=2E=2E057d7c28b794 100644
>--- a/arch/x86/Kconfig=2Ecpu
>+++ b/arch/x86/Kconfig=2Ecpu
>@@ -245,6 +245,15 @@ config MATOM
>=20
> endchoice
>=20
>+config NATIVE_CPU
>+	bool "Build for native CPU"
>+	depends on X86_64
>+	default n
>+	help
>+	  Optimize for the current CPU used to compile the kernel=2E
>+	  Use this option if you intend to build the kernel for your
>+	  local machine=2E
>+
> config X86_GENERIC
> 	bool "Generic x86 support"
> 	depends on X86_32
>diff --git a/arch/x86/Makefile b/arch/x86/Makefile
>index 8120085b00a4=2E=2E0075bace3ed9 100644
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -178,8 +178,13 @@ else
> 	# Use -mskip-rax-setup if supported=2E
> 	KBUILD_CFLAGS +=3D $(call cc-option,-mskip-rax-setup)
>=20
>+ifdef CONFIG_NATIVE_CPU
>+        KBUILD_CFLAGS +=3D -march=3Dnative
>+        KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3Dnative
>+else
>         KBUILD_CFLAGS +=3D -march=3Dx86-64 -mtune=3Dgeneric
>         KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3Dx86-64 -Ztune-cpu=3Dgeneric
>+endif
>=20
>         KBUILD_CFLAGS +=3D -mno-red-zone
>         KBUILD_CFLAGS +=3D -mcmodel=3Dkernel

You may want to consider this option to also select matching kernel option=
s (which would require probing cpuid=2E)

