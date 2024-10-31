Return-Path: <linux-kernel+bounces-390149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3449B7626
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02182284B52
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D65154C07;
	Thu, 31 Oct 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vadr0rah"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B5187323
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362468; cv=none; b=R/+XYFdLBo3nkOY/mnlGFzAKxwhf3nrs1x7J+Lh9lFJ6LtNuMSfYB6ARh+IZhQ5biKiUd4uR7lHRUIFNG5sy6aRoxVpBYcZd1LY93KhLBalI6DGFgYFRYY6hxk+33zEU69dbyOOe+Leh4cFLjreoC8kwvJbzJvQqAKkH6YlFPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362468; c=relaxed/simple;
	bh=4i8PRUnaVqGvMO4RXt6asLg2xN9z/UY9Zi1Qe/JX+bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JcL+K8Zp9r+nIwbfG58tv63vgfhRWUxzDqrxnUHKG4n99j4HhoCzLuVh0Vq8WFZhQhFl08lc2QEoxywm1OcMiYWFxQrLS+laF96AvtYHv1YVHxJEey8YzIRVmCLvliEmUuyA+EoKpOI0O3pdv2/HR6bp1t+eYzVlT/lZ7D4nqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vadr0rah; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so512503a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730362466; x=1730967266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhaSq+JiwY2eXMq9iHjNOMwdUtMvBCWvXjuj5WTX7eI=;
        b=Vadr0rahN3LtIc/4HFmONWQ0dawrkUofE6EaJ4NdXKnzJxbV+7CxSloIGBSVNACEZc
         ApDc8rsiyWgummM9XS4y72DPIEguyIwr8ycTILJ98oPZk6/xihhryuVEoZQ+/s/x597y
         VtORjERIs6rrghtzgaypMIZYJHgvTdMn918ger6GQ7FnD5VUsH9p1VuGckfT4OixDoEa
         we7FxaHCr7DQCn6H6xaWu6rNwABt41sBecOGaw3Wq1ZTzSGk8ljD5Emq1v/QkjPXjrCG
         +filO8FgmsSTPLbofejQKss47TBRqEC6APpJuLgq8w059XewB9X54g9MvxfOJbTcS61r
         AEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730362466; x=1730967266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhaSq+JiwY2eXMq9iHjNOMwdUtMvBCWvXjuj5WTX7eI=;
        b=g+nrrN3jzYkG5jrdtjFTO10skJLYm/cfev+B92WKPTgeWfQKjEcDu8r4p9cEngkM0Z
         D/xKWTgc9ib9e95SzoMNvLBDs3QSOCsKCv6SOs1dbrCh/qsZYpAjaeVfBABbBAAtOe9x
         /KV24YRwwbyh+anIHsbWCYQuMBI8uiBJful7896caZq1ATBhfozRArAN4UMmBG1CKRQ5
         AMhMoF55meSR/PNWmaTtNlpbSU9KGTjCzTiVoNFp8PZiKt5LTu+bCecRJazboEDuhQFI
         v6AxU5tpY1SfRYgRM+yH85p3zjt/1HbutLMkfZV5JZDHVGMDXaReC8zWlfmHntlU2KvX
         B5xw==
X-Forwarded-Encrypted: i=1; AJvYcCWuBNMbglO2W94UH1Cr10dgRRggaCegHWEIZOowJ9HFLm71TH4fzOL5xW1V3GdIgPu/gGll1as3DfsEFvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBdC4IxVyB3XaBZc/pqT5QKJbaXYFK9Nu2IaG59zgXRdLOwwb
	zvFCAdlb3YzPoIGxqdIF4bfCpFxpFBGKWm6fVS+X3EYNdcBSRdBQ6nha6IbMW7U=
X-Google-Smtp-Source: AGHT+IHK1eQB1HIOVcDML9/U+qgad2lrGxmYCIjO8Kr0cktQfTqjB9fcEN6v3D+sRskXXQsEGQyaZA==
X-Received: by 2002:a17:90a:bc83:b0:2e2:d17e:1ef7 with SMTP id 98e67ed59e1d1-2e8f1054a67mr19337853a91.3.1730362465831;
        Thu, 31 Oct 2024 01:14:25 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9201b2586sm5163996a91.0.2024.10.31.01.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 01:14:24 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	peterx@redhat.com,
	catalin.marinas@arm.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 3/7] mm: introduce do_zap_pte_range()
Date: Thu, 31 Oct 2024 16:13:19 +0800
Message-Id: <1639ac32194f2b2590852f410fd3ce3595eb730b.1730360798.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1730360798.git.zhengqi.arch@bytedance.com>
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces do_zap_pte_range() to actually zap the PTEs, which
will help improve code readability and facilitate secondary checking of
the processed PTEs in the future.

No functional change.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index bd9ebe0f4471f..c1150e62dd073 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1657,6 +1657,27 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 	return nr;
 }
 
+static inline int do_zap_pte_range(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma, pte_t *pte,
+				   unsigned long addr, unsigned long end,
+				   struct zap_details *details, int *rss,
+				   bool *force_flush, bool *force_break)
+{
+	pte_t ptent = ptep_get(pte);
+	int max_nr = (end - addr) / PAGE_SIZE;
+
+	if (pte_none(ptent))
+		return 1;
+
+	if (pte_present(ptent))
+		return zap_present_ptes(tlb, vma, pte, ptent, max_nr,
+					addr, details, rss, force_flush,
+					force_break);
+
+	return zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr, addr,
+					 details, rss);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1679,28 +1700,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		pte_t ptent = ptep_get(pte);
-		int max_nr;
-
-		nr = 1;
-		if (pte_none(ptent))
-			continue;
-
 		if (need_resched())
 			break;
 
-		max_nr = (end - addr) / PAGE_SIZE;
-		if (pte_present(ptent)) {
-			nr = zap_present_ptes(tlb, vma, pte, ptent, max_nr,
-					      addr, details, rss, &force_flush,
-					      &force_break);
-			if (unlikely(force_break)) {
-				addr += nr * PAGE_SIZE;
-				break;
-			}
-		} else {
-			nr = zap_nonpresent_ptes(tlb, vma, pte, ptent, max_nr,
-						 addr, details, rss);
+		nr = do_zap_pte_range(tlb, vma, pte, addr, end, details, rss,
+				      &force_flush, &force_break);
+		if (unlikely(force_break)) {
+			addr += nr * PAGE_SIZE;
+			break;
 		}
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
-- 
2.20.1


