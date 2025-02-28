Return-Path: <linux-kernel+bounces-539159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6FA4A19E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16BA17624A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4318281370;
	Fri, 28 Feb 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL1Jw8uk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5827603F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767406; cv=none; b=GoLc0HS6duPy9/KJ68+rzka9OYj0o1WmIpTnfSoneEgSI01+MvB9ttorJ8NExhM6RZBUWvUTTlXqFvFmaASax/2LaXUzI94vEgeQ7egA4MhH1S19uZRnuhGNNIo9PfgVxp7ShtlOLtDGZ0d7yip7jjwskzC3pkjHjzEovlPL35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767406; c=relaxed/simple;
	bh=UUAz05wEFnezIXvRTahNblvNZ7OUEt19we6LGHXdN2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KB7ynh3Vs/K3Th6IoO+3BqktUBmtkXKggUmrmxKF+CGiTgMiq9m5j3JsPP8nippjH0ASBkWAgLJECjWsCadboi5a/MHL0wVFpE2X+mMvt746yu+rdyuYpw5f5u3vkYYS0JwmzrquftffR83AhbXTizV1DHl68fZdre85byiQesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL1Jw8uk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fed20dd70cso427076a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767404; x=1741372204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hj109oq4/9DdjGz6HODDxStLMga0lyJyfx71i/zQohU=;
        b=TL1Jw8ukHtw5GPd/ypR7bb1Ysp6vZqwQEazJoMFbT/7vq+eJ9JIYZ5ixTsjUwYMSXW
         XorFmq6nFgbIiqye4lBHfm5vOT+Vzswx5Roqi64Qlnw9vp0UGXuMhF2aPppkV1zqs6+N
         8QCjtB9rLIC221sPCa5DQM9Sqz5wCe6BDjSwXl/+waFLkDf87vBlDyOIlfmptBL5bsG7
         8n2KRD6wHR4IWHMLZHT1qs1xmWKwNtn1WnXEW32K7kCEO6x9J9w+FZ+gKcNlYYHU7s7y
         Iw0QEQJJA27raqmhint2jPVXbxKd7tHGOvz5dIX9/RCtR328qJiOWn5Dz9vL5JiYG3vD
         yAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767404; x=1741372204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hj109oq4/9DdjGz6HODDxStLMga0lyJyfx71i/zQohU=;
        b=lKdHKsW5vgopVWFWXQOMWrTkeAnILmbDr2LKdb2X9W2Uf5zUXHcgd2r+D1PK+ttQnL
         tbktYcj8+LfkQSsP5nkSpqeyL1EWqI4kIFb7R03ja1FpDqE2mCoq858o7AMWSu1q0KJg
         0Vgcmmzt/UIoRqLiMe5gKN72g4YkNZ/GQS9AYJwFBmR+wKb2mpGLbYhrA7bPXy0WuRhs
         CaCI4pWGf/zW+KHOrw7eGSqcd7FniPlLjg475XCZ042FRj+LFwkqCQoa7lFto4sM+a/h
         cF3c9GWJ6YzBc9YA0ExzHM+DnbADRNfFzyWlzdKoED2exDohrTo4e0B3T1Qr86ArtKBM
         Gcnw==
X-Forwarded-Encrypted: i=1; AJvYcCW/VNZPUGinsH82aob23JKm9bKeICkx6l+gmtytk6R8UcpxvihVdUzeDxM+BQoX9xEqqKWeJlivjGP8WL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMEnQUQPHTSGWuA1Ey4/RBfIc9Sk9QuQirEGYvVtELBPka2YcP
	SVy4sT2RLPVovOLL+e8KD0oWqHJ4ghusN1nxFQ8UxkD92IJWg2LNjHqTBYEvId2U2Evq0g==
X-Google-Smtp-Source: AGHT+IHtRop7g3Onw3l9wZ1xBsCGhgyKFRwX1qlsiqvWyIrnE5Bj3EWSAy2ByEB3fvrSkioLhcNZQOAu
X-Received: from pjblb1.prod.google.com ([2002:a17:90b:4a41:b0:2fc:1158:9fe5])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8d:b0:2ee:48bf:7dc3
 with SMTP id 98e67ed59e1d1-2febab7862fmr7705039a91.15.1740767404053; Fri, 28
 Feb 2025 10:30:04 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:10 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-10-fvdl@google.com>
Subject: [PATCH v5 09/27] mm/bootmem_info: export register_page_bootmem_memmap
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
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
2.48.1.711.g2feabab25a-goog


