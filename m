Return-Path: <linux-kernel+bounces-386968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CDA9B4A43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4638028369D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CA2071E6;
	Tue, 29 Oct 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNpT4zj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFA206E9A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206509; cv=none; b=VqKgpOj3ZowxJFdU1N4a9pNG6dVZ0mBuq8Q3PuR5S7pob7ZpwqJO6ND8abgzO6N8hdDkf5g9WFJBbwxMCw/FFUrGzU60MPXNdxFhr+SuZpUGvmitAlmyKexyeBWxIPhcY5nBkQDIL5uw92z5DG9pKM95FRPg8mFymKt/7/YmeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206509; c=relaxed/simple;
	bh=ohm5m/FEq12JHJkouCz6F5DIQ6ro0AAeDjfyVqNditQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcC4MMrUXeEstFQzecSzILEWTqlMzrCVoiB7UO3FnH5AWenau4njE+utAV8ShKbSkWXqOJFIcXYOyZCvZQGp4ODPv9GkEDDOyOqL2ViTNyoroVnEgkHbXWH+myZCjL4Vzl6dcs0oX+6t5lvLA9wCLJ8I1tIPOatBO9AHLyCFFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNpT4zj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72136C4CECD;
	Tue, 29 Oct 2024 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206509;
	bh=ohm5m/FEq12JHJkouCz6F5DIQ6ro0AAeDjfyVqNditQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNpT4zj669geWnZlsAZnDNm321Gj3pgB2vBPJ4+3YCKqnb7R4KLMqLkxDNOzVq/H6
	 8mJdIcY/R0BmGIMEr+9N+0TqNxOp6KaLdV2oU5OUG2BbXq3zyHiyWxk0Lvqb8SE0oG
	 dopDgR1XYcWQdexsZSsS5mor3fZ1An+7XSRRhV1K3yuh6gQZesdLnKfR6D4grwtCPN
	 mumigen6+cMMbeMwrtZ7sF1CSRA609sXyinviQR5+Xj/qzJVl4ntt2rpQeDHJ0iM9x
	 NwLA682lAGcMDAocybvfuM7ktIjRwoX0U5Fqb5Gg0Y16N/g63/bBmOi96ToTEtoK4w
	 Re5R+dJfhNQTg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining
Date: Tue, 29 Oct 2024 13:54:47 +0100
Message-ID: <20241029125451.54574-7-frederic@kernel.org>
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


