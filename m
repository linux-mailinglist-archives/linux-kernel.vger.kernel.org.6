Return-Path: <linux-kernel+bounces-320501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F622970B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DF81C20A21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ECF134AB;
	Mon,  9 Sep 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yvf4b3V2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AD17999
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845767; cv=none; b=muXUhJcL3j5vt3dgauedg+HF6wEjt2M/iK+8lrdCvdM0W0wcrd5iOs0ik6XfoYp2F9nkjTr8aAUCTIBKzJ0Iz/xaG9r6RvemLYiPGoprdTo3Xa94tm/0iwxaFCkKCC51evFLD1UlaAZjXTDu5orQWdO6P80UxOlWGY7jcATz3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845767; c=relaxed/simple;
	bh=XuAV28beZBB9pt7L44fG41MVE4koHWkMzXmu/XBq26g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHYF81AEQnEaNvnyRkvCYOEVzQ+KXjBlB1nF8gYB36ktjOHed9AjK3i+eUVArqX1DOUFXyvxi9TpSF8PPSm6DBe9QMcPFiuR82yVTyCZIYed/Da3f78Nzh1dK5fGPidtP+uX1uI0GeQNjQYrmWA3tLPgrvVQ3AtBDiAqNc9wBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yvf4b3V2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qa3eHGZmJGnjogDLrYYH+LddmdunfgoRAOyAvGD2Vs=;
	b=Yvf4b3V2EeiGaNCH7kNThaqnuAmjHg9FemDqpZt66Hygf2h+n45eqouZzw71361RiqKbRN
	xb0xiWhfZkNa0HBNz0PYq6YEPTZObAu/4MKkVrANexguqTA/muPoK/PulDB16K3d1p2eeG
	jG0WDkDTafUoF11RTmCLwdzxIZ1eNk4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-w4GiHKBHPVC_EVVCAQsBeA-1; Sun,
 08 Sep 2024 21:35:58 -0400
X-MC-Unique: w4GiHKBHPVC_EVVCAQsBeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8EB1196CDF4;
	Mon,  9 Sep 2024 01:35:55 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBB6A195608A;
	Mon,  9 Sep 2024 01:35:51 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 2/7] vhost: Add kthread support in function vhost_worker_queue()
Date: Mon,  9 Sep 2024 09:33:41 +0800
Message-ID: <20240909013531.1243525-3-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Added back the previously removed function vhost_worker_queue() and
renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
will select the different mode based on the value of the parameter.

The old function vhost_work_queue()  was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
changed in
commit f9010dbdc ('fork, vhost: Use CLONE_THREAD to fix freezer/ps regression')
and also was change the name of function to vhost_worker_queue() in
commit 0921dddcb5 (vhost: take worker or vq instead of dev for queueing)

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index be43181af659..6198c165ab15 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-static void vhost_worker_queue(struct vhost_worker *worker,
-			       struct vhost_work *work)
+static void vhost_worker_queue_task(struct vhost_worker *worker,
+				    struct vhost_work *work)
 {
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
@@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker *worker,
 	}
 }
 
+static void vhost_work_queue_kthread(struct vhost_worker *worker,
+				     struct vhost_work *work)
+{
+	if (!worker)
+		return;
+
+	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
+		/* We can only add the work to the list after we're
+		 * sure it was not in the list.
+		 * test_and_set_bit() implies a memory barrier.
+		 */
+		llist_add(&work->node, &worker->work_list);
+
+		wake_up_process(worker->task);
+	}
+}
+
+static void vhost_worker_queue(struct vhost_worker *worker,
+			       struct vhost_work *work)
+{
+	if (use_kthread) {
+		vhost_work_queue_kthread(worker, work);
+	} else {
+		vhost_worker_queue_task(worker, work);
+	}
+}
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 {
 	struct vhost_worker *worker;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb75a292d50c..c7f126fd09e8 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -27,6 +27,7 @@ struct vhost_work {
 };
 
 struct vhost_worker {
+	struct task_struct	*task;
 	struct vhost_task	*vtsk;
 	struct vhost_dev	*dev;
 	/* Used to serialize device wide flushing with worker swapping. */
-- 
2.45.0


