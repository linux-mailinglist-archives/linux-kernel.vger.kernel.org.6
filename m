Return-Path: <linux-kernel+bounces-291276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1695602C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFC01C20E68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312B1586FE;
	Sun, 18 Aug 2024 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4mn+xtR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7E15820E
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024753; cv=none; b=KOkhGFoQ1UaWIctc0kMjKXlRyLUgvTiLLC8MgArZiyjl+WyCsjNueDFNcDu3e8IvLOXs3LKnGQUWbzkeKEyhkKn0aeUljgCybwsBq+AJFzVG1diQ+ilrd1NvwE7CbV96s8e1wkzcZPKXLnbyluZ/AtkdZVvmf1XEKnT84YI5gTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024753; c=relaxed/simple;
	bh=XOlQmKZDd/hS2AHZREtht9w0eGjuUONoLydr4hn+1iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOBdOzHwgOYhXKXeYfvJpTyhj81bwsBUCPoilb8Mc7ixWBa1nHAJBC898ihLkttp3WwX7x4nQIHp4aykIazB8zTCDdBbwzDQpnUWk3A/1MhNn359qK9KzaYIelVyb8ZD7ouItq49s3sWGHbPlDi+aqTsV6iZgXqnQIcmWDCVVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4mn+xtR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724024750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XtqgvsLkkNoGss1scYw2thSuYRWAooGUrCtmGuXgX0=;
	b=N4mn+xtRRXLhNWIxqBjEAJlZn0xnB7BAp53MaxaYQv57fTmlUg3sIgzEthC60HrN2173ih
	s9dhp42/M+Ra/Wxhowo5p9GrMntCpYvjC1gM1AHSd/AqzwitKEJdCMLaVDbCMaYggUz+en
	uaJ/E4eZjLeK+IuTvmK02effXIkbGzQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Ov74qOUzNvq2X4sjS2qzzQ-1; Sun,
 18 Aug 2024 19:45:44 -0400
X-MC-Unique: Ov74qOUzNvq2X4sjS2qzzQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECD871956095;
	Sun, 18 Aug 2024 23:45:42 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88BE530001A4;
	Sun, 18 Aug 2024 23:45:40 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] sched/isolation: Consolidate housekeeping cpumasks that are always identical
Date: Sun, 18 Aug 2024 19:45:20 -0400
Message-ID: <20240818234520.90186-4-longman@redhat.com>
In-Reply-To: <20240818234520.90186-1-longman@redhat.com>
References: <20240818234520.90186-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The housekeeping cpumasks are only set by two boot commandline
parameters: "nohz_full" and "isolcpus". When there is more than one of
"nohz_full" or "isolcpus", the extra ones must have the same CPU list
or the setup will fail partially.

The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
settable by "isolcpus" and they can be set individually. The other
housekeeping types are all set by "nohz_full" without a way to set them
individually. So they all have identical cpumasks.

There is actually no point to have different cpumasks for these
"nohz_full" only housekeeping types. Consolidate these types to use the
same cpumask by aliasing them to the same value. If there is a need to
set any of them independently in the future, we can break them out to
their own cpumasks again.

With this change, the number of cpumasks in the housekeeping structure
drops from 9 to 4.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..da32b502f0c6 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -7,15 +7,22 @@
 #include <linux/tick.h>
 
 enum hk_type {
-	HK_TYPE_TIMER,
-	HK_TYPE_RCU,
-	HK_TYPE_MISC,
-	HK_TYPE_SCHED,
 	HK_TYPE_TICK,
 	HK_TYPE_DOMAIN,
-	HK_TYPE_WQ,
 	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KTHREAD,
+	HK_TYPE_NOHZ_FULL,
+
+	/*
+	 * The following housekeeping types are only set by the nohz_full
+	 * boot commandline option. So they can share the same value.
+	 */
+	HK_TYPE_TIMER   = HK_TYPE_NOHZ_FULL,
+	HK_TYPE_RCU     = HK_TYPE_NOHZ_FULL,
+	HK_TYPE_MISC    = HK_TYPE_NOHZ_FULL,
+	HK_TYPE_SCHED   = HK_TYPE_NOHZ_FULL,
+	HK_TYPE_WQ      = HK_TYPE_NOHZ_FULL,
+	HK_TYPE_KTHREAD = HK_TYPE_NOHZ_FULL,
+
 	HK_TYPE_MAX
 };
 
-- 
2.43.5


