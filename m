Return-Path: <linux-kernel+bounces-291791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C756B9566F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E1A1C21A20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40E1607AD;
	Mon, 19 Aug 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNXJovvr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39315DBDD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059760; cv=none; b=NJfkZMHX+pUHU5aeXfaKgEBaCkdcSWxuqhmGDZ0urYEbhPkCZHupZlczCK0edkXlNKNXdF9ibI2M91uknvRTkz5VgMzsoIwqFP9HidAsQFaK5nXHhfSk9Q8SZ6GP9jTnHrmDzvOpnbbzDJVdEH/YshgnKlU95MXdNM/JHFZObws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059760; c=relaxed/simple;
	bh=hQzAsPpdGgSBnrUtnTIjrrebyHFjc0TTk3orQMkFSP0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1TaGhM2TjpFgruQxsXFxsmMz8+cyBhPNJz9rzfmATBtdFrChjOLvla+3pVS+BmYdPnGYc55myQcizYrA0JvzQDVs6D6SXPb4SPYFyOPSCKFIVtSRhcoxUr/A7AK+PholIKzw9adMf+xkWgMfyXpBhm9jerH5hxxDzYdWmbqVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNXJovvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rudOnUhTj1NAei5RMGqP2l3kgXSLV5exml+muK1YojA=;
	b=TNXJovvr2hHgeEXn6P7Xs/4LAFrqXXc41DL8cNQjS/vBgHSASKWUy0n+BgaujEpbdHs4Sd
	bdgiI1B9wNOl9437gddxxVVnoh+yRLcrazFDFkz5tbDl0f/VHvKwkJNaAS+3X6ndR2Ivfy
	JWytfrCiTkImDnxIz0RagzCVd9GqolI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-tQ3K3C9KO76VYQ6srwQBGQ-1; Mon,
 19 Aug 2024 05:29:14 -0400
X-MC-Unique: tQ3K3C9KO76VYQ6srwQBGQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06EAC1955BF7;
	Mon, 19 Aug 2024 09:29:14 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCE6B195605A;
	Mon, 19 Aug 2024 09:29:10 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 3/7] vhost: Add kthread support in function vhost_workers_free()
Date: Mon, 19 Aug 2024 17:27:29 +0800
Message-ID: <20240819092851.441670-4-lulu@redhat.com>
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

Added back the previously removed function vhost_workers_free() and
renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
will select the different mode based on the value of the parameter.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6261c9df468e..77071def355c 100644
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
+	if (use_kthread)
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
+	if (use_kthread)
+		vhost_worker_destroy_kthread(dev, worker);
+	else
+		vhost_worker_destroy_task(dev, worker);
 	return 0;
 }
 
-- 
2.45.0


