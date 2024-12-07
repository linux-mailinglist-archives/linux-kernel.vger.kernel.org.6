Return-Path: <linux-kernel+bounces-436040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17B9E8053
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0E162DA3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCB14885B;
	Sat,  7 Dec 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b7TjouYw"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A4146596
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733582861; cv=none; b=Gknz7+akjafy6QTad3xhq4XUeXkoVlHFs3LP83UHtAevMCZULOOOzXMxeqzbZ78s678LfLDp7OHtIjI9URVH3SI0a4WZkuTQDVlgfzZSYtCehBae11SEtTnS5WN6wed0oM6opq2xJoE+fRzgglHVdXKxWlpt9O3GWL32yYi9js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733582861; c=relaxed/simple;
	bh=zcqiHCnrJS4cKbpe+G9eF9jmSbLJWQkUvfyCD3Z9fNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzhUBDSCCRt0g+WHGdicDDG+gAt6osmXh1t4Y19Dy7KrLhahmNA4G/+XqzyFa5C9GQ6eXqrbInJgO4RRnSNJDP6ZagYjvyJtwwGrQukjYTXeYyV1w+8EDqkh3qa73FKSBnJnEQAFtSqt/wlBhrFrEwXA3RynvtfTZiFOJvs8brA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b7TjouYw; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF4573F6BB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733582849;
	bh=SK4VRgmZk4OQ/9PqAGdscKeh3qVkZD1+YrH/zt8icWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=b7TjouYwQ69w1pC+pcjJYsmyEuY6K8V5VUwRMiyrBrA6aS78gZSdZDvBXjrS53Pz7
	 DggvB/v88pwF83sPgk4M6VlfUr5Nami0qut3owmdUN+2ZjggLXDRKKMO0QWi42HWfF
	 Lue55XUpAHvk+wI0XOla6KR5xA1R32+Ji9zGx2y6Mzq1fPauQThOXF9cm+PIov3/zx
	 JuWRmWkwyYu4PbuN5XeHeSiuzn94WkjDEyJxOOyNhM2UYKCiIzpuPu2wL03xbR1cd2
	 JQIeimZ1Kdpdy64K6Ho/lndFdyD5gBwK8miAuvTtCprqQvQsOXAetmCi+VAmngEUf4
	 bFgUfXEpDFZNw==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-725c0e0ee5dso1092396b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 06:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733582848; x=1734187648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK4VRgmZk4OQ/9PqAGdscKeh3qVkZD1+YrH/zt8icWk=;
        b=ZpFzVBUcT4ZUiQHLQ8eAZnqyQQrfLbQEUw6OO78vjbZHgUDI7rLquDQeAUnVFgw+NX
         hSFs16xIXDLIDF5zS6LHWY3wgnWe4IqCKwg5+jynlaAqSvOvOylJxjDgneh00LGhh/Fb
         K1UZU350P5Vfs8f5lG/HNZsh2RupXUfZv0FxdJmLOlOBlccxpEzw2WHBRuAnG6B7CTvP
         9Ob+hQjG4T8AK6R7G/i8kHZHE73LpM3IrIEzLvjsz68HBVfFWSgP2vHgIADq+ok20N7I
         cSlQvi9/SBDMxsCUlhICVWZXr2QtQC1t0jBwpaQ0jXC3GB03nThNUYdGkvpQAYCicC+M
         Y6Jw==
X-Gm-Message-State: AOJu0Ywqzz9KOmhe63jDtmkJGkWQu4FrUTUZk3Q36yZUHP3FcxFlBb4l
	MEf4ispJTQQSMzeBygE3S7m+KSWPe+lSKoi+8iM+ix5D0i4WewEmvGP4QwsFnKve/aVGlWtwfFF
	k6qGmWBdC03paESLw/OeTSlOgfCMevHAXaJjtBKwgGuEpEE5XnQXaATMcELIJqj9ZWzv9Hvy8W2
	Y4bv3kw+mYGg==
X-Gm-Gg: ASbGncsWIW4ak1incOiVQfWZYIH6AsG+1B9Op1kjb+GQKgjYVPsMU4JsiGH4OsAujuy
	b4zYrpL6stzJbltybUwm54ICezqTAoNqvwDP9ZzSb/PegJsRTFquB9l7tGZH1N9BxO5tNx81g8c
	EjeSyLUgkgcLpWC+HUykEebS8P4fZblE4cMemYoM7a6CeUqNR93KDIVZosqZaI+K+cSk/I27/sy
	Tazsy/lLL3u549bL2lZnT1qt2s46d0JNEyPESTedJayw8EnLdEuzHs=
X-Received: by 2002:a05:6a00:2196:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-725b80ded86mr11821499b3a.3.1733582848023;
        Sat, 07 Dec 2024 06:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4KU0cXmyw5fXqEzuzNtZ7U5SgaNeWuB7hRu+bmuCkUXsCncJH4sGeF1ZGYLI7l/LnCuwWlg==
X-Received: by 2002:a05:6a00:2196:b0:725:a78c:6c31 with SMTP id d2e1a72fcca58-725b80ded86mr11821475b3a.3.1733582847658;
        Sat, 07 Dec 2024 06:47:27 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:d825:2a47:700a:b3b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ef564sm4551989b3a.78.2024.12.07.06.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 06:47:27 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	peterz@infradead.org
Subject: [PATCH] cpu/hotplug: ensure the starting section runs fully regardless of target
Date: Sat,  7 Dec 2024 23:47:21 +0900
Message-ID: <20241207144721.2828390-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_CPU_HOTPLUG_STATE_CONTROL=y, writing a state within the
STARTING section to 'hotplug/target' file for a fully online cpu can
cause a kernel crash [1]. This occurs because take_cpu_down() disables
the CPU, but the state machine does not reach CPUHP_AP_OFFLINE. As a
result, when cpu stopper thread finishes its work and idle task takes
over, cpuhp_report_idle_dead() crashes on 'BUG_ON(st->state !=
CPUHP_AP_OFFLINE)'.

In the opposite direction, start_secondary() assumes all startup
callbacks have been invoked and transitions to CPUHP_AP_ONLINE_IDLE,
regardless of the written target. This can result in some callbacks in
the section being silently skipped.

Callbacks in STARTING section must not fail in any case and seem
expected to be executed in one continuous sequence. So, modify both
take_cpu_down() and notify_cpu_starting() to ignore st->target and fully
traverse the STARTING section to its appropriate end state. This
resolves the issue and ensures symmetric behavior for both directions.

[1]: example of reproduction steps:

  # grep 'tick:dying' /sys/devices/system/cpu/hotplug/states
    143: tick:dying # whatever in the middle of the section can be used.
                    # (st->cant_stop needs to be false)
  # cat /sys/devices/system/cpu/cpu7/hotplug/target
    238             # fully online
  # echo 143 > /sys/devices/system/cpu/cpu7/hotplug/target

    [  145.091832] ------------[ cut here ]------------
    [  145.092928] kernel BUG at kernel/cpu.c:1365!
    [  145.093960] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
    --(snip)--

  With this patch, the crash no longer occurs and the state transitions
  to the opposite end of the section.

  # echo 143 > /sys/devices/system/cpu/cpu7/hotplug/target
  # cat /sys/devices/system/cpu/cpu7/hotplug/state
    88              # "idle:dead"

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 kernel/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 85fd7ac4561e..34749792b37e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1269,7 +1269,6 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1285,8 +1284,9 @@ static int take_cpu_down(void *_param)
 
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
+	 * Regardless of st->target, it must run through to CPUHP_AP_OFFLINE.
 	 */
-	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
+	cpuhp_invoke_callback_range_nofail(false, cpu, st, CPUHP_AP_OFFLINE);
 
 	/* Park the stopper thread */
 	stop_machine_park(cpu);
@@ -1593,15 +1593,15 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 void notify_cpu_starting(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
-	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
 
 	rcutree_report_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	cpumask_set_cpu(cpu, &cpus_booted_once_mask);
 
 	/*
 	 * STARTING must not fail!
+	 * Regardless of st->target, it must run through to CPUHP_AP_ONLINE.
 	 */
-	cpuhp_invoke_callback_range_nofail(true, cpu, st, target);
+	cpuhp_invoke_callback_range_nofail(true, cpu, st, CPUHP_AP_ONLINE);
 }
 
 /*
-- 
2.43.0


