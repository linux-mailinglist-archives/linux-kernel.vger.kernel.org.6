Return-Path: <linux-kernel+bounces-223212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5F910FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FE71C242DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67961B4C24;
	Thu, 20 Jun 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLQPyUnw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B731B47D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906245; cv=none; b=kRbz9Gq/Qnw2iFsk5hw70KGrRTi1ZvueNez206c1hPrDM9hb0W13TlMF5ZTJTdtG1IdOm0CrOPqfwvXZ8flib/cnsMBFv/BrCdQziMeGzY7XTc4Fo7B/WwdIHBLj6ipPI3XN6dmyyUc/BLwq8t8OQWT13GQ7BipxLKCUmR/xQVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906245; c=relaxed/simple;
	bh=iFxwlIlYJmwx3d0DAafe4DTo8c0DRvIQvWI6JBsAmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC840l10T2TeO3tKrnLRaOSwKeZiCD1TFivT6lLmPQiwlDlNlz93nxg8hbiHhl+LD40CUdHJYUG5LRkJvTJhqcudEq3Wq4+UVI0CZD67TEGlGzFDGZvS6nWRwl6pxlOQMqdl3Y/TH3aMxsjwQSRxiW/Uh6bkikd7IOt4+gaUag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLQPyUnw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9d9b57b90so5177655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906243; x=1719511043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FPc4+rs8YXE06jsQAfHrhhg6ai+ZxxKg14pnSGboBY=;
        b=DLQPyUnwRwTs03/sHtZECv4mGHGQqVVbF+tTWRYfFko/WUqHxtC01TdW+XCaMSnAXN
         f7SWDDFr00C+3P9L3+X7J4caoaNCQtAnjgf7NR/UJdtP44Cq8meNoRr4Cp9trLk/wKsc
         xidStn5/cU5xHCmirhKi+yxi374GL4hjRi0xK3acmX+USDN3RqJE0GEiVM96GwKlVaES
         qr2WUQUC91IC7WjJojX0g0dV0Mvclbgb4cEFqY6oVCKtkc/kJ1YJBnkVBnAl1iu6yO/X
         jsvaJKIn7bMUR8Vo9XwQCuwOIsfP0PypD1ZVvq+ZH9ssu3LkcWrdIm8fRCCAW1FEh9VN
         va2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906243; x=1719511043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FPc4+rs8YXE06jsQAfHrhhg6ai+ZxxKg14pnSGboBY=;
        b=RJWdnFqaVCZcCI3BGkysluooF5ShkZ6w83WZ6iJkXLGhoKZTYneZqj4C96xpM3LTpK
         lhJaQNFSnhLua1lVNN7IFTck1o5ndEuMlC0QvLnv5nf1nhljgDRzkM8BezEC9M/byBkj
         c+xUEYeVVs35RsEOgvu5E6TMpIQm4KxDXfKvMJnXIYVQIoS0jlVBOZnBB9Taaui5rTuq
         l/sxCNchvmZo2WCazStwx17myHqooVLjTKxzvMmyiyjHG4IS3hrNP+ztN4vHTyekFwJt
         Zq89dBdk/bY/5AyHhiXcI3Y1sUyQchViYfvmNzqTd2ztKeG7fMeXV0XC1YB9oVDa5vwp
         2Kfw==
X-Gm-Message-State: AOJu0Yzeu0Rw8AN+MrYa2uBmY9nxYtkmzV77v0fOOdo6h22vnXd/f4Fb
	kcIiqWJgrqel/71YvceUBvxm/Y2Cm+tF4n5wVwCeWjCstViaoVBNBKfPmGjBBGI=
X-Google-Smtp-Source: AGHT+IEb+NM6rxCaMHA96INVWGzEGUheh9Av2Sh9BOmyvfITs/fmbdQOFOrzoApocqlSRwsejpxs/A==
X-Received: by 2002:a17:903:32c8:b0:1f9:9768:ea61 with SMTP id d9443c01a7336-1f9aa3b0a03mr79468045ad.2.1718906242783;
        Thu, 20 Jun 2024 10:57:22 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855eeaaddsm140325445ad.122.2024.06.20.10.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:22 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v4 05/40] sched: add cpumask_find_and_set() and use it in __mm_cid_get()
Date: Thu, 20 Jun 2024 10:56:28 -0700
Message-ID: <20240620175703.605111-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__mm_cid_get() uses __mm_cid_try_get() helper to atomically acquire a
bit in mm cid mask. Now that we have atomic find_and_set_bit(), we can
easily extend it to cpumasks and use in the scheduler code.

cpumask_find_and_set() considers cid mask as a volatile region of memory,
as it actually is in this case. So, if it's changed while search is in
progress, KCSAN wouldn't fire warning on it.

CC: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 MAINTAINERS                    |  1 +
 include/linux/cpumask_atomic.h | 20 ++++++++++++++++++++
 kernel/sched/sched.h           | 15 ++++++---------
 3 files changed, 27 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/cpumask_atomic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 54f37d4f33dd..7173c74896d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3730,6 +3730,7 @@ F:	include/linux/bitmap-str.h
 F:	include/linux/bitmap.h
 F:	include/linux/bits.h
 F:	include/linux/cpumask.h
+F:	include/linux/cpumask_atomic.h
 F:	include/linux/find_atomic.h
 F:	include/linux/find.h
 F:	include/linux/nodemask.h
diff --git a/include/linux/cpumask_atomic.h b/include/linux/cpumask_atomic.h
new file mode 100644
index 000000000000..1aaf9a63cbe6
--- /dev/null
+++ b/include/linux/cpumask_atomic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_CPUMASK_ATOMIC_H_
+#define __LINUX_CPUMASK_ATOMIC_H_
+
+#include <linux/cpumask.h>
+#include <linux/find_atomic.h>
+
+/*
+ * cpumask_find_and_set - find the first unset cpu in a cpumask and
+ *			  set it atomically
+ * @srcp: the cpumask pointer
+ *
+ * Return: >= nr_cpu_ids if nothing is found.
+ */
+static inline unsigned int cpumask_find_and_set(volatile struct cpumask *srcp)
+{
+	return find_and_set_bit(cpumask_bits(srcp), small_cpumask_bits);
+}
+
+#endif /* __LINUX_CPUMASK_ATOMIC_H_ */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..557896f8ccd7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -30,6 +30,7 @@
 #include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
+#include <linux/cpumask_atomic.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/fs_api.h>
@@ -3312,23 +3313,19 @@ static inline void mm_cid_put(struct mm_struct *mm)
 
 static inline int __mm_cid_try_get(struct mm_struct *mm)
 {
-	struct cpumask *cpumask;
-	int cid;
+	struct cpumask *cpumask = mm_cidmask(mm);
+	int cid = nr_cpu_ids;
 
-	cpumask = mm_cidmask(mm);
 	/*
 	 * Retry finding first zero bit if the mask is temporarily
 	 * filled. This only happens during concurrent remote-clear
 	 * which owns a cid without holding a rq lock.
 	 */
-	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
-			break;
+	while (cid >= nr_cpu_ids) {
+		cid = cpumask_find_and_set(cpumask);
 		cpu_relax();
 	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
-		return -1;
+
 	return cid;
 }
 
-- 
2.43.0


