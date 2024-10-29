Return-Path: <linux-kernel+bounces-386967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF389B4A42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2BB237CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A013206E8A;
	Tue, 29 Oct 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkNRyVnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D5206E7C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206507; cv=none; b=a9YlLRAlj4OkSw2WOMxb0QNVuNVEcWXatxAcmxqlN0c/6pilGUQVhrfUaIBZldvPBjUktgjoUG0/+jPWF9d2+FZs1LLEeZN/8kMU3ueA7c8lLdNTU8qGBeMx2rodP0yx5p89FxaG1cABkRELzGpxFVZH8yXuDjoic784QCl7ymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206507; c=relaxed/simple;
	bh=LSVbONdYSI3CZ/dJAq35R0rVW7RNPedEHyCHamPd/X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hwsv/oOjvjVW62BW7KHs33jz68aoUhbYXoWZbcKWRyworruACLX6Dh6OQihtDwj/ohkuGLsCOXCD0NVPUBfLkAERjoLl2TRiK/VGy85QmBJHBWqXXsQwQNrQ5Wmo298FvgEqO53/iygonGozwTUwZowNCsK1kjxL2wZcSJ7x41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkNRyVnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3902BC4CEE9;
	Tue, 29 Oct 2024 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206507;
	bh=LSVbONdYSI3CZ/dJAq35R0rVW7RNPedEHyCHamPd/X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkNRyVnGdgi/trV2bBALBw8EvREHuwKmyHGwmiZfq6dsPX+GtXYkMmsfew8d2qgp1
	 RXB2xm1PxgCl9KHnApsQAPo2THazdRFMnjGoroATzRoIAMkrA5DlD3Tc5w18ni3+8h
	 cGm+L7Whw+ySv93kBXMogr2wVP9nbCDXXy3eqqFsCnOfuwjdkYxV4dKubCawBrx7cM
	 Dhv8k2HpEjvP10JWmErN19jCwNxV55pZv/8I53+BMUaorGpOOr4tKceamb1IOZg5lg
	 g2XMhLwA8uI38/yWqt6fM2zd/BVsk2utUPoaFP/NhQ21ZcZhrS5cZ3tUowK6/uWUH5
	 RvKRBB+AiujFg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/10] clocksource/drivers/arm_arch_timer: Remove clockevents shutdown call on offlining
Date: Tue, 29 Oct 2024 13:54:46 +0100
Message-ID: <20241029125451.54574-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029125451.54574-1-frederic@kernel.org>
References: <20241029125451.54574-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 03733101e231..2bba81e25aa2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1179,8 +1179,6 @@ static void arch_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
 	if (arch_timer_has_nonsecure_ppi())
 		disable_percpu_irq(arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI]);
-
-	clk->set_state_shutdown(clk);
 }
 
 static int arch_timer_dying_cpu(unsigned int cpu)
-- 
2.46.0


