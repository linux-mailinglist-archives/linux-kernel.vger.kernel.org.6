Return-Path: <linux-kernel+bounces-259008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055FE938FED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A9F1F21B8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113D16D308;
	Mon, 22 Jul 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVN0xUXN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232481D696
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655050; cv=none; b=SjLuOBAV1ueozPhOmFID3uMAN2ZTCijWAPupc7qf7ULkQQ6M8bCR2cD6tk5aMjdEZYav0nsCrI9JWCrjie9npe7ceTZ8s7LVWLYTHNHjbOI5p83m/kYp2v0os5Z4gI6vwEbVNBSoK0ww0nSuUR8MBBHDlg0j0WllbiH4yWfwdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655050; c=relaxed/simple;
	bh=wxUfb/wlT54eP2F5Do3fs3n8BtkwDPNv8wvwn4/nLJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmHsnPP/j7HAj/zNnjDc2cD9pd9b/9gcAiSmVzHakPameXndFjrsWhADXIZtYeoc/Vl0NwAkKFg9hFL7asVLQbA8++tAMgw1Z7TlMaO5gA0CWh0t0yIHpNhM2iLYxwz7NDTyxgJx7BSl8hOp45bu71+UevHMYyUvWrXmd1YoRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVN0xUXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721655048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JiCyYRFuy5v8F5eeKAeQW3EVmqlEaRdFYIcnxRfg3c=;
	b=CVN0xUXNFcM9w1mZ6H0FBAHwy1h4Y03rGHFNiN8Mr7r5l1eftxXeNbDv2otOFN4ShBY7Z5
	PlODCutSd1fVr4C4BtgPvMUkbY4HxjJUQGwWfxX2rFDJP8VS286nK4rBO7jRVb1zytH04E
	SJF5d0J+zg/MyFYTdAnGBDkKxc5exAc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-MKZOIDNuMd69Plzaa5bcKg-1; Mon,
 22 Jul 2024 09:30:45 -0400
X-MC-Unique: MKZOIDNuMd69Plzaa5bcKg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00F2B18EB2EE;
	Mon, 22 Jul 2024 13:30:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.96.134.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A338B1955BF6;
	Mon, 22 Jul 2024 13:30:23 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 2/3] sched/deadline: avoid redundant check for boosted task
Date: Mon, 22 Jul 2024 10:29:26 -0300
Message-ID: <20240722132935.14426-3-wander@redhat.com>
In-Reply-To: <20240722132935.14426-1-wander@redhat.com>
References: <20240722132935.14426-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

enqueue_dl_entity only calls setup_new_dl_entity if the task is not
boosted, so the WARN_ON check is unnecessary.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/sched/deadline.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 312e8fa7ce94..908d5ce79425 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -785,12 +785,11 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
  * one, and to (try to!) reconcile itself with its own scheduling
  * parameters.
  */
-static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
+static inline void __setup_new_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
-	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
 
 	/*
@@ -809,6 +808,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	replenish_dl_new_period(dl_se, rq);
 }
 
+static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
+{
+	WARN_ON(is_dl_boosted(dl_se));
+	__setup_new_dl_entity(dl_se);
+}
+
 /*
  * Pure Earliest Deadline First (EDF) scheduling does not deal with the
  * possibility of a entity lasting more than what it declared, and thus
@@ -1755,7 +1760,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if ((flags & ENQUEUE_RESTORE) &&
 		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
-		setup_new_dl_entity(dl_se);
+		__setup_new_dl_entity(dl_se);
 	}
 
 	__enqueue_dl_entity(dl_se);
-- 
2.45.2


