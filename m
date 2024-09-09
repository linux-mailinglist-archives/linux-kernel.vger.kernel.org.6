Return-Path: <linux-kernel+bounces-320535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E484970BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6851F21D59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A9111A8;
	Mon,  9 Sep 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpdmUaNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC318C3B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847376; cv=none; b=c79IuIk3YSmx8Tuh12UtArNOtsj+UfBYr3SfEQ56cJbVqGXiXdKp5o4t8ER61EObUPNMoe20ARhGnDV53pjedF0hOpene3sfb/JCfnNUDNMoEqjJomrmBtt+6UTih+tTWaAqwk82+h9ltGCfqDSXI6vzmHXQ/H6lEHnprrTgphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847376; c=relaxed/simple;
	bh=QQqC0BM8LdyqKa0sPlX1xLwT8vY7erzuIjQMScwcQNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZtzn4w+W1ypB76K1jTrbqIIeWdhXOvmPe/fpz68UVruTMZYl7s+Fk5xPQ2BG8d19em7iQpG1d/NmzEgMk+5qPhpJUyT101ujyvchuvAnx0ta8wWDubm1g5Akx42mTXSuCeqXbA3pfSY6rbDHzyVGsogRrXtzopmHiscXvMBs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpdmUaNL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhyb1S7F4CzbTneG1JPeiJSHHBElEO8SQAMRCi7GVgg=;
	b=VpdmUaNLO1dHBVzsn2AbcAtgDLHW+wa73f82VQ+jT4xArGBcFHCCdUEVYRnIFJcUUl7Dix
	eqy6/CdzdmyEpToxNwokyrZBRCtZcQGAM+zi8xp8vcvO0wD87be3O81/nKed3UmKhMipI+
	Vy6tzpK+zF82RhT0wv6wu6F76+Uqop8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-oStbUJyrPlmf1wn8XgX1bA-1; Sun,
 08 Sep 2024 22:02:46 -0400
X-MC-Unique: oStbUJyrPlmf1wn8XgX1bA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C9EC1955F41;
	Mon,  9 Sep 2024 02:02:45 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DE981956086;
	Mon,  9 Sep 2024 02:02:40 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 6/7] vhost: Add kthread support in function vhost_worker_create
Date: Mon,  9 Sep 2024 10:00:44 +0800
Message-ID: <20240909020138.1245873-7-lulu@redhat.com>
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Split the function vhost_worker_create to support both task and kthread
       
Added back the previous old function vhost_worker_create and rename it to
vhost_worker_create_khtread to support the khtread.

The new vhost_worker_create will be selected which to use based on the
value of the parameter.

the old function vhost_worker_create was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
also changed in
commit 1cdaafa1b8b ('vhost: replace single worker pointer with xarray')
commit c011bb669dd ('vhost: dynamically allocate vhost_worker')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 46b15e9c0693..838bce29a98b 100644
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
+	if (enforce_kthread)
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


