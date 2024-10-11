Return-Path: <linux-kernel+bounces-360366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DD999A19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEB2B23431
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F71F7073;
	Fri, 11 Oct 2024 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONC6Hy57"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828B1F4FCF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612665; cv=none; b=u6oW6aQSPDxsMI2056asxG0KIQjz5uVj5nDrO4bi79W9mQWhw67y92QpeV8eePVLim5/HK6lCs3yW5zhYAShJdz5YDYkH4mGPXcazvOt7nhlAtgfxqBCCiv3JOaf3BFXyddlBq1FYZ8H8xjkg/Ojc0IwB1uf/EiJGWqTOhqaU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612665; c=relaxed/simple;
	bh=gog1CF3yrC7PbB7iQsGgdqYnwMXPBD/mMhmHGxpuVZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nU1OIm82N0ht2MC0LCRQ73a7epFdPW+/oyrz/M6Q8kIf6m/f2QBiRhgjX8Eln9CVFedBaBxPYBRgHe0BVnHGTjPCTcVn/jkINlqyVhpNZxDQjM1SOuSV3Jb4+X4t8d9HB39FDBQKmxZLB02zz5pN+R4pFMH2+yiQFw6pUBI5J7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONC6Hy57; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so2789354276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612663; x=1729217463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v8x9KibxTSkwYhpZCRmKtWyUdw0jfGm7zyAVE4Sh+6c=;
        b=ONC6Hy57QbsV11qpRLx0KpAX8bqfdWn1XfRhLKP0PqnYUZH7ZkyUGcN3xUn4tTAGOq
         /SR1wFLUBRT7ouJzRBdygu5JrWLhnY6aWLqAYpF6eIWFAoLurUYj0brEH5GrqKQw3pFu
         xVmGOFarBrF1jTkgriM9izIhkTiFDvCbRSbgVQzkh/aV2CIpf3bg/fdgmDwG7BbwDeEd
         mkVK0GhhTH37AfQEzqwKMYqB3dQl0dMqzrFv8pOBNSefMBC9aBR29a06kkeA9tijeZaN
         TL6UmTBi6GMbZunzBKj8sM8ypp+3sqd0yVpfdvB/yw3SULQQXzgTF2XP+G2RF6uPf+Zb
         xYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612663; x=1729217463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8x9KibxTSkwYhpZCRmKtWyUdw0jfGm7zyAVE4Sh+6c=;
        b=YmLM5/RAKwlnJeuJcKbkH1LbDfMMHZgG4DBD4Xcc9d4EBjTFfti6q07EjRwZxJlhdA
         pgWExGl6XVy1dGyJAgPP4ixMDEsgjGAXva5zOjCbbXr+LQiGbjfDSdKUqq6tW7uHhbfH
         FhAv4Wk4bYb3T1dCLsdC/H+vEQKA4xmDyDyVtn0HCSXv8QcGrUfw7xyFv1jkAmS3eWp2
         6yqg1dGIMvrB5mWqHNmRRVtU0GDvb1AWNXBbRGw567rQ5+7h84kPRALargL+zni/vDE7
         Pqn+/c7EfIMNE8FxE7rsEttbEkavD76kU+RKQOTAlH7h6ChmPKtBWe6b1+DQ8cQy//tX
         Rx2g==
X-Forwarded-Encrypted: i=1; AJvYcCUDP4VbGKbbJ5AYtoDknOW26fj82nZ1wbVEAtlxVR9bZBZQ14trS0WctlO120U7gQGg8m2t/lq9yRSdEk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eBbamShLne3oMk+JC5DbMzLlkddNvQPurBxYDspGKYqWetdj
	SQVY+/L5Cacq77Swet7IBBoKPPvwq83tGFyxufuIk3xH667MwmS/Xt7JVnVB0Y4riHYVrVAirgc
	MEw==
X-Google-Smtp-Source: AGHT+IHodHjTZ5CDMtglbtHtbXCkaFSofoERPYUDk+m+jM/azzdFkEPj9rcESeONRYLUbkRsBbP0KylUz8o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:abcf:0:b0:e28:8f00:896a with SMTP id
 3f1490d57ef6-e291a3133e4mr739276.8.1728612663019; Thu, 10 Oct 2024 19:11:03
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:37 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-6-seanjc@google.com>
Subject: [PATCH 05/18] KVM: x86/mmu: Don't flush TLBs when clearing Dirty bit
 in shadow MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't force a TLB flush when an SPTE update in the shadow MMU happens to
clear the Dirty bit, as KVM unconditionally flushes TLBs when enabling
dirty logging, and when clearing dirty logs, KVM flushes based on its
software structures, not the SPTEs.  I.e. the flows that care about
accurate Dirty bit information already ensure there are no stale TLB
entries.

Opportunistically drop is_dirty_spte() as mmu_spte_update() was the sole
caller.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c  | 14 ++++++++------
 arch/x86/kvm/mmu/spte.h |  7 -------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9ccfe7eba9b4..faa524d5a0e8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -521,12 +521,15 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
  * not whether or not SPTEs were modified, i.e. only the write-tracking case
  * needs to flush at the time the SPTEs is modified, before dropping mmu_lock.
  *
- * Remote TLBs also need to be flushed if the Dirty bit is cleared, as false
- * negatives are not acceptable, e.g. if KVM is using D-bit based PML on VMX.
- *
  * Don't flush if the Accessed bit is cleared, as access tracking tolerates
  * false negatives, and the one path that does care about TLB flushes,
- * kvm_mmu_notifier_clear_flush_young(), uses mmu_spte_update_no_track().
+ * kvm_mmu_notifier_clear_flush_young(), flushes if a young SPTE is found, i.e.
+ * doesn't rely on lower helpers to detect the need to flush.
+ *
+ * Lastly, don't flush if the Dirty bit is cleared, as KVM unconditionally
+ * flushes when enabling dirty logging (see kvm_mmu_slot_apply_flags()), and
+ * when clearing dirty logs, KVM flushes based on whether or not dirty entries
+ * were reaped from the bitmap/ring, not whether or not dirty SPTEs were found.
  *
  * Returns true if the TLB needs to be flushed
  */
@@ -537,8 +540,7 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 	if (!is_shadow_present_pte(old_spte))
 		return false;
 
-	return (is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte)) ||
-	       (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte));
+	return is_mmu_writable_spte(old_spte) && !is_mmu_writable_spte(new_spte);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index c81cac9358e0..574ca9a1fcab 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -363,13 +363,6 @@ static inline bool is_accessed_spte(u64 spte)
 			     : !is_access_track_spte(spte);
 }
 
-static inline bool is_dirty_spte(u64 spte)
-{
-	u64 dirty_mask = spte_shadow_dirty_mask(spte);
-
-	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
-}
-
 static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
 				int level)
 {
-- 
2.47.0.rc1.288.g06298d1525-goog


