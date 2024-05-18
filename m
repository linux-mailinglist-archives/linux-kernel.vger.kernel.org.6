Return-Path: <linux-kernel+bounces-182713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8748C8EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C621F2252F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25329A2;
	Sat, 18 May 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LYQ9wfKF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974B10A11
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990686; cv=none; b=J08VXWjzeWvlIsLmd9NKLRNAkb49d5pZvWnMkw/Z2qc1H9RRaqKztWMeQV4iXtnIzSZkjd88SucXMAnaaLoxSrL6qG5zxkNWOJMwczp6mSBTOFd11EcLl+RNIhR6zaTh6LYJ49W+UlUJ5YX2oKauxpCghGwd3DbajO7XIpwMJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990686; c=relaxed/simple;
	bh=4/2HLzcusjSlO0rsq/T4/YEv0mk4XS4XnM4Qi5lbYss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aoe/nd4eacgbvE78rvASRmJaNImsukJMcauVGigtryDiuwGRNLgMQK/+MlPzDDwFer8IkbLibYwgCtzXCn4+UDVTvuXWcAd+/9ZwdrPuXzvyPxe2ioxz4Mxqhj0H9Z8ZzDatc3Wdn4smvjgYVUuavl+FA60zmdfIPze37b8Vofg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LYQ9wfKF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f449ea6804so10624169b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715990684; x=1716595484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QlWrNPMcBNIRjZ1oRUuV/rtUWiyhfC1iM9WcCPk5B74=;
        b=LYQ9wfKF3VBD8azfAFN5KBqS0dei6FaLHfqbNkwe+RREVRBklz1ONbLp0/F9vFB0Bw
         RiZUvJr92W0HSqwzD01xHqbOe+wiPocIIpqvPE6gJl/kYp2dQxFChzWlI7Cpp8cV+pWD
         XHB8V5RMx7hkpDtJOEnofk1m46Ghp7Xwno06HwbkVL+hDcwcnDPhnzylCuwomDikEUcX
         cVJmWr8HC0QYzZ51QnzYGrSwuSZy1K/c33VfwPW5ACGsjyS38TUEpc4UCRtECPavCB6i
         4uRRvzEJ0eBtyFt7xUTjfghs4HhW6fepnOI3QRafWBlaUnGONr0TnACLF2CFYI3g7d9U
         L2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715990684; x=1716595484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlWrNPMcBNIRjZ1oRUuV/rtUWiyhfC1iM9WcCPk5B74=;
        b=n7O6QBHlmBGK0DV/VB0SvxWFmvgUpSdH98iq1BuCTTvJp0Un9gV0zGy0nryPgcXCV7
         HWVlG+UOOh1Gt+p8afWlqgOZAV01/NRVLRSgzRLlQEmCrSA6Tz0EE03lsU3UWfxrjmt7
         B6Ihi326/VKKpq6xJvM4w5psbjjxBk62OaXej/VXNBimsnuThyCGEyJ2tYOrw6pyd7mE
         WV+PgRGzFivgx9obscEHVJUv3rF8oyd0jAjM5r2Px0qYlmErnkfiPc8pK1VAbx/U+fdM
         Hr9plKishdeiClIDyVPjBB+WA0bRUoX5pjIabFXtcJx9TaC7LIikgaBj6iM7gpOAo6Bp
         d6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXHUR9DH77CD6zHW6HorZLlGhQ4rTVE0m3gi5gaK4MOvkuD2VXABaiqEw5JCU38tTnSLSydxJeTp1e2jN2Eg4cnl2Vkh1Hpr9V6eqFG
X-Gm-Message-State: AOJu0Yy6H0X1Pg6V357b/lr+hgDFL9a1OlTtP/flgzcgyW+opQpeJJ7T
	rG66PPYPhZ977VAzBGL4wROHWinwxqbfw4MfpH7OQ1PNRP4CSvN9tnQqHpXSWVo48r5qEPASn2V
	kSA==
X-Google-Smtp-Source: AGHT+IGXTb5HJ+lESm2mn7d52eb+nyx9ads/DAkFTkEN0ck3hpsE/NtPnquqJPYm3p9JzsWWbbm5Xh2kiJg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ea:88cd:67e9 with SMTP id
 d2e1a72fcca58-6f4e0376006mr1193202b3a.4.1715990684360; Fri, 17 May 2024
 17:04:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 17:04:25 -0700
In-Reply-To: <20240518000430.1118488-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240518000430.1118488-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: x86/mmu: Add sanity checks that KVM doesn't create
 EPT #VE SPTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assert that KVM doesn't set a SPTE to a value that could trigger an EPT
Violation #VE on a non-MMIO SPTE, e.g. to help detect bugs even without
KVM_INTEL_PROVE_VE enabled, and to help debug actual #VE failures.

Note, this will run afoul of TDX support, which needs to reflect emulated
MMIO accesses into the guest as #VEs (which was the whole point of adding
EPT Violation #VE support in KVM).  The obvious fix for that is to exempt
MMIO SPTEs, but that's annoyingly difficult now that is_mmio_spte() relies
on a per-VM value.  However, resolving that conundrum is a future problem,
whereas getting KVM_INTEL_PROVE_VE healthy is a current problem.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c      | 3 +++
 arch/x86/kvm/mmu/spte.h     | 9 +++++++++
 arch/x86/kvm/mmu/tdp_iter.h | 2 ++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5095fb46713e..d2af077d8b34 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -336,16 +336,19 @@ static int is_cpuid_PSE36(void)
 #ifdef CONFIG_X86_64
 static void __set_spte(u64 *sptep, u64 spte)
 {
+	KVM_MMU_WARN_ON(is_ept_ve_possible(spte));
 	WRITE_ONCE(*sptep, spte);
 }
 
 static void __update_clear_spte_fast(u64 *sptep, u64 spte)
 {
+	KVM_MMU_WARN_ON(is_ept_ve_possible(spte));
 	WRITE_ONCE(*sptep, spte);
 }
 
 static u64 __update_clear_spte_slow(u64 *sptep, u64 spte)
 {
+	KVM_MMU_WARN_ON(is_ept_ve_possible(spte));
 	return xchg(sptep, spte);
 }
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 5dd5405fa07a..52fa004a1fbc 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -3,6 +3,8 @@
 #ifndef KVM_X86_MMU_SPTE_H
 #define KVM_X86_MMU_SPTE_H
 
+#include <asm/vmx.h>
+
 #include "mmu.h"
 #include "mmu_internal.h"
 
@@ -276,6 +278,13 @@ static inline bool is_shadow_present_pte(u64 pte)
 	return !!(pte & SPTE_MMU_PRESENT_MASK);
 }
 
+static inline bool is_ept_ve_possible(u64 spte)
+{
+	return (shadow_present_mask & VMX_EPT_SUPPRESS_VE_BIT) &&
+	       !(spte & VMX_EPT_SUPPRESS_VE_BIT) &&
+	       (spte & VMX_EPT_RWX_MASK) != VMX_EPT_MISCONFIG_WX_VALUE;
+}
+
 /*
  * Returns true if A/D bits are supported in hardware and are enabled by KVM.
  * When enabled, KVM uses A/D bits for all non-nested MMUs.  Because L1 can
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index fae559559a80..2880fd392e0c 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -21,11 +21,13 @@ static inline u64 kvm_tdp_mmu_read_spte(tdp_ptep_t sptep)
 
 static inline u64 kvm_tdp_mmu_write_spte_atomic(tdp_ptep_t sptep, u64 new_spte)
 {
+	KVM_MMU_WARN_ON(is_ept_ve_possible(new_spte));
 	return xchg(rcu_dereference(sptep), new_spte);
 }
 
 static inline void __kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 new_spte)
 {
+	KVM_MMU_WARN_ON(is_ept_ve_possible(new_spte));
 	WRITE_ONCE(*rcu_dereference(sptep), new_spte);
 }
 
-- 
2.45.0.215.g3402c0e53f-goog


