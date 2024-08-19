Return-Path: <linux-kernel+bounces-291513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908EA956380
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA8DB21AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D1A1547E6;
	Mon, 19 Aug 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJBCQIpw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72704153814
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048039; cv=none; b=JWMZ9lnyTxxUbgyuXbQRFNvH231uM2AE2WnwfCeXBDeCz7c+mkOjojjNrWHeGOmhDU6jXpfpbZbNza/aZ5AJFFxgLxsuJY8ZNzGX6r+j3OfjH4fiTqFVB7sX3Gjm6IkeqbLVBs7AS3lZY1t7/hXa3zOvOmqN+LHnGhcnzngZDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048039; c=relaxed/simple;
	bh=vlbPrDA+0mMvRL6GaHPW8KOBBL0L1yTQyfQlc3ayt5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATVxb4kML0tuNGmR85Bnx9GJzTTd5s3HRfLpDT3S+6BxPNFQWWzBdELrscr9RtJceUsJTybdKcXh/8O5i5qFhR6zEmwTJoA+OkPBa2b2vTEasys52xFSyxre4P93xyS5eimjuqAUkhqwBzh53FF3w78wPPznQ4pqsrhat3ijRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJBCQIpw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83597ce5beso594109366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 23:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724048035; x=1724652835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cj7Xjy6YT9Yj9Il8koGljVSCmdCLs0gmhMJ1q9mU2fo=;
        b=MJBCQIpwgMxaffMylkmwJSFqB5HlBxi+18qQDFHT8VIjtFBpHeXPQhKh9GUPy93TfA
         IttwXob5smpmqSu9ta0Z9xml6R+8pq/Q+WHoplSQtYmK+mEMhgHkvyK6ywYrmCgSkYjc
         chdd2g4eC945ZRVU3VHm59n9knZc88bEgWGg3ZLSzdhqu6IGjSferbFlgeExAUZC5xPY
         q6S/xqIz9mDDcp0nDnKDX0QNiTB5oFu+k4M+9Lo1DWNW5AALw6hH1JGpCBSsENcEeNLF
         MKh/VMxct37n0wAqbbdPr4TlpVWmNhXvVVOEn76iRsoHw4eOmCn12TTAU9aQs3sQ3pVV
         8uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724048035; x=1724652835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj7Xjy6YT9Yj9Il8koGljVSCmdCLs0gmhMJ1q9mU2fo=;
        b=IjD7An+a/4vom8WqF+S/bp6eNM/nOU1EqpNBiDL22gn4DRUgxf7CJr+rNl5xSI8OC+
         Dv0t2DSCpl+ZUEzgsJjxKTkLsIpVKP7Faokm353FPuGguif1TYkhkkVXsvQGd//XtGcj
         pi7noSqdY81gsrTyGCGoTBc6nybDarDZME8qqtKlXX1z+r1jY6fj4xm/C+PjUP1jkdof
         Y6/3XHEHhdQOFKqH4Tj3Pzq5hfzEpO4cBuRIdbN2rPWyCAXyS4KkmH0WDvguBpkoTeR1
         dab2OT0flvayJtkT2pmHKXRaVPOwTrvJVyfpjN7qnP7AGp0NxakmzFeNA8i9gOU51JtW
         RFUw==
X-Gm-Message-State: AOJu0Yx0YkxOKQSseYQ1uMv748zyT5SA5Sw0S4YJwfmjFZjfTApkBfAb
	RKpJ9321pwDi7BW16By7iWpiobLanqnC16sQ6CNdeIFhJUQOchaagWdG1g4Y
X-Google-Smtp-Source: AGHT+IGhjK4Fw8ellGiMdL55s+bppcdoj/sfdqwdNdjSpBnLYUfHR2LQ2qWYgCtUZae4NReP9/K7ig==
X-Received: by 2002:a17:907:6d2a:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a8394f7e0b9mr944318566b.22.1724048034905;
        Sun, 18 Aug 2024 23:13:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6975sm593629466b.41.2024.08.18.23.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 23:13:54 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] clocksource/timer-of: Add missing casts to percpu address space
Date: Mon, 19 Aug 2024 08:13:45 +0200
Message-ID: <20240819061351.14782-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing casts to percpu address space to fix

timer-of.c:29:46: warning: incorrect type in argument 2 (different address spaces)
timer-of.c:29:46:    expected void [noderef] __percpu *
timer-of.c:29:46:    got struct clock_event_device *clkevt
timer-of.c:74:51: warning: incorrect type in argument 4 (different address spaces)
timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
timer-of.c:74:51:    got struct clock_event_device *clkevt

sparse warnings.

Found by GCC's named address space checks.

There were no changes in the resulting object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/timer-of.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..7e0375a804ff 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -26,7 +26,8 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
 	struct clock_event_device *clkevt = &to->clkevt;
 
 	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
+		free_percpu_irq(of_irq->irq,
+				(void __percpu *)(unsigned long)clkevt);
 	else
 		free_irq(of_irq->irq, clkevt);
 }
@@ -70,8 +71,8 @@ static __init int timer_of_irq_init(struct device_node *np,
 	}
 
 	ret = of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
+		request_percpu_irq(of_irq->irq, of_irq->handler, np->full_name,
+				   (void __percpu *)(unsigned long)clkevt) :
 		request_irq(of_irq->irq, of_irq->handler,
 			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
 			    np->full_name, clkevt);
-- 
2.46.0


