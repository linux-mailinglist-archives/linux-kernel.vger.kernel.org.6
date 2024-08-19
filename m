Return-Path: <linux-kernel+bounces-291794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6089566FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAAC1C21B64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9DA15EFA4;
	Mon, 19 Aug 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHEJ4Yow"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E015CD6A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059794; cv=none; b=DpJQOcwYlFrnX+jLGFLRryu9Ebi0aqLae8yctl/iWWtsGe84LO9rscXOR4fmJETV9PoM1KGj5r0vWBadESR673hE599R0TMePGyOdm8R2FsBuHWsjNRLn6NpMa7uE2SAJUt725WDyuYzaTGOrKCTDcBW4/4k4lYk9gG2Sys/cbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059794; c=relaxed/simple;
	bh=efxH1sSMf2klEJ3PKsOaBGUtqvILrO2zUnw6BNzKIls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szf8uAxmTahcRiinvCz9Md56jbaBuGtDMCdpOECK8pL9jY11f+QD5aOq9VhFpupHcmO3WOFX8sIm87uOIm9ly3hjyNHfXnxq9jJIin71tu6em4jEkwJcNOMFDnpUaedSuJs75Ri1mc2xLZRcxsMrpSa0t9tRsqzaci9BHNo7umQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHEJ4Yow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oI5nhMa1kRbv7aaOFKvTmUft8jmCwPzAMkkkRLDVCLg=;
	b=LHEJ4YowWiKqe0CF2eH4gmIO58r2mYYBViU7ymCbt21HjSTY8eWXZ+KG2so6k6Eo7kbd4G
	ZUraakRW+Ss4tkWG2pwjos7lMVe8r4LXbrTvT1nwPvAYIz4Uird8qFuFt8yoYTlfOo23pE
	UvdhoXYKf3m3GlhlfHgokVG3aA+XH6w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-GmO9l7eEPwuZiOAHHJ1JPQ-1; Mon,
 19 Aug 2024 05:29:48 -0400
X-MC-Unique: GmO9l7eEPwuZiOAHHJ1JPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91BD21954B1A;
	Mon, 19 Aug 2024 09:29:47 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F2191956054;
	Mon, 19 Aug 2024 09:29:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 6/7] vhost: Add kthread support in function vhost_worker_create
Date: Mon, 19 Aug 2024 17:27:32 +0800
Message-ID: <20240819092851.441670-7-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Split the function vhost_worker_create to support both task and kthread
       
Added back the previous old function vhost_worker_create and rename it to
vhost_worker_create_khtread to support the khtread.

The new vhost_worker_queue will be selected which to use based on the
value of the parameter.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 66ccda81f073..0a7b2999100f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -807,7 +807,8 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	else
 		vhost_workers_free_task(dev);
 }
-static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
+
+static struct vhost_worker *vhost_worker_create_task(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
@@ -848,6 +849,50 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 	return NULL;
 }
 
+static struct vhost_worker *vhost_worker_create_kthread(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+	u32 id;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return NULL;
+
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+
+	mutex_init(&worker->mutex);
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_run_work_kthread_list, worker, "vhost-%d",
+			      current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0)
+		goto stop_worker;
+	worker->id = id;
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return worker;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	return NULL;
+}
+
 /* Caller must have device mutex */
 static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 				     struct vhost_worker *worker)
@@ -936,6 +981,14 @@ static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
 	return 0;
 }
 
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
+{
+	if (use_kthread)
+		return vhost_worker_create_kthread(dev);
+	else
+		return vhost_worker_create_task(dev);
+}
+
 /* Caller must have device mutex */
 static int vhost_new_worker(struct vhost_dev *dev,
 			    struct vhost_worker_state *info)
-- 
2.45.0


