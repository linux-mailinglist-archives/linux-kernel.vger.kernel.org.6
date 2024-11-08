Return-Path: <linux-kernel+bounces-401853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98B9C2023
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468171C22EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126581F5857;
	Fri,  8 Nov 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nm1F21U8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB51F5836
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078833; cv=none; b=QvqCjugddAU9tRa6/gut3foG+FYB9dpJ9Al/kGTdsoX0WT/zDeYLMxsfhYOX29my9W6iqqt+xa/ZfmZnY8RkNj5NSL0WvuBvToxJjARteghbK0wSzIq5MmIpb1FF+AOJ3J7DywuffuL3yN5P4st0KN0iM53HTzsyVEgs8y+Uy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078833; c=relaxed/simple;
	bh=y5XMG3Y8qTZ1Vt3pQGyjtlsRp2L+jquG6H0ocNFgftc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JX7ejW+TchqUvTYqUIuJHEXlCC/G05amoODPTSUT/A4WcBBaVJlL0ZhksnvQtuHnY7l9877y3Mr5sSez2ImAq/mDLjBSdr+UDD0z/SGxar14ZqysD8Cx/YVEs+N7Xha7SJJMPXXzYZcZeFKiOJYr8qnYA+73Q7fyOIpRt6yAl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nm1F21U8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([90.224.241.145])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8FDDJX1643130
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 07:13:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8FDDJX1643130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731078797;
	bh=hShRUqIkoj08rIUulkZeJbwovVIPy8aqnz6hKWjn1oc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nm1F21U8iZNNYNFnStKXiOSCDuVCGZldPAmVG7j2/ZnA4ASoe96OilFoN+xEOFW8m
	 OYLHbpTIYTholMTlPfKknUxomCLRljgzJ3CgSkkOQlydv4xEtNcmj18TmOQaeJqBPM
	 HdaVAY9XyTCzm2GijrZaB6Of+2Swe2R1FYPrdxteD7ZCHeI4j4n/YdQaf1oNUo5BDw
	 zBxUzdXG3wY3WXVHKxwbPMaWCs9xuBG0u+OSViZsn8bLyYgFycUORIXxBmvn51j87U
	 3FMbq17U1Q/4ZTAJxWUGcQjavmSOW2bWwB/rsGtFkmE5fj9moMuMsNFyKjLi3jwFLw
	 OcNlDtpa0+LXA==
Date: Fri, 08 Nov 2024 16:13:05 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/1=5D_x86/cpu=3A_Make_sure_fl?=
 =?US-ASCII?Q?ag=5Fis=5Fchangeable=5Fp=28=29_is_always_being_used?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241108141235.1456557-1-andriy.shevchenko@linux.intel.com>
References: <20241108141235.1456557-1-andriy.shevchenko@linux.intel.com>
Message-ID: <B7F5B222-2982-43D5-87A5-7510EDCCB4DF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 3:11:46 PM GMT+01:00, Andy Shevchenko <andriy=2Eshevche=
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
>While at it, fix the argument type to be unsigned long, although it curre=
ntly
>only runs in 32-bit cases=2E
>
>Suggested-by: Dave Hansen <dave=2Ehansen@intel=2Ecom>
>Signed-off-by: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>
>---
>
>v4: fixed the type of parameter (hpa)
>v3: rewritten as suggested (Dave)
>v2: marked both 32- and 64-bit cases
>
> arch/x86/kernel/cpu/common=2Ec | 33 +++++++++++++++------------------
> 1 file changed, 15 insertions(+), 18 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/common=2Ec b/arch/x86/kernel/cpu/common=
=2Ec
>index a5f221ea5688=2E=2E49682e35f9bd 100644
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -276,22 +276,14 @@ static int __init x86_noinvpcid_setup(char *s)
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
>+static inline int flag_is_changeable_p(unsigned long flag)
> {
> 	u32 f1, f2;
>=20
>+	if (!IS_ENABLED(CONFIG_X86_32))
>+		return 1;
>+
> 	/*
> 	 * Cyrix and IDT cpus allow disabling of CPUID
> 	 * so the code below may return different results
>@@ -316,6 +308,17 @@ static inline int flag_is_changeable_p(u32 flag)
> 	return ((f1^f2) & flag) !=3D 0;
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
> int have_cpuid_p(void)
> {
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

It's good that you are changing the return type, but we need to be consist=
ent and change f1, f2 to match=2E At the same time, I suggest changing the =
return type to bool=2E

