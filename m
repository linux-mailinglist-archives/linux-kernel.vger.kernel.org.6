Return-Path: <linux-kernel+bounces-217762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD9790B640
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140AEB31C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D115DBA3;
	Mon, 17 Jun 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdWzRUVJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57915D5B2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635284; cv=none; b=TzYeFcsQwZ7gU2TIzBZRRm74y8VnmMK9rkbCqBJYXTTe24DXZ2oi3KldfWoIGSOPuVqUtokRsTb6T5wd5s+v+Yf+2fbRP7RkrvIy7BSTnf/xpuRrBTXSTHTOhVZQP/d99M6UYzop8qMKSLKOErGbvrnyxUYceJNaBrL2KD2RenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635284; c=relaxed/simple;
	bh=dobE8kihQV9T60XVIDbBgNU5uvQG3tjGens1jhgmrrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tx7iVxgvWLf8K5i1Adw3JJ0aT9WUFLCg2sKqH32nlyGEyymnBIlpBhQ7eYy+DvYhfsz/ABexmOvm/OvNoEQUqsBA/m3zaqKVFCh6qVMoHy54SKY4Elzvgi7WbBJH1A0j3i7xB/pqBzLKSrDeI6hMkLqoJRBN6a7XOGnImSGq25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdWzRUVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718635282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POuuOTSCgQ9YWI6IghxXxhiMXh2n0u6EcFeF16mkX7I=;
	b=VdWzRUVJFJXtNxKC+Y/VkpUpJUMLI5lnW360SZUqR2Fzez4nm8FQw8vlsYPRIPxcYyyl2r
	5IbpF4V2kAgI/0bxHB2QXBkh1W6+J8S+6Ru1wbfp/CF/xUHD0HCpI78ZT6jJk007d4d+KK
	Wed7i/0S4u0wMzfHRgH8hj8nYKwVRuY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-dCeivIGBPLq1QD-7fHt1Aw-1; Mon,
 17 Jun 2024 10:41:18 -0400
X-MC-Unique: dCeivIGBPLq1QD-7fHt1Aw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C09C1956096;
	Mon, 17 Jun 2024 14:41:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CC1B1956048;
	Mon, 17 Jun 2024 14:41:13 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2 3/5] cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE until valid partition
Date: Mon, 17 Jun 2024 10:39:43 -0400
Message-Id: <20240617143945.454888-4-longman@redhat.com>
In-Reply-To: <20240617143945.454888-1-longman@redhat.com>
References: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The CS_CPU_EXCLUSIVE flag is currently set whenever cpuset.cpus.exclusive
is set to make sure that the exclusivity test will be run to ensure its
exclusiveness. At the same time, this flag can be changed whenever the
partition root state is changed. For example, the CS_CPU_EXCLUSIVE flag
will be reset whenever a partition root becomes invalid. This makes
using CS_CPU_EXCLUSIVE to ensure exclusiveness a bit fragile.

The current scheme also makes setting up a cpuset.cpus.exclusive
hierarchy to enable remote partition harder as cpuset.cpus.exclusive
cannot overlap with any cpuset.cpus of sibling cpusets if their
cpuset.cpus.exclusive aren't set.

Solve these issues by deferring the setting of CS_CPU_EXCLUSIVE flag
until the cpuset become a valid partition root while adding new checks
in validate_change() to ensure that cpuset.cpus.exclusive of sibling
cpusets cannot overlap.

An additional check is also added to validate_change() to make sure that
cpuset.cpus of one cpuset cannot be a subset of cpuset.cpus.exclusive
of a sibling cpuset to avoid the problem that none of those CPUs will
be available when these exclusive CPUs are extracted out to a newly
enabled partition root. The Documentation/admin-guide/cgroup-v2.rst
file is updated to document the new constraints.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 ++++--
 kernel/cgroup/cpuset.c                  | 36 ++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f886c6ad704e..722e4762c4e0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2359,8 +2359,12 @@ Cpuset Interface Files
 	is always a subset of it.
 
 	Users can manually set it to a value that is different from
-	"cpuset.cpus".	The only constraint in setting it is that the
-	list of CPUs must be exclusive with respect to its sibling.
+	"cpuset.cpus".	One constraint in setting it is that the list of
+	CPUs must be exclusive with respect to "cpuset.cpus.exclusive"
+	of its sibling.  If "cpuset.cpus.exclusive" of a sibling cgroup
+	isn't set, its "cpuset.cpus" value, if set, cannot be a subset
+	of it to leave at least one CPU available when the exclusive
+	CPUs are taken away.
 
 	For a parent cgroup, any one of its exclusive CPUs can only
 	be distributed to at most one of its child cgroups.  Having an
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fb71d710a603..144bfc319809 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -825,17 +825,41 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	/*
 	 * If either I or some sibling (!= me) is exclusive, we can't
-	 * overlap
+	 * overlap. exclusive_cpus cannot overlap with each other if set.
 	 */
 	ret = -EINVAL;
 	cpuset_for_each_child(c, css, par) {
-		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
-		    c != cur) {
+		bool txset, cxset;	/* Are exclusive_cpus set? */
+
+		if (c == cur)
+			continue;
+
+		txset = !cpumask_empty(trial->exclusive_cpus);
+		cxset = !cpumask_empty(c->exclusive_cpus);
+		if (is_cpu_exclusive(trial) || is_cpu_exclusive(c) ||
+		    (txset && cxset)) {
 			if (!cpusets_are_exclusive(trial, c))
 				goto out;
+		} else if (txset || cxset) {
+			struct cpumask *xcpus, *acpus;
+
+			/*
+			 * When just one of the exclusive_cpus's is set,
+			 * cpus_allowed of the other cpuset, if set, cannot be
+			 * a subset of it or none of those CPUs will be
+			 * available if these exclusive CPUs are activated.
+			 */
+			if (txset) {
+				xcpus = trial->exclusive_cpus;
+				acpus = c->cpus_allowed;
+			} else {
+				xcpus = c->exclusive_cpus;
+				acpus = trial->cpus_allowed;
+			}
+			if (!cpumask_empty(acpus) && cpumask_subset(acpus, xcpus))
+				goto out;
 		}
 		if ((is_mem_exclusive(trial) || is_mem_exclusive(c)) &&
-		    c != cur &&
 		    nodes_intersects(trial->mems_allowed, c->mems_allowed))
 			goto out;
 	}
@@ -1375,7 +1399,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
  */
 static int update_partition_exclusive(struct cpuset *cs, int new_prs)
 {
-	bool exclusive = (new_prs > 0);
+	bool exclusive = (new_prs > PRS_MEMBER);
 
 	if (exclusive && !is_cpu_exclusive(cs)) {
 		if (update_flag(CS_CPU_EXCLUSIVE, cs, 1))
@@ -2620,8 +2644,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		retval = cpulist_parse(buf, trialcs->exclusive_cpus);
 		if (retval < 0)
 			return retval;
-		if (!is_cpu_exclusive(cs))
-			set_bit(CS_CPU_EXCLUSIVE, &trialcs->flags);
 	}
 
 	/* Nothing to do if the CPUs didn't change */
-- 
2.39.3


