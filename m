Return-Path: <linux-kernel+bounces-294332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7BA958C51
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BF2284DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F941B9B41;
	Tue, 20 Aug 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wsyA3i1I"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2A1ABEBD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171807; cv=none; b=Q8WteqLzD/UbH+hsWgl4YLVnL7kY9o6+ra7s0AgXj1xL+wgQUfT3MGdhjKKw8lf6/RD9ld5fdZF8B7W9iJ046WBka5NivdgrO3sdxbOLyipuDujf5XrYesfCk15S1P8L1vZ14Fgxqg3QeHuFayp2kmAFC9l+r1O1jdKDaQi0EJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171807; c=relaxed/simple;
	bh=ggQ0xHMfPwWR5W6MLhFpsoF3X1RHmOFsfCjj+44KrkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMe6SvjobvxPq8I31kf6u7pNyfx1g5PTZbZEs+p6fRi/UPZmSL4y4wNSdqKUlV3B0rByM0bxNByblDHD7Bq5I3U3fpwkp4EVa2P+n+UM+aZsTL7FGS/BhTgu/jORcNuK1dxi4aAOEY06JiraS4V6jxBKuoHykL2RL56hETn8tRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wsyA3i1I; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so741083366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171804; x=1724776604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wet2+g0g75UUnmsKQrb/VZONF2cRQanUuyFsF+8Vjk=;
        b=wsyA3i1IbjWoPW9j3p0vNvUGwPtjDlNT45+LMvpLkR7Gh+g1Ft4yn9bcG6cHDY6Fx7
         EskjTsaMfaEWcarR6Xqt1tnXRL+7pkPpjAlgUab7PvpOrpZbl2ph7izXNPl7oLISini8
         V4ljBcawl8Sf7NAfs1prsOlVMV9YYOL0v+8HXCSOh1Jr1bnvLd6Ku1IjRgSIUBusiYEp
         r084fR18jdRdhPY4bsDBe2NmYEqcLYCTg9X4e7/HH2BtfV9GHjqzHR7A6eYyy1REsQRq
         0wdm6G189GSe9YpKNQ8GF0GCTNPMj8Yt4Zf7NoW335B8v6ZY/TFYj7N1dCKjvlLGo8OY
         bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171804; x=1724776604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wet2+g0g75UUnmsKQrb/VZONF2cRQanUuyFsF+8Vjk=;
        b=pd6vIg31DGAm3ZnoULwDa3MCAzq+t5fIowEF3ITq85R3WGdYoQN6i+9c8IEQTkd3LJ
         /L2ifcU5P8Xp68r37c8aspUEwBGrxrmPokhk8pvyKAu/Bm4Kk6zkBWCfpgS/hU8NB55j
         F9xh9k4PCqbhOO/0XZ+uDogDd0D9iqWEmOXkA7QcXPnMpu5MvXUXj+69kfzkjdjEss4r
         l0fSuKE5Cxrwa23coDwPqMvf7gUQ3HdL+1HTlQpM7RCifbVUCXQkjb2h7eBy9NrWYzsP
         JF+/LSkPWF3UyaI2au5MJt5UEekbRtnRdntVUQREvxfXEk5jfEpcqV/5Qn+OtriD9GQV
         jynw==
X-Forwarded-Encrypted: i=1; AJvYcCUNKs4oWNPdw5g+IPmmLtokwRZ1EE8922t8I39WQr28XNWBL+qpkLWFyRnGJYBvDv/Diq6JH50upNxDgPk5H/2jb+eRB/plW57lEaOe
X-Gm-Message-State: AOJu0YwoTV5hPv2H9yAjvIlHJz9PVnco6TBXFrJM/qbtl+ZZzRzvJsII
	YGTCYLH3AaGgf/vvSmUEZ0WkAt5AqHXWQ9gu13MUlyeQrMiu6CLtWU8s/IakzlvrLiX/riqyUB4
	4
X-Google-Smtp-Source: AGHT+IFEuSDJpZmH2vuXQPhm8UldWkmv4L2KE1jsWvuj7bhXQKIf0BaaBicVLq/zLot7W5U3e4x0BA==
X-Received: by 2002:a17:906:d7c7:b0:a7a:bece:6222 with SMTP id a640c23a62f3a-a83928a9f25mr1027872166b.10.1724171804254;
        Tue, 20 Aug 2024 09:36:44 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:43 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 07/16] sched/pelt: Introduce PELT multiplier boot time parameter
Date: Tue, 20 Aug 2024 17:35:03 +0100
Message-Id: <20240820163512.1096301-8-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The param is set as read only and can only be changed at boot time via

	kernel.sched_pelt_multiplier=[1, 2, 4]

PELT has a big impact on the overall system response and reactiveness to
change. Smaller PELT HF means it'll require less time to reach the
maximum performance point of the system when the system become fully
busy; and equally shorter time to go back to lowest performance point
when the system goes back to idle.

This faster reaction impacts both DVFS response and migration time
between clusters in HMP system.

Smaller PELT values (higher multiplier) are expected to give better
performance at the cost of more power. Under-powered systems can
particularly benefit from faster response time. Powerful systems can
still benefit from response time if they want to be tuned towards perf
more and power is not the major concern for them.

This combined with response_time_ms from schedutil should give the user
and sysadmin a deterministic way to control the triangular power, perf
and thermals for their system. The default response_time_ms will half
as PELT HF halves.

Update approximate_{util_avg, runtime}() to take into account the PELT
HALFLIFE multiplier.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
[qyousef: Commit message and boot param]
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c | 62 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 06cb881ba582..536575757420 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -24,6 +24,9 @@
  *  Author: Vincent Guittot <vincent.guittot@linaro.org>
  */
 
+static __read_mostly unsigned int sched_pelt_lshift;
+static unsigned int sched_pelt_multiplier = 1;
+
 /*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
@@ -180,6 +183,7 @@ static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
 		  unsigned long load, unsigned long runnable, int running)
 {
+	int time_shift;
 	u64 delta;
 
 	delta = now - sa->last_update_time;
@@ -195,12 +199,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	/*
 	 * Use 1024ns as the unit of measurement since it's a reasonable
 	 * approximation of 1us and fast to compute.
+	 * On top of this, we can change the half-time period from the default
+	 * 32ms to a shorter value. This is equivalent to left shifting the
+	 * time.
+	 * Merge both right and left shifts in one single right shift
 	 */
-	delta >>= 10;
+	time_shift = 10 - sched_pelt_lshift;
+	delta >>= time_shift;
 	if (!delta)
 		return 0;
 
-	sa->last_update_time += delta << 10;
+	sa->last_update_time += delta << time_shift;
 
 	/*
 	 * running is a subset of runnable (weight) so running can't be set if
@@ -468,6 +477,51 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
 
+static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret)
+		goto error;
+
+	switch (sched_pelt_multiplier)  {
+	case 1:
+		fallthrough;
+	case 2:
+		fallthrough;
+	case 4:
+		WRITE_ONCE(sched_pelt_lshift,
+			   sched_pelt_multiplier >> 1);
+		break;
+	default:
+		ret = -EINVAL;
+		goto error;
+	}
+
+	return 0;
+
+error:
+	sched_pelt_multiplier = 1;
+	return ret;
+}
+
+static const struct kernel_param_ops sched_pelt_multiplier_ops = {
+	.set = set_sched_pelt_multiplier,
+	.get = param_get_int,
+};
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+/* XXX: should we use sched as prefix? */
+#define MODULE_PARAM_PREFIX "kernel."
+module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
+MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
+
 /*
  * Approximate the new util_avg value assuming an entity has continued to run
  * for @delta us.
@@ -482,7 +536,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 	if (unlikely(!delta))
 		return util;
 
-	accumulate_sum(delta, &sa, 1, 0, 1);
+	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1);
 	___update_load_avg(&sa, 0);
 
 	return sa.util_avg;
@@ -494,7 +548,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 u64 approximate_runtime(unsigned long util)
 {
 	struct sched_avg sa = {};
-	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 delta = 1024 << sched_pelt_lshift; // period = 1024 = ~1ms
 	u64 runtime = 0;
 
 	if (unlikely(!util))
-- 
2.34.1


