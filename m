Return-Path: <linux-kernel+bounces-400537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7049C0EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F8C28402F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529FA217F50;
	Thu,  7 Nov 2024 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQhaXhTE"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5092217F39
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007905; cv=none; b=aObCFAsQqxEY87J3/2orwn6unNtj4kNolGmvx41j5A9YxjnA7Ltzux8gkhrIRtVU/LPUEX06ZQrWxnERWSjE7sqjHI9VrR820NP2sWxmvoiPC5bQpgpf2xORsVPPjhrlKivEGJhFsZrt8bg8ndkZ/CrJErlM8m/Xphvf7vBHocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007905; c=relaxed/simple;
	bh=xKZEM3BEB1RuTSN4Uueuml1p0DgkTsbm8rJMvKSFMCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjBDp7vNNOvq7jR/N2iG0/sAmCOnQGjdLhMy0QpAaPuZi8/etj2LOCW6/DZQ7mdDratwgRMeYoRV3QZWIyqJfG0w1OLnlzo/CY3ASdgLCXvhAk6L4xK61pX5+1ZUBmUBQb9DJl7qU0unltqDTSm2s9h8gIPJoInOxce2I3thoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kQhaXhTE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720be27db74so1108793b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731007903; x=1731612703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83Suh2wjIyKRrMNGwMzdQsYr0nqcWo4eqvxd8u8DH7w=;
        b=kQhaXhTEUfJBe7s3Jds9KlHa1fcBK5mBVQFGB/3DCZ6zHUt4ehSpGSAhOwAxHqPgBh
         fRqvE2rgnnS+TPZKJLbb7ngMHCSbqpnT0FVSCtmSrL/3KKdF5jeEbnQy3znJ6jiP3DTb
         A+WSooq9A+m6i7oCV8gA13ALIjODVntP4Y4f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007903; x=1731612703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83Suh2wjIyKRrMNGwMzdQsYr0nqcWo4eqvxd8u8DH7w=;
        b=gIFv21pwpLc9yMlHqO1VILyaKi4w4+OqDGGsv5hsO1vvzzO9XbbdiE1tvcmy1Oj11f
         bkTDvBit4Qtq527LeM5HqOAF6pKE4v0dvoIzhWkicWo2MJpY/ezPQidZiAobkwYXkrml
         MzB86Ed7ChhnkTEy9mZ3hZaDzMS+7C0MjdkHsG5xYE898pR2SRkT0N//pcYMKYebX9ob
         x/6VJgkQI8ISqm3GvGvbFafBqNuO8aYzEaSGzQnfTBcPK+a1IT0SNEyqgSEpiWgBYXZA
         cocJQxFLh2LRIwQOEiSoTgDHyWc2qrCW6cDWjqpoRFgKp+LuX0p6aHt4wSxFcItS5XCp
         QrWg==
X-Forwarded-Encrypted: i=1; AJvYcCVvWGok32aqPCciNyqz69z0llvUxtWMCMUgo9TG9RBf5KGkOuhIxCrjmONizGaXhmVHPj24aIU5lRTkhjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTnuSsU/hG0MljzR/Cf9gdEh8DkhUCuyOaNEEx9Fr0ubFeCLU
	DnTw5UYr0oLQBsdkB4+aq4CHYT/rE/6SplWBMPDb0SfGY/gHEFEJ/unDtF+iGw==
X-Google-Smtp-Source: AGHT+IHowZtPGb5/tcFnUmur6kDpXYtUcCT3psAEQ+OeTjw995kJie6fup9tOg4xNTXfF4EEHk+p9Q==
X-Received: by 2002:a05:6a00:21c4:b0:71e:7f08:492c with SMTP id d2e1a72fcca58-72413f4c526mr51975b3a.1.1731007902821;
        Thu, 07 Nov 2024 11:31:42 -0800 (PST)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724078cd28asm2002020b3a.85.2024.11.07.11.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 11:31:42 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	dmitry.baryshkov@linaro.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
Date: Thu,  7 Nov 2024 11:29:55 -0800
Message-ID: <20241107112955.v3.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241107193021.2690050-1-abhishekpandit@chromium.org>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
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
Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes:
* Delay cable + plug checks so that the module doesn't fail to probe
  if cable + plug information isn't available by the time the partner
  altmode is registered.
* Remove unncessary brace after if (IS_ERR(plug))

The rest of this patch should be the same as Heikki's original RFC.


Changes in v3:
- Revert rename of TYPEC_TBT_MODE
- Remove mode from typec_device_id

Changes in v2:
- Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
- Pass struct typec_thunderbolt_data to typec_altmode_notify
- Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
- Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
- Change module license to GPL due to checkpatch warning

 drivers/usb/typec/altmodes/Kconfig       |   9 +
 drivers/usb/typec/altmodes/Makefile      |   2 +
 drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++++++++++
 include/linux/usb/typec_tbt.h            |   1 +
 4 files changed, 320 insertions(+)
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
index 000000000000..a945b9d35a1d
--- /dev/null
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -0,0 +1,308 @@
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
+#include <linux/usb/typec_tbt.h>
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
+	u32 enter_vdo;
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
+	tbt->enter_vdo = vdo;
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
+				struct typec_thunderbolt_data data;
+
+				data.device_mode = tbt->alt->vdo;
+				data.cable_mode =
+					tbt->plug[TYPEC_PLUG_SOP_P] ?
+						tbt->plug[TYPEC_PLUG_SOP_P]
+							->vdo :
+						0;
+				data.enter_vdo = tbt->enter_vdo;
+
+				typec_altmode_notify(alt, TYPEC_STATE_MODAL, &data);
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
+	{ USB_TYPEC_TBT_SID },
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index fa97d7e00f5c..55dcea12082c 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -44,6 +44,7 @@ struct typec_thunderbolt_data {
 
 #define   TBT_GEN3_NON_ROUNDED                 0
 #define   TBT_GEN3_GEN4_ROUNDED_NON_ROUNDED    1
+#define TBT_CABLE_ROUNDED		BIT(19)
 #define TBT_CABLE_OPTICAL		BIT(21)
 #define TBT_CABLE_RETIMER		BIT(22)
 #define TBT_CABLE_LINK_TRAINING		BIT(23)
-- 
2.47.0.277.g8800431eea-goog


