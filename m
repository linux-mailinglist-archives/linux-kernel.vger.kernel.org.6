Return-Path: <linux-kernel+bounces-210176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5D4904075
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD52282C52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA73839C;
	Tue, 11 Jun 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYrmGG+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAB125A9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121044; cv=none; b=iYScSqHC4mXTH08ezC5Hb8KYOdkFw5+oiCWzm4f5nnCJO6Nx7Nc8SDnH8DfGvcVs28qAz2bWEJ8I1NkzSMpvA49QbAYft3mTVdWgsb74XIKJukXdXbqJagGCkKk/f5J68bQfuOOKKvbI6T2A+nvmpvYKdQCjUhivgo+rcd+4DyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121044; c=relaxed/simple;
	bh=jI5NwtYOV0N7nO4N65St6X+X54gw21IY5Jfh68MvKFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWBI89aC5vcZ7K/+BXKfJyEldVJSV+klbCGK7ePZPR/lCxdMpA8bt+wOpgtz0NyWJR9M0NmSm8KCRrEjd8MgxMusmRTsLkKfAhZb2dbMG+fB2J4uYnWmxuanGPVoVtdskN6HTvGJq0XVbzgwTcQpn+3AuDFjDo3rquFfghBs1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYrmGG+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54342C2BD10;
	Tue, 11 Jun 2024 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718121043;
	bh=jI5NwtYOV0N7nO4N65St6X+X54gw21IY5Jfh68MvKFc=;
	h=From:To:Cc:Subject:Date:From;
	b=cYrmGG+VOiG6F1oIC4PjKOeTRoG9mBdxYDYssNT0OBR+iPB3Rc1sm7gawmmu/GyZv
	 LNTZ+61jUVnWtOsWn0T+JcOEniZNnyqLai4LqJvZCzskRl6i1adksxDE0R2fnyg1Ts
	 hIcjD7tX9KIWQYng1N6aXsj3Szci5/yifH/yZThbSULOMaR7G5W76lnVK6jTjPVy5a
	 wgqzGZdldEIDM4PMCmhtx6YM4KGRLV8+POTyz7HbiVhsXW/mkT6CeM6mBlrDFBASLo
	 uzBQj2TDAZOQfHOZiOxwD3ZrErTlTtsym6V4nkec9KR4t+pc+T58VqmF8cmWQDaGly
	 vvOMH7R9oD51g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_pmuv3: Avoid assigning fixed cycle counter with threshold
Date: Tue, 11 Jun 2024 09:50:12 -0600
Message-ID: <20240611155012.2286044-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user has requested a counting threshold for the CPU cycles event,
then the fixed cycle counter can't be assigned as it lacks threshold
support. Currently, the thresholds will work or not randomly depending
on which counter the event is assigned.

While using thresholds for CPU cycles doesn't make much sense, it can be
useful for testing purposes.

Fixes: 816c26754447 ("arm64: perf: Add support for event counting threshold")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..2612be29ee23 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -939,9 +939,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
+	bool has_threshold = !!(hwc->config_base & ARMV8_PMU_EVTYPE_TH);
 
 	/* Always prefer to place a cycle counter into the cycle counter. */
-	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
+	if ((evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) && !has_threshold) {
 		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return ARMV8_IDX_CYCLE_COUNTER;
 		else if (armv8pmu_event_is_64bit(event) &&
-- 
2.43.0


