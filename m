Return-Path: <linux-kernel+bounces-425764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027859DEACB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11F6163F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC01547FF;
	Fri, 29 Nov 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/7iZylA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8A14C5B3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897095; cv=none; b=UNEXMek32wWH4C9q6C8RuiGd2Opxe+6Dev9jYiK8LJYhSS50wUWrctYAl1LORL184SYpKDvhs1Cke3Q68VbauBSFceuwPja069AkbL7IA3ZHP0ORX5DBFUM8H/TgaYs3FzNOYqvfVuUrje30/ayI2HnUxDuKcyv/5nkfITPhbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897095; c=relaxed/simple;
	bh=5rNF5amaXsZJixky76H/H2BwtSuseNAmI2pbT9MZjJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZvB3zyg58uwqyV2rvpAao4XzWmkTCdGUP2S6yu0LbonVZ2KG+RE0swBrKAbqYrsD1vpJsoPmkzaq4YPx/rdExiR2HDnZWuHF/LQ2s0TyuGaZ25VH7pQm3iUxh63hM8x9IXn0qMZdBbjH6Ds84F9N+usbG9R5pwrGxulkfYjqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/7iZylA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a95095efso18883715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897091; x=1733501891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6dmWzMShhnYdCqEKnF32ypM7coFrozhxpDR6Xd+e8=;
        b=c/7iZylAxOGB8m4kypbHZaucwV6hSUEwcxV09Nx+F3rvQSI3PZzcnwwU7PYVfke6Ha
         BGhHrG2r2EHYRCWurw0Uf++fu9d2QD0ELxHLeCHNyqZxxxZWtoJhTkwSp5UB2LNk0csS
         PHDxcOm7YzNytb9Yv74uz0bs/otoDV4megEtT4JBvq/jaYVJfEmIZ8cHnlpD6FtoFv//
         13NrRPZqKHCXaEoztORRCCqmlQme3nbR5ZDqebqp5vbrJceaob7NIEwawo6NVtpWdNil
         BOXdTxYYz3Kstxs8Y1R0HNf/bWe7DOmshmijzoFKBCUB9pNiJGxEGpKPr/7a9qiX6oED
         ducg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897091; x=1733501891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6dmWzMShhnYdCqEKnF32ypM7coFrozhxpDR6Xd+e8=;
        b=LA+KCmeLW0RPmjw9PSSAHDy83VSGCYlHI/fddz3rf5HXucELtt3fT4dlq6CGz3kOG6
         kPligrEaBX5dBQ1VTLtFcOe1kRSWk1pLCENVLb20hPka7XE7TgE1sKNE/seEnM67BYol
         cGQ7c0ukSxU4s8eu8HwlzbE5vIQWnDdW+Y+cw7faLp1t8KSJeM1yboyv3Tl6yPjx754p
         ejz3KSEVdQQH0Khzz9HPEhLVnu+gc6lo08DNNb3ayC4OgrY8K/cI4NIm0481DLeV0oDR
         4XYEahIP5zt7R04Rk4zOHnAI6lCBnhOTF7ynQqq2o/rp2M6r3svqKQhNK5xemG3Z8Up2
         9XOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCOVMyM8BLlHO6fhJmuNhMyoC1RszIUCDHwYw++dh0fjcuNsTRImYBCepuhiIMOz7MJpCDNjqpURt8+W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIu5PjTCIAu/+dT5M0CFNGYeve1I7fOWsbq9rF4sLwPUJ3oho
	Vgp/FMULztjvrmDnN8gGF2/JOlAcUAz7GJCkhYnZ6Ddss+R4JmzbjsMF/PbsUhU=
X-Gm-Gg: ASbGncuv5r8YJNQZfXNaMzJ+9UqGDdZuwktxcZ46bz94bbbeZHNdoFxYreCQNBXzsXs
	+9et1rsGh2LWTeXusL3yfkACPGunfPiHS1eh6TpQFB2/f8A6EYx32xWZ6CjdHaR1VN9IvTJBlim
	Oj5vCqKvjPBThZ9KYmYOdoP8qXawCpfS/7sr/l8hMxYMxiFkHToJwUTtBqIJhfJeSkozougMM/K
	6/DvHsq0GHgJks4XiN5RGo4JG51ZBETNhJSfB7Msjm80Bj8jC3NOGOVVIo=
X-Google-Smtp-Source: AGHT+IF+IgST8Rc7khbCImbAalx4frVnCVVtZPqXFkY6q1FgR2UiUzP7sUgtq8Ym41RAsjH/TYqsOw==
X-Received: by 2002:a05:600c:4fcc:b0:42c:b67b:816b with SMTP id 5b1f17b1804b1-434afb8dea4mr76735565e9.1.1732897091586;
        Fri, 29 Nov 2024 08:18:11 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:10 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 08/10 v2] sched/fair: Do not try to migrate delayed dequeue task
Date: Fri, 29 Nov 2024 17:17:54 +0100
Message-ID: <20241129161756.3081386-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrating a delayed dequeued task doesn't help in balancing the number
of runnable tasks in the system.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dc9725da033e..c34874203da2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9394,11 +9394,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) throttled_lb_pair, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 1) delayed dequeued unless we migrate load, or
+	 * 2) throttled_lb_pair, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
+	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
-- 
2.43.0


