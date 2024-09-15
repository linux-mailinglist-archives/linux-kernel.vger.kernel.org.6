Return-Path: <linux-kernel+bounces-329990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344B97983B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B310A1F21B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D3D1C9DDE;
	Sun, 15 Sep 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ViJl8C5K"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A391D2F5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425795; cv=none; b=qDgAIbTIoXS4mgzUmI9U82gRr516A9b+uXlosM93K4NJTiUBpj9A6tZ3+7wADbnCpSD5zYl9k3G9h8+Rgc0oYMwn987UIPj9oUkBZ7ti5VC9VMGxiMxYpIlOvsrd6YWN1tshHNsQ3Z6IGnJoOCzwdnPlGXTZ6UMkxFB7ZwlrUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425795; c=relaxed/simple;
	bh=VmFzIft6ZUj8RtK4CKaBe3rLx/VOdgu6PVoIYRqecoI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1qO4NAG+BZwD9qxEdXGz3xhHmKAiLYoZ9asyURwwaaztGnGENVrDiGPrGLHIZFO5UbtLcYxhDt4ihq8erxzJK4hSxCccSa8zvIR0UFNdf8xdWUaSiyt95VaRvt6KGkXI5njmXc/ziZRNzrZsiwqgX2E2Gekior1o6UnrDgfChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ViJl8C5K; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726425777; x=1726684977;
	bh=a22Sk5MhrMsT33nJV0/hM80OKbc8cT2Gk5ukh7q7DTc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ViJl8C5KRYikiGus8/w0TwN03VyPUNbp3bCfp7gWrYoxBhUCz71ZEExKNU3Ae6KkM
	 g60HfY3xqOxqOUsrStNOZut23BD6gw3/HacIFR7GUTy2YSsusxux5Bo3jRM+7o+/Qn
	 X/8Te1SOrc5Mh7zvEaGoiZqhp+tyQYRk81+LJ4HGO64JeK82KuiUN66gn0sTjS4xkV
	 3qzM0EF+AU2OlNmvyyJLJ6RndT85VQtrqTp/D4zL0ihlUrj1OI0RZqt8OFeypX1f0c
	 94DJL/4c+6NcY9bKO6mFl15K7t/bdELJNCpuc8igXYxpa7ap4PGeEpf2haoUTxJw18
	 z5gfN3UiL/ETQ==
Date: Sun, 15 Sep 2024 18:42:38 +0000
To: Dave Hansen <dave.hansen@intel.com>
From: John <therealgraysky@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <XngBYmNlmx5HynQiady8B6MsNyjWhWsWHhjmEIw4vhFYS_Pyi082MCXetLK66amn2j2XQiRlzFVdrUu3V0UN-3yDWOSOv9Dpr7sAgShOme0=@proton.me>
In-Reply-To: <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me> <e5081e3b-0f14-4e1e-975a-a4fd22944fc7@intel.com>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: ef69efd87df97df2ee35543283e7a47f6aa0dabd
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

> In the WORST case, we shouldn't be doing this with bools. Do this:
>=20
> config X86_MARCH_VER
> int "Compiler Micro-Architecture Level"
> range 2 4
> depends on (CC_IS_GCC && GCC_VERSION > 110000) ||
>=20
> (CC_IS_CLANG && CLANG_VERSION >=3D 120000)
>=20
> depends on EXPERT
> depends on X86_64
> help
> Specify a specific compiler "micro-architecture" version.
> You might want to do this when...
> You can find the best version for your CPU here...
> The pitfalls of this option are...
>=20
> Then you can do fun like:
>=20
> config X86_L1_CACHE_SHIFT
> int
> default "7" if MPENTIUM4 || MPSC
> + default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || ...
> + X86_MARCH_VER >=3D 2
>=20
>=20
> which has the added advantage of never needing to be touched when v5
> gets added.

I like this approach much better, it is more streamlined and clean.  I ran =
with your suggestions and the attached seems to work.  I am grateful for my=
 feedback and suggestions on the syntax.


---
 arch/x86/Kconfig.cpu | 27 +++++++++++++++++++--------
 arch/x86/Makefile    |  9 +++++++--
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..2b24574f6ac5 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -308,6 +308,17 @@ config X86_GENERIC
 =09  This is really intended for distributors who need more
 =09  generic optimizations.
=20
+config X86_MARCH_VER
+=09int "Compiler Micro-Architecture Level"
+=09range 1 4
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  Specify a specific compiler "micro-architecture" version.
+=09  You might want to do this when...
+=09  You can find the best version for your CPU here...
+=09  The pitfalls of this option are...
+
 #
 # Define implied options from the CPU selection here
 config X86_INTERNODE_CACHE_SHIFT
@@ -318,7 +329,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 =09int
 =09default "7" if MPENTIUM4 || MPSC
-=09default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || =
X86_GENERIC || GENERIC_CPU
+=09default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || =
X86_GENERIC || GENERIC_CPU || X86_MARCH_VER >=3D 2
 =09default "4" if MELAN || M486SX || M486 || MGEODEGX1
 =09default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYR=
IXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || =
M586 || MVIAC3_2 || MGEODE_LX
=20
@@ -336,11 +347,11 @@ config X86_ALIGNMENT_16
=20
 config X86_INTEL_USERCOPY
 =09def_bool y
-=09depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586M=
MX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+=09depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586M=
MX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2 || X86_MARCH_VER >=
=3D 2
=20
 config X86_USE_PPRO_CHECKSUM
 =09def_bool y
-=09depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENT=
IUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 |=
| MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
+=09depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENT=
IUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 |=
| MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM || X86_MARCH_VER >=3D=
 2
=20
 #
 # P6_NOPs are a relatively minor optimization that require a family >=3D
@@ -356,15 +367,15 @@ config X86_USE_PPRO_CHECKSUM
 config X86_P6_NOP
 =09def_bool y
 =09depends on X86_64
-=09depends on (MCORE2 || MPENTIUM4 || MPSC)
+=09depends on (MCORE2 || MPENTIUM4 || MPSC || X86_MARCH_VER >=3D 2)
=20
 config X86_TSC
 =09def_bool y
-=09depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || M=
K6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MM=
X || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCOR=
E2 || MATOM) || X86_64
+=09depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || M=
K6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MM=
X || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCOR=
E2 || MATOM || X86_MARCH_VER >=3D 2) || X86_64
=20
 config X86_HAVE_PAE
 =09def_bool y
-=09depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM =
|| MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM ||=
 X86_64
+=09depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM =
|| MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM ||=
 X86_64 || X86_MARCH_VER >=3D 2
=20
 config X86_CMPXCHG64
 =09def_bool y
@@ -374,12 +385,12 @@ config X86_CMPXCHG64
 # generates cmov.
 config X86_CMOV
 =09def_bool y
-=09depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMI=
II || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X=
86_64 || MATOM || MGEODE_LX)
+=09depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMI=
II || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X=
86_64 || MATOM || MGEODE_LX || X86_MARCH_VER >=3D 2)
=20
 config X86_MINIMUM_CPU_FAMILY
 =09int
 =09default "64" if X86_64
-=09default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPEN=
TIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7=
 || MK8)
+=09default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPEN=
TIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7=
 || MK8 || X86_MARCH_VER >=3D 2)
 =09default "5" if X86_32 && X86_CMPXCHG64
 =09default "4"
=20
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 801fd85c3ef6..e2d0d156a919 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,14 +178,19 @@ else
         cflags-$(CONFIG_MPSC)=09=09+=3D -march=3Dnocona
         cflags-$(CONFIG_MCORE2)=09=09+=3D -march=3Dcore2
         cflags-$(CONFIG_MATOM)=09=09+=3D -march=3Datom
-        cflags-$(CONFIG_GENERIC_CPU)=09+=3D -mtune=3Dgeneric
+        ifeq ($(CONFIG_X86_MARCH_VER),1)
+          cflags-$(CONFIG_GENERIC_CPU)=09=09+=3D -mtune=3Dgeneric
+          rustflags-$(CONFIG_GENERIC_CPU)=09+=3D -Ztune-cpu=3Dgeneric
+        else
+          cflags-$(CONFIG_GENERIC_CPU)=09=09+=3D -march=3Dx86-64-v$(CONFIG=
_X86_MARCH_VER)
+          rustflags-$(CONFIG_GENERIC_CPU)=09+=3D -Ztune-cpu=3Dx86-64-v$(CO=
NFIG_X86_MARCH_VER)
+        endif
         KBUILD_CFLAGS +=3D $(cflags-y)
=20
         rustflags-$(CONFIG_MK8)=09=09+=3D -Ctarget-cpu=3Dk8
         rustflags-$(CONFIG_MPSC)=09+=3D -Ctarget-cpu=3Dnocona
         rustflags-$(CONFIG_MCORE2)=09+=3D -Ctarget-cpu=3Dcore2
         rustflags-$(CONFIG_MATOM)=09+=3D -Ctarget-cpu=3Datom
-        rustflags-$(CONFIG_GENERIC_CPU)=09+=3D -Ztune-cpu=3Dgeneric
         KBUILD_RUSTFLAGS +=3D $(rustflags-y)
=20
         KBUILD_CFLAGS +=3D -mno-red-zone
--=20
2.46.1


