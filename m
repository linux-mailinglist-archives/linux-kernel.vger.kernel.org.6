Return-Path: <linux-kernel+bounces-192277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8628D1AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4461F2406D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063516D312;
	Tue, 28 May 2024 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJyONNdx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VFE9cBeZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567716D4E9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898779; cv=none; b=LPBUv5v7w1MN3OJmLrq2e0UeQHgmOo47tfZz45IrsH+6OfIl/Fjbqyn2Jmh8/8EnDh5cjtV+30pbFkJt6jKHEKXhuFnzrk9i8NgfJ+Jz6RFR7Fo+gBQix7hkuT/037K9SrVGPDL8xfaqOcEfJoo56dn1xVz72fjsmBEG3JXEpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898779; c=relaxed/simple;
	bh=6k3PwYvMbq7Jv+xs5c9g3ZV6scoDh6bYmY+SysydD30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qD4Xl7pqeIgFfHAQWDyPUurnWuzomTs5sVsurNex0JKbS3lrc4tpvtr6oKnk35bLQ6Amzc7zanxt2koElpP5LuSAlKu6D1Rd1eROI9bAo6W4XD6uJne1Urk7i1LTJalSz88A7lcuyYaL9RV9xNH4zDI7c4oFrVJoKuEPIwyoCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJyONNdx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VFE9cBeZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 14:19:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716898769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BVI6TfGQyXa2HdEH+/r5e1ZnTptMlsWk95fc1VQDtGI=;
	b=zJyONNdx8saZ2VFjVc8rTd0pApCI3WDAcZke8JmBdGrwkoI5WG6TlAkrqz87b1Dej4Iraq
	VyYQZibATPir4vMtdIrvRjZdERYh2tcKPfz2HCyhQMyMXrIue+l1I1g20GjpTZtcdjkyhG
	UUl77euxq2PmZaTu7VMqVk4dYrqZLD+mNEwoXD4xiDXJE4/OqUGoJ5ReT17JA2cUeRfpSj
	FEowPg/pFCTCStMChvYOGBQr3jL0W1XXi5jhiW5JFCOSwZ/VQrQx0iOj31jwZ7qrJNEZ5l
	RX4HfGtWUJ/cwZfTEsIKRyZ6o/lTkhmcf+EOjIbZ2BE/sDfKLyzJLApiDljJlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716898769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BVI6TfGQyXa2HdEH+/r5e1ZnTptMlsWk95fc1VQDtGI=;
	b=VFE9cBeZh5CSymXXWfeQVGjrBbQEPBfw1e5kuPWLhN4sfCVp68x+hZkwFF2mdx91iMaeXw
	MWzfG2V/8htD5MDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] memcg: Remove the lockdep assert from __mod_objcg_mlstate().
Message-ID: <20240528121928.i-Gu7Jvg@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The assert was introduced in the commit cited below as an insurance that
the semantic is the same after the local_irq_save() has been removed and
the function has been made static.

The original requirement to disable interrupt was due the modification
of per-CPU counters which require interrupts to be disabled because the
counter update operation is not atomic and some of the counters are
updated from interrupt context.

All callers of __mod_objcg_mlstate() acquire a lock
(memcg_stock.stock_lock) which disables interrupts on !PREEMPT_RT and
the lockdep assert is satisfied. On PREEMPT_RT the interrupts are not
disabled and the assert triggers.

The safety of the counter update is already ensured by
VM_WARN_ON_IRQS_ENABLED() which is part of memcg_stats_lock() and does
not require yet another check.

Remove the lockdep assert from __mod_objcg_mlstate().

Fixes: 91882c1617c15 ("memcg: simple cleanup of stats update functions")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3147,8 +3147,6 @@ static inline void __mod_objcg_mlstate(s
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	lockdep_assert_irqs_disabled();
-
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);

