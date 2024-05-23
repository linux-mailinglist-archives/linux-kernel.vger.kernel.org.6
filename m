Return-Path: <linux-kernel+bounces-187031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6A8CCC15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF265B212BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4F13B586;
	Thu, 23 May 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JCMPdrMH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF81BDD0
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716444582; cv=none; b=jf17/NB8BNn+ibr4M+fl1ZNIanrrPyIx6Jk12cjlSQiSijUFHvb+3U8mHnR52NA40R4CER7EdlTLZU3dEKh0/+NYRvAxZNs2ecAXR1SnZUU6lnI29xjBs98pChSOJRO9yDFv0kA0IoE6XVY5eZpblxxy1uOOObOWoX950dpYcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716444582; c=relaxed/simple;
	bh=ClT9vX/HM+flAX4WR6xtfhx/WHDU8FGjIiz340H6hw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9Lf5kKTm5MQhcJ1q/jU5HT6EaYcdbAdpRCcSzGB1/egR9VjtQZnyJ4J/S3qD/8RmUvZsfJ3kBBfvjFpQSpyU2S45YYa0MFmztNVEgyXvg5xFG8sj4+z4pFtGROdqh2PO8bTQfTh3q9JqTJLDp2dQ//ZeNchsdzE4Xw4m7NBRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JCMPdrMH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ee5235f5c9so117304145ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716444580; x=1717049380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+LuT33Y3K3mqEN1LulXHyyOGhBSjgsuD2IY0DLKvAdM=;
        b=JCMPdrMHS15qLu5W5Mlfh/P637EJkIJWJCTAMK+4uDObym/ZzdLwP418tK4lFj05bZ
         rq4I/vV3X+ShPix4UqcMRBUGkswGlIk5OidWDdW2NTBJncoZp62qAOr9Y26hSvcc7x6C
         2C9b8icOXo9xXIue6PFZfMn3jgSYSkuN4GCD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716444580; x=1717049380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LuT33Y3K3mqEN1LulXHyyOGhBSjgsuD2IY0DLKvAdM=;
        b=vEeVNqFHN/njFDXdwKWOuir9lczAjR+jV2VsA814brfR+rW3qh8SbqP8xSXFJ3+d7d
         U833BbQAZnVm8MtWvYJqOL9TmumVuIAsrcvd4XK9tUb6cKK28xlomS4OsB2+v2j29TY4
         szfz62IJW/VNqM28dLQgirStj6LmvGsl8JztBloX6809rxLOuYaJJSuB6yRNyurmkVGT
         fv+5uynx32ngEogmQ3N35+2mNz1zVWp+odRSCIudcGKir5JPNd9zm53976EDkl6T7awe
         BanEWc1qY9/UlSmWAhiKngrYisV5w8S3gCw8MjSvyJt/nTZlrVC/5wOEsYsFP0cWjFo3
         mi1w==
X-Forwarded-Encrypted: i=1; AJvYcCUnit0p2I5gQeKdAz1dnjnuXtBNS1Gf6yHgX/xUuAdu5ibcPR4Vf+MQZ3yi40N3C+GsGaemXoykQWMH9KACJ9Ez6gf+MoQiFfWyrlbG
X-Gm-Message-State: AOJu0Yyg1Hatx5Qi++NniSxAcYHml2yVJ5ddfpX+PgFgb2IKhWHUS3QX
	TWvhGkUukAyFBszUj50lg8QZnA6ShdI0p7Qhq1w51ugnft3GJwHBIl9oW1uV6/bMGQWdlXAhWFg
	=
X-Google-Smtp-Source: AGHT+IFzqjFDtCbz7oQ/B9H7RRX0BLXKo/ipyGeyF4VKxCBCN922m2tCj4WCeBeJkUAgYz5GU89FoA==
X-Received: by 2002:a17:903:40d2:b0:1f3:a5b:9705 with SMTP id d9443c01a7336-1f31c9ed4cbmr52027645ad.48.1716444579913;
        Wed, 22 May 2024 23:09:39 -0700 (PDT)
Received: from localhost (60.252.199.104.bc.googleusercontent.com. [104.199.252.60])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ef0badcbacsm250027495ad.97.2024.05.22.23.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 23:09:39 -0700 (PDT)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add vendor-specific packet classification for ISO data
Date: Thu, 23 May 2024 06:09:31 +0000
Message-ID: <20240523060934.2883716-1-yinghsu@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HCI raw sockets are opened, the Bluetooth kernel module doesn't
track CIS/BIS connections. User-space applications have to identify
ISO data by maintaining connection information and look up the mapping
for each ACL data packet received. Besides, btsnoop log captured in
kernel couldn't tell ISO data from ACL data in this case.

To avoid additional lookups, this patch introduces vendor-specific
packet classification for Intel BT controllers to distinguish
ISO data packets from ACL data packets.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
Tested LE audio unicast recording on a ChromeOS device with Intel AX211

Changes in v2:
- Adds vendor-specific packet classificaton in hci_dev.
- Keeps reclassification in hci_recv_frame.

 drivers/bluetooth/btusb.c        | 19 +++++++++++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 16 ++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79aefdb3324d..75561e749c50 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -966,6 +966,24 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
+#define BT_USB_INTEL_ISODATA_HANDLE_BASE 0x900
+
+static u8 btusb_intel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/*
+	 * Distinguish ISO data packets form ACL data packets
+	 * based on their conneciton handle value range.
+	 */
+	if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+		__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+		if (hci_handle(handle) >= BT_USB_INTEL_ISODATA_HANDLE_BASE)
+			return HCI_ISODATA_PKT;
+	}
+
+	return hci_skb_pkt_type(skb);
+}
+
 #define RTK_DEVCOREDUMP_CODE_MEMDUMP		0x01
 #define RTK_DEVCOREDUMP_CODE_HW_ERR		0x02
 #define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT	0x03
@@ -4451,6 +4469,7 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->classify_pkt_type = btusb_intel_classify_pkt_type;
 
 		if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
 			btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_SUPPORT);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9231396fe96f..7b7068a84ff7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -649,6 +649,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b3ee9ff17624..8b817a99cefd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_reset_dev);
 
+static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (hdev->classify_pkt_type)
+		return hdev->classify_pkt_type(hdev, skb);
+
+	return hci_skb_pkt_type(skb);
+}
+
 /* Receive frame from HCI drivers */
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	u8 dev_pkt_type;
+
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
 		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
 
+	/* Check if the driver agree with packet type classification */
+	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
+	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
+		hci_skb_pkt_type(skb) = dev_pkt_type;
+	}
+
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_EVENT_PKT:
 		break;
-- 
2.45.1.288.g0e0cd299f1-goog


