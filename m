Return-Path: <linux-kernel+bounces-520060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2CA3A52D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2574188AD42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEEA1EB5CE;
	Tue, 18 Feb 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRpIBtuh"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28417A310
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902652; cv=none; b=j7CoQVsmQZRsLNAk9ZWethT/FgoqI0vN0kMrvEnjNgBOKHbLVVZ86wdx8nLw0MNvd4+o46dUzJXxXVURpSoKJm8r1jf9q3hARWbIDeqs2ICgNZS4VvD0NP1C3a1WDJUH3CUGh2TwFKEmuob2VJ01yjzz0NTXIPt/XmabPOnWVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902652; c=relaxed/simple;
	bh=5zL2l5B15glN9c6rmEe90AE+smdcgUZ4Fy8JkQI8tvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2vYRysml9WBu4YeWqxMUBs5STcUAXOHPaEhsG+SApQDTTHJgQNJwF2JOy5DNCq5oe5ZuzDYffHzXCFlsWikcdNQjeyxV27bJHajQhKDhGGDa5LCgpuEETVTAIYxrTVTCTLild6n7Hn1ReIefNaRcwx7ZJecjdmI7AdvZGCT+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LRpIBtuh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220cb5924a4so186589825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902650; x=1740507450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqd9IxTofwawmp1dYCujhov0pMRv31D5VOrM7Wa0ZrI=;
        b=LRpIBtuhvF4lKRSaSSZpi9FfwiKkLmaLIHvW+/DvYZt7kqzwtxxP2B3DE7uXvDUI9U
         XNDt7UFLO+VTDbcM+g4hyxoVX+oGUwStTDkhEABK14zZVqLovumMGGmcrvrtpqXi4dXH
         64FymQAihlWGw4Zal+znfAu/OqK85NnKVdDc/GRNP75LQ6ksDiFIk+p3hQoSpJos8I5v
         xY3tY9GWR//ApG1Z6DmybbMA+M66DrgZMVpyuzh5mNZeh6o58Q3QJvstnH8MrKhl2xw9
         slE/Gn8QzlGAtvWqW/OqwN0hdgUFGezzjt3lV8Eg31sxgNR4WGlZNAXWR9lQwqe9025Q
         Vq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902650; x=1740507450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqd9IxTofwawmp1dYCujhov0pMRv31D5VOrM7Wa0ZrI=;
        b=IT16SDkISb6U5bmVFje3EOF6+px5nYUk/GlOayP52inKeBtPBaKIDp/Cdw8BxQ6auX
         j+jSD1JYANCBiJ6u/E9KK4g9QDT6paYbbERB+QZNlCWU5Q1y8ANxUGyG+Ek6A2rXgfpL
         61hSHmhK+AiEy+yoRJ0Oyfez0RdMxKwoV1sjIP8RZztewrnR+Gd7Jy2YOsEmJX7OksFs
         fA5PcGDBsxFL4l8dlm5lfSKr1fHmEeNjneGdC5lVk4lACXhRGKYNkh+H85nS/o7zBSaa
         71TjL5/UOOO4RlIYQi3d+ils/lSQp7hUZc+vazn8YbFST8mmG+1nnbnHDIjajuVA41kc
         zX4g==
X-Forwarded-Encrypted: i=1; AJvYcCVAFJcuFHpwIjACm+lHknsmNYj/WmlzdPtwdXezbmEaUE2w8zKIqdw6olc15Eh0HayOq/ucP3wdzeLl+uE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iqbaL049VMSRak7Wxk+BthS4V0RlJ+x86Q55Ymss9wNnaQBq
	q6ZZdQVnVMBi+pQZQ6SwJj5L7AsHb5OfbDLnY+E51qdJIj1xT3FBNel4/clIqDy480fFNg==
X-Google-Smtp-Source: AGHT+IFjTD0B6vnesK387z7IZw++9KQQ8VuMcl6CQdkIwwGo2IRYNL3TOstEEppR/SOlo9oZvDErqS3A
X-Received: from pfva19.prod.google.com ([2002:a05:6a00:c93:b0:730:94db:d304])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a6:b0:1e1:9ba5:80d8
 with SMTP id adf61e73a8af0-1ee8cc162e9mr23545819637.33.1739902650491; Tue, 18
 Feb 2025 10:17:30 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:43 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-16-fvdl@google.com>
Subject: [PATCH v4 15/27] mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Architectures that want pre-HVO of hugetlb vmemmap pages
will need to call hugetlb_bootmem_alloc from an earlier
spot in boot (before sparse_init). To facilitate some
architectures doing this, protect hugetlb_bootmem_alloc
against multiple calls.

Also provide a helper function to check if it's been called,
so that the early HVO code, to be added later, can see if there
is anything to do.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9cd7c9dacb88..5061279e5f73 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -175,6 +175,7 @@ extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 void hugetlb_bootmem_alloc(void);
+bool hugetlb_bootmem_allocated(void);
 
 /* arch callbacks */
 
@@ -1256,6 +1257,11 @@ static inline bool hugetlbfs_pagecache_present(
 static inline void hugetlb_bootmem_alloc(void)
 {
 }
+
+static inline bool hugetlb_bootmem_allocated(void)
+{
+	return false;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f9704a0e62de..ea5f22182c6e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4906,16 +4906,28 @@ static int __init default_hugepagesz_setup(char *s)
 }
 hugetlb_early_param("default_hugepagesz", default_hugepagesz_setup);
 
+static bool __hugetlb_bootmem_allocated __initdata;
+
+bool __init hugetlb_bootmem_allocated(void)
+{
+	return __hugetlb_bootmem_allocated;
+}
+
 void __init hugetlb_bootmem_alloc(void)
 {
 	struct hstate *h;
 
+	if (__hugetlb_bootmem_allocated)
+		return;
+
 	hugetlb_parse_params();
 
 	for_each_hstate(h) {
 		if (hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
 	}
+
+	__hugetlb_bootmem_allocated = true;
 }
 
 static unsigned int allowed_mems_nr(struct hstate *h)
-- 
2.48.1.601.g30ceb7b040-goog


