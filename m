Return-Path: <linux-kernel+bounces-223999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C769911BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA141C23B51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E883C167DA4;
	Fri, 21 Jun 2024 06:27:00 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC814A615
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951220; cv=none; b=pOC4/BR18QOJ0RWFOj8AnpMTNlFDq58M3nYfPaS+qHLc914UzTJ85QyERCiE9SDKX0K/Ct+0Sm7QYwZ56I/rwdxGRo1rbGk18yvjc73jPJs19iknI/u4ITH/rsH2Nbs5/DbIKbFEq7vPyiOttRKtzPsVWwwvINpvi8tVB4p5CK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951220; c=relaxed/simple;
	bh=KudXxBQ7PeZZyc7Axfzl8L2a5hEN3vRw59lt4oasRUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fV1IAm2PK424QLnDUuJTXDB/ggIfBsMz8j+MHeoqxertF0hJU+PnthkQtZwXjNhL/WRdXXvRaHZnnenPp4dtbSMBHSGocH1+Cjzcp/ngwgQg6s7/Xs12c6mMaV0F0VbhiDURYBDKeDw2ErtZOyKk0YIcnLgSKffIQy/rzzX5R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45L6QVZj041339;
	Fri, 21 Jun 2024 14:26:31 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W56hR1r47z2SFWL2;
	Fri, 21 Jun 2024 14:21:59 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 21 Jun 2024 14:26:28 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <sunyibuaa@gmail.com>, <tj@kernel.org>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC: <ebiggers@google.com>, <jiangshanlai@gmail.com>,
        <kent.overstreet@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <niuzhiguo84@gmail.com>,
        <Hao_hao.Wang@unisoc.com>, <yunlongxing23@gmail.com>
Subject: [PATCH 1/2] workqueue: add io priority to work_struct
Date: Fri, 21 Jun 2024 14:26:16 +0800
Message-ID: <20240621062617.595007-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240621062617.595007-1-yi.sun@unisoc.com>
References: <20240621062617.595007-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 45L6QVZj041339

Many works will go to submit_bio(), and in many cases the io priority of
kworker cannot meet the real-time requirements of this work.

So add the basic attribute ioprio to work_struct, and kworker can adjust
its io priority according to this attribute.

Add function set_work_ioprio() to set the io priority of this work.
Add function may_adjust_work_task_ioprio() to adjust kworker's io priority.
Add function restore_work_task_ioprio() to restore kworker's io priority.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 include/linux/workqueue.h       |  9 ++++++
 include/linux/workqueue_types.h |  6 ++++
 kernel/workqueue.c              | 51 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index fb3993894536..f6191774b730 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -286,6 +286,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 		lockdep_init_map(&(_work)->lockdep_map, "(work_completion)"#_work, (_key), 0); \
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		(_work)->func = (_func);				\
+		(_work)->ioprio = 0;					\
+		(_work)->ori_ioprio = 0;				\
+		(_work)->ioprio_flag = 0;				\
 	} while (0)
 #else
 #define __INIT_WORK_KEY(_work, _func, _onstack, _key)			\
@@ -294,6 +297,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 		(_work)->data = (atomic_long_t) WORK_DATA_INIT();	\
 		INIT_LIST_HEAD(&(_work)->entry);			\
 		(_work)->func = (_func);				\
+		(_work)->ioprio = 0;					\
+		(_work)->ori_ioprio = 0;				\
+		(_work)->ioprio_flag = 0;				\
 	} while (0)
 #endif
 
@@ -585,6 +591,9 @@ extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
+extern void set_work_ioprio(struct work_struct *work, unsigned short ioprio);
+extern void may_adjust_work_task_ioprio(struct work_struct *work);
+extern void restore_work_task_ioprio(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
 extern void show_all_workqueues(void);
diff --git a/include/linux/workqueue_types.h b/include/linux/workqueue_types.h
index 4c38824f3ab4..d9969596bbc3 100644
--- a/include/linux/workqueue_types.h
+++ b/include/linux/workqueue_types.h
@@ -17,6 +17,12 @@ struct work_struct {
 	atomic_long_t data;
 	struct list_head entry;
 	work_func_t func;
+	/* If the work does submit_bio, io priority may be needed. */
+	unsigned short ioprio;
+	/* Record kworker's original io priority. */
+	unsigned short ori_ioprio;
+	/* Whether the work has set io priority? */
+	long ioprio_flag;
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map lockdep_map;
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 003474c9a77d..a44a8f92eec2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -55,6 +55,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/ioprio.h>
 
 #include "workqueue_internal.h"
 
@@ -6025,6 +6026,56 @@ unsigned int work_busy(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(work_busy);
 
+/**
+ * set_work_ioprio - set io priority for the current work
+ * @work: the work to be set
+ * @ioprio: desired io priority
+ *
+ * This function can be called after INIT_WORK if the io priority
+ * of the work needs to adjust. And it is recommended to use this
+ * function together with may_adjust_work_task_ioprio() and
+ * restore_work_task_ioprio().
+ */
+void set_work_ioprio(struct work_struct *work, unsigned short ioprio)
+{
+	work->ioprio = ioprio;
+	work->ioprio_flag = 1;
+}
+EXPORT_SYMBOL_GPL(set_work_ioprio);
+
+/**
+ * may_adjust_work_task_ioprio - adjust the io priority of kworker
+ * @work: the work that kworker will do
+ *
+ * It is recommended to use this function together with set_work_ioprio()
+ * and restore_work_task_ioprio().
+ */
+void may_adjust_work_task_ioprio(struct work_struct *work)
+{
+	if (work->ioprio_flag) {
+		work->ori_ioprio = get_current_ioprio();
+		set_task_ioprio(current, work->ioprio);
+	}
+}
+EXPORT_SYMBOL_GPL(may_adjust_work_task_ioprio);
+
+/**
+ * restore_work_task_ioprio - restore the io priority of kworker
+ * @work: the work that kworker just did
+ *
+ * When kworker finishes the work, the original io priority of
+ * kworker should be restored. It is recommended to use this function
+ * together with set_work_ioprio() and may_adjust_work_task_ioprio().
+ */
+void restore_work_task_ioprio(struct work_struct *work)
+{
+	if (work->ioprio_flag) {
+		set_task_ioprio(current, work->ori_ioprio);
+		work->ioprio_flag = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(restore_work_task_ioprio);
+
 /**
  * set_worker_desc - set description for the current work item
  * @fmt: printf-style format string
-- 
2.25.1


