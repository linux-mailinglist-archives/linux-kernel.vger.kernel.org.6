Return-Path: <linux-kernel+bounces-250948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16C92FEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1111C22082
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C5176FAB;
	Fri, 12 Jul 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fc0pFS+N"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079F176AB1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803656; cv=none; b=ZYILzoxl+bpaLtB23vMhrrtldcjMIzm3qhIBQGuALbqMaTkhhXRruFwyZmA4fk+ZE0jhHSmGgsiwjVPTFs2vAFMsV4Qe6R3nU5bYGNgyCWSEL7/i/hCNyBwatcAYx9xwdwwSt5R1z3fWVfuI97ECux4eNYPZosKNVRe7jxZTi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803656; c=relaxed/simple;
	bh=K3gVCDyK+u9CvTzMmL9E5JCyrrcnY9YAK60OCxm0rQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V+EZ2znbm4q21E9tNNEewjSzyW9R6c37fjEeUa6tVQAQYv4tzHsmqIWyhZkswUZOAHgB2p7FgrctQEMtywR+Cuy1AocsAti5CmoUAfyi7qLtdMzRHT70muAWWhXK+IvS/sFRp1j740pAbXfx4zew8GMC+WADsrJi47gNZwwqgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fc0pFS+N; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-426683d9c4bso13382075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720803653; x=1721408453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYkIsXZqE6yHwQwkHX4TOc/fbGXEyWGzvfr2StuEGo8=;
        b=fc0pFS+Nh2U2Mi8rn0F+6Fs1JrbPag9EVaO+Ju4s5e7nUsPuvKL1RRRAmvxblLm4l+
         EcbcppmuJ53lhg1V5k9tcSlcNaioP3kiBXxMXpe+rKcqpTbR5hGKkk9rRyMdpamLHMDU
         sZrRFwFODi2d2RuyX1ssofzsDYri3g4Xfav24XTByxDciYv5NgePdzZzsrpnX8uTn2/M
         Uei7hWFEQ0J7kvTWdCKet+Out8wk7z/hHub4vp3jBUpgQPj9nYf6fFZxq1LNcqi/0LLd
         g3QE4mg0dn2+iBUT0adF0lToa42WGK17l9cjZPIW1V7vpickjp4Y3ksnEr1i3yAOLqaA
         eVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803653; x=1721408453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYkIsXZqE6yHwQwkHX4TOc/fbGXEyWGzvfr2StuEGo8=;
        b=XU8mkkCKAwCv6c1nRV7oZlTPY4sCHHrdAiYSCl5mbTIXlStTLF2L4dusbCgs3j3QiR
         OVk9JowVxbPm+2pReV6kTOB1TaJ82cs+176U1Aqw50uPq9OD6DeTnGQkd1012tJaV9zL
         zU0dcQsYEZ1vP2US3xA43IrDD3Qm+4n1hQj3J7DZjZ221k9zqhPLPaUrlANMHvLoRmPK
         30H2fVuwmkq42pUP7Vt7tIulrFRoVNrSc2EP1tyMKEASAS8xeHlvQRIQUWm5MBd0K5l0
         X7dqP5mbpPaXlHUpWHBLOmNNYRwKV2KWNxLGO6gz6xorx1nUCkxMPblCmnncLILig03e
         geqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCheGNeYM6aCNj2O+pkrbs7B99/k3fIJ7B6Vlk2NIOsHJb3BHJZD8IffZVcw95+W4auQS15rbrL9lBuNoGpI4nJkStwC7s6ev6p+YS
X-Gm-Message-State: AOJu0YyeeNAR8OzDjqqZQuGsfvz/77taaTy9K3gzhJcCihAeRPaRm0zX
	D6o8/Qrl2cV9OcFLiMzqf/+tOc4oX5DU2A5iAsxW39IbKIex04TE2e1APSW6R158/xdDQuoJMti
	F1P/NNYu0cw==
X-Google-Smtp-Source: AGHT+IHv51LtvzZcsv+Q35b3qDQSC+/JaCm1f27HCjANRBhvdVtpbFdUnaeYYxG55HOkAMdxTZXXEQFhJkEhkg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:35c6:b0:424:a4ac:561b with SMTP
 id 5b1f17b1804b1-426708fda54mr866675e9.7.1720803652922; Fri, 12 Jul 2024
 10:00:52 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:00:19 +0000
In-Reply-To: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712-asi-rfc-24-v1-0-144b319a40d8@google.com>
X-Mailer: b4 0.14-dev
Message-ID: <20240712-asi-rfc-24-v1-1-144b319a40d8@google.com>
Subject: [PATCH 01/26] mm: asi: Make some utility functions noinstr compatible
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Liran Alon <liran.alon@oracle.com>, 
	Jan Setje-Eilers <jan.setjeeilers@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Paul Turner <pjt@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Junaid Shahid <junaids@google.com>, Ofir Weisse <oweisse@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Patrick Bellasi <derkling@google.com>, 
	KP Singh <kpsingh@google.com>, Alexandra Sandulescu <aesa@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

From: Junaid Shahid <junaids@google.com>

Some existing utility functions would need to be called from a noinstr
context in the later patches. So mark these as either noinstr or
__always_inline.

Signed-off-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/processor.h     | 2 +-
 arch/x86/include/asm/special_insns.h | 8 ++++----
 arch/x86/mm/tlb.c                    | 8 ++++----
 include/linux/compiler_types.h       | 8 ++++++++
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 78e51b0d6433d..dc45d622eae4e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -206,7 +206,7 @@ void print_cpu_msr(struct cpuinfo_x86 *);
 /*
  * Friendlier CR3 helpers.
  */
-static inline unsigned long read_cr3_pa(void)
+static __always_inline unsigned long read_cr3_pa(void)
 {
 	return __read_cr3() & CR3_ADDR_MASK;
 }
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 2e9fc5c400cdc..c63433dc04d34 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
@@ -153,12 +153,12 @@ static __always_inline void write_cr2(unsigned long x)
  * Careful!  CR3 contains more than just an address.  You probably want
  * read_cr3_pa() instead.
  */
-static inline unsigned long __read_cr3(void)
+static __always_inline unsigned long __read_cr3(void)
 {
 	return __native_read_cr3();
 }
 
-static inline void write_cr3(unsigned long x)
+static __always_inline void write_cr3(unsigned long x)
 {
 	native_write_cr3(x);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047c..6ca18ac9058b6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -110,7 +110,7 @@
 /*
  * Given @asid, compute kPCID
  */
-static inline u16 kern_pcid(u16 asid)
+static inline_or_noinstr u16 kern_pcid(u16 asid)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 
@@ -155,9 +155,9 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
+static inline_or_noinstr unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 {
-	unsigned long cr3 = __sme_pa(pgd) | lam;
+	unsigned long cr3 = __sme_pa_nodebug(pgd) | lam;
 
 	if (static_cpu_has(X86_FEATURE_PCID)) {
 		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
@@ -1087,7 +1087,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  * It's intended to be used for code like KVM that sneakily changes CR3
  * and needs to restore it.  It needs to be used very carefully.
  */
-unsigned long __get_current_cr3_fast(void)
+inline_or_noinstr unsigned long __get_current_cr3_fast(void)
 {
 	unsigned long cr3 =
 		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 8f8236317d5b1..955497335832c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -320,6 +320,14 @@ struct ftrace_likely_data {
  */
 #define __cpuidle __noinstr_section(".cpuidle.text")
 
+/*
+ * Can be used for functions which themselves are not strictly noinstr, but
+ * may be called from noinstr code.
+ */
+#define inline_or_noinstr						\
+	inline notrace __attribute((__section__(".noinstr.text")))	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */

-- 
2.45.2.993.g49e7a77208-goog


