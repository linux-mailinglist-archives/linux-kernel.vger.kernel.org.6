Return-Path: <linux-kernel+bounces-535194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B1A47001
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA847A43AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591F16C850;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A41BE4F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615133; cv=none; b=tkmrQFW+rbrxOvLq+xwxeLTF/6vgpqQzk1VqiABSHZHOCQ+VYaog6iEH+TZWDDvMASvvSopcYqMaMI9hJFAj7hHSiJpOMVq5X0EWnEyGa+Dsz9UfQ+nypRM1qmhSWen9WXcUc0mUkUDfbYb3Vm2c8Tgs645EOjeZLctMM5ZM0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615133; c=relaxed/simple;
	bh=ZLwh4kTeifDTY9uIjXp+TmPGZdPu1espl9jSu0PMnds=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZWtdbxQWsPpyGDu1DdFMPb8yy+iEP6lC4hb4vZX7LyizBGxm3m0fZSpGVIZbdzNhY1v6EDeN8kQ7AitnMMOca3Gw5IwgLBRvJLDrrDAe6G5TJy9EKC+lCpVV06XuayzkYaru/x7GfZnlu/vkIGu4Ns8ARmdzt/TR+DtOJCaWfHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7B3C4CEEB;
	Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnRWI-00000009XR3-2Wns;
	Wed, 26 Feb 2025 19:12:54 -0500
Message-ID: <20250227001254.455561171@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Feb 2025 19:12:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 linux-mm@kvack.org
Subject: [for-next][PATCH 2/3] mm/memblock: Add reserved memory release function
References: <20250227001235.355892523@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add reserve_mem_release_by_name() to release a reserved memory region
with a given name. This allows us to release reserved memory which is
defined by kernel cmdline, after boot.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/173989133862.230693.14094993331347437600.stgit@devnote2
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/mm.h |  1 +
 mm/memblock.c      | 66 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ee9e7447485 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4123,6 +4123,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
 void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
+int reserve_mem_release_by_name(const char *name);
 
 #ifdef CONFIG_64BIT
 int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..8cd95f60015d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/mutex.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -2283,6 +2284,7 @@ struct reserve_mem_table {
 };
 static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
 static int reserved_mem_count;
+static DEFINE_MUTEX(reserve_mem_lock);
 
 /* Add wildcard region with a lookup name */
 static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
@@ -2296,6 +2298,21 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 	strscpy(map->name, name);
 }
 
+static struct reserve_mem_table *reserve_mem_find_by_name_nolock(const char *name)
+{
+	struct reserve_mem_table *map;
+	int i;
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		map = &reserved_mem_table[i];
+		if (!map->size)
+			continue;
+		if (strcmp(name, map->name) == 0)
+			return map;
+	}
+	return NULL;
+}
+
 /**
  * reserve_mem_find_by_name - Find reserved memory region with a given name
  * @name: The name that is attached to a reserved memory region
@@ -2309,22 +2326,47 @@ static void __init reserved_mem_add(phys_addr_t start, phys_addr_t size,
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size)
 {
 	struct reserve_mem_table *map;
-	int i;
 
-	for (i = 0; i < reserved_mem_count; i++) {
-		map = &reserved_mem_table[i];
-		if (!map->size)
-			continue;
-		if (strcmp(name, map->name) == 0) {
-			*start = map->start;
-			*size = map->size;
-			return 1;
-		}
-	}
-	return 0;
+	guard(mutex)(&reserve_mem_lock);
+	map = reserve_mem_find_by_name_nolock(name);
+	if (!map)
+		return 0;
+
+	*start = map->start;
+	*size = map->size;
+	return 1;
 }
 EXPORT_SYMBOL_GPL(reserve_mem_find_by_name);
 
+/**
+ * reserve_mem_release_by_name - Release reserved memory region with a given name
+ * @name: The name that is attatched to a reserved memory region
+ *
+ * Forcibly release the pages in the reserved memory region so that those memory
+ * can be used as free memory. After released the reserved region size becomes 0.
+ *
+ * Returns: 1 if released or 0 if not found.
+ */
+int reserve_mem_release_by_name(const char *name)
+{
+	char buf[RESERVE_MEM_NAME_SIZE + 12];
+	struct reserve_mem_table *map;
+	void *start, *end;
+
+	guard(mutex)(&reserve_mem_lock);
+	map = reserve_mem_find_by_name_nolock(name);
+	if (!map)
+		return 0;
+
+	start = phys_to_virt(map->start);
+	end = start + map->size - 1;
+	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
+	free_reserved_area(start, end, 0, buf);
+	map->size = 0;
+
+	return 1;
+}
+
 /*
  * Parse reserve_mem=nn:align:name
  */
-- 
2.47.2



