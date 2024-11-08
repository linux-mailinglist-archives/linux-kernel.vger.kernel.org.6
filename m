Return-Path: <linux-kernel+bounces-401883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C09C2089
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B5D28138E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693221A709;
	Fri,  8 Nov 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i9r3Y+mh"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DE1E7C26
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080156; cv=none; b=aLvS1mGDXCJy3BH+ortSbmmetkjOXzJpLjq7nzubuZJJ0tsBYfi4YG/Yq64N2KeS2iLrzRFKMTLvmtwuAhdcFHFMBtGGx4SX/iJO9tUKfyvtCDwYWSkSkDL904I+xi+Djkfih8RGdZt0BnG8LrKJ/xE9TIA2evbd9EPoHzUjdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080156; c=relaxed/simple;
	bh=/dBLc42ZULon4f5jxLW7hmS2yRMFW+dvihOfiV2JL4A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RwcZy9VFzz2AVgCcuh5L10MObo81POtD3DRxbuMo5b6OviFpc7T9f6QIrNoLXMjZ3bNopTlelwFg+vN6vkoSLOiA5CJQ525RhJ8IPPnzt/txeQDH9Bz0CLK3xLDWdEMjsOWMVNGvu0r/f7UZhMsEARWbLhVX8jc4gcwCwOnPMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i9r3Y+mh; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([90.224.241.145])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8FZPI61651468
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 07:35:27 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8FZPI61651468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731080128;
	bh=G1qv8+XkFa/EOG9R/DaRbnKN3PfbqfQNFabDyoSPFB8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=i9r3Y+mhnswtrCxdbozgjpjZC9Le9CCZTYTTfysRoVZeboqk774A5zftMourtOo3V
	 9HtSJwPMJZFZWfF3T1TVASTbwnKjmaVKYzsZR7BR6qpg2LxcIRWm31AS+CHzQT2v3R
	 T9Bn/QgKVMh0DMSfG/d08geuLQsVuO+8oo1Gj8bduwadebesFUxMhPIjSm4g/E483m
	 NNxiWuSw+c2Yt+NmAftxCk4Xn5lNAWONZU0KpTDgDRBC784WPeAaqwcS+YN/Ue1eiP
	 lFCAH5iPuhNXKGtmwF1GFR2gsAwMc8aCuXfdCUHl2WAe/S+bEFbj2JTmYbdcu93s8A
	 AdxmYeSwOaNMg==
Date: Fri, 08 Nov 2024 16:35:17 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/1=5D_x86/cpu=3A_Make_sure_fl?=
 =?US-ASCII?Q?ag=5Fis=5Fchangeable=5Fp=28=29_is_always_being_used?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com>
Message-ID: <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy=2Eshevche=
nko@linux=2Eintel=2Ecom> wrote:
>When flag_is_changeable_p() is unused, it prevents kernel builds
>with clang, `make W=3D1` and CONFIG_WERROR=3Dy:
>
>arch/x86/kernel/cpu/common=2Ec:351:19: error: unused function 'flag_is_ch=
angeable_p' [-Werror,-Wunused-function]
>  351 | static inline int flag_is_changeable_p(u32 flag)
>      |                   ^~~~~~~~~~~~~~~~~~~~
>
>Fix this by moving core around to make sure flag_is_changeable_p() is
>always being used=2E
>
>See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
>inline functions for W=3D1 build")=2E
>
>While at it, fix the argument type to be unsigned long along with
>the local variables, although it currently only runs in 32-bit cases=2E
>Besides that, makes it return boolean instead of int=2E This induces
>the change of the returning type of have_cpuid_p() to be boolean
>as well=2E
>
>Suggested-by: Dave Hansen <dave=2Ehansen@intel=2Ecom>
>Signed-off-by: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>
>---
>
>v5: fixed type of the local vars (hpa), made it return bool (hpa)
>v4: fixed the type of parameter (hpa)
>v3: rewritten as suggested (Dave)
>v2: marked both 32- and 64-bit cases
>
> arch/x86/include/asm/cpuid=2Eh |  8 +++++---
> arch/x86/kernel/cpu/common=2Ec | 39 +++++++++++++++++-------------------
> 2 files changed, 23 insertions(+), 24 deletions(-)
>
>diff --git a/arch/x86/include/asm/cpuid=2Eh b/arch/x86/include/asm/cpuid=
=2Eh
>index ca4243318aad=2E=2E239b9ba5c398 100644
>--- a/arch/x86/include/asm/cpuid=2Eh
>+++ b/arch/x86/include/asm/cpuid=2Eh
>@@ -6,6 +6,8 @@
> #ifndef _ASM_X86_CPUID_H
> #define _ASM_X86_CPUID_H
>=20
>+#include <linux/types=2Eh>
>+
> #include <asm/string=2Eh>
>=20
> struct cpuid_regs {
>@@ -20,11 +22,11 @@ enum cpuid_regs_idx {
> };
>=20
> #ifdef CONFIG_X86_32
>-extern int have_cpuid_p(void);
>+bool have_cpuid_p(void);
> #else
>-static inline int have_cpuid_p(void)
>+static inline bool have_cpuid_p(void)
> {
>-	return 1;
>+	return true;
> }
> #endif
> static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
>diff --git a/arch/x86/kernel/cpu/common=2Ec b/arch/x86/kernel/cpu/common=
=2Ec
>index a5f221ea5688=2E=2Ef361336416ae 100644
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -276,21 +276,13 @@ static int __init x86_noinvpcid_setup(char *s)
> }
> early_param("noinvpcid", x86_noinvpcid_setup);
>=20
>-#ifdef CONFIG_X86_32
>-static int cachesize_override =3D -1;
>-static int disable_x86_serial_nr =3D 1;
>-
>-static int __init cachesize_setup(char *str)
>-{
>-	get_option(&str, &cachesize_override);
>-	return 1;
>-}
>-__setup("cachesize=3D", cachesize_setup);
>-
> /* Standard macro to see if a specific flag is changeable */
>-static inline int flag_is_changeable_p(u32 flag)
>+static inline bool flag_is_changeable_p(unsigned long flag)
> {
>-	u32 f1, f2;
>+	unsigned long f1, f2;
>+
>+	if (!IS_ENABLED(CONFIG_X86_32))
>+		return true;
>=20
> 	/*
> 	 * Cyrix and IDT cpus allow disabling of CPUID
>@@ -313,11 +305,22 @@ static inline int flag_is_changeable_p(u32 flag)
> 		      : "=3D&r" (f1), "=3D&r" (f2)
> 		      : "ir" (flag));
>=20
>-	return ((f1^f2) & flag) !=3D 0;
>+	return (f1 ^ f2) & flag;
> }
>=20
>+#ifdef CONFIG_X86_32
>+static int cachesize_override =3D -1;
>+static int disable_x86_serial_nr =3D 1;
>+
>+static int __init cachesize_setup(char *str)
>+{
>+	get_option(&str, &cachesize_override);
>+	return 1;
>+}
>+__setup("cachesize=3D", cachesize_setup);
>+
> /* Probe for the CPUID instruction */
>-int have_cpuid_p(void)
>+bool have_cpuid_p(void)
> {
> 	return flag_is_changeable_p(X86_EFLAGS_ID);
> }
>@@ -349,10 +352,6 @@ static int __init x86_serial_nr_setup(char *s)
> }
> __setup("serialnumber", x86_serial_nr_setup);
> #else
>-static inline int flag_is_changeable_p(u32 flag)
>-{
>-	return 1;
>-}
> static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c=
)
> {
> }
>@@ -1088,7 +1087,6 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
>=20
> static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
> {
>-#ifdef CONFIG_X86_32
> 	int i;
>=20
> 	/*
>@@ -1109,7 +1107,6 @@ static void identify_cpu_without_cpuid(struct cpuin=
fo_x86 *c)
> 				break;
> 			}
> 		}
>-#endif
> }
>=20
> #define NO_SPECULATION		BIT(0)

Looks good to me:

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

But another question: why the hell does clang complain about an unused sta=
tic inline function?!

