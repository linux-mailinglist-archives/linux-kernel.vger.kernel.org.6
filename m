Return-Path: <linux-kernel+bounces-353891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77670993405
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E60C1F21FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EE1DE3D3;
	Mon,  7 Oct 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlzWtgHv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeoWapdo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C1DE2B9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319819; cv=none; b=qu5whUGllekAa0qYiBnA+8xS0k+boaS+HlX8rtS5EPzWftF77aZrFj3aUOMk/tClaO30GNtvKCsfqCQN8zIKdegx7UNqfjdgXMhhmEzxeznVNqrsKC3LvvToYaOYxA6b9hCRAnTyD/orsnnhgSRVGKd8q/DVZCeMs9NchU9D6M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319819; c=relaxed/simple;
	bh=5+EAf50dSxAoBX7Xv/AahGjoTi0OfZ9NeYeRmvt3lrU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Z11IN3UGweX0Y/GWia8bCfgrMR/nniu6Ou9/zJVzKkJ9AuV6p3psaaLcSi9eQVZaaffh3/IguaRVd9UH7hXBI9+kwuer8moNjRMiJraNSUEKKRdWca6YcSJq/Ndqs5DftzBj+oh6ee8oFhOms3w+ph1ohg2eyss3IBcR4hNJO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlzWtgHv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EeoWapdo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.077247071@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=w2tTfBGbQWuv1aJS1y+ptC+wplD7DmV2MTe3q95US6c=;
	b=OlzWtgHviMXIEkcZLgx12tl5ZzGvXziLpD3MIOVBv9tII6EY/DiS5cKnBhlnF9fQ0MYpV0
	P8UuV8z/Yy8n9jB1kFsfupGMpcKRcYF3RlEGCgDTeIWxyKFFmDvAeEo2zD10jmxxSveR5B
	tvNSB9Xk5YDOrI0iKQPIqRHXLS6TwQtGAh9lel7GfdZ0ZDff5nEGZ94TaCjWXmo7IUxoEJ
	ae+8982nJr5lAAwt3q8s6D9n9DqFWF0a5Fiua5sMpzX9a7KObZj4EzB0lxfD/kuTs0QPs3
	u/mCfegoJiF6swUg8YqkSVFjwpQs9FAfgr1x0L9PzFM4u7rs5dYbjL7Af0RArg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=w2tTfBGbQWuv1aJS1y+ptC+wplD7DmV2MTe3q95US6c=;
	b=EeoWapdoqK9BQdsL+SBaj5TnFKE+w3qBRsMwez2CrudQ7g3vpb3eUp98/WOHHS+T3BiT3O
	JEKjVDas3dxJ06Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 18/25] debugobjects: Use static key for boot pool selection
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:13 +0200 (CEST)

Get rid of the conditional in the hot path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -7,16 +7,16 @@
 
 #define pr_fmt(fmt) "ODEBUG: " fmt
 
+#include <linux/cpu.h>
 #include <linux/debugobjects.h>
-#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/hash.h>
+#include <linux/kmemleak.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seq_file.h>
-#include <linux/debugfs.h>
 #include <linux/slab.h>
-#include <linux/hash.h>
-#include <linux/kmemleak.h>
-#include <linux/cpu.h>
+#include <linux/static_key.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -103,6 +103,8 @@ static int __data_racy		debug_objects_fr
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
 
+static DEFINE_STATIC_KEY_FALSE(obj_cache_enabled);
+
 static int __init enable_object_debug(char *str)
 {
 	debug_objects_enabled = true;
@@ -343,7 +345,7 @@ static struct debug_obj *alloc_object(vo
 {
 	struct debug_obj *obj;
 
-	if (likely(obj_cache))
+	if (static_branch_likely(&obj_cache_enabled))
 		obj = pcpu_alloc();
 	else
 		obj = __alloc_object(&pool_boot);
@@ -393,7 +395,7 @@ static void free_obj_work(struct work_st
 static void __free_object(struct debug_obj *obj)
 {
 	guard(irqsave)();
-	if (likely(obj_cache))
+	if (static_branch_likely(&obj_cache_enabled))
 		pcpu_free(obj);
 	else
 		hlist_add_head(&obj->node, &pool_boot);
@@ -572,7 +574,7 @@ static struct debug_obj *lookup_object_o
 
 static void debug_objects_fill_pool(void)
 {
-	if (unlikely(!obj_cache))
+	if (!static_branch_likely(&obj_cache_enabled))
 		return;
 
 	if (likely(!pool_should_refill(&pool_global)))
@@ -1378,6 +1380,7 @@ void __init debug_objects_mem_init(void)
 
 	/* Everything worked. Expose the cache */
 	obj_cache = cache;
+	static_branch_enable(&obj_cache_enabled);
 
 #ifdef CONFIG_HOTPLUG_CPU
 	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,


