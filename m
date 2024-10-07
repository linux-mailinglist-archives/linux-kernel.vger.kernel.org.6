Return-Path: <linux-kernel+bounces-353875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFC9933E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989A41C22C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F181DCB2C;
	Mon,  7 Oct 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+yJyBTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G/Y/BTVC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C491DCB03
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319801; cv=none; b=YlaPJfqfl36+/0HVPHsD6aJQsVkaYqoMVlv8UkzL3GHiY3DLIkFfvnKU3mWwXP8AN1pRVFRE6GX7/0Ev5ErqjKfhAMtbyuhzEjsi2ET/totIUWWGmeIhdkX4qIR+7UvmqqBj4cAeoj+Dy6p/33qpeOog72YMIQTXHm/dJLKy98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319801; c=relaxed/simple;
	bh=2V1uwOf9Lz5kfl8cAFnIf1hL1Ej6o91RjqpnkrVfhWI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JDlKH7NuCI6LnVkyGkceY14FbcelULOXjBs/O8gM6T6B96wmJwfZyqA/Bs2jLTJasHTeDhLhih11DWp9yb/kaJjJYdW8Izlp30B8Pi6sHMzH+jPgNt1tEB3UZfvbj9OsUbX0oysTC856y/ePP2JYZx2qrirkUy8miKQzGbMt9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+yJyBTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G/Y/BTVC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.263960570@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MtciriuSO8ml4j4OAkJX3p/tvIF+cexwWzSghsv9eHk=;
	b=H+yJyBTQ+13VMbrAlsejigARsspFDkVphs+AIlMAMa0r3kRFcmPw+Ob0TKPVHjMRG7U575
	azrn6wxbISAx2/Boiw479TgeVJk6jLvmNPMGUASCgM6sJ06stmmuQyYLHyn3b6ei8wUZNn
	8N9tbrGsPowGGev2NHfW7KQP/34Av8uuFluk55UjLT+yFmmqw8t+aTFAZZKFCZ00qX8mdx
	9yETXwSxizEgdEcBam2NUasvdAtEDSD1LjwY+IjjA5JFZRco/J/po6P2qG/emtFFY7z/M2
	qNFVTsRDPCUxV7lRNfrWph4HGx60dwRxTGwI1Cq7/6kpH532mGQzyp5SdCiZPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MtciriuSO8ml4j4OAkJX3p/tvIF+cexwWzSghsv9eHk=;
	b=G/Y/BTVCpimC8aVVLx+4dq1l+puOMFl2C4Llvw5iilR8Pgeh0cLvIEx5CG1L6qafBH9ltR
	dCktcPowCLNLheAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 05/25] debugobjects: Dont free objects directly on CPU hotplug
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:57 +0200 (CEST)

Freeing the per CPU pool of the unplugged CPU directly is suboptimal as the
objects can be reused in the real pool if there is room. Aside of that this
gets the accounting wrong.

Use the regular free path, which allows reuse and has the accounting correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -430,27 +430,28 @@ static void free_object(struct debug_obj
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int object_cpu_offline(unsigned int cpu)
+static void put_objects(struct hlist_head *list)
 {
-	struct debug_percpu_free *percpu_pool;
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
-	unsigned long flags;
 
-	/* Remote access is safe as the CPU is dead already */
-	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
-	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+	/*
+	 * Using free_object() puts the objects into reuse or schedules
+	 * them for freeing and it get's all the accounting correct.
+	 */
+	hlist_for_each_entry_safe(obj, tmp, list, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		free_object(obj);
 	}
+}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
-	obj_pool_used -= percpu_pool->obj_free;
-	debug_objects_freed += percpu_pool->obj_free;
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-
-	percpu_pool->obj_free = 0;
+static int object_cpu_offline(unsigned int cpu)
+{
+	/* Remote access is safe as the CPU is dead already */
+	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
 
+	put_objects(&pcp->free_objs);
+	pcp->obj_free = 0;
 	return 0;
 }
 #endif


