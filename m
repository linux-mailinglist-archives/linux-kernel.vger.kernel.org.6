Return-Path: <linux-kernel+bounces-268455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747519424D8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC1285EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DAB182B3;
	Wed, 31 Jul 2024 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqjPo8k8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475C18E25
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395844; cv=none; b=MCLFISD+TdrgQlwwDITNqz3L88WI7KeDJcEVXXSe0vGFad13M5TAmdkHQIO3EvT2esPENnQlHcpoNzj4HsVCedblquDnZ0iVGrUBziyxVnqbJGt02WAxytfpQcD+RYpcTmRpNqpts9DzNVxh6FOFzo+wrEOb4ntWN/6JwHKMiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395844; c=relaxed/simple;
	bh=OmaLShaDtZGPGB2XTdgq6lxTdyoWtWoJaAEU+gVqnZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIiBfyxn7NshURLaFx6Af2uYguk0ZiaY5CTSSuOQy8zGES51NMhCHlVfae39BWnbhoGTcxwa6XvqhSse6l0LWz93Sgho5wNZmz7yRdJkxNBxCm/wSeXYHjRjdK/7GffgjyRxu9ZWpYkiKWORH4hlMGHmhulocXDl+Sb9EBLnvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqjPo8k8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SzdyF62rVlEqda1lu661LgYoUfSa5OYqKk2xzeaqfvk=;
	b=IqjPo8k87dacOhWdpKP0dS6aVbBIeAX8TCfgwA+dDKxc/rd2LFvIaSRQTFlCK/iyTXljI7
	b7X/FyQ1raq+H2/hJIJVYxYKkW0LzIWjTPkF2C4M63fN5B8FgXGd6moJmprslY3kr0JbWG
	xLEq7AHwykuTwpEEd/fp5fan0T5Zzyc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-wLl7DIrDNCmGo_aMi6ZE6Q-1; Tue,
 30 Jul 2024 23:17:18 -0400
X-MC-Unique: wLl7DIrDNCmGo_aMi6ZE6Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18FDD1955D4C;
	Wed, 31 Jul 2024 03:17:17 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DDA31955F3B;
	Wed, 31 Jul 2024 03:17:11 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] vdpa_sim_net: Add the support of set mac address
Date: Wed, 31 Jul 2024 11:16:02 +0800
Message-ID: <20240731031653.1047692-3-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-1-lulu@redhat.com>
References: <20240731031653.1047692-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add the function to support setting the MAC address.
For vdpa_sim_net, the driver will write the MAC address
to the config space, and other devices can implement
their own functions to support this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index cfe962911804..6caf09a1907b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -414,6 +414,24 @@ static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
 }
 
+static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+				const struct vdpa_dev_set_config *config)
+{
+	struct vdpasim *vdpasim = container_of(dev, struct vdpasim, vdpa);
+	struct virtio_net_config *vio_config = vdpasim->config;
+
+	mutex_lock(&vdpasim->mutex);
+
+	if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
+		ether_addr_copy(vio_config->mac, config->net.mac);
+		mutex_unlock(&vdpasim->mutex);
+		return 0;
+	}
+
+	mutex_unlock(&vdpasim->mutex);
+	return -EOPNOTSUPP;
+}
+
 static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
 				     const struct vdpa_dev_set_config *config)
 {
@@ -510,7 +528,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
 
 static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
 	.dev_add = vdpasim_net_dev_add,
-	.dev_del = vdpasim_net_dev_del
+	.dev_del = vdpasim_net_dev_del,
+	.dev_set_attr = vdpasim_net_set_attr
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.45.0


