Return-Path: <linux-kernel+bounces-539166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4EA4A1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D9B3BCF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862D27605D;
	Fri, 28 Feb 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZAYTcGW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BC1F09A1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767416; cv=none; b=Z8S6Qc2MFrfmKG2u0T7ompeDvzjgdLoIYdAcdocDB2UioRHOzDUijRWJXPPiESzOq9jtGenPYomEQYPSkd4pa3K4abajB7S5L3pHnDoW3LcNneFQf17teI0buGCgNFxv/wJO1pDTCyoFx3xVE7zGijgjX/DV4UpgTx6GGhq0YEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767416; c=relaxed/simple;
	bh=n8ooIlwvuqYrq6tlu5NBzw5tNXbGCYpJo/0nrKRGQbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s+zdXhZxSziniqd+Hzg3qX+NAnBU7k6WnzMbCcVnrwFEVPkZGzBHSS2MO3/A/2d0+oXlY9PqUULJAIIGLfRDbJ2WP6BV1Pf8TNrJKFhlbig1d6bN7gf+DCL8j87HlVpaXjuenxYUGIaPJqMtqR7OKUeI6I1Zwz4S8LdoXfIkW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ZAYTcGW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb8d29740so2892143a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767413; x=1741372213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zk9Htkr8Yt0AZQiLc51J5q9c0jXDbJ3jlcXbWrZj33Y=;
        b=4ZAYTcGWWErA2WVfTMmfQrtQwbdpBlUxLy7MRapusLY4mLm+VbVeP3OuB7YpASodZJ
         aUWXXYsCkdh4GaF8nhxNAd1FQ1w1LY363eG1PnYiXcZdRO1XfCFokjQ1ii11/KBvw9x2
         MqWJnY9B99FTL/uIIAfpkIbyZITzHZN05SbR7SYLv/JZLQ8UvWXYClnXvIxLDfu9hM1j
         OrfMIIkdMKk5QgnWrpVM4tFXeq+uI+b0PregEVWrxkcgzp0B0/ooydFjztlg91onO28j
         mUe0KuqNT7k5speQMBV0fAAhXllrcFlDvOakjEUmlqUOs9LpuRx4o7Avr4iBxnOm35Ai
         difQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767413; x=1741372213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zk9Htkr8Yt0AZQiLc51J5q9c0jXDbJ3jlcXbWrZj33Y=;
        b=t2ts+95tozywAK0OQ5QKC3BheH3Xo5EaR8sjy+gY7rSKb/VUGX2MF7+agR4sNGwyw8
         3+LQXPwcCUSn6XEuVENQP9w3XTSE4nGrnNelP54vpdfq2C9Cpchg1RhL9XvtAFHJWuK6
         yMM9YKpOznPBcAyh35SHnCH5SbpadW6JR34N5FpUWMF2+edtVEUssutK7FYtakmo/kSy
         oGjtTsQYILa49EshIGCEVjrvVKzqiixAQARtpEmhyfLcGJwBVYIhPHqKp3TA4VQ1YJH9
         WL5nwJM87tpBAi7ba3963Arcmb9618OlPToK6XIlmkzETZIyKaWGP+aDZXe+uDaMf42f
         kJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUNDX3MW46Fr+7Yw8I5N2J8KQzH69SNnUNGR2xRaG+j/GVEBFgaq39U3lHd5iH8Bq2ZXQiJLQlnA9rw2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZDpJ1iAJz6coud7k9FE+qVB8Fw7zJiILEyX0wQc1Te1wxUGh
	YaLUfCr5W6e6J7FWylbDAsWKaQ6yzWcjxTEx6B1qqnR3utSx4oIizA4L4lA4OUBmVYvkoQ==
X-Google-Smtp-Source: AGHT+IEv+QN7E0eQvDAjJvrjNKcnw7M4fyJS/kvcrVF43N89A8GZT3t7+PIL/4t4nWbs737dFUx4stCK
X-Received: from pjbee14.prod.google.com ([2002:a17:90a:fc4e:b0:2ea:5469:76c2])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3803:b0:2ee:44ec:e524
 with SMTP id 98e67ed59e1d1-2febac0a7e6mr6645676a91.35.1740767413637; Fri, 28
 Feb 2025 10:30:13 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:16 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-16-fvdl@google.com>
Subject: [PATCH v5 15/27] mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
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
2.48.1.711.g2feabab25a-goog


