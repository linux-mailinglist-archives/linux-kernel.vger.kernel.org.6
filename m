Return-Path: <linux-kernel+bounces-521766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B55A3C210
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F63116CA39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3CE1EDA1A;
	Wed, 19 Feb 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxzZeqmp"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF01DFE25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975100; cv=none; b=FML4zRA9dnEI/yzYGBgEErJs/PPIeWpCnvP2Wrd5DEzvYIDIvYfVFFaTyh32qn7LtBOXCNnQLdk4+GnFmXqDfqTNp+2wedHEEHJbznIsmD0ErHwHffMi9WhsOimwAm+2RwoEnRCC0Yyh3yx7+58AY97dGLlsGVa9RWpND4jwE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975100; c=relaxed/simple;
	bh=NEpwjvWwd3zdH87q00QcMAth/YL8+NIAVMkbiMlaE5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SK0fWu3jFEKMGD2dAP0JZ3elN0AY9hboi3TrmHpaeU6b2IZzeUV8CBM+KUARzRiwWB7AFkgARytWLc//Nb5hsVK7Ap34VePRKBdRph1vOE4KmpSz1AYwM+G43ZGIztj74B85p0X1BiGsydmaSZqcr+eJv8f/6m7VlSJ4iGEE4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxzZeqmp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4399d14334aso5707135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975097; x=1740579897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OhlGluAjXb17F8YGQfin1m4bYC+4YIL3i7B/no4Yxo=;
        b=gxzZeqmpYgX6f6aIFf2pbDuWbM5zwxs+Lo1LYslU89rkI3nbTup/TpHe8iB/Eib2f6
         GtJiynh0gar4/zcsQXlaOO8i7cDiIZkKLZaj6uZtsfOQd3NgugjgmdKX3NDjwzBECeg/
         W+JTZSBrWezCKsXZyPhbCy2qC4XSFiQdhozYdg2th9SgIBZyLI0fmo29T9bg2sP3nuDH
         xCkbmVmJX94vLwdcY2WqxVlasOXCE8wkvfXI8y+9PMIquS6dtAaQg1RrpZdvSSZ/8Mqq
         PRO6DDlLc1p1B3P20A5ImQZ6Qwe8Bxa6gF6fejF5b3nUgh2ZWIqinA+7YLd6YFDG5Ysl
         JwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975097; x=1740579897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OhlGluAjXb17F8YGQfin1m4bYC+4YIL3i7B/no4Yxo=;
        b=QmS1InXmzsBrZRr6q1pN8FWORR9XMAGAgL8bpVCB9MsEk5M4H3qnpjjZH4JODGi0qW
         0x8mTye8bQLbxNrbmkmboFgwnrMZsuksjnN8uVXN5kcoS4SfPWIOzA6wXPKvkX8I8WDA
         zv1wd0LoZwo/bLuN0EGHhh5crqte+XkFJkCHM7PQsobm0jRuyCaWgxdiNqsP1xQvUBm9
         9eOHl8noVR1av8SGyE2mfQBWvaPbnTXjTtU/REwLEUQg02LwixTvMv9SSbwcy4VQudy1
         MebhpPhp+Sd1bbUfk7ZMYo/J1TlmKaB0gnYLKK35u5mlhPuqHpA/UmDzXQdpi9vM6uaq
         pTPQ==
X-Gm-Message-State: AOJu0Yy/ZoWLnBCfwHLOLYFfElwxGKYycmJ/M2Cz+gUy8krpfYRSl7gx
	Y3SoRFpe76lU5IKh2uGp68aQHq9xO2jI30zNIM5nXWk4JZtEyqWc
X-Gm-Gg: ASbGncvIPyYwsJzCA0fFQ4a4sy12SmHKrh3n65PevQrClspf0FuoT340D0fV+SJQ33j
	Kx9cx8A/h67GYXlPzhcJ/BOsvXjUNWxl7HmS4Oo04bkgvFCu1RbkIZDS3UtKEtl4ZtBMejviF2y
	hnNhVsXNGX2v8XBR/AqJmpluJGmzex5iG8Gi8O5OA2RQDPyrj4xqIlGMyNkx3VuR5Nc5APgihjz
	itF1gfmcU0Z7wNgxvYI17FtnP1n1Vo6vxCRdjOBuKSYV13No8Bl4FEKjxUlfsErKrg0jkYvDhkG
	TDlnD/Ko3OBgwQgI
X-Google-Smtp-Source: AGHT+IFRVNEisW/f14MpMOb3gWBHyE2+Pgpe6vOLOm5HWgt/KqZ5Xa02RMEhjsGEzDID9RoC34JmwQ==
X-Received: by 2002:a05:600c:4f48:b0:439:8bb1:14b1 with SMTP id 5b1f17b1804b1-43999d91255mr46587815e9.11.1739975096579;
        Wed, 19 Feb 2025 06:24:56 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258b410dsm17968582f8f.5.2025.02.19.06.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 06:24:56 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched: add unlikey branch hints to several system calls
Date: Wed, 19 Feb 2025 14:24:23 +0000
Message-ID: <20250219142423.45516-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Adding an unlikely() hint on early error return paths improves the
run-time performance of several sched related system calls.

Benchmarking on an i9-12900 shows the following per system call
performance improvements:

		       before     after     improvement
sched_getattr          182.4ns    170.6ns      ~6.5%
sched_setattr          284.3ns    267.6ns      ~5.9%
sched_getparam         161.6ns    148.1ns      ~8.4%
sched_setparam        1265.4ns   1227.6ns      ~3.0%
sched_getscheduler     129.4ns    118.2ns      ~8.7%
sched_setscheduler    1237.3ns   1216.7ns      ~1.7%

Results are based on running 20 tests with turbo disabled (to reduce
clock freq turbo changes), with 10 second run per test based on the
number of system calls per second. The % standard deviation of the
measurements for the 20 tests was 0.05% to 0.40%, so the results are
reliable.

Tested on kernel build with gcc 14.2.1

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/sched/syscalls.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 456d339be98f..9f40348f1dc7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -875,7 +875,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
 	struct sched_param lparam;
 
-	if (!param || pid < 0)
+	if (unlikely(!param || pid < 0))
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
@@ -984,7 +984,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	struct sched_attr attr;
 	int retval;
 
-	if (!uattr || pid < 0 || flags)
+	if (unlikely(!uattr || pid < 0 || flags))
 		return -EINVAL;
 
 	retval = sched_copy_attr(uattr, &attr);
@@ -1049,7 +1049,7 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 	struct task_struct *p;
 	int retval;
 
-	if (!param || pid < 0)
+	if (unlikely(!param || pid < 0))
 		return -EINVAL;
 
 	scoped_guard (rcu) {
@@ -1085,8 +1085,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	struct task_struct *p;
 	int retval;
 
-	if (!uattr || pid < 0 || usize > PAGE_SIZE ||
-	    usize < SCHED_ATTR_SIZE_VER0 || flags)
+	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
+		      usize < SCHED_ATTR_SIZE_VER0 || flags))
 		return -EINVAL;
 
 	scoped_guard (rcu) {
-- 
2.47.2


