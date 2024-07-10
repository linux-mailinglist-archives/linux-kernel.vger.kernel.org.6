Return-Path: <linux-kernel+bounces-248081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E269692D82E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970CC1F22053
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D9195B08;
	Wed, 10 Jul 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxLi6BBJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D21F22066
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635851; cv=none; b=psWPkBwayd9LLXouS6cwBlCQVyl/pnJgkfEatGf4gWY4lKic54RlI204oDMF1OY6xB2LXFFwrRUrrYKQNT3GNRzgrweTvOaoqLv0qlheUltzKZFrnQG2CY/IHUVP/RnKOoTwjDpE95SoxVnJ16zV8BCpd6XqjRnE5FGk+mBVCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635851; c=relaxed/simple;
	bh=8SZKFJyedywx5ZvuuHTT1yzw/aUPfNyJ0LEd/6JrPTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SO8ghpejlGQ3LiuqESyteuyz7fUe+0RI5Ir9DOdcoyaCXEuJaL7zF0YPeEJyS6VMo2qdOV9nOzR8uDshcZBGapPnnk3yp6Vyqk0/U2WOxhYU7Ps/crkoBhXe03qG61liAm0XJVgPCNDQLGJDCTdWKks9I2PRwj8BN4oTSFa+Frw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxLi6BBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EBCC32781;
	Wed, 10 Jul 2024 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720635851;
	bh=8SZKFJyedywx5ZvuuHTT1yzw/aUPfNyJ0LEd/6JrPTw=;
	h=From:To:Cc:Subject:Date:From;
	b=GxLi6BBJwK5U8yqeJk0jx4GtVjdaV+COb7/MOEA/asH2MGcHHANg4Btt1al822Biz
	 dVfKWcIW7e7hOqXIR/GHH4pLJKmLwWEWezCP7Fk+YhkdMtc3XHjADRYnZJteWDCN10
	 QNBXFuDAXhNyvZ4dZTpMg2mM7Tna3JV+vZ1/NsZrgMm7Iep6qSqQwCBVAi//yvhdwL
	 IcCJ8zDv5vVbiNJcrNAsOg3ZDhQJwH5F03I3HAPsm635CjtPbb7HCEzvTW+G9T3FwU
	 6Oy1TMDPVLjmZ0Xx0aBrzHKLsloXLnadiXsh62mGtAD4+V2/+0gKaYxLAxbc/LX3xS
	 MLWWTcV4hRllQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_pmuv3: Fix chained event check for cycle counter
Date: Wed, 10 Jul 2024 12:23:56 -0600
Message-ID: <20240710182357.3701635-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to
counter remapping"), armv8pmu_event_is_chained() is incorrectly
returning that the cycle counter is chained, but the cycle counter has
always been 64-bit. The result is trying to configure counter #30 which
typically doesn't exist.

As ARMV8_PMU_MAX_GENERAL_COUNTERS is the number of counters (31), the
comparison to the counter index needs to be '<' rather than '<='.

Fixes: b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to counter remapping")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 3b3a3334cc3f..0e22c68fb804 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -482,7 +482,7 @@ static bool armv8pmu_event_is_chained(struct perf_event *event)
 	return !armv8pmu_event_has_user_read(event) &&
 	       armv8pmu_event_is_64bit(event) &&
 	       !armv8pmu_has_long_event(cpu_pmu) &&
-	       (idx <= ARMV8_PMU_MAX_GENERAL_COUNTERS);
+	       (idx < ARMV8_PMU_MAX_GENERAL_COUNTERS);
 }
 
 /*
-- 
2.43.0


