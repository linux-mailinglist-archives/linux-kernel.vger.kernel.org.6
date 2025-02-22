Return-Path: <linux-kernel+bounces-526935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39543A40557
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5859219E066B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44691FFC5C;
	Sat, 22 Feb 2025 03:36:09 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321573451
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195369; cv=none; b=NlBV5LAeheWfGBeuDvjyvvRLmCl71vrLC8nr33PAagmci/Akq6T1vK6lmKx0GNKOHuwsOF5McAw2b2wzYXMeANax/ZGvjg9shi6mP5DPx44L7vVPOrmCuiUpSIDZImBR10yoxBFyTEsc3+ZPJFStagTGktla9MAIRngfkLe1ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195369; c=relaxed/simple;
	bh=w+JOgo8FfDpikwRQsL7QZBSNuI98YTtl+4+2yervku4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMflgk+4a7TEyyRFhB+L7kj0MONy30TKINSALcX+PqPmAQec7CHBRGQ20qLMpY3myACs+zqzh5SAzWyhfFabS1HTD63zTN9PGpPfy9y+TGoftW9gfHQ+kwSjUHV2S4CF5ybLe0B1orfUBW9b5bl5LjFc91ueJqD7HzYt0UQ7Mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlgIK-000000002Cc-10FN;
	Fri, 21 Feb 2025 22:35:12 -0500
Date: Fri, 21 Feb 2025 22:35:11 -0500
From: Rik van Riel <riel@surriel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v12.2 04/16] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250221223511.10f98927@fangorn>
In-Reply-To: <2435a1ed-d8dc-935b-9e96-b709d785a46a@amd.com>
References: <20250221005345.2156760-1-riel@surriel.com>
	<20250221005345.2156760-5-riel@surriel.com>
	<20250221015801.GHZ7fdqaGFEvsG6qW1@fat_crate.local>
	<20250221130322.1c87b284@fangorn>
	<2435a1ed-d8dc-935b-9e96-b709d785a46a@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: riel@surriel.com

On Fri, 21 Feb 2025 12:41:40 -0600
Tom Lendacky <thomas.lendacky@amd.com> wrote:

> I think what you really want is:
>=20
> 	depends on CPU_SUP_AMD && 64BIT
>=20
> And then delete the select X86_BROADCAST_TLB_FLUSH below.
>=20
> Otherwise, won't it be y even if CPU_SUP_AMD isn't y?

I think you're right. Good catch.

I currently have this in my tree:

---8<---
=46rom 49edabe3a1f338b4386c41ff5d378584a320e3db Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Fri, 21 Feb 2025 15:28:39 -0500
Subject: [PATCH 04/16] x86/mm: get INVLPGB count max from CPUID

The CPU advertises the maximum number of pages that can be shot down
with one INVLPGB instruction in the CPUID data.

Save that information for later use.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/Kconfig.cpu               | 4 ++++
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/include/asm/tlbflush.h    | 3 +++
 arch/x86/kernel/cpu/common.c       | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..981def9cbfac 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -401,6 +401,10 @@ menuconfig PROCESSOR_SELECT
 	  This lets you choose what x86 vendor support code your kernel
 	  will include.
=20
+config X86_BROADCAST_TLB_FLUSH
+	def_bool y
+	depends on CPU_SUP_AMD && 64BIT
+
 config CPU_SUP_INTEL
 	default y
 	bool "Support Intel processors" if PROCESSOR_SELECT
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h
index 508c0dad116b..b5c66b7465ba 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -338,6 +338,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Co=
unt */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/res=
tore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instruction=
 supported. */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register a=
t user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instructio=
n */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Bar=
rier */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflus=
h.h
index 3da645139748..09463a2fb05f 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -183,6 +183,9 @@ static inline void cr4_init_shadow(void)
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
=20
+/* How many pages can we invalidate with one INVLPGB. */
+extern u16 invlpgb_count_max;
+
 extern void initialize_tlbstate_and_flush(void);
=20
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7cce91b19fb2..742bdb0c4846 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -95,6 +95,8 @@ EXPORT_SYMBOL(__num_cores_per_package);
 unsigned int __num_threads_per_package __ro_after_init =3D 1;
 EXPORT_SYMBOL(__num_threads_per_package);
=20
+u16 invlpgb_count_max __ro_after_init;
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
@@ -1030,6 +1032,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >=3D 0x80000008) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 		c->x86_capability[CPUID_8000_0008_EBX] =3D ebx;
+		invlpgb_count_max =3D (edx & 0xffff) + 1;
 	}
=20
 	if (c->extended_cpuid_level >=3D 0x8000000a)
--=20
2.47.1


