Return-Path: <linux-kernel+bounces-339970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B91986CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E3B283E99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0118D621;
	Thu, 26 Sep 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="itaI4G/q"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596917554A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333257; cv=none; b=bVRcMR1U4t8y4oa81BUWdnzjRxRcl0qnMi3hmKtgh/kq7/nsxfK27GCU4c60zIwEuDHDHbaytVy1OB148JSgSlfxdppmLafT7eVtYqoZ0/fQTtauC/cuGQDnr3VMspMuIK2y+AEze0yZazGRhsuB9IVljKahhyrErgnUIBjgxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333257; c=relaxed/simple;
	bh=AW2pi97601MGuZiCOXDhP3jZoiCUTCuHUPQzcZePTCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlQ9r7lTPFh8OsqZyP+JhrhTA1GUQwbDM2GQVFz/Vi8FOLkl/7kDyqjLEICAhLGFvAmwEkz/DmEzCX1mLAjqRIXrmqmmRigMqsi+8OoN+opoWUql1p2/QTDIhCIv6fhlHjx2dq6TpJwKY8VO78qQmiYLbKEkqJPqH/BFDAbZkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=itaI4G/q; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9b049251eso47707685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333254; x=1727938054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88oX8R3xcxvOkzUvzbp2hva7xyyimZKCI3msRz7gwSQ=;
        b=itaI4G/qzn2DcT8Rl3gcyXgeMKtQlTP2zbR9vQvlX993Z5EWneMssOdIQNlxp1tCb9
         A14kWE6D4Wpgupn0ML3oSLAYNrJQ2nUtiTV9azZXBuJqmn9xsPddePzumdthL3AVRSgT
         0ojFQguGdE/RCSeOjnjdQ6XtE+tUa8B+Tyb+VHnRKUL82uItVt4Mm3oJTMSGsN96oOvg
         GgIRbIflmJ7/ihaGstZrU7dFwmT8f3AGcJCn7FS8umhTT6gapZSnCHDdFB6Vbmeg+sd4
         TskwLUolsweR5epzQsP5GGTiGr+fcUg5Z4Yg4SwD5M7DocKwePquRZ65+GRnVspkkcza
         111w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333254; x=1727938054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88oX8R3xcxvOkzUvzbp2hva7xyyimZKCI3msRz7gwSQ=;
        b=lmJUmADnkV3P2xmdN7SDf7nF+33WPCXC07rlACwKJ0qvfnx+AmdXVpqVi5eF6nKV0g
         U2sFH4prKgjj+Wt14a3UzTenl1eddCJ+fmvX8DE2h2Bwif9JzXSnOzZ8MALOKJl/Es53
         mJcojqKlFBn50TSn5oXXpJ803aR6hGG0Tl3QYYJbCph+DkC5hEdrrWCTIzTswGBXpa+f
         4L28q1c9CfzbsrvfxT2dIHn3Gvo+vuZ6L5MjifmaRsxLIC0lKlRzPfRa+dqnGhsBVo1a
         9R5WNSHjGMJ426YqwRuXFyKgzTrvEdaNeVDJU/2eQps8EynHaAzbt5e1gD2W7qmx+JmU
         7nOw==
X-Gm-Message-State: AOJu0YyckxdhMdbyVOMC6Kujh86o2OTFfba//uldJBPGqVsijnVL0Wue
	jfUU4wA7G/li4uG7BMWnKSV6dOzbwdHFxKkOb1L/mXZlzTnZ33rHYxh2AkvBiag=
X-Google-Smtp-Source: AGHT+IEkNfjkqcOSOf8WFqyh7ycpXwLGwDHOuzbRwWfPgE4JYY85w8LbZC4JktZjOBGqNKfXWcA2mg==
X-Received: by 2002:ac8:5a43:0:b0:458:3824:a083 with SMTP id d75a77b69052e-45b5def43dcmr69885101cf.32.1727333254117;
        Wed, 25 Sep 2024 23:47:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:47:33 -0700 (PDT)
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
Subject: [PATCH v5 06/13] mm: handle_pte_fault() use pte_offset_map_rw_nolock()
Date: Thu, 26 Sep 2024 14:46:19 +0800
Message-Id: <af8d694853b44c5a6018403ae435440e275854c7.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In handle_pte_fault(), we may modify the vmf->pte after acquiring the
vmf->ptl, so convert it to using pte_offset_map_rw_nolock(). But since we
will do the pte_same() check, so there is no need to get pmdval to do
pmd_same() check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
---
 mm/memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a245d28787034..6432b636d1ba7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5750,14 +5750,24 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		vmf->pte = NULL;
 		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
+		pmd_t dummy_pmdval;
+
 		/*
 		 * A regular pmd is established and it can't morph into a huge
 		 * pmd by anon khugepaged, since that takes mmap_lock in write
 		 * mode; but shmem or file collapse to THP could still morph
 		 * it into a huge pmd: just retry later if so.
+		 *
+		 * Use the maywrite version to indicate that vmf->pte may be
+		 * modified, but since we will use pte_same() to detect the
+		 * change of the !pte_none() entry, there is no need to recheck
+		 * the pmdval. Here we chooes to pass a dummy variable instead
+		 * of NULL, which helps new user think about why this place is
+		 * special.
 		 */
-		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+		vmf->pte = pte_offset_map_rw_nolock(vmf->vma->vm_mm, vmf->pmd,
+						    vmf->address, &dummy_pmdval,
+						    &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
-- 
2.20.1


