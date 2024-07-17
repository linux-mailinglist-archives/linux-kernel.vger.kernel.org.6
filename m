Return-Path: <linux-kernel+bounces-255545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0479934214
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF05A2834D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600511836FC;
	Wed, 17 Jul 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d55LaEwt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762418306C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239967; cv=none; b=KfIs48pCPzxRmagSNNggx+S7eQhIFbl6eU9XsfwsfJHRbNjd3qhgWjno0VaklnGUjvTm9u1m8c+ySKe7JLXOF6fvqx/bx3h3PsU0MTgeUEfn+tmBXc8hNnf+8TvLtSXCfcInasYEthBh7Sg5dBIJZ6CldAWu0FcNl3nmMpma91o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239967; c=relaxed/simple;
	bh=eOoyY03ECvdG+gCfdsL2oTy8DwStzbkeFsDwVfyEJCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AqiEV+oveNO5e/1dDLrKy+0v5ekVEGJB1KvAHbz1eHknVFzPsJ56q0nIb+5FFSYZGFe+qKSOvAVLNFZc2MDZl+ymb3Z2NfDjTYQ+xGtbXdmrZsb7Njp4WLPGlxCFU4jDw6Zcxf1WeGdlzhSOi9T7eVxn+8vz3P1m6DesMjsi8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d55LaEwt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03b3f48c65so206395276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721239965; x=1721844765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ygXA0XIa9xBbp7z6zKTfYsdLjjMC6FzyRil3fs2y+xs=;
        b=d55LaEwtc1818TsnxDvBW+49+BCbHeUmDmId6fhX9OXQ4gaGxZrnxPNH+n16U4g+Xv
         MmAFSooyfKAvxnLhERBjdD+eIgd+h9Icsuh8MF5368oLFu6Q8iPYDb/EbvD1TeLkUqYe
         A/XyXDZN1TfHQJfPh4VHEW1sShO7AwFtVlYQoRTw75ouO79aPg/Xx77Yletq5JYmLVsg
         iCu5pLoTUiZ3gZCVo2bsTfN+Q3gLSaqpQdHHPrla63joiftavuDzgXcGKhdFRpPopEBj
         iezSfGGzMOdJm+OuPnQtRvGmmy1mbBg5JuuWWpZV+ce+lfEZQbsvbC7sn1DiPSU6dv0J
         SK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239965; x=1721844765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygXA0XIa9xBbp7z6zKTfYsdLjjMC6FzyRil3fs2y+xs=;
        b=UwGsunKXtdpLppfVpMr6b9dGh7pgRz8bpZixRnmui623U88NvLMYxXvD7/LwyBttiU
         xBxcFdQdE3uiBaMwDM3/epCifVFhKjr+dyRzYAask7TZwRg+87Y0CmlKIiBN7UoDfVf/
         wGzoKFztqJCKVGiB+laep7NzEEKDKyhZOSByvo8sD4NRRJH9Q2sZbDHGxnEQj68FMQD0
         wUvTL/7uH4BeOLhuCzVbU3UJy1fhq/YA5ujJ8DW+k74bk+AXmxHQ66SRHl1BN+wmgHWZ
         7fNTvOHVuwv4KDRaVxlJRCExnAxV29wCYMmJopIz1ZTNkd/cXLzdOYaqk95SKlDNJAmD
         OfCg==
X-Forwarded-Encrypted: i=1; AJvYcCVDXVuhOQjep1imXQsmfq4jxLt/bxpbYTPb3wairM3b73WZlpylAp20/YQr0QkZ7mskzNk98QS32AoNYBUMe8RC31YNv1/T4/6YF5jR
X-Gm-Message-State: AOJu0Yz4UzJCbMx0HqmXKUZGm53GfvbAwsI6JvoPa4QXWTItKqfXUGxD
	mLMvYP8sgZhelglm7JYTTWsaYScV0Nx17VPV42p/IjyQj3dxiBOvnsb9zKWyhFnBRmwfBxBJpHV
	6lA==
X-Google-Smtp-Source: AGHT+IGa1owAr+/QUJsrv0druT/r58eUd+kkgRXi2LZMu6lmkvI/Rv/vL7MKUayeWR/KwZcz3SEeOV6KLbc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f44b:e467:5c7c:74ab])
 (user=surenb job=sendgmr) by 2002:a05:6902:72f:b0:e05:ec8f:b497 with SMTP id
 3f1490d57ef6-e05feac7896mr533276.4.1721239965044; Wed, 17 Jul 2024 11:12:45
 -0700 (PDT)
Date: Wed, 17 Jul 2024 11:12:39 -0700
In-Reply-To: <20240717181239.2510054-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240717181239.2510054-1-surenb@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717181239.2510054-2-surenb@google.com>
Subject: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Outline and export free_reserved_page() because modules use it and it
in turn uses page_ext_{get|put} which should not be exported. The same
result could be obtained by outlining {get|put}_page_tag_ref() but that
would have higher performance impact as these functions are used in
more performance critical paths.

Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]
- Outlined and exported free_reserved_page() in place of {get|put}_page_tag_ref,
per Vlastimil Babka

[1] https://lore.kernel.org/all/20240717011631.2150066-2-surenb@google.com/

 include/linux/mm.h | 16 +---------------
 mm/page_alloc.c    | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..b58bad248eef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3177,21 +3177,7 @@ extern void reserve_bootmem_region(phys_addr_t start,
 				   phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
-static inline void free_reserved_page(struct page *page)
-{
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	adjust_managed_page_count(page, 1);
-}
+void free_reserved_page(struct page *page);
 #define free_highmem_page(page) free_reserved_page(page)
 
 static inline void mark_page_reserved(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..7d2fa9f5e750 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5805,6 +5805,23 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	return pages;
 }
 
+void free_reserved_page(struct page *page)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+	ClearPageReserved(page);
+	init_page_count(page);
+	__free_page(page);
+	adjust_managed_page_count(page, 1);
+}
+EXPORT_SYMBOL(free_reserved_page);
+
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;
-- 
2.45.2.993.g49e7a77208-goog


