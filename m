Return-Path: <linux-kernel+bounces-370230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C39A29E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B4DB2C9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18A1E048C;
	Thu, 17 Oct 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBKLIDg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA321DF754
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183858; cv=none; b=Hr/eApwhLrYXt9NhAsOS9SowtW7YXGAEsYmrwVfWBjQglLdujkiUQb9lmxBD5ndUAfYvgWp0tjzbVVQzdR7dbSpO/8lM8lzpyHolcow/rlOjinxnvrJlqXs5vSgHG+TSEGplWMGpC/gy6QqMEKOJ2Dq2MAqVwSJjVxa8eG9R700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183858; c=relaxed/simple;
	bh=ohm5m/FEq12JHJkouCz6F5DIQ6ro0AAeDjfyVqNditQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6cDjejF5AchtttoL10KVhIWEy9F1A6lhBc67/Y7lGVYX52qTcQAZG2UjFQIhLxeuKTwSABK/+L4fqEIlLJpRpjzqKxVWvbO0OJRoRgMQ/y4jPVtp536C62cO2AvE6PtW0RW7weWZtNRDTfd0DFGgXjW2s7nwIVCfe4lLUr4GWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBKLIDg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB4AC4CECE;
	Thu, 17 Oct 2024 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183858;
	bh=ohm5m/FEq12JHJkouCz6F5DIQ6ro0AAeDjfyVqNditQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBKLIDg7vejluna9ytgUb4LHK7sdDU7oqfV7yErYzd5nQdeGSD1MFac1Hz1xcdpq5
	 aRrQiu6m9HBk0r+WUopP2JYDblNExvZUn9oKHRySr/MX66XwXV7dhAs+7ljKPN6xyJ
	 uPjssWeNWcPV6S9jqdnP0J/gaIA29CvGpeaox4Y6aF+5ZLXFgM9ca7xVI75iE51GIA
	 hXBtGl34rnvSMOTkjZRQqZorsD0U1Z8/X/jbv+duNZtvJYovUXzGNoSz6xQqr7MmJF
	 isPtP/DUvTK62i94mqsw0nHd5o9f2+T5H6daHkld/SyxcEw8viYC8QujE9N9Q9Gthz
	 dD6EjJwo8ZvSg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] clocksource/driver/arm_global_timer: Remove clockevents shutdown call on offlining
Date: Thu, 17 Oct 2024 18:50:37 +0200
Message-ID: <20241017165041.6954-7-frederic@kernel.org>
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
 drivers/clocksource/arm_global_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a05cfaab5f84..2d86bbc2764a 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,7 +195,6 @@ static int gt_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk = this_cpu_ptr(gt_evt);
 
-	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 	return 0;
 }
-- 
2.46.0


