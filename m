Return-Path: <linux-kernel+bounces-291790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F09566F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694CB1F227CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9A15FCEB;
	Mon, 19 Aug 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6wwNSOm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375F15FA6A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059754; cv=none; b=ohmBFEjMyNdzyDyBiBTDqJGko93sP0g2zFrVeuKeL1NFncRixPLOnU7H9SusaxsqxFx6rswmCsg9VU8DL0Wh9p7KDLzYfpU556Zyg0PyCepN7Pd77olhH0IEf+Gvr+nYxPqA3Ss6ewy+NdqdiWvjBbB4zEUpzkKGRkW1B2V1wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059754; c=relaxed/simple;
	bh=bCcqpKiJI8aKiCcDeYVwFAl69XuQNef0FHW+n9EVc78=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icBf+YXvMjeHUZT7u9K993wfBKQcMgI16MpFp9z1X+hQJBmQSoioVPQ7twMrH4ehvTaCidMopUGBXu3PEXT6uJD9o1Gjei0sK+RuFMgXs1bIp6RiDjDmO12VpdUP3cFGzFsl0kdnVm+KCKtKgi2YOh/0ePJes5F8s+uI9e+GiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6wwNSOm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTiAXi97N+gpQpGCrSBfOxeh4bPxPDjSj8mY3XZdH4M=;
	b=I6wwNSOmU+4JYnKU0tSkDE9kVO3n7xLDXmtlJ9IdoquLIltCBRPpUzguOAKxnoxv675lOI
	b3QdXHj0JaSehza35Hz80NUDpq2WTG9NGLDzpIuKFSukL7ah97Msf6fVBX+dM208pwA1G4
	KuesY0o/JGFNrrBjZ8+roRmLyqaDipg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-zo-vL0JBOyy-nQB-HA3CXg-1; Mon,
 19 Aug 2024 05:29:10 -0400
X-MC-Unique: zo-vL0JBOyy-nQB-HA3CXg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBBA51955D56;
	Mon, 19 Aug 2024 09:29:09 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE8611956054;
	Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
Date: Mon, 19 Aug 2024 17:27:28 +0800
Message-ID: <20240819092851.441670-3-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Added back the previously removed function vhost_worker_queue() and
renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
will select the different mode based on the value of the parameter.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index da701f6b3f2c..6261c9df468e 100644
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


