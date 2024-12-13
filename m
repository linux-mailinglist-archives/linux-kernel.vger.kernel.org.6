Return-Path: <linux-kernel+bounces-444252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD69F035C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72996169F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824D17A597;
	Fri, 13 Dec 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cWANRpDu"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAD8F5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062682; cv=none; b=Jcu7pWRitXmPWUo5IOdCojN3c4py6WyfK/LObOu5gBOl0Kc0J++ULEQGw7B+IM7X8W9Uc0ggR/ce4GP2wPgHIVmxTWbpesx5TPNhl9TkP1xEfkDv1SjeNDo3ocDQd4e6seMYDgMRpdTbnNaN76SD7pTDosBRu5vZQLwQpS35MXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062682; c=relaxed/simple;
	bh=9uKPv+nA0DYYhWDNhWFHUgyJuC9n4Q/+gOe7CZ3OOzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dk+ZHRIXFK8UFmrUMXmFegySN7XG4rGuK4OfXe3x07ZJhDb47LYEqvMePYaRZHKbeRkSAgUuCFca7IhM0oaSDY8v9h2FR27TgXS+T9jEppldDb33McXqrSwo48YL7lTzXQeD/E1kXjwsVqOXeukquYYUZPZi1+YK4zdqFVYomq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cWANRpDu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso874593a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734062680; x=1734667480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xC1PWxsz+fLoRoV12VLNzfDC1+hiBiUnmX6sO7UCuXk=;
        b=cWANRpDuL+TBDcqE0Cv4f1lqUAnP91E17DsQAiGDS4Gq2xzf8GJQ8gMie1misMhYGR
         D3bl1pV7eqGbH2Fj18iUk8WSsKqjTYCDXxh5Wb7JOIlFQHm1XoC2KVPEnyvpKPiM5yCR
         0Lzy37K5WwRPEvPn6PJR4libntD7BowBX2sXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062680; x=1734667480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xC1PWxsz+fLoRoV12VLNzfDC1+hiBiUnmX6sO7UCuXk=;
        b=huzN7ivCwYMiiB7VYE/Py+ls/E0W1DjVbAlsm4UQZTXZ6bbwA0nJwFsBzA7gTU0VBw
         ArqWY0UraIizx3+Utzz4Hdu3YUQHy5PgCdkGhB+57vA+DbzCY3j8pFcxlWRiQAdMIhAZ
         oJ/E/rPvsY3/ziRMtUMAKupHACI39A26cpGLvJYSG97964xEuiAHG26KDg7B97vxRh0x
         8E7ClmdBM/jpmfiDKVRjzRiQxLB7ix10/9qI0/CvkhupL5mlnEnBtLmJ5qR5RntGcX3I
         +fTcwbHpKtNW7+Y6sRLAvFtSW0YcAIbwiph2y44WmXg03Rv3XBSjzQVE3kiGC5goCRz4
         nSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGILOUOtptO0Ks+nol55hycG2BBoarB4DLG0Nun1ZLLbTVz67bDWkzTH9TabxUmwkeNmUpxJn52TXAn4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRqD3bw/BXPQ7xgyRGd/OStaRnACfY64PmyH1D5srU/JzhIi6
	2QPf8wIsNjamR8dmOjS0rXdgNtz70xiMVZIVRC5W2lU62o2lAKJTa7BFaaViVQ==
X-Gm-Gg: ASbGncsizNrA6dRZKyVR5goW/fNVCVSekh9G6i79d8QbqFMZvo+ECdxSLisGfhuaCyH
	AT4WovD1cBj2KWRc/E3rA7T/4sCqkEvGmpJQrfNTosjlJNZGldo0gUE8b85a6iJ9/BlYz6Pq/dQ
	LVGVpHTdjltkl/0UrApZqATpH4IchyKTpW9xlXJECKq3diy0W9wDoYWNESRvegTk/y/GfM/yPTc
	NjsPJJydH2PozyhV1cYDbiia49ox5KlPzfGRtP31ZUuzjAR36eBwqY7CoW7csX97O77AC34DVmt
	jEFsxKgy
X-Google-Smtp-Source: AGHT+IGVI281zdlVYTcdVEiL/CpBhWJseYXPG1mM20XQL8Q0gyt/Hy4yCMb7tVAtIZJ/+QY3fDJRrQ==
X-Received: by 2002:a17:90b:28c5:b0:2ee:44ec:e524 with SMTP id 98e67ed59e1d1-2f2901b1131mr2019572a91.35.1734062680598;
        Thu, 12 Dec 2024 20:04:40 -0800 (PST)
Received: from superwings-p920.tpe.corp.google.com ([2401:fa00:1:17:5fde:7175:a92c:73e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d979b7sm2179398a91.11.2024.12.12.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:04:40 -0800 (PST)
From: Ying Hsu <yinghsu@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org,
	Ying Hsu <yinghsu@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
Date: Fri, 13 Dec 2024 12:04:22 +0800
Message-ID: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Bluetooth raw socket is open, the HCI event related to SCO
connection changes are not dispatched to the hci_event module, and
the underlying Bluetooth controller's USB Interface 1 will not be
updated accordingly.

This patch adds `isoc_alt` sysfs attribute, allowing user space
to update the alternate setting of the USB interface alternate
setting as needed.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
This commit has been tested on a chromebook with AX211.

Changes in v2:
- Add check for the existence of a valid USB interface 1.

 drivers/bluetooth/btusb.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..7d7cfcd07aef 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3645,6 +3645,32 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t isoc_alt_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->isoc_altsetting);
+}
+
+static ssize_t isoc_alt_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	int alt;
+	int ret;
+
+	if (kstrtoint(buf, 10, &alt))
+		return -EINVAL;
+
+	ret = btusb_switch_alt_setting(data->hdev, alt);
+	return ret < 0 ? ret : count;
+}
+
+static DEVICE_ATTR_RW(isoc_alt);
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4008,6 +4034,10 @@ static int btusb_probe(struct usb_interface *intf,
 						 data->isoc, data);
 		if (err < 0)
 			goto out_free_dev;
+
+		err = device_create_file(&intf->dev, &dev_attr_isoc_alt);
+		if (err)
+			goto out_free_dev;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4054,8 +4084,10 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-	if (data->isoc)
+	if (data->isoc) {
+		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
 		usb_set_intfdata(data->isoc, NULL);
+	}
 
 	if (data->diag)
 		usb_set_intfdata(data->diag, NULL);
-- 
2.47.1.613.gc27f4b7a9f-goog


