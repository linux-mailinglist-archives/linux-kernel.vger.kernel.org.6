Return-Path: <linux-kernel+bounces-335609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB397E808
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF50C1F21311
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C61946CF;
	Mon, 23 Sep 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHf/o0xG"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9A1946C3
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082084; cv=none; b=PPhdV62Fh7JLZpDZ5l5occNEG0GOgrBstpZ1I56PBuC51YPVYRvpDQFk35F/m1h6VWXCp0kfeXIeHr+FeVYIperIEiBNgpHuecbLAgqStlM7Cbf7Lbz/ZTNg8l6pil1jmoXGYQpgMGyJkPThWo5FWk6BEQpZF/1Mq6NEjX9jpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082084; c=relaxed/simple;
	bh=ebaEp4qgWBJ6q1S+WqYncxTKs1M2+e7QNkGq1Dioxp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbND2LX7wmk5SDCol4J8F8nQ/IcOkH7Xl5HcMuCyyax/q6O5v+fuc9b/zrcq6PQWJlJol17zqpVOPC9nz6Ac8YVpJLGO5Mcomi0AW/f/nMZXjCvt6gwqsYlWD2hxkXGSSvjx6x6ikqGd5Wtf94E+W+Pw7BtAIi6JuMEB2NVKNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHf/o0xG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2743018a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727082082; x=1727686882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23Ofto8ZNkiE6V91gkyCDbtFPh5A2fyseeuvv0xtnBE=;
        b=WHf/o0xGO1j4BIdN51WudlLG7CfJC37mpiZWS1s+Solfxn8dvNfHBj1Y61gHW8jB7u
         5+BvGepL7AGKlLFmzcOAxeNVO8xfQUJ/nCgatCxQS9yxcd/SrqUZXRgp2dBRRwW4X3A5
         zdUjCTmApgUcXypf+cKpo/dNdzeoDP0Tlpa5heVEcKrskTlQp3mRZJZZ2uZgs9f2oV/v
         i4ScYgzf6BjF74KDoR4aNhsxu68F2riwdGKaTbJQz7UUw/DdZlLpXuOL6vOmFS1rqeK9
         rxjK8IO5tvREKhBt0QXu0XInz9anz+qqcKPwgDO9ok7mVEuB2b+QeuLdC5TLmi7XFkmZ
         ABbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082082; x=1727686882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23Ofto8ZNkiE6V91gkyCDbtFPh5A2fyseeuvv0xtnBE=;
        b=vX5D5RwsLfLb7mlbNxCQVcN3outBgR3laCY3jKkORtpNSz3b7V5wl8tmGVNun7lAed
         lAxqb2qPWnUgzWy7EGXR4Xfd9jeG3aXIUxfVezTe5nfjyCad9lWeNHj1WAJTGeaeIVeB
         BFKQ92gxL2g/olSaPEiUb3GLmmt/8ScU5La78o141dCPQyxJNmVzQV+yxjC7bzjw1cci
         CcBITQd/bl07ujV13mJwTQE+QKraMmWfHUHon+lTuhuLcLOsq/Cgh8DDA3MpCJCTCXmw
         ZTEe29BN5tbtTVGCPs+KR6TP9tdFO07cTlwg1hbXypnNQMe2gdMIOSwGNMGjwjMdXvtl
         WC5A==
X-Gm-Message-State: AOJu0Ywkb1pGEKFYrcc68b9qJ/Dhxs234xlkzVFibHTHmCxrXOUPAuxu
	OlcxPKqzYiOSv50aUVJIUtuuEUDfaIVljG2tUG+yt8/Zq4M/aQBL
X-Google-Smtp-Source: AGHT+IEfwqDx4aMnlQUqypf9YkQ/UQsMIguXiKc+NhiWwMRpgYtI2wvqkQGPEY5D7UlBq9LPG2NtNg==
X-Received: by 2002:a17:90b:17c6:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2dd7f416072mr13601148a91.18.1727082082589;
        Mon, 23 Sep 2024 02:01:22 -0700 (PDT)
Received: from localhost.localdomain ([39.144.43.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ca487sm6768872a91.39.2024.09.23.02.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2024 02:01:22 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/3] sched: Define sched_clock_irqtime as static key
Date: Mon, 23 Sep 2024 17:00:27 +0800
Message-Id: <20240923090028.16368-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240923090028.16368-1-laoar.shao@gmail.com>
References: <20240923090028.16368-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since CPU time accounting is a performance-critical path, let's define
sched_clock_irqtime as a static key to minimize potential overhead.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/cputime.c | 16 +++++++---------
 kernel/sched/sched.h   |  1 +
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 4586db5cf3a8..de9a36e0fe04 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -7,6 +7,8 @@
  #include <asm/cputime.h>
 #endif
 
+DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
+
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 
 /*
@@ -22,16 +24,14 @@
  */
 DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
-static int sched_clock_irqtime;
-
 void enable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime = 1;
+	static_branch_enable(&sched_clock_irqtime);
 }
 
 void disable_sched_clock_irqtime(void)
 {
-	sched_clock_irqtime = 0;
+	static_branch_disable(&sched_clock_irqtime);
 }
 
 static void irqtime_account_delta(struct task_struct *curr,
@@ -61,7 +61,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	s64 delta;
 	int cpu;
 
-	if (!sched_clock_irqtime)
+	if (!static_branch_likely(&sched_clock_irqtime))
 		return;
 
 	cpu = smp_processor_id();
@@ -94,8 +94,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
 
 #else /* CONFIG_IRQ_TIME_ACCOUNTING */
 
-#define sched_clock_irqtime	(0)
-
 static u64 irqtime_tick_accounted(u64 dummy)
 {
 	return 0;
@@ -482,7 +480,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_likely(&sched_clock_irqtime)) {
 		irqtime_account_process_tick(p, user_tick, 1);
 		return;
 	}
@@ -511,7 +509,7 @@ void account_idle_ticks(unsigned long ticks)
 {
 	u64 cputime, steal;
 
-	if (sched_clock_irqtime) {
+	if (static_branch_likely(&sched_clock_irqtime)) {
 		irqtime_account_idle_ticks(ticks);
 		return;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8063db62b027..db7d541eebff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3174,6 +3174,7 @@ struct irqtime {
 };
 
 DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
+DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
 
 /*
  * Returns the irqtime minus the softirq time computed by ksoftirqd.
-- 
2.43.5


