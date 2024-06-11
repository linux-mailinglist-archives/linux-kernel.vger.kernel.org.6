Return-Path: <linux-kernel+bounces-209285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1048903141
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FC028B36B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EF17332A;
	Tue, 11 Jun 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3NbzL7z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FB433C4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083978; cv=none; b=qI6y5nSiYmZkT7+yL9xqzNrGgIJtkizg8bEzrWgKAte1Z6iT5sr3PwyMcnEs++GXnI6yHFvye2ncykeoEaKCryovH2DUUWXsNiTtIOsGT5NEZUcprH1F4SzeHTf3UN+2iagYSn7dPIOMBBxIA4avtTtT0BUlQBGLMPhOyK+bweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083978; c=relaxed/simple;
	bh=RxfXH2ZFb7Id4zlG5fVIVyfD9EzHBt+idquBieWGYcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=spi6FFusU9h4a/KS2TDL75rvbU6HXmShPaTWyXJINYj+rGZfvHGaL57qCWc2cUxWhz2UJkxRmQ94AxQqSOPjcGi1fXt7unIVMioNjWg3E9Aww+0FXAF7HacoRXa8uhMGbgdQ5pYWqvt3ROBvKNp1mRVOfaNaS0OxnLdJ1amUW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3NbzL7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718083973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rjMLPcN4lf4hILs75qKFb2X8tj4fMICRG7d9Mi8k40Q=;
	b=b3NbzL7zyEWC28fAQjEA1wnAZKX+AwcCcWSaBOrpUrTXOU+NQcJ9gpYLHqLvVQcgWGy4kC
	OqK6y44uZh/h7PzmRiX8wAaCrbcwVqhs4hbd4bkQHWFoXIFrAzfuwn+8yjkBFuiH5Ck3MS
	UFVml2I059cfcibEoT9JodiQr6p91vA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-_V8BYhHVPAey9ah6ri3acA-1; Tue,
 11 Jun 2024 01:32:50 -0400
X-MC-Unique: _V8BYhHVPAey9ah6ri3acA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 199A719560BD;
	Tue, 11 Jun 2024 05:32:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CAC11956048;
	Tue, 11 Jun 2024 05:32:42 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Date: Tue, 11 Jun 2024 13:32:32 +0800
Message-ID: <20240611053239.516996-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add new UAPI to support the mac address from vdpa tool
Function vdpa_nl_cmd_dev_config_set_doit() will get the
MAC address from the vdpa tool and then set it to the device.

The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**

Here is sample:
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
 drivers/vdpa/vdpa.c       | 71 +++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  2 ++
 include/uapi/linux/vdpa.h |  1 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a7612e0783b3..347ae6e7749d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1149,6 +1149,72 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	return err;
 }
 
+static int vdpa_nl_cmd_dev_config_set_doit(struct sk_buff *skb,
+					   struct genl_info *info)
+{
+	struct vdpa_dev_set_config set_config = {};
+	struct nlattr **nl_attrs = info->attrs;
+	struct vdpa_mgmt_dev *mdev;
+	const u8 *macaddr;
+	const char *name;
+	int err = 0;
+	struct device *dev;
+	struct vdpa_device *vdev;
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
+		NL_SET_ERR_MSG_MOD(
+			info->extack,
+			"Fail to find the specified management device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	mdev = vdev->mdev;
+	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
+		if (!(mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
+			NL_SET_ERR_MSG_FMT_MOD(
+				info->extack,
+				"Missing features 0x%llx for provided attributes",
+				BIT_ULL(VIRTIO_NET_F_MAC));
+			err = -EINVAL;
+			goto mdev_err;
+		}
+		macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
+		memcpy(set_config.net.mac, macaddr, ETH_ALEN);
+		set_config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
+		if (mdev->ops->set_mac) {
+			err = mdev->ops->set_mac(mdev, vdev, &set_config);
+		} else {
+			NL_SET_ERR_MSG_FMT_MOD(
+				info->extack,
+				"%s device not support set mac address ", name);
+		}
+
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "%s device not support this config ",
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
@@ -1285,6 +1351,11 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_CONFIG_SET,
+		.doit = vdpa_nl_cmd_dev_config_set_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db15ac07f8a6..c97f4f1da753 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -581,6 +581,8 @@ struct vdpa_mgmtdev_ops {
 	int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
 		       const struct vdpa_dev_set_config *config);
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
+	int (*set_mac)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev,
+		       const struct vdpa_dev_set_config *config);
 };
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 54b649ab0f22..53f249fb26bc 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -19,6 +19,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
 	VDPA_CMD_DEV_VSTATS_GET,
+	VDPA_CMD_DEV_CONFIG_SET,
 };
 
 enum vdpa_attr {
-- 
2.45.0


