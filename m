Return-Path: <linux-kernel+bounces-278665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171794B34B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F48B23A55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9311156641;
	Wed,  7 Aug 2024 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J6UtWubh"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF3155725
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071524; cv=none; b=B+Vmnnc8FY+CyPX0UFohg7vvjZCgjD4LuvQY9UCZSgcgwyZrS/bVmCC7uuZw6fTpUW3VoV3j1Ed1H/MtMPwsNRekzOrlsgrFScJDi9EdflhLRSTW8Fdb73r1iumII6mFHr2LjTOLpetKiFaxQ/+HMWfNTdPL6fR08Va58lnoqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071524; c=relaxed/simple;
	bh=i4bQ2f0KhzqS43M84Z+6cqfFzyMKd1/zGXIzDO7oaj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiyDnO5h92FW1tTIlIGQaDRj+0SgAWzdqcs/RfsoqowucM8pyfb1PzHSxpLlIvpRWB0Oum6cWdF+U+uHXiEagtYL0heSilBi3Ou3r5LWl6bwk0hMqYAGjU+hR22jtCvHBGknqtt7AbjqJ0PwuLyaslBL08xGv9MLCkyCEDMXvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J6UtWubh; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bbbd25d216so8584166d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723071521; x=1723676321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgTw1MJpREDKtA8MBDfFpK1lRDgpnFo5p3QGqe5q1yE=;
        b=J6UtWubhaRhGAHbPO5ynOJvh18bsgu94ds9pXyf2X6W9Mk8WvExO9Qkf0O/5k26X7x
         IHgCn82f198H1cBK3LyteR2LhfzpXOyNia2tBkVWxqZwForoiPBs3LRuJVwiiHTYeoXr
         rFj3YB0Mvl6PjGjiWOAxr7SQzgfLUImNhZVffvoawHj7yZk7rEIfjnD+QbuEj57pkJhs
         /hEQ8ocbiyw1t+DH984l70lMN7HzoqPYBHsYPu+8fB1zeYQU4xKw26pL8dbT8OzqKbPv
         Q++eq5Dehij7wCqaV5H1EYx5tLxtww5G+HCgEVudfnVrB7c+TBvQZ9T5jYS+eNdshckg
         7tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071521; x=1723676321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgTw1MJpREDKtA8MBDfFpK1lRDgpnFo5p3QGqe5q1yE=;
        b=Arp5ruR0es276pc99OEkWyENZJel4tRez17N4H34IgNs2DRdGvt7+KK5ZqA7jJtZ84
         xwOxh0PVsULGQXxlo7fqvUuPqKeAW2eODkeiN1cK3ea58ZGfJicEORT0Y2Db30CZg5mf
         3tMMWd6OJ+k/UhdCy2oa3kBkfnL0EA2+L4tMRvyeBn2+4djHh0hVk4AgcVuHw46uZoGV
         uTQBrtG4o4qSUdfQKkcylLKPcRhGFij1rZoV55Ru+q6QTJZYjF8rK4TS93mxR5bRj+Fx
         9EFlZ8t2v7E3hsVL57gIRPyY0m+swbjzP29BhQTniT+8e6LBgCLaV9KvrU1EXR6Rqj/w
         QpPw==
X-Gm-Message-State: AOJu0YzDfTV7/p9f0S742gvsMi5jLhIoT3JJRmTzBKJUHaAEJD1F4snc
	gCNGaKJxuOoJnwpnXDdhMLslR2NfNunJr9lrQGuzY3NiP1rZUcGD6O20deU46bM=
X-Google-Smtp-Source: AGHT+IESTvxvIP/0NsY/nNAedSv7eOQc6S3fHV+zRTAbSx6VH57uc+pCgilTBNWuC9GtEa+9Xyvohw==
X-Received: by 2002:a05:6214:5784:b0:6b5:2f57:1a63 with SMTP id 6a1803df08f44-6bd6c3b4356mr418216d6.21.1723071521363;
        Wed, 07 Aug 2024 15:58:41 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b82cbsm59997096d6.61.2024.08.07.15.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:58:41 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ying.huang@intel.com,
	nphamcs@gmail.com,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 3/3] swap: enable promotion for unmapped pagecache on access
Date: Sat,  3 Aug 2024 05:47:15 -0400
Message-ID: <20240803094715.23900-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803094715.23900-1-gourry@gourry.net>
References: <20240803094715.23900-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unmapped pagecache presently cannot be promoted off of lower tiers,
even if they are being accessed by read/write calls. Enable migration
in mark_folio_accessed if a given folio presently resides on a lower
tier of memory.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/swap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 9caf6b017cf0..08f76d748e29 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,9 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/sched/sysctl.h>
+#include <linux/memory-tiers.h>
+#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -463,9 +466,26 @@ static void folio_inc_refs(struct folio *folio)
  *
  * When a newly allocated folio is not yet visible, so safe for non-atomic ops,
  * __folio_set_referenced() may be substituted for folio_mark_accessed().
+ *
+ * This call may also attempt to migrate the folio memory to the local node
+ * if it presently resides on a lower memory tier.
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	int nid = folio_nid(folio);
+
+	/* If folio is on lower tier, try to promote to local node */
+	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+	    (nid == NUMA_NO_NODE || !node_is_toptier(nid))) {
+		int flags;
+
+		nid = numa_migrate_prep(folio, NULL, 0, nid, &flags);
+		if ((nid != NUMA_NO_NODE) &&
+		    !migrate_misplaced_folio_prepare(folio, NULL, nid)) {
+			migrate_misplaced_folio(folio, nid);
+		}
+	}
+
 	if (lru_gen_enabled()) {
 		folio_inc_refs(folio);
 		return;
-- 
2.43.0


