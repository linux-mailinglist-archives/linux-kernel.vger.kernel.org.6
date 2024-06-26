Return-Path: <linux-kernel+bounces-231537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBFB9199AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4225285036
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D25192B95;
	Wed, 26 Jun 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/Wac0qx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2919049B;
	Wed, 26 Jun 2024 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436688; cv=none; b=PorW3MBqzmx1YEEGnKVcEEJQA/JeYNITOsjefsRNUItVf1ZQA/r04zGvCvR26B4VApUOHuNdPy0Up9mj1fDHwWP1XBcj/Kp+i8eDCIrKjxhayQ/QZRdVLMp8W2N0UbqyhaOKLpLJRcrHhD37R65D6t/JObQNp/jyyEtdy2KF4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436688; c=relaxed/simple;
	bh=REm3K5MgPmRQpONdIW7zODAdzetyL88KjbhiskxYUbE=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=cuubGpvRxJx+YncYw9EP7tdYzBjqK6AQemI4RhDuYRpylCKJ0Lw4Hcx9TN2XM62PSmsZzj68e/1BybPfRj60+Zu5BLpj/qOSvBpH+emuHJZIWcBwv0nFDyahGFVIjX+/rLODtgWJMK8cT9Hc5BiSBPvOunLESAWpW4SxQduSdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/Wac0qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C1C116B1;
	Wed, 26 Jun 2024 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719436688;
	bh=REm3K5MgPmRQpONdIW7zODAdzetyL88KjbhiskxYUbE=;
	h=Subject:From:To:Cc:Date:From;
	b=D/Wac0qxevcEfjBcZDFu7IFQMj7jU4HtWpIqu0UnsE2ueDdQJM712AAu2CFpsPkzm
	 V9OegwGAcqG45Q5Ikg0ns+qtqKoRSfvLPTmLJ7RyyZN9k9M+uLoz36FdZxoWvkN19v
	 vi0C+cDTKdkTH9SnrCWh4zgaoEQF7kFY0Kz2vjBLPTDa80mnzwoSDTc/MRrHwMZacG
	 t0scleUPQrexxc+1kfkPa6Df6yv8zo6x9f/gG1h/IsxuCT8GUkrD5ohnlbqO2KAaYh
	 dQQujx64oJpmy1IymKwad5QAatk3MlbkfWOQevsY8XwoeJ73PJ6sMb4BLhebfwNb6S
	 ex6hfIqtR+Ivg==
Subject: [PATCH V3 1/2] cgroup/rstat: Helper functions for locking expose
 trylock
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 23:18:03 +0200
Message-ID: <171943667611.1638606.4158229160024621051.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/cgroup/rstat.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..2a42be3a9bb3 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -279,17 +279,30 @@ __bpf_hook_end();
  * value -1 is used when obtaining the main lock else this is the CPU
  * number processed last.
  */
-static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
+static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
+{
+	bool locked;
+
+	locked = spin_trylock_irq(&cgroup_rstat_lock);
+	if (!locked)
+		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, !locked);
+
+	return locked;
+}
+
+static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
+				       bool check_contention)
 	__acquires(&cgroup_rstat_lock)
 {
-	bool contended;
+	bool locked = false;
 
-	contended = !spin_trylock_irq(&cgroup_rstat_lock);
-	if (contended) {
-		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
+	if (check_contention)
+		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
+
+	if (!locked)
 		spin_lock_irq(&cgroup_rstat_lock);
-	}
-	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
+
+	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, !locked);
 }
 
 static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
@@ -328,7 +341,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 			__cgroup_rstat_unlock(cgrp, cpu);
 			if (!cond_resched())
 				cpu_relax();
-			__cgroup_rstat_lock(cgrp, cpu);
+			__cgroup_rstat_lock(cgrp, cpu, true);
 		}
 	}
 }
@@ -348,9 +361,16 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
+	bool locked;
+
 	might_sleep();
 
-	__cgroup_rstat_lock(cgrp, -1);
+	locked = __cgroup_rstat_trylock(cgrp, -1);
+	if (!locked) {
+		/* Opportunity to ongoing flush detection */
+		__cgroup_rstat_lock(cgrp, -1, false);
+	}
+
 	cgroup_rstat_flush_locked(cgrp);
 	__cgroup_rstat_unlock(cgrp, -1);
 }
@@ -368,7 +388,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
+	__cgroup_rstat_lock(cgrp, -1, true);
 	cgroup_rstat_flush_locked(cgrp);
 }
 



