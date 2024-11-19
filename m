Return-Path: <linux-kernel+bounces-413729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833319D1DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD26B20D77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6412AAC6;
	Tue, 19 Nov 2024 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/SEX1xh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C628E3F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981924; cv=none; b=JtesLK+dpqfLzGXtyyA4nC4IgWpG0Sx04Ud9kP3tEapK2XSqUKne7XhGxqNNAQZmFZap+n0H21WLDxXXVWjAARNhoyWzBsOPN8pngBT91OBdDdZF3NYcmqk6g+IvJOTB46z3faxxQ58wfsSpaE0ZF11/rIZFeO3ij2gRbgRTyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981924; c=relaxed/simple;
	bh=4QB5ElzE9j4D9M0fHUHAvmmqFK+FzyCjqXxd2sd4in8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=Y5chIvkJLD+/RD+8hc4iSFBtRCogu9yfK0xX+NgUPQVDaPICdhY1/hPeYAxpjTFRTo6/PxSPiD5FO/9bqnPo3/Ge5Mw6PB035bHIjSSn8ClCkbvz+4FIk0ArGsNaQOslQ31oycrfs6lYQnti6cU8ExSWAZCgaKPiIkV5US/MIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/SEX1xh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee426e3414so65093357b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731981922; x=1732586722; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6gLHV6vusPni+PQ8Izadtx5nSuli5BwZYfDCvAoOeM=;
        b=e/SEX1xhEWM3eNdHTJAwjiILr5yWJOa/FS39TCX5QciCRNgfexVj6kkrwozFd/Gjqz
         9MuLw3saWf5rn+BuLKoXCZWVNrqxH8QtxNWQj3E88Nh1wqPFcYCLkAd4rewmxw6iLJw3
         80+BQZH+I7FC56VEi0it3gN7Xw/TZ/N5xVuBaZThW95VxIgXjb9n7J/XX/32D0Ur6VXS
         tZ2ta2rfZRB/sWC1rMWXZh4Q2Pql1l/fgY6joO4D6VPqBIVCKNxUO0tZwNrSOuWAi8Ep
         Sfo/9MF6h+OrGG0vzdEqn0ATQKonAfMueWxgQfIUhLYAVNYuFSR+1/GhIUY9oTkzGVlj
         Kp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731981922; x=1732586722;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6gLHV6vusPni+PQ8Izadtx5nSuli5BwZYfDCvAoOeM=;
        b=bWEjxBAwFHxqfhwpqN0R8Fl4ES1Y1AsQwW+eWVUll+vWJgP4/2DRAjeIvCd5fAyyes
         u92nWynnSBn5kk3AbjHXyZBe8v+f4pP+p3SucLhke+4K3gMduRMUw0MaL3McyXOQaMSY
         MC4TawbPzQE6FhV+Z/vvctuf2zPYfEr0R42+sB4+yVeOSrJbdgOJkUU3NomT81p9tOtQ
         S2IvLsfB/nUWNinZNwjRpU2q3+8oPDWxydoT7b7qKhFhpy2RqYHxb2DJa3CNzauPqpiW
         i6AzesxmcWE9YhtgnvyVCSoq+FZ2TlZlgk5+r3/vj7azpYft8aZHsmB1fLcN959K28n7
         ZffA==
X-Forwarded-Encrypted: i=1; AJvYcCUAW7OO+p4T01Tu+z+Ag7+DZj174IwT7TgJtCbqHDrmP5vdBgPFp6DLqOihOn7AIfJrQnibif+tqFzV9YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWR6AgjAUoqnDPPRz/oVZ5w1Y8MN8evCxqXD0N5ltVfrZ2PgG
	Y2PWnLZnfaLjN5Rzka7vPeHATHO9WZlUFwwfCISjaqtyK34+MKmn4Y8N8G4u1P8Qq4ymicxloBA
	GcmT/ymnPXukrgA==
X-Google-Smtp-Source: AGHT+IE+bPfkzUK73IBzFCd66eKNwWVRKFYblcIQrjih3BXRxNv23IR/qXTl7unR+SbMbXVjKQ/UK2FsOTTH9lE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:296a:f9c4:979f:3466])
 (user=saravanak job=sendgmr) by 2002:a05:690c:8110:b0:6ee:3f5e:1c1b with SMTP
 id 00721157ae682-6ee558f3375mr451477b3.0.1731981921704; Mon, 18 Nov 2024
 18:05:21 -0800 (PST)
Date: Mon, 18 Nov 2024 18:05:15 -0800
Message-Id: <20241119020519.832013-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [RFC PATCH v1] cpu/suspend: Do a partial hotplug during suspend
From: Saravana Kannan <saravanak@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The hotplug state machine goes through 100+ states when transitioning
from online to offline. And on the way back, it goes through these
states in reverse.

When a CPU goes offline, some of the states that occur after a CPU is
powered off are about freeing up various per-CPU resources like
kmalloc caches, pages, network buffers, etc. All of these states make
sense when a CPU is permanently hotplugged off.

However, when offlining a CPU during suspend, we just want to power
down the CPUs to that the system can enter suspend. In this scenario,
we could simply stop the hotplug state machine right after the CPU has
been power off. During resume, we can simply resume the CPU to an
online state from the state where we paused the offline.

This save both time both during suspend and resume and it is
proportional to the number of CPUs in the system. So, if systems with
a large number of CPUs, we can expect this to have a huge amount of
time saved.

On a Pixel 6, averaging across 100+ suspend/resumes cycles, the total
time to power off 7 of the 8 CPUs goes from 51 ms down to 24 ms.
Similarly, the average time to power off each individual CPU (they are
different) also goes down by 50%.

The average time spent powering up CPUs goes down from 34 ms to 32 ms.
Keep in mind that the time saved during resume is not easily
quantified by looking at CPU onlining times. This is because the
actual time savings comes later when per-CPU resources do not need to
be reallocated and would speed up actions like allocations, etc that
can pick up memory from per-CPU kmalloc caches, etc.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Hi Thomas/Peter,

The hotplug state machine rewrite is great! Enables all kinds of
optimizations for suspend/resume.

About this patch, I'm not sure if the exact state the hotplug state is
paused at (CPUHP_WORKQUEUE_PREP) will work for all arch/boards, but
this is the general idea.

If it works as is, great! At a glance, it looks like it should work
though. None of the other stages between this and CPUHP_OFFLINE seem
to be touching hardware.

If CPUHP_WORKQUEUE_PREP doesn't work, then we can make it a config
option to select the state or an arch call or something along those
lines.

What are your thoughts on this? How would you like me to proceed?

Btw, ideally, I'd have liked to have paused at CPUHP_TMIGR_PREPARE,
but the hrtimers unwinding seems to be broken if we fail/unwind before
reaching "hrtimers:prepare". I'll send out a separate email on that.

Thanks,
Saravana

 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00..ca21ac017471 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1649,7 +1649,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	if (st->state >= target)
 		goto out;
 
-	if (st->state == CPUHP_OFFLINE) {
+	if (st->state < CPUHP_BP_KICK_AP) {
 		/* Let it fail before we try to bring the cpu up */
 		idle = idle_thread_get(cpu);
 		if (IS_ERR(idle)) {
@@ -1931,7 +1931,7 @@ int freeze_secondary_cpus(int primary)
 		}
 
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
-		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
+		error = _cpu_down(cpu, 1, CPUHP_WORKQUEUE_PREP);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
 		if (!error)
 			cpumask_set_cpu(cpu, frozen_cpus);
-- 
2.47.0.338.g60cca15819-goog


