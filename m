Return-Path: <linux-kernel+bounces-329822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B415979668
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC04281D78
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC81C3F26;
	Sun, 15 Sep 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Be6VIb5n"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8691B969
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726398367; cv=none; b=nzEJyNzqQ6+bigt2p8YxyfYQ3Ex1rhTSgc+I25KnPXxgi/3SGvevJ0b6eDTunad5uQ2VN6p+UacLxDlXn+BB9iAfW7RlEeYFNqCrbqpm/oGk2jF1dt0CFO/U3hwFnOi7e1SeaGO1+Y+wVD7YCDd+FhPtaKtm0Szeu8IEGNWabX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726398367; c=relaxed/simple;
	bh=DaZD5DW7LP1SPgv2j3v5co0ny011mKy30Z8qr5v7NUU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=maJALOGa4gD3Db9kNfE28U3br6Q8kEWpzHNJhBHsL7yjvzoybZBJ6cbDCcB4GSAQAjfTQ6hO/mz0j2mC+5Jc7w5oMmiJG6xImpRIxGWjgKWn3LT5FoX/j6ZbNK0BRFSiCgpYWgQHMP3QRE2Dvxk93Up28cXohtkxS3oqMgno7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Be6VIb5n; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726398357; x=1726657557;
	bh=McL4CZyYmX/FIwqVZ1rgPN1sN35XLWWWGC02YxHqiuA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Be6VIb5ni+M0xEMavEtZWb9FlZV4083PK5GuVgGlg4Vq6q+iho6yxdTdNbP3OwxRM
	 Ax9kwWrWi8mEy3xDtAuG0X5f5y+nioeOxViXLWBpTXuCGDchVlz+QyHN6DS/Mb/8cE
	 N0x8AER/cghM3ls4NoIZrUjVVkeCfNoT2sV+biM7o0XO63+n3dblsIyhU2+CAPXF6/
	 AwexEGHWDk92UqUg9JcterQPQmo87z1m+a9xBD6E6ueJgQWcLA4NNhqr7ltBLO5cu/
	 7BK6E3IUoDlF8iAwI+BcZ5yJS1bJnyXrUhKRIRPVBRyfJh2wiQO8zVnzslwv5ve4JT
	 4wirYGbZoZhjA==
Date: Sun, 15 Sep 2024 11:05:52 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: John <therealgraysky@proton.me>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 52e6ef91b4c57b770a6cbb78a43e908dfbdc64eb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

GCC 11.1 and Clang 12.0[1] allow for the following new generic
64-bit levels: x86-64-v2, x86-64-v3, and x86-64-v4.  This commit
adds them as options accessible under:
 Processor type and features  --->
  Processor family --->

Users of glibc 2.33 and above can see which level is supported
by running: /lib/ld-linux-x86-64.so.2 --help | grep supported

or: /lib64/ld-linux-x86-64.so.2 --help | grep supported

ACKNOWLEDGMENTS
This patch builds on the seminal work by Jeroen.[2]

REFERENCES
1.  https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb=
7e9
2.  http://www.linuxforge.net/docs/linux/linux-gcc.php

Signed-off-by: John Audia <therealgraysky@proton.me>
---
 arch/x86/Kconfig.cpu | 60 +++++++++++++++++++++++++++++++++++++++-----
 arch/x86/Makefile    |  6 +++++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..b09a764e6dd1 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -294,6 +294,54 @@ config GENERIC_CPU
 =09  Generic x86-64 CPU.
 =09  Run equally well on all x86-64 CPUs.

+config MAMD_CPU_V2
+=09bool "AMD x86-64-v2"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  AMD x86-64 CPU with v2 instructions.
+=09  Run equally well on all AMD x86-64 CPUs with min support of -march=3D=
x86-64-v2.
+
+config MAMD_CPU_V3
+=09bool "AMD x86-64-v3"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  AMD x86-64-v3 CPU with v3 instructions.
+=09  Run equally well on all AMD x86-64 CPUs with min support of -march=3D=
x86-64-v3.
+
+config MAMD_CPU_V4
+=09bool "AMD x86-64-v4"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  AMD x86-64 CPU with v4 instructions.
+=09  Run equally well on all AMD x86-64 CPUs with min support of -march=3D=
x86-64-v4.
+
+config MINTEL_CPU_V2
+=09bool "Intel x86-64-v2"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  Intel x86-64 CPU with v2 instructions.
+=09  Run equally well on all Intel x86-64 CPUs with min support of -march=
=3Dx86-64-v2.
+
+config MINTEL_CPU_V3
+=09bool "Intel x86-64-v3"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  Intel x86-64 CPU with v3 instructions.
+=09  Run equally well on all Intel x86-64 CPUs with min support of -march=
=3Dx86-64-v3.
+
+config MINTEL_CPU_V4
+=09bool "Intel x86-64-v4"
+=09depends on (CC_IS_GCC && GCC_VERSION > 110000) || (CC_IS_CLANG && CLANG=
_VERSION >=3D 120000)
+=09depends on X86_64
+=09help
+=09  Intel x86-64 CPU with v4 instructions.
+=09  Run equally well on all Intel x86-64 CPUs with min support of -march=
=3Dx86-64-v4.
+
 endchoice

 config X86_GENERIC
@@ -318,7 +366,7 @@ config X86_INTERNODE_CACHE_SHIFT
 config X86_L1_CACHE_SHIFT
 =09int
 =09default "7" if MPENTIUM4 || MPSC
-=09default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || =
X86_GENERIC || GENERIC_CPU
+=09default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || =
X86_GENERIC || GENERIC_CPU || MAMD_CPU_V2 || MAMD_CPU_V3 || MAMD_CPU_V4 || =
MINTEL_CPU_V2 || MINTEL_CPU_V3 || MINTEL_CPU_V4
 =09default "4" if MELAN || M486SX || M486 || MGEODEGX1
 =09default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYR=
IXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || =
M586 || MVIAC3_2 || MGEODE_LX

@@ -336,11 +384,11 @@ config X86_ALIGNMENT_16

 config X86_INTEL_USERCOPY
 =09def_bool y
-=09depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586M=
MX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+=09depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586M=
MX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2 || MINTEL_CPU_V2 || =
MINTEL_CPU_V3 || MINTEL_CPU_V4

 config X86_USE_PPRO_CHECKSUM
 =09def_bool y
-=09depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENT=
IUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 |=
| MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
+=09depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENT=
IUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 |=
| MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM || MAMD_CPU_V2 || MAM=
D_CPU_V3 || MAMD_CPU_V4 || MINTEL_CPU_V2 || MINTEL_CPU_V3 || MINTEL_CPU_V4

 #
 # P6_NOPs are a relatively minor optimization that require a family >=3D
@@ -356,7 +404,7 @@ config X86_USE_PPRO_CHECKSUM
 config X86_P6_NOP
 =09def_bool y
 =09depends on X86_64
-=09depends on (MCORE2 || MPENTIUM4 || MPSC)
+=09depends on (MCORE2 || MPENTIUM4 || MPSC || MINTEL_CPU_V2 || MINTEL_CPU_=
V3 || MINTEL_CPU_V4)

 config X86_TSC
 =09def_bool y
@@ -364,7 +412,7 @@ config X86_TSC

 config X86_HAVE_PAE
 =09def_bool y
-=09depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM =
|| MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM ||=
 X86_64
+=09depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM =
|| MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM ||=
 X86_64 || MAMD_CPU_V2 || MAMD_CPU_V3 || MAMD_CPU_V4 || MINTEL_CPU_V2 || MI=
NTEL_CPU_V3 || MINTEL_CPU_V4

 config X86_CMPXCHG64
 =09def_bool y
@@ -379,7 +427,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 =09int
 =09default "64" if X86_64
-=09default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPEN=
TIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7=
 || MK8)
+=09default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPEN=
TIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7=
 || MK8 || MAMD_CPU_V2 || MAMD_CPU_V3 || MAMD_CPU_V4 || MINTEL_CPU_V2 || MI=
NTEL_CPU_V3 || MINTEL_CPU_V4)
 =09default "5" if X86_32 && X86_CMPXCHG64
 =09default "4"

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 801fd85c3ef6..3d03e687eaac 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -179,6 +179,12 @@ else
         cflags-$(CONFIG_MCORE2)=09=09+=3D -march=3Dcore2
         cflags-$(CONFIG_MATOM)=09=09+=3D -march=3Datom
         cflags-$(CONFIG_GENERIC_CPU)=09+=3D -mtune=3Dgeneric
+        cflags-$(CONFIG_MAMD_CPU_V2)=09+=3D -march=3Dx86-64-v2
+        cflags-$(CONFIG_MAMD_CPU_V3)=09+=3D -march=3Dx86-64-v3
+        cflags-$(CONFIG_MAMD_CPU_V4)=09+=3D -march=3Dx86-64-v4
+        cflags-$(CONFIG_MINTEL_CPU_V2)=09+=3D -march=3Dx86-64-v2
+        cflags-$(CONFIG_MINTEL_CPU_V3)=09+=3D -march=3Dx86-64-v3
+        cflags-$(CONFIG_MINTEL_CPU_V4)=09+=3D -march=3Dx86-64-v4
         KBUILD_CFLAGS +=3D $(cflags-y)

         rustflags-$(CONFIG_MK8)=09=09+=3D -Ctarget-cpu=3Dk8
--
2.46.1


