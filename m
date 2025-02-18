Return-Path: <linux-kernel+bounces-520052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A196EA3A521
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB611738ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F027FE9E;
	Tue, 18 Feb 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5ss3XVx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C27FE72
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902643; cv=none; b=m5Q3HbOlu6wBQqCY8V8JEruydMPehplrG5CSHq9VObPfdJ77KQ9/9NUNbb6RcnpajUO2Q32xTJGRox6h7FW7Glpo2V0k0GA/Cqasme/KcNf7vGnoGYjBP7T/som5hgMmBfWHsCkKygTL9JiQO5bUklUBVG8pmuYENiTxZDxbpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902643; c=relaxed/simple;
	bh=4DL6xm0WyAaVe3kNTcE3vx1Mgw6/YO+ytDXdSWY4t2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+nSbGX7jwiNYX4IFkp3Lccb3dAFjN0Ese2edVKK6ns4n07FmHkIaU0LJh0BYdty21/oke82eLEj/c3BAEYhXAXv8ZP7ZC1E+wJsetbdu1ac79fb6gTlQz/YKxl6ZGnj76sWNfBoqgBXnNaxp2wL1h1ZTe/+T9Qr8Kv3C9G02oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5ss3XVx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22101351b1dso70695875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902641; x=1740507441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0IhpG73Mu/sy6kJxwk08UujlGc0BKXNAJxBD1Va+9I=;
        b=w5ss3XVxJBddOamGmZ8E1WsNNUbZKGtfAJDdCYMCgnkJBiTsb5zvF1ufFpRPGqCkNx
         UWTTUSkHk24Fv872bMGG66bOvIJGxQWtXmK7a2s+MzalpY2rEgHhGaYM4cNYCdPnm2nJ
         ulcHxMmiKLuul7kkyk1y3FwC+KKZpnjWg8Vx9UJo5YV6G3a/1I4bOfv3YBCw4myRiOnH
         xv7nC3FVgBEN9YQF7kGM5mNCKD4TBSK+AdDU3kXuyLQpISfroNXbLXAquL+vSV/QDgoL
         u6INtO0RwQu3qiBOjL+PsxtL3MrJyqrm5dAv5eU9ESf0BM/c29/KFu27SfYgarONDYxR
         qyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902641; x=1740507441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0IhpG73Mu/sy6kJxwk08UujlGc0BKXNAJxBD1Va+9I=;
        b=lRH0TsKr6VxSYjzM6xrAK0hYRqz43bi9JIFW9MDaCIGk9/AaaoPBhurtI0kCFWxfuA
         jh1hqgw8ASVrXX49SaUgQJFhc3aJ0FID3RO+vCkZ4lac5dIw0hwTJmG4afWEoAE5bYjo
         Vo0UAg45DzvOspeuAl72t62kimOMf18SwQXlFJwsyQIC5ggdkIVKYhVKNcmmJcTST7zq
         Y8gUpwsHsKkIeqZ4OdZfWF6ZKKpQuysQqjSxMkc/xqAxHq3eP2yj6rJ4BSqYPz6CLbtY
         S8zAjdCyrKZoACjnrZ9uWCFV7z/qjZ+YOUOFSqGXvOI14bTnxr971Tx0d8Q0KRS1SQdM
         TYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWwH5DRAJ+Dak0CGznMEAqV3vxrEe+3Aldu/8zAyNs4+Y1ERMrctr+3qM78FiJCSGuzOeScNm8DMWIuUzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVb7xT25xKPYxLGUqozi6CQBDjaaaUf3YrevJjjZAS8Hr3TFQT
	t7IfYuCTqZL4eobEak9JRdtybY0lzLf7KusWJO91dcqh1nlh/gy4dEPSNYwcBj6fpSmAag==
X-Google-Smtp-Source: AGHT+IHIdBPoxWjU9UROtCoNBXFA8FwC/QXY/IFjY0j7H4jQuSn/Y/LKSiDgq3UeDUo+hwamke9lbkTW
X-Received: from pfan14.prod.google.com ([2002:aa7:8a4e:0:b0:730:7648:7a74])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:138b:b0:728:e2cc:bfd6
 with SMTP id d2e1a72fcca58-7329df01493mr426974b3a.18.1739902640911; Tue, 18
 Feb 2025 10:17:20 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:37 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-10-fvdl@google.com>
Subject: [PATCH v4 09/27] mm/bootmem_info: export register_page_bootmem_memmap
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

If other mm code wants to use this function for early
memmap inialization (on the platforms that have it),
it should be made available properly, not just
unconditionally in mm.h

Make this function available for such cases.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/powerpc/mm/init_64.c    | 4 ++++
 include/linux/bootmem_info.h | 7 +++++++
 include/linux/mm.h           | 3 ---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d96bbc001e73..b6f3ae03ca9e 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -41,6 +41,7 @@
 #include <linux/libfdt.h>
 #include <linux/memremap.h>
 #include <linux/memory.h>
+#include <linux/bootmem_info.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -386,10 +387,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 }
 
 #endif
+
+#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long size)
 {
 }
+#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
 
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index d8a8d245824a..4c506e76a808 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -18,6 +18,8 @@ enum bootmem_type {
 
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
+void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
+				  unsigned long nr_pages);
 
 void get_page_bootmem(unsigned long info, struct page *page,
 		enum bootmem_type type);
@@ -58,6 +60,11 @@ static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
 }
 
+static inline void register_page_bootmem_memmap(unsigned long section_nr,
+		struct page *map, unsigned long nr_pages)
+{
+}
+
 static inline void put_page_bootmem(struct page *page)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..6dfc41b461af 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3918,9 +3918,6 @@ static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
 }
 #endif
 
-void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
-				  unsigned long nr_pages);
-
 enum mf_flags {
 	MF_COUNT_INCREASED = 1 << 0,
 	MF_ACTION_REQUIRED = 1 << 1,
-- 
2.48.1.601.g30ceb7b040-goog


