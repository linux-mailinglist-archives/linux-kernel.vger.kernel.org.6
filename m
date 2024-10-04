Return-Path: <linux-kernel+bounces-349844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29898FC1D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5D6284A77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5D3C099;
	Fri,  4 Oct 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DseNto1G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82282AE8A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007234; cv=none; b=hPDL95Kb0Lh1PrS6//QtXmRNJoxgNy2QBQHfK+dTj4I96gc+LH93ahlJ2IzjF3NZI+QaKkCA+jVPKLFJHmLjomv4K/Yv1Z7nvpNmvPZK5xofVleSlEUKcz1EQpDuM89OU18gwXvUoUWvh4pGq/ewHBEFzN5ZmEHV6OCIj+N4in8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007234; c=relaxed/simple;
	bh=zjxmZ7yCPNr5FzfI9m9RlLaaV2g+LOs0OuJz7URLIhk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAEZYyJ0BiWKA35LN03CR4qObx0w20PhSL3pqzNOZkYISp3DotX8dq3+S8kjcuUzOUqj/8EfrVMcUfRMrGFJQNayG6DUS3T1Z6AcDRNcK4uLbAIhigpSU9qfY8vfmG/vsXhTnwXYD2+89qjcTeTUlzgsiIrfy10pE9vJoKjdNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DseNto1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfPS8HLRSnQ9qcVq5kX+4iK0JJXiQpbCvSzpkaatVBQ=;
	b=DseNto1G/0+t7C5yJMrX359iqPYd2Gdl2rBhfUBR2OtjsEPygPAOE4Tlnu/yZ7ofbbIYbo
	4/egrmrErILYLt94NEEAc0tP/oNWSpmzXJGdKW+45DlJvL+sBERRmrb7CcehWL14EwyDOd
	NbED4R/U1WoZYCqPfGZNJOGA6wOLi0A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-nOzjp9psOfOSnJS2uSGBNg-1; Thu,
 03 Oct 2024 22:00:30 -0400
X-MC-Unique: nOzjp9psOfOSnJS2uSGBNg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 778CB1955F65;
	Fri,  4 Oct 2024 02:00:29 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D63D519560A2;
	Fri,  4 Oct 2024 02:00:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 5/7] vhost: Add the cgroup related function
Date: Fri,  4 Oct 2024 09:58:19 +0800
Message-ID: <20241004015937.2286459-6-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add back the previously removed cgroup function to support the kthread
The biggest change for this part is in vhost_attach_cgroups() and
vhost_worker_cgroups_kthread(). This is because of the change in
struct dev->worker_xa.

The old function was remove in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 349499139f4f..eb30da658bfe 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
+#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -649,6 +650,57 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
+struct vhost_attach_cgroups_struct {
+	struct vhost_work work;
+	struct task_struct *owner;
+	int ret;
+};
+
+static void vhost_attach_cgroups_work(struct vhost_work *work)
+{
+	struct vhost_attach_cgroups_struct *s;
+
+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
+	s->ret = cgroup_attach_task_all(s->owner, current);
+}
+
+static int vhost_worker_cgroups_kthread(struct vhost_worker *worker)
+{
+	struct vhost_flush_struct flush;
+	struct vhost_attach_cgroups_struct attach;
+
+	attach.owner = current;
+
+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
+	vhost_worker_queue(worker, &attach.work);
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+	vhost_worker_queue(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
+
+	return attach.ret;
+}
+
+static int vhost_attach_cgroups(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+	int ret;
+
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+
+	xa_for_each(&dev->worker_xa, i, worker) {
+		ret = vhost_worker_cgroups_kthread(worker);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
-- 
2.45.0


