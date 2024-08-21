Return-Path: <linux-kernel+bounces-295111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A29596F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D610B20DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35901BAEC7;
	Wed, 21 Aug 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZaK4qU+6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133A1B1D60
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228411; cv=none; b=Mr1wqONnxuMNK3IiaaCq3b7RGkv68dJLxMJWVJGCcCz8PVywDVwz+28AizBc/cEAAQS8uvuuMyehUa5p5l6ik/yzrVRyXy/F8NuqNhiH0BXAXN8iarqsJHjHqtYMDTTLDszwxsaf55PGTpAt1dY6LDNrVQg0O6U2dANHhX0Kx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228411; c=relaxed/simple;
	bh=6VVYech/7eI8919A6pOE+PmFQ5cOQ+vb1NF6FJ9YCKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FF+3eEb/kLlLtw+gBEy8DiEeO0B91xJM4OR6KXEe/1NTPTdJx76Ajq4sejKPShysN/8wsUVrpx6rhSorGE7cnlyvgRuq5BkYiat6wlQwJwg8JSwcU+Dtn/coPtLPIWd17QogP7lYnBmwbMOnS8dXjYa7s20IWjkIbKchuXSqNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZaK4qU+6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso379668a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228409; x=1724833209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk5nZGQoU/UHicxrt5T+UXYIL6+4L5PcGNmpQKRqaJs=;
        b=ZaK4qU+6lg5h6QpKcBH1Ve0mKjYKu7M2HDK5rXcUWrqI+LxfuJCBmcZ2VxtHhLXrqr
         15sZU6UFHWfRM0EgbwM3uUk6S8icIu31qK8e9TOGl0tpZIYAzr7RDwU1wvxQa+cs50Sj
         GPnR6ZccSRzOzdyBb2uRqqqnVzTP+PLxW6WcMYBsD3Aky6D0hUK8wuEC3AzwE3dynTQK
         49aDYRBVafRFlo8EUJkOfEudZ96jUC8evd0TOc9//M7cj0GITkl2efTFsZ7oubAOEnEw
         GLd7oY2BKU/yWQv7hqW3YgvuKhpgWrc50Y66AXh49G6BdwRapJmNsNPQGKBnsP4F76Dj
         x/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228409; x=1724833209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk5nZGQoU/UHicxrt5T+UXYIL6+4L5PcGNmpQKRqaJs=;
        b=CnocdjaU2QspOsORERyQYFno54JB7PEYBEA924qEc1ZGh6jA0GAVnytXCx/I4PUsQK
         dnr5ze1HhEFTRS+viQ0N2PW7Pb7cAQTkzdiCAT30kwXB9vxiHKSfvCopWkMVYgiE0p1c
         W99XWr4GOR5Y9Uli0kGwAXLoLEMW2J+Wc+TqYjDjlr/Y+KTFxEeZ/HKmbhfk3N2Zet4v
         tUxCTKsrB+hLHxNDIvIiDNCNNoX9XsAoX4HDfaSlEWv/CT8mShWuteXEYb1z6S4Loy3q
         WAb3CgKGm5GtXMHvfr9Nw1hqhrZgpfLn8sL1TGNFqidbCJII6XeM8UPcsIwHSwdNVvJD
         FGdA==
X-Gm-Message-State: AOJu0YxRLEreIBpk76EHUphqe2RyeMNOlYDwyHNDUfCx6B9cjLXqNbP+
	fLtdHU+NUtPq3AHgxY7rsBz3Or0U9oVAPy7WiqqFQu2gj4rrIrFJFZbD41hLkbaDlj+3P2EFwtm
	h
X-Google-Smtp-Source: AGHT+IEz6hEUMU7QDWWn6q3mNXap3/YJ5XtpoR3UgLNTk8qimJ6ZhRH05YhkApxF5Pk84JIDmuV6pg==
X-Received: by 2002:a17:90b:4a10:b0:2cb:5dbb:d394 with SMTP id 98e67ed59e1d1-2d5e995c932mr2717849a91.4.1724228407428;
        Wed, 21 Aug 2024 01:20:07 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:07 -0700 (PDT)
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
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 06/14] mm: handle_pte_fault() use pte_offset_map_maywrite_nolock()
Date: Wed, 21 Aug 2024 16:18:49 +0800
Message-Id: <239432a0bc56464e58a6baf3622fdc72526c8d57.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In handle_pte_fault(), we may modify the vmf->pte after acquiring the
vmf->ptl, so convert it to using pte_offset_map_maywrite_nolock(). But
since we already do the pte_same() check, so there is no need to get
pmdval to do pmd_same() check, just pass NULL to pmdvalp parameter.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d02..d3378e98faf13 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5504,9 +5504,14 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * pmd by anon khugepaged, since that takes mmap_lock in write
 		 * mode; but shmem or file collapse to THP could still morph
 		 * it into a huge pmd: just retry later if so.
+		 *
+		 * Use the maywrite version to indicate that vmf->pte will be
+		 * modified, but since we will use pte_same() to detect the
+		 * change of the pte entry, there is no need to get pmdval.
 		 */
-		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
-						 vmf->address, &vmf->ptl);
+		vmf->pte = pte_offset_map_maywrite_nolock(vmf->vma->vm_mm,
+							  vmf->pmd, vmf->address,
+							  NULL, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
-- 
2.20.1


