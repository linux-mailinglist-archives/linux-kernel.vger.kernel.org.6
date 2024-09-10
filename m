Return-Path: <linux-kernel+bounces-323990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9C974684
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B7B24A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB631AED4F;
	Tue, 10 Sep 2024 23:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eynnDoq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9401AE036
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011878; cv=none; b=Pl8QwCZ/XCAs4O41gAFqG0GRPEyjIrSuzRM9ZoIH4KWCI0b6xkm38Z33gykOQODb2X//mGH9SqczATQrYMdfFpMdfqws24nxnf8zl879dNH1PXQbWBM8qb53IUGKS3NHO4oExdguPg5+IHPgTin1FQ45woGMDyjob2fZMdeOhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011878; c=relaxed/simple;
	bh=io1ZCw2TLt0wqz/lMjXlJWELP6TFBEOB8jTdyPdEz+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R8ynPcuBtsEXZPrVNDKutGdrmQjPSjipXDsh4f2TiLF07gHJznkdyhXG8ABm56VhancMdDJTKOya7eSTJRe4hyUqiup5L+UmNlbSIENKteQCK+cRcXj3GbhINdEVb8CpePbq+suSga2F/5/NWSuDolffTOvZh3wQGINA/gUQYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eynnDoq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20535259f94so76830265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011877; x=1726616677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J90/0IHODiFrv0z5R6WYA4Y44jSC3bFJWxuZTo3OsX8=;
        b=4eynnDoq0BfljQ08PTt2OfiklTKycIXL0Yd8DdwpW0YBbdzaMeDe2+G6c+Uq6M7fuM
         cPoBzn4LiL1EnRLlqZ4pXFy0P2j6Yx/FvM8AvYG1NeBqw9clbgy4V+i3/AgJfQbguMo7
         mhRvNtONmKcXyGRCXAOdGu1a+gLIku2WmbkkRfGMKPQUwL9UoduOU74Ow+cy3ekB9kjp
         Q1803rqmD2i5i+cAjNJ2yU2oxj1yXbdor1rN7HNpq3xHVIMg0UvmjfksDrMadaKInGFB
         /rOsW9WYvWAIJC1R9/7oqoXRGJrA16sqWy33DIFc/3iH6exM3qvOmNpzzkPQcj0teRok
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011877; x=1726616677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J90/0IHODiFrv0z5R6WYA4Y44jSC3bFJWxuZTo3OsX8=;
        b=atZndma7FlZ55OrJb/pJ9AhU2Nqbo62mhALJDK05kM2Zp1BloqVuZVmCLjcgVkvr88
         czzycWqDu6v4R/n+0elLLr4eGrxy+ZR2EPjajTsd+AYzQ0Nb0gLLXXmwIpgbiWYGliAj
         CJR5XsR6reFxEgyq2J2luBVWjkAtM8CgSa980RlDGUJMUONYgNFFL5fjCXEHmhVk+vWx
         xiTjyHGbR6b72VahL2VdemtTJOuJz7SRifkUTTWs1MLrsMizSKGIJeMlGo3/02aAoTPh
         BJSoig3350/YwJsekoZNgAs15IJx0s7T46VP5JcV0QAcuCywUWU6ZMUplILgC3sARHJK
         zbqw==
X-Forwarded-Encrypted: i=1; AJvYcCXnOC9PWxtT3Iv3hAvteQqlCejHUTQvQ9F4QOgnnFlFnIBRu7OKpkrFDtv/t2HrYBY5dclbBiDUb3P4afc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gcgc8OgBp2tDgFmjH3kIuGq9IJBFt8Afa8pfM1s10pilCoAC
	SyzBSfJp7w5SifvPVA/if+ypRZgpTGSzHgxawlVyvCqX+cklGu09pzv7xjyktjLZrZyNMSrIgwz
	la1AlFW1adiF6tTdu0chjMA==
X-Google-Smtp-Source: AGHT+IH+P75b7qdmkP6eoZLmeGyUgGCW8nOF1XpFIdx3c0B8s35iOw3gNUn1NvFFrnEnCdwtnZF761N+oNC8hfEQ5Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:c40f:b0:205:4d27:6164 with
 SMTP id d9443c01a7336-2074c5e71f2mr248205ad.5.1726011876473; Tue, 10 Sep 2024
 16:44:36 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:33 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <416274da1bb0f07db37944578f9e7d96dac3873c.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 02/39] mm: hugetlb: Refactor vma_has_reserves() to should_use_hstate_resv()
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
index af5c6bbc9ff0..597102ed224b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1245,9 +1245,19 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
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
@@ -3182,7 +3192,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	if (ret)
 		goto out_uncharge_cgroup_reservation;
 
-	use_hstate_resv = !avoid_reserve && vma_has_reserves(vma, gbl_chg);
+	use_hstate_resv = should_use_hstate_resv(vma, gbl_chg, avoid_reserve);
 
 	spin_lock_irq(&hugetlb_lock);
 	folio = dequeue_hugetlb_folio_vma(h, vma, addr, use_hstate_resv);
-- 
2.46.0.598.g6f2099f65c-goog


