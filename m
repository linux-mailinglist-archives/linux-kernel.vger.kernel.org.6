Return-Path: <linux-kernel+bounces-390983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778849B80D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D406FB2241A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663E1C1AD0;
	Thu, 31 Oct 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E7+Phsm4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDC1BC9ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394401; cv=none; b=omiPfM+v/vP8/Ep7fDDJ7Yf9xGf+grQJner9O/t3VaCSl4ZnivNCUTREIciqizekol4n4ra11RTIKx0R40H/rRdRavcA+W+0ROi8aWzinjQW60nWICqG6B8HGjIY5uO7dSz2JfZ2Hu9zQZtLYkpJFCw7EnNV6fM+ys4mh+eS7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394401; c=relaxed/simple;
	bh=TmFubaHpoCAggLPaGKoJJzqPvhVGJlp46tYw+F5ne78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KxTMqXb8vaKbigfuYOROaUPdQJbxt3qOmm0bktFeGVPaVctWvSUfVowcEWgWqlmt7WzkexjJvGcUJc43sod0i2EM2EI4mFx8UVOr1LSzTE+BV8Y+TuR+UJqiiGZeVZgrddK1Abj9rehW1ZtJ50Axyncpdj81cS4zrDq2wgYhij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E7+Phsm4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so22743487b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730394399; x=1730999199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aPh8/kX/bvDxkNAaOErpld4gvqOrWlO93evgZwqYlRo=;
        b=E7+Phsm4OeSWrbJ5rJ7BojMhbGT0fpZIZbNIwuiF80O04Nnmuc47fCS0tRl+ZWLgEv
         dGe9nB5mnoIFTCprLKbr8SIfugcuwSxyl1fR4bo6MJsRf1jn9DVSAI0TMU/I6cq11EmR
         iaoPwlSMWwAcTQ7KjbZWhxsmOBTp0tBBFMKPfh0EPlFEfZGg8XFpbe7kJPIt7az6qh+7
         9Qy2O4X++TL4FK+XlTGr3+Iu9Mq6RQ6ZWig+rM4rwJeocY3KW3HasbmXveHmjUVy3GQs
         GvbkWfM3ZkDK/CJVt/3zD/bUD9HJDQtP/qYNwDP+9NO3Pv75sCZ5EJCFU4DiYBtbFTye
         EcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730394399; x=1730999199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPh8/kX/bvDxkNAaOErpld4gvqOrWlO93evgZwqYlRo=;
        b=eCxXKrH6jjyvEO/3Rb/F6XbNhQE4/UUb19LjBH+lhtIllMqPWJa1KZ/VLy2NZ19wlM
         PcrwkixSdmZRE9q6fMMif2M5ZTSbm47V1bEL4m7w3Z6LnzIT5YZAhkwrMyJdvm6oZre9
         jdnXhKguPS4+GSr8ga5iCoOpGUGaUmZP91xiKPB2jyuWREftxHIeQuiTo36Vzy+s2qeC
         slL4LkbN2YIQWq4/SaUaUsXrpUhqMWubxvPtVSS4i7R/lIB1Pcd1zyFNNcrdOz0uJz+o
         aQ4bsE4o331Yqh+FQdjQh47/Qkbx/lwSAxXxpVpPpJW4HUa9BJkfuAwt8JDI2AIkGh1b
         EmDg==
X-Forwarded-Encrypted: i=1; AJvYcCXzGa5tPTEzdvxC7tdg+qSi3CcSuJTWpO5CFcKUkkbCe3xm7JQ+kQKScsWiJTuPjdtX7aN1mWIPNDTG8CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeS1awYeeLCkODQN+ylNzd00sE0new3Af/V/vJb+x6Lawkvze
	D3mQIwBpZzZBPoSB2qiDGvuYpgAICsv+LygfU1TiSBx59ce4jfsOTJk+IgCXQQwMIrfYmUUPGxR
	2Yw==
X-Google-Smtp-Source: AGHT+IGiTrpfLC5rBMx47TY3FTKwPiTPo+GH6RHeAuK/D3+uMT5K0Tm4GGSSfwK2VRsPn0K+jhIU4mRjfi4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6811:b0:6e3:14c3:379a with SMTP id
 00721157ae682-6ea6479f2f6mr87277b3.0.1730394398970; Thu, 31 Oct 2024 10:06:38
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 31 Oct 2024 10:06:32 -0700
In-Reply-To: <20241031170633.1502783-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031170633.1502783-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031170633.1502783-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86/mmu: Check yielded_gfn for forward progress iff
 resched is needed
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Swap the order of the checks in tdp_mmu_iter_cond_resched() so that KVM
checks to see if a resched is needed _before_ checking to see if yielding
must be disallowed to guarantee forward progress.  Iterating over TDP MMU
SPTEs is a hot path, e.g. tearing down a root can touch millions of SPTEs,
and not needing to reschedule is by far the common case.  On the other
hand, disallowing yielding because forward progress has not been made is a
very rare case.

Returning early for the common case (no resched), effectively reduces the
number of checks from 2 to 1 for the common case, and should make the code
slightly more predictable for the CPU.

To resolve a weird conundrum where the forward progress check currently
returns false, but the need resched check subtly returns iter->yielded,
which _should_ be false (enforced by a WARN), return false unconditionally
(which might also help make the sequence more predictable).  If KVM has a
bug where iter->yielded is left danging, continuing to yield is neither
right nor wrong, it was simply an artifact of how the original code was
written.

Unconditionally returning false when yielding is unnecessary or unwanted
will also allow extracting the "should resched" logic to a separate helper
in a future patch.

Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 91caa73a905b..a06f3d5cb651 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -700,29 +700,29 @@ static inline bool __must_check tdp_mmu_iter_cond_resched(struct kvm *kvm,
 {
 	WARN_ON_ONCE(iter->yielded);
 
+	if (!need_resched() && !rwlock_needbreak(&kvm->mmu_lock))
+		return false;
+
 	/* Ensure forward progress has been made before yielding. */
 	if (iter->next_last_level_gfn == iter->yielded_gfn)
 		return false;
 
-	if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
-		if (flush)
-			kvm_flush_remote_tlbs(kvm);
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
 
-		rcu_read_unlock();
+	rcu_read_unlock();
 
-		if (shared)
-			cond_resched_rwlock_read(&kvm->mmu_lock);
-		else
-			cond_resched_rwlock_write(&kvm->mmu_lock);
+	if (shared)
+		cond_resched_rwlock_read(&kvm->mmu_lock);
+	else
+		cond_resched_rwlock_write(&kvm->mmu_lock);
 
-		rcu_read_lock();
+	rcu_read_lock();
 
-		WARN_ON_ONCE(iter->gfn > iter->next_last_level_gfn);
+	WARN_ON_ONCE(iter->gfn > iter->next_last_level_gfn);
 
-		iter->yielded = true;
-	}
-
-	return iter->yielded;
+	iter->yielded = true;
+	return true;
 }
 
 static inline gfn_t tdp_mmu_max_gfn_exclusive(void)
-- 
2.47.0.163.g1226f6d8fa-goog


