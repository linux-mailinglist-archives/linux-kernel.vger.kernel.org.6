Return-Path: <linux-kernel+bounces-320504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10258970B53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB071F21C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6665410A19;
	Mon,  9 Sep 2024 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3dVkDVZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982A168BD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845798; cv=none; b=qjV4Rhw4+BOwO+u/aNOoC12hv0eeWQIDn6Ets+O/oOEAeZYT18aY7l/SgOdzAiZajRNnp6ZF27ME01aSQA7e82jRz8HSEZQ3GOF9wqAGO3X1ScygUZ0mdgUHRtG/4Yd/p5qOSC8aw4HWMI6JReqqO8dPeS/2niDllNwpngtiSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845798; c=relaxed/simple;
	bh=Zj52ujkm+R0tviSIHLkmWRXg5f1ITFTOrXGxPxViqoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9fq8EJaG62OgahM7JMUynHDgkVdoOY+FcNqpXUXzyPQ4Mcgeg6M2DqbdRt/QpIXo5lqkAGsp3P9ukSuxRErUcUTQCQQvfChIdzsHUZENQKdoBDg5IIz4NdHQltXtlhFj7hKtmN3p/GQtekXw6fG8CzQBvZqqxACWwaqthOt5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3dVkDVZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUK21wL5JOX0cOtdsK1MpB8tVQltsuArPMxS2cXskDc=;
	b=J3dVkDVZJC+QdQf7t9oJybu6DN5kE437qvetPkEjniJA7fdzzizxiQjbqx+Dsk5XJcd3Sa
	/TXzGe673nJa73lDlenTY80A5NpynyrmiCYHBY9S24aiIsj8hZRXcx67pVJEAZoqdl/fUv
	stnav5ofMbZaruwn8zxq1XazjaqfAXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-JKqYP9TlNfipfu_MaouYig-1; Sun,
 08 Sep 2024 21:36:35 -0400
X-MC-Unique: JKqYP9TlNfipfu_MaouYig-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 275F31977027;
	Mon,  9 Sep 2024 01:36:34 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1776A19560AA;
	Mon,  9 Sep 2024 01:36:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 5/7] vhost: Add the cgroup related function
Date: Mon,  9 Sep 2024 09:33:44 +0800
Message-ID: <20240909013531.1243525-6-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
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
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fd54ee323fb1..f05545b125f0 100644
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
@@ -648,6 +649,57 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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


