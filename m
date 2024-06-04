Return-Path: <linux-kernel+bounces-200314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C88FAE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203FD1C22E18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33661442FD;
	Tue,  4 Jun 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M0kAdpmy"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA57143879
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492155; cv=none; b=cLYmDOi3HgQIZP6MvUeW0eGAnySNwO3aGgiAu7P2T9GiRMYfhe8KWaNBnFA0dwaXFkWV6FeQ67Aw8a22m3T6CYYoA08+g8f0avV8W32V615TELraCY+gdxxd2KXfaNDFzX8bD/Y4GoSMEHc9jlM3sdKOEG7B1Luk1RocHVlD4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492155; c=relaxed/simple;
	bh=UdxRgzWjFQ8nvwfCq2iecsJsp5rik97H65lidWIfejs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vE9OwoZwqiVrOvK/yQly4d+PVYDhfHhh6sLA5XgI6GduyMosGS67N0R2Yw0jE0dNyxBBbKn5/OfWCcAQthGS9RswcBMjbOZaL3vVTSKfDOMKFZMeTiWyvgnQVuA/xPV+OoPnq+DQu4X7/G5uDeYPrdHUxfSHSnrQ8uuYP+Z/7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M0kAdpmy; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a626919d19dso943648866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492151; x=1718096951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu9yS7pQCrsoRi7ZUhn1+G2Y6nFzVt+avQdoI72cAe0=;
        b=M0kAdpmysxYo5hqM46ymYTojdJC21cmzRtlYqOczx8sa1AdEFmqLvxYB9T5ApP1KOu
         KoaVcCTDqqKGzXry0NHtkC7lub32MHyB63YyGZntsPb8kRMZqbv7H0XAFmP10/x2qjHj
         0B7zKpZPdnROjrROLHix0aU9ZfzbFLuhOUVjS4qCcM5jkMuRLnQ8KaxAcWVK4jbXPYBH
         I7b70SdADkYB+lEWlBt1ZEhhwn0EGqhbSo5F8ziPuhaCLAtbfc6P6RY9vx0OoZMAICo4
         OP9uuVINUSuvI9wTiKW+1E+tv3UDO6bRcMnW+UkRXTtUTPm/0qyIT+yTH1GR+8t91UZE
         e9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492151; x=1718096951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9yS7pQCrsoRi7ZUhn1+G2Y6nFzVt+avQdoI72cAe0=;
        b=meehdl5x4ZhJ0SXuvpPJxx2PSYTKHttWGP5cTOSVkO0f3HPgcOGn9tKiEQa+LC+U14
         KnoSLBAeVTZtRTdQjtBoPyENlRIHngf7mq6MGrFgpYXJ3oQO1xHUX+nu0raLGGMAasww
         U0K54Islh6z5kG6Dqw6YU3zImI0wxEPuOGbTMSRvlfNWy80hBrKj62Z4jlGqcVIYIVSD
         q8aLyqsYZfPW548B/8Bqa/sYcT4Ey5NZkPfYmYqaQdDCFDT9B0ULXZLdo7Q8XkX6JLdp
         19n7Gs83VxV5ULZGMpqjdd168JYM8oG6DIZfigHPPJQtbaapjhN5A47ISBSGW3+SCgNf
         U7cA==
X-Forwarded-Encrypted: i=1; AJvYcCWTi1/3FQbvcJOVd6LTAc0OsFegj5jDdjw9T17lcAdqg+WE4OmGJvMgYRz0mDb5/B0R/4c3T7OFGkoS7gkuzQXqMoNWMN7nASpwSE20
X-Gm-Message-State: AOJu0Yxm0f2ytMUyqVp1D6+CuA9Ow9u3p5gy6QF9o6UBXR9qe0mU6M3d
	Z9ShtcrEXIEFYNYNrjKaOBZ2XYSLDE4EkIoji0ajIu1X/esMus8/BkzjIJrCbw8=
X-Google-Smtp-Source: AGHT+IFXHmTUY2LAO0CrBslhuc7TrTKlPItnXfEjmCqfLbltfo+OCfR+cziyr/TPphDgOmpCJJexuA==
X-Received: by 2002:a17:906:471a:b0:a59:dba0:1544 with SMTP id a640c23a62f3a-a69544242b4mr149880166b.31.1717492151196;
        Tue, 04 Jun 2024 02:09:11 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:09 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 04/15] linux/mm.h: move page_kasan_tag() to mm/page_kasan_tag.h
Date: Tue,  4 Jun 2024 11:08:34 +0200
Message-Id: <20240604090845.2182265-5-max.kellermann@ionos.com>
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

Prepare to reduce dependencies on linux/mm.h.

page_kasan_tag() is used by the page_to_virt() macro in ARM64 (but
asm/memory.h does not include linux/mm.h).  Thus, in order to be able to use
anything that calls page_to_virt(), linux/mm.h needs to be included.

This would prevent us from moving page_address() to a separate header,
because it calls lowmem_page_address() which in turn calls
page_to_virt().  To prepare for this move, we move page_kasan_tag()
out of linux/mm.h into a separate lean header.

A side effect of this patch is that the <linux/kasan.h> include line
is moved inside the "#ifdef CONFIG_KASAN..." block, i.e. it is not
included at all if KASAN is disabled.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 MAINTAINERS                       |  1 +
 include/linux/mm.h                | 56 +-------------------------
 include/linux/mm/page_kasan_tag.h | 66 +++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 55 deletions(-)
 create mode 100644 include/linux/mm/page_kasan_tag.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bb9f8077b37d..a9459947a3b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14475,6 +14475,7 @@ F:	include/linux/mempolicy.h
 F:	include/linux/mempool.h
 F:	include/linux/memremap.h
 F:	include/linux/mm.h
+F:	include/linux/mm/*.h
 F:	include/linux/mm_*.h
 F:	include/linux/mmzone.h
 F:	include/linux/mmu_notifier.h
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c41c82bcbec2..3ff239992d4c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/page_kasan_tag.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -28,7 +29,6 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
-#include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
 
@@ -1812,60 +1812,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
-
-/*
- * KASAN per-page tags are stored xor'ed with 0xff. This allows to avoid
- * setting tags for all pages to native kernel tag value 0xff, as the default
- * value 0x00 maps to 0xff.
- */
-
-static inline u8 page_kasan_tag(const struct page *page)
-{
-	u8 tag = KASAN_TAG_KERNEL;
-
-	if (kasan_enabled()) {
-		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
-		tag ^= 0xff;
-	}
-
-	return tag;
-}
-
-static inline void page_kasan_tag_set(struct page *page, u8 tag)
-{
-	unsigned long old_flags, flags;
-
-	if (!kasan_enabled())
-		return;
-
-	tag ^= 0xff;
-	old_flags = READ_ONCE(page->flags);
-	do {
-		flags = old_flags;
-		flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
-		flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
-	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
-}
-
-static inline void page_kasan_tag_reset(struct page *page)
-{
-	if (kasan_enabled())
-		page_kasan_tag_set(page, KASAN_TAG_KERNEL);
-}
-
-#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
-
-static inline u8 page_kasan_tag(const struct page *page)
-{
-	return 0xff;
-}
-
-static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
-static inline void page_kasan_tag_reset(struct page *page) { }
-
-#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
-
 static inline struct zone *page_zone(const struct page *page)
 {
 	return &NODE_DATA(page_to_nid(page))->node_zones[page_zonenum(page)];
diff --git a/include/linux/mm/page_kasan_tag.h b/include/linux/mm/page_kasan_tag.h
new file mode 100644
index 000000000000..1210c62170a3
--- /dev/null
+++ b/include/linux/mm/page_kasan_tag.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_PAGE_KASAN_TAG_H
+#define _LINUX_MM_PAGE_KASAN_TAG_H
+
+#include <linux/types.h>
+
+struct page;
+
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
+
+#include <linux/kasan.h>
+#include <linux/mm_types.h> // for struct page
+
+/*
+ * KASAN per-page tags are stored xor'ed with 0xff. This allows to avoid
+ * setting tags for all pages to native kernel tag value 0xff, as the default
+ * value 0x00 maps to 0xff.
+ */
+
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	u8 tag = KASAN_TAG_KERNEL;
+
+	if (kasan_enabled()) {
+		tag = (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
+		tag ^= 0xff;
+	}
+
+	return tag;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag)
+{
+	unsigned long old_flags, flags;
+
+	if (!kasan_enabled())
+		return;
+
+	tag ^= 0xff;
+	old_flags = READ_ONCE(page->flags);
+	do {
+		flags = old_flags;
+		flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
+		flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
+	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+}
+
+static inline void page_kasan_tag_reset(struct page *page)
+{
+	if (kasan_enabled())
+		page_kasan_tag_set(page, KASAN_TAG_KERNEL);
+}
+
+#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+static inline u8 page_kasan_tag(const struct page *page)
+{
+	return 0xff;
+}
+
+static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
+static inline void page_kasan_tag_reset(struct page *page) { }
+
+#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
+
+#endif /* _LINUX_MM_PAGE_KASAN_TAG_H */
-- 
2.39.2


