Return-Path: <linux-kernel+bounces-294328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B38958C49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975151F24F71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABD1BD512;
	Tue, 20 Aug 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I8RXwI2m"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7951B3F33
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171723; cv=none; b=Ya+qCtRwPf8NZT4s4PHMvX/JzQ0kyIOQXWIQIatDOmGoQ7Gvmi3AX5Swzjs4QLGS/dkXmfEfisDnExiRQiB3Nid6+DZeD8SMy0ydlhpmo1Zl3SG1Tbie+A/p8kxgdoaSbEnKqosKK/Uf0iOnttlUKzo8CL55+9wQ+cUL31l9OoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171723; c=relaxed/simple;
	bh=FF4nQxBM0nS1lqakhr4Q+sUzCZDVAFySaog/xxInf3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok+lExfqimQJetY1Y223sgogUU07DNUORaRnXZtBWCzT2GFgzSNKqJ20D8pZmqgzv8dbo3u2hyelgqD7NCxdyUeWNRFuZxjoxmD7nCcwy/Ly9Nne2Y3IZRifDWjddYakch2euBsqRPVDKZ0YUVTMZh0hZECHKXlsAU3PU7Dc01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=I8RXwI2m; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so2907819e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171719; x=1724776519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BSe4KOyJw2YEYF8rnu6mjIl7u9y+oNGIQ3Hg6lKPvk=;
        b=I8RXwI2menTRCf+yMfWW84ydKaVgC8EaI0+dk0M56EXo1MH5w5kGeC4s2aOpnqQWZQ
         VK9w+FqoOQlkqcCO7ngOn4KWGi7Dk9rcqopIwm3NbpFrHtPkSMIjFLhpvgtwR11sl0n3
         9uONdTjNa87gXkR4Z8g883SQgjTwYZorQuGWz/LvC9IWbmw2KUxkvsZzFZLpE3zmgh4d
         JQ20QBJlGdjA0uCPNyh5vaEAXt7DZzaeYNgAC81/il4bqs1+1d7qGzDuKrcaq7ySaRf1
         9JTFsbjojBZvIOii/Uzl36hdwPQfw+PHkl4iIcRTkr5UutahNW9NWZk6uFpXt7Dn7GVc
         gWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171719; x=1724776519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BSe4KOyJw2YEYF8rnu6mjIl7u9y+oNGIQ3Hg6lKPvk=;
        b=Q14D2RETVLuKLTnjInlzJbgZmyroMLJG7R6WILgKaEqAF+CeQc+14APpN0mjExAdPO
         gkk9SrBcmtQuLW+MyJ4FNAlTzkDTz5gZvLKvuiDVYIYd1zSvwXAvUlaZ2pICC5x01rm+
         VTcrE2SQEorjrtpcbeh3IDow2dWXjoAN4F7MrED5/dl0vsCyk5xSAZZMpn23EWYsNSKR
         xlCkXLnJ3jjRWRNVWjW/VqrhN01QRQ3umVgE6wUotogYBSJ/aiCMVMc/39CBYr2BPYmp
         KenuLLhpta9tUXW9Ts/xmqQ1bw4OwqYnncNY8NC7X5xAEouypFmgPlqkOWhpAjqZpjUm
         TQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXanHBR2HTy+jakdcDJ5Uk7P02EO/B+ltTkdKjtFype512LaRwlq/CgNqCiAJYjUqw0Zo2be9aICJqr5+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zu+9wdipO6hoRAYoaxQb89P1Zc/yg++4RKSWJQSyOsr1vzL4
	nuu4EoMPSHCUV5SIpDMLheEQ7kn5TA2QFzO8r6ep3i9riP9zCI3trMPOE2bADyE=
X-Google-Smtp-Source: AGHT+IFsK5sSF4zn+iA0VCf5c4osiSUBkZLZkTq8PaWwmO8mR0g9hawJ9xoV1658/XBy+x9/4qSzfw==
X-Received: by 2002:a05:6512:3d28:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5331c6e4088mr12083886e87.55.1724171719232;
        Tue, 20 Aug 2024 09:35:19 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:18 -0700 (PDT)
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
Subject: [RFC PATCH 03/16] sched/pelt: Add a new function to approximate runtime to reach given util
Date: Tue, 20 Aug 2024 17:34:59 +0100
Message-Id: <20240820163512.1096301-4-qyousef@layalina.io>
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

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2ce83e880bd5..06cb881ba582 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 294c6769e330..47f158b2cdc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3065,6 +3065,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


