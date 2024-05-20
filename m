Return-Path: <linux-kernel+bounces-184033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094F8CA1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E63B2824A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9701386C6;
	Mon, 20 May 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yp5Kp5u/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18860138486
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227977; cv=none; b=WvkTFfzePSMU6Q1K7ko2/2uO9c+W/QInjX0Naw8MGXc6cpOYHob9i6BIdlAdIyMa+4iWYzK/vdTy0TP+FrQt0NNAijD98FnMlgalZn7C7Lj9+ubxRz6LwzxP8WnuZ7sfXlO0E1wDMK52G2tmTfqYwLB/IREo7M0JSNg/YRLNEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227977; c=relaxed/simple;
	bh=oYeg6M/8BXFeF72GIZUJoyQ6cz3+t2Q25cnBZ3MlWBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TxOy/xGf/PFhXFuspo1nVZDDkBFPV+ILrbbQ9Xt1pt8DIxwXyCcFK+5FaMqND4CCbL8bUlQxSKuwn7R8PERN2lmRZUO7kX+5WVVQvBQnkLV2qdAdHDQVSWznk4nCDGz5q6ZoVROn32tEbcCbuSHCXXReElPqf9BheWMm3aqdIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yp5Kp5u/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6576ea645caso3877224a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716227975; x=1716832775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JpEBqP0Ldwf12x5b7wHEkxdUDEyE4xwWPLNZsKClKoI=;
        b=Yp5Kp5u/uGONhvCspXtJe8XBCFU/Z7hcLCkNleVm51s0Mq8ugYJrtqd9nJ4BbJ6bMN
         43xnol/Yyqck8r/xnpNgyUhRoRMZF7onCASZW0jL/z+T68M1UnurKxHh10U+h+e7wQek
         jCqClTfHD026BWstfFw3w4QF2NdY91J9Qf0+uFuYiOZOu4oF+gm+u88wnA1JEDyxTUnI
         TOnZh1VeKqK65KyvTtKHrSBD3nBUC8ny4AolN+EwZAPY5+6RUXJaF1y+gVSc0V/nwuBR
         Q0wvPtd11gDqQciIFLYZABypq8lcTWXFyxqAQJjWF5rSJ+gSCQj0yEyJ5m6Ezt6JFu5k
         UzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227975; x=1716832775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpEBqP0Ldwf12x5b7wHEkxdUDEyE4xwWPLNZsKClKoI=;
        b=Foegd/iSzyXnEYdS4b5aoOJnsiO89Fl/lsaiOIYllU47ZeO0KGWV/DJPOCrOYdCpha
         zlFSJBkQmOpZPuHsNkJOscXWr/5+QL8BceLukxU4udcZy8QXowAIyMqznlADppzWc/Um
         +157W+Mztl8HrNnhALjHg516kQzvYjH4l+pNhDGL4/AUCzQ6HYhSlLIyeEZfKzbLRPTs
         dE3WLRS4DzSJxs/NZ3yha5W53iVCQbmk46/zU6biic+GrJp/oQo19uxH3k7Db72s23lk
         3KhbpBXgtIBHmSWhl7P4W7pJmZN+pd+5TkZHPvwehfFxGfQHUMtEQ/tdujn7uP9vV7MM
         hRCw==
X-Forwarded-Encrypted: i=1; AJvYcCUX42ifBs+vg8ZN4wxfrHAa+Z51W1P/71KBVIpy09aNtEY4v5YmJiPvO5qP2gCr81fbQri0eQLFpQ0GxX68Q/8RY6Xre6Q3qpO7uRMM
X-Gm-Message-State: AOJu0YzNy2qjy7beGD/uyGJKd35iSfHzfDdrP+6i+pPr52pHHBG0ItNC
	R3bB/h+aeEh6EcKBIDCJRzUu1Ws8QcD6eNCi57vbtbh7sXav7bUh7v+qPPq5G/4gzA2XZgU1BJ5
	aDg==
X-Google-Smtp-Source: AGHT+IEOu/2YerqvdzvBFSVRcUGgUSMcWRA2TkehcJx5HjxojCJ44A4qUh7KAauzh2u/qViqKGGCRWmo4sA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:ef44:0:b0:5f4:10b5:a26f with SMTP id
 41be03b00d2f7-637422d834fmr75772a12.8.1716227975379; Mon, 20 May 2024
 10:59:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 May 2024 10:59:17 -0700
In-Reply-To: <20240520175925.1217334-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520175925.1217334-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240520175925.1217334-3-seanjc@google.com>
Subject: [PATCH v7 02/10] x86/cpu: KVM: Move macro to encode PAT value to
 common header
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move pat/memtype.c's PAT() macro to msr-index.h as PAT_VALUE(), and use it
in KVM to define the default (Power-On / RESET) PAT value instead of open
coding an inscrutable magic number.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h |  6 ++++++
 arch/x86/kvm/x86.h               |  3 ++-
 arch/x86/mm/pat/memtype.c        | 13 +++----------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ea00500a263..b14434af00df 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -378,6 +378,12 @@
 
 #define MSR_IA32_CR_PAT			0x00000277
 
+#define PAT_VALUE(p0, p1, p2, p3, p4, p5, p6, p7)			\
+	((X86_MEMTYPE_ ## p0)      | (X86_MEMTYPE_ ## p1 << 8)  |	\
+	(X86_MEMTYPE_ ## p2 << 16) | (X86_MEMTYPE_ ## p3 << 24) |	\
+	(X86_MEMTYPE_ ## p4 << 32) | (X86_MEMTYPE_ ## p5 << 40) |	\
+	(X86_MEMTYPE_ ## p6 << 48) | (X86_MEMTYPE_ ## p7 << 56))
+
 #define MSR_IA32_DEBUGCTLMSR		0x000001d9
 #define MSR_IA32_LASTBRANCHFROMIP	0x000001db
 #define MSR_IA32_LASTBRANCHTOIP		0x000001dc
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d80a4c6b5a38..3a1274371f22 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -89,7 +89,8 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
 	return max(val, min);
 }
 
-#define MSR_IA32_CR_PAT_DEFAULT  0x0007040600070406ULL
+#define MSR_IA32_CR_PAT_DEFAULT	\
+	PAT_VALUE(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC)
 
 void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
 int kvm_check_nested_events(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0417368011c4..365af5a84fbf 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -247,12 +247,6 @@ void pat_cpu_init(void)
 void __init pat_bp_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
-#define PAT(p0, p1, p2, p3, p4, p5, p6, p7)				\
-	((X86_MEMTYPE_ ## p0)      | (X86_MEMTYPE_ ## p1 << 8)  |	\
-	(X86_MEMTYPE_ ## p2 << 16) | (X86_MEMTYPE_ ## p3 << 24) |	\
-	(X86_MEMTYPE_ ## p4 << 32) | (X86_MEMTYPE_ ## p5 << 40) |	\
-	(X86_MEMTYPE_ ## p6 << 48) | (X86_MEMTYPE_ ## p7 << 56))
-
 
 	if (!IS_ENABLED(CONFIG_X86_PAT))
 		pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
@@ -283,7 +277,7 @@ void __init pat_bp_init(void)
 		 * NOTE: When WC or WP is used, it is redirected to UC- per
 		 * the default setup in __cachemode2pte_tbl[].
 		 */
-		pat_msr_val = PAT(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC);
+		pat_msr_val = PAT_VALUE(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC);
 	}
 
 	/*
@@ -318,7 +312,7 @@ void __init pat_bp_init(void)
 		 * NOTE: When WT or WP is used, it is redirected to UC- per
 		 * the default setup in __cachemode2pte_tbl[].
 		 */
-		pat_msr_val = PAT(WB, WC, UC_MINUS, UC, WB, WC, UC_MINUS, UC);
+		pat_msr_val = PAT_VALUE(WB, WC, UC_MINUS, UC, WB, WC, UC_MINUS, UC);
 	} else {
 		/*
 		 * Full PAT support.  We put WT in slot 7 to improve
@@ -346,13 +340,12 @@ void __init pat_bp_init(void)
 		 * The reserved slots are unused, but mapped to their
 		 * corresponding types in the presence of PAT errata.
 		 */
-		pat_msr_val = PAT(WB, WC, UC_MINUS, UC, WB, WP, UC_MINUS, WT);
+		pat_msr_val = PAT_VALUE(WB, WC, UC_MINUS, UC, WB, WP, UC_MINUS, WT);
 	}
 
 	memory_caching_control |= CACHE_PAT;
 
 	init_cache_modes(pat_msr_val);
-#undef PAT
 }
 
 static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
-- 
2.45.0.215.g3402c0e53f-goog


