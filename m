Return-Path: <linux-kernel+bounces-521430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE5A3BD2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE218991CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EF1DF75A;
	Wed, 19 Feb 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bxxFiskj"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FC1DF731
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965319; cv=none; b=jxPvZBgwWrf2U1/UC+U7tJ1XaErnapNtlMpDygbuGtnoBAK+XjNmaa7pSZoxHQBdMizp5PEL7QIibO3gYhhZqFsUaGhfsPzSRHkL3xabWbrsf0oYJsm7jKvTH9pjRL5jJW4x73VfSdY22CwSDYdnpxhY2zhQZ0u1QHpnEwU6dKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965319; c=relaxed/simple;
	bh=0dn2PeNhoOQUTbhx3injG0rRhyEL8HprCAWRAhEWq4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Fa0gB6oitSSfvezhxQ4y4qH02xsucur9MsFEngCnq43SDE4fueRGoewPV55EnbDemH0sL4UV2BhudcjZ0XN2A3yCluWJ2GqFrptv4hLIyc4bCX8fcJSW4oobYakwtpBXyg5yC9WSXainWKXrGq6h/55nI8IyN0iDyEyAgmWc3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bxxFiskj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22113560c57so74642395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739965317; x=1740570117; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vklkpg4jT7Yqa+MBRKwFAsqmVQ4XSjs4oAO0nIa6Dj0=;
        b=bxxFiskjrB22IdU18E1JgjHvjCnrkTiJPT+ZPWNGOXfRVH5Kb/1wgDhN9ea9BBwOJF
         3M5DthPc3IkBibxjal6MM5PJf1OqwafvfZbj9EQ5v2sfEN8PHyxPq2Uk72fmC/64PKR2
         bzNEVsbXXuWNIEJqOtyKbSo1X7EHcxDN3PDPgfVn5FbgoEGBapy1TdUpsMR2hsJmT9B+
         16zDVanX/VFTUcdiJtnnkOE5V1y50t0ZUfSqZgxjGVkjveTSx6nLkS4+yrJWK8MveArS
         N6gRe/KLQPbf/VG1nOC3gXZgrOXlkt91X7rX6LEkj7ryG89ZAZO2Yaed4LinIqFhvsuS
         /mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965317; x=1740570117;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vklkpg4jT7Yqa+MBRKwFAsqmVQ4XSjs4oAO0nIa6Dj0=;
        b=chEFdZOxnYATmq5xk3m0g1T8NQFLSnapUg8trH550G7F2o0nB6auF6D+bMGVbblZTt
         qWLXTugICdoyL9WZGx1Yf54TNKx08tkB6l3Se7h45F0xuD9l8Nycj3ZkXOqfDY8elVf8
         0NkvDGPWD36vpIZsidUvJGN7SUEQ48KY6Woqsib9iNNpkNqgHppCJkqcZdR13mYSDjM9
         YTqpdfTNp6G/uSZUSh7Viqx4E7imQOtlEsDTAI3hcL8NWl3oz5IdnIg+5NaSNPOyHlx2
         ExRT8XbLOc40zoI9SPMbdQsrgBrSF/wNMO99fBA5lB14mDOAvwJN1E71hrLAvo5pfZDL
         fHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKxWNnyJ/KyMHdJZaKNo/xO512P8+HXNNZmyuCxQi5DXMy/B4WA4mRGlKUt3DlxAnXO10jRHKCoI0giwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmcPxFxT9nkfnwuhQ344TLAvRcXcOL4y/LQtD9l9tAjhjxr2RS
	ysQdJ1fmV1b8ZyPR4JrIcVcUJkgYXlMB1oSplfyGbR8LXy+XnFtYasgIhC4y1Wo=
X-Gm-Gg: ASbGnctHwEHhQxsc6gfQADV3R9I8UeIHp5k8vw3rX8QY4TR2aIc3BZYVEwl0yrHAI1L
	Y72Jfa84W7nwHLMMN/UP+E4uvSQyt8w+0iFwvplR6hFzf4ycovDlbkm/MqFxJfptlDmQhVM5XQ/
	vneJ9UAtU0culYrOXnrumUcdA0c/XWsQMhRAIXrSRMLbqb1AD6uRRLHgFmu1B0LHOe/yTl6r3PS
	Lp/gVdaCricU4g9lKGLhfKELr5pl+vLVsgOfmB38HTn5LPXze61ZlfjMtlS0qBCWQMqrkbeOpRA
	8U4C2yyQbbmEHLnGu0Y+ozQXFxKjxvzXpPh9sA==
X-Google-Smtp-Source: AGHT+IFvUGCxrEtU2DX0SrdIbNORvhPcIZJPoieuSk/WRd8FcbtSdqlslOM+6SkiVjV1leDekkTRwA==
X-Received: by 2002:a17:903:2f8c:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-22104038460mr260923585ad.20.1739965317390;
        Wed, 19 Feb 2025 03:41:57 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d507sm103218545ad.145.2025.02.19.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:41:57 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Nick Hu <nick.hu@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/2] clocksource/drivers/timer-riscv: Stop stimecmp when cpu hotplug
Date: Wed, 19 Feb 2025 19:41:35 +0800
Message-Id: <20250219114135.27764-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250219114135.27764-1-nick.hu@sifive.com>
References: <20250219114135.27764-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Stop the timer when the cpu is going to be offline otherwise the
timer interrupt may be pending while performing power-down.

Suggested-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/clocksource/timer-riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..4d7cf338824a 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -126,7 +126,13 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
 static int riscv_timer_dying_cpu(unsigned int cpu)
 {
+	/*
+	 * Stop the timer when the cpu is going to be offline otherwise
+	 * the timer interrupt may be pending while performing power-down.
+	 */
+	riscv_clock_event_stop();
 	disable_percpu_irq(riscv_clock_event_irq);
+
 	return 0;
 }
 
-- 
2.17.1


