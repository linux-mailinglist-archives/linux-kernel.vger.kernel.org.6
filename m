Return-Path: <linux-kernel+bounces-376191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED39AA156
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB341C2185A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95819CCEC;
	Tue, 22 Oct 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYvXo9ZT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50345026
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597694; cv=none; b=FLMbTe0HI8h1/9Yc9Up4y/E3rtl9HIugyDboRg3/QamPxKotkPtD2ZunlFqxc9ZAj62kVT4WQIGgvc1wdZjWwzAIB92xXB74vr2Va3rrCpaU+y9h8jvIFEdE7qni7jkg//vDMcmjI125H2zDBcYt6hrbuFLWLselY5GXeeDXXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597694; c=relaxed/simple;
	bh=Bqeo9yMnwygaahE35FD8nIgjrAjptFnrJVmtoyrIb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa+7Q2qH5R5GoVZAlISCD6hrBuwYj+9h0oA6SjeIyYnpZJoook327oFgUZ0m6tvnQ0zlzG+GjzgrvPSCkMMpqyBBSGWT/D33PUP2HNk/0BfikIjP2ESo5J3K9Kt4l3978wtm7ue81De5kDk0YO0LS4XB66knJ+t8ijFqlubDQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYvXo9ZT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20caccadbeeso60121905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597692; x=1730202492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKl6U/5kYqIul35IkUGRHOkC+Sxs+wAsHazeOfjnayo=;
        b=aYvXo9ZT6rX5sSNKgHW2RQUalCZYiz/YmBoHYTQUX+dVsCTmTlnPkVhRL2DW7HOL7J
         knJRBdLjyTztjkRuWy8zEOFeoMT3sUsg56XWqirzqB2X5VS9chtrCbW0Cu9cjVjCknCW
         fUKZs8bJGIkuiu4+5j7TamgvEDFgi5kcj4jv9Q3Ldyv1oq2jRiCUNCQ29jZnHcZ6cLcB
         sNCGANwn90NuF8amMt4PG8vOG5QnstSO75eBO9Kb6CyfRk5cY8QAK/Bd2VI3/kLPgPiX
         q3flEcAUVDMDRdWroNx7hBRpBZMwKzEPKdO/Rhbv2063HesFzKasLe3Lb/j31IYdhwzv
         dY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597692; x=1730202492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKl6U/5kYqIul35IkUGRHOkC+Sxs+wAsHazeOfjnayo=;
        b=p6g/4rJCYKSbC84SQnTtFMVXv0JBglG/Q/n1yl0+OixgeIE0vpFx4wPcA5mNzZ3POq
         BSm6VgJ8piDSDHFxBl7DwfzyBHKWmXIqILFvQeNHE1TCzY8kxPVmYy9AYjk2YiPAXhgD
         JDXHBjN4ISAumYbFhuqo+cvo9WKGJSy509MVII011Y0rU+aUS4W31R7YVY4+4voHPl9r
         SNYdsw5MJhZqx+iUAlTnhYmpeTY7XO6egYEzzOrdaoSkfqFc+/WyTX5afaZcGmb9/MFs
         hyRPlfEbsrGPzf6QRJCN0ihAF9gtZ6olGWcdVokQFehm7wl1W0Qn0uQLqcT/ynYMbGSV
         ky+g==
X-Forwarded-Encrypted: i=1; AJvYcCUiGdE1R/QQOYiBu1qOTtyGvY8kJ+PEW6fC3NJrO5fqmB1bDwBoH50+Z9gnIAcIMEdpJdTjSYygj1148dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5u0PgXqnHGYew3xjWFNSS7LSGBcWizyKYW7a/A7s2nCSx4lD
	FlXHaDrAagWncEqR3n/bDFbs3O+RRtmBrNBMf155qbrHO5SF3XhC
X-Google-Smtp-Source: AGHT+IHiGn0rGlYqLqA+F/OWg8LpaBp6Ymm27XpKX4Az/xFYXPaV3FzGzu4YKfbwVcSJ4WTJHHB2HQ==
X-Received: by 2002:a17:902:ea0a:b0:20b:70b4:69d8 with SMTP id d9443c01a7336-20e984a5a57mr20839455ad.37.1729597692576;
        Tue, 22 Oct 2024 04:48:12 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0e13bsm41147145ad.65.2024.10.22.04.48.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Oct 2024 04:48:12 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: cunhuang@tencent.com,
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
	Lance Yang <ioworker0@gmail.com>,
	Mingzhe Yang <mingzhe.yang@ly.com>
Subject: [PATCH 1/2] hung_task: add detect count for hung tasks
Date: Tue, 22 Oct 2024 19:47:35 +0800
Message-ID: <20241022114736.83285-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022114736.83285-1-ioworker0@gmail.com>
References: <20241022114736.83285-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a counter, hung_task_detect_count, to track the number of
times hung tasks are detected. This counter provides a straightforward way
to monitor hung task events without manually checking dmesg logs.

With this counter in place, system issues can be spotted quickly, allowing
admins to step in promptly before system load spikes occur, even if the
hung_task_warnings value has been decreased to 0 well before.

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


