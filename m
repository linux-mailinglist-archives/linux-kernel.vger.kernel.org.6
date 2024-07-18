Return-Path: <linux-kernel+bounces-256857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D673B93716E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DAE1F21A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9376A4DA13;
	Fri, 19 Jul 2024 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2N0SKvD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B20481D5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721347209; cv=none; b=meymJiwJazhNo0BAT8ke7zSuvQcDvnANNRFOB17xzrw6FLcP5Bhc5D6b5RuOj8bFcIPEeXCIgbjz9M1XQaZv905V4x2/z575mvXkudAqPp40QX+12xpEe+MiLrpZ1/FDyRRGTb0cr3VsuU1T7Q3qYz5HH2BJ54TZyYzf+C52/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721347209; c=relaxed/simple;
	bh=ZMl3CgvXKI0kGS4UvrPRPhOCrjlQA4qOSK3yFNnLPq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHK516WNfbkEa2C+8K6FkyK4IvkpleDkojbU8IP0DtpnrW310ujQGxGA6+Jl9Wu+Qp3C75MrH6cniqNtYAlVOM8mROpvuhXAz25eAI4a4YgBoE8qBhhHDjjlorpDaYE1YteaNEygjuJIzvybDNXBqKwqcu+k8jy7VqOCTHW0aFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2N0SKvD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb05b0be01so8999475ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721347208; x=1721952008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhFjKkNjAi1oeJpxJm8K6xSBLtitAfnagpuZpkzecaE=;
        b=R2N0SKvDhOjibk6ufSJPYtBgMl0KZtuDl2KlZIp9HzPQ1Vx0m/WcbhTNS6tDWwvjH4
         hjlj1Z8VuC9qG/wx8eDn6ySf42rz2h3GVtxY3zXFS+omHiprFXCM1jdPHQbx4cSuymfE
         i+pGLupJHeseJ0jdfN0RqWcrzxQ4Xy11tKNr+WkkPK9nuXYNZQlpUM+W5eblbxCKXqby
         ZQvEvnWxiBLWDjcbVDL//JlVKNSxjw6f+FOqQK9b4knEUU4UMlrFclMxEandsTm6KdNn
         yj1XTNP15saGXtgKC/3zHEUQE66qA6TnGOVh3+NGDyP7eQT2FjxRULe4VQ4yNMv8eYZ0
         c3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721347208; x=1721952008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhFjKkNjAi1oeJpxJm8K6xSBLtitAfnagpuZpkzecaE=;
        b=Ieo1l/weP/jsvwMxvVDjgxIlmE/aFkBCyK/s3Bh/fzrnnoKl+jMnCuhTNWkCSC9jrW
         OQRGDEX2IjWBtH6HA2tm/GWkwqO0b6AEIVch2CG+OklJyLMZeE4vVB5lYWtWIcpMsP12
         pBxRNJPH9HuiR5SwE5m3qrH8c2aSUYYLCsgWkGXmBsYz/hFYvPBiGBdZ1U/XvyGBuZlY
         5E6eOqbi/ChOZ9dDD2VJMK5UlIZGmYQ5zWzCK6f//nJGDPjXwLQzTdF8cTRtfBKeSe3B
         pfC+F6MMnov+EEi7hDBFRDeJQsEJvRR8bOXnRRYNjjL7CneVA7Q/IBTIHBVb/jINjeUa
         1g2g==
X-Gm-Message-State: AOJu0Yzy5VwdmOSjlSscTxPO0ZsTiVH5NykzdN8HwuvoPopw91tz13HZ
	pneAGU/62hGGr+xHU/7O8/4dfEI9jRhHoZo+D6DKJO84iUz+syx+
X-Google-Smtp-Source: AGHT+IHA8SQDymle9BH0GtJacvNYGwmAj2OkL41i3t9Nsh1tnQWQPfsXeQHrdaci5SH9E5XroevhVw==
X-Received: by 2002:a17:903:2282:b0:1fb:7b96:846e with SMTP id d9443c01a7336-1fc4e6ed33amr62010595ad.44.1721347207554;
        Thu, 18 Jul 2024 17:00:07 -0700 (PDT)
Received: from fedora.. ([222.186.150.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d4c2a7sm1484715ad.268.2024.07.18.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 17:00:06 -0700 (PDT)
From: Xiang Lin <myd.xia@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Xiang Lin <myd.xia@gmail.com>
Subject: [PATCH] irqtime: exclude steal time on paravirt
Date: Fri, 19 Jul 2024 07:58:31 +0800
Message-ID: <20240718235831.19150-1-myd.xia@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On paravirt, guest irq time may include some steal time, need
subtract steal time delta when accounting irqtime. And when
account user or system time, we exclude irq time and steal
time, if irq time includes some steal time, this will make
user or system time smaller than actual value.

Using below steps to reproduce the problem:
    1. run qemu, and pin vcpu to a physical cpu(e.g, cpu15)
       taskset 0x8000 qemu-system-x86_64 -nographic -enable-kvm \
            -kernel bzImage -append "console=ttyS0,115200 nokaslr" \
            -initrd rootfs.cpio.gz -nic user,hostfwd=tcp::2222-:22
    2. run below cmd on guest console to increase some irq loads
       (guest) top -d 1 -b
    3. ssh to guest, and monitor cpu usage
       (guest) top -d 1 -b | grep ^%Cpu
    4. do some stress on host, and pin it to the same physical cpu as vcpu
       (host) chrt -f 2 stress-ng --cpu 1 --cpu-load 90 --taskset 15

  Before patch, the irq usage is fluctuating hugely
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,5.6 id,0.0 wa, 16.7 hi,  0.0 si, 77.8 st
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,8.1 id,0.0 wa,  2.0 hi,  0.0 si, 89.9 st
   %Cpu(s):0.0 us,0.7 sy,0.0 ni,6.2 id,0.0 wa, 15.9 hi,  0.0 si, 77.2 st
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,8.7 id,0.0 wa,  2.9 hi,  0.0 si, 88.5 st
   %Cpu(s):0.6 us,0.0 sy,0.0 ni,5.0 id,0.0 wa, 16.7 hi,  0.0 si, 77.8 st
   %Cpu(s):0.0 us,0.8 sy,0.0 ni,9.4 id,0.0 wa,  0.0 hi,  0.0 si, 89.8 st
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,6.9 id,0.0 wa, 15.9 hi,  0.0 si, 77.2 st
   ....

  After patch, the irq usage is steady
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,7.2 id,0.0 wa,  2.4 hi,  0.0 si, 90.4 st
   %Cpu(s):0.0 us,0.8 sy,0.0 ni,7.9 id,0.0 wa,  1.6 hi,  0.0 si, 89.7 st
   %Cpu(s):0.8 us,0.0 sy,0.0 ni,7.2 id,0.0 wa,  2.4 hi,  0.0 si, 89.6 st
   %Cpu(s):0.0 us,0.8 sy,0.0 ni,8.0 id,0.0 wa,  1.6 hi,  0.0 si, 89.6 st
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,7.2 id,0.0 wa,  2.4 hi,  0.0 si, 90.4 st
   %Cpu(s):0.0 us,0.8 sy,0.0 ni,7.9 id,0.0 wa,  1.6 hi,  0.0 si, 89.7 st
   %Cpu(s):0.0 us,0.0 sy,0.0 ni,7.2 id,0.0 wa,  2.4 hi,  0.0 si, 90.4 st
   ....

Signed-off-by: Xiang Lin <myd.xia@gmail.com>
---
 kernel/sched/cputime.c | 20 +++++++++++++++++++-
 kernel/sched/sched.h   |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a5e00293ae43..bc00296f8f9b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -46,6 +46,23 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_end(&irqtime->sync);
 }
 
+static u64 steal_irqtime_account(bool irq_entry)
+{
+#ifdef CONFIG_PARAVIRT
+	if (static_key_false(&paravirt_steal_enabled)) {
+		struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
+		u64 delta, steal;
+
+		steal = paravirt_steal_clock(smp_processor_id());
+		delta = steal - irqtime->steal_start_time;
+		irqtime->steal_start_time += delta;
+
+		return irq_entry ? 0 : delta;
+	}
+#endif
+	return 0;
+}
+
 /*
  * Called after incrementing preempt_count on {soft,}irq_enter
  * and before decrementing preempt_count on {soft,}irq_exit.
@@ -54,7 +71,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 {
 	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
 	unsigned int pc;
-	s64 delta;
+	u64 delta;
 	int cpu;
 
 	if (!sched_clock_irqtime)
@@ -64,6 +81,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	delta = sched_clock_cpu(cpu) - irqtime->irq_start_time;
 	irqtime->irq_start_time += delta;
 	pc = irq_count() - offset;
+	delta -= min(delta, steal_irqtime_account(!pc));
 
 	/*
 	 * We do not account for softirq time from ksoftirqd here.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..b5389bc8062f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2981,6 +2981,9 @@ struct irqtime {
 	u64			total;
 	u64			tick_delta;
 	u64			irq_start_time;
+#ifdef CONFIG_PARAVIRT
+	u64			steal_start_time;
+#endif
 	struct u64_stats_sync	sync;
 };
 
-- 
2.45.2


