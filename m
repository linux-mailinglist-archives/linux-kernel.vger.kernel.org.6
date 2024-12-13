Return-Path: <linux-kernel+bounces-445708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499569F1A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C933188E108
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD21EC4C3;
	Fri, 13 Dec 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHplin1n"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA291C3C0B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132959; cv=none; b=gbmUEDWJm1eLNpjfHP9qDnAr49ZKmfWtEwrZebiSDibAl2nMLpQeEUeJ7hAJFRHANpbwP4CcjY8LImyvlV6RIUe5IGlr5Z7vAFxbwT66zUZcGL13ojXxNURL8kfmKhfckMudFHLUsSvdYo//Wkz9GOPSKhTAfN9foDj0SmbivtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132959; c=relaxed/simple;
	bh=ZcNnlmhrVmmMMwNRBOoy4zZOB5r5+DnDezDE6NV4jR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcfLou69ZaeNEfDKCi3hTHh/ONKwnDlCaEIAyvX12qqizdc4YJQoWpiM7LZWJY2ZwNQYFDmC2XUaOimW/T/M3FLh/4MTjfwGuFaCSXS6fL95gpOpu7vY0VO4DxTXTMJBmqY4uLIhg5GSzLfL4jzwJkmOs/t3zq97wzf5Na3aHo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHplin1n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso17894535ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132957; x=1734737757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaRD9DPyrFbyL8pyww8mrMbKOId4U0+Qeig9qlLXmr4=;
        b=lHplin1nNWtpnMIol4jaKJnIGf/2Z+yMdfF1aESp515wfTxrJhVWaMhYkH+2EFMEXu
         ZA0/XnN1vjM5ApBewdyndXgAsQVGxtCSHc/U5LELh1/Zz35M3FMxpW6UgIRG8AWfURl+
         81dgzfC1KouJGztQdILAI8CurlV00pN/JiRK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132957; x=1734737757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaRD9DPyrFbyL8pyww8mrMbKOId4U0+Qeig9qlLXmr4=;
        b=gU7aB8WLeYU8/IK4P223U1bUpRnQ55vSGJlNfXvkPej2XQ0MpH8FH7yFjvO8d4S/pa
         YrlQlY609fvko9epJ7fZZ5AgszO+kNGZS3D+Gue4HmjqK45EIkSWmywIhTgUTzTc1/Dy
         be+tZlql9hs3N2ZkzVooqpuqGUP369W78EOneyFep6Um7pNuhDqRFKw1R9OtdFhoMOqt
         qGj2t2mhkC5qaXaSOaLxSrHsz8yAPHN0zn6CzkQVFkX1NauLUNbB3LpxUpZsYShy08a8
         13lxn+gCxC7pc4tKEzKP0JAqzuaoR423tHABSeXWNk3qkx9Cj9Xo269hFkkRIvaZxHJ4
         ssEA==
X-Forwarded-Encrypted: i=1; AJvYcCUZlhp+keBaFNFRrC2wdKVKrXxEjMUOXIdmniTRkCH3gfQIEkqv5mxrm90dpBCvsT47LuavxI1Q+dllSnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0z4nOgPKLWaEmufMBxhxryqPyBgR/d5Ncplgeo1ozesQYU+f
	ibNoNqiJ+WNCyjRaOe8yOo11bFZV/ZyVBEXqz7hCuy68HO3V4Iai4H4zJYkKdw==
X-Gm-Gg: ASbGncuCaH309z9zPmOLyzVFeWq4/SJIrUqqcpwxHGz8sGK0zdnMGcgQi09mjM49gOV
	aB9RgYGrz3kskXujUDw3xAyz0nxeysFkI7oIlnPXJwwkEqj8cfQxrrDcUunKi+5aqImC1lJPNTF
	6kueiOZVM3ULfIYvpAcuCmjgNn443DvB/tP7bNla0/UmsOmOyMeJUqpDgoutm9hahHuGkx9j/kF
	IY9ahvWxC6OCkZViuMho2VMkYmfqhFCx4nfiZZxQZghXjdSQ2CTYv9FRhPU60WhcYP+NvTr5wAl
	gkaM3bLPVBDu7tWBXCpIOJvRzkrgBvI=
X-Google-Smtp-Source: AGHT+IETdNgVXYZ5Z8O24raMy/AF+XMjHbeYQOwM0hr6oaWPRSIzz/61m5YWJ+TaoHPwZWibfwn4Xg==
X-Received: by 2002:a17:90b:3ec7:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f28fb66708mr8908266a91.12.1734132956814;
        Fri, 13 Dec 2024 15:35:56 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f2a1e9939fsm333523a91.13.2024.12.13.15.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:35:56 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	sboyd@kernel.org,
	pmalani@chromium.org,
	badhri@google.com,
	rdbabiera@google.com,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
Date: Fri, 13 Dec 2024 15:35:43 -0800
Message-ID: <20241213153543.v5.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213233552.451927-1-abhishekpandit@chromium.org>
References: <20241213233552.451927-1-abhishekpandit@chromium.org>
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

Changes in v5:
- Add lockdep, missing includes and fix up block comment style.

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
 drivers/usb/typec/altmodes/thunderbolt.c | 388 +++++++++++++++++++++++
 include/linux/usb/typec_tbt.h            |   1 +
 4 files changed, 400 insertions(+)
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
index 000000000000..1b475b1d98e7
--- /dev/null
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Typec-C Thunderbolt3 Alternate Mode driver
+ *
+ * Copyright (C) 2019 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/lockdep.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
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
+/*
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
+	lockdep_assert_held(&tbt->lock);
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
2.47.1.613.gc27f4b7a9f-goog


