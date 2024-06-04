Return-Path: <linux-kernel+bounces-200323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A618FAE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4991B20BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3674145A0C;
	Tue,  4 Jun 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DFpQ9JUh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645F145348
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492165; cv=none; b=ggh4jiE8EI2IAcN//0l88G4+IvKIm6hCufmemQoGYcYFoKMqLxfOJLoIfyBvsVbOwcCJz2VyK8FthFpQnIa7aps1uBSSN8Tp0VWeCWjtTq2hanSMuF/lBEHEGLqpnWBZCDvGuy/UsrPCOoSYsp2a5/gHC8mBTRbZQNft6XLgixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492165; c=relaxed/simple;
	bh=dlTQMSRsIpZjRzOd2Rm/WzLiyJ/xHYiubGPGAJZf/Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaLNFgLdbrHcCuenbhZB/Nm6omWPfdT1WOP40oNhuKXXU5LA8l4VoyvC7DPM5tEV7PUxT0C3UvZeun3iclAWtJ8dThB71IyGLjTlsqrMX/RDVpeNbKvztGXHW2uazJ/OdNOxVpGyrxsXp9CtOzf/7gZdccEWf7wGVCB+Btrx7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DFpQ9JUh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6267778b3aso466698166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492162; x=1718096962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o8h4WW2rkKyKPUI+a/gz6b5mzKTaMa0Q8zXDVfDCoM=;
        b=DFpQ9JUhBl0RMW0QGCUXj4K+RHRw1bbbX/B4wJiik5W1sFw4RQwnGk/Iw+tr6v5iue
         Qo3Fju+QTrvlEA4RsLCzuJ4T8XZ905S4sCGdRO4S3lW8iYbWvKhftBtm+voEDRhKjsmh
         UKY4QOWVqmx3dFmJlVTNHKnl/QVIy72QktpmgVj6nadHPQYlR81vj2q1iaWhm9CTFF8u
         8XCwljG/dgtNquOPWVImWybnlyLJlDBpYOoxC2yeh0bEoUOK+wuS+4ONN5uWp2YmVm9y
         pfGZu/gn2DiFVZB6+U+5K46TfqXmIqqY/i6hNe3/843S0Pn+avShLZWu4Rvnzv3EuyTu
         vnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492162; x=1718096962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o8h4WW2rkKyKPUI+a/gz6b5mzKTaMa0Q8zXDVfDCoM=;
        b=VO0aX166hLEQjOHYqvgUfyBhAdy2867kFPZiIybjU77wOi9mcBN2L8GPJNGABs4jde
         JES7/o/pPa5nFkjvXBzcUVjv3Oh6rqFcFoIzNuosDOGEw+fQ7sN3HcEqhg2PChsyWIaF
         Lo/XxGFbj7RFTyKTNq2DwDqpahZQgI6lmSkKahrEInBljsjZXoNZ6zjrp8zIyUb+wS3G
         tMapSJF0+04192irUkoTs7tIrDeBWAHX1iIpcdPUQADEctzOv7kjEq7pXqscNa/xTg6o
         v8WpSNWKa07Ug4iDC8A07oplRGFwcWqjSUqqAsHMskKpZmT6SIw0DOYLj22+BKjwtqVZ
         fqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnoNEpKkdf98lqhB/xv8vThztvIzJnjic8PfsQmbd9ddtXnMYs8J+HCcsuSgAJi7l1iqnAHpCG+cdsKg5AvhaWYf+aPm2YD6RQSfJM
X-Gm-Message-State: AOJu0YwE0pPTWpv8Ekon8IdfH6wF5yFBWi3UUEEgnH1ktOngHouw95Wx
	pZ851KclKAcZyRQP6/tQt3oxsrdWf2aNhNuFtvt3umebHOQcIgz2VYZI4Sj5+G0=
X-Google-Smtp-Source: AGHT+IHcBCOnI/AP+4Gs+A9GVqIIvYfhFKwdpV9/+hIkLKh+cjnNIZ7LwpLVGv8+f7nFEA7iDEBeHg==
X-Received: by 2002:a17:906:40d8:b0:a68:379d:d623 with SMTP id a640c23a62f3a-a68379dd799mr735700466b.36.1717492162204;
        Tue, 04 Jun 2024 02:09:22 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:21 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 13/15] linux/mm.h: move is_vmalloc_addr() to mm/vmalloc_addr.h
Date: Tue,  4 Jun 2024 11:08:43 +0200
Message-Id: <20240604090845.2182265-14-max.kellermann@ionos.com>
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

This is needed to eliminate linux/dma-mapping.h's dependency on
linux/mm.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h              | 25 +------------------------
 include/linux/mm/vmalloc_addr.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/mm/vmalloc_addr.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e178bda2525d..6c9089adbb4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -9,6 +9,7 @@
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
 #include <linux/mm/pfmemalloc.h>
+#include <linux/mm/vmalloc_addr.h>
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
@@ -1087,30 +1088,6 @@ enum {
 int region_intersects(resource_size_t offset, size_t size, unsigned long flags,
 		      unsigned long desc);
 
-/* Support for virtually mapped pages */
-struct page *vmalloc_to_page(const void *addr);
-unsigned long vmalloc_to_pfn(const void *addr);
-
-/*
- * Determine if an address is within the vmalloc range
- *
- * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
- * is no special casing required.
- */
-#ifdef CONFIG_MMU
-extern bool is_vmalloc_addr(const void *x);
-extern int is_vmalloc_or_module_addr(const void *x);
-#else
-static inline bool is_vmalloc_addr(const void *x)
-{
-	return false;
-}
-static inline int is_vmalloc_or_module_addr(const void *x)
-{
-	return 0;
-}
-#endif
-
 /*
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
diff --git a/include/linux/mm/vmalloc_addr.h b/include/linux/mm/vmalloc_addr.h
new file mode 100644
index 000000000000..86ad2dc94960
--- /dev/null
+++ b/include/linux/mm/vmalloc_addr.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_VMALLOC_ADDR_H
+#define _LINUX_MM_VMALLOC_ADDR_H
+
+#include <linux/types.h> // for bool
+
+struct page;
+
+/* Support for virtually mapped pages */
+struct page *vmalloc_to_page(const void *addr);
+unsigned long vmalloc_to_pfn(const void *addr);
+
+/*
+ * Determine if an address is within the vmalloc range
+ *
+ * On nommu, vmalloc/vfree wrap through kmalloc/kfree directly, so there
+ * is no special casing required.
+ */
+#ifdef CONFIG_MMU
+extern bool is_vmalloc_addr(const void *x);
+extern int is_vmalloc_or_module_addr(const void *x);
+#else
+static inline bool is_vmalloc_addr(const void *x)
+{
+	return false;
+}
+static inline int is_vmalloc_or_module_addr(const void *x)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_MM_VMALLOC_ADDR_H */
-- 
2.39.2


