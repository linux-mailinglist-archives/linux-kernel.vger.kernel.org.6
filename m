Return-Path: <linux-kernel+bounces-249180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E792E816
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06319284B57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926E15B149;
	Thu, 11 Jul 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RJCFoes+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482CD82C7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700227; cv=none; b=rGIQvd7ZtU0ZHWY7IAdx9n7I1vGCVILk4v46npemB92ou7BPyVWWZMPGukWVzK5HVkkFk6hVrAxhK/AhE8sC6AlkRYxU8D8VE+SbsHZrlVzt3r1JDMZytq3bTNdhUuXT0kij+cL+rIuRCm59tjqvh5K9CV+DWd56SSSNIE87yVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700227; c=relaxed/simple;
	bh=Bpm6/V6MDQFK3+fB6ShwWGUjksTwvserU1Szp0+Gc14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oeeNu1CcCxilQjwq3lVGxBE6ZQjApXNy4QFLPBpHjXtOCn/JKuBYxgzf6ItNSa2uzibWbSZkdTWtOkVY1YWD16up4l9SLAvMVcsssRK+tSmIAMVP+bu2IZYS0cnSYfLX49dmT3Gw6IVrxcfK6R/xIx+WGFg0vlYN9xsdckpdo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RJCFoes+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb1c918860so13360155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720700226; x=1721305026; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2pG6NifEEeNfHkGMBqMcDY/jdLpNHGUhc4OZl9qCkHI=;
        b=RJCFoes+QwAmRmLxSJqHOAibQJN1eR2QeCyexZ0jaVR0CdCRoq4Em4UiPs2nEx1jea
         RILHhB+leQIF1lQHzKODY/bUm7JkqxYiCJbKKk/HfgbJD472c41cxD2vbITM83UlJYUr
         44HLVuU3LBHk6E+YmYmOXzsXJNaSd4DCBCE1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700226; x=1721305026;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pG6NifEEeNfHkGMBqMcDY/jdLpNHGUhc4OZl9qCkHI=;
        b=ttJVRmfuWicz3umROSUZ4Smdu3KTDEigbmeDhVkjRTRLr8L11bMB6AjzHyUjHzAgt/
         Cw+nbYOmNOX27NO9LAw++GvKjhxnerZ3pxTDSzKwqmqSOMPYyoVicmKLLH+gpmMcWNxP
         YEBXF8LCHW4RhfOdou3C8PAb/jjAnzgNkBin+mfDWQg9fD6pM0WdH+VGAXyaH4TctZs7
         5KwtNTI4qE/L2RH8az9MBBxN9aWTSSqDNVyuqUQ7j90zWx15wupyE5BonyAU2tbxEuiU
         uDTdTDJM6feNhqE0B/UbSIdOFB7XM4mvZEz5oNOjKiewnpbZFpcjeBWicJMKZmd1vHjV
         s5TA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqBA9bLHgxopQwCcSA3+1KomwcjNnzAvOgUJnSwjVlpC+OP0/4h2lgdraE4B9Z+YvDxWotqkHEZmqWTOCrZLkSdHCg0aV4x4thlC+
X-Gm-Message-State: AOJu0YzB4aMffS4/jlYne8AVIZ4ywHbXt59mniKwTq35uo63urAqs4VC
	T/IqE+6lDHvkI5x5fTDEbl5dEUUDHGRi9NcC60dcQmh1e42B65Y4+j1tGC7v/A==
X-Google-Smtp-Source: AGHT+IHecHqT1oxxMCbOg1AOShzm2j71EEhKZQqKfq5DBpHatwzqR87qgWQdjHRuhZJRKeBdAtPcPw==
X-Received: by 2002:a17:903:2449:b0:1f8:44f8:a357 with SMTP id d9443c01a7336-1fbdba235a6mr35954355ad.17.1720700225602;
        Thu, 11 Jul 2024 05:17:05 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10111sm49211985ad.20.2024.07.11.05.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 05:17:05 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	asmadeus@codewreck.org,
	siyanteng@loongson.cn,
	sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH RFC 1/3] perf/core: add logic to collect off-cpu sample
Date: Thu, 11 Jul 2024 17:46:17 +0530
Message-Id: <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

following logics has been added to collect the off-cpu sample:

- 'task_pt_regs(current)' has been used to capture registers
  status off-cpu sample.

- off-cpu time represent the time period for which the target
  process not occupying the cpu cycles. And calculate as:

  off-cpu time = swap-in time - swap-out time

Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>

---
 include/linux/perf_event.h            | 16 ++++++++++++++++
 include/uapi/linux/perf_event.h       |  3 ++-
 kernel/events/core.c                  | 27 ++++++++++++++++++++++-----
 tools/include/uapi/linux/perf_event.h |  3 ++-
 4 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..09dc3f695974 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -599,6 +599,11 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ACTIVE		=  1,
 };
 
+enum perf_sample_cpu {
+	PERF_SAMPLE_ON_CPU,
+	PERF_SAMPLE_OFF_CPU,
+};
+
 struct file;
 struct perf_sample_data;
 
@@ -828,6 +833,7 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+	u64				stop_time;
 
 	/*
 	 * Certain events gets forwarded to another pmu internally by over-
@@ -1301,6 +1307,16 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
 	return size;
 }
 
+static inline void perf_sample_set_off_cpu(struct perf_sample_data *data)
+{
+	data->cpu_entry.reserved = PERF_SAMPLE_OFF_CPU;
+}
+
+static inline void perf_sample_set_on_cpu(struct perf_sample_data *data)
+{
+	data->cpu_entry.reserved = PERF_SAMPLE_ON_CPU;
+}
+
 /*
  * Clear all bitfields in the perf_branch_entry.
  * The to and from fields are not cleared because they are
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..9d0a23ab2549 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				off_cpu        :  1, /* include off_cpu sample */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..e71eb7936134 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7168,10 +7168,8 @@ static void __perf_event_header__init_id(struct perf_sample_data *data,
 	if (sample_type & PERF_SAMPLE_STREAM_ID)
 		data->stream_id = event->id;
 
-	if (sample_type & PERF_SAMPLE_CPU) {
-		data->cpu_entry.cpu	 = raw_smp_processor_id();
-		data->cpu_entry.reserved = 0;
-	}
+	if (sample_type & PERF_SAMPLE_CPU)
+		data->cpu_entry.cpu = raw_smp_processor_id();
 }
 
 void perf_event_header__init_id(struct perf_event_header *header,
@@ -11083,8 +11081,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 		return HRTIMER_NORESTART;
 
 	event->pmu->read(event);
-
 	perf_sample_data_init(&data, 0, event->hw.last_period);
+	perf_sample_set_on_cpu(&data);
 	regs = get_irq_regs();
 
 	if (regs && !perf_exclude_event(event, regs)) {
@@ -11099,6 +11097,18 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 	return ret;
 }
 
+static void perf_swevent_offCPUSample(struct perf_event *event, u64 period)
+{
+	struct perf_sample_data data;
+	struct pt_regs *regs;
+
+	event->pmu->read(event);
+	perf_sample_data_init(&data, 0, period);
+	perf_sample_set_off_cpu(&data);
+	regs = task_pt_regs(current);
+	__perf_event_overflow(event, 1, &data, regs);
+}
+
 static void perf_swevent_start_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -11107,6 +11117,11 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 	if (!is_sampling_event(event))
 		return;
 
+	if (event->attr.off_cpu && event->stop_time && hwc->sample_period) {
+		perf_swevent_offCPUSample(event, perf_clock() - event->stop_time);
+		event->stop_time = 0;
+	}
+
 	period = local64_read(&hwc->period_left);
 	if (period) {
 		if (period < 0)
@@ -11128,6 +11143,7 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
+		event->stop_time = perf_clock();
 		hrtimer_cancel(&hwc->hrtimer);
 	}
 }
@@ -11139,6 +11155,7 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
 	if (!is_sampling_event(event))
 		return;
 
+	event->stop_time = 0;
 	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hwc->hrtimer.function = perf_swevent_hrtimer;
 
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..9d0a23ab2549 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				off_cpu        :  1, /* include off_cpu sample */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
-- 
2.39.0


