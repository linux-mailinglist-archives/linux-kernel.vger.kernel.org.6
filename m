Return-Path: <linux-kernel+bounces-185429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDB8CB4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535331F21F32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F0B149C6D;
	Tue, 21 May 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElXeTZh+"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90353816
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324218; cv=none; b=RV5BZVuCHBK3NeGIby0NAfEDE5bKh3rZXogNWPTf657To6H37UPn1LZuS2/73Q5TerxaMeq4PfB2GqhzyiR226BWFLm+OtmoU0fdhNzFZdDmHcYGZb2ikrSz2Ter9b5LnL055/WowigRPUfDBMUyCHOYH/HXKMo4/EtTMsvn65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324218; c=relaxed/simple;
	bh=TzQgSTHgyU3RFoY2gln3DsZdwLETCJum6BNwDOVNJoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iH9/R05O5RJss9CrQ4+6oZk0iHfkIFbMsF6EkCV9/aULkHHKTJt3fRTg7B6Yn+Vt7cGbexkmSN8aeCxaANbet9HkGxm/L/UFdGTQJpnHPIeBb2wSeEK1ZXMxAEcgqj9jWTBsFf1j5RfS3NHiHt09LU+TxTPKyAALr4VcXMtcENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElXeTZh+; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stern@rowland.harvard.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716324213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bef2r7PmAPGGh3unVAHDRXktGwmTTWv6IxMkhLqqDqQ=;
	b=ElXeTZh+E3DhYrztaPCNXbyulyJAnRLZI3D5L4hTmCT2yONO9HkfS5P7cAoAPxZhxxGxJV
	Mw7eReiwVSbBXJqU7HaukGpck4HYFNe9Z8td+7LwebFNn3b+sIRHWwqqJcDIKWQ2QGzIgW
	JfcxbZ2oZr7Y5n6Dd2I8hELpKYS4tG0=
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
Subject: [PATCH v2] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
Date: Tue, 21 May 2024 22:43:24 +0200
Message-Id: <20240521204324.479972-1-andrey.konovalov@linux.dev>
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

Changes v1->v2:

- Fix compiler error when CONFIG_KCOV=n.
---
 drivers/usb/core/hcd.c | 12 ++++++-----
 include/linux/kcov.h   | 47 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 14 deletions(-)

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
index b851ba415e03..1068a7318d89 100644
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
@@ -103,8 +129,11 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline void kcov_remote_start_usb_softirq(u64 id) {}
-static inline void kcov_remote_stop_softirq(void) {}
+static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+{
+	return 0;
+}
+static inline void kcov_remote_stop_softirq(unsigned long flags) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
-- 
2.25.1


