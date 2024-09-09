Return-Path: <linux-kernel+bounces-320532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12E1970BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A2FB20C19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586C18633;
	Mon,  9 Sep 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNEfMboT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F51CD16
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847334; cv=none; b=f5+on1OSbMy+Qtu1yQeYnSL6qr7Yf+rXFrvnRVcG3+/N0h3OS05BFBjO5s9ZnKjTZX2mRdJh8S7qhuQH5puVMrWauCRwlnupEU471/fYEy8ntnPHQ2zo8J/Qtd7qCbDy7YdB3uTIfrJ0b+dP/rwfGJT8YguyfuU2yee0Thiih5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847334; c=relaxed/simple;
	bh=EkRHJb5RZNeNBEkKpyo5YbQvL6WrbchVnkZM21iwMJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWGumCHCUJAZCsRTQJjgv4ehWgv2b8IjwzrIRFjhu4Fam8zlZhdA+2f7oqeLlpS5a5WklQNorE7vVdea9mkoH1S0X0TJA2PBCGfXT6iZj4GCiVnxvLLWW+mR5EQyCPIJGGZ50KLf4IRjQe7RqRoV7zZYO1ZBRrbUG6jfSp0rQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNEfMboT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdl4Ti7H8Zn8CJdFokcfn4yA/bPmnyZMHZeexqaTaMc=;
	b=XNEfMboTAryhTfLsMp27iTrZ0I+sOXzFL/9Surn9R4QTthtbi4iTosCzojEzK9oWK+aToo
	PQt+sdIaoHnU7uFas9x+JtnxeOJtu2ZU8CovmrRoi3dg8wCYWtV6EhIst1hulIxK7iEXk2
	JNYEVwLyKbv/wWm2qAH1LFPcZmgFrXo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-8vsL1yYvNqGWjVgFrfAi-g-1; Sun,
 08 Sep 2024 22:02:08 -0400
X-MC-Unique: 8vsL1yYvNqGWjVgFrfAi-g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82CB719560AD;
	Mon,  9 Sep 2024 02:02:07 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B8601956086;
	Mon,  9 Sep 2024 02:02:03 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 3/7] vhost: Add kthread support in function vhost_workers_free()
Date: Mon,  9 Sep 2024 10:00:41 +0800
Message-ID: <20240909020138.1245873-4-lulu@redhat.com>
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
References: <20240909020138.1245873-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Added back the previously removed function vhost_workers_free() and
renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
will select the different mode based on the value of the parameter.

The old function vhost_workers_free was change to support task in
commit 6e890c5d5021 ('vhost: use vhost_tasks for worker threads')
also changed in
commit a284f09effe ('vhost: Fix crash during early vhost_transport_send_pkt calls')
change to xarray in
commit 1cdaafa1b8b ('vhost: replace single worker pointer with xarray')

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ab4608fcf86b..da4482efd2cb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -647,8 +647,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
-static void vhost_worker_destroy(struct vhost_dev *dev,
-				 struct vhost_worker *worker)
+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
+					 struct vhost_worker *worker)
+{
+	if (!worker)
+		return;
+
+	WARN_ON(!llist_empty(&worker->work_list));
+
+	xa_erase(&dev->worker_xa, worker->id);
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static void vhost_worker_destroy_task(struct vhost_dev *dev,
+				      struct vhost_worker *worker)
 {
 	if (!worker)
 		return;
@@ -659,7 +672,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 	kfree(worker);
 }
 
-static void vhost_workers_free(struct vhost_dev *dev)
+static void vhost_workers_free_task(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	unsigned long i;
@@ -674,10 +687,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
 	 * created but couldn't clean up (it forgot or crashed).
 	 */
 	xa_for_each(&dev->worker_xa, i, worker)
-		vhost_worker_destroy(dev, worker);
+		vhost_worker_destroy_task(dev, worker);
 	xa_destroy(&dev->worker_xa);
 }
 
+static void vhost_workers_free_kthread(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	unsigned long i;
+
+	if (!dev->use_worker)
+		return;
+
+	for (i = 0; i < dev->nvqs; i++)
+		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
+	/*
+	 * Free the default worker we created and cleanup workers userspace
+	 * created but couldn't clean up (it forgot or crashed).
+	 */
+	xa_for_each(&dev->worker_xa, i, worker)
+		vhost_worker_destroy_kthread(dev, worker);
+	xa_destroy(&dev->worker_xa);
+}
+
+static void vhost_workers_free(struct vhost_dev *dev)
+{
+	if (enforce_kthread)
+		vhost_workers_free_kthread(dev);
+	else
+		vhost_workers_free_task(dev);
+}
 static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
@@ -845,7 +884,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
 	__vhost_worker_flush(worker);
 	mutex_unlock(&worker->mutex);
 
-	vhost_worker_destroy(dev, worker);
+	if (enforce_kthread)
+		vhost_worker_destroy_kthread(dev, worker);
+	else
+		vhost_worker_destroy_task(dev, worker);
 	return 0;
 }
 
-- 
2.45.0


