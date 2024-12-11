Return-Path: <linux-kernel+bounces-441264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E29ECC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB051666BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C39022912F;
	Wed, 11 Dec 2024 12:26:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07E1AF0D8;
	Wed, 11 Dec 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919991; cv=none; b=cuTWIJLJZXpkMPgWr5fr0NlWoiGgI8PS9lUPPYygFaTbz7JzuWTIiLXnuOYPN/JTi8SM1e9pt+xmJKUsq1wbzwKZDt+SLC3Uls241YD32bG4uT+LqQ6EsikNFtVLFDp2qIEW/3UpfUSm/eq4Jz4aVCShgoJ5fGZTkaHqbZpmusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919991; c=relaxed/simple;
	bh=DOc0cHF0YJN5zNirMv5yMsYZg+/U1TycZSF5KDmMGdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO56FzMOXkxXSoNEr5dp/2sgYlf/KAjT4C9yYgUD+d0As5LqELPGQh2AhJSWmtG0xwJIkGyMM4xCnKaCb+gwY4L4ITQ/JVEr7l5URuFtLy4B+v1Dwt6/AaC6QOLLPo5RbsmUBG63wo48cCFl1v+aZU+6GqOvkJ5W+TNlv9DsC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37BD91063;
	Wed, 11 Dec 2024 04:26:57 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.37.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7BD03F5A1;
	Wed, 11 Dec 2024 04:26:26 -0800 (PST)
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Subject: [PATCH 1/2] cpufreq: amd-pstate: Use CPUFREQ_POLICY_UNKNOWN
Date: Wed, 11 Dec 2024 12:26:04 +0000
Message-Id: <20241211122605.3048503-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211122605.3048503-1-christian.loehle@arm.com>
References: <20241211122605.3048503-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

epp_policy uses the same values as cpufreq_policy.policy and resets
to CPUFREQ_POLICY_UNKNOWN during offlining. Be consistent about
it and initialize to CPUFREQ_POLICY_UNKNOWN instead of 0, too.

No functional change intended.

Cc: Huang Rui <ray.huang@amd.com>
Cc: <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516..546e69cbdf76 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1449,7 +1449,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		return -ENOMEM;
 
 	cpudata->cpu = policy->cpu;
-	cpudata->epp_policy = 0;
+	cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
 
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
-- 
2.34.1


