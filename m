Return-Path: <linux-kernel+bounces-265116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5993ECF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A21BB20D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52833824A1;
	Mon, 29 Jul 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1tUmCuk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70798002A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722230532; cv=none; b=uHCBdgrAXuMFnhp1cHm4lzhBS3eYbJe38ghzis5GvT2aO44wOC0dRl93c0LkaG/RgWzU2vA2PekBmPSsX6vYzg/N8aWsawrU0u/yDGGky4aio2eIkLIeROix40sMtb74ycloarGgIhG8wZDnDjd0GB3J8gR1szj/c6WXoIW7co0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722230532; c=relaxed/simple;
	bh=FqGoL1gIrG+6pQBWKG7TqPWVrmXfXg8wT0MmB/exNU0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRJBco46gwutDqgh8Hw0Gcz7bgSiw7gohNZVTk3HWy+PYrCtdd9eflM4J/rYon4LK/Mb7t3oSJZT8afF7rblXgjIamdYmjfxLTYHo+axP9qkYS0DRmMg/ZFvleMUhaWR01Y+8CQsJMIO0X7YMVELjV/bSKbtadjJtjZFE3ooQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1tUmCuk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722230529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaDV7paMve8+TDjLvnzLCW3finEF8AmwpTegyY1jZGA=;
	b=A1tUmCuk8jpGDOKluxWd/CZm/8TSuVvfPujj62BL6/Lp1xTRHRyrF7BOZAZzG9ui7OEBpZ
	p8I7BJ4RRibovhDjEZPoDJZpVAocfpPuYCxAkjlrhRpB10MWDB20b8/v9XFHPfpHw7JLKC
	Hh+S/U7c3i7/Lf0heHaKoDp84C0slj4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-4q3-DfTlNDiLk3Kg7TdA7g-1; Mon,
 29 Jul 2024 01:22:04 -0400
X-MC-Unique: 4q3-DfTlNDiLk3Kg7TdA7g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DA2E1944B32;
	Mon, 29 Jul 2024 05:22:03 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9231A195605F;
	Mon, 29 Jul 2024 05:21:58 +0000 (UTC)
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
Subject: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
Date: Mon, 29 Jul 2024 13:20:45 +0800
Message-ID: <20240729052146.621924-2-lulu@redhat.com>
In-Reply-To: <20240729052146.621924-1-lulu@redhat.com>
References: <20240729052146.621924-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add new UAPI to support the mac address from vdpa tool
Function vdpa_nl_cmd_dev_attr_set_doit() will get the
new MAC address from the vdpa tool and then set it to the device.

The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**

Here is example:
root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "82:4d:e9:5d:d7:e6",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55

root@L1# vdpa -jp dev config show vdpa0
{
    "config": {
        "vdpa0": {
            "mac": "00:11:22:33:44:55",
            "link ": "up",
            "link_announce ": false,
            "mtu": 1500
        }
    }
}

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa.c       | 80 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  9 +++++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 90 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8d391947eb8d..7d16f62540ed 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1361,6 +1361,81 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	return err;
 }
 
+static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
+					struct genl_info *info)
+{
+	struct vdpa_dev_set_config set_config = {};
+	struct vdpa_mgmt_dev *mdev = vdev->mdev;
+	struct nlattr **nl_attrs = info->attrs;
+	const u8 *macaddr;
+	int err = -EINVAL;
+
+	down_write(&vdev->cf_lock);
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+
+		if (is_valid_ether_addr(macaddr)) {
+			ether_addr_copy(set_config.net.mac, macaddr);
+			memcpy(set_config.net.mac, macaddr, ETH_ALEN);
+			if (mdev->ops->dev_set_attr) {
+				err = mdev->ops->dev_set_attr(mdev, vdev,
+							      &set_config);
+			} else {
+				NL_SET_ERR_MSG_FMT_MOD(info->extack,
+						       "device does not support changing the MAC address");
+			}
+		} else {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "Invalid MAC address");
+		}
+	}
+	up_write(&vdev->cf_lock);
+	return err;
+}
+
+static int vdpa_nl_cmd_dev_attr_set_doit(struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	struct vdpa_device *vdev;
+	struct device *dev;
+	const char *name;
+	u64 classes;
+	int err = 0;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+
+	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+
+	down_write(&vdpa_dev_lock);
+	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		err = -ENODEV;
+		goto dev_err;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	classes = vdpa_mgmtdev_get_classes(vdev->mdev, NULL);
+	if (classes & BIT_ULL(VIRTIO_ID_NET)) {
+		err = vdpa_dev_net_device_attr_set(vdev, info);
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack, "%s device not supported",
+				       name);
+	}
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	up_write(&vdpa_dev_lock);
+	return err;
+}
+
 static int vdpa_dev_config_dump(struct device *dev, void *data)
 {
 	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
@@ -1497,6 +1572,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_ATTR_SET,
+		.doit = vdpa_nl_cmd_dev_attr_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7977ca03ac7a..2e7a30fe6b92 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -582,11 +582,20 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
  *	     @dev: vdpa device to remove
  *	     Driver need to remove the specified device by calling
  *	     _vdpa_unregister_device().
+ * @dev_set_attr: change a vdpa device's attr after it was create
+ *	     @mdev: parent device to use for device
+ *	     @dev: vdpa device structure
+ *	     @config:Attributes to be set for the device.
+ *	     The driver needs to check the mask of the structure and then set
+ *	     the related information to the vdpa device. The driver must return 0
+ *	     if set successfully.
  */
 struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
 		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*dev_set_attr)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+			    const struct vdpa_dev_set_config *config);
 };
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 842bf1201ac4..71edf2c70cc3 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_ATTR_SET,
 };
 
 enum vdpa_attr {
-- 
2.45.0


