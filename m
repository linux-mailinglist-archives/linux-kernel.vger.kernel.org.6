Return-Path: <linux-kernel+bounces-314571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3296B54C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6655828C5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9BF1CF7CA;
	Wed,  4 Sep 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KELdJdon"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99B1CF7AF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439291; cv=none; b=SegGs+Jm7LKDsxLQJ2GUAmB0dNO3KH7G0EliYDv5iViH5GhE4zEDFqHbVxYXrloVn+1rTY90d2yf1ngj9uM09WEzvGLB9aa5o74h5k3Kid0QkTPo5x0Rv/qEdSuvxdkLvsVP1G2IOzx/UHsG2vPVY+jduN62g+NQDzxGgx6uY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439291; c=relaxed/simple;
	bh=dswOOZEK3YN0rQ2t/qfVl5+dn5LvxI1SZRUT+v+P+Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Foc3lhNMxxo7oGbQN1uhxtm7zAS9aThJoJh1gXvQvzBn/w3Ffm4LXGNFfDKZeCJ65+Z6mUuxl+e266+xLKDtop7nKXbRZBPyhCDWSM4m2fHQYeUscaWYmdz70PmrJhJM9qwpX2M3WmbLhAFK8tXNaYquh0trXIY4aU/QC9loI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KELdJdon; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71434174201so5159336b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439289; x=1726044089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ720IHYb4PoZSjS34HAH7fD9gF/j7WA/1t49m6Kiwg=;
        b=KELdJdon9tFSGVXdZP+O9X4ZSqFOdWO+QhNtQXvC2QS/YsGhe4XkOeC79AC9XR4rxD
         ILh8M01isntUfmuC79ogKJEkIQveQrBnAv2LD6ImUmcellIuFa5yS0nxN0YMarHyLTOj
         hFiRXyqnnoeFplkb483kvfEbwhh25Io3OcKWdQeWrr7Fgl3LvRH5G8+gxiV3vOCcoMtB
         J+5j4vMUVtcZoxG5J+hmY2qR6sDTN1VVX6SESuM38umH6k+4LwA+9X3gzFib2ZN2x0Bp
         xJS53xMqRn53gjGx+hszOP3f66zxC390fCaWEPkt43EJVhEfwIx6WFVbVOBScFarz/QZ
         4mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439289; x=1726044089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJ720IHYb4PoZSjS34HAH7fD9gF/j7WA/1t49m6Kiwg=;
        b=Wy3xthzp0fpm8RSilxy8okysFdcR3qhdhxycKmRlkOk0wOwKFl/uy5iBJnkTdgQu54
         I11jTDiy2b5Nk6ClKIFa5ZozUTMpF/WSUu5gSLWscW1Rd/lNIqhes24MeM84udrbzXuf
         robyDRSeeBFtRaevD38L7CXERDTsF5F47uiGKCoUP5mdMW4d7TxWV45uNSSaOJGq6SJw
         93Ictq+QCBfPDXYh8lbyIja2yxo9ypHrf6vhWAIyCCvT87D0d/ms3vAVMSWBNywwkolM
         ocIZJPFh2HHMIDz6fDn0Rii27mPio26fZq4gTUfzTIdQeiVVzkQHJv4FqF5iX+bCXvCJ
         FqYQ==
X-Gm-Message-State: AOJu0Yyu4s8sS6HgqwLvohxJBcD4PffubTaRRGBCjZ09UCgit6k0DL+A
	Iv4vypDHgiZxSYUWLwMyamncxjA4q7PUylQ/IDs8nStCCdGX7vPQODmKXMzzONc=
X-Google-Smtp-Source: AGHT+IHVhSodGEWLJbqfntGARXqFTBke8IrjtWuvc6P4tKsUnW/m6YB1esVTiG0+MVp8pwa1UVDERA==
X-Received: by 2002:a05:6a21:330b:b0:1c6:edfb:431f with SMTP id adf61e73a8af0-1cecf788518mr14875554637.44.1725439288977;
        Wed, 04 Sep 2024 01:41:28 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:41:28 -0700 (PDT)
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
Subject: [PATCH v3 07/14] mm: khugepaged: collapse_pte_mapped_thp() use pte_offset_map_rw_nolock()
Date: Wed,  4 Sep 2024 16:40:15 +0800
Message-Id: <20240904084022.32728-8-zhengqi.arch@bytedance.com>
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

In collapse_pte_mapped_thp(), we may modify the pte and pmd entry after
acquring the ptl, so convert it to using pte_offset_map_rw_nolock(). At
this time, the pte_same() check is not performed after the PTL held. So we
should get pgt_pmd and do pmd_same() check after the ptl held.

For the case where the ptl is released first and then the pml is acquired,
the PTE page may have been freed, so we must do pmd_same() check before
reacquiring the ptl.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6498721d4783a..a117d35f33aee 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1605,7 +1605,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, haddr, &ptl);
+	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1613,6 +1613,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1658,6 +1661,16 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
+		/*
+		 * We called pte_unmap() and release the ptl before acquiring
+		 * the pml, which means we left the RCU critical section, so the
+		 * PTE page may have been freed, so we must do pmd_same() check
+		 * before reacquiring the ptl.
+		 */
+		if (unlikely(!pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			spin_unlock(pml);
+			goto pmd_change;
+		}
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 	}
@@ -1689,6 +1702,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pte_unmap_unlock(start_pte, ptl);
 	if (pml && pml != ptl)
 		spin_unlock(pml);
+pmd_change:
 	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
 drop_folio:
-- 
2.20.1


