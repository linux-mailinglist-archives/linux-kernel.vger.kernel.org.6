Return-Path: <linux-kernel+bounces-447276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF49F2FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE47B1887E94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6C20626E;
	Mon, 16 Dec 2024 11:50:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91063205E3E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349834; cv=none; b=oS66yT2mvfwdewqw2i/tkcVf2thjyERm5Je5t0hmKrDg2a5CMGRD4Ho6cfEqGubT8f+bjqKvrv+XkZcf5J4Sbxg7FaI5R9bNWVRGuI1s6jSBmffozLyodsD6Gnen2Nr4atBUAOOz8JdY/rmtQ/m8cI4yfmVo/VBuvyW3/ENsk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349834; c=relaxed/simple;
	bh=gFaoFu9KKvHqNDT9slT8K/JDLRz71AvbwCXWYMx9Kng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NW4BoyZWTLT5juKgc/mwBSj70GDHgNrz1H24rbDnI6kYUGNjSyM5eNLwXHsoIu2yrOkPZoX6V3yvFTAOxFzeoZdg0U0iUNh+rTfOv8ZpRo5ueQ1mRk/bDikGYuWBpZjN6wcQvSbtT3Jp+hV0xSnGunV85sdBLw2diEkoykWI54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2030C113E;
	Mon, 16 Dec 2024 03:51:00 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0660E3F58B;
	Mon, 16 Dec 2024 03:50:29 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 9/9] coresight/ultrasoc: change cti_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 16 Dec 2024 11:50:06 +0000
Message-Id: <20241216115006.415861-10-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216115006.415861-1-yeoreum.yun@arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ultrasoc-smb drivers, smb_drv_data->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since smb__drv_data->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type smb_drv_data->spinlock in ultrasoc-smb drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 12 ++++++------
 drivers/hwtracing/coresight/ultrasoc-smb.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index dc3c9504dd7c..26cfc939e5bd 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -98,7 +98,7 @@ static int smb_open(struct inode *inode, struct file *file)
 	struct smb_drv_data *drvdata = container_of(file->private_data,
 					struct smb_drv_data, miscdev);
 
-	guard(spinlock)(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	if (drvdata->reading)
 		return -EBUSY;
@@ -152,7 +152,7 @@ static int smb_release(struct inode *inode, struct file *file)
 	struct smb_drv_data *drvdata = container_of(file->private_data,
 					struct smb_drv_data, miscdev);
 
-	guard(spinlock)(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 	drvdata->reading = false;
 
 	return 0;
@@ -245,7 +245,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 	int ret = 0;
 
-	guard(spinlock)(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* Do nothing, the trace data is reading by other interface now */
 	if (drvdata->reading)
@@ -280,7 +280,7 @@ static int smb_disable(struct coresight_device *csdev)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	guard(spinlock)(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	if (drvdata->reading)
 		return -EBUSY;
@@ -378,7 +378,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	if (!buf)
 		return 0;
 
-	guard(spinlock)(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* Don't do anything if another tracer is using this sink. */
 	if (csdev->refcnt != 1)
@@ -563,7 +563,7 @@ static int smb_probe(struct platform_device *pdev)
 
 	smb_reset_buffer(drvdata);
 	platform_set_drvdata(pdev, drvdata);
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 	drvdata->pid = -1;
 
 	ret = smb_register_sink(pdev, drvdata);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
index a91d39cfccb8..c4c111275627 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.h
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -115,7 +115,7 @@ struct smb_drv_data {
 	struct coresight_device	*csdev;
 	struct smb_data_buffer sdb;
 	struct miscdevice miscdev;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 	bool reading;
 	pid_t pid;
 };
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


