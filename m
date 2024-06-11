Return-Path: <linux-kernel+bounces-210642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1090468D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B50B25174
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B324154C0C;
	Tue, 11 Jun 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2e+Rm1Z"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0606150991
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143090; cv=none; b=iazXfeviU6mkqyvIFDZCxyZndSmM1c43iGmtgqIsJKW2dOyoviOeVp9h+GubkVHbrH5R/kfR/yIq5hnwG/8Wljm0iTZFlFyHxpdgvD6QvdOfzYCUBzhXtl+vkuMjUpywqzX1cyegmMfZdAG8/Rwvtd3b5Q0vTWYBRbYCO0x15Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143090; c=relaxed/simple;
	bh=IkcUZXxfZfGtEuqDFEfXjk5PL0kaTZTimAtsOntwH0c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LZ39EKW9t4pU2Qh2uTXsz3Qll3A/TFnDSzeQuvTHpXgGOdSiFXnN8v0bOknDG6zOWjn96pc2zP3RQhTihFy1tsGN7BHduru6pQx8sU3WFHSWSD/YHW5A/DlzWm1mVzUphl0waXY0pSysBqZjJveetyGia3i1kWzoN982wWA1fNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2e+Rm1Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6e231ed9e5aso3911431a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718143088; x=1718747888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgBsV7Qs18R7dQFA6CLfjwo4Hn5qZ69LouFSR8EeMz8=;
        b=X2e+Rm1Z4AYIyOONo0fQObTg78gRczxK5LKf2oFsZuuY1iqW9OCdCWIvw94ZwzzK40
         VYbCDMZ4BLXnb11C5/QPSaWqCtlUwRoUqirEqeOg22biTLW33l60ikeXclRAB1MVivEg
         43URBiIb9mdYD71PHDRTyU/nGFxqYqAGALCE+2SCQXd2+lJFQ1tJtWXRevC8gMB7LHQX
         3rOYFsgQaJFdfWwpUFsoJZCHEXUYC8Qc0wWNkNykGmXZaweDOwDVrG1Ck6e3WPBehJtk
         xOtMjujU+Ifpc60uK7UJ6uX1F0kaUFBgsXpT68bOkAoZ+ui+76PgrP4+uFHS6kzXpp7X
         9kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143088; x=1718747888;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgBsV7Qs18R7dQFA6CLfjwo4Hn5qZ69LouFSR8EeMz8=;
        b=H47Ivxu2+Nf5WJjlq0JQXEx8mcZuAilqKePR+CEWve9abo8tAZHJ1RBA7UJ1GvbhBF
         zXQKHQpF5kr2Ume9gE6kRx+3rwkFhdtVgZLpdneffqrPcPZAjA/vmrBbkIpYMMG7mxZD
         Q3oBxZd+VQm0rub+c23AMkYXb/GzPVsT08vIsl3hWWiNs+gOsaOFO24enHfQo2S0J0Qt
         FlQRxS7aK8qquKRlbnHGvcLuprozNzkEYz4jMPK0e3m5iS0qa/4UOVy33g+q1w1w+QnQ
         RFFdRdLTR6ajgvSOjUIH76nRz/IScBds4Voizlkb+73aFc8nJikSuLGfg8buuluQKmbA
         AORQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnfiGyBiy8idQoDwaTmq519NbABXzmxeDPryoqpzUT+cqyCmt/iv0Byw/d9FYs9IQlNStFaB/UYhenaiQNxeSJ01gYmhDeGAPcKhM+
X-Gm-Message-State: AOJu0Yw1QdxONeYSechnZXytxlONc3sxdArFrRGGSiBcPkQCcQb8d2BZ
	DtuyRF9Rrbodvzgw1Ktjos29QL9JG2kyo3YYHwd8nPdUFH7Gk92ibVd57p7LKKAzObw8mMDdVER
	SnA==
X-Google-Smtp-Source: AGHT+IEmldGTIkv1T4o9/PiXtoC4rZne+Dg326PKnj69O+oEtuDXipai7Z86wWOiFzxP3tEmhS691Edp3UQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:bb97:b0:1f6:8033:f361 with SMTP id
 d9443c01a7336-1f83b5df050mr4825ad.6.1718143088022; Tue, 11 Jun 2024 14:58:08
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 11 Jun 2024 14:58:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611215805.340664-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Clean up function comments for dirty logging APIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework the function comment for kvm_arch_mmu_enable_log_dirty_pt_masked(),
as it has gotten a bit stale, and is the last source of warnings for W=1
builds in KVM x86 due to using a kernel-doc comment without documenting
all parameters.

Opportunistically subsume the functions comments for
kvm_mmu_write_protect_pt_masked() and kvm_mmu_clear_dirty_pt_masked(), as
there is no value in regurgitating the same parameter information, and
capturing the differences between write-protection and PML-based dirty
logging is best done in a common location.

No functional change intended.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

I don't actually care too much about the comment itself, I really just want to
get rid of the annoying warnings (I was *very* tempted to just delete the extra
asterisk), so if anyone has any opinion whatsoever...

 arch/x86/kvm/mmu/mmu.c | 43 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f2c9580d9588..7eb87d473223 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1307,15 +1307,6 @@ static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	return flush;
 }
 
-/**
- * kvm_mmu_write_protect_pt_masked - write protect selected PT level pages
- * @kvm: kvm instance
- * @slot: slot to protect
- * @gfn_offset: start of the BITS_PER_LONG pages we care about
- * @mask: indicates which pages we should protect
- *
- * Used when we do not need to care about huge page mappings.
- */
 static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 				     struct kvm_memory_slot *slot,
 				     gfn_t gfn_offset, unsigned long mask)
@@ -1339,16 +1330,6 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	}
 }
 
-/**
- * kvm_mmu_clear_dirty_pt_masked - clear MMU D-bit for PT level pages, or write
- * protect the page if the D-bit isn't supported.
- * @kvm: kvm instance
- * @slot: slot to clear D-bit
- * @gfn_offset: start of the BITS_PER_LONG pages we care about
- * @mask: indicates which pages we should clear D-bit
- *
- * Used for PML to re-log the dirty GPAs after userspace querying dirty_bitmap.
- */
 static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 gfn_t gfn_offset, unsigned long mask)
@@ -1373,14 +1354,26 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 }
 
 /**
- * kvm_arch_mmu_enable_log_dirty_pt_masked - enable dirty logging for selected
- * PT level pages.
+ * kvm_arch_mmu_enable_log_dirty_pt_masked - (Re)Enable dirty logging for a set
+ * of GFNs
  *
- * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
- * enable dirty logging for them.
+ * @kvm: kvm instance
+ * @slot: slot to containing the gfns to dirty log
+ * @gfn_offset: start of the BITS_PER_LONG pages we care about
+ * @mask: indicates which gfns to dirty log (1 == enable)
  *
- * We need to care about huge page mappings: e.g. during dirty logging we may
- * have such mappings.
+ * (Re)Enable dirty logging for the set of GFNs indicated by the slot,
+ * gfn_offset, and mask, e.g. after userspace has harvested dirty information
+ * and wants to re-log dirty GFNs for the next round of migration.
+ *
+ * If the slot was assumed to be "initially all dirty", write-protect hugepages
+ * to ensure they are split to 4KiB on the first write (KVM dirty logs at 4KiB
+ * granularity).  If eager page splitting is enabled, immediately try to split
+ * hugepages, e.g. so that vCPUs don't get saddled with the cost of the split.
+ *
+ * If Page-Modification Logging (PML) is enabled and the GFN doesn't need to be
+ * write-protected for other reasons, e.g. shadow paging, clear the Dirty Bit.
+ * Otherwise write-protect the GFN, i.e. clear the Writable Bit.
  */
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,

base-commit: f99b052256f16224687e5947772f0942bff73fc1
-- 
2.45.2.505.gda0bf45e8d-goog


