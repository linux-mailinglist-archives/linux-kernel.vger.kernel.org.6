Return-Path: <linux-kernel+bounces-339790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C70986A91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C7B1F22185
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720C1A4B70;
	Thu, 26 Sep 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJ56MGYn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD2197A9A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314531; cv=none; b=Z3FKmuOyfa5Bo/cwcSrBg544bk0TMzp1gnqnHEMHZiUw1h6Q3005szebQpBb0IUZ6C0bDmTzTMa+vrvnyzSBQn7nEeU9ssf9umU3Q/5puTmlMZpw22UwpQfWtSWQLT7m6djwqPsvLS/2n7IRCDIPxhOgeIn91IYDlfbz1m/TrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314531; c=relaxed/simple;
	bh=sw/0Zxhq6kIY8BLZP2OCu04cT4fuVwkynKL63RK8D/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ap4bTlum/Fec2qrM4gPQnW/dNTLhRhXio2B7QS32MX2nkpNtnL1u6nTfFdcorPbV00Om2xF1Nt5XZFiB3swCC4zquD9a0Cd1skCyv1oIoXQ7SucvaZLjrzhCpGVvtjY/G+aZiaqnoiUiEOvlkZxi93g+xG4FHBR/mICEqr1RLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UJ56MGYn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d54ab222fcso13066177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727314528; x=1727919328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Z3PBXE4Aegel3/riahgcLFAyLXvOzS5uEE7fXt5qw=;
        b=UJ56MGYnqItl4G3t75gQ3/ESpNwGEzgsGmQZs66+3XPTKOOSJVP1N2jGfvKBnKT9ZZ
         ViejWh4kls3lr8AfcVf/PIpODN7eqJc8flIHxeOdRr1XnCPs7u2X4XFaXea/Ipwd+CWX
         vBpI+qeqF/q+tSnrH5b82TnXOCGy280ULCB8Vsj3mRlU1F4ljVYKf8BkTRHC9U9FVx4I
         3YCPfTvvAPUvlXqOSWvt5/A3z5Ij0V+v2pEOQ2NxJFrBrMjKHWpHNLB+rSTxIR1jboc3
         5VgDGAfASlijmnV7AAhOdC14IJ/xOLwt6S9YD9n9/9EIrzITXJeZP6J2/hlUZ4DYnHwu
         i3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314528; x=1727919328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Z3PBXE4Aegel3/riahgcLFAyLXvOzS5uEE7fXt5qw=;
        b=OrBEjfG7aRoO47YY3LAVNzXpB8vvOSGNsSyDyBQSD7y8Y/WDwpIy7z8ECJGMYVaCGM
         NyDT2m/wyMZl+8OxXkdE0PAlBzagxCzAthLVk+Jhe/lEk0l8bS8IpPUDiNgoKtSQTWpF
         TqRq6sUItPISzGZjP2zlCZlWGuJWKQAaG62Nj/Kv+W2W4j9loQ3StraoOjY7Sjislw7m
         ZWQQLw0o+XM1NWBlsii73V0XfnzsrIiCIRxZFapS3CA2AwC/zlCaCWNF0qkLd4V1fqbg
         3U4lUnKFefO0Co76H+oM7wkhB1dZCL2en2Ee7kBCGAHfiDtcVJ9r9mFo1ZsOQjvE9cvx
         bsSg==
X-Forwarded-Encrypted: i=1; AJvYcCXqZJ8UOFkUTuSzbNKA5IHKmsUIdb/Fx3IzfWDoU/OG7oJnURlfD6x98Jt8zj37M9PNWbQkvVf+s+LZJUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyKRh/Hy03gqIoD35eufIOFtZBBlArkHF3QcfMRLK7XjJyrnh
	wEFF1u5kyHJWmuqAvH0U01UGKK70jyTk24xWAxIYaKY7Q5a9VndXTkiz+K9z7G6gkNW8txb2hD4
	H0QJxpjUOjMhRj+SJuA==
X-Google-Smtp-Source: AGHT+IEpNqlcby3XCzPxmMXEa3yAsp88MrqHgIHgIiYwCpactoczoPP9Ca8XqrYS/AN0Db4KS1YJcToucGPf0cLH
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:2892:b0:648:fc8a:cd23 with
 SMTP id 00721157ae682-6e21d6e1f34mr309987b3.2.1727314528595; Wed, 25 Sep 2024
 18:35:28 -0700 (PDT)
Date: Thu, 26 Sep 2024 01:34:59 +0000
In-Reply-To: <20240926013506.860253-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926013506.860253-1-jthoughton@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240926013506.860253-12-jthoughton@google.com>
Subject: [PATCH v7 11/18] mm: Add missing mmu_notifier_clear_young for !MMU_NOTIFIER
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove the now unnecessary ifdef in mm/damon/vaddr.c as well.

Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
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
index 58829baf8b5d..2d5b53253bc2 100644
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
2.46.0.792.g87dc391469-goog


