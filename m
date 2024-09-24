Return-Path: <linux-kernel+bounces-336589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20258983CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF081C20C92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CD12EBDB;
	Tue, 24 Sep 2024 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kZ/VmX+K"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63181AC6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158286; cv=none; b=VdopRHibZCNezPkR/7wcI3hkxj6+fvjGw/norCvDtxPYdCNoHX73Vw3lEKLxsE8UAZ5okumo/UCETwYRZnTq1ygb8b71n3Z83VFQT4M7esUkQF2cgseYvL1b14vDKfFmmclxDQGkD8U1/SkaC0+a+y37w8Hz2rUZQtZQA0/YZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158286; c=relaxed/simple;
	bh=fNpWWLmkLOIWq8WIIHHiPpHL0jJedeNIHk+yGdnzoao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trgtmDKVtvzePQdxvE+rmEPxryIAfGYaMl70/VVnyFkWVw92MncvURkEFX0mmNnB4syZCU5nKSzx1nx6Z9a/VihK2z3oGJ0Aiit96bukH7Z1SkHeYfJc8ZGd4iCwrzGmPbQQ+I6sG9nSrXBZvrccOsS/3IR90/02h7qN1gjyj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kZ/VmX+K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-208cf673b8dso50308815ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158284; x=1727763084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYDx6olGBZytK5syFvtWNqesQWJmZ/VcuSiPjSyD9NM=;
        b=kZ/VmX+KaKMVOV2PxdWAxRQbKvOv9uU39GLuEwfcWA3AbXpNSdtkrnrmZpTTY4b+Pq
         tQ5kv9Em3kb8wgf8YfIglWNqHKD4yxTedlW9zeSB50KITvydf+9pYaErIYTmCxkzf6O6
         TqMSQJja/R9TAdjA3rlMSekoXrbibG6KeWGR5KExGxgCpbElwd367FUvLpnckmxGpZFP
         n8/k4L0lV/E19U56OVnVim6j4munZ4nT2KCAK2vcciLAo0/J/k+HI90iD6paXcc25K6g
         z+N7kVdhk+CSUzvdlMpkNaNCA6UcOod7aHg8WNdxgE9wbCNEVXxHCHy+K2uZm9xjkD0s
         D1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158284; x=1727763084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYDx6olGBZytK5syFvtWNqesQWJmZ/VcuSiPjSyD9NM=;
        b=HoLNGa6xAaNAGfF01R4YOqpXLmS3bx6fpQojUzQ8001yKSZyqui7i30zB+NJUWAvt1
         t+SJjmFTT7y6QeMwqcN/rKNchdzGed1FyBj4FW25j8cHMD5nZD6em+xY0Cunk3RtM2Jo
         IVXto4ipk5GqSLfYySIKkHoMCwxtnj/bvpxX+AFvDL87H7rhLsp1kH6SbwZYpmorjDMi
         BFpRAdS0HU9hujCxiX3wQZRQVvlkyNzJ5tEhlUd6cUO6xg5LA7JEfF1zjDOq0bkPfp8Q
         4oYIv7uGfXeXPSUHXmmAnc1neBWN2DcVHa9hb18UB+ExDFlbwY0qVYZk7l+aGEUGxkx2
         dB5Q==
X-Gm-Message-State: AOJu0YwiWJomXKG1TawNiRIpotEtrRzfLePSci+M5SkndL7psnsvhvvQ
	I4Zgjb/4a0ln4Ny6lbT9C6oZDxFKAApJ1H76ZGrDjv0aHj5Rp+akN5cJx+MAUzE=
X-Google-Smtp-Source: AGHT+IEhn+iGj1vkzgTAalYoZbG5psMaFd6djM60OU+3J7JbD8pdYTlvGGhg/wgUQ8cNcQFEVSSWnw==
X-Received: by 2002:a17:902:d483:b0:206:aac4:b844 with SMTP id d9443c01a7336-208d97e3f78mr215574535ad.6.1727158284398;
        Mon, 23 Sep 2024 23:11:24 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:24 -0700 (PDT)
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
Subject: [PATCH v4 09/13] mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
Date: Tue, 24 Sep 2024 14:10:01 +0800
Message-Id: <c7b3ba9e8e58efe7bba9d52ce30a8ff4f4298e2f.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
convert it to using pte_offset_map_rw_nolock(). Now new_pte is none, so
hpage_collapse_scan_file() path can not find this by traversing
file->f_mapping, so there is no concurrency with retract_page_tables(). In
addition, we already hold the exclusive mmap_lock, so this new_pte page is
stable, so there is no need to get pmdval and do pmd_same() check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24712f8dbb6b5..9dffd4a5b4d18 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	pmd_t dummy_pmdval;
 	int err = 0;
 
 	/*
@@ -175,7 +176,15 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	/*
+	 * Now new_pte is none, so hpage_collapse_scan_file() path can not find
+	 * this by traversing file->f_mapping, so there is no concurrency with
+	 * retract_page_tables(). In addition, we already hold the exclusive
+	 * mmap_lock, so this new_pte page is stable, so there is no need to get
+	 * pmdval and do pmd_same() check.
+	 */
+	new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &dummy_pmdval,
+					   &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
-- 
2.20.1


