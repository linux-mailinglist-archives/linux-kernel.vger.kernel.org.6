Return-Path: <linux-kernel+bounces-315752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71196C685
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E681C226CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D78E1E4112;
	Wed,  4 Sep 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa+q0e7S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331951E2039
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475032; cv=none; b=JdoJ2jqgFfNkSTJDde9HGXiRAzcPHkJkrtiz0GAq8b3NjdbICuUiYfar12H49UuDc1fJlYF1tZ+uBhtOOW4QLbnafxwg0J8MWxLhQ5EhzZ0P2ysoR/XJ35UODhIvvZXVz/o/gmOs8xULCihJECGhCBttuhdMDUoyqkcuwGjUUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475032; c=relaxed/simple;
	bh=Qz1oHXsGRvkul0CPue8xzPHrcvGU8z6RPHX1YAy5KnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhBPT2MdfDxVa2pZtvBeur7roPIIIgebWHMoaeoq+NcM0no/eQ4+J6bkoDZ2t4g1FP/aBzAGMMPrD0sxGya0xS9dQfLBCFMejaHJSUCWfRZ+i8jvPnEJnErwSVGNfUQPKQ6XToW/GtfZhCrx9rBVoc61wBfYgE48ASjLOx1df1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa+q0e7S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725475030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H5gC7elI8FcKQ992DZVgo/TSNWN3fufuNC65WmyMao8=;
	b=Xa+q0e7S2zvzH9Vkwd9GlMhwC6W7uQs2Bz6jN3lb/E25F7APVSgiB5/xvsI/waxuS7jQC8
	Lut9NgOZqITPpLKirCwS6Mo0fEHyT/Sfje2XivMR4CkH12sAYF5jX78NatrrEEPxGQTjHF
	2Y/nWq7U1v1k/j0wj1QtNaE98u3/d0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-qtzUgY4DPESSsuF5uZbl5g-1; Wed,
 04 Sep 2024 14:37:05 -0400
X-MC-Unique: qtzUgY4DPESSsuF5uZbl5g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42B651955F07;
	Wed,  4 Sep 2024 18:37:04 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.172])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 749B51955F45;
	Wed,  4 Sep 2024 18:37:01 +0000 (UTC)
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
Subject: [PATCH v3 2/2] sched/isolation: Consolidate housekeeping cpumasks that are always identical
Date: Wed,  4 Sep 2024 14:36:50 -0400
Message-ID: <20240904183650.1053708-3-longman@redhat.com>
In-Reply-To: <20240904183650.1053708-1-longman@redhat.com>
References: <20240904183650.1053708-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The housekeeping cpumasks are only set by two boot commandline
parameters: "nohz_full" and "isolcpus". When there is more than one of
"nohz_full" or "isolcpus", the extra ones must have the same CPU list
or the setup will fail partially.

The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
settable by "isolcpus" and they can be set individually. The other
housekeeping types are all set by "nohz_full" without a way to set them
individually. So they all have identical cpumasks.

There is actually no point in having different cpumasks for these
"nohz_full" only housekeeping types. Consolidate these types to use the
same cpumask by aliasing them to the same value. If there is a need to
set any of them independently in the future, we can break them out to
their own cpumasks again.

With this change, the number of cpumasks in the housekeeping structure
drops from 9 to 4. There is no other functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h | 18 ++++++++++++------
 kernel/sched/isolation.c        |  9 ++-------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 499d5e480882..e2c42172de82 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,15 +7,21 @@
 #include <linux/tick.h>
 
 enum hk_type {
-	HK_TYPE_TIMER,
-	HK_TYPE_RCU,
-	HK_TYPE_MISC,
 	HK_TYPE_TICK,
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
+	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
 #ifdef CONFIG_CPU_ISOLATION
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5345e11f3d44..61d0f97341c3 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,14 +9,10 @@
  */
 
 enum hk_flags {
-	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
-	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
-	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
 	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
+	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -194,8 +190,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+	flags = HK_FLAG_TICK | HK_FLAG_KERNEL_NOISE;
 
 	return housekeeping_setup(str, flags);
 }
-- 
2.43.5


