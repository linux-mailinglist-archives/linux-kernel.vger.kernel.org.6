Return-Path: <linux-kernel+bounces-282423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23E94E3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DC71C2137F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83E165EF0;
	Sun, 11 Aug 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckuEmKdV"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC44166F22
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416610; cv=none; b=asagwPw/QdLieoRfGP1OD5cwIqjiE8YDhSsvmflBLVaW1/rWRLPi/ngzBimXCstWocAIH73HHhpxJ5fVdCGD3pzYFnS5aLFZbD11Ky27MEyRlTj5dM3Ucl5FMpucjybNU7gTtXwc/Oofd7T4Mqtm/57X22fppvjMtgXhDmeKPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416610; c=relaxed/simple;
	bh=IToINcaF2S0+9dCP10klRm3tCSewdppPlJSqaKrLXA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9bw7rOZ3q/4Tv0KukZWykcKwWSIeGZ0sTIzgtu1Mewq1Hn7fQDDOp7csS6r/0ZBXXI4YNi+Xop8K++nP5K9vW6Dkiyz2nU6/uifPP7EpeY1vmbhXwqM4zFLk5+vd7iyinFy9O50ctIl3D91XagSTfCEUN4hbSx84IpnMd8K/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckuEmKdV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso2685021b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723416609; x=1724021409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw0JgRH12Wo8KdGqNK+rncsTqLHooD07nmRGRawWDls=;
        b=ckuEmKdVTGxoh60KsxP/jj1IcGzd4PY9OhZq/F1dvo5WE9a22tgRRH7bcw+28uOcpi
         RDXB1LPbAwbCOEhyjr2RyfZcaIXY6YV++vw7R1sp/L0fGdz6ZL8seKYMCewDMyD9QEh5
         RbtfkjcNfbVP5Y/QvrGfrk+9/JvwurjiMh+i/a7+SNUcBy/tJMlx8ZBYcxLfnVA47Gut
         EwQw4vEIFS4VYpEToxfVRPIesyH9qtJQWhDifaJ4hp3Z7sfzTqKECcUPsHnvJRZ2yF8C
         IVqA0sNOtao28Gs9/IUI6bkAqt4blS7FUtHdbxY6N2c9hikMyb9fUqYn242oUZcEVQMT
         EfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416609; x=1724021409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw0JgRH12Wo8KdGqNK+rncsTqLHooD07nmRGRawWDls=;
        b=aaQqdFa0t8FITqVJTNtjYhR5BzCf+RQEI6oq8T+R4nAa5x3O8ATx19YlUQa2K2JpRZ
         ynju+5i92WYPEi0O15NzHoRP5PYpUvHaX4zRL9IDBj9zeYhSSufVW4M0XzWYJN2Ev/4X
         BZEBOkE2ct44FOl+0FS76+d6l5+HY718OsdSBj4+z6QFfbeXFJGnlttyBBBkQwgOUzxV
         7G0EngBzkB5IYXv6GlCsDTjTL3jAl791rZEx1S2lMa8v3y7ResitgJrELtsi12Q/RmiF
         p4Cwc5hPM+Hw0VAWy7uwMeXUppesdC1aw8uuHJE4SbVWHYDPQAyIAN7bS6SOkEtvnmeJ
         m+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWTMAtV3+Ug7Edr3W1UNp1Q00r62zcVl2JtCrpKSQruFIjxFbkzAXlNp3LMrZ2qmgul/SpbPifavImg5g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLt4g/nuIqkdYZSXattiRN4dSdXF0//n10+i+/LKCN6B4B/HK
	lafOSXYAe3XiRQuB2Fha7w2MMXICmcb07mI/Q8pI7Px69pHAzYV6
X-Google-Smtp-Source: AGHT+IGAQoUx/mSmccF5tcTHEJNHLzHr1Ne7T77+kVl0PpmsVLNxjtn54anVGm8f20OzojHM35fnSQ==
X-Received: by 2002:a05:6a00:2e17:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-710dc6e549amr6012262b3a.13.1723416608551;
        Sun, 11 Aug 2024 15:50:08 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ddcsm2822993b3a.28.2024.08.11.15.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:50:08 -0700 (PDT)
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
	ziy@nvidia.com,
	yuanshuai@oppo.com
Subject: [PATCH v2 2/2] mm: collect the number of anon large folios on split_deferred list
Date: Mon, 12 Aug 2024 10:49:40 +1200
Message-Id: <20240811224940.39876-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811224940.39876-1-21cnbao@gmail.com>
References: <20240811224940.39876-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When an mTHP is added to the deferred_list, its partial pages
are unused, leading to wasted memory and potentially increasing
memory reclamation pressure.

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
index 9fdfb46e4560..7072469de8a8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -532,6 +532,11 @@ nr_anon
        These huge pages could be entirely mapped or have partially
        unmapped/unused subpages.
 
+nr_split_deferred
+       the number of anon huge pages which have been partially unmapped
+       and put onto split queue. Those unmapped subpages are also unused
+       and temporarily wasting memory.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2ee2971e4e10..1e2d5dbe82c5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -127,6 +127,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
 	MTHP_STAT_NR_ANON,
+	MTHP_STAT_NR_SPLIT_DEFERRED,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afb911789df8..1a12c011e2df 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -597,6 +597,7 @@ DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
 DEFINE_MTHP_STAT_ATTR(nr_anon, MTHP_STAT_NR_ANON);
+DEFINE_MTHP_STAT_ATTR(nr_split_deferred, MTHP_STAT_NR_SPLIT_DEFERRED);
 
 static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -610,6 +611,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
 	&nr_anon_attr.attr,
+	&nr_split_deferred_attr.attr,
 	NULL,
 };
 
@@ -3359,6 +3361,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_SPLIT_DEFERRED, -1);
 			/*
 			 * Reinitialize page_deferred_list after removing the
 			 * page from the split_queue, otherwise a subsequent
@@ -3425,6 +3428,7 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_SPLIT_DEFERRED, -1);
 		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
@@ -3466,6 +3470,7 @@ void deferred_split_folio(struct folio *folio)
 		if (folio_test_pmd_mappable(folio))
 			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_SPLIT_DEFERRED, 1);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3513,6 +3518,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 			list_move(&folio->_deferred_list, &list);
 		} else {
 			/* We lost race with folio_put() */
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_SPLIT_DEFERRED, -1);
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
-- 
2.34.1


