Return-Path: <linux-kernel+bounces-268441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E26F9424AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C751F244AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1541BDCF;
	Wed, 31 Jul 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5Acj3pT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD318044
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394820; cv=none; b=L/dV6NXluSO4OU5tuyqCHCp7wn7gpP4Do09n1rM+fspzJoLtqoR0pPzsR+SVePR1a6xTYDCdWdp4omYov4uYe0Ix7l52aRsmJ9km0iChQQ8wK5izdVB7xPDwyLTIcXtqfUxI+kYLMjWawxKk8Yp9uf2kSVmdhP/VyfgAZBbnSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394820; c=relaxed/simple;
	bh=eYihf3op2OHUAz1BNkShdp05oFbUZonOr+MDyhBI/Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMF8EEX+hW8oybEkBWU8js/cisgFXjMOcOgZt8d3DB4KzySzY4EYPU0Eq8gSNNLfva3dals3ZHIsicur0uzIWLBUXSsmsPj8oKLDvXODzZfINFSP5wwun8F4XPXL7A8aKToGCFTtJaBYUSjGQ9+3pTNhCR93D/pAPw7qHgoWIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5Acj3pT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722394817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWxz1G3y/9OaIyC01/ouvZE4hcE+DwSqP63LEoUSwSA=;
	b=P5Acj3pTCnaozvCFK4A0slHEIjTA+1R7SFRMXpSEvJgJCDmIwd29QxwnRP8f47zR6PQDZ9
	wj7kPFs+UeWtNtEwWl93Q4+6azY8JZoKLPk53vK9LCYFPcSLnyzGTRqzSgi0t7O3KyINpS
	o7rVxdpJtwl9UMGM1LVcrH3/PU8f4E0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-8ZVYjkeQNUq08xi3mT53KQ-1; Tue,
 30 Jul 2024 23:00:10 -0400
X-MC-Unique: 8ZVYjkeQNUq08xi3mT53KQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC41C1955D45;
	Wed, 31 Jul 2024 03:00:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.247])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F46719560AA;
	Wed, 31 Jul 2024 03:00:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH V4 net-next 1/3] virtio: rename virtio_config_enabled to virtio_config_core_enabled
Date: Wed, 31 Jul 2024 10:59:45 +0800
Message-ID: <20240731025947.23157-2-jasowang@redhat.com>
In-Reply-To: <20240731025947.23157-1-jasowang@redhat.com>
References: <20240731025947.23157-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Following patch will allow the config interrupt to be disabled by a
specific driver via another boolean. So this patch renames
virtio_config_enabled and relevant helpers to
virtio_config_core_enabled.

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 22 +++++++++++-----------
 include/linux/virtio.h  |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a9b93e99c23a..b24f08ff2a8c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_enabled)
+	if (!dev->config_core_enabled)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed)
 		drv->config_changed(dev);
@@ -143,17 +143,17 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
-static void virtio_config_disable(struct virtio_device *dev)
+static void virtio_config_core_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_core_enabled = false;
 	spin_unlock_irq(&dev->config_lock);
 }
 
-static void virtio_config_enable(struct virtio_device *dev)
+static void virtio_config_core_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = true;
+	dev->config_core_enabled = true;
 	if (dev->config_change_pending)
 		__virtio_config_changed(dev);
 	dev->config_change_pending = false;
@@ -322,7 +322,7 @@ static int virtio_dev_probe(struct device *_d)
 	if (drv->scan)
 		drv->scan(dev);
 
-	virtio_config_enable(dev);
+	virtio_config_core_enable(dev);
 
 	return 0;
 
@@ -340,7 +340,7 @@ static void virtio_dev_remove(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	virtio_config_disable(dev);
+	virtio_config_core_disable(dev);
 
 	drv->remove(dev);
 
@@ -455,7 +455,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
 
 	INIT_LIST_HEAD(&dev->vqs);
@@ -512,14 +512,14 @@ int virtio_device_freeze(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	virtio_config_disable(dev);
+	virtio_config_core_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
 		if (ret) {
-			virtio_config_enable(dev);
+			virtio_config_core_enable(dev);
 			return ret;
 		}
 	}
@@ -578,7 +578,7 @@ int virtio_device_restore(struct virtio_device *dev)
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
 		virtio_device_ready(dev);
 
-	virtio_config_enable(dev);
+	virtio_config_core_enable(dev);
 
 	return 0;
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ecc5cb7b8c91..98db6390c1be 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,7 +115,7 @@ struct virtio_admin_cmd {
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
- * @config_enabled: configuration change reporting enabled
+ * @config_core_enabled: configuration change reporting enabled by core
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
@@ -132,7 +132,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_enabled;
+	bool config_core_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
-- 
2.31.1


