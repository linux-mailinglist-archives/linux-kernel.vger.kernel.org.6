Return-Path: <linux-kernel+bounces-170445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C68BD6E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405201F21B64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D71D15B97E;
	Mon,  6 May 2024 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iljeouOH"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569B446AC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031116; cv=none; b=k1e2vMDtVKbwtqahVlmZwJAWOyKe8bK45ifpRYbRBEu5ySDC26DmWYQRrYVnHjtcl5WYaLvg3cgLxcjwZgb7m80rN8MqpVXOURM2EliKDVoq35ttfJJznJ55SAQy773isn7uX2gG1Yr6xx4SuwqCsx/cwz7LQpshK2TLuRh3yys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031116; c=relaxed/simple;
	bh=HVLHvpEyG2mfyd18sLfQXaFprFxs1P/zGv7gmW5JvUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EE/CGEM95S4SXFXoLZ3QfqM059vVElPMoYnJ9iw6ONLr2Mm0tPUOTgA0M/h0Zm89+bqFLQmLaIE+/wsIutlbDb4oB18iIYLQU4yniib7Sjt6eJfK/2kx/7youGhx61r4xWBm3Fkql1ddcFdUCivCV9qkVTpqmDw2GoQ7NlQUWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iljeouOH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b21ed19f5so16726575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715031113; x=1715635913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0C9sj5lYnX5Se84emc2aH7p5IP0yHRhAhDOYWxq1wAA=;
        b=iljeouOHU5sQFbR8tH7BH42qIQM5sNpF3usbyaI0bGvqegvnv5OwvVTVCZDZX4ZPzI
         knovvTsJVJZAMyJm6bZLcDbjEOuZU0v5/Hr7aS7ZAzjgcinjYQsbhG8txQ+HQvcgHega
         JNwP8ZwBYZAHn+/yEjVFDHZXlM6tqV3V789ps4iSGPgIRUMAMDd6SGsICNkmhMh6/5gA
         KRYCzsZIdal+U2ucAeShXPFXN1KjKUdGdMwTN03r4ocXgUGz+klzA4GzvnCb1S7IVdvm
         LTeawtCvnC/y/PJEOX4gvzeZJirfZm4fLSY6RXTdVZ4rEK89pnNzHW8u3Oo+BwBuCOf9
         kJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031113; x=1715635913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C9sj5lYnX5Se84emc2aH7p5IP0yHRhAhDOYWxq1wAA=;
        b=vTUyI/UXJPKsfY/aiNetddQk1jjR443bPmdwQk8vCWmmYNAyHJEzLxqGSU+DwOHXN2
         b/hhkZ0xAl2R1botBIf8slp83qj2ANUykxyIUtPZ9OThghf+TQTanYNltl/CAPMTZKMW
         LPYNMaau+fP6Qkf26w9+p6TkXDtKDEt/fhWzF7Ds4loAA2Od1/pK15i8FMsW55S1nrDb
         PygHb+uTxVJVtLXsbp3qPhXXrM7EF0fJ5T/ugSk0kD0Ug0t32x4068zpqsvsncq0Byhe
         qvXLKn7sCDt5+5U7VXhY3vJLMfuMIRPFcGChnH80QeXxqBPq1iU5B4/T3zKPOTaRQi1V
         SFPQ==
X-Gm-Message-State: AOJu0YyY6fWl3Lh3pyQHxfRRIEVlY+UfiBqvezT4uXEcFS0Al/bQ7yNg
	PVEy62cMLmj+CrYE8BiryRvRpdRjRjjzhhn35bR8u9pcRIyh75o8vuIa+w==
X-Google-Smtp-Source: AGHT+IGzWNPXPcpEK4cmfXu1iZvGx4skz8H0ac7fOZbovk+7Eo/Od8Qbw6HYoiEk5NhssaENQpg46Q==
X-Received: by 2002:a05:600c:1c03:b0:416:605b:5868 with SMTP id j3-20020a05600c1c0300b00416605b5868mr8692902wms.35.1715031113310;
        Mon, 06 May 2024 14:31:53 -0700 (PDT)
Received: from localhost.localdomain (host86-177-210-156.range86-177.btcentralplus.com. [86.177.210.156])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b0041bff91ea43sm17270669wmb.37.2024.05.06.14.31.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 May 2024 14:31:52 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] time/tick-sched: enable idle load balancing when nohz_full cpu becomes idle.
Date: Mon,  6 May 2024 22:31:50 +0100
Message-ID: <20240506213150.13608-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nohz_full CPU stops tick in tick_nohz_irq_exit(),
It wouldn't be chosen to perform idle load balancing bacause it doesn't
call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
becomes idle.

tick_nohz_idle_stop_tick() is only called in idle state and
nohz_balance_enter_idle() tracks the CPU is part of nohz.idle_cpus_mask
with rq->nohz_tick_stopped.

So, nohz_balance_enter_idle() could be called safely without !was_stooped
check.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 kernel/time/tick-sched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..31a4cd89782f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;

-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
-			ts->idle_jiffies = ts->last_jiffies;
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			if (!was_stopped)
+				ts->idle_jiffies = ts->last_jiffies;
+
 			nohz_balance_enter_idle(cpu);
 		}
 	} else {
--
2.41.0

