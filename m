Return-Path: <linux-kernel+bounces-291833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E49567C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D40B20B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E415ADB2;
	Mon, 19 Aug 2024 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5oj1Mae"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EB148FE0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061833; cv=none; b=fslsEtbn5V/LuTGo0L4RqbDQP6iSgguT2LHYbrDKg2Bot3ep7O/OUXn4UkkcleGzDWjJwfnSctyCLAAzIds0pkK+xQ6k1LN2FAjA822LEVfava4HeV+vp0nWmcnrQBmtqz8uNnIki0pKgRnrFLV3KLMMK0AX29Z6NXuPQaajIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061833; c=relaxed/simple;
	bh=VLBf/vQhpjzUzMy9tb9YmExwAvXbb81J1NRns3EBoZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayyV+rK2/lSQcOZ1SLpTKB+JEnI5GGy+q6NtUCjPIU7OZ9OUSkXMOjRYbOLBBMprQ48WCKtJVB8NWmsJLk6oPUytY9AX1wPqAilAh3NvGbDHH1ooR3NCGtr0soNafrwkX7nujddjx6P59UUYikyz9l3t/SUALOGMi+W5NgozWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t5oj1Mae; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so30857075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724061829; x=1724666629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SzkBfR/OysQC8TAF7ZDp46PHM4J6mKeh/JMzA0MpVk=;
        b=t5oj1MaeaT2FFHjqY4xcmm1lDyncTml1zm0dKGPY7CwHNDuEzKcsINbgrc1aydhwv8
         utBZcCzOoFbjgZPUI/sRwb0XZT86MzRYbX0NqmKaQexDmGgpG2yR6nj3rs4lefI2BaMs
         dE8Mc4ur+Xb1WJKy7P6+yyYQvpRy10oVMWrtfW/+Qkgg1ajMgc1tUDTUGRW+MrCQgDPG
         76EiTrRYoxs8QCXyHZAJ2pIjP4GVzOkGUuUn/mYYpVlZL7N7exoo33W4ynAyZl3EDneU
         UXKexHc2G/bIR41lZWFrpuv+o/7jxUM4e76TzYbEYdOCLNH7bxONrA7lPkjgmnh/2oVO
         5nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724061829; x=1724666629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SzkBfR/OysQC8TAF7ZDp46PHM4J6mKeh/JMzA0MpVk=;
        b=UE3G0GCLicXstWqFHOYlDwp81VfVwoBRFU4K7eKwjsuxCJIhoYPKA7tPF5zwDc02lk
         moX/N8VtxZYhxswDgCZ0fBzta9hsEo6dcTJR8a3g+SP8Z4eOc72bHJSGNnaRnSIDdZzq
         kv8BHcdS8OwoZefOI2d0XVfNBUUrdj0vS9dbjiU5+fKZa7FpC3wi0ZUOTCIUrxokJH9C
         znaj0nYWH44B6Kyrf4ZQKOonCg9wd4Gqx+YxYLJJZqQSIs2kLyaNP1ydkBFrbrVoavsL
         vKfttmTSb70xLv0tEo8m+PdEFtvr9B7eha9m7LB2c0D6/ZrLjC5th3sQcILaWBHNv2t8
         9MZQ==
X-Gm-Message-State: AOJu0YzltKi0DJDfgp3J2ScV5/a0WFgSq0Q8RoHoCzuyWqiU446d7snm
	a1AC5vzQtrVyYhKqBBE6l+l3jyF/Gep53nDqfYYitw1+3ZWk/HsJt0yxLzBdyXE=
X-Google-Smtp-Source: AGHT+IEY8uHWA297HnF0Dyvmxi6OSpRyRtCpiTa1zaBqOolOkKTew5RY+XMBlI2CwFjQNd9AO+fHbQ==
X-Received: by 2002:a05:600c:4f45:b0:426:5dd0:a1ea with SMTP id 5b1f17b1804b1-429ed7e4200mr63218765e9.28.1724061828952;
        Mon, 19 Aug 2024 03:03:48 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898bb83bsm10144653f8f.117.2024.08.19.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:03:48 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	ubizjak@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-of: Remove percpu irq related code
Date: Mon, 19 Aug 2024 12:03:35 +0200
Message-ID: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by GCC's named address space checks:

timer-of.c:29:46: warning: incorrect type in argument 2 (different address spaces)
timer-of.c:29:46:    expected void [noderef] __percpu *
timer-of.c:29:46:    got struct clock_event_device *clkevt
timer-of.c:74:51: warning: incorrect type in argument 4 (different address spaces)
timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
timer-of.c:74:51:    got struct clock_event_device *clkevt

It appears the code is incorrect as reported by Uros Bizjak:

"The referred code is questionable as it tries to reuse
the clkevent pointer once as percpu pointer and once as generic
pointer, which should be avoided."

The initial change proposed to do a coercitive cast which is probably
not right given the correct is incorrect.

This change removes the percpu related code as no drivers is using it.

Fixes: dc11bae785295 ("clocksource/drivers: Add timer-of common init routine")
Reported-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-of.c | 17 ++++-------------
 drivers/clocksource/timer-of.h |  1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..420202bf76e4 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -25,10 +25,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
 
 	struct clock_event_device *clkevt = &to->clkevt;
 
-	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
-	else
-		free_irq(of_irq->irq, clkevt);
+	free_irq(of_irq->irq, clkevt);
 }
 
 /**
@@ -42,9 +39,6 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  * - Get interrupt number by name
  * - Get interrupt number by index
  *
- * When the interrupt is per CPU, 'request_percpu_irq()' is called,
- * otherwise 'request_irq()' is used.
- *
  * Returns 0 on success, < 0 otherwise
  */
 static __init int timer_of_irq_init(struct device_node *np,
@@ -69,12 +63,9 @@ static __init int timer_of_irq_init(struct device_node *np,
 		return -EINVAL;
 	}
 
-	ret = of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
-		request_irq(of_irq->irq, of_irq->handler,
-			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
-			    np->full_name, clkevt);
+	ret = request_irq(of_irq->irq, of_irq->handler,
+			  of_irq->flags ? of_irq->flags : IRQF_TIMER,
+			  np->full_name, clkevt);
 	if (ret) {
 		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
 		return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..01a2c6b7db06 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -11,7 +11,6 @@
 struct of_timer_irq {
 	int irq;
 	int index;
-	int percpu;
 	const char *name;
 	unsigned long flags;
 	irq_handler_t handler;
-- 
2.43.0


