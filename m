Return-Path: <linux-kernel+bounces-200321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCF8FAE68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC09B21024
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61FC1459E9;
	Tue,  4 Jun 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XxhLpnXo"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95B144D38
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492163; cv=none; b=NqPLfFa2ZnQs+fj3vqoBPFX2Fok0uVaSAuh70RNKJtiTnn4QhYb+TPHKx915KyenWv1rongXzuxHry1XgBeg79jlvytjHPDQjwZqlBbxi3ywNwzsAsUELKhp9PUQjiqJeFwr6k0612PEY0qMXnFlXTIb/cwxBWmPeaBVSLZHk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492163; c=relaxed/simple;
	bh=3Sz+Aj3CJQm/oV0JwgpIRYXzlurt8LpdkUahvJGjCqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mRz4TaHGkpBBBJgKTA44qzJkneJJ2aw8e1PvzaT/sHHsKFnEC08PfTlwFNVNXu67Itgl8SGCy0KUvulLb0v9+qFpfoUHbp7DcUV0M5adHMmfQhe5AAhd83R/1/xylpWVySIf5DjqL9aIam6z2KHIn+vZQSK67UWU5XitkRqYPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XxhLpnXo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaad2c673fso31778691fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492160; x=1718096960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a14+jXYXTjmg6E3qRGIvRJfYcGA2t0M1Ozzz17Ypyc=;
        b=XxhLpnXoPrNLG8bYixdzk8iipsGpkr2ELIViKvAuPJS8ouhGl2fZKKdB0eKvL6JTA1
         hEBYOEg3+Bk6tL4gNsatTF5C2mymf5eMUbmlrcQBz6dPZeeUuvsWIK9E4TeaGFECNZUQ
         Ez/+NJklKMr7NhGTatmOxrN1jtKd2pgYOnjkBLu9l2DqfcNxu8BePTVEhJi/JxXH+e8M
         l8JkpH8PW5q0diCb/ROqwvN3zkQJiUYHU/BFZ6UX5qBLbpyVB4dsU3XdW6aQ7R7l5IE/
         7Dor0/w++oZJEhV5ABBU/Yb7TwTwFNV9J51L2iOAeCzu8L1V4CSulmpRZXAnDU3ps69m
         GjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492160; x=1718096960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a14+jXYXTjmg6E3qRGIvRJfYcGA2t0M1Ozzz17Ypyc=;
        b=WSQL/9W7CMtAkps74K8ohBOrxb7rWQTNSlOnlt9KJI/TUnKR66oKwRwjoBP3XCPHAB
         GjJRkwW3rRcgSgkbsZu8tC6K3d0Ga0Ta5eiMKCjmt9OtEooBZP7s3gZE9Oo6y5JoP70m
         Wi5+jQ7O0cpdbCBN9/6QIac92+lDwwoIMHuJEkQXd0Smw+KEeIPz/lJ2KXzQL3s6isoM
         /wdeTHfsNL/rNN/u2dOwR7vXuXd+hgmiHppuk60e0vbyl4YtZik7jhCUWNWNt0Jo++r6
         uT6+THHo4Z7yZthV5AiTzjeXZRflwk1EzSbx51Ufl765anmiHsRY+AVbh95E4mpc8jUR
         bT+w==
X-Forwarded-Encrypted: i=1; AJvYcCWLTZZoPGSJ50MBG/CPgLeasCjMuJa6uWxVF7V8L92NB0bFLcZHdTdI2S2TBGcjHALS9QNm0KWsGWbhWS+73W0budBgRlSrf1R5B+An
X-Gm-Message-State: AOJu0YzWAwOecX2mVVkvrUQMI9ADBGbMaApj+Ic+Iimgzogs5WMntFv2
	YyNuPfCJ/bDr7dYs0/+YnoQ8BZtJoMVmAqfjIcdZ/MYQa18wrsJ9t4ua5JBVVZg=
X-Google-Smtp-Source: AGHT+IHsJf4f3OBFK5S9RQgJe4xLIo0Z7mZgH0CJQAgenYk9ZH6OP2KgkT94QdNs7YGr5ClMSzJPQA==
X-Received: by 2002:a2e:9d88:0:b0:2e1:9c57:195a with SMTP id 38308e7fff4ca-2ea951de27fmr93794341fa.32.1717492160177;
        Tue, 04 Jun 2024 02:09:20 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 11/15] linux/mm.h: move page_zone_id() and more to mm/folio_zone.h
Date: Tue,  4 Jun 2024 11:08:41 +0200
Message-Id: <20240604090845.2182265-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed to eliminate linux/skbuff.h's dependency on linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 48 +-----------------------------
 include/linux/mm/folio_zone.h | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/mm/folio_zone.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a32d284813f4..c026e58e3725 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/folio_usage.h>
+#include <linux/mm/folio_zone.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/errno.h>
@@ -1369,33 +1370,6 @@ static inline bool is_nommu_shared_mapping(vm_flags_t flags)
 }
 #endif
 
-/*
- * The identification function is mainly used by the buddy allocator for
- * determining if two pages could be buddies. We are not really identifying
- * the zone since we could be using the section number id if we do not have
- * node id available in page flags.
- * We only guarantee that it will return the same value for two combinable
- * pages in a zone.
- */
-static inline int page_zone_id(struct page *page)
-{
-	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
-}
-
-#ifdef NODE_NOT_IN_PAGE_FLAGS
-int page_to_nid(const struct page *page);
-#else
-static inline int page_to_nid(const struct page *page)
-{
-	return (PF_POISONED_CHECK(page)->flags >> NODES_PGSHIFT) & NODES_MASK;
-}
-#endif
-
-static inline int folio_nid(const struct folio *folio)
-{
-	return page_to_nid(&folio->page);
-}
-
 #ifdef CONFIG_NUMA_BALANCING
 /* page access time bits needs to hold at least 4 seconds */
 #define PAGE_ACCESS_TIME_MIN_BITS	12
@@ -1546,26 +1520,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline struct zone *page_zone(const struct page *page)
-{
-	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
-}
-
-static inline pg_data_t *page_pgdat(const struct page *page)
-{
-	return NODE_DATA(page_to_nid(page));
-}
-
-static inline struct zone *folio_zone(const struct folio *folio)
-{
-	return page_zone(&folio->page);
-}
-
-static inline pg_data_t *folio_pgdat(const struct folio *folio)
-{
-	return page_pgdat(&folio->page);
-}
-
 /**
  * folio_pfn - Return the Page Frame Number of a folio.
  * @folio: The folio.
diff --git a/include/linux/mm/folio_zone.h b/include/linux/mm/folio_zone.h
new file mode 100644
index 000000000000..3f3e4284b911
--- /dev/null
+++ b/include/linux/mm/folio_zone.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_ZONE_H
+#define _LINUX_MM_FOLIO_ZONE_H
+
+#include <linux/mm_types.h> // for struct page, struct folio
+#include <linux/mmzone.h> // for ZONEID_*, NODES_*
+#include <linux/page-flags.h> // for PF_POISONED_CHECK()
+
+/*
+ * The identification function is mainly used by the buddy allocator for
+ * determining if two pages could be buddies. We are not really identifying
+ * the zone since we could be using the section number id if we do not have
+ * node id available in page flags.
+ * We only guarantee that it will return the same value for two combinable
+ * pages in a zone.
+ */
+static inline int page_zone_id(struct page *page)
+{
+	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
+}
+
+#ifdef NODE_NOT_IN_PAGE_FLAGS
+int page_to_nid(const struct page *page);
+#else
+static inline int page_to_nid(const struct page *page)
+{
+	return (PF_POISONED_CHECK(page)->flags >> NODES_PGSHIFT) & NODES_MASK;
+}
+#endif
+
+static inline int folio_nid(const struct folio *folio)
+{
+	return page_to_nid(&folio->page);
+}
+
+static inline struct zone *page_zone(const struct page *page)
+{
+	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
+}
+
+static inline pg_data_t *page_pgdat(const struct page *page)
+{
+	return NODE_DATA(page_to_nid(page));
+}
+
+static inline struct zone *folio_zone(const struct folio *folio)
+{
+	return page_zone(&folio->page);
+}
+
+static inline pg_data_t *folio_pgdat(const struct folio *folio)
+{
+	return page_pgdat(&folio->page);
+}
+
+#endif /* _LINUX_MM_FOLIO_ZONE_H */
-- 
2.39.2


