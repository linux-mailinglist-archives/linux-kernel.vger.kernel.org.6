Return-Path: <linux-kernel+bounces-278760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96194B465
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B4D1C21915
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764B8BE8;
	Thu,  8 Aug 2024 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg55I2Ue"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F8881E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079121; cv=none; b=IcTsTmqoSsN+VgFvWP6Sl1/T0gBhPreO3t51Q53qNZJkQs/hhZPgragxgng17NpFIn4Xbd6vGRmU8LEBmJvedZ6ll6HscHVaT3kzgZrDcZGHMcxSyA0kgaYFQxGFVP85Z9xqq4UbFMx1EtxbAgRS+KNRvhiE0tt2rPyQbrf35UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079121; c=relaxed/simple;
	bh=5U4lS5blrjKjNnwtJ0JAGrg9HtapdZAUWXjQBZSiQMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFkA1qx0t5BN62J7mhyESpDfHT9g0eq/HsCLIzetsGcbBhxN1zCeNkbCN8tK6U9zhDVmjCNMFPUU8gQSVja6rNag58G97YIQu1qHksK1Z7/8taVAi00s97vUk12KJY6+WWrHJzV0HQV5NM+OFewqmfgTcC6eISZNrtNpBLuKr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg55I2Ue; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so313614a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723079119; x=1723683919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ8sxzB4aPr0Vge9g3yQBgOYvVFXrxRLbY/NfWTtAlo=;
        b=Dg55I2UeOF8RX9QzF0TKErDwjx2yacOn/WUvYdJgx0do1snbDwM5jvdEy9nbeT38dL
         Q9tZ9DevC3drap/o5kg2eFgrfRPbnlBqFUBk4wTULI/0kJ8Obz9RQvnmxT9HTq/MOfCB
         dPbIfoUu0zWpCDz/CyYAvt2mpxLX3EpKrxhF1Y3MttoRnEo14P+mm0q8BqhXfmjRZ6GN
         +/jy9fpZZAXqr3OufqtNcofQCKS3IWKjODnGsUosiKOObBro6JFGzNXYaxj+Q59ViV2z
         p0Hf2OfELltVSQwIPdvdhRTHS0SIUY3MctxENsIxExcLDCodaDzEIsV4hYv0d9mTaOfj
         DwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079119; x=1723683919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZ8sxzB4aPr0Vge9g3yQBgOYvVFXrxRLbY/NfWTtAlo=;
        b=iAMzHaYJey9vWuhIK76B0W2GZK/CHqTqMswX/qzQVXVdG8LNMrCAlaJstNoRk9O+CE
         +kuKKKp2cNoq9IETJy2khdTWAjlBBi3SDHOkNnpnhhK2iz+nBseP/cATASmVjw6Sr2en
         kjkt4c6sFTFXFrvmehaoYwS7xRuAgCuCUcD0AauH2d78/WXIza5wp39oo72i3XOGKvfy
         Ne/RC0egXormEk9oLl73qk2L9O26jBTj9lw+ZPLC2YqPJOqQOT5AAX8jKJp/Ah3bs835
         T5a66Mze8OaVtAz+IWLni4vNWeYBbnlW2oMZonmr4wjD8uLEtW2xm0pctzmCxkc5dWFO
         LliA==
X-Forwarded-Encrypted: i=1; AJvYcCXQNi4jL4vI97scDcGG3UD9AAkqwS26e99hEei9A5fd5ePq2vO/QzZNw56e762DEB40UCCHhugsJbvAUQwITM7E7GezK/RGL2xsJql3
X-Gm-Message-State: AOJu0YzyNig455v4bIr19Z0/iCT2HyK9Xj/JlXscwv/xZfT6OIOx+3gh
	qpeCrDLmTnZJwdfUg23IHMUbOClNui+V+Ok1zghg63BG1kY3PNe0
X-Google-Smtp-Source: AGHT+IFCeHsptWQNn+GRGmrttopLCRKRdBS8FtimFO4Zbpo1lD2OAE4fdgSkKuEBLGbzrph+oLqDyA==
X-Received: by 2002:a17:90a:b10e:b0:2cb:e429:f525 with SMTP id 98e67ed59e1d1-2d1c34668f4mr418466a91.33.1723079118896;
        Wed, 07 Aug 2024 18:05:18 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9cc5asm2234639a91.10.2024.08.07.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:05:18 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com,
	hanchuanhua@oppo.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 1/2] mm: collect the number of anon large folios
Date: Thu,  8 Aug 2024 13:04:56 +1200
Message-Id: <20240808010457.228753-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808010457.228753-1-21cnbao@gmail.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

When a new anonymous mTHP is added to the rmap, we increase the count.
We reduce the count whenever an mTHP is completely unmapped.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  5 +++++
 include/linux/huge_mm.h                    | 15 +++++++++++++--
 mm/huge_memory.c                           |  2 ++
 mm/rmap.c                                  |  3 +++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..715f181543f6 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -527,6 +527,11 @@ split_deferred
         it would free up some memory. Pages on split queue are going to
         be split under memory pressure, if splitting is possible.
 
+anon_num
+       the number of anon huge pages we have in the whole system.
+       These huge pages could be still entirely mapped and have partially
+       unmapped and unused subpages.
+
 As the system ages, allocating huge pages may be expensive as the
 system uses memory compaction to copy data around memory to free a
 huge page for use. There are some counters in ``/proc/vmstat`` to help
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..294c348fe3cc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -281,6 +281,7 @@ enum mthp_stat_item {
 	MTHP_STAT_SPLIT,
 	MTHP_STAT_SPLIT_FAILED,
 	MTHP_STAT_SPLIT_DEFERRED,
+	MTHP_STAT_NR_ANON,
 	__MTHP_STAT_COUNT
 };
 
@@ -291,14 +292,24 @@ struct mthp_stat {
 #ifdef CONFIG_SYSFS
 DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
 
-static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
 {
 	if (order <= 0 || order > PMD_ORDER)
 		return;
 
-	this_cpu_inc(mthp_stats.stats[order][item]);
+	this_cpu_add(mthp_stats.stats[order][item], delta);
+}
+
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+	mod_mthp_stat(order, item, 1);
 }
+
 #else
+static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
+{
+}
+
 static inline void count_mthp_stat(int order, enum mthp_stat_item item)
 {
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 697fcf89f975..b6bc2a3791e3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
 DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
 DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
+DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
 
 static struct attribute *stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
@@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
 	&split_attr.attr,
 	&split_failed_attr.attr,
 	&split_deferred_attr.attr,
+	&anon_num_attr.attr,
 	NULL,
 };
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 901950200957..2b722f26224c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
+	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,
@@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	    list_empty(&folio->_deferred_list))
 		deferred_split_folio(folio);
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
+	if (folio_test_anon(folio) && !atomic_read(mapped))
+		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully
-- 
2.34.1


