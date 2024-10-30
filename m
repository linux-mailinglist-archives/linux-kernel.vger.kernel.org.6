Return-Path: <linux-kernel+bounces-389034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DD9B67C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5CA1C20C92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743632144D2;
	Wed, 30 Oct 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHPuIzqW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292D1FAC2A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301953; cv=none; b=bDiw/pLlbpDCs74tvUrq+ecJhfmWnW7TnTuUDu7aY723c+0HXUfd69PUVpmUwSq8HjMhvNJOW3U+gHNpwDvdHvEwZIWEx8vyp0eOxGndIX0Im/+qax2vtSdqlbAJGxQvafcY9j2YRUQtRu8/fnHtiI3aM7hMvUU8RL94JwOioWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301953; c=relaxed/simple;
	bh=XscQ+bVi3jjKbtGttvWup3T5JJPmmKuWuh6WpGbeC8I=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=svfNzJywhpuBFQBnB1uKIsuD672di7ZJukLT/On1WxcDhGxIM6XJ3/xnMAz6/HpBtHPXSwOYFEKA910xwY39YMYfxXeK8Wzx0yHwkCKs42ExDge9G+g67kfpSEuUpqpqOyRa5vcmi4+5AZdst0SkgLVojfPndq6tS6aLDXFHj2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OHPuIzqW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=hySKwNG5fYiUJP6OaBxgQPAobnHMX6aFY1uAJveg7qs=; b=OHPuIzqWJM2LMN0W86hptkIx/l
	eg1b3TU9yzW5qyrLGwSg1PvudXFbb3JSIC5X3AaX+hwtohRWliMgXBp6SuenszzDe+Ms9z2GdaF5h
	m1EqKWbcSPM5yMDf4+j26vJ3er9Ee4Vi0vPfoLEiIwfZjsodpItmTQ2xTyCg6U6ec8N7zJmfzWbuF
	yRgLKHDv9NhR+SHer/wpRBH784p45XiRNuE1bpHn7vkn85bPwwG5uQ/50KLI7m89jWuluA63F+YNi
	J+H1zPOIPPhyArJjLIR6ohqvky1NKU/PrzmdoJrjEorJ1WomXN6F+bDLGoGqhEUXF+ZACkIKmT5AT
	oGUvm/SQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZs-0000000AI27-3QPL;
	Wed, 30 Oct 2024 15:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E3D873011E4; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.602414152@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:12:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/6] sched: Re-arrange the {EN,DE}QUEUE flags
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Ensure the matched flags are in the low byte while the unmatched flags
go into the second byte.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/sched.h |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2337,26 +2337,25 @@ extern const u32		sched_prio_to_wmult[40
 #define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
-#define DEQUEUE_SPECIAL		0x10
-#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
-#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
+
+#define DEQUEUE_MIGRATING	0x10 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x20 /* Matches ENQUEUE_DELAYED */
+
+#define DEQUEUE_SPECIAL		0x0100
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
 #define ENQUEUE_MOVE		0x04
 #define ENQUEUE_NOCLOCK		0x08
 
-#define ENQUEUE_HEAD		0x10
-#define ENQUEUE_REPLENISH	0x20
-#ifdef CONFIG_SMP
-#define ENQUEUE_MIGRATED	0x40
-#else
-#define ENQUEUE_MIGRATED	0x00
-#endif
-#define ENQUEUE_INITIAL		0x80
-#define ENQUEUE_MIGRATING	0x100
-#define ENQUEUE_DELAYED		0x200
-#define ENQUEUE_RQ_SELECTED	0x400
+#define ENQUEUE_MIGRATING	0x10
+#define ENQUEUE_DELAYED		0x20
+
+#define ENQUEUE_HEAD		0x0100
+#define ENQUEUE_REPLENISH	0x0200
+#define ENQUEUE_MIGRATED	(0x0400*IS_ENABLED(CONFIG_SMP))
+#define ENQUEUE_INITIAL		0x0800
+#define ENQUEUE_RQ_SELECTED	0x1000
 
 #define RETRY_TASK		((void *)-1UL)
 



