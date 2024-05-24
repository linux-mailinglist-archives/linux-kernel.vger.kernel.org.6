Return-Path: <linux-kernel+bounces-188914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB68CE86F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6276BB210BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55D12E1D0;
	Fri, 24 May 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Lbgi7TeO"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D11AACC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566704; cv=none; b=cps/qEaWgZN5WrW7DQg+9yiqp9sx6DuzQ23z83MlLzKDAW8Ur7WWmCxKb7RImTtlDZTlAiW8IzNRAivw4nx24z+dl2VCe03c2LT2ogFd3CM+w0l0HTof8wsf5DLcbA7Orr0tVeu65kD+mhW1y4ZFYdog5SByKsYTw7LUZxxeHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566704; c=relaxed/simple;
	bh=bENozkYqLLbuieHyKroyUB6wlwtIHSYIRauuwhuKVCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ipggn+f0hVnzEJVDgSeL+54dmtCVz3IgsAQnvHQ9ZV7HFRL6m/YCwMCCuunFk7WZ0m9Zg68Z8RLqxcfBCRCabbUkm8uJTQeqEs/7wMYdU9BTTeGmOSEo578lhfhdnV56JqhaBtlw9pCRdXfHNwucL1FJuo5ZAAoB902HO/RRvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Lbgi7TeO; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1716566703; x=1748102703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MDXx/XnKHW1rqwed/iKvE1FGlnrLhIu2TweAuu7JpO4=;
  b=Lbgi7TeOVHxQFYa7xR2KMDL6WbMw4NHlQz2j6B3rbbHeyYevgmTIh3HS
   hXkBRB2iq4T6N65fwqQiQQJXZmqO3YM7pqVk+E4cK65vOOSFZNlNWUlt0
   dfqejuriQs1ONl6gBDSrapj7ID52O1BJ76sBLVVyUV5Cwp0szYudfAMxr
   U=;
X-IronPort-AV: E=Sophos;i="6.08,185,1712620800"; 
   d="scan'208";a="728072119"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 16:04:56 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.29.78:46947]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.87.67:2525] with esmtp (Farcaster)
 id fe603f6f-4dfe-4386-8cb7-81bd4115f331; Fri, 24 May 2024 16:04:55 +0000 (UTC)
X-Farcaster-Flow-ID: fe603f6f-4dfe-4386-8cb7-81bd4115f331
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 24 May 2024 16:04:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 24 May 2024 16:04:54 +0000
Received: from dev-dsk-stanspas-1a-2337b95e.eu-west-1.amazon.com
 (172.19.107.251) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Fri, 24 May 2024 16:04:53 +0000
From: Stanislav Spassov <stanspas@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>, James Gowans
	<jgowans@amazon.com>, Stanislav Spassov <stanspas@amazon.de>
Subject: [PATCH] cpu: Reverse order of iteration in freeze_secondary_cpus
Date: Fri, 24 May 2024 16:04:49 +0000
Message-ID: <20240524160449.48594-1-stanspas@amazon.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Whenever CPU hotplug state callbacks are registered (cpuhp_setup_state),
the startup callback is invoked on CPUs that have already reached the
provided state in order of ascending CPU id. For symmetry, we change
freeze_secondary_cpus to iterate through the CPUs in opposite order,
so that the teardown callback invocations happen in order of descending
CPU id.

One case where this is known to make a difference is the current
implementation of these callbacks in arch/x86/events/intel/uncore.c:

- uncore_event_cpu_online: designates the first CPU it is invoked for
  on each package as the uncore event collector for that package

- uncore_event_cpu_offline: if the CPU being offlined is the event
  collector for its package, transfers that responsibility over to
  the next (by ascending CPU id) one in the same package

Without reversing the order of teardowns in freeze_secondary_cpus, the
latter ends up doing the ownership transfer work on every single CPU.
That work involves a synchronize_rcu call (in perf_pmu_migrate_context),
ultimately unnecessarily degrading the performance of the CPU offlining.

Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 kernel/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index cc4a8068747c..aaa8b7d5f93e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1942,7 +1942,10 @@ int freeze_secondary_cpus(int primary)
 	cpumask_clear(frozen_cpus);
 
 	pr_info("Disabling non-boot CPUs ...\n");
-	for_each_online_cpu(cpu) {
+	for (cpu = nr_cpu_ids - 1; cpu >= 0; cpu--) {
+		if (!cpu_online(cpu))
+			continue;
+
 		if (cpu == primary)
 			continue;
 

base-commit: 266e95786452d97f42dcb9a881bba223584b9648
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


