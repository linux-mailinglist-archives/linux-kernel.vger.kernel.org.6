Return-Path: <linux-kernel+bounces-315760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389196C69B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9911F27E05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246D1E200E;
	Wed,  4 Sep 2024 18:42:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438A1E200D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475322; cv=none; b=nMQvGc36vUkn5d+U0UK7KXBe7Z7VQSBPRgBIXAljJ7FZ319J/j2AZa3y2zvBXyovZPrzOp+8Ok8G+dD6yfh5RiVqjBsHv2syRhXdn+r2UFboqzPenOOW8/tjS1Gjq4JfoL6wWchjhbAiH53sxfZifJvTsElPZhOSMvT37mbrK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475322; c=relaxed/simple;
	bh=IJeq+Msp+aDFBgoammH53NYxHJSYn8cxb9o8XNkISYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAYEM0GqsraI69fdIybrl6WlCezqoyN/5ZYPGlRYTu7GoObhsqOwInGKI/2TlmZwa5NFqInQ7hYM+QRoHhNeVrePK+uAO9U5MXX4RpcU7XX5b7WUgNDCWvf1Yzc2BeILoyv45j1V7TE3k2KoexM+zGdryGGHlfXPv51P1rmng5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39BDEFEC;
	Wed,  4 Sep 2024 11:42:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 459E43F73F;
	Wed,  4 Sep 2024 11:41:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf/arm-cmn: Clean up unnecessary NUMA_NO_NODE check
Date: Wed,  4 Sep 2024 19:41:54 +0100
Message-Id: <00634da33c21269a00844140afc7cc3a2ac1eb4d.1725474584.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking for NUMA_NO_NODE is a misleading and, on reflection, entirely
unnecessary micro-optimisation. If it ever did happen that an incoming
CPU has no NUMA affinity while the current CPU does, a questionably-
useful PMU migration isn't the biggest thing wrong with that picture...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Just a couple more little tweaks here, paying back some co-development
from the NI driver.

 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 0266ff041e0b..62d4782da7e4 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2023,7 +2023,7 @@ static int arm_cmn_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_nod
 
 	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
 	node = dev_to_node(cmn->dev);
-	if (node != NUMA_NO_NODE && cpu_to_node(cmn->cpu) != node && cpu_to_node(cpu) == node)
+	if (cpu_to_node(cmn->cpu) != node && cpu_to_node(cpu) == node)
 		arm_cmn_migrate(cmn, cpu);
 	return 0;
 }
-- 
2.39.2.101.g768bb238c484.dirty


