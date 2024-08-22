Return-Path: <linux-kernel+bounces-298034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF295C0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214201C2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D001D2787;
	Thu, 22 Aug 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj5JBnV2"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940E1D0DF2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366446; cv=none; b=flXXLXUlQbI5FiJMpHPf3ptd9b5Juaf5jrNT266zGsvtabPs6zxkhOkoku0cYufPVGuFpKfwNAzUrFbuML9dbDTAfBunjgT9vADq4MCYPuub9B2qeWlyDm3/TSrJWZtqnV2daihPowbUTbxemqm96L3O2miq6Hp5Llp0XYNIylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366446; c=relaxed/simple;
	bh=ZrlxsJfxAQLOXh7tvanSJNOTVwsUW8jzs1D69cbZVXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MD4eoGwBCAAFlc3qGmscQYpz5xm2pfWiybh3sOAcQB1LJs3ACu//BhrbpvCv74v91/nGwt1Su+RbxGzqbCVQgmiaSnmOGSKQCL2SMb7WRuxxUGhpce6RY1IQ+yE1jcJ7dkOr8/nGqlZEngGz4gB+sEmXfhTb4RqoiRrfcQSNMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj5JBnV2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714302e7285so1131865b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724366444; x=1724971244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVEO528xLjg/PuKuE9cDFRxA62lNB/Fmrg4qlWADHI0=;
        b=mj5JBnV2QXHZG4TVXrdwh2Kc3JL4W5aToASIlBo97Yjiv5Wf+5aKoPhXdkOs7ZAvhp
         PhaqBEqVr0457wBiRkFQXz31O0IdXFoi/e7XGODlN98zIXw9PiYntbHJn2UJcOSz/p2H
         wYtpj8AdmXmh8MzzVNftmtC+87ucxtCw7chwjDC35HMaRowLVY/h4zVuko8m/gZqDC/Y
         jTMph+D1IBsP/u5BM2dGwC7dyTrOTLETDj56kGGU3lw526JQLX3fyVXKBEgocZSahXyS
         ydhxRd9wPCF5C+B0yH6cZMr/3EtP2ZGCUNfkWPsJ4vdm+SnevvqZdug4c2VCOYHcevIk
         4mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366444; x=1724971244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVEO528xLjg/PuKuE9cDFRxA62lNB/Fmrg4qlWADHI0=;
        b=FE9Gpk86BG3FPNMS3qiP5V3TmbMepIH4MrfqCpp/N1ejgmLdppotx0cR6DVLh5RNVI
         wPoNMOp717rliC3X1LUOZiLOq3IFAKnJHpbyySqw09j3HfKjPtYJytjDMpakO0u191ay
         J4Al8C4OyJ6C2IoufMENrpZe9oUevKNGDm7udQBQZV59/IJERgNze+j6ZyePyQBiX5Fi
         uCaOvWWkc4BIn++UgAxgY64YeMkzH/i8RPu74nDWKC8AhzTHgCra2nJ9GhoBAmS2BwBp
         LXvvOxNkrCsrwSxk3Sf9Jl90/HPq9CuAWiMTTz4wcPxtPJ1WGS5kUmwLLoP0YOL5onQu
         Mk3w==
X-Forwarded-Encrypted: i=1; AJvYcCW1k2wa24onXaz8U4tVl89E4eQDzwTwCIRTQRZG8UTrxDIKanSQfXVSs+BCP8jq1EdHDrzP0TDSsHAJgXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR1hs3N4Ei2GOK/6PqopH0aMQhcgxN2eUMklok2d0WFf18Zza3
	h2tTKy56+dUJSxELcP6h6q+S4+36mclQIfsF9+2Yxa+IGIt5BVbg
X-Google-Smtp-Source: AGHT+IHnqb968+Zitp3p5u4TOI4aFeXzvXdoE4qLweNPuNBY4uAHHRFd2qkEsni5ggfyg4UXXhAL5g==
X-Received: by 2002:a05:6a00:1a8e:b0:710:4d08:e094 with SMTP id d2e1a72fcca58-7144573cd07mr499649b3a.2.1724366444216;
        Thu, 22 Aug 2024 15:40:44 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:427:337e:a4f:8e74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acabccasm1609912a12.27.2024.08.22.15.40.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Aug 2024 15:40:43 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	yuanshuai@oppo.com,
	ziy@nvidia.com,
	usamaarif642@gmail.com
Subject: [PATCH v3 2/2] mm: collect the number of anon large folios partially mapped
Date: Fri, 23 Aug 2024 10:40:15 +1200
Message-Id: <20240822224015.93186-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240822224015.93186-1-21cnbao@gmail.com>
References: <20240822224015.93186-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When an mTHP is added to the deferred_list due to partially mapped,
its partial pages are unused, leading to wasted memory and potentially
increasing memory reclamation pressure.

Detailing the specifics of how unmapping occurs is quite difficult
and not that useful, so we adopt a simple approach: each time an
mTHP enters the deferred_list, we increment the count by 1; whenever
it leaves for any reason, we decrement the count by 1.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 5 +++++
 include/linux/huge_mm.h                    | 1 +
 mm/huge_memory.c                           | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b78f2148b242..b1c948c7de9d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -556,6 +556,11 @@ nr_anon
        These huge pages could be entirely mapped or have partially
        unmapped/unused subpages.
 
+nr_anon_partially_mapped
+       the number of transparent anon huge pages which have been partially
+       unmapped and put onto split queue. Those unmapped subpages are
+       also unused and temporarily wasting memory.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2ee2971e4e10..4ff4e7fedc95 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -127,6 +127,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
+	MTHP_STAT_NR_ANON_PARTIALLY_MAPPED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26ad75fcda62..b5ee950df524 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -598,6 +598,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
+DEFINE_MTHP_STAT_ATTR(nr_anon_partially_mapped, MTHP_STAT_NR_ANON_PARTIALLY_MAPPED);
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -611,6 +612,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
+	&nr_anon_partially_mapped_attr.attr,
 	NULL,
 };
 
@@ -3457,6 +3459,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			/*
 			 * Reinitialize page_deferred_list after removing the
 			 * page from the split_queue, otherwise a subsequent
@@ -3523,6 +3526,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
@@ -3564,6 +3568,7 @@ void deferred_split_folio(struct folio *folio)
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3611,6 +3616,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 			list_move(&folio->_deferred_list, &list);
 		} else {
 			/* We lost race with folio_put() */
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
-- 
2.39.3 (Apple Git-146)


