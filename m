Return-Path: <linux-kernel+bounces-535365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C42A471BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877333A8B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A711482E7;
	Thu, 27 Feb 2025 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vc+clqhD"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFF15E5C2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620952; cv=none; b=V+oYGrUX2P+Ne171ESxjmRypIKWb6gLu3vEZmCUESsC69UPnhnIbQhmG/Q4tGqZSH1w8GoU6GrSh0yE728xs7+gascUt+l7EyPJLWd0YxkSf0aPsvyq9734JT9224NNZucnhQQHbnkD3OSlRDdtn79kNnhR9TCEzksH+6UGP1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620952; c=relaxed/simple;
	bh=MLFcAaV7Kp3fzJwWXrLEW5MrwTlpZh8+LdBgVE9E8LY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOqzyZsQaAILeDFIW1ybTFaoUW+7d+oFblz7Q36d6gUTIw5zIUhuNRt2g2gaTd2jHHEP8ClEGcaECU4Lp22pHk5BvxqGgNvnDs2Yr+zH6FQKATpLxTi/DN2lnlma2uJW8NvLNhnHonzH5q9wy0RCUhs1fD19g4bZYc9vmj0c4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vc+clqhD; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe862ea448so1419593a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740620949; x=1741225749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ql6MsPcFG1hKThKVbS33oCo+B0Gfqh6TWUoqCKtoqBs=;
        b=vc+clqhDIAXxr8H4NcwmaHg/cftakSAcCwiQN+XuxXitUuSgZ1DTE9UObEBh1Y5Ael
         EtBvS1tBVKtWCo6KMQtKViD7tzsSdYeetifJAeTRsPOMW2P1c+wtHG699ZsRv6VrG0pe
         EILhPxLFvyabVjWpItN+ao/WrjMOZtiUDT838Y0/hlHCBFK8pbF3NuSQt+X7rx44LJAy
         snvMYz4KVOKvRLZouVhwoT/JqaZISCA6VwLcKSRPihOrNJipSNG41YD/0U9LySrJpqbh
         /L31g31uln/ZRCkPWxmGGveEsbtUN/3JAGrCqqsz5OiUTIaEujVRFqOLqg8L/iZRsQWT
         GnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740620949; x=1741225749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ql6MsPcFG1hKThKVbS33oCo+B0Gfqh6TWUoqCKtoqBs=;
        b=Aj7HzzwErcX9qH/84QK1VBkc49K6yk9TODXOBizfwdXiH+xuSqRaPT03ylC2cP2yJX
         aASQN01kYPnRC/AI3dg3bPDyzPzP2dCH9n3G9n1r6pnCd7eWhZf+kUTMQzVVDy4o6f50
         bScUAG01x7DCXS3Bp3D+luTAp94VXV/lMY1MsBinEILOc0p86gq30KF5EyCPo9rZdYgY
         kEvbGsTas3bU3nZRktL5ksKKsCewLAfcYeQmCVcebiuptpvqubAkIQFqLnyRwL7xylkQ
         N/RUR6/HVvQzKd4uBTEmakj0GNpCRqCmaZ9MUIwyzE2Cbf+RX2SjJKGH3fdb0LX5KXZ5
         c97w==
X-Gm-Message-State: AOJu0YwsjDYJbbZmEzpDN3LN++vgfz0TZ+JgDuaKr9TbEWAQYdj1qk5f
	U2Mbb7r5+C6pmA2KfqGmJRHY1a/Poi2cxaOXbuqk1AsMW3x2heyij9L6Kj4RwUVIuuRT7TblpnY
	msw==
X-Google-Smtp-Source: AGHT+IHSebIlwvVX9AkLwVEhCgxbe2TyARpKt911VKqev26ad0iwG8j4dXRoe0e4YVDy+hyTSXHejlekFWY=
X-Received: from pjuw13.prod.google.com ([2002:a17:90a:d60d:b0:2f9:dc36:b11])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d43:b0:2fa:b84:b31f
 with SMTP id 98e67ed59e1d1-2fe68d065f6mr15204924a91.25.1740620949332; Wed, 26
 Feb 2025 17:49:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:48:54 -0800
In-Reply-To: <20250227014858.3244505-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227014858.3244505-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227014858.3244505-4-seanjc@google.com>
Subject: [PATCH 3/7] x86, lib: Add WBNOINVD helper functions
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kevin Loughlin <kevinloughlin@google.com>

In line with WBINVD usage, add WBONINVD helper functions.  Fall back to
WBINVD (via alternative()) if WBNOINVD isn't supported, as WBINVD provides
a superset of functionality, just more slowly.

Note, alternative() ensures compatibility with early boot code as needed.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
[sean: massage changelog and comments, use ASM_WBNOINVD and _ASM_BYTES]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/smp.h           |  6 ++++++
 arch/x86/include/asm/special_insns.h | 19 ++++++++++++++++++-
 arch/x86/lib/cache-smp.c             | 11 +++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ee61e322e2a1..d4c50128aa6c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,6 +112,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
+void wbnoinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
 
@@ -159,6 +160,11 @@ static inline void wbinvd_on_all_cpus(void)
 	wbinvd();
 }
 
+static inline void wbnoinvd_on_all_cpus(void)
+{
+	wbnoinvd();
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 03e7c2d49559..962477a83584 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -117,7 +117,24 @@ static inline void wrpkru(u32 pkru)
 
 static __always_inline void wbinvd(void)
 {
-	asm volatile("wbinvd": : :"memory");
+	asm volatile("wbinvd" : : : "memory");
+}
+
+/* Instruction encoding provided for binutils backwards compatibility. */
+#define ASM_WBNOINVD _ASM_BYTES(0xf3,0x0f,0x09)
+
+/*
+ * Cheaper version of wbinvd(). Call when caches need to be written back but
+ * not invalidated.
+ */
+static __always_inline void wbnoinvd(void)
+{
+	/*
+	 * If WBNOINVD is unavailable, fall back to the compatible but
+	 * more destructive WBINVD (which still writes the caches back
+	 * but also invalidates them).
+	 */
+	alternative("wbinvd", ASM_WBNOINVD, X86_FEATURE_WBNOINVD);
 }
 
 static inline unsigned long __read_cr4(void)
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 079c3f3cd32c..1789db5d8825 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -19,3 +19,14 @@ void wbinvd_on_all_cpus(void)
 	on_each_cpu(__wbinvd, NULL, 1);
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
+
+static void __wbnoinvd(void *dummy)
+{
+	wbnoinvd();
+}
+
+void wbnoinvd_on_all_cpus(void)
+{
+	on_each_cpu(__wbnoinvd, NULL, 1);
+}
+EXPORT_SYMBOL(wbnoinvd_on_all_cpus);
-- 
2.48.1.711.g2feabab25a-goog


