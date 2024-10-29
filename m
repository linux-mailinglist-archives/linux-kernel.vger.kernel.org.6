Return-Path: <linux-kernel+bounces-386970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C09B4A47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96C5283611
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC920207216;
	Tue, 29 Oct 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvZ/IJEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB120720B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206513; cv=none; b=emCa33185Wqiztufbt4vEbzJnGOW/67wnzwK57srXTRGvccbi/0vG0OfsFA7RqYpfsWtG6y1trcOdR67weh02R1FsU1ZDgVFOLcbU+ca4dCXbsOdiqgQbdcFFzcVK0/SXozkX8sLeP8ar+Xii83rLUduqHCWjl/gYqnwsyK90DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206513; c=relaxed/simple;
	bh=osLJ67WkCleliN3lQ7XuVH0lOjALLrP6N6qy/Qc6chM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obtufs15EBcOuL8T0iWOq0ZhzGsW1mLh4DFzGHOyNr+pOZwA6g7M+7yF7ayEXeznW/f01Z3NBPyDnCTgF1qFV0s3bnKEumz/PAWwMEwRltyxiIHG2/Id4EMQnX/hZW0KOLTWE/26NN4GBb3KYvKznZ2OyJfXoGqY+nXOFJUa8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvZ/IJEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AF7C4CECD;
	Tue, 29 Oct 2024 12:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206512;
	bh=osLJ67WkCleliN3lQ7XuVH0lOjALLrP6N6qy/Qc6chM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IvZ/IJEINIzcFhKQ38Gx+RsW/Wfa3RAR6+WVCrDZPUT3rSFS2VVub7/8bNFVCbu5Y
	 zqGDOb3BmZNy8ElxCAuX+Qqbm2NUW1JZGAD5jsdTGvWnXAgr4gIWUYr14CYMks7UzQ
	 LT8pGe+JG7VPJPK4PtDSXE35fbKomwe707e+XPDfPdPHDGTquTAkaEleOEwiQxIg0v
	 ocg3vYKw9SAqPN0USxaFRcOiP0P08cB4UXPiEhSb8tpA25R+u4SSmQ6Zn7IxeKsq15
	 6ooBFNZlSC+U+nRaqsLzotC/mPnulw1PAv6SGfBWTGgK2OafEkHea3xeCVu9G9v1Pm
	 6dc9TReXuMhAg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 08/10] clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining
Date: Tue, 29 Oct 2024 13:54:49 +0100
Message-ID: <20241029125451.54574-9-frederic@kernel.org>
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
 drivers/clocksource/timer-armada-370-xp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/timer-armada-370-xp.c
index 6ec565d6939a..54284c1c0651 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -201,7 +201,6 @@ static int armada_370_xp_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt = per_cpu_ptr(armada_370_xp_evt, cpu);
 
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }
-- 
2.46.0


