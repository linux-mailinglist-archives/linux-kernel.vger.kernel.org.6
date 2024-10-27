Return-Path: <linux-kernel+bounces-383585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A466A9B1D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80AC1C20B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60439153803;
	Sun, 27 Oct 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXeuQDD4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17A2FE33
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030903; cv=none; b=nRAH72cjdTUkfMLdiz47uvg1ycqfblvq/+Da5Nz14ue6qs1bjtMlobTVKYBzySYH+KlA2jX7CSDyW54tUxCJLpsbdgMe6M2SU6rSOZsyz/v+HKAsy8kX//aMRHpOHR3E9aMaA+xVaWyBVJcW/sgzrtlmTAKJ2SshhkSyBmQdu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030903; c=relaxed/simple;
	bh=52tOPjSDZZ5PaUlFM91mvluoXT+WpaA7tF2vOrmXbuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1Cu9H7/4VQDmrFfHAaGLqpYBoHJNT7hVEKNpWjIekErwfw1qEtAYijIV6+VjJrPWuq+794zH+fNOf3JhjcWer9X+wCvOlGq0TQ41pJaVzfHzL1B/4slOXqauD8Rc6QsIhMpmQ5N4Y+X1wwo94Qo4dSBHzKtOs7WKnYGUc9BRQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXeuQDD4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e576dbc42so34500505ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730030901; x=1730635701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0YBTty29fCDfURPSOlaCYcuKhU2mEB3YdomHT84Hu0=;
        b=HXeuQDD44wjKqAEXqoAiiw+ShqL4G3mpBXsM5VAC2mFq6TXP/XxCYH3AA4PlD1iJHq
         Bz+fPVI0h2IUdFcWW8qaHnvbYRPVmojX9lZlbldQGS1AtKxP8wYtkLv3v78FQsem6Jmf
         5m37jjWZdRGhOUqKShDDflGZNmunio+Jd/HUreFm0EVMh/RCEldSRcJRuCWk7P2xTL7m
         seyUcnRg2fWh67pglaY/hr7DrZpNPK2HFa0k5s1MFZ5+f76zPVAA8HnOcZTgKSkI7Dib
         x2qjFAA1K2zCTEP5wyBVg9+5XvZqAnKOHZvtd8DzCn7+o3AlXQwm8iSOoycWQJh8UgUM
         SxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730030901; x=1730635701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0YBTty29fCDfURPSOlaCYcuKhU2mEB3YdomHT84Hu0=;
        b=JXlFoxj1JN1R/4oMGSJ77xTowbiNZ9ocP5GjOErCEj74/lRkp/68/2RZe0PFlmCfpS
         yC8gkg9a0HHFsEkccahcZ3qK8YYKOlpGZvVnwc7VhqOUdOSZbe8bfXW11i0FGvG/WPXw
         niHcogQtI4wTEwLlmxG1Xvwc55f2vXY/mV/I2TOT7I9mKMypNhgD8Mctdr3IDRIfyP8g
         oBlWBN7S2di7A+UfjHd3BJZ3Yd59GWBu6HIVHB55eGADN9tXntaRtHh3A5ecwpAV2Hyc
         lYfLU2rn9YE8S5577JcB6NU7UuU3u4LyozRSrGvEAF59qAH0qq2e3IlkX7l1zY/C0ZUP
         qgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU9HLbDzS3BGSaAmzYAmI0CXIh3YbYTkLaQP/LhzewiY6sv6B7eFcV2YFo0MX7OJVSa1DrAEeiZXpk6AM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWZHsL8BJljQbaIyYiPLs18KAt1MLoHi7O7EhormRnmSJFwD9
	5VBJXdh57GKbl1H90+x+v2JLkA8eMVFckXjqYEwxU3nwlvjQd1ne
X-Google-Smtp-Source: AGHT+IEC7SL1yaU6CsPvivYj99USvnYvIa+jRLOO6wsH1fIK/VVaqfW9WsUEB/88wKPnAtzTyVWulA==
X-Received: by 2002:a17:903:8ce:b0:20c:c631:d81f with SMTP id d9443c01a7336-210c6c28284mr59132545ad.21.1730030901053;
        Sun, 27 Oct 2024 05:08:21 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf43476sm34897435ad.24.2024.10.27.05.08.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Oct 2024 05:08:20 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	cunhuang@tencent.com,
	leonylgao@tencent.com,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	kent.overstreet@linux.dev,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	joel.granados@kernel.org,
	linux@weissschuh.net,
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH v2 1/2] hung_task: add detect count for hung tasks
Date: Sun, 27 Oct 2024 20:07:46 +0800
Message-ID: <20241027120747.42833-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027120747.42833-1-ioworker0@gmail.com>
References: <20241027120747.42833-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a counter, hung_task_detect_count, to track the number of
times hung tasks are detected.

IHMO, hung tasks are a critical metric. Currently, we detect them by
periodically parsing dmesg. However, this method isn't as user-friendly as
using a counter.

Sometimes, a short-lived issue with NIC or hard drive can quickly decrease
the hung_task_warnings to zero. Without warnings, we must directly access
the node to ensure that there are no more hung tasks and that the system
has recovered. After all, load average alone cannot provide a clear
picture.

Once this counter is in place, in a high-density deployment pattern, we
plan to set hung_task_timeout_secs to a lower number to improve stability,
even though this might result in false positives. And then we can set a
time-based threshold: if hung tasks last beyond this duration, we will
automatically migrate containers to other nodes. Based on past experience,
this approach could help avoid many production disruptions.

Moreover, just like other important events such as OOM that already have
counters, having a dedicated counter for hung tasks makes sense.

Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 kernel/hung_task.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 959d99583d1c..229ff3d4e501 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -30,6 +30,11 @@
  */
 static int __read_mostly sysctl_hung_task_check_count = PID_MAX_LIMIT;
 
+/*
+ * Total number of tasks detected as hung since boot:
+ */
+static unsigned long __read_mostly sysctl_hung_task_detect_count;
+
 /*
  * Limit number of tasks checked in a batch.
  *
@@ -115,6 +120,12 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
 		return;
 
+	/*
+	 * This counter tracks the total number of tasks detected as hung
+	 * since boot.
+	 */
+	sysctl_hung_task_detect_count++;
+
 	trace_sched_process_hang(t);
 
 	if (sysctl_hung_task_panic) {
@@ -314,6 +325,13 @@ static struct ctl_table hung_task_sysctls[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_NEG_ONE,
 	},
+	{
+		.procname	= "hung_task_detect_count",
+		.data		= &sysctl_hung_task_detect_count,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
+	},
 };
 
 static void __init hung_task_sysctl_init(void)
-- 
2.45.2


