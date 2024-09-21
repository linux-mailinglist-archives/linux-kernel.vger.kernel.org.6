Return-Path: <linux-kernel+bounces-334931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B80497DE72
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B91C20C31
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA157CB1;
	Sat, 21 Sep 2024 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJpSZAkt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3086126BF3
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726945687; cv=none; b=RLTzU0ZiQHazxU+9viM+wzv/lAxpNn+GHrZfUFtJ9PtuS0WkUbPAmzO4D5aAqk5DJrIUXK9ZbWAfFvshuJAUD9BKtJlpgZU0UGJEyWvtKpZZWYwsIvAjwFeDqr9g3+D5epssejhDoff2VIYMo/4yuKkvv8qf0MpwdqNCIfiT/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726945687; c=relaxed/simple;
	bh=VQeNTpXMIwAp46t86U24dnCwflvwKJxs+ep3wJU+cj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oczdLGRCEzQJmYMm7IKf/HDZgBfaAKYDl3RhXFVMP2UENClz8zPwRRFfwmEmfsZegArBCZZrga2JdEVvNE3+hwNKgL+NNSto+yxw5tnOxkykXaNa/KcyAm83hJWnVQM8y0ZPUIle/k8iBaYn9fkD6QWOhI0pca1d9pkOxOw2b4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJpSZAkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726945684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgVcm3Qd2yD7/d4w7weoF1xnG5k0KKeLeGB66utTa4g=;
	b=DJpSZAktWF4KEI0DIu0aFWPHlNfL7/6+bW0RWI55SDF9jzKDWPp0HfWKxJugUwDBrhGsWn
	mWyIVWztQu/mEiSqEp/k5pi5VHLxDG5DPeGpdarLPe7Jkmy5EECO6p5tWG3coOB2JH+zBe
	zgyrx2WLz6FT1v+eqt8lQJ+z9GhFQAw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-_2XP1_9BNFGVHI8Sc1_a2A-1; Sat,
 21 Sep 2024 15:08:01 -0400
X-MC-Unique: _2XP1_9BNFGVHI8Sc1_a2A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDEA5192E27C;
	Sat, 21 Sep 2024 19:07:59 +0000 (UTC)
Received: from llong.com (unknown [10.45.224.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9650219560AB;
	Sat, 21 Sep 2024 19:07:55 +0000 (UTC)
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
Subject: [PATCH v4 2/4] sched/isolation: Make "isolcpus=nohz" equivalent to "nohz_full"
Date: Sat, 21 Sep 2024 15:07:18 -0400
Message-ID: <20240921190720.106195-3-longman@redhat.com>
In-Reply-To: <20240921190720.106195-1-longman@redhat.com>
References: <20240921190720.106195-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The "isolcpus=nohz" boot parameter and flag were used to disable tick
when running a single task.  Nowsdays, this "nohz" flag is seldomly used
as it is included as part of the "nohz_full" parameter.  Extend this
flag to cover other kernel noises disabled by the "nohz_full" parameter
to make them equivalent. This also eliminates the need to use both the
"isolcpus" and the "nohz_full" parameters to fully isolated a given
set of CPUs.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 kernel/sched/isolation.c                        | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8337d0fed311..4e664587943f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2424,7 +2424,9 @@
 			specified in the flag list (default: domain):
 
 			nohz
-			  Disable the tick when a single task runs.
+			  Disable the tick when a single task runs as well as
+			  disabling other kernel noises like having RCU callbacks
+			  offloaded. This is equivalent to the nohz_full parameter.
 
 			  A residual 1Hz tick is offloaded to workqueues, which you
 			  need to affine to housekeeping through the global
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5345e11f3d44..6a686322ce3c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -209,9 +209,13 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	int len;
 
 	while (isalpha(*str)) {
+		/*
+		 * isolcpus=nohz is equivalent to nohz_full.
+		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK;
+			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
+				 HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD;
 			continue;
 		}
 
-- 
2.43.5


