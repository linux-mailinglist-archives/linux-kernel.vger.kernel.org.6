Return-Path: <linux-kernel+bounces-273073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A367194644C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6063C2823C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0DF53E23;
	Fri,  2 Aug 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIQdZ5Dg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1521233DF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630015; cv=none; b=Z1Ff1CeZ4S0YdBHbiyl6aiMY5MOEBpCQ8e4hRzNZHgfyQpMle1o3ygyGvEc0x8cbIrsR7yFDEPMGqqusNBuDoXJocUxYZQz896tlQPeCacr+Y3SYz9ud71dVkwHgb3Uah+91Q9Z7TsCuSYxevcqOiAZj8MsBWJXjgsWWiunaAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630015; c=relaxed/simple;
	bh=f5wk1BYE1qFGiIzXiTtgFC/3NOx8IBR69a3l+kDiJQE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gaxMK/Mh/Q3YA5WGXeS7pN9Zv4V+FJVW6Lf1mYLYk3SM0LwuEUFlAxI24Yk80pIuo0MHFykhHiBKg3JH2vqK6oAjN9VTASxQaxLihH9VF/A92T74KQG6Kji2l6KyLwflAKuQL7hMBv+cRzO9mH/unnb0QERnOE2rNw5bwgdZgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hIQdZ5Dg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664bc570740so59468957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722630013; x=1723234813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiQAcpRKpe7+E/+WMw3cwWwkg0i5rhbg/4mNpxGloLQ=;
        b=hIQdZ5DgTwFsEo+zmzuY7gNo/0mxExLnCmbm33stD+zokSM9Fk2ZD3+hrfS2CR/74m
         Kv6fdr6TkvGGQGqtZJbwZPh05k91je1QQF/xfijYF9h5QbpOlp3bPOw/ledwGjL9vVYe
         Xjrh+VuU1ueOEU1qHvTmuN0X++7karrxqZTqOFjMy4dCh56fJxJ1GAQ0FEwziOl9jQOu
         izEBJRDKtmdVnGLW3nfyykZEYa2uv7x+RlY4G7kmpXGQ1MisGNq5b3f/iZdonUyJ1fla
         o7wrURA5ZTY8b8vZo9lZtTrtNnhS9tN4CkFF3yzvf+j9GYIckI9EkF/v7JBXTN4UdXiM
         loyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630013; x=1723234813;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiQAcpRKpe7+E/+WMw3cwWwkg0i5rhbg/4mNpxGloLQ=;
        b=RNgcTU8RHVMvgCJ49KkpVVdOdj2exZaHM0wypnPHekrRVoflu37++6Hzi5FXjA/dmI
         lPKHPPS0fv/0tfmCb6Wu8aWSNKk6Pr6Q2AOp0tdfpH42LJAYs/QFBQOPAxyznNOdMAWc
         WglXiYqPCu5scyM4toKJy+XjnSKKWSsxvtoXaErfHtB4X94XrzU/RnPku/WUxIAljGxh
         IXe/12Ys6/J9JzZcpVHRs5rTQrvBPDUNRW7cpgK/Nd+/IO45TJooAwWRk7c6sD96BI4j
         Dzs6UbL0WonbLsYNyTDuYuIzMpIbHk7w/Bz6yLUpsibrWyFa8cSjCQOkd7+7AifqTcCW
         6Z5w==
X-Forwarded-Encrypted: i=1; AJvYcCVALoERo7fZ4vaDyeB9JNh93qSyXjXc0PwCKCGP9udeEBkEZiiLWNfuOJzejpM4n/joxD5Zuwi6eBsoQclbZM1wyNbhaAMLY3YqVx9O
X-Gm-Message-State: AOJu0YwJrdCFpfcg7Hz94TYLxxDxo6maPfEmvPIqyDNZjZ7qKN8RpZu/
	+L+4Sp0Z8oD9Y3xs2CkZgQt9ujLmnciEhpaOAQgXHpaDOEgAI9fUgAEj6pcG1vNKKLO/+yPMrnL
	I/w==
X-Google-Smtp-Source: AGHT+IH1+DZ9dslVBjL+N5f3Pd9iBLWduh+TbgNV+/sWoiV+TYiGZGIaviiJqBarqG931ibfyvNy8OtMYe4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:d82:b0:65b:a403:5ec1 with SMTP id
 00721157ae682-68964d4e782mr1368287b3.4.1722630013194; Fri, 02 Aug 2024
 13:20:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:20:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802202006.340854-1-seanjc@google.com>
Subject: [PATCH v2] KVM: x86/mmu: Clean up function comments for dirty logging APIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework the function comment for kvm_arch_mmu_enable_log_dirty_pt_masked()
into the body of the function, as it has gotten a bit stale, is harder to
read without the code context, and is the last source of warnings for W=1
builds in KVM x86 due to using a kernel-doc comment without documenting
all parameters.

Opportunistically subsume the functions comments for
kvm_mmu_write_protect_pt_masked() and kvm_mmu_clear_dirty_pt_masked(), as
there is no value in regurgitating similar information at a higher level,
and capturing the differences between write-protection and PML-based dirty
logging is best done in a common location.

No functional change intended.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Put the comments in the function body. [David]

v1: https://lore.kernel.org/all/20240611215805.340664-1-seanjc@google.com

 arch/x86/kvm/mmu/mmu.c | 48 +++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 901be9e420a4..45e7e9bd5e76 100644
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
@@ -1372,24 +1353,16 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	}
 }
 
-/**
- * kvm_arch_mmu_enable_log_dirty_pt_masked - enable dirty logging for selected
- * PT level pages.
- *
- * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
- * enable dirty logging for them.
- *
- * We need to care about huge page mappings: e.g. during dirty logging we may
- * have such mappings.
- */
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
 	/*
-	 * Huge pages are NOT write protected when we start dirty logging in
-	 * initially-all-set mode; must write protect them here so that they
-	 * are split to 4K on the first write.
+	 * If the slot was assumed to be "initially all dirty", write-protect
+	 * huge pages to ensure they are split to 4KiB on the first write (KVM
+	 * dirty logs at 4KiB granularity). If eager page splitting is enabled,
+	 * immediately try to split huge pages, e.g. so that vCPUs don't get
+	 * saddled with the cost of splitting.
 	 *
 	 * The gfn_offset is guaranteed to be aligned to 64, but the base_gfn
 	 * of memslot has no such restriction, so the range can cross two large
@@ -1411,7 +1384,16 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 						       PG_LEVEL_2M);
 	}
 
-	/* Now handle 4K PTEs.  */
+	/*
+	 * (Re)Enable dirty logging for all 4KiB SPTEs that map the GFNs in
+	 * mask.  If PML is enabled and the and the GFN doesn't need to be
+	 * write-protected for other reasons, e.g. shadow paging, clear the
+	 * Dirty bit.  Otherwise clear the Writable bit.
+	 *
+	 * Note that kvm_mmu_clear_dirty_pt_masked() is called whenever PML is
+	 * enabled but it chooses between clearing the Dirty bit and Writeable
+	 * bit based on the context.
+	 */
 	if (kvm_x86_ops.cpu_dirty_log_size)
 		kvm_mmu_clear_dirty_pt_masked(kvm, slot, gfn_offset, mask);
 	else

base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog


