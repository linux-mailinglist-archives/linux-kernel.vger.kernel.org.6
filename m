Return-Path: <linux-kernel+bounces-260510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4E493AA62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CA7284814
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273EBE4F;
	Wed, 24 Jul 2024 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZOrMIfP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CBEAE9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783479; cv=none; b=f8Lom1VapELEfIntYP47XcVTPv9cAux9+9ei39LuBVPZdJBv30t+Dvubh9aQ+VuO3Kn9CqLtJqvCcpxpXgiQ/o/0a4a9TU4hTZcnkW22lfDJCugSePgPhwm0q/fyOVJh4GKAlxrm5Rm0u7OB5m1eyO05EdpOdiKk8QGnEZ9yA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783479; c=relaxed/simple;
	bh=9epNWMu0nT72OSlYY2Zz+fVtDIgBskl4k6najJMpllA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0P3RB53GWfrrgDZc1pR/1xePjRU9ocjj684LYh2YM6WDE/mb96G3sxw9mEqpVAff8jR1TIGTWaUa3eTjWheBjCvW6JsxI2yNDaDaFclopGWkawaQSuhG5HHDvgja2fLzhil0esY7oH89w/GyeIl6rKC18UIzg4wacMFuMg0Vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZOrMIfP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0875f9f7ceso801584276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721783477; x=1722388277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yD4XBA3wulmfL9cZplrhNjvZpnpcy308OK8qykR4vJ4=;
        b=GZOrMIfPSbiCq9npdDFMEPkF0DN1qLf+s0/e9a/gRuFNMAtVf7ur4Qm7Q8+vZBgLra
         zm5NBq0ooont2k1Y6Jkeha1EtTu3GoP0T0vcD4Yyg8jzI/WaTd/ZWscJtxs368hDVRi7
         Gw1w3utDjaQeNg7b12/sGSr3EoHSdGtbPE3XsR7xr3MfGJQIL01QDtNx7kUlSeySNEi/
         NRQk4QXBBMVcc0lkdngH7iu7AHGS9MgmgQAuxOxPJncSSQByVsvjPl8mEQlI4uzv1CPa
         ukBAwpgGV5GUORzgvobCe6CpAMN0cJHd/O2uAgATMZ/DK1kNLLiRg6JqVEnBOjYzNF1n
         6a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721783477; x=1722388277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD4XBA3wulmfL9cZplrhNjvZpnpcy308OK8qykR4vJ4=;
        b=N9oV0FXdFHUbamDTlzW+7Ncb0co65xeiEbCmeUBteP7TrkqW73qZ3BN8eY77R2+VHe
         n4DTJDiwk/aMIz/p7dkmFcXYIcmizIrvAxa4NNJlaFN2D87U5ouF2RQashvx+st0LQxE
         DXqsM49aUyM0lahBqUnVJRdOVLt+7TQ9vZdWiqfN6DJeKLrqL4gXFa8FTIo3viC3/D9z
         HR8k+VCYaQAUOOHGMgnrTFdnch4kI9vpV6IyJaUelIgyy3YquWAKG4T8Cgdpf/MCfltk
         1qV5T1JdOneUX9cP9G8xPfHY+VUFl5SZNgKBaU0Hnw3gUeeSRDN/q1vRfFq+nybJnnOs
         6/Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWQyOObduiTxrLO3RhuyXXXGCOnEa0weCBY/RDiCdrSO3GD50iZf+i6SeKvwajvnxn2QtFSfqyajgptDulUynklqPz06fVwsIlBAopk
X-Gm-Message-State: AOJu0YziOXO89zXGxhHjXJsuE0KL8ZmvRywSVaaZma1TXoTY3YsFebH5
	OF9Y7fJwr1A1ZA6gonEtmlK8KI8uzPm5iwqGZGKuYvA0mlvUyof+BPXSwi1YZf+p4y38sJv53Nr
	aid/U1OdX0aIwNlHYDA==
X-Google-Smtp-Source: AGHT+IGa8qCTH1LNH/hmEAmVML0lM3qLC3vgS4lo0iysyChD5iecelBKp5Dde0rCv2FIne41yj4Q4w4VDl3wLvaY
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:72b:b0:e05:a1df:5644 with SMTP
 id 3f1490d57ef6-e0b115446e0mr18142276.2.1721783476871; Tue, 23 Jul 2024
 18:11:16 -0700 (PDT)
Date: Wed, 24 Jul 2024 01:10:29 +0000
In-Reply-To: <20240724011037.3671523-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724011037.3671523-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240724011037.3671523-5-jthoughton@google.com>
Subject: [PATCH v6 04/11] mm: Add missing mmu_notifier_clear_young for !MMU_NOTIFIER
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	James Morse <james.morse@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Wei Xu <weixugc@google.com>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/mmu_notifier.h | 7 +++++++
 mm/damon/vaddr.c             | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d39ebb10caeb..e2dd57ca368b 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -606,6 +606,13 @@ static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mmu_notifier_clear_young(struct mm_struct *mm,
+					   unsigned long start,
+					   unsigned long end)
+{
+	return 0;
+}
+
 static inline int mmu_notifier_test_young(struct mm_struct *mm,
 					  unsigned long address)
 {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 381559e4a1fa..a453d77565e6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -351,11 +351,9 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 		set_huge_pte_at(mm, addr, pte, entry, psize);
 	}
 
-#ifdef CONFIG_MMU_NOTIFIER
 	if (mmu_notifier_clear_young(mm, addr,
 				     addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
 		folio_set_young(folio);
-- 
2.46.0.rc1.232.g9752f9e123-goog


