Return-Path: <linux-kernel+bounces-395417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0579BBDAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDBE1C21C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF91CBE85;
	Mon,  4 Nov 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikmH/Waf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC41CBE82
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747186; cv=none; b=Kb2hJNEA+LBEBw0ddr/XwzD6BYeZBHuRXbEHJRqdXrz4a1yYak8qEkLbelFgAmJNs/adKqkeNLB5hwuZo0p5u5+s0Y3c8f4vi72M93jzB82KraD0rjDd4SuQl521lmJMDwjtweHoje5M7Hyt6F0isHgQgKCpUO7pkbgYDtuOE4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747186; c=relaxed/simple;
	bh=wMGuXVghL+bQd4b7q/UhbB4pOglwKLk0XTn4dCQA4jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4ZT/XYkbRkhMq9DBZVK+gtMwQRPddlcIj794HqhkFx4xaACqjU6nCMI+eavCik/yUssC3/iC5lu8+eZgYGRg7rFR0889z5GIdr3P0hGb1KXFBQKSLnQgOu9XuJJSpZpMh/bTuyhOCe0ftaZtwcukp+LYY8M/cM89h12HnFqRQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikmH/Waf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D51BC4CECE;
	Mon,  4 Nov 2024 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747185;
	bh=wMGuXVghL+bQd4b7q/UhbB4pOglwKLk0XTn4dCQA4jA=;
	h=From:To:Cc:Subject:Date:From;
	b=ikmH/Wafqqp/NoIKBlkRHVfaRHzrw3vGSly8hlCNwdqk0x9QZUldb7kfdRkLsdpUG
	 P1vqv4hv2lICBkPn9vRKJXsiYuQ3XJbqFf++EHJW47uCS2nlTtLLeMCJCTEclYHZEp
	 z2gsgkxg48IykI3mkKVKMTVSQ7QhLfh61SfSYc8tXETcklhwi0hDnB2GhfrZRFbR+w
	 twCl+Jh+4S1LOYsWULZa3yYnROMMnBi6n6sNYrAl9HYBVdZH068VE1E9Qp67pvNq7d
	 eHjgwpVPSN7O3ebrm+o2FT3ZEUEIvlQAP4UAAdVv8Cyj95KrcHgL+PS4/FBazY46Ha
	 U+Tj9dVeS8lvg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:05:06 -0600
Message-ID: <20241104190505.272805-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c       | 2 +-
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 03733101e231..7bd099f728a9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1430,7 +1430,7 @@ static int __init arch_timer_of_init(struct device_node *np)
 
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
-	has_names = of_property_read_bool(np, "interrupt-names");
+	has_names = of_property_present(np, "interrupt-names");
 
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
 		if (has_names)
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index c2dcd8d68e45..c33c3b5e0e07 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -202,10 +202,10 @@ static bool __init dmtimer_is_preferred(struct device_node *np)
 
 	/* Secure gptimer12 is always clocked with a fixed source */
 	if (!of_property_read_bool(np, "ti,timer-secure")) {
-		if (!of_property_read_bool(np, "assigned-clocks"))
+		if (!of_property_present(np, "assigned-clocks"))
 			return false;
 
-		if (!of_property_read_bool(np, "assigned-clock-parents"))
+		if (!of_property_present(np, "assigned-clock-parents"))
 			return false;
 	}
 
-- 
2.45.2


