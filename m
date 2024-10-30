Return-Path: <linux-kernel+bounces-389326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA39B6B64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1428A1F21BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368BA213EED;
	Wed, 30 Oct 2024 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw1kv51J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A921313F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310829; cv=none; b=YwryR3y1QaPfh/iLQf5p9EnIxdBqtzmfEmf/Zuzu02sVHI5SU7LkLMgjsKqXAeODzsf2ujVD1Fs8G05WwZYXzQqdjuZSC0ywHz85t+c9m19Xdj7iJzPoaU6xMpW7QW/C1J0AqvR6z7FYhr9IO7aJkFgjaCZhn9j3Wm+Q7tmdplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310829; c=relaxed/simple;
	bh=yghUm+iCzQZWjznzIjU5ZpOutOU9ZOKU1YjDLNkq+7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxsRN4Oj7bB8xBcMQbgbkOSAcV07Psb/3fZL4h9MPCGDmaVov4MtuGP/XfmtwFj94w6mlhRVzRCAViL6RSF04fkV1fmlR//uKmAKpmZmhKGrGKvZt5cSLL5E7+uN2vnFLkz8KsAy02GrbsKH6OhDdVkYYMODzZTOtUZqmTRrv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw1kv51J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730310826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCfJJQzrDJuV7NXoHO3WL1fpfNRacCThoNNgfJ3p6D8=;
	b=dw1kv51Jl5T+iQsW8Unoxvf9Sb8FgQyrAHcpe8/3g3uu0KgEfRuN0euB0cyzLGes9HlPaA
	muHo/E8hpwPH+iTMXCzwiemKltjqbvNncOIBD7O69TxLWwyL512sS5fZX/I8ULh0YkIL7p
	BTtMjDU+LUIuZszDsqpCl0cx9kvoz8Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-AyZjmNOdPBqv5kguHeFt4w-1; Wed,
 30 Oct 2024 13:53:42 -0400
X-MC-Unique: AyZjmNOdPBqv5kguHeFt4w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3853C1955F42;
	Wed, 30 Oct 2024 17:53:40 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFC8719560A2;
	Wed, 30 Oct 2024 17:53:37 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RESEND PATCH v4 3/4] sched/isolation: Consolidate housekeeping cpumasks that are always identical
Date: Wed, 30 Oct 2024 13:52:52 -0400
Message-ID: <20241030175253.125248-4-longman@redhat.com>
In-Reply-To: <20241030175253.125248-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
 <20241030175253.125248-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The housekeeping cpumasks are only set by two boot commandline
parameters: "nohz_full" and "isolcpus". When there is more than one of
"nohz_full" or "isolcpus", the extra ones must have the same CPU list
or the setup will fail partially.

The HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are settable by
"isolcpus" only and their settings can be independent of the other
types. The other housekeeping types are all set by "nohz_full" or
"isolcpus=nohz" without a way to set them individually. So they all
have identical cpumasks.

There is actually no point in having different cpumasks for these
"nohz_full" only housekeeping types. Consolidate these types to use the
same cpumask by aliasing them to the same value. If there is a need to
set any of them independently in the future, we can break them out to
their own cpumasks again.

With this change, the number of cpumasks in the housekeeping structure
drops from 9 to 3. Other than that, there should be no other functional
change.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 20 +++++++++++++-------
 kernel/sched/isolation.c        | 19 ++++++-------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 499d5e480882..d8501f4709b5 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,15 +7,21 @@
 #include <linux/tick.h>
 
 enum hk_type {
-	HK_TYPE_TIMER,
-	HK_TYPE_RCU,
-	HK_TYPE_MISC,
-	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
-	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KTHREAD,
-	HK_TYPE_MAX
+	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MAX,
+
+	/*
+	 * The following housekeeping types are only set by the nohz_full
+	 * boot commandline option. So they can share the same value.
+	 */
+	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 6a686322ce3c..81bc8b329ef1 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,14 +9,9 @@
  */
 
 enum hk_flags {
-	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
-	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
-	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
-	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -96,7 +91,7 @@ void __init housekeeping_init(void)
 
 	static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping.flags & HK_FLAG_TICK)
+	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
 		sched_tick_offload_init();
 
 	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
@@ -120,7 +115,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	unsigned int first_cpu;
 	int err = 0;
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
 			pr_warn("Housekeeping: nohz unsupported."
 				" Build with CONFIG_NO_HZ_FULL\n");
@@ -176,7 +171,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 			housekeeping_setup_type(type, housekeeping_staging);
 	}
 
-	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK))
+	if ((flags & HK_FLAG_KERNEL_NOISE) && !(housekeeping.flags & HK_FLAG_KERNEL_NOISE))
 		tick_nohz_full_setup(non_housekeeping_mask);
 
 	housekeeping.flags |= flags;
@@ -194,8 +189,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+	flags = HK_FLAG_KERNEL_NOISE;
 
 	return housekeeping_setup(str, flags);
 }
@@ -214,8 +208,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
-				 HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD;
+			flags |= HK_FLAG_KERNEL_NOISE;
 			continue;
 		}
 
-- 
2.43.5


