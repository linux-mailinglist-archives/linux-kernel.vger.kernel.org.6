Return-Path: <linux-kernel+bounces-536413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6BA47F36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586B73AC1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042B22FDF7;
	Thu, 27 Feb 2025 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZ5Cer2V"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83322DFB3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663162; cv=none; b=VAlupGbUmSO9VaWfpsTWc1nHqGgZzxCceWDyo8/PUISrJEaUAOqSS7BSJd1xTPvQqXPaMcxwashVgBmmeVZTsFHLJ4Q2jl/ha6iAx4pZ0WBopFNX91Pg9HeLoojMakSXISO5ut1DsVxcDSCwGxHkXszdjzUtnBqVwuLIWlVNC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663162; c=relaxed/simple;
	bh=ZkqjquJmqyKCF3YVGXF3s6NPgWRXSZRfFKpweGnRmXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxR9sikqk8yyHdK0G8o2J+tvGZx3RfRKnSK58wUsWRikVhXMvldypyU9Qu2zSWzN92Xf2gXv/YydmDzBRj8TnK/oQOb1GVySGpnYGO9tssmYLN1Nus3dQ9bDpd3kwPDf5Yaj4Fso5BbJ8dx2h+ZVwQIiH5/0qXRTsfAXO/Gz89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZ5Cer2V; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47217c14be9so31388381cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740663158; x=1741267958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyfS+UvHxKI14QQn8t0ml/VJXb1kYrctFLX+Mu/t1JE=;
        b=PZ5Cer2VvgawBAiwj32e9OgWrX0Wc/394uBq8zscQBGuxPx+G3JcasoxLfxmnNxGKB
         nHfvWjIfcacTtvsNFpK7Ohv9QpDnHZTScQseyAxAorFzDzvultHWOpWwSh0y7VpEeby3
         xdOwH0IBEJS4LcH55uubqIdfAFB7en2Ztd37U2i6Agt6tW1MmZm4UkxY7gW38j8djDED
         yr6WAWavJsNA6B69QZH2WW7CcS8uqNQVl94ZC0BmjYd/HSgmr8rLbHsXK4S2IIX2pF+6
         V/ZHlv2d89OBWciWU2/GNJZQm+MXcbWU8+xE4Ym73yMKrHPmg8BkZlWRyPBtE6u3anxM
         xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663158; x=1741267958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyfS+UvHxKI14QQn8t0ml/VJXb1kYrctFLX+Mu/t1JE=;
        b=NfwdKffZsu5QLHZ4f2IxxrVxTHH8Rf+dp3cHqR8sxIit/JPqVDqFvHb3ZvGT2xpXdM
         SbG8j3VfN0RzeSNvccbUJ5vLSJSlunyvADofBHYAFMBTE5NqK/yj+nvueQumnLkNEtVQ
         FpPVnl2JurSlMiKq1T90yef0UrBa4C+LJkC+Pn+XjAQK6Rl6JlrafN/1uoC4cQWhMJmn
         TzkvZ0Gi9ovGLbbdPTFHjLs+FUqNaDZaIjsvk26dYTV1+6UXXbk2kejdPY1mg88PqWQY
         sO1D0vpVSdqrM+Q9enueI+VYTUvw9m4fsxoLgw320Usg/8YCo3fjGDLdporOouicBe88
         t0XA==
X-Forwarded-Encrypted: i=1; AJvYcCU4yDJzMhZPZQBKV1s4nF7chLEtcH62XE95fOI7KanO/jKpwOSNzE6aSAyCNMZYjpmSLmx78dm0Kh7GSYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5ffGSKOYr8gKECzT3EOGezcFsunc+xO9wuSfdaV/FjIJbA6/
	A87WRPyGQxfcWI3pPvYB4Po59CRH/2Pue74/KFxYZWTgj5/w8iX+fxgM8E+ED2f20RsiKDGLk8+
	hS+jgyQ==
X-Google-Smtp-Source: AGHT+IHvETM3+pn2QTpJ1tsLr3mG9ApdH9Fim1Cx8ibw/PLC8WURMDcwwL5DzLuRErYfJClH2Bb5qxGCi7L2
X-Received: from qtbcm27.prod.google.com ([2002:a05:622a:251b:b0:472:122b:3255])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5d16:0:b0:472:1573:fa9c
 with SMTP id d75a77b69052e-47377118705mr141991131cf.6.1740663158655; Thu, 27
 Feb 2025 05:32:38 -0800 (PST)
Date: Thu, 27 Feb 2025 08:32:36 -0500
In-Reply-To: <20250226114815.758217-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226114815.758217-1-bgeffon@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227133236.1296853-1-bgeffon@google.com>
Subject: [PATCH v3] mm: fix finish_fault() handling for large folios
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Brian Geffon <bgeffon@google.com>, stable@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Marek Maslanka <mmaslanka@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling faults for anon shmem finish_fault() will attempt to install
ptes for the entire folio. Unfortunately if it encounters a single
non-pte_none entry in that range it will bail, even if the pte that
triggered the fault is still pte_none. When this situation happens the
fault will be retried endlessly never making forward progress.

This patch fixes this behavior and if it detects that a pte in the range
is not pte_none it will fall back to setting a single pte.

Cc: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>
Fixes: 43e027e41423 ("mm: memory: extend finish_fault() to support large folio")
Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Marek Maslanka <mmaslanka@google.com>
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..f3054bbb3c1e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5183,7 +5183,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
 	int type, nr_pages;
-	unsigned long addr = vmf->address;
+	unsigned long addr;
+	bool needs_fallback = false;
+
+fallback:
+	addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -5222,7 +5226,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * approach also applies to non-anonymous-shmem faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
+	    unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
@@ -5258,9 +5263,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		needs_fallback = true;
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto fallback;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
-- 
2.48.1.711.g2feabab25a-goog


