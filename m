Return-Path: <linux-kernel+bounces-369557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754359A1EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF8DB23F61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AA41DB37F;
	Thu, 17 Oct 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LymoGsNQ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF91DACA7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158478; cv=none; b=DHMnp3moDiL/A29KCJcGIt1saKGvIi2j3jFOD/XSEAJkRDEWbi1ZwKdewffiYBJv33LPF0RJGV5TxmrRVxGfXzP+nBUfqq9kAC4/aWMppokSzdJD5rqFI045IbOF/d3lUH4FkQZVJGJ4cmGugrASPSLRyemsSjGKYT/CqHrJGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158478; c=relaxed/simple;
	bh=xy3J47nYQIkyOxm6U50THk/J9Zo0uYz5kNGc+0/M+B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2GW3rH+0nNFmWq/NWBWg3ObqPeKiXSiUaXpJ1WTnHOZpyg90do0phaBvpMwlIJ5Bb4ndFr/tyV/qkPkDggXt+Wc+738JCrjOPvONMgtA3gQn4Sl47msD//Wbx9M5XHRgm1kkEkvmMt8/sibYiAfHRbA9R/o8IVetuYo/6Pctdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LymoGsNQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso499207a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729158475; x=1729763275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7VdqwStWQj5e7m9yAII5NEsGFIvs7nS0Am+cBAHNsQ=;
        b=LymoGsNQp2QXmmbwAL3cOXmeaGmYSJu3KKfXEaZchjE5RBd6YHFkonLroX5Tv9chJm
         BgboUAM4tUcKqKETnF66g1INCPp7poEM8DAD5g85r77c5if+9hKFxoBNGrNOvEkOE4T2
         t5lI2DR2co8oWEeAugGBXVX0wiuJMWI2paWZsF0+4m8MjdDxb8pM922dch/KEewsIQz/
         GMao+Bfb29Cu+gIfeF1s6hm3CQrgEtkZopqMEMwW7F3G6vR/bQIoMgS+D0xWgUqUpEpH
         4dXMtLcYuBc5YRzdbW7/4hOcmPYkja5X3emFT8PT2PSp47yuMPJ+GxS5ahrqQ2WoNtTh
         X/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158475; x=1729763275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7VdqwStWQj5e7m9yAII5NEsGFIvs7nS0Am+cBAHNsQ=;
        b=UgLnaS7q0rPeWzMSOv2hcEXUlWzlBkPdG5w5mDUEgLtEMJ7IhlOsvnvpCglgLkBzzO
         BL2/gTl0KIV/S7DGofEMNoVPq8+cYnFLzXxsrGJGntr4z3wDlIKN21+paQmkc0xaz7TK
         48XAkfUmBFnzUAxmWQNVSFsw6t3mNPi1N2roIwe9z/TJS7T8RUz9J+jM0LwcvEfeNcqx
         oMfn5RCTdass4IZLa/jV7ebcp/qyajmMMOXkcGhEMpi+W5nc4O9qXhl7o2Ro7WA45SoL
         fZ/4nB8WEtXm33de/LAXIOXxHVYSjenlK6oce+OgHTU5ONCRpaZZBXiOYflp+Z7LXaly
         67Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVx2C/eu/wNqV0vaIfzq0MghArBVWK3zvP1ZexZ+5Tac43CFqawZu2x7ZQ03Ps4ZfTqBP+s8erFRoRJHEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKZpR1YdDDRUj1Qfy56/Hgbfk0x/Ytg/R/zRTMdenQmCUTJUT
	cexUh8I3jCdom4ROaigeza53lpwdN50HzRmq3beXzNBk4TwHCj2+DOiU3lXS0to=
X-Google-Smtp-Source: AGHT+IHzuiiCIun9pa4mZiHfpa9E3frsNbxHgaXVoXJzu+vwbmm9rxbIGaUhA7zByM5nDjwu8FuQmQ==
X-Received: by 2002:a05:6a21:e8a:b0:1d9:181f:e6d8 with SMTP id adf61e73a8af0-1d9181fe778mr4119688637.31.1729158474948;
        Thu, 17 Oct 2024 02:47:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4218sm4385365b3a.120.2024.10.17.02.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:47:54 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com,
	jannh@google.com,
	peterx@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 1/7] mm: khugepaged: retract_page_tables() use pte_offset_map_lock()
Date: Thu, 17 Oct 2024 17:47:20 +0800
Message-Id: <258de4356bdcc01bce0ff1f6c29b2b64a4211494.1729157502.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1729157502.git.zhengqi.arch@bytedance.com>
References: <cover.1729157502.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In retract_page_tables(), we may modify the pmd entry after acquiring the
pml and ptl, so we should also check whether the pmd entry is stable.
Using pte_offset_map_lock() to do it, and then we can also remove the
calling of the pte_lockptr().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/khugepaged.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 94feb85ce996c..b4f49d323c8d9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1757,9 +1758,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		mmu_notifier_invalidate_range_start(&range);
 
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
+		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte) {
+			spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+		pte_unmap(pte);
 
 		/*
 		 * Huge page lock is still held, so normally the page table
-- 
2.20.1


