Return-Path: <linux-kernel+bounces-203925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BA8FE20C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6645928B9B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB757152164;
	Thu,  6 Jun 2024 09:01:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604A14EC71;
	Thu,  6 Jun 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664487; cv=none; b=WLkiBQ/yLfm4AIuHwSVOtY2s/J7FpZG++YpKzpr2aLSwIFq8mBQg1dVTf6l7yLio+Ha3OVe4CR9//gsgsACZuvmUpJe2wHvzQfVS6TcGc7xnNgvQ5kidAe0Npag5Zf2aJkRtc9/Y4Wg3m7H4PSBUTV4THYRnhCfFeZXTJhOErns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664487; c=relaxed/simple;
	bh=Iy/Jw+bQQcXAeMSukRlrF4oA2JnT/oc9lz2u483pIYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBlYPvVBfXR91nvRVRLUEhX1EKVzBLx0IzBz6ZiBa+fLi+aDBsp1GYfrMXcKKYCM6n5gq916H91FRdTftSQOQM/RvTK/5TT6Th82elyodBxTa2xs5aMMy6Rq+RB2Zih+5kTQ4DfaUDd2COMAu2sEyCkkIAoi60n85XTu7kwCyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6AC0339;
	Thu,  6 Jun 2024 02:01:49 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.71.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B4023F762;
	Thu,  6 Jun 2024 02:01:22 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	anna-maria@linutronix.de,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 3/6] cpuidle: teo: Don't always stop tick on one state
Date: Thu,  6 Jun 2024 10:00:47 +0100
Message-Id: <20240606090050.327614-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606090050.327614-1-christian.loehle@arm.com>
References: <20240606090050.327614-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if we have only one state, we unfortunately still need to query
expected sleep length if state0 is a proper sleep state like WFI.
This enables teo to save energy even in that scenario.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 2c427dd4cac0..216d34747e3b 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -403,7 +403,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/* Check if there is any choice in the first place. */
 	if (drv->state_count < 2) {
 		idx = 0;
-		goto out_tick;
+		if (drv->states[0].flags & CPUIDLE_FLAG_POLLING)
+			goto out_tick;
+		/*
+		 * If we only have one state and it is a proper one, check if
+		 * disabling the tick would be worth it.
+		 */
+		duration_ns = tick_nohz_get_sleep_length(&delta_tick);
+		goto end;
 	}

 	if (!dev->states_usage[0].disable)
--
2.34.1


