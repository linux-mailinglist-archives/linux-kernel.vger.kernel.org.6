Return-Path: <linux-kernel+bounces-220677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3A90E54E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91711F23381
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3088378C64;
	Wed, 19 Jun 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BE2MFgDA"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71078C6D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784718; cv=none; b=lM0BgatUiKhRS5R4pbdgaobn5QL7FvCzQtc1SAujiBG5qBfMuVb9ciPIOf+3SdRO3LLgb25+052wVFIGh2di1hb2xOcnS799JyGmEhE2FrfYR25ulzVrSfWt4HtMZ4m1/BQ0YRCogty28xdDR5d2f83AvKNifb2QP5vQ2oX+yr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784718; c=relaxed/simple;
	bh=kPwccXzHHHXcyNHHa9e0En5gni47pKaRNJjCr/GujaY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CfdXoiHTGNTMFT1vyq6zi0hI89i3wx1EHnlXvO8dipS/XSsADkuk6Lz4iP1WaS7trDqg3kv5cYNOKJgoxTQYDqjMoTUDNI9C4xw0zdNzVfTsYmb5G9XXJHlmcobe15NfW104F92cDT1171fvtNajaN51F8qfdH55nQtMYMr2kGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BE2MFgDA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45J8BJIO2356998
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 19 Jun 2024 01:11:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45J8BJIO2356998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718784680;
	bh=IR/kiio0i+T2L1NbFZq8TVw54HSgi9fpGY0HFuTimA8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BE2MFgDAqC2nqn8SESTvKP09ZLziCbiMHrkJZ/H+iJjHAmIWfgsLOQ5qatG8cnVtI
	 0CVZJnhPTnox3okk5oCIzUYJr1MDThaTxfYBhcqLHMgEi4S98F3gfcO7PPmpANZuvi
	 oRsLHOUWgL8kR89a6+Mbshbl6cZ1UgBp6Y08qZbiftBPt0UbjWmTstdNxRdTLnffrZ
	 lqPhv2c4B7dhA8Y7cKL2Xs1s176YebKXZd0CfuqkHCO6sXi9OHj1DdgzozkMbw7qre
	 YvtGg2AkVJtIf+tExu10qCSrp9s5PqWQExAlkSM8QuFY2e1MEH2cGarO3D6Ac/13oy
	 hqV9O+UXJl/Lg==
Date: Wed, 19 Jun 2024 01:11:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@kernel.org>, Sean Christopherson <seanjc@google.com>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_x86/cpufeatures=3A_Fli?=
 =?US-ASCII?Q?p_the_/proc/cpuinfo_appearance_logic?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240618113840.24163-1-bp@kernel.org>
References: <20240618113840.24163-1-bp@kernel.org>
Message-ID: <D9E4D244-1E56-441E-AF6C-2822AC9A2C25@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 18, 2024 4:38:40 AM PDT, Borislav Petkov <bp@kernel=2Eorg> wrote:
>From: "Borislav Petkov (AMD)" <bp@alien8=2Ede>
>
>I'm getting tired of telling people to put a magic "" in the
>
>  #define X86_FEATURE		/* "" =2E=2E=2E */
>
>comment to hide the new feature flag from the user-visible
>/proc/cpuinfo=2E
>
>Flip the logic to make it explicit: an explicit "<name>" in the comment
>adds the flag to /proc/cpuinfo and otherwise not, by default=2E
>
>Add the "<name>" of all the existing flags to keep backwards
>compatibility with userspace=2E
>
>There should be no functional changes resulting from this=2E
>
>Signed-off-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>---
> arch/x86/include/asm/cpufeatures=2Eh | 800 ++++++++++++++---------------
> arch/x86/include/asm/vmxfeatures=2Eh | 106 ++--
> arch/x86/kernel/cpu/mkcapflags=2Esh  |   3 +-
> 3 files changed, 454 insertions(+), 455 deletions(-)
> mode change 100644 =3D> 100755 arch/x86/kernel/cpu/mkcapflags=2Esh
>
>diff --git a/arch/x86/include/asm/cpufeatures=2Eh b/arch/x86/include/asm/=
cpufeatures=2Eh
>index 3c7434329661=2E=2Ea1dd81027c2d 100644
>--- a/arch/x86/include/asm/cpufeatures=2Eh
>+++ b/arch/x86/include/asm/cpufeatures=2Eh
>@@ -18,170 +18,170 @@
>=20
> /*
>  * Note: If the comment begins with a quoted string, that string is used
>- * in /proc/cpuinfo instead of the macro name=2E  If the string is "",
>- * this feature bit is not displayed in /proc/cpuinfo at all=2E
>+ * in /proc/cpuinfo instead of the macro name=2E  Otherwise, this featur=
e
>+ * bit is not displayed in /proc/cpuinfo at all=2E
>  *
>  * When adding new features here that depend on other features,
>  * please update the table in kernel/cpu/cpuid-deps=2Ec as well=2E
>  */
>=20
> /* Intel-defined CPU features, CPUID level 0x00000001 (EDX), word 0 */
>-#define X86_FEATURE_FPU			( 0*32+ 0) /* Onboard FPU */
>-#define X86_FEATURE_VME			( 0*32+ 1) /* Virtual Mode Extensions */
>-#define X86_FEATURE_DE			( 0*32+ 2) /* Debugging Extensions */
>-#define X86_FEATURE_PSE			( 0*32+ 3) /* Page Size Extensions */
>-#define X86_FEATURE_TSC			( 0*32+ 4) /* Time Stamp Counter */
>-#define X86_FEATURE_MSR			( 0*32+ 5) /* Model-Specific Registers */
>-#define X86_FEATURE_PAE			( 0*32+ 6) /* Physical Address Extensions */
>-#define X86_FEATURE_MCE			( 0*32+ 7) /* Machine Check Exception */
>-#define X86_FEATURE_CX8			( 0*32+ 8) /* CMPXCHG8 instruction */
>-#define X86_FEATURE_APIC		( 0*32+ 9) /* Onboard APIC */
>-#define X86_FEATURE_SEP			( 0*32+11) /* SYSENTER/SYSEXIT */
>-#define X86_FEATURE_MTRR		( 0*32+12) /* Memory Type Range Registers */
>-#define X86_FEATURE_PGE			( 0*32+13) /* Page Global Enable */
>-#define X86_FEATURE_MCA			( 0*32+14) /* Machine Check Architecture */
>-#define X86_FEATURE_CMOV		( 0*32+15) /* CMOV instructions (plus FCMOVcc,=
 FCOMI with FPU) */
>-#define X86_FEATURE_PAT			( 0*32+16) /* Page Attribute Table */
>-#define X86_FEATURE_PSE36		( 0*32+17) /* 36-bit PSEs */
>-#define X86_FEATURE_PN			( 0*32+18) /* Processor serial number */
>-#define X86_FEATURE_CLFLUSH		( 0*32+19) /* CLFLUSH instruction */
>+#define X86_FEATURE_FPU			( 0*32+ 0) /* "fpu" Onboard FPU */
>+#define X86_FEATURE_VME			( 0*32+ 1) /* "vme" Virtual Mode Extensions */
>+#define X86_FEATURE_DE			( 0*32+ 2) /* "de" Debugging Extensions */
>+#define X86_FEATURE_PSE			( 0*32+ 3) /* "pse" Page Size Extensions */
>+#define X86_FEATURE_TSC			( 0*32+ 4) /* "tsc" Time Stamp Counter */
>+#define X86_FEATURE_MSR			( 0*32+ 5) /* "msr" Model-Specific Registers *=
/
>+#define X86_FEATURE_PAE			( 0*32+ 6) /* "pae" Physical Address Extension=
s */
>+#define X86_FEATURE_MCE			( 0*32+ 7) /* "mce" Machine Check Exception */
>+#define X86_FEATURE_CX8			( 0*32+ 8) /* "cx8" CMPXCHG8 instruction */
>+#define X86_FEATURE_APIC		( 0*32+ 9) /* "apic" Onboard APIC */
>+#define X86_FEATURE_SEP			( 0*32+11) /* "sep" SYSENTER/SYSEXIT */
>+#define X86_FEATURE_MTRR		( 0*32+12) /* "mtrr" Memory Type Range Registe=
rs */
>+#define X86_FEATURE_PGE			( 0*32+13) /* "pge" Page Global Enable */
>+#define X86_FEATURE_MCA			( 0*32+14) /* "mca" Machine Check Architecture=
 */
>+#define X86_FEATURE_CMOV		( 0*32+15) /* "cmov" CMOV instructions (plus F=
CMOVcc, FCOMI with FPU) */
>+#define X86_FEATURE_PAT			( 0*32+16) /* "pat" Page Attribute Table */
>+#define X86_FEATURE_PSE36		( 0*32+17) /* "pse36" 36-bit PSEs */
>+#define X86_FEATURE_PN			( 0*32+18) /* "pn" Processor serial number */
>+#define X86_FEATURE_CLFLUSH		( 0*32+19) /* "clflush" CLFLUSH instruction=
 */
> #define X86_FEATURE_DS			( 0*32+21) /* "dts" Debug Store */
>-#define X86_FEATURE_ACPI		( 0*32+22) /* ACPI via MSR */
>-#define X86_FEATURE_MMX			( 0*32+23) /* Multimedia Extensions */
>-#define X86_FEATURE_FXSR		( 0*32+24) /* FXSAVE/FXRSTOR, CR4=2EOSFXSR */
>+#define X86_FEATURE_ACPI		( 0*32+22) /* "acpi" ACPI via MSR */
>+#define X86_FEATURE_MMX			( 0*32+23) /* "mmx" Multimedia Extensions */
>+#define X86_FEATURE_FXSR		( 0*32+24) /* "fxsr" FXSAVE/FXRSTOR, CR4=2EOSF=
XSR */
> #define X86_FEATURE_XMM			( 0*32+25) /* "sse" */
> #define X86_FEATURE_XMM2		( 0*32+26) /* "sse2" */
> #define X86_FEATURE_SELFSNOOP		( 0*32+27) /* "ss" CPU self snoop */
>-#define X86_FEATURE_HT			( 0*32+28) /* Hyper-Threading */
>+#define X86_FEATURE_HT			( 0*32+28) /* "ht" Hyper-Threading */
> #define X86_FEATURE_ACC			( 0*32+29) /* "tm" Automatic clock control */
>-#define X86_FEATURE_IA64		( 0*32+30) /* IA-64 processor */
>-#define X86_FEATURE_PBE			( 0*32+31) /* Pending Break Enable */
>+#define X86_FEATURE_IA64		( 0*32+30) /* "ia64" IA-64 processor */
>+#define X86_FEATURE_PBE			( 0*32+31) /* "pbe" Pending Break Enable */
>=20
> /* AMD-defined CPU features, CPUID level 0x80000001, word 1 */
> /* Don't duplicate feature flags which are redundant with Intel! */
>-#define X86_FEATURE_SYSCALL		( 1*32+11) /* SYSCALL/SYSRET */
>-#define X86_FEATURE_MP			( 1*32+19) /* MP Capable */
>-#define X86_FEATURE_NX			( 1*32+20) /* Execute Disable */
>-#define X86_FEATURE_MMXEXT		( 1*32+22) /* AMD MMX extensions */
>-#define X86_FEATURE_FXSR_OPT		( 1*32+25) /* FXSAVE/FXRSTOR optimizations=
 */
>+#define X86_FEATURE_SYSCALL		( 1*32+11) /* "syscall" SYSCALL/SYSRET */
>+#define X86_FEATURE_MP			( 1*32+19) /* "mp" MP Capable */
>+#define X86_FEATURE_NX			( 1*32+20) /* "nx" Execute Disable */
>+#define X86_FEATURE_MMXEXT		( 1*32+22) /* "mmxext" AMD MMX extensions */
>+#define X86_FEATURE_FXSR_OPT		( 1*32+25) /* "fxsr_opt" FXSAVE/FXRSTOR op=
timizations */
> #define X86_FEATURE_GBPAGES		( 1*32+26) /* "pdpe1gb" GB pages */
>-#define X86_FEATURE_RDTSCP		( 1*32+27) /* RDTSCP */
>-#define X86_FEATURE_LM			( 1*32+29) /* Long Mode (x86-64, 64-bit support=
) */
>-#define X86_FEATURE_3DNOWEXT		( 1*32+30) /* AMD 3DNow extensions */
>-#define X86_FEATURE_3DNOW		( 1*32+31) /* 3DNow */
>+#define X86_FEATURE_RDTSCP		( 1*32+27) /* "rdtscp" RDTSCP */
>+#define X86_FEATURE_LM			( 1*32+29) /* "lm" Long Mode (x86-64, 64-bit su=
pport) */
>+#define X86_FEATURE_3DNOWEXT		( 1*32+30) /* "3dnowext" AMD 3DNow extensi=
ons */
>+#define X86_FEATURE_3DNOW		( 1*32+31) /* "3dnow" 3DNow */
>=20
> /* Transmeta-defined CPU features, CPUID level 0x80860001, word 2 */
>-#define X86_FEATURE_RECOVERY		( 2*32+ 0) /* CPU in recovery mode */
>-#define X86_FEATURE_LONGRUN		( 2*32+ 1) /* Longrun power control */
>-#define X86_FEATURE_LRTI		( 2*32+ 3) /* LongRun table interface */
>+#define X86_FEATURE_RECOVERY		( 2*32+ 0) /* "recovery" CPU in recovery m=
ode */
>+#define X86_FEATURE_LONGRUN		( 2*32+ 1) /* "longrun" Longrun power contr=
ol */
>+#define X86_FEATURE_LRTI		( 2*32+ 3) /* "lrti" LongRun table interface *=
/
>=20
> /* Other features, Linux-defined mapping, word 3 */
> /* This range is used for feature bits which conflict or are synthesized=
 */
>-#define X86_FEATURE_CXMMX		( 3*32+ 0) /* Cyrix MMX extensions */
>-#define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* AMD K6 nonstandard MTRRs */
>-#define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* Cyrix ARRs (=3D MTRRs) */
>-#define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* Centaur MCRs (=3D MTRRs) =
*/
>-#define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
>-#define X86_FEATURE_ZEN5		( 3*32+ 5) /* "" CPU based on Zen5 microarchit=
ecture */
>-#define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
>-#define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
>-#define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant r=
ate */
>-#define X86_FEATURE_UP			( 3*32+ 9) /* SMP kernel running on UP */
>-#define X86_FEATURE_ART			( 3*32+10) /* Always running timer (ART) */
>-#define X86_FEATURE_ARCH_PERFMON	( 3*32+11) /* Intel Architectural PerfM=
on */
>-#define X86_FEATURE_PEBS		( 3*32+12) /* Precise-Event Based Sampling */
>-#define X86_FEATURE_BTS			( 3*32+13) /* Branch Trace Store */
>-#define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspac=
e */
>-#define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 usersp=
ace */
>-#define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
>-#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Ext=
ension Version 2 */
>-#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers usi=
ng VERW */
>-#define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mecha=
nism */
>-#define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
>-#define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
>-#define X86_FEATURE_XTOPOLOGY		( 3*32+22) /* CPU topology enum extension=
s */
>-#define X86_FEATURE_TSC_RELIABLE	( 3*32+23) /* TSC is known to be reliab=
le */
>-#define X86_FEATURE_NONSTOP_TSC		( 3*32+24) /* TSC does not stop in C st=
ates */
>-#define X86_FEATURE_CPUID		( 3*32+25) /* CPU has CPUID instruction itsel=
f */
>-#define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) =
*/
>-#define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
>-#define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordinat=
ion feedback capability (APERF/MPERF MSRs) */
>-#define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
>-#define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 =
state */
>-#define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency=
 */
>+#define X86_FEATURE_CXMMX		( 3*32+ 0) /* "cxmmx" Cyrix MMX extensions */
>+#define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* "k6_mtrr" AMD K6 nonstandard =
MTRRs */
>+#define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* "cyrix_arr" Cyrix ARRs (=3D=
 MTRRs) */
>+#define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCR=
s (=3D MTRRs) */
>+#define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
>+#define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitect=
ure */
>+#define X86_FEATURE_P3			( 3*32+ 6) /* P3 */
>+#define X86_FEATURE_P4			( 3*32+ 7) /* P4 */
>+#define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks =
at a constant rate */
>+#define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
>+#define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART)=
 */
>+#define X86_FEATURE_ARCH_PERFMON	( 3*32+11) /* "arch_perfmon" Intel Arch=
itectural PerfMon */
>+#define X86_FEATURE_PEBS		( 3*32+12) /* "pebs" Precise-Event Based Sampl=
ing */
>+#define X86_FEATURE_BTS			( 3*32+13) /* "bts" Branch Trace Store */
>+#define X86_FEATURE_SYSCALL32		( 3*32+14) /* syscall in IA32 userspace *=
/
>+#define X86_FEATURE_SYSENTER32		( 3*32+15) /* sysenter in IA32 userspace=
 */
>+#define X86_FEATURE_REP_GOOD		( 3*32+16) /* "rep_good" REP microcode wor=
ks well */
>+#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* "amd_lbr_v2" AMD Last Bran=
ch Record Extension Version 2 */
>+#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* Clear CPU buffers using =
VERW */
>+#define X86_FEATURE_ACC_POWER		( 3*32+19) /* "acc_power" AMD Accumulated=
 Power Mechanism */
>+#define X86_FEATURE_NOPL		( 3*32+20) /* "nopl" The NOPL (0F 1F) instruct=
ions */
>+#define X86_FEATURE_ALWAYS		( 3*32+21) /* Always-present feature */
>+#define X86_FEATURE_XTOPOLOGY		( 3*32+22) /* "xtopology" CPU topology en=
um extensions */
>+#define X86_FEATURE_TSC_RELIABLE	( 3*32+23) /* "tsc_reliable" TSC is kno=
wn to be reliable */
>+#define X86_FEATURE_NONSTOP_TSC		( 3*32+24) /* "nonstop_tsc" TSC does no=
t stop in C states */
>+#define X86_FEATURE_CPUID		( 3*32+25) /* "cpuid" CPU has CPUID instructi=
on itself */
>+#define X86_FEATURE_EXTD_APICID		( 3*32+26) /* "extd_apicid" Extended AP=
ICID (8 bits) */
>+#define X86_FEATURE_AMD_DCM		( 3*32+27) /* "amd_dcm" AMD multi-node proc=
essor */
>+#define X86_FEATURE_APERFMPERF		( 3*32+28) /* "aperfmperf" P-State hardw=
are coordination feedback capability (APERF/MPERF MSRs) */
>+#define X86_FEATURE_RAPL		( 3*32+29) /* "rapl" AMD/Hygon RAPL interface =
*/
>+#define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* "nonstop_tsc_s3" TSC do=
esn't stop in S3 state */
>+#define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* "tsc_known_freq" TSC ha=
s known frequency */
>=20
> /* Intel-defined CPU features, CPUID level 0x00000001 (ECX), word 4 */
> #define X86_FEATURE_XMM3		( 4*32+ 0) /* "pni" SSE-3 */
>-#define X86_FEATURE_PCLMULQDQ		( 4*32+ 1) /* PCLMULQDQ instruction */
>-#define X86_FEATURE_DTES64		( 4*32+ 2) /* 64-bit Debug Store */
>+#define X86_FEATURE_PCLMULQDQ		( 4*32+ 1) /* "pclmulqdq" PCLMULQDQ instr=
uction */
>+#define X86_FEATURE_DTES64		( 4*32+ 2) /* "dtes64" 64-bit Debug Store */
> #define X86_FEATURE_MWAIT		( 4*32+ 3) /* "monitor" MONITOR/MWAIT support=
 */
> #define X86_FEATURE_DSCPL		( 4*32+ 4) /* "ds_cpl" CPL-qualified (filtere=
d) Debug Store */
>-#define X86_FEATURE_VMX			( 4*32+ 5) /* Hardware virtualization */
>-#define X86_FEATURE_SMX			( 4*32+ 6) /* Safer Mode eXtensions */
>-#define X86_FEATURE_EST			( 4*32+ 7) /* Enhanced SpeedStep */
>-#define X86_FEATURE_TM2			( 4*32+ 8) /* Thermal Monitor 2 */
>-#define X86_FEATURE_SSSE3		( 4*32+ 9) /* Supplemental SSE-3 */
>-#define X86_FEATURE_CID			( 4*32+10) /* Context ID */
>-#define X86_FEATURE_SDBG		( 4*32+11) /* Silicon Debug */
>-#define X86_FEATURE_FMA			( 4*32+12) /* Fused multiply-add */
>-#define X86_FEATURE_CX16		( 4*32+13) /* CMPXCHG16B instruction */
>-#define X86_FEATURE_XTPR		( 4*32+14) /* Send Task Priority Messages */
>-#define X86_FEATURE_PDCM		( 4*32+15) /* Perf/Debug Capabilities MSR */
>-#define X86_FEATURE_PCID		( 4*32+17) /* Process Context Identifiers */
>-#define X86_FEATURE_DCA			( 4*32+18) /* Direct Cache Access */
>+#define X86_FEATURE_VMX			( 4*32+ 5) /* "vmx" Hardware virtualization */
>+#define X86_FEATURE_SMX			( 4*32+ 6) /* "smx" Safer Mode eXtensions */
>+#define X86_FEATURE_EST			( 4*32+ 7) /* "est" Enhanced SpeedStep */
>+#define X86_FEATURE_TM2			( 4*32+ 8) /* "tm2" Thermal Monitor 2 */
>+#define X86_FEATURE_SSSE3		( 4*32+ 9) /* "ssse3" Supplemental SSE-3 */
>+#define X86_FEATURE_CID			( 4*32+10) /* "cid" Context ID */
>+#define X86_FEATURE_SDBG		( 4*32+11) /* "sdbg" Silicon Debug */
>+#define X86_FEATURE_FMA			( 4*32+12) /* "fma" Fused multiply-add */
>+#define X86_FEATURE_CX16		( 4*32+13) /* "cx16" CMPXCHG16B instruction */
>+#define X86_FEATURE_XTPR		( 4*32+14) /* "xtpr" Send Task Priority Messag=
es */
>+#define X86_FEATURE_PDCM		( 4*32+15) /* "pdcm" Perf/Debug Capabilities M=
SR */
>+#define X86_FEATURE_PCID		( 4*32+17) /* "pcid" Process Context Identifie=
rs */
>+#define X86_FEATURE_DCA			( 4*32+18) /* "dca" Direct Cache Access */
> #define X86_FEATURE_XMM4_1		( 4*32+19) /* "sse4_1" SSE-4=2E1 */
> #define X86_FEATURE_XMM4_2		( 4*32+20) /* "sse4_2" SSE-4=2E2 */
>-#define X86_FEATURE_X2APIC		( 4*32+21) /* X2APIC */
>-#define X86_FEATURE_MOVBE		( 4*32+22) /* MOVBE instruction */
>-#define X86_FEATURE_POPCNT		( 4*32+23) /* POPCNT instruction */
>-#define X86_FEATURE_TSC_DEADLINE_TIMER	( 4*32+24) /* TSC deadline timer =
*/
>-#define X86_FEATURE_AES			( 4*32+25) /* AES instructions */
>-#define X86_FEATURE_XSAVE		( 4*32+26) /* XSAVE/XRSTOR/XSETBV/XGETBV inst=
ructions */
>-#define X86_FEATURE_OSXSAVE		( 4*32+27) /* "" XSAVE instruction enabled =
in the OS */
>-#define X86_FEATURE_AVX			( 4*32+28) /* Advanced Vector Extensions */
>-#define X86_FEATURE_F16C		( 4*32+29) /* 16-bit FP conversions */
>-#define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
>-#define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
>+#define X86_FEATURE_X2APIC		( 4*32+21) /* "x2apic" X2APIC */
>+#define X86_FEATURE_MOVBE		( 4*32+22) /* "movbe" MOVBE instruction */
>+#define X86_FEATURE_POPCNT		( 4*32+23) /* "popcnt" POPCNT instruction */
>+#define X86_FEATURE_TSC_DEADLINE_TIMER	( 4*32+24) /* "tsc_deadline_timer=
" TSC deadline timer */
>+#define X86_FEATURE_AES			( 4*32+25) /* "aes" AES instructions */
>+#define X86_FEATURE_XSAVE		( 4*32+26) /* "xsave" XSAVE/XRSTOR/XSETBV/XGE=
TBV instructions */
>+#define X86_FEATURE_OSXSAVE		( 4*32+27) /* XSAVE instruction enabled in =
the OS */
>+#define X86_FEATURE_AVX			( 4*32+28) /* "avx" Advanced Vector Extensions=
 */
>+#define X86_FEATURE_F16C		( 4*32+29) /* "f16c" 16-bit FP conversions */
>+#define X86_FEATURE_RDRAND		( 4*32+30) /* "rdrand" RDRAND instruction */
>+#define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a =
hypervisor */
>=20
> /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word =
5 */
> #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
> #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
> #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) *=
/
> #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enab=
led */
>-#define X86_FEATURE_ACE2		( 5*32+ 8) /* Advanced Cryptography Engine v2 =
*/
>-#define X86_FEATURE_ACE2_EN		( 5*32+ 9) /* ACE v2 enabled */
>-#define X86_FEATURE_PHE			( 5*32+10) /* PadLock Hash Engine */
>-#define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
>-#define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
>-#define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
>+#define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Eng=
ine v2 */
>+#define X86_FEATURE_ACE2_EN		( 5*32+ 9) /* "ace2_en" ACE v2 enabled */
>+#define X86_FEATURE_PHE			( 5*32+10) /* "phe" PadLock Hash Engine */
>+#define X86_FEATURE_PHE_EN		( 5*32+11) /* "phe_en" PHE enabled */
>+#define X86_FEATURE_PMM			( 5*32+12) /* "pmm" PadLock Montgomery Multipl=
ier */
>+#define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
>=20
> /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
>-#define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
>-#define X86_FEATURE_CMP_LEGACY		( 6*32+ 1) /* If yes HyperThreading not =
valid */
>-#define X86_FEATURE_SVM			( 6*32+ 2) /* Secure Virtual Machine */
>-#define X86_FEATURE_EXTAPIC		( 6*32+ 3) /* Extended APIC space */
>-#define X86_FEATURE_CR8_LEGACY		( 6*32+ 4) /* CR8 in 32-bit mode */
>-#define X86_FEATURE_ABM			( 6*32+ 5) /* Advanced bit manipulation */
>-#define X86_FEATURE_SSE4A		( 6*32+ 6) /* SSE-4A */
>-#define X86_FEATURE_MISALIGNSSE		( 6*32+ 7) /* Misaligned SSE mode */
>-#define X86_FEATURE_3DNOWPREFETCH	( 6*32+ 8) /* 3DNow prefetch instructi=
ons */
>-#define X86_FEATURE_OSVW		( 6*32+ 9) /* OS Visible Workaround */
>-#define X86_FEATURE_IBS			( 6*32+10) /* Instruction Based Sampling */
>-#define X86_FEATURE_XOP			( 6*32+11) /* extended AVX instructions */
>-#define X86_FEATURE_SKINIT		( 6*32+12) /* SKINIT/STGI instructions */
>-#define X86_FEATURE_WDT			( 6*32+13) /* Watchdog timer */
>-#define X86_FEATURE_LWP			( 6*32+15) /* Light Weight Profiling */
>-#define X86_FEATURE_FMA4		( 6*32+16) /* 4 operands MAC instructions */
>-#define X86_FEATURE_TCE			( 6*32+17) /* Translation Cache Extension */
>-#define X86_FEATURE_NODEID_MSR		( 6*32+19) /* NodeId MSR */
>-#define X86_FEATURE_TBM			( 6*32+21) /* Trailing Bit Manipulations */
>-#define X86_FEATURE_TOPOEXT		( 6*32+22) /* Topology extensions CPUID lea=
fs */
>-#define X86_FEATURE_PERFCTR_CORE	( 6*32+23) /* Core performance counter =
extensions */
>-#define X86_FEATURE_PERFCTR_NB		( 6*32+24) /* NB performance counter ext=
ensions */
>-#define X86_FEATURE_BPEXT		( 6*32+26) /* Data breakpoint extension */
>-#define X86_FEATURE_PTSC		( 6*32+27) /* Performance time-stamp counter *=
/
>-#define X86_FEATURE_PERFCTR_LLC		( 6*32+28) /* Last Level Cache performa=
nce counter extensions */
>-#define X86_FEATURE_MWAITX		( 6*32+29) /* MWAIT extension (MONITORX/MWAI=
TX instructions) */
>+#define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long m=
ode */
>+#define X86_FEATURE_CMP_LEGACY		( 6*32+ 1) /* "cmp_legacy" If yes HyperT=
hreading not valid */
>+#define X86_FEATURE_SVM			( 6*32+ 2) /* "svm" Secure Virtual Machine */
>+#define X86_FEATURE_EXTAPIC		( 6*32+ 3) /* "extapic" Extended APIC space=
 */
>+#define X86_FEATURE_CR8_LEGACY		( 6*32+ 4) /* "cr8_legacy" CR8 in 32-bit=
 mode */
>+#define X86_FEATURE_ABM			( 6*32+ 5) /* "abm" Advanced bit manipulation =
*/
>+#define X86_FEATURE_SSE4A		( 6*32+ 6) /* "sse4a" SSE-4A */
>+#define X86_FEATURE_MISALIGNSSE		( 6*32+ 7) /* "misalignsse" Misaligned =
SSE mode */
>+#define X86_FEATURE_3DNOWPREFETCH	( 6*32+ 8) /* "3dnowprefetch" 3DNow pr=
efetch instructions */
>+#define X86_FEATURE_OSVW		( 6*32+ 9) /* "osvw" OS Visible Workaround */
>+#define X86_FEATURE_IBS			( 6*32+10) /* "ibs" Instruction Based Sampling=
 */
>+#define X86_FEATURE_XOP			( 6*32+11) /* "xop" Extended AVX instructions =
*/
>+#define X86_FEATURE_SKINIT		( 6*32+12) /* "skinit" SKINIT/STGI instructi=
ons */
>+#define X86_FEATURE_WDT			( 6*32+13) /* "wdt" Watchdog timer */
>+#define X86_FEATURE_LWP			( 6*32+15) /* "lwp" Light Weight Profiling */
>+#define X86_FEATURE_FMA4		( 6*32+16) /* "fma4" 4 operands MAC instructio=
ns */
>+#define X86_FEATURE_TCE			( 6*32+17) /* "tce" Translation Cache Extensio=
n */
>+#define X86_FEATURE_NODEID_MSR		( 6*32+19) /* "nodeid_msr" NodeId MSR */
>+#define X86_FEATURE_TBM			( 6*32+21) /* "tbm" Trailing Bit Manipulations=
 */
>+#define X86_FEATURE_TOPOEXT		( 6*32+22) /* "topoext" Topology extensions=
 CPUID leafs */
>+#define X86_FEATURE_PERFCTR_CORE	( 6*32+23) /* "perfctr_core" Core perfo=
rmance counter extensions */
>+#define X86_FEATURE_PERFCTR_NB		( 6*32+24) /* "perfctr_nb" NB performanc=
e counter extensions */
>+#define X86_FEATURE_BPEXT		( 6*32+26) /* "bpext" Data breakpoint extensi=
on */
>+#define X86_FEATURE_PTSC		( 6*32+27) /* "ptsc" Performance time-stamp co=
unter */
>+#define X86_FEATURE_PERFCTR_LLC		( 6*32+28) /* "perfctr_llc" Last Level =
Cache performance counter extensions */
>+#define X86_FEATURE_MWAITX		( 6*32+29) /* "mwaitx" MWAIT extension (MONI=
TORX/MWAITX instructions) */
>=20
> /*
>  * Auxiliary flags: Linux defined - For features scattered in various
>@@ -189,93 +189,93 @@
>  *
>  * Reuse free bits when adding new feature flags!
>  */
>-#define X86_FEATURE_RING3MWAIT		( 7*32+ 0) /* Ring 3 MONITOR/MWAIT instr=
uctions */
>-#define X86_FEATURE_CPUID_FAULT		( 7*32+ 1) /* Intel CPUID faulting */
>-#define X86_FEATURE_CPB			( 7*32+ 2) /* AMD Core Performance Boost */
>-#define X86_FEATURE_EPB			( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
>-#define X86_FEATURE_CAT_L3		( 7*32+ 4) /* Cache Allocation Technology L3=
 */
>-#define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2=
 */
>-#define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L=
3 */
>-#define X86_FEATURE_TDX_HOST_PLATFORM	( 7*32+ 7) /* Platform supports be=
ing a TDX host */
>-#define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
>-#define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterfac=
e */
>-#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (X=
SAVES or XSAVEC) */
>-#define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enab=
led */
>-#define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* "" Set/clear IBRS on kern=
el entry/exit */
>-#define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* "" Fill RSB on VM-Exit */
>-#define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory =
Number */
>-#define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L=
2 */
>-#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is impl=
emented */
>-#define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable=
 */
>-#define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
>-#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context swit=
ches */
>-#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring=
 Version 2 */
>-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Predictio=
n Barrier enabled */
>-#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtim=
e firmware calls */
>-#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable S=
peculative Store Bypass=2E */
>-#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementati=
on via LS_CFG MSR */
>-#define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Specu=
lation */
>-#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barri=
er */
>-#define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch P=
redictors */
>-#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and =
newer */
>-#define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE in=
version */
>-#define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
>-#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL=
 configured */
>+#define X86_FEATURE_RING3MWAIT		( 7*32+ 0) /* "ring3mwait" Ring 3 MONITO=
R/MWAIT instructions */
>+#define X86_FEATURE_CPUID_FAULT		( 7*32+ 1) /* "cpuid_fault" Intel CPUID=
 faulting */
>+#define X86_FEATURE_CPB			( 7*32+ 2) /* "cpb" AMD Core Performance Boost=
 */
>+#define X86_FEATURE_EPB			( 7*32+ 3) /* "epb" IA32_ENERGY_PERF_BIAS supp=
ort */
>+#define X86_FEATURE_CAT_L3		( 7*32+ 4) /* "cat_l3" Cache Allocation Tech=
nology L3 */
>+#define X86_FEATURE_CAT_L2		( 7*32+ 5) /* "cat_l2" Cache Allocation Tech=
nology L2 */
>+#define X86_FEATURE_CDP_L3		( 7*32+ 6) /* "cdp_l3" Code and Data Priorit=
ization L3 */
>+#define X86_FEATURE_TDX_HOST_PLATFORM	( 7*32+ 7) /* "tdx_host_platform" =
Platform supports being a TDX host */
>+#define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* "hw_pstate" AMD HW-PState *=
/
>+#define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* "proc_feedback" AMD Proc=
FeedbackInterface */
>+#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* Use compacted XSTATE (XSAV=
ES or XSAVEC) */
>+#define X86_FEATURE_PTI			( 7*32+11) /* "pti" Kernel Page Table Isolatio=
n enabled */
>+#define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* Set/clear IBRS on kernel =
entry/exit */
>+#define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* Fill RSB on VM-Exit */
>+#define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* "intel_ppin" Intel Process=
or Inventory Number */
>+#define X86_FEATURE_CDP_L2		( 7*32+15) /* "cdp_l2" Code and Data Priorit=
ization L2 */
>+#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* MSR SPEC_CTRL is impleme=
nted */
>+#define X86_FEATURE_SSBD		( 7*32+17) /* "ssbd" Speculative Store Bypass =
Disable */
>+#define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocatio=
n */
>+#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switche=
s */
>+#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performan=
ce Monitoring Version 2 */
>+#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction B=
arrier enabled */
>+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime f=
irmware calls */
>+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Spec=
ulative Store Bypass=2E */
>+#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation =
via LS_CFG MSR */
>+#define X86_FEATURE_IBRS		( 7*32+25) /* "ibrs" Indirect Branch Restricte=
d Speculation */
>+#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Predictio=
n Barrier */
>+#define X86_FEATURE_STIBP		( 7*32+27) /* "stibp" Single Thread Indirect =
Branch Predictors */
>+#define X86_FEATURE_ZEN			( 7*32+28) /* Generic flag for all Zen and new=
er */
>+#define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* L1TF workaround PTE inver=
sion */
>+#define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* "ibrs_enhanced" Enhanced=
 IBRS */
>+#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* MSR IA32_FEAT_CTL co=
nfigured */
>=20
> /* Virtualization flags: Linux defined, word 8 */
>-#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
>-#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* Intel FlexPriority */
>-#define X86_FEATURE_EPT			( 8*32+ 2) /* Intel Extended Page Table */
>-#define X86_FEATURE_VPID		( 8*32+ 3) /* Intel Virtual Processor ID */
>+#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* "tpr_shadow" Intel TPR Sha=
dow */
>+#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* "flexpriority" Intel Flex=
Priority */
>+#define X86_FEATURE_EPT			( 8*32+ 2) /* "ept" Intel Extended Page Table =
*/
>+#define X86_FEATURE_VPID		( 8*32+ 3) /* "vpid" Intel Virtual Processor I=
D */
>=20
>-#define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
>-#define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
>-#define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table acce=
ss-dirty bit */
>-#define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMC=
ALL instruction */
>-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL=
 hypercall instruction */
>-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
>-#define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted f=
unction */
>-#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Intel Trust Domain Extensio=
ns Guest */
>+#define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to V=
MCALL */
>+#define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
>+#define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page T=
able access-dirty bit */
>+#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL=
 instruction */
>+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hy=
percall instruction */
>+#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
>+#define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted func=
tion */
>+#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Dom=
ain Extensions Guest */
>=20
> /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>-#define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE=
, WRGSBASE instructions*/
>-#define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* TSC adjustment MSR 0x3B */
>-#define X86_FEATURE_SGX			( 9*32+ 2) /* Software Guard Extensions */
>-#define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation exten=
sions */
>-#define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
>-#define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
>-#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* "" FPU data pointer up=
dated only on x87 exceptions */
>-#define X86_FEATURE_SMEP		( 9*32+ 7) /* Supervisor Mode Execution Protec=
tion */
>-#define X86_FEATURE_BMI2		( 9*32+ 8) /* 2nd group bit manipulation exten=
sions */
>-#define X86_FEATURE_ERMS		( 9*32+ 9) /* Enhanced REP MOVSB/STOSB instruc=
tions */
>-#define X86_FEATURE_INVPCID		( 9*32+10) /* Invalidate Processor Context =
ID */
>-#define X86_FEATURE_RTM			( 9*32+11) /* Restricted Transactional Memory =
*/
>-#define X86_FEATURE_CQM			( 9*32+12) /* Cache QoS Monitoring */
>-#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* "" Zero out FPU CS and FP=
U DS */
>-#define X86_FEATURE_MPX			( 9*32+14) /* Memory Protection Extension */
>-#define X86_FEATURE_RDT_A		( 9*32+15) /* Resource Director Technology Al=
location */
>-#define X86_FEATURE_AVX512F		( 9*32+16) /* AVX-512 Foundation */
>-#define X86_FEATURE_AVX512DQ		( 9*32+17) /* AVX-512 DQ (Double/Quad gran=
ular) Instructions */
>-#define X86_FEATURE_RDSEED		( 9*32+18) /* RDSEED instruction */
>-#define X86_FEATURE_ADX			( 9*32+19) /* ADCX and ADOX instructions */
>-#define X86_FEATURE_SMAP		( 9*32+20) /* Supervisor Mode Access Preventio=
n */
>-#define X86_FEATURE_AVX512IFMA		( 9*32+21) /* AVX-512 Integer Fused Mult=
iply-Add instructions */
>-#define X86_FEATURE_CLFLUSHOPT		( 9*32+23) /* CLFLUSHOPT instruction */
>-#define X86_FEATURE_CLWB		( 9*32+24) /* CLWB instruction */
>-#define X86_FEATURE_INTEL_PT		( 9*32+25) /* Intel Processor Trace */
>-#define X86_FEATURE_AVX512PF		( 9*32+26) /* AVX-512 Prefetch */
>-#define X86_FEATURE_AVX512ER		( 9*32+27) /* AVX-512 Exponential and Reci=
procal */
>-#define X86_FEATURE_AVX512CD		( 9*32+28) /* AVX-512 Conflict Detection *=
/
>-#define X86_FEATURE_SHA_NI		( 9*32+29) /* SHA1/SHA256 Instruction Extens=
ions */
>-#define X86_FEATURE_AVX512BW		( 9*32+30) /* AVX-512 BW (Byte/Word granul=
ar) Instructions */
>-#define X86_FEATURE_AVX512VL		( 9*32+31) /* AVX-512 VL (128/256 Vector L=
ength) Extensions */
>+#define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBAS=
E, RDGSBASE, WRGSBASE instructions*/
>+#define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* "tsc_adjust" TSC adjustmen=
t MSR 0x3B */
>+#define X86_FEATURE_SGX			( 9*32+ 2) /* "sgx" Software Guard Extensions =
*/
>+#define X86_FEATURE_BMI1		( 9*32+ 3) /* "bmi1" 1st group bit manipulatio
Or use a marker like =3D instead of =E2=80=9Dxxx" to explicitly expose it =
under the same name=2E

For extra credit fix up the ones where the user space name is different so=
 duplication isn't needed in so many places=2E

