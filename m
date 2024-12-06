Return-Path: <linux-kernel+bounces-435799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CE9E7CB3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC916C973
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88921480F;
	Fri,  6 Dec 2024 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KAm6cm7L"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6063213E89
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528327; cv=none; b=X/hof1cqdFaM6OFrraVvCYx0NPQxSbzZqfC+/Z6Vs6Na5pWDmt+7m6EARX7zypsOL0WDF1wUKbyAetCSzPIf7wfVwqrVzsCa1l6I6d+3+pfI+itLW4ssJ6EojwhJfaQKPr7oVzAS68UjhY/cqP/qtSZBMJxBG4IVFp0HCO+w020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528327; c=relaxed/simple;
	bh=smB67MxYTGXL0wT1q7L5mLkbgh4UMdxC1IAgHVVgeBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thdkAMRLWUhbr7JZ+NyLUQqqwwN5BZ21/isjh1v+qXWlXcDRFoboNa0hI+yFfcaQKglIJRyb00LdRqrr9dPSTs5IvX6/hB5I9xnSHcM14+yeOVong1a7AC7YWf/oK7znVupxckonI18eyM6JJ3pZoEOp3RL/ljYKM3ErcWS5B2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KAm6cm7L; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724e1742d0dso2429389b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733528325; x=1734133125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rMEcgn2kv9SSKmI6LxVsXgCiZxQojUUrd3cm2OFs5Y=;
        b=KAm6cm7Ll097qlmFWfE/CNS2X8E9rGyODJDlbxPicFckp+50Y94ZllS05EeemUjsLv
         Ew1tobuULDvokUSOnLx+5l8AXVYzKTURXkSQ/poeGqw2RYxdbALEjBygmcZSfLQnYH9z
         0Mjq8zOqc12FdtYD/nHV7UA1CgEd8DSiDgYKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528325; x=1734133125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rMEcgn2kv9SSKmI6LxVsXgCiZxQojUUrd3cm2OFs5Y=;
        b=lLFXOJ3XBlkABZOafAR9TAQSacUpTGGW667XMCWrga/Up/Y7HSKbX5IGwptPmF40vi
         oQKwH7GHemk+8F5qPM8JjuFA3mwultBonHP35kKPEUMcsfzT7AfSJQQHH/4p0e7gBE71
         XVD4Sa3E6H9L10HJJjmQDsDNupgr8vagcirfhLXgBzazQon4JSqxIVOrcK6M4MBm2awe
         dwZ9BNkTXhfDIGQ8BsCFKNnNKsSOa8KYvYCbze05jHE07nJK0/axET7lFhu4zN6yraXp
         ZovJEoV3IWBpPy1WmHixc6KbulLA/pEDgdrEUcb0fzvqzT+J/OVDzr2zemSnm+pIrY4+
         QyRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmHB/t72fRLy9QkNqm8BnQmZAvdTakP6UBMeJzZi3y3eBg1FVOMr+IYepnjVuD6aQFJX02vYQ+D6+bMWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0B4sQZ3FEb72Mhs6yQhJTyey4BQzAsZ2vKWccC5ik4dk2L/Pn
	JSXG/3lbJ3Xt4vc9R9HQ9j4l2YfrhXnl7I7C8uBD2lTDd1IPCNsNjOGiQvdLaQ==
X-Gm-Gg: ASbGncsUE/UYolfBf6qoZae6gJaTlUu6q56KP2bkM3ET0lpR3RS7r9Dopj/BeU/aG2R
	ILtRyyMbMUB1g3Cjo1NBIfdk8RRGIH9+CwC/cNloOcHzH40VTN36wUH5RDVH7QV3cnDXmaFhCur
	FkvT6yIdol+H0++GbaDBuuZAySjN8QV8QHlqOg8Cvh8+f6fBLcNAbAWm0by7X7q06aLv5y5Dnso
	JbsdCMQmOgXdj2Px4ULCO7ZjNRU0re6FOj6AlC1XnTwbzz1d4Z1l1LyovBfvRRk4hPrep1tdm1K
	49Mz97IfC31ZCjZ1/sdesAfF
X-Google-Smtp-Source: AGHT+IGMkAHbAyLL/Sws52EMD14nSuU+heoWGjssi5zVIb7cyOVFaZvfBHEZ5Z3gJblyJe0Ihk0i/A==
X-Received: by 2002:a17:903:2290:b0:216:2426:767f with SMTP id d9443c01a7336-216242677d2mr34935115ad.49.1733528325212;
        Fri, 06 Dec 2024 15:38:45 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-215f8f09146sm33847435ad.199.2024.12.06.15.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:38:44 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	pmalani@chromium.org,
	jthies@google.com,
	dmitry.baryshkov@linaro.org,
	badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
Date: Fri,  6 Dec 2024 15:38:13 -0800
Message-ID: <20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241206233830.2401638-1-abhishekpandit@chromium.org>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org>
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

Changes in v4:
- Large refactor to use cable_altmodes
- Fixed ordering of cable mode enter/exit (SOP', SOP", then port for
  enter; reverse order for exit)
- Other small fixes from v3 feedback

Changes in v3:
- Revert rename of TYPEC_TBT_MODE
- Remove mode from typec_device_id

Changes in v2:
- Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
- Pass struct typec_thunderbolt_data to typec_altmode_notify
- Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
- Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
- Change module license to GPL due to checkpatch warning

Changes in v1:
- Delay cable + plug checks so that the module doesn't fail to probe
  if cable + plug information isn't available by the time the partner
  altmode is registered.
- Remove unncessary brace after if (IS_ERR(plug))

 drivers/usb/typec/altmodes/Kconfig       |   9 +
 drivers/usb/typec/altmodes/Makefile      |   2 +
 drivers/usb/typec/altmodes/thunderbolt.c | 387 +++++++++++++++++++++++
 drivers/usb/typec/class.c                |   5 +-
 include/linux/usb/typec.h                |   2 +
 include/linux/usb/typec_tbt.h            |   1 +
 6 files changed, 404 insertions(+), 2 deletions(-)
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
index 000000000000..14e89e9a7691
--- /dev/null
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -0,0 +1,387 @@
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
+		ret = typec_cable_altmode_enter(tbt->alt, TYPEC_PLUG_SOP_P, NULL);
+		if (ret) {
+			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_P]->dev,
+				"failed to enter mode (%d)\n", ret);
+			goto disable_plugs;
+		}
+		break;
+	case TBT_STATE_SOP_PP_ENTER:
+		ret = typec_cable_altmode_enter(tbt->alt, TYPEC_PLUG_SOP_PP,  NULL);
+		if (ret) {
+			dev_dbg(&tbt->plug[TYPEC_PLUG_SOP_PP]->dev,
+				"failed to enter mode (%d)\n", ret);
+			goto disable_plugs;
+		}
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
+		typec_cable_altmode_exit(tbt->alt, TYPEC_PLUG_SOP_PP);
+		break;
+	case TBT_STATE_SOP_P_EXIT:
+		typec_cable_altmode_exit(tbt->alt, TYPEC_PLUG_SOP_P);
+		break;
+	default:
+		break;
+	}
+
+	tbt->state = TBT_STATE_IDLE;
+
+	mutex_unlock(&tbt->lock);
+	return;
+
+disable_plugs:
+	for (int i = TYPEC_PLUG_SOP_PP; i > 0; --i) {
+		if (tbt->plug[i])
+			typec_altmode_put_plug(tbt->plug[i]);
+
+		tbt->plug[i] = NULL;
+	}
+
+	tbt->state = TBT_STATE_ENTER;
+	schedule_work(&tbt->work);
+	mutex_unlock(&tbt->lock);
+}
+
+/* MUST HOLD tbt->lock.
+ *
+ * If SOP' is available, enter that first (which will trigger a VDM response
+ * that will enter SOP" if available and then the port). If entering SOP' fails,
+ * stop attempting to enter either cable altmode (probably not supported) and
+ * directly enter the port altmode.
+ */
+static int tbt_enter_modes_ordered(struct typec_altmode *alt)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+	int ret = 0;
+
+	if (!tbt_ready(tbt->alt))
+		return -ENODEV;
+
+	if (tbt->plug[TYPEC_PLUG_SOP_P]) {
+		ret = typec_cable_altmode_enter(alt, TYPEC_PLUG_SOP_P, NULL);
+		if (ret < 0) {
+			for (int i = TYPEC_PLUG_SOP_PP; i > 0; --i) {
+				if (tbt->plug[i])
+					typec_altmode_put_plug(tbt->plug[i]);
+
+				tbt->plug[i] = NULL;
+			}
+		} else {
+			return ret;
+		}
+	}
+
+	return tbt_enter_mode(tbt);
+}
+
+static int tbt_cable_altmode_vdm(struct typec_altmode *alt,
+				 enum typec_plug_index sop, const u32 hdr,
+				 const u32 *vdo, int count)
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
+			 * Following the order described in USB Type-C Spec
+			 * R2.0 Section 6.7.3: SOP', SOP", then port.
+			 */
+			if (sop == TYPEC_PLUG_SOP_P) {
+				if (tbt->plug[TYPEC_PLUG_SOP_PP])
+					tbt->state = TBT_STATE_SOP_PP_ENTER;
+				else
+					tbt->state = TBT_STATE_ENTER;
+			} else if (sop == TYPEC_PLUG_SOP_PP)
+				tbt->state = TBT_STATE_ENTER;
+
+			break;
+		case CMD_EXIT_MODE:
+			/* Exit in opposite order: Port, SOP", then SOP'. */
+			if (sop == TYPEC_PLUG_SOP_PP)
+				tbt->state = TBT_STATE_SOP_P_EXIT;
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
+
+	mutex_unlock(&tbt->lock);
+	return 0;
+}
+
+static int tbt_altmode_vdm(struct typec_altmode *alt,
+			   const u32 hdr, const u32 *vdo, int count)
+{
+	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
+	struct typec_thunderbolt_data data;
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
+		/* Port altmode is last to enter and first to exit. */
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			memset(&data, 0, sizeof(data));
+
+			data.device_mode = tbt->alt->vdo;
+			data.enter_vdo = tbt->enter_vdo;
+			if (tbt->plug[TYPEC_PLUG_SOP_P])
+				data.cable_mode = tbt->plug[TYPEC_PLUG_SOP_P]->vdo;
+
+			typec_altmode_notify(alt, TYPEC_STATE_MODAL, &data);
+			break;
+		case CMD_EXIT_MODE:
+			if (tbt->plug[TYPEC_PLUG_SOP_PP])
+				tbt->state = TBT_STATE_SOP_PP_EXIT;
+			else if (tbt->plug[TYPEC_PLUG_SOP_P])
+				tbt->state = TBT_STATE_SOP_P_EXIT;
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
+	if (activate)
+		ret = tbt_enter_modes_ordered(alt);
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
+static const struct typec_cable_ops tbt_cable_ops = {
+	.vdm		= tbt_cable_altmode_vdm,
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
+		if (tbt->plug[TYPEC_PLUG_SOP_P])
+			tbt->state = TBT_STATE_SOP_P_ENTER;
+		else if (tbt->plug[TYPEC_PLUG_SOP_PP])
+			tbt->state = TBT_STATE_SOP_PP_ENTER;
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
+	/* Thunderbolt 3 requires a cable with eMarker */
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
+		if (!plug || plug->svid != USB_TYPEC_TBT_SID)
+			break;
+
+		plug->desc = "Thunderbolt3";
+		plug->cable_ops = &tbt_cable_ops;
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
+	}
+};
+module_typec_altmode_driver(tbt_altmode_driver);
+
+MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index febe453b96be..b5e67a57762c 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -458,7 +458,8 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 	struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
 
 	if (attr == &dev_attr_active.attr)
-		if (!adev->ops || !adev->ops->activate)
+		if (!is_typec_port(adev->dev.parent) &&
+		    (!adev->ops || !adev->ops->activate))
 			return 0444;
 
 	return attr->mode;
@@ -563,7 +564,7 @@ typec_register_altmode(struct device *parent,
 
 	if (is_port) {
 		alt->attrs[3] = &dev_attr_supported_roles.attr;
-		alt->adev.active = true; /* Enabled by default */
+		alt->adev.active = !desc->inactive; /* Enabled by default */
 	}
 
 	sprintf(alt->group_name, "mode%d", desc->mode);
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index d616b8807000..252af3f77039 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -140,6 +140,7 @@ int typec_cable_set_identity(struct typec_cable *cable);
  * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
  * @roles: Only for ports. DRP if the mode is available in both roles
+ * @inactive: Only for ports. Make this port inactive (default is active).
  *
  * Description of an Alternate Mode which a connector, cable plug or partner
  * supports.
@@ -150,6 +151,7 @@ struct typec_altmode_desc {
 	u32			vdo;
 	/* Only used with ports */
 	enum typec_port_data	roles;
+	bool			inactive;
 };
 
 void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);
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
2.47.0.338.g60cca15819-goog


