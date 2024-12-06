Return-Path: <linux-kernel+bounces-435552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7128C9E7941
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27F31888653
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484421DE2D8;
	Fri,  6 Dec 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuVsxbai"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6E1C549B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514524; cv=none; b=mkxzf7HacRlpdY23eBt12rZlssEcmdLay4Vqv1yQ0g0yQ12XPpA7+0u61qffTDs4gFkDxUnZPBKdYy4SHHbjA0pyAPhtcJV32wFaBxsc3S2KAxfNsa9PefwYzSTfZ/GAA2RNp2OB4URrJkSjvcCAPooB5IvbgaMGWvQotNIaBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514524; c=relaxed/simple;
	bh=y7xDByu9MPkBlucoz00880P1VUr0kZvziiLVTc+bB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjrKuv5V8CPM5Cd6Ym68SX5uxN7B2EhXn2ySZ9IpXEmQkrlkmXp+TwJZWIpYL6F5xJ3kL4E8Z06N70ChvVUMu46HpiTtvU6MpqQI05vDGAhBAjtsU6qz6rkP2wqbtvBDICTy1QEhUOZuG0/LcAhEzGPhQtazDX+yxTrcS47mMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iuVsxbai; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7e2204d1so300855a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733514521; x=1734119321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKZgGxt5h33tUs/q9vcvav+JlEm6T9+HGtdqCUo6Cio=;
        b=iuVsxbaiqJ5yn56BPGlVhPUQHHWVkJqJEcaFKYJr9F9z/DhjTT3pXND9RjZXwmtXzM
         TnG/PAXGv0oY/TDQnurFyIsGcnGWy9bTkiDzsM0JFwrqC/JawVlooXOXp23tDgg2qvMo
         k2f7ITLq1ETE05qkIX7xc/NwgjVm7by561Fog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514521; x=1734119321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKZgGxt5h33tUs/q9vcvav+JlEm6T9+HGtdqCUo6Cio=;
        b=GioKQDJP4mIQcA09xYRHSPgIEMCsvbG0xJXFp7ZqGWyBNqo9SrT2Tjw3FGaQyhzis2
         wczdNp79Qg0LZu3YcKE/tKt841xWukyOjFR+LRoW2hiDFRtNro4xVt1Po+8uJZ8roqT4
         9mazHur4M7vOE+eLS6br+VCTS8fUCNMCry9s/+tSOlNcUamXgMw3N/sssH0ELxKt4lh3
         g919yM7dyPpd56Vv6Lk6IvRmPu97uFtH1DwtpSJGuTaVuO0YpYTCrHC5mrW6CmEaWRjR
         XA8cxipl0siIHZfjwsP1L/xaz9pGuI6olaDZybP/yu4kna6hA3jWVDy5CA3AinJLi3rs
         o+rg==
X-Gm-Message-State: AOJu0YwcWeYBAYum310j5M95ECW0mdV48tAdOvr7OpfwJmnBZp86x44h
	epUvpz/9Tnv+tz+l47YSric1N16/LPHXnS+7Q5kTk+ci9kI6k5OvvD2QD1QF3w==
X-Gm-Gg: ASbGncsYXIsSzTemDNjpjEdej2Jf0LFaHMu+E6BfpBFJF/tSiDXBn8QlEm7jAIJM90T
	tAaOrFKWYiT+Tq51vfcjsS68nsS6D/fHzdHd5hEPv/Qo3T4K/f2jiP8wZnWjS0WD+W6V4DnjjYF
	9vuc0mOBL2+CDKRVsI/3sIuO4usIlz052MCpBGGpzmaFUz155LgVKzSBaUdZmFcFiswfp1LJ1CR
	W5qk5vc0zJH13qmLqlHd7RogoGmC5qtTVQpJXDloikNE/EEbul9BhfcX6OBWeehw2lWAROnwGzj
	a3MXyw+0oio=
X-Google-Smtp-Source: AGHT+IHHIPUS+nOwW3qIcBXhQCAbu0RwI1NczWGVxjH2s2mm/k1K5Ni5Cq+mTyAFLJrv08XeLo3oQQ==
X-Received: by 2002:a05:6a20:72a3:b0:1d9:71:c23a with SMTP id adf61e73a8af0-1e187158340mr3045518637.10.1733514521497;
        Fri, 06 Dec 2024 11:48:41 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725a29c5d77sm3317742b3a.31.2024.12.06.11.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:48:41 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 1/1] mseal: remove can_do_mseal()
Date: Fri,  6 Dec 2024 19:48:39 +0000
Message-ID: <20241206194839.3030596-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206194839.3030596-1-jeffxu@google.com>
References: <20241206194839.3030596-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

No code logic change.

can_do_mseal() is called exclusively by mseal.c, and mseal.c is compiled
only when CONFIG_64BIT flag is set in makefile.  Therefore, it is
unnecessary to have 32 bit stub function in the header file, remove
this function and merge the logic into do_mseal().

Link: https://lkml.kernel.org/r/20241206013934.2782793-1-jeffxu@google.com
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/internal.h | 16 ----------------
 mm/mseal.c    |  6 +++---
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 74dc1c48fa31..5e4ef5ce9c0a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
-#ifdef CONFIG_64BIT
-static inline int can_do_mseal(unsigned long flags)
-{
-	if (flags)
-		return -EINVAL;
-
-	return 0;
-}
-
-#else
-static inline int can_do_mseal(unsigned long flags)
-{
-	return -EPERM;
-}
-#endif
-
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/mseal.c b/mm/mseal.c
index 81d6e980e8a9..c27197ac04e8 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -217,9 +217,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	unsigned long end;
 	struct mm_struct *mm = current->mm;
 
-	ret = can_do_mseal(flags);
-	if (ret)
-		return ret;
+	/* Verify flags not set. */
+	if (flags)
+		return -EINVAL;
 
 	start = untagged_addr(start);
 	if (!PAGE_ALIGNED(start))
-- 
2.47.0.338.g60cca15819-goog


