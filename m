Return-Path: <linux-kernel+bounces-370229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8B9A2997
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7656B281D62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52861E00BC;
	Thu, 17 Oct 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIQTBZQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA41E00A8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183857; cv=none; b=iGMRmdXAQarTjz5Qeu/xyT7jQb7NnchWJirDXdWfXmzMHswVJ+lcSZyp/fF0j1EHbUWnBOZ5gSSXab2RSHkisr5Q7AiBgtLrElMrOIHBoSfG2EFJk/oSOkSS01c8qTVv9ZwO8zptDbisAtl4VrLYi5OO/dlA0a8GKINEPHIR9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183857; c=relaxed/simple;
	bh=LSVbONdYSI3CZ/dJAq35R0rVW7RNPedEHyCHamPd/X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgCBoQoh9sYObjrTNzeMfGEfqG5VmF9N82PdKWMKTq+9dW4RYSg7v33QxqKfaUGW4pX+VbzsaPcpKnNtf9SJabQpl9G3buQq7Xx7X3YlOQmIvhTIpzzQtooIRCwerH9HCtrR7JWKxFnwYjVNqblb//MatJ0DXTe2uN4UpCEBKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIQTBZQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C77C4CEC3;
	Thu, 17 Oct 2024 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183856;
	bh=LSVbONdYSI3CZ/dJAq35R0rVW7RNPedEHyCHamPd/X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIQTBZQp84Ia/ch94EF3cCuXu+IVDl2CyVe6PXaftl8EeW2bwIPRDm+gnJ6Cy68R4
	 bu6Uo/31++jynHj+p4k9GLYlAtC9v0AXI5FHqecuTUf2WGPrf34QZV/WS4PWkWh+CB
	 Xt6YzX4F/b1DpXBxOXCl0mKpUWxue2/0bKfn968ciH77Z5E1z+4mZJP6jycVfj6YWB
	 PKGIBIg1I9sShmI94NHE1HH8ZByoZGx0O27EjS7Gm3xlYDu6MrZ728tZ6GIvE1wTlu
	 uAw+iTWOV44MdC9gtKJ4xSPqNk7FpB9VXGnTe+Mk47MtCvVDfWbg9/ZnVhZhJVECtm
	 CgC5ddDs+iwEA==
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
Date: Thu, 17 Oct 2024 18:50:36 +0200
Message-ID: <20241017165041.6954-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
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


