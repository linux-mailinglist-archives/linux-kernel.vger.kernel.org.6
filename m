Return-Path: <linux-kernel+bounces-370233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518BB9A29A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C320C282570
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE701E0B89;
	Thu, 17 Oct 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSe9sPEg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081691E0B61
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183863; cv=none; b=dptCDLheMhYwP/q5nCFlnBKZWMiyR+b7vo5miLUUT4S4rDE4Y+C5lIvyv6eEkUvFRlGM5WIyenmo+2W8qa7H6VlJKlDADMSVzIk/Jw6uosQomOXB+LJngcjnsIRz/zlgjjWFzmh9eQes78y1OETenkUSjvBdG7YJYk2BJg6FvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183863; c=relaxed/simple;
	bh=osLJ67WkCleliN3lQ7XuVH0lOjALLrP6N6qy/Qc6chM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gutVgqeZxUKL3lba1yGDv6BC3q/MDFVg6tDcdjTV2Ked3UlRy2woNUFzwYg+ybwKg/946WXx1jjqdzSvo6LR12jbL8m9JrSQ97v6aHOJAPydK1lFFZ17Dth8iQUH5LldkrXOokCrMXt9/HkmuVpdzp2xqboT7lH4sxcrQowURJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSe9sPEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E491C4CED1;
	Thu, 17 Oct 2024 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183862;
	bh=osLJ67WkCleliN3lQ7XuVH0lOjALLrP6N6qy/Qc6chM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSe9sPEgsjvI3YtOJUQUwnMcYsWyba7qC6Jprks9dAQOtzpoffQCkj4oisd7+9cHE
	 DVRwwIHcAjN8dKvn0wlvAivEEQL1eQ9S1yqoDO4sQXULSD73aWNqqwZuR59dv+Pe4W
	 bnSUSSQ8L9P4TkPrIdWbxXE7sYZZrB4gQ7l2HRT+zVQZUtrV9OOWWDpMW3oyGKHkzF
	 zuWZiyzOtdxnVuK+SDeIJT+7al7FLdqjVXGYEZLDscsztfwK6tylSmiiyBmzsrnmjf
	 cILANsVA5Cv2VU6PXZ+LV+MZy6ylGd0uuE/zTR7MaQmOVtoHQbByhidwi+3crRDRH3
	 e70pC/QNy1Wiw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 08/10] clocksource/drivers/armada-370-xp: Remove clockevents shutdown call on offlining
Date: Thu, 17 Oct 2024 18:50:39 +0200
Message-ID: <20241017165041.6954-9-frederic@kernel.org>
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


