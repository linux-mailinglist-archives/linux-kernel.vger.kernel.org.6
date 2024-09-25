Return-Path: <linux-kernel+bounces-339409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CBE9864C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DD71F25583
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658D13B59A;
	Wed, 25 Sep 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPkWzjSk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E86F305
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281521; cv=none; b=iQBFFZbi8KLrEZEdYrtpZPmuUYFjZqTiphl1Hs7l55JqpjpRIxJr/OMlkMzXEexFcGM4xf1Y52gbijDpMVKVhnlxfQCuLdawqpkVSHtJeDYEb4AyjpwkYzVTeZRaR0k1kF/MYWo6oSPzr4apcrXer7iDMTksFbGUtZ2wmqTbwFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281521; c=relaxed/simple;
	bh=bTqNKaJ0zrSNVrgzbJdNqFzrk1uq/TCe0Tw0ffqNEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kp8iB0DRm+tSYS/QgmninyIBGJNd6qDIxgvfkXlqWn+0eYMhf8wtUECdNHKnNnqU0Vy9VR5ZMgpJWkDMbVZ5uyRR0civBqAmE4MAGBfT+mOgTd/l/wb3Sv+P68zMui8YXZJxW4ZlyVj8Un7GOFBcvkRFoq5ghxd0EryzD5sorv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FPkWzjSk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b1335e4e4so4678245ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727281519; x=1727886319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soh9tpwQeZYCRkIZ0qsRPLYdoMt3WX+ET4bADOa1Pug=;
        b=FPkWzjSkyeTHv7HGzlx50ZCWX8Y9VF7D3DDzZwIo4yFztfNIsTJk6j7Wc4LVLkQsTp
         YgXg0Q527zkFecQSh+1DE3jKxWQ3VHzn+/vfMZNmAHoC1hYHjUv78IrMCp+MPrb0BWni
         xw5K/S0TLywDGF9i6ge5Fo+dhkUemUT8DVT7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281519; x=1727886319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soh9tpwQeZYCRkIZ0qsRPLYdoMt3WX+ET4bADOa1Pug=;
        b=XPRmYye7FPjzFZHFSl5QhybAlRnWiVU5uYZdvXlWxFu1heE7bsEhEZzeslYtOL66Bw
         +EfnTQh3jAhraj2Xg90Nw6MWQZZbUAs8Epv6naGC4MDA16akPwLBqw/dNVUTn3Qa0MQM
         BpJVVAlYxAXCZV594pndoSUigO3E3KzgfHDY8PjAkeU6j9CF1EPn5j+Sq72oWd/hn87k
         NNkJZRacooR+gViI+PiCUe7c3EQ5Gb4R9L+nv8Nb9Br/U9oULZSXNxp6G+gqMIeY6UGy
         I3qGj4qZt7san0LOtPZJwQ37Jn7CSGB86PBlgTf5HJUYt0luiQZXf7k8y9X4O7DZYOmq
         Z2kA==
X-Forwarded-Encrypted: i=1; AJvYcCV5kb8YPE1FvxgQ/0mMzxnwBNCHTmRspIABQ4J4p15tehKX6UIVm8+OXgNIvSxJxM+4sbpQ64eTBDQ4sMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMVCECN4W8ArmHWoQYyZwra9O+wVPZdw3pp6VZqyYjlrAIFCe
	qwchASgZ6cnhtpLKhX0Eh2PjySWLGW8zaiFrPLpmRWPxj4qyj87040Qek+jGUA==
X-Google-Smtp-Source: AGHT+IGr3cGE4FriIync0xkl+vrO6tr5K8eOoarCEoEgywCGg+W4iCeJ35U6sKFdtVDSZmLZ3EJmfg==
X-Received: by 2002:a17:903:11c4:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-20afc4c83c5mr46503105ad.41.1727281519237;
        Wed, 25 Sep 2024 09:25:19 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20af17dffdasm26422195ad.176.2024.09.25.09.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:25:18 -0700 (PDT)
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
Subject: [PATCH 4/8] usb: typec: Auto enter control for alternate modes
Date: Wed, 25 Sep 2024 09:25:05 -0700
Message-ID: <20240925092505.4.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
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

Add controls for whether an alternate mode is automatically entered when
a partner connects. The auto_enter control is only available on ports
and applies immediately after a partner connects. The default behavior
is to enable auto enter and drivers must explicitly disable it.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
 drivers/usb/typec/altmodes/displayport.c  |  6 +++--
 drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
 drivers/usb/typec/class.c                 | 31 +++++++++++++++++++++++
 include/linux/usb/typec.h                 |  2 ++
 include/linux/usb/typec_altmode.h         |  2 ++
 6 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/ABI/testing/sysfs-bus-typec
index 205d9c91e2e1..f09d05727b82 100644
--- a/Documentation/ABI/testing/sysfs-bus-typec
+++ b/Documentation/ABI/testing/sysfs-bus-typec
@@ -12,6 +12,15 @@ Description:
 
 		Valid values are boolean.
 
+What:		/sys/bus/typec/devices/.../auto_enter
+Date:		September 2024
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Controls whether a mode will be automatically entered when a partner is
+		connected.
+
+		This field is only valid and displayed on a port. Valid values are boolean.
+
 What:		/sys/bus/typec/devices/.../description
 Date:		July 2018
 Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 92cc1b136120..7b164086bbbb 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -767,8 +767,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	if (plug)
 		typec_altmode_set_drvdata(plug, dp);
 
-	dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
-	schedule_work(&dp->work);
+	if (port->auto_enter) {
+		dp->state = plug ? DP_STATE_ENTER_PRIME : DP_STATE_ENTER;
+		schedule_work(&dp->work);
+	}
 
 	return 0;
 }
diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index 515e775ee41a..ba2ddaf3245e 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -225,6 +225,7 @@ static const struct typec_altmode_ops tbt_altmode_ops = {
 
 static int tbt_altmode_probe(struct typec_altmode *alt)
 {
+	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct tbt_altmode *tbt;
 
 	tbt = devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
@@ -239,7 +240,7 @@ static int tbt_altmode_probe(struct typec_altmode *alt)
 	typec_altmode_set_drvdata(alt, tbt);
 	typec_altmode_set_ops(alt, &tbt_altmode_ops);
 
-	if (tbt_ready(alt)) {
+	if (port->auto_enter && tbt_ready(alt)) {
 		if (tbt->plug[TYPEC_PLUG_SOP_PP])
 			tbt->state = TBT_STATE_SOP_PP_ENTER;
 		else if (tbt->plug[TYPEC_PLUG_SOP_P])
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 179856503d5d..a7ae0cdecca0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -397,6 +397,31 @@ static ssize_t active_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(active);
 
+static ssize_t
+auto_enter_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct typec_altmode *alt = to_typec_altmode(dev);
+
+	return sprintf(buf, "%s\n", alt->auto_enter ? "yes" : "no");
+}
+
+static ssize_t auto_enter_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	struct typec_altmode *adev = to_typec_altmode(dev);
+	bool auto_enter;
+	int ret;
+
+	ret = kstrtobool(buf, &auto_enter);
+	if (ret)
+		return ret;
+
+	adev->auto_enter = auto_enter;
+
+	return size;
+}
+static DEVICE_ATTR_RW(auto_enter);
+
 static ssize_t
 supported_roles_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
@@ -440,6 +465,7 @@ static DEVICE_ATTR_RO(svid);
 
 static struct attribute *typec_altmode_attrs[] = {
 	&dev_attr_active.attr,
+	&dev_attr_auto_enter.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_svid.attr,
 	&dev_attr_vdo.attr,
@@ -455,6 +481,10 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 		if (!adev->ops || !adev->ops->activate)
 			return 0444;
 
+	if (attr == &dev_attr_auto_enter.attr)
+		if (!is_typec_port(adev->dev.parent))
+			return 0;
+
 	return attr->mode;
 }
 
@@ -557,6 +587,7 @@ typec_register_altmode(struct device *parent,
 	if (is_port) {
 		alt->attrs[3] = &dev_attr_supported_roles.attr;
 		alt->adev.active = true; /* Enabled by default */
+		alt->adev.auto_enter = !desc->no_auto_enter;
 	}
 
 	sprintf(alt->group_name, "mode%d", desc->mode);
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 549275f8ac1b..67242355f78e 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -128,6 +128,7 @@ int typec_cable_set_identity(struct typec_cable *cable);
  * @svid: Standard or Vendor ID
  * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
+ * @no_auto_enter: Only for ports. Disables auto enter which is default behavior.
  * @roles: Only for ports. DRP if the mode is available in both roles
  *
  * Description of an Alternate Mode which a connector, cable plug or partner
@@ -137,6 +138,7 @@ struct typec_altmode_desc {
 	u16			svid;
 	u8			mode;
 	u32			vdo;
+	bool			no_auto_enter;
 	/* Only used with ports */
 	enum typec_port_data	roles;
 };
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index b3c0866ea70f..ab7c3ebe4926 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -18,6 +18,7 @@ struct typec_altmode_ops;
  * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
  * @active: Tells has the mode been entered or not
+ * @auto_enter: Tells whether to auto-enter mode (only valid for port mode).
  * @desc: Optional human readable description of the mode
  * @ops: Operations vector from the driver
  * @cable_ops: Cable operations vector from the driver.
@@ -28,6 +29,7 @@ struct typec_altmode {
 	int				mode;
 	u32				vdo;
 	unsigned int			active:1;
+	unsigned int			auto_enter:1;
 
 	char				*desc;
 	const struct typec_altmode_ops	*ops;
-- 
2.46.0.792.g87dc391469-goog


