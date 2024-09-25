Return-Path: <linux-kernel+bounces-339406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3B9864BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5FB1C22F09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B04D8BF;
	Wed, 25 Sep 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Drju13rI"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6C3B298
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281518; cv=none; b=MoKOgDgl7zgFEZy+9Yj+6uVFmbXECHoLkMLnta7/z/veCF1gjfhIjukjFCTl9KiBq2Mm/S3OiTSbqmwuYFh6C2YABI8jq817HIMBLjqj4mttp3xXr1QclPcWI7XtMmmuNb1o6NwB8Q0JXf+OMexOsF1eryb6v/5aJwhm68P71ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281518; c=relaxed/simple;
	bh=T4RnOjnnRlXT9AkkzqwUs+wqJYYyJuCdRXXu/NmJ5tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSk0rGvGa3S2xkPRoa+0cLPLxL0t5fUYScPzydynYnA5BFjckkRuAV3f+gdvb+hDWR8DESAk975PSyiNUr6CvmH4obV3lCt8SS8ZZ0BlM5TIS0S//UjGgaK7nw8GWmIkZPTPxJE+C+nBqVECMZgjcpm84UXsynSeYrMSNIr0Ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Drju13rI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71b08405187so74807b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281516; x=1727886316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+fzEPtpiDuBZH77Ojs0eNit0iDR4Bt4bD2UwQhL7js=;
        b=Drju13rI7uOnThPXYGqAok5hHbtACcIHSJDAB1hqIRSCSNN0KwiX1JsDBL4cYhhhp5
         zci7w6ubMBpb7tIzyUNE14vRddvvH4653EcKu6RayZyhZJVSd5JkoRxCDQ2e8sSFdHpw
         WS24Detq1T6EbsIJs2L004Ux6EfzL5hlJObNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281516; x=1727886316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+fzEPtpiDuBZH77Ojs0eNit0iDR4Bt4bD2UwQhL7js=;
        b=uwx61SAkW2lZ4hzlnkxb679Yx/vMADRCFvEx2DzDDLpjTaXqa7J3kj2L8qgln0Mrsp
         CiD1UoXLXxQsW13/BbE7T4LHd5hl3El41fk1WMB5RY5SH1zLUqsV3ncN2ZC17Am7A3oW
         WOwxshbQEUlLEJnPPy9C4BqfW4CubddsfiiK8kLcUU1R4vSEP2HvcMpq8rnbIGGgeJv5
         vhAi50KcCw3vdpFx1tM6wi6g2+u7YAft4M6Q5P3VZF7YB5NnDYI4a9v3qjN6mPFPgjfC
         LeeM9n+JL7Jlv1gZXAWWUiMFFL8y4r75FtB+FMmVZ5OQ/0Gap7w70BNbGzi5wc8Sfqg9
         iGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiP2dNxRL1slFN/Yl+cMIL528XBJOxJbwCES9nkS6tWfzhpfdJCscQS+ZC8VuPFMd2MDxDKC85VqrG+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBvNstOch079nbXai8AujSjcoKw5bPm19H226D7BCkBvG1nvW
	+AXh9NHuN2Po9zIwajbQ6smwONtrRQpNlbILUm7alyqnSSZmTZ8eUPkJDvNSIQ==
X-Google-Smtp-Source: AGHT+IG75Vy5hIcFYdYhSgVz+KBWwgeHqFcnz9r+B+MSJzNpY0kWW+NHCzlYyYQL8Grxr4Ppix+Dag==
X-Received: by 2002:a05:6a00:2292:b0:717:950e:b589 with SMTP id d2e1a72fcca58-71b0ac57543mr5840836b3a.19.1727281515857;
        Wed, 25 Sep 2024 09:25:15 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7e6b7c3f161sm2912617a12.27.2024.09.25.09.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:15 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 1/8] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
Date: Wed, 25 Sep 2024 09:25:02 -0700
Message-ID: <20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925162513.435177-1-abhishekpandit@chromium.org>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thunderbolt 3 Alternate Mode entry flow is described in
USB Type-C Specification Release 2.0.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes:
* Delay cable + plug checks so that the module doesn't fail to probe
  if cable + plug information isn't available by the time the partner
  altmode is registered.
* Remove unncessary brace after if (IS_ERR(plug))

The rest of this patch should be the same as Heikki's original RFC.


 drivers/usb/typec/altmodes/Kconfig       |   9 +
 drivers/usb/typec/altmodes/Makefile      |   2 +
 drivers/usb/typec/altmodes/thunderbolt.c | 321 +++++++++++++++++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c

diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
index 1a6b5e872b0d..7867fa7c405d 100644
--- a/drivers/usb/typec/altmodes/Kconfig
+++ b/drivers/usb/typec/altmodes/Kconfig
@@ -23,4 +23,13 @@ config TYPEC_NVIDIA_ALTMODE
 	  To compile this driver as a module, choose M here: the
 	  module will be called typec_nvidia.
 
+config TYPEC_TBT_ALTMODE
+	tristate "Thunderbolt3 Alternate Mode driver"
+	help
+	  Select this option if you have Thunderbolt3 hardware on your
+	  system.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called typec_thunderbolt.
+
 endmenu
diff --git a/drivers/usb/typec/altmodes/Makefile b/drivers/usb/typec/altmodes/Makefile
index 45717548b396..508a68351bd2 100644
--- a/drivers/usb/typec/altmodes/Makefile
+++ b/drivers/usb/typec/altmodes/Makefile
@@ -4,3 +4,5 @@ obj-$(CONFIG_TYPEC_DP_ALTMODE)		+= typec_displayport.o
 typec_displayport-y			:= displayport.o
 obj-$(CONFIG_TYPEC_NVIDIA_ALTMODE)	+= typec_nvidia.o
 typec_nvidia-y				:= nvidia.o
+obj-$(CONFIG_TYPEC_TBT_ALTMODE)		+= typec_thunderbolt.o
+typec_thunderbolt-y			:= thunderbolt.o
diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
new file mode 100644
index 000000000000..515e775ee41a
--- /dev/null
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * USB Typec-C Thuderbolt3 Alternate Mode driver
+ *
+ * Copyright (C) 2019 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/usb/pd_vdo.h>
+#include <linux/usb/typec_altmode.h>
+
+#define USB_TYPEC_VENDOR_INTEL		0x8087
+
+/* TBT3 Device Discover Mode VDO bits */
+#define TBT_MODE			BIT(0)
+#define TBT_ADAPTER(_vdo_)		(((_vdo_) & BIT(16)) >> 16)
+#define   TBT_ADAPTER_LEGACY		0
+#define   TBT_ADAPTER_TBT3		1
+#define TBT_INTEL_SPECIFIC_B0		BIT(26)
+#define TBT_VENDOR_SPECIFIC_B0		BIT(30)
+#define TBT_VENDOR_SPECIFIC_B1		BIT(31)
+
+/* TBT3 Cable Discover Mode VDO bits */
+#define TBT_CABLE_SPEED(_vdo_)		(((_vdo_) & GENMASK(18, 16)) >> 16)
+#define   TBT_CABLE_USB3_GEN1		1
+#define   TBT_CABLE_USB3_PASSIVE	2
+#define   TBT_CABLE_10_AND_20GBPS	3
+#define TBT_CABLE_ROUNDED		BIT(19)
+#define TBT_CABLE_OPTICAL		BIT(21)
+#define TBT_CABLE_RETIMER		BIT(22)
+#define TBT_CABLE_LINK_TRAINING		BIT(23)
+
+/* TBT3 Device Enter Mode VDO bits */
+#define TBT_ENTER_MODE_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
+#define TBT_ENTER_MODE_ACTIVE_CABLE	BIT(24)
+
+enum tbt_state {
+	TBT_STATE_IDLE,
+	TBT_STATE_SOP_P_ENTER,
+	TBT_STATE_SOP_PP_ENTER,
+	TBT_STATE_ENTER,
+	TBT_STATE_EXIT,
+	TBT_STATE_SOP_PP_EXIT,
+	TBT_STATE_SOP_P_EXIT
+};
+
+struct tbt_altmode {
+	enum tbt_state state;
+	struct typec_cable *cable;
+	struct typec_altmode *alt;
+	struct typec_altmode *plug[2];
+
+	struct work_struct work;
+	struct mutex lock; /* device lock */
+};
+
+static bool tbt_ready(struct typec_altmode *alt);
+
+static int tbt_enter_mode(struct tbt_altmode *tbt)
+{
+	struct typec_altmode *plug = tbt->plug[TYPEC_PLUG_SOP_P];
+	u32 vdo;
+
+	vdo = tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B1);
+	vdo |= tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
+	vdo |= TBT_MODE;
+
+	if (plug) {
+		if (typec_cable_is_active(tbt->cable))
+			vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
+
+		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
+		vdo |= plug->vdo & TBT_CABLE_ROUNDED;
+		vdo |= plug->vdo & TBT_CABLE_OPTICAL;
+		vdo |= plug->vdo & TBT_CABLE_RETIMER;
+		vdo |= plug->vdo & TBT_CABLE_LINK_TRAINING;
+	} else {
+		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
+	}
+
+	return typec_altmode_enter(tbt->alt, &vdo);
+}
+
+static void tbt_altmode_work(struct work_struct *work)
+{
+	struct tbt_altmode *tbt = container_of(work, struct tbt_altmode, work);
+	int ret;
+
+	mutex_lock(&tbt->lock);
+
+	switch (tbt->state) {
+	case TBT_STATE_SOP_P_ENTER:
+		ret = typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_P], NULL);
+		if (ret)
+			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
+				"failed to enter mode (%d)\n", ret);
+		break;
+	case TBT_STATE_SOP_PP_ENTER:
+		ret = typec_altmode_enter(tbt->plug[TYPEC_PLUG_SOP_PP], NULL);
+		if (ret)
+			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_PP]->dev,
+				"failed to enter mode (%d)\n", ret);
+		break;
+	case TBT_STATE_ENTER:
+		ret = tbt_enter_mode(tbt);
+		if (ret)
+			dev_dbg(&tbt->alt->dev, "failed to enter mode (%d)\n",
+				ret);
+		break;
+	case TBT_STATE_EXIT:
+		typec_altmode_exit(tbt->alt);
+		break;
+	case TBT_STATE_SOP_PP_EXIT:
+		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_PP]);
+		break;
+	case TBT_STATE_SOP_P_EXIT:
+		typec_altmode_exit(tbt->plug[TYPEC_PLUG_SOP_P]);
+		break;
+	default:
+		break;
+	}
+
+	tbt->state = TBT_STATE_IDLE;
+
+	mutex_unlock(&tbt->lock);
+}
+
+static int tbt_altmode_vdm(struct typec_altmode *alt,
+			   const u32 hdr, const u32 *vdo, int count)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+	int cmd_type = PD_VDO_CMDT(hdr);
+	int cmd = PD_VDO_CMD(hdr);
+
+	mutex_lock(&tbt->lock);
+
+	if (tbt->state != TBT_STATE_IDLE) {
+		mutex_unlock(&tbt->lock);
+		return -EBUSY;
+	}
+
+	switch (cmd_type) {
+	case CMDT_RSP_ACK:
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			/*
+			 * Following the order describeded in USB Type-C Spec
+			 * R2.0 Section 6.7.3.
+			 */
+			if (alt == tbt->plug[TYPEC_PLUG_SOP_P]) {
+				if (tbt->plug[TYPEC_PLUG_SOP_PP])
+					tbt->state = TBT_STATE_SOP_PP_ENTER;
+				else
+					tbt->state = TBT_STATE_ENTER;
+			} else if (alt == tbt->plug[TYPEC_PLUG_SOP_PP]) {
+				tbt->state = TBT_STATE_ENTER;
+			} else {
+				typec_altmode_notify(alt, TYPEC_STATE_MODAL,
+						     NULL);
+			}
+			break;
+		case CMD_EXIT_MODE:
+			if (alt == tbt->alt) {
+				if (tbt->plug[TYPEC_PLUG_SOP_PP])
+					tbt->state = TBT_STATE_SOP_PP_EXIT;
+				else if (tbt->plug[TYPEC_PLUG_SOP_P])
+					tbt->state = TBT_STATE_SOP_P_EXIT;
+			} else if (alt == tbt->plug[TYPEC_PLUG_SOP_PP]) {
+				tbt->state = TBT_STATE_SOP_P_EXIT;
+			}
+			break;
+		}
+		break;
+	case CMDT_RSP_NAK:
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			dev_warn(&alt->dev, "Enter Mode refused\n");
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (tbt->state != TBT_STATE_IDLE)
+		schedule_work(&tbt->work);
+
+	mutex_unlock(&tbt->lock);
+
+	return 0;
+}
+
+static int tbt_altmode_activate(struct typec_altmode *alt, int activate)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+	int ret;
+
+	mutex_lock(&tbt->lock);
+
+	if (!tbt_ready(alt))
+		return -ENODEV;
+
+	/* Preventing the user space from entering/exiting the cable alt mode */
+	if (alt != tbt->alt)
+		ret = -EPERM;
+	else if (activate)
+		ret = tbt_enter_mode(tbt);
+	else
+		ret = typec_altmode_exit(alt);
+
+	mutex_unlock(&tbt->lock);
+
+	return ret;
+}
+
+static const struct typec_altmode_ops tbt_altmode_ops = {
+	.vdm		= tbt_altmode_vdm,
+	.activate	= tbt_altmode_activate
+};
+
+static int tbt_altmode_probe(struct typec_altmode *alt)
+{
+	struct tbt_altmode *tbt;
+
+	tbt = devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
+	if (!tbt)
+		return -ENOMEM;
+
+	INIT_WORK(&tbt->work, tbt_altmode_work);
+	mutex_init(&tbt->lock);
+	tbt->alt = alt;
+
+	alt->desc = "Thunderbolt3";
+	typec_altmode_set_drvdata(alt, tbt);
+	typec_altmode_set_ops(alt, &tbt_altmode_ops);
+
+	if (tbt_ready(alt)) {
+		if (tbt->plug[TYPEC_PLUG_SOP_PP])
+			tbt->state = TBT_STATE_SOP_PP_ENTER;
+		else if (tbt->plug[TYPEC_PLUG_SOP_P])
+			tbt->state = TBT_STATE_SOP_P_ENTER;
+		else
+			tbt->state = TBT_STATE_ENTER;
+		schedule_work(&tbt->work);
+	}
+
+	return 0;
+}
+
+static void tbt_altmode_remove(struct typec_altmode *alt)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+
+	for (int i = TYPEC_PLUG_SOP_PP; i > 0; --i) {
+		if (tbt->plug[i])
+			typec_altmode_put_plug(tbt->plug[i]);
+	}
+
+	if (tbt->cable)
+		typec_cable_put(tbt->cable);
+}
+
+static bool tbt_ready(struct typec_altmode *alt)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+	struct typec_altmode *plug;
+
+	if (tbt->cable)
+		return true;
+
+	/* Thundebolt 3 requires a cable with eMarker */
+	tbt->cable = typec_cable_get(typec_altmode2port(tbt->alt));
+	if (!tbt->cable)
+		return false;
+
+	/* We accept systems without SOP' or SOP''. This means the port altmode
+	 * driver will be responsible for properly ordering entry/exit.
+	 */
+	for (int i = 0; i < TYPEC_PLUG_SOP_PP + 1; i++) {
+		plug = typec_altmode_get_plug(tbt->alt, i);
+		if (IS_ERR(plug))
+			continue;
+
+		if (!plug || plug->svid != USB_TYPEC_VENDOR_INTEL)
+			break;
+
+		plug->desc = "Thunderbolt3";
+		plug->ops = &tbt_altmode_ops;
+		typec_altmode_set_drvdata(plug, tbt);
+
+		tbt->plug[i] = plug;
+	}
+
+	return true;
+}
+
+static const struct typec_device_id tbt_typec_id[] = {
+	{ USB_TYPEC_VENDOR_INTEL, TYPEC_ANY_MODE },
+	{ }
+};
+MODULE_DEVICE_TABLE(typec, tbt_typec_id);
+
+static struct typec_altmode_driver tbt_altmode_driver = {
+	.id_table = tbt_typec_id,
+	.probe = tbt_altmode_probe,
+	.remove = tbt_altmode_remove,
+	.driver = {
+		.name = "typec-thunderbolt",
+		.owner = THIS_MODULE,
+	}
+};
+module_typec_altmode_driver(tbt_altmode_driver);
+
+MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
-- 
2.46.0.792.g87dc391469-goog


