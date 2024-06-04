Return-Path: <linux-kernel+bounces-200318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0378FAE65
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F340284A01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055B143862;
	Tue,  4 Jun 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NLyYdngd"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AC1448DC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492160; cv=none; b=G2rU3TjX4ht9gk8tkUKxat40s+18FB6vL9r61hxZ4tEzJfOebU1uJMnKJCXHkkOu5SudxPJNcKe9J8V75e+8xbxLIbDOZ8IKSiG89WpqHiD+KbmJ+sabaJw9qF/KaHQnk4g96W+KHAmTXcujChl/KmNUyrGi/aEkdt4SWRC840U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492160; c=relaxed/simple;
	bh=6CsVTNav/2xxEWRFZ4+7NyJK7QkNGv4emu58fxOVnhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYvNY9mXCWxH8qpjkwTg46jYEmjO9Rb9AB+twQqy9U0B87kKJqQBhPp8XT1zypJtmS/qyPBXY8TCatWDwuFncVaFu5pfdFQYkciQQk8+io3CsJE2TifXSYw0znlwAeTdNTe4deb/IkQxLWuB5hJQC3fPktj2DlSI0uN0giiTemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NLyYdngd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a50ac2ca1so3261522a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492156; x=1718096956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOL4vXuZ0a4PoiG22TiWEmdORRFE9U+5xK6xKS6y2zU=;
        b=NLyYdngdQ635dsixX/j4uc9LIreyNhPsO8CsfZywJEcY4baMgxLJuwCBxkl27HgLp5
         w5SivYR/qXYomWcOYmpmp+AC7xhJdzVuPYSUHz7GjALhar2xRfDtF5odBSuB9bLpkWws
         5L5lKz8PJz3xJh/qAGEHZEO25LjUPmkezahbIenkyt8AW047ZlwdQG3OZIKPazuRN9o5
         c8L+8ipkGOkKcRC28UNc378y+SMtuS51CBmQJCqfZ77BNfx7acu/o1bl21c56/BXF2HQ
         bFu37KhqKVAOyPh6qDoSzw9vJky70HRml7rCF+w169p9rN0f1doY4O+WUolSnCsPy48J
         710w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492156; x=1718096956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOL4vXuZ0a4PoiG22TiWEmdORRFE9U+5xK6xKS6y2zU=;
        b=e3rqRiaxiCpiQAYskisn1kxlABgUuC6P1JnieJwzm3CHDHJ9ySg8pOB5ZOCgZx7KE6
         r6jocj8g7E3xwJb3zrVSoETbCOLhHRFjmRRTkI05ZTjs/vsEn+xnf3hTlCV9ZrS/JTXq
         hdeyMDiXn20g3EgcGab0yFlAbvGOqj/Xo8RWt/1POUvbiOIMCFwyD8QSpNYj87KlYOk2
         Y2M6K5MZQguhkY0RPiSjrtOcVNKi9tqfhpQyXLFQzZ8YpYT9I8+muxLBakJPZsFr2Fdl
         h7gdQZbeFC0TChuZAOkA5SOZxs+VgN722xEcPSXcp5a7AIdUa6Z8OX5Ot7RUTxonLHhJ
         1dUw==
X-Forwarded-Encrypted: i=1; AJvYcCW3cYp5ejN2apw9HS/0gyIWpItwjba6xKkWxdDPoOlHB0AvOldLmjKgPjdR5y9wMqBHzrMjNNiDT7tClBcNMtS+c2XV7Qj74L6tZRRj
X-Gm-Message-State: AOJu0YwrdqFSL6S9T1jcCZlgaHr8OvRe3IFhWeVXZ8YbK3h9axw5x8bV
	AjvDxX2sIO3wlfWJnVrFBl7x6qcSpMBAXctv7pR6xTe8BaBDm2xrPQi8DKi8JTjU+B48zRiM6iu
	4mrc=
X-Google-Smtp-Source: AGHT+IHt9F2oYYdhVTvxemPiWIf8QKaB1WXTbOFaVE7w6l+bxeSDT0tJO0j/hkCZ7p0XgmZYIYi9Bw==
X-Received: by 2002:a17:906:6bc4:b0:a68:d2c:2a23 with SMTP id a640c23a62f3a-a6822049940mr757127166b.76.1717492156465;
        Tue, 04 Jun 2024 02:09:16 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:15 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 08/15] linux/mm.h: move folio_next() to mm/folio_next.h
Date: Tue,  4 Jun 2024 11:08:38 +0200
Message-Id: <20240604090845.2182265-9-max.kellermann@ionos.com>
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

folio_next() is used by linux/bio.h.  Moving it to a separate lean
header will allow us to avoid the dependency on linux/mm.h.

Having a one-function header may seem excessive, but there is hardly
another way if we want to distangle linux/mm.h from linux/bio.h.  If
one day, say, folio_prev() gets added, we can still rename the header
to something like folio_iterator.h, but until that happens, this
folio_next.h header seems like the best trade-off to reduce
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h            | 20 +-------------------
 include/linux/mm/folio_next.h | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/folio_next.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b11bbbdd2754..7be75960e7e1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
 #include <linux/mm/page_section.h>
@@ -1916,25 +1917,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
 #define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
 #endif
 
-/**
- * folio_next - Move to the next physical folio.
- * @folio: The folio we're currently operating on.
- *
- * If you have physically contiguous memory which may span more than
- * one folio (eg a &struct bio_vec), use this function to move from one
- * folio to the next.  Do not use it if the memory is only virtually
- * contiguous as the folios are almost certainly not adjacent to each
- * other.  This is the folio equivalent to writing ``page++``.
- *
- * Context: We assume that the folios are refcounted and/or locked at a
- * higher level and do not adjust the reference counts.
- * Return: The next struct folio.
- */
-static inline struct folio *folio_next(struct folio *folio)
-{
-	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
-}
-
 /**
  * folio_likely_mapped_shared - Estimate if the folio is mapped into the page
  *				tables of more than one MM
diff --git a/include/linux/mm/folio_next.h b/include/linux/mm/folio_next.h
new file mode 100644
index 000000000000..7016e303439c
--- /dev/null
+++ b/include/linux/mm/folio_next.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_FOLIO_NEXT_H
+#define _LINUX_MM_FOLIO_NEXT_H
+
+#include <linux/mm/folio_size.h> // for folio_nr_pages()
+#include <linux/mm/page_address.h> // for nth_page(), needed by folio_page()
+
+/**
+ * folio_next - Move to the next physical folio.
+ * @folio: The folio we're currently operating on.
+ *
+ * If you have physically contiguous memory which may span more than
+ * one folio (eg a &struct bio_vec), use this function to move from one
+ * folio to the next.  Do not use it if the memory is only virtually
+ * contiguous as the folios are almost certainly not adjacent to each
+ * other.  This is the folio equivalent to writing ``page++``.
+ *
+ * Context: We assume that the folios are refcounted and/or locked at a
+ * higher level and do not adjust the reference counts.
+ * Return: The next struct folio.
+ */
+static inline struct folio *folio_next(struct folio *folio)
+{
+	return (struct folio *)folio_page(folio, folio_nr_pages(folio));
+}
+
+#endif /* _LINUX_MM_FOLIO_NEXT_H */
-- 
2.39.2


