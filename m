Return-Path: <linux-kernel+bounces-418451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CF9D61C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A7A283022
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80141DDA32;
	Fri, 22 Nov 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqErJRCb"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF52D638;
	Fri, 22 Nov 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292094; cv=none; b=qHNXBk+4YZqvWPrceul/XUE74JN78PT+z7x6j3mHdBmgLbX76wYrGD4PLTt5L5eHS+q6XPZ/FPaiu6I6IVNjcO/JZ/vrD0lGRcClXABEFx0mhzrKaZp01EL37GhvFNr2xntoAR8TDld6WfSxAJbcr19vVfkk61ZeYvY5weer3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292094; c=relaxed/simple;
	bh=IwjuWNGh2uZEpdw8TpxMZNPOF/Uq4KjiwIC6pMF8CfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IKZOuWENtcI/aLgMfbpnGk4kLTHu4sKFhweuZYXLcaoGBzb8aVicfXFHKbCYipgNo+FNLTSACbDdAx3EHVEL2fD5K1aDHVGqtnspmVHpoPn/8R0g3FT+Te1oIMWT+VkVq/ywWVdGVK5MXRWoysVAtp5uWXivtnVHrt4DUGbeobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqErJRCb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72483f6e2fbso2077330b3a.2;
        Fri, 22 Nov 2024 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732292092; x=1732896892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrbSK43NLfB2e4wOG+aqQWdM/1SYnnFodbzmkkuii34=;
        b=jqErJRCbAkfnBoQCX0Catfk2NO1PbouOGwpOIrfC0HzTI9owza7eHRhleL9RWWPZ60
         0iP6ZafksChd8MJqwlu3sKJiX06LiVEbzM1YIq0nWV9rcJXDHh6wZI0OXstazpQWRaRi
         MtvIlsMWQeFKpYTFW4VOrJB3sBvBwMZCkd5Z4Sqfzb8Bm2OP1WtuTvjJlq9SYJ88QSZj
         MlOrTdBhcfDN3aREv3KAe3DCRkGCYZq/uKCag5e7s2QJD+7G3CkRRBAYWfpeWD3qHsAc
         XPa2elorMZkxzmEGSiI1p/xxC6aN7cf5FICu6uBM/IEFVTWP47N3egHgPUHOwhtoLWjt
         07WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292092; x=1732896892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrbSK43NLfB2e4wOG+aqQWdM/1SYnnFodbzmkkuii34=;
        b=GXzt820r2ozUlSMO3lIzXwrBIlrfRNv+jNgj8ejc1ZY1KBzHUen5pfsIoFbvrwG95L
         +9BJOQkMeTw03xfqOx+Tw1rlmtc6b/kHL0+h3C/6XFL9Tx6o85MKAHGb4ZuH+WsFovsS
         NQuyT6cJpZoM7m0iymubOL2LWuX3VyxlNtZc08kYHe1Swxvnu8Bn9uJ42AekAO3AmQ/8
         BkyKNyct9b1y9hW51MsTktgxeDMGdWaUAJcJ6FxZUnXaG2f/37LttOOXiQt4vfNxiqeP
         X++X6oTepfJcQvRpOxTgqN/Ahyufjkyct4Mf4shmg0cgflmV1NkOC0B0gt3pz5GOuYa9
         Tb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2EXespqrWKDA4xLpZHWKc0C7nCvzDfWV7LMhgyyMbmvISg/2x07AfBjl8pnZu4HLUjxhOzQKFJP0djm+i@vger.kernel.org, AJvYcCWZp8TVLDO8rkU4JXOAqjfjsszbKshqyIpqh1NyLIGtwQwhjfjdDYwol5YvoxEfHPoUBAo4jdeDYjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKZ8/cLGP7TIqmX53MaWczhMYR61laZPxyiwk3+pncnCtczrM
	Aowwenk9POFaVqtJ/JwJe7rwwszaPI5vLrEcN7wzO6SXD0tN8/ed
X-Gm-Gg: ASbGncutG8BXXPs2yg6XfR7/NHjtD2laeGn7Dgoz/yCbEWD5G+Pzk80o8MCpLPT/oIP
	w6UzfCfFH7hGkQS7sD5+Y/7LRveVp3k16XFhEev88OFaWx0aQ9f8r4fB/lBqVMNd2ESrj7AQkGM
	FMxnyIAjzt+HYgAzskU2leTsGRWlRmK3rd7j7WTawivrVCZSEKIM7QZEOO0iBz6Y5b7wRsM57VK
	mdTgdF6XNZ5zQbm0fjSX7NnJ4r/oPkoTzgaC8I13HLA+3ZWAcrLvebtUyyzZ6xZPI6lbEBtvI4=
X-Google-Smtp-Source: AGHT+IHZBKaTxzynLBARfL0nD6HFNiUz9zQkGuzJbrgfSWXqatNsBKAMj0e4czJDygoyIwHBq0V3Zg==
X-Received: by 2002:a17:903:230e:b0:20e:95c9:4ed5 with SMTP id d9443c01a7336-2129f5c3b21mr46128455ad.7.1732292091863;
        Fri, 22 Nov 2024 08:14:51 -0800 (PST)
Received: from localhost.localdomain ([112.2.230.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22009sm17890195ad.264.2024.11.22.08.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Nov 2024 08:14:51 -0800 (PST)
From: Wenchao Hao <haowenchao22@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Lance Yang <ioworker0@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Wenchao Hao <haowenchao22@gmail.com>
Subject: [PATCH v2] mm: add per-order mTHP swap-in fallback/fallback_charge counters
Date: Sat, 23 Nov 2024 00:14:43 +0800
Message-Id: <20241122161443.34667-1-haowenchao22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, large folio swap-in is supported, but we lack a method to
analyze their success ratio. Similar to anon_fault_fallback, we introduce
per-order mTHP swpin_fallback and swpin_fallback_charge counters for
calculating their success ratio. The new counters are located at:

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/
	swpin_fallback
	swpin_fallback_charge

Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
---
V2:
 Introduce swapin_fallback_charge, which increments if it fails to
 charge a huge page to memory despite successful allocation.

 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/huge_mm.h                    |  2 ++
 mm/huge_memory.c                           |  6 ++++++
 mm/memory.c                                |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5034915f4e8e..9c07612281b5 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -561,6 +561,16 @@ swpin
 	is incremented every time a huge page is swapped in from a non-zswap
 	swap device in one piece.
 
+swpin_fallback
+	is incremented if a huge page swapin fails to allocate or charge
+	a huge page and instead falls back to using huge pages with
+	lower orders or small pages.
+
+swpin_fallback_charge
+	is incremented if a page swapin fails to charge a huge page and
+	instead falls back to using huge pages with lower orders or
+	small pages even though the allocation was successful.
+
 swpout
 	is incremented every time a huge page is swapped out to a non-zswap
 	swap device in one piece without splitting.
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..93e509b6c00e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -121,6 +121,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
 	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPIN,
+	MTHP_STAT_SWPIN_FALLBACK,
+	MTHP_STAT_SWPIN_FALLBACK_CHARGE,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ee335d96fc39..46749dded1c9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -617,6 +617,8 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
+DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(swpin_fallback_charge, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -637,6 +639,8 @@ static struct attribute *anon_stats_attrs[] = {
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
+	&swpin_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -669,6 +673,8 @@ static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
+	&swpin_fallback_attr.attr,
+	&swpin_fallback_charge_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 209885a4134f..774dfd309cfe 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4189,8 +4189,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
 				return folio;
+			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
 			folio_put(folio);
 		}
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
 	}
 
-- 
2.45.0


