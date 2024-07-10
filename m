Return-Path: <linux-kernel+bounces-248425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C091C92DD08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C30286805
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3416D9A0;
	Wed, 10 Jul 2024 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDXVRsCx"
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FEC16C862
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654976; cv=none; b=L99c3/H+E2yf/ep0MuW2jT8tKcZ0uhJDYe64DlSEzIkKPlPgf/hiUkFWERUYEKfCLILsFkbaGBMMmK14ls0M9rF4fTgdVmhso+o7BQraEnNbs2WdvPdqaCk7rKAVu3t5mGMoswFlV/RYJ9+yPskDuEwAg/j+rMCi7oNV8ltxnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654976; c=relaxed/simple;
	bh=9nGVvjTtRrzXeDKQT/PGApCposmumXI12BdKtg64Aj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sr0MBajdDkIvG7PwjziK7ZMJZz5b7PbNJe8Uib896oF+5WF32ycObu9mTUFboxSxXOHgzuAM4eFggLn9/lxg68HkkKG4NzSEEsRD4Br35hmCqp40DUD+aXC9mWDSUIiOYVb444Gs3novJ5BBfb6FKoTVeIUaIFHl2dJgv+QuGSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDXVRsCx; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-8101ef99bf6so89288241.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654973; x=1721259773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=86wUnUhZHhvP2m3KtD2mzNoNsfKZM3y2BVe++0uTyFA=;
        b=gDXVRsCx4zAb+aXQVU500pfuxdZC1fBEA1iLF/nd/5kaJzmrZvl9SDY2pHegNlDieX
         hd8gLixD2Jl+++LLsALferKZDuhbA1PzIJmVwFM8Wxmp/scWJlgpfU4AOkD3t3ObKRst
         OenkqnPb3tJdCOiWX2bVSr6jwWzDTB9i8nH3LgleIWgOGXl/Rttrre+zbPV0eS4/jV7t
         GxzpanKaknmyn08V6EwDg4rLCLeQnOEpfQJwuOgWAkBzMg1JhsnWXn8AFPs44QJP8Z5X
         4VhbUFc2EcLF1yjqiDWBwv3TuwVIiYFgdsjHaSSKoewzwiQlIBfCLxwee5mFwULOgDOb
         40LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654973; x=1721259773;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86wUnUhZHhvP2m3KtD2mzNoNsfKZM3y2BVe++0uTyFA=;
        b=vKYMC8MOodW50jELNSdqCFphvPyG38jsPXDO9klGzwKEe8FnKiAf1QxIXsvu4MI5l9
         1/aCm0cL9CND70kFJImh7lsVdJM/bSD7/SdU1kZNhNEg/FOPp72D5NXN7us0jnVXVNUR
         CVcMJOVyrQMmL/r1hyHtzbkvFleizGl61p2Q8zxWwJaETrpW3K5EaS+LcgjyfkBPtuxp
         MJtBZOQHOKwqDohN4wnDYWVEuri5WE9hn/zO0YWmC6zEwgtrDz7eaWBaW6ucW8Sf0IdY
         B3QesvmfmqZb8qSn2jcb8CdzV9S5zz22IBbeVxix1CPXewLD33y2nGCTbJVRT1lD1Wwz
         Q8nw==
X-Forwarded-Encrypted: i=1; AJvYcCVgw8ijsT7PS4tKyHShGEvRSZFLDXmtEGZCGtbsXQLHaWyKplcLyms8zhxeZhkEaBr9CB9UiVGeOBtd9BG0+y+YnRsJC/74NFzl6WRt
X-Gm-Message-State: AOJu0YwMX3038dKo3rbtR2FLNuhKo5GDmUgnMw4YOoei0oAIv5yITxuo
	Nzl+38n6+7SFziOZfB4lu4OLj3xKBiAvaQ+xR7Z3H1XT18ZQsie/j5havwWEWQOeTaA3Z6qfwzx
	a1YHT39qU2WltmQzYlg==
X-Google-Smtp-Source: AGHT+IFuuD8TX5cMTXqfbBITU1Rk5gbgp8/gjNqtfzjUDzjMtEhdHehLKT0HBMd1mO2mStlwTdwfc0NYjYZ51/Zs
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6130:2c07:b0:80f:e89a:dc21 with
 SMTP id a1e0cc1a2514c-81076f04ee0mr30519241.2.1720654972976; Wed, 10 Jul 2024
 16:42:52 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:19 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-16-jthoughton@google.com>
Subject: [RFC PATCH 15/18] KVM: guest_memfd: Add KVM Userfault support
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

We now have to pass our struct kvm into __kvm_gmem_get_pfn to know if a
gfn is userfault-enabled or not.

For faults on userfault-enabled gfns, indicate this to the caller by
setting *pfn to KVM_PFN_ERR_USERFAULT. Architectures may use this to
know to return a userfault to userspace, though they should be careful
to set a value for *pfn before calling (e.g. KVM_PFN_ERR_FAULT).

While we're at it, set *pfn to KVM_PFN_ERR_HWPOISON for accesses to
poisoned gfns.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 virt/kvm/guest_memfd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9148b9679bb1..ba7a981e3396 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -542,8 +542,9 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	fput(file);
 }
 
-static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
-		       gfn_t gfn, kvm_pfn_t *pfn, int *max_order, bool prepare)
+static int __kvm_gmem_get_pfn(struct kvm *kvm, struct file *file,
+		       struct kvm_memory_slot *slot, gfn_t gfn, kvm_pfn_t *pfn,
+		       int *max_order, bool prepare)
 {
 	pgoff_t index = gfn - slot->base_gfn + slot->gmem.pgoff;
 	struct kvm_gmem *gmem = file->private_data;
@@ -551,6 +552,11 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 	struct page *page;
 	int r;
 
+	if (gfn_has_userfault(kvm, gfn)) {
+		*pfn = KVM_PFN_ERR_USERFAULT;
+		return -EFAULT;
+	}
+
 	if (file != slot->gmem.file) {
 		WARN_ON_ONCE(slot->gmem.file);
 		return -EFAULT;
@@ -567,6 +573,7 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 		return PTR_ERR(folio);
 
 	if (folio_test_hwpoison(folio)) {
+		*pfn = KVM_PFN_ERR_HWPOISON;
 		folio_unlock(folio);
 		folio_put(folio);
 		return -EHWPOISON;
@@ -594,7 +601,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
-	r = __kvm_gmem_get_pfn(file, slot, gfn, pfn, max_order, true);
+	r = __kvm_gmem_get_pfn(kvm, file, slot, gfn, pfn, max_order, true);
 	fput(file);
 	return r;
 }
@@ -634,7 +641,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			break;
 		}
 
-		ret = __kvm_gmem_get_pfn(file, slot, gfn, &pfn, &max_order, false);
+		ret = __kvm_gmem_get_pfn(kvm, file, slot, gfn, &pfn,
+					 &max_order, false);
 		if (ret)
 			break;
 
-- 
2.45.2.993.g49e7a77208-goog


