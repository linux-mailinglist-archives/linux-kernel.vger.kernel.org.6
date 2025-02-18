Return-Path: <linux-kernel+bounces-520124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6FA3A5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885273A2C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D81EB5D2;
	Tue, 18 Feb 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwKR9qll"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757617A31E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904362; cv=none; b=Avc/Ru5t426XGkCMP84Xok3ecVc7aEGf9AsPLH2hYLiltWmOkxf7EKikWEDq/M7y/nMQqMrxayIXpEJnvX7ao7y4AjEjaRHpZDRLs4GtIA1+uUSpV5H/zamp3uuauBVrK6eaacavX76pp7bv3tx+txGiImqmK2F8JToEisx4oio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904362; c=relaxed/simple;
	bh=vQeAMQ20Md0VXJePIigD/ZqFsxA/4VdAZ57FkI5QmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Za4aVMP9s6mhRqKFDOj1m717bQuLkxKg6jt7J5Li1/8Ot+UX/tQvbH9KMNMKaDqphIiPEngImdYSQOMK/hahvmbrffpxazePcNhQZHupe5/48hJBiBjCozwoG4lj4OPeOb3sXfylbnBZVsDQJGjrNaJm1FSugno28Dt8SIE+AQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwKR9qll; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739904359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZF5tpF6UJnnsQsQZhKc0GP3aet9jKbVyzU4KMF0FyoM=;
	b=OwKR9qll0MwCQuXa6VKbIAxtKk5HYnvbtTCP/yqRQ1Q04QtmRC5WxwAMoYdbgjzFHr51EO
	64Hbtm8cU8cp7tfCgZU8921f8zs7zfeG/ZA0IVQDT11rk3wmOSqqqp/RUdwS1WdhJYZvwe
	cCjV6AeEM4j1zVg5fl5P0jN4AbH6Y+s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-7PkcZ5D4Pz-RpiYNv5aymA-1; Tue,
 18 Feb 2025 13:45:53 -0500
X-MC-Unique: 7PkcZ5D4Pz-RpiYNv5aymA-1
X-Mimecast-MFC-AGG-ID: 7PkcZ5D4Pz-RpiYNv5aymA_1739904352
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FF511800875;
	Tue, 18 Feb 2025 18:45:52 +0000 (UTC)
Received: from isengard.. (vm-10-0-109-147.hosted.upshift.rdu2.redhat.com [10.0.109.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C57CB300019F;
	Tue, 18 Feb 2025 18:45:50 +0000 (UTC)
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v2] sched/isolation: Make use of more than one housekeeping cpu
Date: Tue, 18 Feb 2025 18:46:18 +0000
Message-ID: <20250218184618.1331715-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The exising code uses housekeeping_any_cpu() to select a cpu for
a given housekeeping task. However, this often ends up calling
cpumask_any_and() which is defined as cpumask_first_and() which has
the effect of alyways using the first cpu among those available.

The same applies when multiple NUMA nodes are involved. In that
case the first cpu in the local node is chosen which does provide
a bit of spreading but with multiple HK cpus per node the same
issues arise.

We have numerous cases where a single HK cpu just cannot keep up
and the remote_tick warning fires. It also can lead to the other
things (orchastration sw, HA keepalives etc) on the HK cpus getting
starved which leads to other issues.  In these cases we recommend
increasing the number of HK cpus.  But... that only helps the
userspace tasks somewhat. It does not help the actual housekeeping
part.

Spread the HK work out by having housekeeping_any_cpu() and
sched_numa_find_closest() use cpumask_any_and_distribute()
instead of cpumask_any_and().

Signed-off-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/

---

v2: Fix subject line. Update commit message. No code change. 

 kernel/sched/isolation.c | 2 +-
 kernel/sched/topology.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 81bc8b329ef1..93b038d48900 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
 			if (likely(cpu < nr_cpu_ids))
 				return cpu;
 			/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..94133f843485 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 	for (i = 0; i < sched_domains_numa_levels; i++) {
 		if (!masks[i][j])
 			break;
-		cpu = cpumask_any_and(cpus, masks[i][j]);
+		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
 		if (cpu < nr_cpu_ids) {
 			found = cpu;
 			break;
-- 
2.47.1


