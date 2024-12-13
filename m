Return-Path: <linux-kernel+bounces-444164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1929F0246
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A069B283E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43821106;
	Fri, 13 Dec 2024 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oz3iCFXp"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BADDDC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734053677; cv=none; b=AuC2xcOJ+EhxRetf5EA20nAYM8wOuyUjZsNAMhTkUUyRKGl37bdGUHSQTw0rDJ6BmwzyRRrTWQe+6UeoOHtVQJUVh9fYirco9ANqUT3CsHc464gkM61Ua9geSHIuN/Xs0cwyzi3mfV1k08uROwfD+OUg47tjPdK17cGXOzK+P6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734053677; c=relaxed/simple;
	bh=3Mwrc50tBykuEB4xXl5KImDQb1dbDzpxLfUyp9ZmWTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSXcTuwbRDM8cGQqRpw/KN2QmUx6Se2QU8gsgQzHNTeOfylghyGvNKvUGqTtit1fKrqVTaiNIne1lOdBQcSzjk59NEwHLbqAM4DT/WzaUHIcjcgHBianDb0CfYe8Hno8Fl2Y15L12l5mse5Q1cC6KF+llgfmxpibkwE4PYqSTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oz3iCFXp; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QSqfE
	9gWL2eSEncQbXA9WzU3XQBVueorn8PymwoOkrw=; b=Oz3iCFXpZt85h5EDcULaL
	IUEpyQKOLU8jKm+VzQJJhRwlHmKCV78aD4P4cdHnx5ok0nHR40s3p/0u7YgJF32M
	f/NkKksdSksMIU70+nej6izwYU0ovVRGdPy+bL51sVF61JgKxHG3YavwQDczGh9j
	8hiHWnR2bHzJ6UeOVJa+mc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n9XujltnbdXUAA--.513S4;
	Fri, 13 Dec 2024 09:33:49 +0800 (CST)
From: David Wang <00107082@163.com>
To: surenb@google.com
Cc: akpm@linux-foundation.org,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	yuzhao@google.com,
	David Wang <00107082@163.com>
Subject: [PATCH v3] mm/codetag: clear tags before swap
Date: Fri, 13 Dec 2024 09:33:32 +0800
Message-Id: <20241213013332.89910-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAJuCfpF2e7niEbR=nX2u0HZHq-7tjRGB=xV397pFpjdzBqUGfQ@mail.gmail.com>
References: <CAJuCfpF2e7niEbR=nX2u0HZHq-7tjRGB=xV397pFpjdzBqUGfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9XujltnbdXUAA--.513S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Zw4rJw1xWFyxGFWruFg_yoW8Zw4Dpr
	47Wr1UGa95JryxCrWkK3W2vr13Xw45tw15GFWa9a9YvryayrsrGrn5WFW2qFnrZFWkAF4S
	yrsFgrWIk3WUJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ5rxUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hC0qmdbjOs+3QAAsk

When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
triggered when calling __alloc_tag_ref_set() during swap:

	alloc_tag was not cleared (got tag for mm/filemap.c:1951)
	WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...

Clear code tags before swap can fix the warning. And this patch also fix
a potential invalid address dereference in alloc_tag_add_check() when
CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
which is defined as ((void *)1).

Signed-off-by: David Wang <00107082@163.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h | 2 +-
 lib/alloc_tag.c           | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 7c0786bdf9af..cba024bf2db3 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -135,7 +135,7 @@ static inline struct alloc_tag_counters alloc_tag_read(struct alloc_tag *tag)
 #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
 static inline void alloc_tag_add_check(union codetag_ref *ref, struct alloc_tag *tag)
 {
-	WARN_ONCE(ref && ref->ct,
+	WARN_ONCE(ref && ref->ct && !is_codetag_empty(ref),
 		  "alloc_tag was not cleared (got tag for %s:%u)\n",
 		  ref->ct->filename, ref->ct->lineno);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 35f7560a309a..3a0413462e9f 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -209,6 +209,13 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 		return;
 	}
 
+	/*
+	 * Clear tag references to avoid debug warning when using
+	 * __alloc_tag_ref_set() with non-empty reference.
+	 */
+	set_codetag_empty(&ref_old);
+	set_codetag_empty(&ref_new);
+
 	/* swap tags */
 	__alloc_tag_ref_set(&ref_old, tag_new);
 	update_page_tag_ref(handle_old, &ref_old);
-- 
2.39.2


