Return-Path: <linux-kernel+bounces-307522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D0D964E77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A41C22830
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD361B86ED;
	Thu, 29 Aug 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbnuBNOP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B41B9B53
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958708; cv=none; b=dr1Q8NKiSJ0N6Rb/uJJAYXNAykgPP9X1cxZOwjEFELa5x1Ll8s7jHq3jfu6r4zRyM+Qvlp+Op4tY/oUJsDQmQCwI2JEQZt7mFhPBOa437Sk8SEuOafoBUfVLHk/C5stvAxnd7d4L414rW7BegtGPtrMKo7Wl79zruWYcticywt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958708; c=relaxed/simple;
	bh=rrJ9r8ms6kWklefGCuisxnO/txgebqDl2+mcGhArhVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWiUgjNk131kWcTxxL5aQVkZWJwuyS78Rf+Awbu8hoCgRwdlMnPr2nCI8IBWjhxr7+w1fMHR2mV6nSNaVFV2svyqcWIHDgsBU/awDattaodxxbwW1wNciPaBxrLNB8OQnMyX7reqj17KW554UlCKpql0Rr3ngw8hv0MI3+wO8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbnuBNOP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11cdb464f2so1661761276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724958706; x=1725563506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S15CpaBo2DhgLbkSJxYME2NDX2/9h7B78GJzx7e7VI8=;
        b=FbnuBNOPZ/AngrcPeAweUGlKVixahb939VBgnk2QcWyRyK9ewmQuTzG9WWBSwHubZz
         rOz/tsF8OflJLoQA5x3+tkbK33w2RKJdWrq/pLjiIk7Gdjwa97Ny0Qhs2k3JWdEHDSus
         d2V8ZrCFywPmx3cHwANx3hL+v5LkMeWDgsFqrGc1z8ibylEbLjE+q8Vt8Opc9OvFBRdU
         ViRVUwIGy6lOTAAe4qSVkJ27iVniKqk0i9yE397JYtxh4i343N+l4Sv3t+aHLlH67a9A
         HYwdOifSoqarhrQYXymWh5V8KbzgLLT+O4/6LaMdClv6ZmA6PlMDwPuAWPT42theU//3
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958706; x=1725563506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S15CpaBo2DhgLbkSJxYME2NDX2/9h7B78GJzx7e7VI8=;
        b=trHIWgmqmLKlcQ0tdkZA0Pw43ctQAoV6buAML8zY67t5GtogASLuRAI4g7LxZ2S7B3
         qv58ZKlHEcdJD7dRrE0TrdfiPFBeMKpSaAg0AkfVyYOTtQnPGAIyQDClhgnR4aHCVctY
         K5CzAqxkNmkCYdyvIwzRNkUXbB9fnu0J40qtY5bM6IRLB+uJr75dtXBfXvg9iY9Vhf6Z
         6SkltTIWh2gQaV2/4szxquq0dFleWqoZaSkIPGlN1DdILN12e7h57Y8sWwwwcH4EHLPo
         NcWwRQyaq9KLjTC5X0ZCdePWg9GxzFfDENus7YSakHoRJfUEwXh3kIy8LssBoEQ7zTmG
         FWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgf/55HpgIZLGI+bRhdtPznIKlgh3Ck8AD1/PkVWmwUqMUW0C4TGHZrU8nmHbVK+4MDv9fTwsYhDYVMso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvE1KUVXzLT2lexPV1LJAD2YBScR5urTasS+066bQsCYk5+971
	/jBlUAfK5uhxDQZ051IzhSR+9BWcorbXkYjyTS4x9b6P2rhrGNzusyiSiQcBNm3GCxTcZlreC9O
	cDL0NJQ==
X-Google-Smtp-Source: AGHT+IEtzc+zngyHL/Sycpta8KjyasW4DBxaRHtMDv8dCHg39P7HkVopIgMp8dEHRyXqnlzPS1+e/d0iUksR
X-Received: from vipin.c.googlers.com ([35.247.89.60]) (user=vipinsh
 job=sendgmr) by 2002:a25:a2c4:0:b0:e0b:a712:2ceb with SMTP id
 3f1490d57ef6-e1a5ab8d7d0mr22335276.5.1724958705697; Thu, 29 Aug 2024 12:11:45
 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:11:34 -0700
In-Reply-To: <20240829191135.2041489-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829191135.2041489-1-vipinsh@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829191135.2041489-4-vipinsh@google.com>
Subject: [PATCH v2 3/4] KVM: x86/mmu: Rearrange locks and to_zap count for NX
 huge page recovery
From: Vipin Sharma <vipinsh@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dmatlack@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract out locks from TDP and legacy MMU NX huge page recovery flow and
use them at a common place inside recovery worker. Also, move to_zap
calculations to their respective recovery functions.

Extracting out locks will allow acquiring and using locks for
TDP flow in the same way as other TDP APIs i.e. take read lock and then
call the TDP APIs. This will be utilized when TDP MMU NX huge page
recovery will switch to using read lock.

to_zap calculation outside recovery code was needed as same code was
used for both TDP and legacy MMU. Now, as both flows have different code
there is no need to calculate them separately at a common place. Let the
respective functions handle that.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/mmu.c     | 45 +++++++++++++-------------------------
 arch/x86/kvm/mmu/tdp_mmu.c | 23 +++++--------------
 arch/x86/kvm/mmu/tdp_mmu.h |  5 +----
 3 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c8c64df979e3..d636850c6929 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7354,19 +7354,18 @@ bool kvm_mmu_sp_dirty_logging_enabled(struct kvm *kvm, struct kvm_mmu_page *sp)
 	return slot && kvm_slot_dirty_track_enabled(slot);
 }
 
-static void kvm_mmu_recover_nx_huge_pages(struct kvm *kvm,
-					  struct list_head *nx_huge_pages,
-					  unsigned long to_zap)
+static void kvm_mmu_recover_nx_huge_pages(struct kvm *kvm)
 {
-	int rcu_idx;
+	unsigned long pages = READ_ONCE(kvm->arch.possible_nx_huge_pages_count);
+	unsigned int ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
+	unsigned long to_zap = ratio ? DIV_ROUND_UP(pages, ratio) : 0;
 	struct kvm_mmu_page *sp;
 	LIST_HEAD(invalid_list);
 
-	rcu_idx = srcu_read_lock(&kvm->srcu);
-	write_lock(&kvm->mmu_lock);
+	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	for ( ; to_zap; --to_zap) {
-		if (list_empty(nx_huge_pages))
+		if (list_empty(&kvm->arch.possible_nx_huge_pages))
 			break;
 
 		/*
@@ -7376,7 +7375,7 @@ static void kvm_mmu_recover_nx_huge_pages(struct kvm *kvm,
 		 * the total number of shadow pages.  And because the TDP MMU
 		 * doesn't use active_mmu_pages.
 		 */
-		sp = list_first_entry(nx_huge_pages,
+		sp = list_first_entry(&kvm->arch.possible_nx_huge_pages,
 				      struct kvm_mmu_page,
 				      possible_nx_huge_page_link);
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
@@ -7401,9 +7400,6 @@ static void kvm_mmu_recover_nx_huge_pages(struct kvm *kvm,
 		}
 	}
 	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-
-	write_unlock(&kvm->mmu_lock);
-	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
 
 static long get_nx_huge_page_recovery_timeout(u64 start_time)
@@ -7417,19 +7413,11 @@ static long get_nx_huge_page_recovery_timeout(u64 start_time)
 		       : MAX_SCHEDULE_TIMEOUT;
 }
 
-static unsigned long nx_huge_pages_to_zap(struct kvm *kvm)
-{
-	unsigned long pages = READ_ONCE(kvm->arch.possible_nx_huge_pages_count);
-	unsigned int ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
-
-	return ratio ? DIV_ROUND_UP(pages, ratio) : 0;
-}
-
 static int kvm_nx_huge_page_recovery_worker(struct kvm *kvm, uintptr_t data)
 {
-	unsigned long to_zap;
 	long remaining_time;
 	u64 start_time;
+	int rcu_idx;
 
 	while (true) {
 		start_time = get_jiffies_64();
@@ -7447,19 +7435,16 @@ static int kvm_nx_huge_page_recovery_worker(struct kvm *kvm, uintptr_t data)
 		if (kthread_should_stop())
 			return 0;
 
-		to_zap = nx_huge_pages_to_zap(kvm);
-		kvm_mmu_recover_nx_huge_pages(kvm,
-					      &kvm->arch.possible_nx_huge_pages,
-					      to_zap);
+		rcu_idx = srcu_read_lock(&kvm->srcu);
+		write_lock(&kvm->mmu_lock);
 
+		kvm_mmu_recover_nx_huge_pages(kvm);
 		if (tdp_mmu_enabled) {
-#ifdef CONFIG_X86_64
-			to_zap = kvm_tdp_mmu_nx_huge_pages_to_zap(kvm);
-			kvm_tdp_mmu_recover_nx_huge_pages(kvm,
-						      &kvm->arch.tdp_mmu_possible_nx_huge_pages,
-						      to_zap);
-#endif
+			kvm_tdp_mmu_recover_nx_huge_pages(kvm);
 		}
+
+		write_unlock(&kvm->mmu_lock);
+		srcu_read_unlock(&kvm->srcu, rcu_idx);
 	}
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f0b4341264fd..179cfd67609a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1798,25 +1798,15 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gfn_t gfn,
 	return rcu_dereference(sptep);
 }
 
-unsigned long kvm_tdp_mmu_nx_huge_pages_to_zap(struct kvm *kvm)
+void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm)
 {
 	unsigned long pages = READ_ONCE(kvm->arch.tdp_mmu_possible_nx_huge_pages_count);
 	unsigned int ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
-
-	return ratio ? DIV_ROUND_UP(pages, ratio) : 0;
-}
-
-void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm,
-				   struct list_head *nx_huge_pages,
-				   unsigned long to_zap)
-{
-	int rcu_idx;
+	unsigned long to_zap = ratio ? DIV_ROUND_UP(pages, ratio) : 0;
 	struct kvm_mmu_page *sp;
 	bool flush = false;
 
-	rcu_idx = srcu_read_lock(&kvm->srcu);
-	write_lock(&kvm->mmu_lock);
-
+	lockdep_assert_held_write(&kvm->mmu_lock);
 	/*
 	 * Zapping TDP MMU shadow pages, including the remote TLB flush, must
 	 * be done under RCU protection, because the pages are freed via RCU
@@ -1825,7 +1815,7 @@ void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm,
 	rcu_read_lock();
 
 	for ( ; to_zap; --to_zap) {
-		if (list_empty(nx_huge_pages))
+		if (list_empty(&kvm->arch.tdp_mmu_possible_nx_huge_pages))
 			break;
 
 		/*
@@ -1835,7 +1825,7 @@ void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm,
 		 * the total number of shadow pages.  And because the TDP MMU
 		 * doesn't use active_mmu_pages.
 		 */
-		sp = list_first_entry(nx_huge_pages,
+		sp = list_first_entry(&kvm->arch.tdp_mmu_possible_nx_huge_pages,
 				      struct kvm_mmu_page,
 				      possible_nx_huge_page_link);
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
@@ -1869,7 +1859,4 @@ void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm,
 	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 	rcu_read_unlock();
-
-	write_unlock(&kvm->mmu_lock);
-	srcu_read_unlock(&kvm->srcu, rcu_idx);
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 4036552f40cd..86c1065a672d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -67,10 +67,7 @@ int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gfn_t gfn,
 					u64 *spte);
 
-unsigned long kvm_tdp_mmu_nx_huge_pages_to_zap(struct kvm *kvm);
-void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm,
-				   struct list_head *nx_huge_pages,
-				   unsigned long to_zap);
+void kvm_tdp_mmu_recover_nx_huge_pages(struct kvm *kvm);
 
 #ifdef CONFIG_X86_64
 static inline bool is_tdp_mmu_page(struct kvm_mmu_page *sp) { return sp->tdp_mmu_page; }
-- 
2.46.0.469.g59c65b2a67-goog


