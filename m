Return-Path: <linux-kernel+bounces-294341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919C958C64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FAB1F26D90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF21C7B7E;
	Tue, 20 Aug 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Fsybhqe7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983A81C4635
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171816; cv=none; b=pyLQmF2xfR+5PNUgR/yUv3qWz2oI2fG0UbXf5QEasIiyTjhBQh7RA4GKKCJfqqkNVGda8OC7TS8O2+kqNpl8MNVnFXWimK2+42bXrt7HFNk1mBT1yec2ee4xj8SOjlyx35Iazkm/X4njPRH92hw7QrnPdYtgaAG2aMkXr6DYgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171816; c=relaxed/simple;
	bh=FcQoU+XSuInJQQOSIHfVyJzGsFgsU0Fz0b3FqV2urj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCbAG6WiGjH2cGp4fkNRKyc0QKft/qRcA4KADYl9QykEYzSty5H49o9Ijqzd1v+uDS9YZzOtwz3kNxRBoRzVPGhJGfZtcZREgeqD9BkSMZTMDiP2+6UGJ0EFNJKu09183PWvbKhKinkcSTngv63u+6UpYGYgxyX+jLT++55REMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Fsybhqe7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a80eab3945eso584643666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171813; x=1724776613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc420hGJWxSmQzyq9r4KlOxaBiNHLqomnZxiY/aUtfM=;
        b=Fsybhqe7muuGhbmgEdTCITd2P88EV0KF/kH75xdvPkU8GWKNa07xoXRRDpOMicwFwi
         vnw0Q2B/jcxC1RuJO/XDYFVkPxJsw/xaCoeRULoBrYZlMW752AMBar6kGPqf6FFNedhL
         Lu72rWH9TFTi0KkxHwvdyNfht1QcpE/GV6jLq+LKsijg8xXCeG9VVJFUz2dyysQNFAs6
         5kWy52wB6U6vmT+hkRIJITVzIcGFPQfHxRuWMV9PbqxrGRtmHqYL8Y/i96xKFcEoiDTo
         KV96gXw6UIQj1afHF05y+JLNaQQpNLM9+ipA9I/wFwlsot+O10899CQnR/nTDqbLry7a
         EuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171813; x=1724776613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tc420hGJWxSmQzyq9r4KlOxaBiNHLqomnZxiY/aUtfM=;
        b=teeFSwato2zTHCmlDEpIA/OfQDwwUf3UmwsBFuZTPWTKI0G/Na87bBpDBPF644+Qds
         JtixOSi9uXzob1mUdqLU39QnnFJB3299Uo51VO9PSPVtGAMRjSSmGcy1nXgwpFHoAAE1
         15H0feiUgjDGcqm7lkl4InlnQwVS+Lpj7moXpuHxx3TyZWxJEUHDvfQD2DUOTaXEeozl
         2R7vLf0NvIkACSpat9pfaevEVUi9kLnPsycrpEM5Hj5S2uRaFihQ3VbllqmgKk/N+49y
         K1KMUsmuslzIA9yBoNR1prYHQS3CPp31AQeK4UkuEogvh7fxVntVxD/ypDNOzYPU/8Ad
         nKWA==
X-Forwarded-Encrypted: i=1; AJvYcCVZen3PgGxuCz0Vo/Y4G4v1rqMYnCZdhKn/ueo/f79e4/lhATUFoaYkOp2e4JNlH4aiNL/kIHFMrcgYQ+7Dyg9miu0cqAkqabL/lClT
X-Gm-Message-State: AOJu0YxgHZMLU4Xm12EP61CKDzi2ItB4SgaExzh0lXSuiZTmbvhoj4o+
	zybmVCQ9lyJaWS1IhQj67IArdRrZSptzWPWKCea0hSfXpzq1VgTHeS8B67WK9e8=
X-Google-Smtp-Source: AGHT+IFrFBtEWI8G3mIhZShOA/h8coVH75w3HUcYb7DxNvB76QnrvRr68I5ag+1Mh1T6RnbU58v1zg==
X-Received: by 2002:a17:907:d581:b0:a7a:8cb9:7490 with SMTP id a640c23a62f3a-a8392a15b30mr1057699366b.47.1724171812633;
        Tue, 20 Aug 2024 09:36:52 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:52 -0700 (PDT)
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
Subject: [RFC PATCH 16/16] sched/fair: Don't mess with util_avg post init
Date: Tue, 20 Aug 2024 17:35:12 +0100
Message-Id: <20240820163512.1096301-17-qyousef@layalina.io>
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

The extrapolation logic for util_avg for newly forked tasks tries to
crystal ball the task's demand. This has worked well when the system
didn't have the means to help these tasks otherwise. But now we do have
util_est that will rampup faster. And uclamp_min to ensure a good
starting point if they really care.

Since we really can't crystal ball the behavior, and giving the same
starting value for all tasks is more consistent behavior for all forked
tasks, and it helps to preserve system resources for tasks to compete to
get them if they truly care, set the initial util_avg to be 0 when
util_est feature is enabled.

This should not impact workloads that need best single threaded
performance (like geekbench) given the previous improvements introduced
to help with faster rampup to reach max perf point more coherently and
consistently across systems.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad72db5a266c..45be77d1112f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1031,6 +1031,19 @@ void init_entity_runnable_average(struct sched_entity *se)
 }
 
 /*
+ * When util_est is used, the tasks can rampup much faster by default. And with
+ * the rampup_multiplier, tasks can ask for faster rampup after fork. And with
+ * uclamp, they can ensure a min perf requirement. Given all these factors, we
+ * keep util_avg at 0 as we can't crystal ball the task demand after fork.
+ * Userspace have enough ways to ensure good perf for tasks after fork. Keeping
+ * the util_avg to 0 is good way to ensure a uniform start for all tasks. And
+ * it is good to preserve precious resources. Truly busy forked tasks can
+ * compete for the resources without the need for initial 'cheat' to ramp them
+ * up automagically.
+ *
+ * When util_est is not present, the extrapolation logic below will still
+ * apply.
+ *
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
  *
@@ -1080,6 +1093,12 @@ void post_init_entity_util_avg(struct task_struct *p)
 		return;
 	}
 
+	/*
+	 * Tasks can rampup faster with util_est, so don't mess with util_avg.
+	 */
+	if (sched_feat(UTIL_EST))
+		return;
+
 	if (cap > 0) {
 		if (cfs_rq->avg.util_avg != 0) {
 			sa->util_avg  = cfs_rq->avg.util_avg * se_weight(se);
-- 
2.34.1


