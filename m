Return-Path: <linux-kernel+bounces-309608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04302966D62
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CC51C21F72
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757B15F404;
	Sat, 31 Aug 2024 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqxJs9zS"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B114EC5E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063384; cv=none; b=dBUk2UICHbv7RmQ7TwmWkqA/HqwnHoczEicCi84IQv9RTJOpYIqL8aAVLContX1ETHCuBODj0nKhVMfedWpo62Fno/2Sl9tzseoSSpUyjA3JW6gFmItdBRp7Rji82kjKovTno3ys3wxU1v6dVtjugbL9sJZAQvbGDbiOgwOXKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063384; c=relaxed/simple;
	bh=jbNYq8nf4cToP9nG3R9NtHXCFO1UUWSTXyZK1MFowyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jnYiiCf07EXT/C8jcprAMvUC4at2IU8x0m9xwauL4fXn1W/8qPzR1jGJSQXaBMiiNNnREIkUoVO3xu3Gb52L4ipXi7xoTD6DmtOsIVNidNRwEVXbSQpE+fWsuQewVTWZoimsQOrFnzX08YSPiFNimrzWZS9uAEo6tYMgIfXLrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqxJs9zS; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d406dc42f4so2287029a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063382; x=1725668182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cR1WOtXSuetpHOXK2S+96cMV73XM9Whtcc3KrMXdeXM=;
        b=gqxJs9zS7eFen9ZACMiMMglKRYkC+Xb7ZK7pYkLyKdJTjggbmQvEHqEXPGXI9Nxq41
         IdogRgDcL4iawguzYoGtGTKXVLrvIqW/c8GXBXgLxgecgUmmGQYociWuQDHLL6CebDle
         P3FZhsPvFOyLbtb+CoyYSP1zdWTZ4k+bF0bzf7Kx6Kwix8t2eSd9xD1XRlup0fsrdcju
         SzBaE9maQ65q7Fc06D6/GP2fxGzJDePck5H/kNgLrT+n48Ju5OBy3QgW5GCztmx1ansu
         IQjrxRvH6WvaIwSO51tzHxZ8jy37nGqXSXVyGY/y9S6K80UjVL58lPrr0AuO6KaREsLo
         VTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063382; x=1725668182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cR1WOtXSuetpHOXK2S+96cMV73XM9Whtcc3KrMXdeXM=;
        b=dWsdR1O+V4JkuJDefUZOAtBx/1lB+r8sgkFmfzha4q/xdHIP6kUZLrhIJLAf9g6SJb
         ZAsP/Wl0T7buGitYz0ylpCvPS8LMq87GHwvbnm4f4jtGk/99JkovR/VqzyD259tE/gzW
         OZ9BFQk5Shohi8besWwyXARkVkg05a21WCbUOlxYnMGm8OwjLRcCMUCtqbZZeHBDxLw0
         VSWNPx4BOqtDmLVO8p/hDKrkWTIW7ndmgr1D6EZR1NppRquCzyoq1uJl8GN6kf0shJg0
         YOo0SDmAzXAXlNYnrlxVB3quc+fAe2QECaLyci8m/BF2GGENMzSu6N4yaA309wu3oV/m
         2YMw==
X-Forwarded-Encrypted: i=1; AJvYcCU5vZjx15Va8ePw4pIQaY3jkweoHaAoyXlY7h6D0NO3pJnp4HIZQ6CFZFV2t6WhTKHZPX4uwBAtXNknEQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuUoWdnrsTtC29x/dB++gNhJZOaeS2Nq5ItaLPhdgMvveipeQ
	sGBQIOhb78m7oDtB6d+GnG/MYEIUvLCacByES6Fddue/bdfu8vCPO0yj8Z9o+G2QqrmCtDYryKX
	aew==
X-Google-Smtp-Source: AGHT+IGfs7gXN6qWH4tGlZzsztZguerRTLfMi+oiBPqhIYFJkNIRpCAXsHN1MLCUuyCoUdzMs9CiDW0dVcI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:bc85:b0:2d8:94d4:5845 with SMTP id
 98e67ed59e1d1-2d894d4658amr1195a91.0.1725063381728; Fri, 30 Aug 2024 17:16:21
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Aug 2024 17:15:35 -0700
In-Reply-To: <20240831001538.336683-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831001538.336683-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240831001538.336683-21-seanjc@google.com>
Subject: [PATCH v2 20/22] KVM: x86/mmu: Subsume kvm_mmu_unprotect_page() into
 the and_retry() version
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuan Yao <yuan.yao@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Fold kvm_mmu_unprotect_page() into kvm_mmu_unprotect_gfn_and_retry() now
that all other direct usage is gone.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/mmu/mmu.c          | 33 +++++++++++++--------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4aa10db97f6f..0fbde3ca8d1a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2134,7 +2134,6 @@ int kvm_get_nr_pending_nmis(struct kvm_vcpu *vcpu);
 
 void kvm_update_dr7(struct kvm_vcpu *vcpu);
 
-int kvm_mmu_unprotect_page(struct kvm *kvm, gfn_t gfn);
 bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				       bool always_retry);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aabed77f35d4..d042874b0a3b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2695,27 +2695,12 @@ void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long goal_nr_mmu_pages)
 	write_unlock(&kvm->mmu_lock);
 }
 
-int kvm_mmu_unprotect_page(struct kvm *kvm, gfn_t gfn)
-{
-	struct kvm_mmu_page *sp;
-	LIST_HEAD(invalid_list);
-	int r;
-
-	r = 0;
-	write_lock(&kvm->mmu_lock);
-	for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
-		r = 1;
-		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
-	}
-	kvm_mmu_commit_zap_page(kvm, &invalid_list);
-	write_unlock(&kvm->mmu_lock);
-
-	return r;
-}
-
 bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 				       bool always_retry)
 {
+	struct kvm *kvm = vcpu->kvm;
+	LIST_HEAD(invalid_list);
+	struct kvm_mmu_page *sp;
 	gpa_t gpa = cr2_or_gpa;
 	bool r = false;
 
@@ -2727,7 +2712,7 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * positive is benign, and a false negative will simply result in KVM
 	 * skipping the unprotect+retry path, which is also an optimization.
 	 */
-	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
+	if (!READ_ONCE(kvm->arch.indirect_shadow_pages))
 		goto out;
 
 	if (!vcpu->arch.mmu->root_role.direct) {
@@ -2736,7 +2721,15 @@ bool __kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			goto out;
 	}
 
-	r = kvm_mmu_unprotect_page(vcpu->kvm, gpa_to_gfn(gpa));
+	r = false;
+	write_lock(&kvm->mmu_lock);
+	for_each_gfn_valid_sp_with_gptes(kvm, sp, gpa_to_gfn(gpa)) {
+		r = true;
+		kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
+	}
+	kvm_mmu_commit_zap_page(kvm, &invalid_list);
+	write_unlock(&kvm->mmu_lock);
+
 out:
 	if (r || always_retry) {
 		vcpu->arch.last_retry_eip = kvm_rip_read(vcpu);
-- 
2.46.0.469.g59c65b2a67-goog


