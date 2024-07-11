Return-Path: <linux-kernel+bounces-249568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73792ED66
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC1C1C20F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7116D306;
	Thu, 11 Jul 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vX4yGfu8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE10450FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717343; cv=none; b=etmxb+aTww/zLDnjA6LgPkWKb35UeaIHX/2VFNcL4ShmOcj6MiIuRZYCdO6tJa4WthMs0fMDfOtdAyD26W3ZoTioFiXwzbuK96kLrzgkh+kgFvzep9WFtrMHMkx569r2VsVCWZWH5nyi9DZlcdcOr5V6jlPCeyA1t1GQhfywBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717343; c=relaxed/simple;
	bh=1ZV9ofeTN5rLqh4xgBefwf8x7OwYD/0EUD+CPImYW7I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SqbeODMnV0EzR9MX7M8oJXmFt/TgqBtEPG8eqxqTVrUe40Xoa3yUNWq6AD/Qyw8w4j6jzjjuZkTnXWznsPt2y8FXJiidZ1CFC9lWm8uBDCGyRdP/0xDjIG1uaacvmmpJkK3fuobp+TbsDG3p9q4GQBFWnbNfxy9upJGJN+MFtDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vX4yGfu8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6511c587946so18773177b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720717341; x=1721322141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=faUXYQX/NPjNwWRBOvRIcnxaagQhXf0tTHr83ryFsFo=;
        b=vX4yGfu8bxrxLWiH6r/7WlaUqvo11ECEno5ACJkfKNUvZh9dBixEwFl2SOsZSDcSK2
         LmRj+rDtYGvDptLupzbV++Mbydq8BEeOOspEyGxemduElUqzdAjheH/x2TONs5Ql8qkG
         ONQ7JjCTGAaaT3tipUWSNUe43XyJyab+YvWhyso5cBYFJGch9N8WB8UXw/xSYgm9qudp
         cxZHcVtGvVvxSRdg9KWLsof3xK4MMcXOxv6Ym+tsFkLA4cKQobw9htJG57u54Q0gx6US
         xGrT8A5k5T04DyuvBBwMmHtIllTP4z0WaZ4l+6+Ci8GqjkAbP/yGO9igwlfc4BeZlY4A
         evmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720717341; x=1721322141;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faUXYQX/NPjNwWRBOvRIcnxaagQhXf0tTHr83ryFsFo=;
        b=iQ+BXO3KpQHI3UEXg+7chOjN3kQO7n3SUbFxFdPEriWfBOjwWdZum5QMI7AWDmoctj
         WCR8GRCytCoTp9Tf2Q1sGOc5BLOCIkMHdN7rMt/0W1YRopo8wd1vLTJBc5enO/iDP0kP
         6+0SEbNN1MuEJm8FdIuJrOopbuRRckfXZ9n2ZwXgNKqSJLVjfWh7Ja+D4hXmE0TTbXKJ
         j4Juqegc3uoyvyCKgjX+E2iAcACOLyQy6etLRx05M9Q84YViQIPY4oSsE/ZCyqq/kuts
         UKPRrcx1L8InxQNXOUKIJ7UChmBPOrWzPaZjb4pxzf3XaxlA52oxb+1PrNRfMbp+ssxo
         HKsg==
X-Forwarded-Encrypted: i=1; AJvYcCUeLm1A9TTbnSunursZMh221jGe0lPFPQOfISjoGJx+wFdOl+mWOPmQjzOEEjt4g6jsa8Nf6x3L11oWnQBb6NyALFw4C2IXv3W7PIhn
X-Gm-Message-State: AOJu0YwjAsHjY3Wd3Ds2GMEh/QHbuwN1WJn0FIfNqp0uabYsaCkVQ35I
	diSz8I69uw0yqfLoWFfw9W6jQcTQuNb6wgf38erguy/aaEYsYiNJ7EYO5a79xtMcipA7Fg2lNMv
	+Dg==
X-Google-Smtp-Source: AGHT+IEH2cBMCGGN+S9iv+gX76zKXY9neF03TmVjkK8wKg2bNrwEGyY3g1U4ZR0jGWCuRUKjbpCQVlGCQrs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:e0a6:8638:6754:d2a1])
 (user=surenb job=sendgmr) by 2002:a05:6902:2504:b0:e03:ac6c:91b0 with SMTP id
 3f1490d57ef6-e041b05837dmr384182276.5.1720717340863; Thu, 11 Jul 2024
 10:02:20 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:02:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711170216.1149695-1-surenb@google.com>
Subject: [PATCH 1/1] mm, slab: move prepare_slab_obj_exts_hook under CONFIG_MEM_ALLOC_PROFILING
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: vbabka@suse.cz, sxwjean@me.com, xiongwei.song@linux.dev, 
	willy@infradead.org, nathan@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

The only place prepare_slab_obj_exts_hook() is currently being used is
from alloc_tagging_slab_alloc_hook() when CONFIG_MEM_ALLOC_PROFILING=y.
Move its definition under CONFIG_MEM_ALLOC_PROFILING to prevent unused
function warning for CONFIG_SLAB_OBJ_EXT=n case.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407050845.zNONqauD-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
Applied over slab/for-next because of the refactoring [1] in that branch.

[1] 302a3ea38aec ("mm, slab: move allocation tagging code in the alloc path into a hook")

 mm/slub.c | 48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ce39544acf7c..829a1f08e8a2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2027,6 +2027,27 @@ static inline bool need_slab_obj_ext(void)
 	return false;
 }
 
+#else /* CONFIG_SLAB_OBJ_EXT */
+
+static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			       gfp_t gfp, bool new_slab)
+{
+	return 0;
+}
+
+static inline void free_slab_obj_exts(struct slab *slab)
+{
+}
+
+static inline bool need_slab_obj_ext(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_SLAB_OBJ_EXT */
+
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+
 static inline struct slabobj_ext *
 prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
@@ -2051,33 +2072,6 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
 }
 
-#else /* CONFIG_SLAB_OBJ_EXT */
-
-static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-			       gfp_t gfp, bool new_slab)
-{
-	return 0;
-}
-
-static inline void free_slab_obj_exts(struct slab *slab)
-{
-}
-
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
-
-static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
-{
-	return NULL;
-}
-
-#endif /* CONFIG_SLAB_OBJ_EXT */
-
-#ifdef CONFIG_MEM_ALLOC_PROFILING
-
 static inline void
 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {

base-commit: fe4e761669ab4d8b388fdb6e9dbe9a110eed8009
-- 
2.45.2.993.g49e7a77208-goog


