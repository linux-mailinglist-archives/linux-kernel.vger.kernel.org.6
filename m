Return-Path: <linux-kernel+bounces-184174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15038CA38E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116471C20FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60180139CE8;
	Mon, 20 May 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1JjhjK3"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DF168BD
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238745; cv=none; b=FRXLj6Hg/HKtCLgR9DAUzXZjJ7ecX5mIjKqXD2KikFksJEpGgPSOuKZ3y19460ecD1iNfPf9gmIe3a37X2agvoPXQttGrUrVDY1cW7zfIwxOSLMWRfyzCs59TkIBRkd74ikNfIevQ/7+XO8F+oqAKRGu4ZIqIVASuuITxxf/h6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238745; c=relaxed/simple;
	bh=y7/tHkkU+6LM/sgkkjIZQzGhCN3OQBbKgY5ooxhPzP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kS9FhzI6tb9MxXCOTf5KktOKpO3luECtn6AG9d9NRDGD/rOV82Et5LgxRQZ+IiicjZJ1Y1z23OlKbC6y+FEXvk33XcJil4TqTiZnG0iLoUHfcgkC0YLzO6O1rApkWLX6qH1NaE3Utj/5oVOfnFnpFEP0cN+oTsiPMHjq9FTlyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1JjhjK3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stern@rowland.harvard.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716238740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dVtkm6Cg+QhrfgIVN0pjJZdjkLBJfP8oJdEHuFJPJQU=;
	b=C1JjhjK3Pqg679wyMjVHSms1bdU0ECv8draV03dcUKEV4zOhFgXdAD0U+Rj/yjW6ouYM3Z
	xyqddroJwKLa/md5O2X55MpRyNbuELtln3f2RROOinm9I5bw1Qf1053pDCaLgqL9j4pxZ+
	rC/dX8KF8d81RHiPRxxqSJL4nEKV5dg=
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: dvyukov@google.com
X-Envelope-To: elver@google.com
X-Envelope-To: glider@google.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: penguin-kernel@i-love.sakura.ne.jp
X-Envelope-To: tj@kernel.org
X-Envelope-To: linux-usb@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	kasan-dev@googlegroups.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Tejun Heo <tj@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
Date: Mon, 20 May 2024 22:58:56 +0200
Message-Id: <20240520205856.162910-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

After commit 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH
workqueue"), usb_giveback_urb_bh() runs in the BH workqueue with
interrupts enabled.

Thus, the remote coverage collection section in usb_giveback_urb_bh()->
__usb_hcd_giveback_urb() might be interrupted, and the interrupt handler
might invoke __usb_hcd_giveback_urb() again.

This breaks KCOV, as it does not support nested remote coverage collection
sections within the same context (neither in task nor in softirq).

Update kcov_remote_start/stop_usb_softirq() to disable interrupts for the
duration of the coverage collection section to avoid nested sections in
the softirq context (in addition to such in the task context, which are
already handled).

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Closes: https://lore.kernel.org/linux-usb/0f4d1964-7397-485b-bc48-11c01e2fcbca@I-love.SAKURA.ne.jp/
Closes: https://syzkaller.appspot.com/bug?extid=0438378d6f157baae1a2
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 8fea0c8fda30 ("usb: core: hcd: Convert from tasklet to BH workqueue")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 drivers/usb/core/hcd.c | 12 +++++++-----
 include/linux/kcov.h   | 44 +++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index c0e005670d67..fb1aa0d4fc28 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1623,6 +1623,7 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
 	struct usb_anchor *anchor = urb->anchor;
 	int status = urb->unlinked;
+	unsigned long flags;
 
 	urb->hcpriv = NULL;
 	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
@@ -1640,13 +1641,14 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	/* pass ownership to the completion handler */
 	urb->status = status;
 	/*
-	 * This function can be called in task context inside another remote
-	 * coverage collection section, but kcov doesn't support that kind of
-	 * recursion yet. Only collect coverage in softirq context for now.
+	 * Only collect coverage in the softirq context and disable interrupts
+	 * to avoid scenarios with nested remote coverage collection sections
+	 * that KCOV does not support.
+	 * See the comment next to kcov_remote_start_usb_softirq() for details.
 	 */
-	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
+	flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop_softirq();
+	kcov_remote_stop_softirq(flags);
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index b851ba415e03..ebcfc271aee3 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -55,21 +55,47 @@ static inline void kcov_remote_start_usb(u64 id)
 
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
- * work around for kcov's lack of nested remote coverage sections support in
- * task context. Adding support for nested sections is tracked in:
- * https://bugzilla.kernel.org/show_bug.cgi?id=210337
+ * workaround for KCOV's lack of nested remote coverage sections support.
+ *
+ * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
+ *
+ * kcov_remote_start_usb_softirq():
+ *
+ * 1. Only collects coverage when called in the softirq context. This allows
+ *    avoiding nested remote coverage collection sections in the task context.
+ *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
+ *    within an existing remote coverage collection section. Thus, KCOV should
+ *    not attempt to start collecting coverage within the coverage collection
+ *    section in __usb_hcd_giveback_urb() in this case.
+ *
+ * 2. Disables interrupts for the duration of the coverage collection section.
+ *    This allows avoiding nested remote coverage collection sections in the
+ *    softirq context (a softirq might occur during the execution of a work in
+ *    the BH workqueue, which runs with in_serving_softirq() > 0).
+ *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
+ *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
+ *    the middle of its remote coverage collection section, and the interrupt
+ *    handler might invoke __usb_hcd_giveback_urb() again.
  */
 
-static inline void kcov_remote_start_usb_softirq(u64 id)
+static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
 {
-	if (in_serving_softirq())
+	unsigned long flags = 0;
+
+	if (in_serving_softirq()) {
+		local_irq_save(flags);
 		kcov_remote_start_usb(id);
+	}
+
+	return flags;
 }
 
-static inline void kcov_remote_stop_softirq(void)
+static inline void kcov_remote_stop_softirq(unsigned long flags)
 {
-	if (in_serving_softirq())
+	if (in_serving_softirq()) {
 		kcov_remote_stop();
+		local_irq_restore(flags);
+	}
 }
 
 #ifdef CONFIG_64BIT
@@ -103,8 +129,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline void kcov_remote_start_usb_softirq(u64 id) {}
-static inline void kcov_remote_stop_softirq(void) {}
+static inline unsigned long kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(unsigned long flags) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
-- 
2.25.1


