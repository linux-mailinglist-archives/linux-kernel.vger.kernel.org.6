Return-Path: <linux-kernel+bounces-246860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F416692C819
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2846F1C21F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2D79C0;
	Wed, 10 Jul 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpAHh+3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789A3D62
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576269; cv=none; b=moOKco18U1Sq655TCeQRC8KYaS2YMjZzo7/KbtLUrpffdZyEY9EXrdeixWzeN22j9Kl9AEx7AWkemA4gApuGpsY8OjWZ/XRbIE4OAb9M5OenoPYMWBi+zKeOd5gTZLOBsku5vOOPLG/ZrDyW/OoZhmyIUYQy27MJYSbsdq9U36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576269; c=relaxed/simple;
	bh=ZvLp7r5qYpXgQ8FeJYMYjuwJ6F6KhsV/1xQSB21NOzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYb0T0bbXo3iTcyTzwxVVHckVVM1MNYjSP8khoeQQIWwNjoxKGPsqUDTuPCLHpy09h5sk4yEpAcKNPz3CFtS+aclPx7Db+ZdgLaeAyqvv80D2vc239vru54Y3thuxbQrT69UZu6TBphEPeei97ejv276UD/IHJEMrTuAKvL+voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpAHh+3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E6C3277B;
	Wed, 10 Jul 2024 01:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720576269;
	bh=ZvLp7r5qYpXgQ8FeJYMYjuwJ6F6KhsV/1xQSB21NOzY=;
	h=From:To:Cc:Subject:Date:From;
	b=EpAHh+3sKtz1m+bYgcFLVMI5KjLyu0QMXujNasDcqXOK+IGr7IQBtM+eHAk5nzRz+
	 tMk6XRyqPl7l5A1BVK5AqaccCektN/8Dhy752zi3rsCDh6EqrASj9AfqE06oNPkb+u
	 RlqtaGS7nBYx58z+sPhHOPJIIsH2Q17uZDG7LEp8cyWQVUNJ++Pv1ZrgEndq4VYyKr
	 3nk94moYyIg8C5KVOH5nS5Y1KwoL2gN3Sp1BNDwqP0SduRUZAjhSYGlDgpfHDV4kC+
	 uHBbVV2EPUclEOEMkuqShJFgIeiEdgIXV25oVk93Q+IEPLqZSzJDaMOVZtzkCOODSe
	 6qDR8/rj6yEkQ==
From: alexs@kernel.org
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Alex Shi (Tencent)" <alexs@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2] mm/memcg: alignment memcg_data define condition
Date: Wed, 10 Jul 2024 09:56:08 +0800
Message-ID: <20240710015608.100801-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (Tencent)" <alexs@kernel.org>

commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
extensions") changed the folio/page->memcg_data define condition from
MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
SLAB_MATCH(memcg_data, obj_exts), even no other relationship between them.

Above action make memcg_data exposed and include SLAB_OBJ_EXT for
!MEMCG. That's incorrect in logcial and pay on code size.

So let's remove SLAB_OBJ_EXT from MEMCG and as Vlastimil Babka suggested,
add _unused_slab_obj_ext for SLAB_MATCH for slab.obj_exts while !MEMCG.
That could resolve the match issue, clean up the feature logical and
save the unnessary code adding.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm_types.h | 8 ++++++--
 init/Kconfig             | 1 -
 mm/slab.h                | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ef09c4eef6d3..4ac3abc673d3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -180,8 +180,10 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+	unsigned long _unused_slab_obj_ext;
 #endif
 
 	/*
@@ -343,8 +345,10 @@ struct folio {
 			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+			unsigned long _unused_slab_obj_ext;
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
 			void *virtual;
diff --git a/init/Kconfig b/init/Kconfig
index 26bf8bb0a7ce..61e43ac9fe75 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -965,7 +965,6 @@ config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
 	select EVENTFD
-	select SLAB_OBJ_EXT
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
diff --git a/mm/slab.h b/mm/slab.h
index 3586e6183224..8ffdd4f315f8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
 SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 SLAB_MATCH(memcg_data, obj_exts);
+#else
+SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
+#endif
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
-- 
2.43.0


