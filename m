Return-Path: <linux-kernel+bounces-401053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9629C1573
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECF41C21736
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EDA1C4609;
	Fri,  8 Nov 2024 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcbwLxRW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15346199BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040189; cv=none; b=EOWnwHBAS82sOJeXOdIdQ8UcPEG7csT/pkIB8VZY/8yKY2Zt+PNB08SB/OApP6iOILkcNxV//UxqVZyCrYnGZh6qQ20YisjnjidbSdkASWYLKuROPEXQYdPfoa8LYu5qFwL9FloB9OjpFmaf8aI05ZFTpp333dEmvE3bZRDYFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040189; c=relaxed/simple;
	bh=2ETS86wh1T9gkfSbS2Iz2PhobS0UrZnbDFYac9TU6zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvQ3PAkBF8uAUskid8wysIiM8bQfaS6O/Ob2Rdg7QWULyf8sqgrrhNI+6W0V4Qhmy//1M2hY1cRO7aNnglIC0oWJTDR7lJ1jWFsalGbGhuQqFherBHF8TlFBrUn53qGXA9+XpAoHXP+TaVBhRnB1DvOYRl72dsmAmiSe5UPt85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcbwLxRW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731040185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+4xzCVIv4+K0HVgfcCSdshNv9x+PRjK8RaOzmppLwds=;
	b=gcbwLxRWwofpp6dtHrySch1uuN+hlW3olHc3xYeHvK+Y2fcPRqrALR39Wo9hC5pb+gE3um
	uSlgDdCj6S2iv7y1kIfLU6Zht+9aeKdoJAXFW6/0FenhM7ZgESvyZCITrpMPPQJaoC1KiV
	CQyNktWft9w6xaQbYpUicRMENyl4o7s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-a4EviaSuMta1VFrtzGXC1w-1; Thu,
 07 Nov 2024 23:29:44 -0500
X-MC-Unique: a4EviaSuMta1VFrtzGXC1w-1
X-Mimecast-MFC-AGG-ID: a4EviaSuMta1VFrtzGXC1w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59E031955EE9;
	Fri,  8 Nov 2024 04:29:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EA181953880;
	Fri,  8 Nov 2024 04:29:39 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] sched/deadline: Skip overflow check if 0 capacity
Date: Thu,  7 Nov 2024 23:29:24 -0500
Message-ID: <20241108042924.520458-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

By properly setting up a 1-cpu sched domain (partition) with no
task, it was found that offlining that particular CPU failed because
dl_bw_check_overflow() in cpuset_cpu_inactive() returned -EBUSY. This
is due to the fact that dl_bw_capacity() return 0 as the sched domain
has no active CPU causing a false positive in the overflow check.

Fix this corner case by skipping the __dl_overflow() check in
dl_bw_manage() when the returned capacity is 0.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/deadline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index be1b917dc8ce..0195f350d6d3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3479,7 +3479,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	} else {
 		unsigned long cap = dl_bw_capacity(cpu);
 
-		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+		/*
+		 * In the unlikely case of 0 capacity (e.g. a sched domain
+		 * with no active CPUs), skip the overflow check as it will
+		 * always return a false positive.
+		 */
+		if (likely(cap))
+			overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
 
 		if (req == dl_bw_req_alloc && !overflow) {
 			/*
-- 
2.47.0


