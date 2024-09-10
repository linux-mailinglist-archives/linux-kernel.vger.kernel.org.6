Return-Path: <linux-kernel+bounces-323995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB5974691
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6781C20DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0D1B3B0D;
	Tue, 10 Sep 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1MOvzuO4"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E21B2ECE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011884; cv=none; b=SynQVfnPlXOQ4/geGh9bC9uoUxUPBM4bQEH7t/3+Wzi5xFAiZ5GJNlWUclxf9D4WmZvCk1xhuXmvFNP+cUv0yuwJf04UJ3SXQiabIDkYzNoz3mt4ze4n5mNwjuvFCP/yBxTSpG0RhCanzWu3PKCqSe5diOGDj3pGNK7Bh5/QxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011884; c=relaxed/simple;
	bh=OQBUOF2Uq6jS4pRXGCaJ5/4GiCZ/0iOxc0vUCCmO+bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W640F9xUgZkz2v6vQ0IjhkCQm5UP2Vx5HeE/JWOj0dl15BRAWv4J0BxPx0OrH4AZ4dxhyaL9faMSe1XP0BiE+ZH2L6w6o/mXX6jbxNVa8CFa8vGPR5MLxls9DKn1FTlA6qCZrVKxeTkWDb4udIyYzseqQ3zUKXdDA3aD2TE6brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1MOvzuO4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7178f096d62so6934803b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011881; x=1726616681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P0FEJ4ZKBglbUpSmnWaSSUOycb+KTZhx2f+dpCTvB7Q=;
        b=1MOvzuO4D+tO/RpFPmleZfo8l7WxdQPP79UsyAYOG9+WcsIbXzUeMAW/aA/2awVfRf
         9gaxSeDuykpNIYxUAdK4B0YDDWD+qQZ8I7nZnW8MA3IzGlStt4QpCQQyDrBs/VQ78XUg
         DyIrYJOI9OXI2kyCpRYeXlARiDg7xeeznTLrcDgv8cz4U6V6H/AxmhdSAvaaNuOTrvt8
         +cLAKSTWnBESsoOdA0BzqKEBihhj5HqSCuNbdVLpyIhJRXUjC4AkZkJ8DpyIMKx8YqTQ
         2ZlayVvVesxKAbmL9bjVFG/sfpSdsH/WjeCgTTPBAUrSDKeR3MPqJJFPX/rgDtcs0+AQ
         BM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011881; x=1726616681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0FEJ4ZKBglbUpSmnWaSSUOycb+KTZhx2f+dpCTvB7Q=;
        b=B87YH9dbflnoL1/tWFIClOvDrbxiohHpuBgEvRSgCOqeByrx8uz0piG8rxPB1hZEJ5
         aD0OAXxNmttsO7zz5+NTID/Hfl2fDDm9sOah4l7HXTEgwtp2VsFQwcN0qP2AOtZyeqEO
         zhJyrtfJCzVBSwZTHqW6MytqL7uthfNlVBAuTqyAfh4oeOU5dHwtOnJtqCsdJmzD9aKa
         K9T7uYJUBbxB+lB/q6F2OH4DXo7BCEAe6rtz/D1Lk2G89vxAPAfT5dyPD17DLdsqoyWw
         HjQ6a4wX2jAxdMZhEF+OtoUP2o63qZHYtAKkHIvq9R/C8i72rZAx8rCWfBYkI0CSgtga
         PfVA==
X-Forwarded-Encrypted: i=1; AJvYcCXQlcvCJnpDQe99LC+2RjP7D/L6nOPt5Gwnw6dQyyQNWkiEQPH8EZ8y/bPHuCDwtxc6ndluSqEDP3ZgrJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7s9ruSK4u5zFlmf4lwy0mfc5wQwbhdMQQ+rRSAbVOe0X2UCPK
	ffH+iQEd02bzhyEj0pcU9d9xO4EL5d9r32u9Sf/x7rFlk/GBchp7dxfeX0aD9pX8BFenCkJ6loZ
	Ig+Al0OlBsTvMDnsBJT+9hQ==
X-Google-Smtp-Source: AGHT+IHx4+TfNxnFVDcFxBFG2SogMutruOf/RcFp6adNqekz63WzrINlsJVnsUCpFS0h+PHdTGU8HSxvhRc6JvhHRw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a62:ab02:0:b0:710:9d5e:4b9a with SMTP
 id d2e1a72fcca58-718d5e04dadmr37747b3a.2.1726011881266; Tue, 10 Sep 2024
 16:44:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:36 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <1778a7324a1242fa907981576ebd69716a94d778.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 05/39] mm: hugetlb: Refactor alloc_buddy_hugetlb_folio_with_mpol()
 to interpret mempolicy instead of vma
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Reducing dependence on vma avoids the hugetlb-specific assumption of
where the mempolicy is stored. This will open up other ways of using
hugetlb.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5cf7fb117e9d..2f2bd2444ae2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2536,32 +2536,31 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 }
 
 /*
- * Use the VMA's mpolicy to allocate a huge page from the buddy.
+ * Allocate a huge page from the buddy allocator, given memory policy, node id
+ * and nodemask.
  */
-static
-struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
-		struct vm_area_struct *vma, unsigned long addr)
+static struct folio *alloc_buddy_hugetlb_folio_from_node(struct hstate *h,
+							 struct mempolicy *mpol,
+							 int nid,
+							 nodemask_t *nodemask)
 {
-	struct folio *folio = NULL;
-	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
-	int nid;
-	nodemask_t *nodemask;
+	struct folio *folio = NULL;
 
-	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
 
 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
+	}
 
-		/* Fallback to all nodes if page==NULL */
+	if (!folio) {
+		/* Fallback to all nodes if earlier allocation failed */
 		nodemask = NULL;
-	}
 
-	if (!folio)
 		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
-	mpol_cond_put(mpol);
+	}
+
 	return folio;
 }
 
@@ -3187,8 +3186,18 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	spin_lock_irq(&hugetlb_lock);
 	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
 	if (!folio) {
+		struct mempolicy *mpol;
+		nodemask_t *nodemask;
+		pgoff_t ilx;
+		int nid;
+
 		spin_unlock_irq(&hugetlb_lock);
-		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
+
+		mpol = get_vma_policy(vma, addr, hstate_vma(vma)->order, &ilx);
+		nid = policy_node_nodemask(mpol, htlb_alloc_mask(h), ilx, &nodemask);
+		folio = alloc_buddy_hugetlb_folio_from_node(h, mpol, nid, nodemask);
+		mpol_cond_put(mpol);
+
 		if (!folio)
 			goto out_uncharge_cgroup;
 		spin_lock_irq(&hugetlb_lock);
-- 
2.46.0.598.g6f2099f65c-goog


