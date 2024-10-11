Return-Path: <linux-kernel+bounces-361955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFB999AF50
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2AC1C267FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254521E572C;
	Fri, 11 Oct 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0S+Ycl5"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DC1E282B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688979; cv=none; b=Atl0wxZ4wq7CzfC919DgbKQyYy0Dz6cz2Er8cq0B4dvc2yuyh+iuLQlrGKW1zO8VrAa5B8AildlfnAQiMrKnf6fDGadJ+XFY/vpBkTqeITkzYc6xDBS8Xfx5Vbo2S3F5XIXH4v3fX/8dFbHjnUnfJpx5RHszfDvXwKVYY19T0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688979; c=relaxed/simple;
	bh=VLWDTCmywSyTYwNHGbNc22jp0cSi/jdVaczUtrYClPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKWQF6ILCx1cGpLRVHjWGaWZ2GcbJasA2C22+oKhB/zz1Yn9esC8ytwwatE8kZ4xWyA7QSXAVFZPjohjkwIDj84WKOa2KfbUHp/wLzq7iz7/u5VNQ7pO/dwwAcf+uRSpp4c5feVKc6K4A5UlRiQ7eUchAXoQd+DiHud0pCcgIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0S+Ycl5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e46373148so852306b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728688977; x=1729293777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJE7PzBze7zAcfbdc8FDy9pk9WnzblcaKcmb3qltDsU=;
        b=Q0S+Ycl5Wc+bh4Wbi02CZRtLWAA3ee/SK0MurH6fMoi0oOs5hxYufUCSMKQTDRhnGg
         LCHvU/0JDoXOgpyY3oQdPzOv9ZbQCHDLtg/+JxrVuekt7Nq0n7ZgCd1w0fDEriEbiwU9
         6l5ocBrRDv+5Xo6GPB8oA02SqcBcC/h/YnSNgV+gf6yrEg/85Det5Y0fORnyXBZe9MOv
         if9pCJQvRF0+iYCHlHRZLbnSbzPwMv5Rq32bJrU+0onb9J0t6fY5448gE1lfH4cx2Zcj
         hpNy05lLFOBIdP9DtVG+6tTfj5IagtoGkJNF3rYaggva/NTNvwzTi4YS8ZeCsLr0fEyT
         x7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688977; x=1729293777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJE7PzBze7zAcfbdc8FDy9pk9WnzblcaKcmb3qltDsU=;
        b=fFWEa6diatBiHHSyP4/ASdsEUv7WVPotPcaKLOJeTQCWoDWx4LLVkrhfbvGnJ0DGgw
         caanSFNv+Dh7mf4WjHjhqhT6A1h5xppdJHRpNXZ68aFeEctEDUdUlpTeWYQWTUuXDx6B
         /cJm8ChiA08g9JBoX5Yb6hvg04GLIzn5GDcgZTRvW14zKR2e9jajZlsV9O9v4wfgsNya
         bOFopaIekUtqFeP4FCMdaVOHjsZd3GEMyq5GQCMvnUW6wDTrGiTjwLgQdjwXwUCd9JHX
         k4DWLyZcxgvIO/1z8I5og+qTmOes1E92QVIxND41DeazngbE0vntbz8bEUUM5GAfX7fa
         Y7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRqHvuoXaYyyVBIXrtjoVqnErcCTDWR6NV5EWhvu78Bwwp78neeCugbPHXqWXPZ/xCidrGiBgjhTQT2R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y+oG93Kl7YGDr591XWhiaFjtVmx/oMwQ2QHe8hwCYA6GOu85
	wWIh2nrqOF+sK6xVUWfjZqOvitDl2gIqTDzyttXPlMMTxFybECSYiZ34QWC2t21QiKLyzWyQFcJ
	dH6unjc3ubwOK8QuLjShp0A==
X-Google-Smtp-Source: AGHT+IF8BpvRbiiW7MMpoPgSGCVrmxKRcOQNff2W1WyN3coN7ji1l7zEFJG8+MRsUOFufoc4FZXZrVo9qdPjRKOSmQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a05:6a00:870b:b0:71e:4ec7:aed8 with
 SMTP id d2e1a72fcca58-71e4ec7afb8mr435b3a.6.1728688977169; Fri, 11 Oct 2024
 16:22:57 -0700 (PDT)
Date: Fri, 11 Oct 2024 23:22:37 +0000
In-Reply-To: <cover.1728684491.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728684491.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <3d1946d01f63104de913c0979b5a596e2add1672.1728684491.git.ackerleytng@google.com>
Subject: [RFC PATCH 2/3] mm: hugetlb: Refactor vma_has_reserves() to should_use_hstate_resv()
From: Ackerley Tng <ackerleytng@google.com>
To: muchun.song@linux.dev, peterx@redhat.com, akpm@linux-foundation.org, 
	rientjes@google.com, fvdl@google.com, jthoughton@google.com, david@redhat.com
Cc: isaku.yamahata@intel.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, tabba@google.com, quic_eberman@quicinc.com, 
	roypat@amazon.co.uk, jgg@nvidia.com, jhubbard@nvidia.com, seanjc@google.com, 
	pbonzini@redhat.com, erdemaktas@google.com, vannapurve@google.com, 
	ackerleytng@google.com, pgonda@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

With the addition of the chg parameter, vma_has_reserves() no longer
just determines whether the vma has reserves.

The comment in the vma->vm_flags & VM_NORESERVE block indicates that
this function actually computes whether or not the reserved count
should be decremented.

This refactoring also takes into account the allocation's request
parameter avoid_reserve, which helps to further simplify the calling
function alloc_hugetlb_folio().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 73165c670739..47c421eba112 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1246,9 +1246,19 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 	hugetlb_dup_vma_private(vma);
 }

-/* Returns true if the VMA has associated reserve pages */
-static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
+/*
+ * Returns true if this allocation should use (debit) hstate reservations, based on
+ *
+ * @vma: VMA config
+ * @chg: Whether the page requirement can be satisfied using subpool reservations
+ * @avoid_reserve: Whether allocation was requested to avoid using reservations
+ */
+static bool should_use_hstate_resv(struct vm_area_struct *vma, long chg,
+				   bool avoid_reserve)
 {
+	if (avoid_reserve)
+		return false;
+
 	if (vma->vm_flags & VM_NORESERVE) {
 		/*
 		 * This address is already reserved by other process(chg == 0),
@@ -3025,7 +3035,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;

-	use_hstate_resv = !avoid_reserve && vma_has_reserves(vma, gbl_chg);
+	use_hstate_resv = should_use_hstate_resv(vma, gbl_chg, avoid_reserve);

 	spin_lock_irq(&hugetlb_lock);
 	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
--
2.47.0.rc1.288.g06298d1525-goog

