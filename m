Return-Path: <linux-kernel+bounces-314573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6796B54E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C131F26B6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052A1CFECC;
	Wed,  4 Sep 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hub1K39V"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A571CDA20
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439304; cv=none; b=UZwlrfpp+h1RvwkCMGNd2MfJOSW7ACZM29WJELHdXm7kDn/bpIR5or4CRlwWeJaw5KorALUC0KGYHFjhScpI/Md8bMdRM4z0xfdRHV9sOCviIx2ML7M0h+Pe+pwcljyoeJkpmphRR+P817+7gxucq205hX1QrWA/mlxnX89z0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439304; c=relaxed/simple;
	bh=hDpOwgBOPPSAVs5qcIYRUt4zcDmO9dDuotmNaP9YlXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlVJMy+/Z9DahPVqv4ydmHKN8bclAlOf8oo5Qi3mGsGBgMJ1rrOqJn0NPdOeEZ6g1x++rulFQTudoIGi/CqyUhZbv0orTp1smour+I9FEE7mWJgCsRaUVQnKWv5ynihUKEXOcCg30cpeUCa3Oi/AcqgH/KYBZ6Q6KtH3GmCtLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hub1K39V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8a4fso21204755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439302; x=1726044102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHfOyy55HFvG/XxGZW1ra6nqYg449VLN9cHJI9/IEBs=;
        b=hub1K39VoAw3gViDaM9WmbKAbGh92ejNsayldik9Ype+Cx4Jp9xXs/o3eQGlhn8FuL
         sm58pkVMVyBBY8gBM3YWbpP/MSf7ZLDVJ8WSQZcWikFkvPWjczx+hJedc5YSqKUcdDp5
         w8vlVC99nv2TqZGVa5CEBTgK8xn0F+GqNJWZK34Z81ZZNcGzO9Jg+iRnw8Z54ozqGsc+
         xkMVzCP77jzpW1OKnbnXUfhmM/t6mhTgrtu75+1gYjY3gcYF5zSQH7oE7STQRJkwP9TN
         azaD9CiTkviyv2nxFHE1rAk1ek1dLG/Sh0PG3zsKYCaR95B3fpf7VFQ/aEJ7On3bGwCQ
         D2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439302; x=1726044102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHfOyy55HFvG/XxGZW1ra6nqYg449VLN9cHJI9/IEBs=;
        b=XamsjWduUbTYOfxdFKo2uDn7G9Xtmikmie8Hv1iOnjVUcPMXHU72UQkhpS/rjRm5se
         Ew7qoCJm80PqE27wkiKoihkTCAG28hwv2ONzJ8hOX5ieuLqS+EM+QR1N2C8uVpmyV+mZ
         T+qXM5j/BH8mPvahCcCknIgf2r0Bv4qugydXq7nL687+jxpY/L4HIXzcElkuMahDzmuS
         S0wKnDnaKVPggtIbKRCns+B9fiCa9BQhWjHKXxY8QoPoIjBQ7oTyoTnejx0R5tNqGRN3
         qgNG5lbbFUMYnlaLhqSTvrSPBLZvcCRNoFTgHQNz47496FmV1DRGkvnJlvp/YIrFm9NI
         fTSA==
X-Gm-Message-State: AOJu0YxcljuXIedvpauvKbMQ7qpYORgQPUuUoL95AtL6Zw8YVeFmPV21
	GLBkwh0M0qqpNPzTnRZ1CndsFtC+eFST2OJWo+ae6PXPQpA1zjBOXjWP4lwHRo0=
X-Google-Smtp-Source: AGHT+IGlDE+bZkJMe3LtnR3dMefm4RFnOsn/qpiRzdld3O/wCPCkO6r/LjjSl6iGWtDIKmNPthI/eg==
X-Received: by 2002:a17:902:b68b:b0:202:4a24:ee with SMTP id d9443c01a7336-2050c45e710mr147539585ad.55.1725439302519;
        Wed, 04 Sep 2024 01:41:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:42 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 09/14] mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:17 +0800
Message-Id: <20240904084022.32728-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
convert it to using pte_offset_map_rw_nolock(). Since we may free the PTE
page in retract_page_tables() without holding the read lock of mmap_lock,
so we still need to do a pmd_same() check after holding the PTL.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mremap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24712f8dbb6b5..16e54151395ad 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	pmd_t pmdval;
 	int err = 0;
 
 	/*
@@ -175,14 +176,29 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	/*
+	 * Since we may free the PTE page in retract_page_tables() without
+	 * holding the read lock of mmap_lock, so we still need to do a
+	 * pmd_same() check after holding the PTL.
+	 */
+	new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &pmdval,
+					   &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
 		goto out;
 	}
-	if (new_ptl != old_ptl)
+	if (new_ptl != old_ptl) {
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
+
+		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(new_pmd)))) {
+			pte_unmap_unlock(new_pte, new_ptl);
+			pte_unmap_unlock(old_pte, old_ptl);
+			err = -EAGAIN;
+			goto out;
+		}
+	}
+
 	flush_tlb_batched_pending(vma->vm_mm);
 	arch_enter_lazy_mmu_mode();
 
-- 
2.20.1


