Return-Path: <linux-kernel+bounces-353878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB09933EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F72A1F22AED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC11DD55C;
	Mon,  7 Oct 2024 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J94TJ8OT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="52ymK6iS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4D1DD527
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319804; cv=none; b=Vua9aYlhi5qa33no70S64AMnZUo9dFUXSFGA6/5pQrWJSku7MvBcfVqU4QVwVHMVKyXHGUegs5n46Iy0crHSC5u3v+T0ULD6mtrTRnT3wD/bLqYU5AcXp+v/ufeTcT/Aheeikjstrrr+qdAQXINKbhMc5mD4m9rZmjOjPDPszvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319804; c=relaxed/simple;
	bh=huwrr8yoIiLO+sycKuHEO61YqWvJ5wMCX42IOJL6d0U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GDPHhW8kay+CGxyLQRSgrqMmC/6Pc/KloMm7hZNAKuwcJq6iPijShapF8ID/StgKZ1otOYUecNbZwWCLcSoFSl1Q2Mq13qxaxLBL3TipHJYdYnyCYiKiDj6lfAFuvtmMy7iMf6vlLS5MbjUL2Qe5j8m+gml6gI8DcbbFY1B6OQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J94TJ8OT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=52ymK6iS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.453912357@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3yz7XTTQgqOO6f/M5A+HCXYlu+Zj5Ag/dtYwShwS6fQ=;
	b=J94TJ8OTOuRHEGjzTKATV3UBkqhiXBbAFhsigEKq7PWDX3T9abMNr/UMT6oNeyugPWHj0O
	KZNeWnLB3qOthPsASJb5Rdo+UHKYs1PfQEPDWQdVT1FFYVlqsQXYJujIfSmM1PqAfYQVnH
	GDKBB2Ut7IdcFNtxqb2VopQc91sG/czF5JsExRoYkYnK5MhscxbAXmzGjKVAbGI9HYQWzt
	p7EkenFvFpPLtUDDNBpUXlfxQMwra2UFgse7rgdmYkFmo/5QB6c32xurVSNH9pZg75onHO
	zSzONmlI6zon0Psw4HRIg58Hg6D2WvwYY2U9wXDlD/p3LFYLaJGoZ2cTxhyqvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3yz7XTTQgqOO6f/M5A+HCXYlu+Zj5Ag/dtYwShwS6fQ=;
	b=52ymK6iSLfchVJuFo65BgMT/qhPoylOecdRa7zOdF2wRQ9fUinNUeTiStoET/ioNniJ3Pf
	y/CGyiSq9U6aXICw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 08/25] debugobjects: Provide and use free_object_list()
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:01 +0200 (CEST)

Move the loop to free a list of objects into a helper function so it can be
reused later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -125,6 +125,20 @@ static const char *obj_states[ODEBUG_STA
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
+static void free_object_list(struct hlist_head *head)
+{
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+	int cnt = 0;
+
+	hlist_for_each_entry_safe(obj, tmp, head, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+		cnt++;
+	}
+	debug_objects_freed += cnt;
+}
+
 static void fill_pool(void)
 {
 	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
@@ -286,7 +300,6 @@ alloc_object(void *addr, struct debug_bu
  */
 static void free_obj_work(struct work_struct *work)
 {
-	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	unsigned long flags;
 	HLIST_HEAD(tofree);
@@ -323,15 +336,11 @@ static void free_obj_work(struct work_st
 	 */
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
-		debug_objects_freed += obj_nr_tofree;
 		WRITE_ONCE(obj_nr_tofree, 0);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
-	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
-	}
+	free_object_list(&tofree);
 }
 
 static void __free_object(struct debug_obj *obj)
@@ -1334,6 +1343,7 @@ static bool __init debug_objects_replace
 	}
 	return true;
 free:
+	/* Can't use free_object_list() as the cache is not populated yet */
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
 		hlist_del(&obj->node);
 		kmem_cache_free(cache, obj);


