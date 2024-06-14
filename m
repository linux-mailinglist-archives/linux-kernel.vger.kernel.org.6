Return-Path: <linux-kernel+bounces-215546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB090945F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485011C215F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4A186E51;
	Fri, 14 Jun 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmiMiqut"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E112137905
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405997; cv=none; b=lt42SfjxW19miX1vYabzPs+8kqkSqSVAJ4+UD/7VH/0JK36Vb1q1LZQyEkmVHaAHKFMtUXHwWLiNb1IyNgpLq9nROztuMjFrEn74KFjmxsjru8Z/+gACE6QYjst1kc06JiQ2jebRhLMeRjmmiKVKAlzImbR5bUr+2B+r6Myhj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405997; c=relaxed/simple;
	bh=Jvx/D00bdKpscL8H+BgKzqSrJpNVmyQG4WGp2oeFAFk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qiGlxiF/ywdWGTUTeGqabKtenwvECRz0nL6nWkWOIDmo1nwn8EZ11JEQ07AHWRzTY0un6idsGcUcoCucsxA5ntaQmJHfU+nsyQ9iWhUoru0/bm6bhmNRMfJ2g/HNmcSUmJe5SjfU2U27D7ZCQbDd7+XVdo0Fgwbqb8LM0toZpnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmiMiqut; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f43bec13so45549817b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718405995; x=1719010795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ov9SboQQfNn2c9IqfdAPrbvWYYp8I7N4DcF5qw+Lk1g=;
        b=qmiMiqutFLkbD5UP0baGkarHdQ1YH/T/2Y3NvnD+oCgb1OHe0NcQohwPKiMUP0Rt0v
         i03StLSzwlZo7ZdE5i1IPprvGV/i5e1heegE/fb0mGE6OW2VHKqubiy5Oa3oXRi17+4z
         xUnbJdeAXDX2A47CW+RGCC3LOGV4OGsbCJLe/+n2fe/OY8vPCkc/bcDjoLUd8JOfMQ53
         a2qid7+s1VLEFuHr9P3Stg+4lzh/P0xaebX/HbXIRvmyrqRbYEsat7fkxKWdMiX5hW6y
         6+OTy9y9C7yf+ny7IiwEELPaAMAy/hHqqoz7NlVpkps/GkKEOMjn0vH6tsTApsqHpBak
         3wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718405995; x=1719010795;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ov9SboQQfNn2c9IqfdAPrbvWYYp8I7N4DcF5qw+Lk1g=;
        b=Wa4+VYqgOv8BXa8jP+DOPwoqwF+oKy2phR2PqmqVJecjR05ZPwS1CugMMhzxG9YbUn
         3PhTqJbIyKM1q4aieflHBSswIJT3wa58thVmIgf+BylHYdIbaQl6dJDvWc4VcdOCeSJ6
         e9Z9YgNsGicjRhh9DzV/GvabZfuDIXJfLXeX+4+3ji4BlsEHvUQTGEGYELEDwAih/MCY
         UuG7cRx6y7rUFRIaozISl56crw6UiaF0ZWIcSC0OJH6/BytiI//MArU8L7yQKTNBoZfM
         OJI0itudzuc1dRl7uHikBeg2TAmZj+1OPNPNEHn+YH5iQC3Xr0prunbHZrJHsq+5quna
         EopA==
X-Forwarded-Encrypted: i=1; AJvYcCU5OdR9z+Kdd4qh6nvMjt2/ZqXlb0LSlPCg0egPZngwz+9JSBqgIZzTKIl7MRFAqiGQIg9wIYELRv1GXts17PD326Ygxv/2Q2VFPcfL
X-Gm-Message-State: AOJu0YysQ2WuteG1B0usP/TB9oYpd/9dc53azr1g6NHSRBhtXhpIiRmZ
	FvUluv0SqtY2ONXLhFugdyAw3pV6T11dMPYafNdnprUGCSkGnmGNZTElfFxHFa48KpPQCX2JYTs
	eDQ==
X-Google-Smtp-Source: AGHT+IHrPdYXJQ88SIVzQ5uVnIDoZr8qnm3pGhWwZruCCZDr6O/84844meKb98AqqszmQhjmVqBN2EZJARI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:92f9:5432:a95e:d0e8])
 (user=surenb job=sendgmr) by 2002:a05:690c:d87:b0:61b:791a:9850 with SMTP id
 00721157ae682-6322480e75dmr10421527b3.9.1718405995393; Fri, 14 Jun 2024
 15:59:55 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:59:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614225951.3845577-1-surenb@google.com>
Subject: [PATCH 1/1] mm/slab: fix 'variable obj_exts set but not used' warning
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

slab_post_alloc_hook() uses prepare_slab_obj_exts_hook() to obtain
slabobj_ext object. Currently the only user of slabobj_ext object in
this path is memory allocation profiling, therefore when it's not enabled
this object is not needed. This also generates a warning when compiling
with CONFIG_MEM_ALLOC_PROFILING=n. Move the code under this configuration
to fix the warning. If more slabobj_ext users appear in the future, the
code will have to be changed back to call prepare_slab_obj_exts_hook().

Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSaiy-lkp@intel.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1373ac365a46..4927edec6a8c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3902,7 +3902,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			  unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
-	struct slabobj_ext *obj_exts;
 	bool kasan_init = init;
 	size_t i;
 	gfp_t init_flags = flags & gfp_allowed_mask;
@@ -3945,9 +3944,11 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
+#ifdef CONFIG_MEM_ALLOC_PROFILING
 		if (need_slab_obj_ext()) {
+			struct slabobj_ext *obj_exts;
+
 			obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
-#ifdef CONFIG_MEM_ALLOC_PROFILING
 			/*
 			 * Currently obj_exts is used only for allocation profiling.
 			 * If other users appear then mem_alloc_profiling_enabled()
@@ -3955,8 +3956,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			 */
 			if (likely(obj_exts))
 				alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
-#endif
 		}
+#endif
 	}
 
 	return memcg_slab_post_alloc_hook(s, lru, flags, size, p);

base-commit: c286c21ff94252f778515b21b6bebe749454a852
-- 
2.45.2.627.g7a2c4fd464-goog


