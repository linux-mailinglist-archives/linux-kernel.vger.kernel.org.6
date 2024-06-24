Return-Path: <linux-kernel+bounces-226583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35CC91409D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0A9281250
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA29DDBC;
	Mon, 24 Jun 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGBu0zOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE8D517
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197149; cv=none; b=XjI4sje88bKLf3yeS2Vnvio+lzEbSRZHUd7AHokeQ4y5kCiqWpcnOE4MngR/IEW7qaVf2Mx/fbmxJOHQrY1reBML+fBwZYsSUDbadj2Cf97LWZphKud5+VnQzNgADra887T3mR1XUixzqIUy67Has9/+ci12zGdsDNgnO4yRCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197149; c=relaxed/simple;
	bh=WfeIGdPCABX8Ekz9dFEQWp6GcPg872qaZOhjgmpzO+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNznt8xkg2AndpADjtVu2g33I4K2OMm4K+X0TS5F2Bap3MNihzqP0bheUKHLGM7UqmNU89CU0Iwo0S1SpLHPm7GJKmDz3qMbjinJ+IJD56hO2OyEHlP0RUAK8+ixCW58Bf+lhSNYqtCTIcZwiMdklq/EDgCiZu50dnejKXw0xbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGBu0zOj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDxzijJpYtAgNTVGRnv3Y++7d/17cWXmWRlDF3N15Ms=;
	b=CGBu0zOjk2rrSdI5IE5s2qjfSnZnLq3TxNfNlEclICbAsFNlwWdYrJc8tzAkXg1JmDUCBZ
	WAFwN6mSaOM9H1SX9Hjl10GSriOcZPyxr3ctQTiSDzLwhVLXhIpkLzaVzqklsCDGUa8Top
	66yCDfukXX7/AqmmxUcIF6Qz7eSgMjs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-f4qeZlybPK25jEVqZkh3gw-1; Sun,
 23 Jun 2024 22:45:44 -0400
X-MC-Unique: f4qeZlybPK25jEVqZkh3gw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D479C195608E;
	Mon, 24 Jun 2024 02:45:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A98B3000218;
	Mon, 24 Jun 2024 02:45:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 1/3] virtio: allow nested disabling of the configure interrupt
Date: Mon, 24 Jun 2024 10:45:21 +0800
Message-ID: <20240624024523.34272-2-jasowang@redhat.com>
In-Reply-To: <20240624024523.34272-1-jasowang@redhat.com>
References: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Somtime driver may want to enable or disable the config callback. This
requires a synchronization with the core. So this patch change the
config_enabled to be a integer counter. This allows the toggling of
the config_enable to be synchronized between the virtio core and the
virtio driver.

The counter is not allowed to be increased greater than one, this
simplifies the logic where the interrupt could be disabled immediately
without extra synchronization between driver and core.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 20 +++++++++++++-------
 include/linux/virtio.h  |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..d3aa74b8ae5d 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_enabled)
+	if (dev->config_enabled < 1)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed)
 		drv->config_changed(dev);
@@ -146,17 +146,23 @@ EXPORT_SYMBOL_GPL(virtio_config_changed);
 static void virtio_config_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = false;
+	--dev->config_enabled;
 	spin_unlock_irq(&dev->config_lock);
 }
 
 static void virtio_config_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = true;
-	if (dev->config_change_pending)
-		__virtio_config_changed(dev);
-	dev->config_change_pending = false;
+
+	if (dev->config_enabled < 1) {
+		++dev->config_enabled;
+		if (dev->config_enabled == 1 &&
+		    dev->config_change_pending) {
+			__virtio_config_changed(dev);
+			dev->config_change_pending = false;
+		}
+	}
+
 	spin_unlock_irq(&dev->config_lock);
 }
 
@@ -455,7 +461,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_enabled = 0;
 	dev->config_change_pending = false;
 
 	INIT_LIST_HEAD(&dev->vqs);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96fea920873b..4496f9ba5d82 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -132,7 +132,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_enabled;
+	int config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
-- 
2.31.1


