Return-Path: <linux-kernel+bounces-199651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC18D8A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DD1C220AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9AC13A416;
	Mon,  3 Jun 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4wKsMz1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804B3838F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443528; cv=none; b=B+ofimpiZ7E2hx0UtDWHStSRyK9dlNCMJFxvPJygZH599/ZmDpR1gE2pA8EE1iDQ6YMW1CLhiT5SicCSZ0qv64W4SpVMXvWel+yUfw7OFydfwyS6HepFMXkcUg1FV3ppodQkU3Ofj39tTDv8ompDw4z16CB3eUlV8wDTEnXpYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443528; c=relaxed/simple;
	bh=rBLf380duWASA+BHiufGZGEMzz9Q+lZrGAfvletpReU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IOZFLjqypLgNqDHFsdBxDTaTvlZQZ1FVx9TnyIUjoYCPbil9pyDE2+9RbodY9Emsb+FVhwAv0QfyyMzSWzzqpT8p37hg5zte4/4AcMl53GjBwtgtUPeTzsA3czxVehZ0mtzOKu3ZAzaaog55izgUzMXhTOGqTjDyEKRqL7cZDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4wKsMz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717443525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRP6XsL9a0oYCQIdSQy4MFeP5v2pU/iHsNba/xl+gzk=;
	b=V4wKsMz1LVCcCtq4Nh4wkjKUWtfnL/0z1nqJD4XWyU1o7Pnifi6/bKfsvI6i7j3s6CVUk2
	LBnQhpXW5OrmBgyLQa3VaSd3XdcQNB0HXg4QSid9ui36UXrDJ3hqunhbOosnCPJDYGsOT3
	FAOg0j2tLkffj61saG7R0y/lRtSixUE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-e6GYhzR6PTecxpOJjk52Hg-1; Mon, 03 Jun 2024 15:38:42 -0400
X-MC-Unique: e6GYhzR6PTecxpOJjk52Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE031184882A;
	Mon,  3 Jun 2024 19:38:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92A211C0D105;
	Mon,  3 Jun 2024 19:38:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup] cgroup/cpuset: Optimize isolated partition only generate_sched_domains() calls
Date: Mon,  3 Jun 2024 15:38:22 -0400
Message-Id: <20240603193822.1209999-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

If only isolated partitions are being created underneath the cgroup root,
there will only be one sched domain with top_cpuset.effective_cpus. We can
skip the unnecessary sched domains scanning code and save some cycles.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 315f8cbd6d35..f9b97f65e204 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -964,6 +964,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 
 	/* Special case for the 99% of systems with one, full, sched domain */
 	if (root_load_balance && !top_cpuset.nr_subparts) {
+single_root_domain:
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
 		if (!doms)
@@ -1022,6 +1023,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 	rcu_read_unlock();
 
+	/*
+	 * If there are only isolated partitions underneath the cgroup root,
+	 * we can optimize out unneeded sched domains scanning.
+	 */
+	if (root_load_balance && (csn == 1))
+		goto single_root_domain;
+
 	for (i = 0; i < csn; i++)
 		csa[i]->pn = i;
 	ndoms = csn;
-- 
2.39.3


