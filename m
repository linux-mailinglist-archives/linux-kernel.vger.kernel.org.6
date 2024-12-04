Return-Path: <linux-kernel+bounces-431048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246F9E38D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E48B253A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D781B4F2B;
	Wed,  4 Dec 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lvIqLbyk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A21B21B3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310650; cv=none; b=hYvcQdS3Mm5XJ+iSV9CxlDFhSZvkjSOUdyjEp22k2epX5+9IlDO1EItnd9zFKC1Oarf/kDultZ83LE2xxX1S2I0TsUSmRShn0h/9USXYcDNNRpCmU1A8b8IlPUBNzdQ4sLbtkJSr8aXGxmv2vwd/wjAFqVE9gDT08m1rlGxbO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310650; c=relaxed/simple;
	bh=6cazHoRYcol5ohvX1jpEboV34t7h7jYizQ5+Hl/hvx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ry/nz0cpTipEVEcKsDSH0gAfwxslQccc+aRs7XeiQPx7UOea+/oanZ+1K/FUhz7VTE8WJaheBPKf0H7CkUhrH504027yujS2gX9odb74OvvC+NCX5KlsHzUWG+60T9hPkXrRwAP7ws0vk4xT3bC8q8c1GLGbdQgaEl36nkDOL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lvIqLbyk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so61931145ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733310649; x=1733915449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2X5SMV19Fsn2OjJZllhusee1Lj+v0wZR5QDlA7SZpw=;
        b=lvIqLbykAAfCTrZHQyTbEyVsI5x53/pPILhRn4Q0O1h5f2UMS2fV3G5S+iCBUJvtIH
         KieYxYmP2cdUAdV/xFLd2eM6dpSa4I7lszXhTrL2qi0ZQy95YbFHMilTMUmWjarBrQFI
         zthPo5JtBR+Z/sT5MVHdoj83pxhK9ti88R5Vwmc2yz01L0MF2FAvgrwGugeHtl/if9HT
         px/ZSs6kMwgT2atCMEpt7K7lcq2nvdYPW5HT/rT/McGBvFTifDNYvxFHHwZBdHKeJgrd
         +lFUxKdYb2QbtJVjYtjA5iqQORAlVE1ugVhsdcBG60JmxSbzKx42d63arUMLFyvkSBso
         MlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310649; x=1733915449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2X5SMV19Fsn2OjJZllhusee1Lj+v0wZR5QDlA7SZpw=;
        b=umP32LOcqLeaMkeenocMi/CjX2rzr1ZrCohjDryS4nLrzaTVFZJ9ud2EtN8tkx8PF4
         NjlFn9mVpZ0/8cQDOW4Owz/jDmQKmlKqnpJGYbPnSCnIikC12IlJ7i38nhiHJEo68B3J
         c018a7ffyBHxmgXIdr+LioykxdhmQLu2Ko0FLFbOrY4ywfPYm4P15p2rnB5N0nRj+he4
         yWe+UgpkiXOwJA/+z0GLi3oKNm0vJQp4kDe22msieYeeV+3SUX29bLth7cNhQxj227A6
         qr0gcGfehO6oP5OqAk9KuwnEO8lsAVoumNSTtcv2lfX53pVWJzzArW9Omsr/8hZxxLbs
         EF4w==
X-Forwarded-Encrypted: i=1; AJvYcCVi6YagOemQ08GGkvlf0tR2/UkMPTl+DLBM3FWgZAL1jL5gyRkZEe2t3r92mJBfHCriZDRu5q1O1YCZKgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiuycjqy+FLEfIEQhmsauspYQlteg81Z7orMd7i98atnc5/rJx
	Ey0uSX7rJBJ8Ku6SakyejBYQ0L0vvy7RK7lrd3GE7WZoP7SRviJTYBYaqy87i8Y=
X-Gm-Gg: ASbGncteIS9KoipSTC5kzlWX0HpkCxjsLdj1rLWjOrNqTNvfw+ra9ynamkA5DoXd3Sx
	kFnOZXfHvRMJVP0AhsgB2QqW5fTFLAmHQH1ZxGe33RkmHC6DSNLCYYTicUzj+xo9roPMJBrkwg2
	ml/wl9urbOzP0JLaxNsAP1Qw1j1x46Fp22RTMPtXlOQc2Hy8fHDgO8lDE2N7uK0B/t4R5cT8J1q
	X7GVyjcNbNWV9n2BcKwPkaIX67qzfNQNoSSAnTCn8h2Kza/wknv/y+3XqJkBliITNOVkOrmicVC
	6a52ywWETagmFk0=
X-Google-Smtp-Source: AGHT+IH7KMftfdbT7IJ/SYECv1Z0b6kIRJQ0pshXMsGiPcHLBFGh7gTwpZlD1z3c4LTYAe+5oKH33A==
X-Received: by 2002:a17:902:d2c7:b0:215:b18d:e1 with SMTP id d9443c01a7336-215bcfc2ab1mr102416785ad.24.1733310648745;
        Wed, 04 Dec 2024 03:10:48 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21527515731sm107447495ad.192.2024.12.04.03.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 03:10:47 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	x86@kernel.org,
	lorenzo.stoakes@oracle.com,
	zokeefe@google.com,
	rientjes@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 04/11] mm: introduce do_zap_pte_range()
Date: Wed,  4 Dec 2024 19:09:44 +0800
Message-Id: <c3fd16807f83bb7d7a376cc6de023a9f5ead17da.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Jann Horn <jannh@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5624c22bb03cf..abe07e6bdd1bb 100644
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


