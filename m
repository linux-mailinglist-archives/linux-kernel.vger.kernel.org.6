Return-Path: <linux-kernel+bounces-389598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4A9B6ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B7CB22024
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF39218582;
	Wed, 30 Oct 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ctwky1Bl"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF1D215C72
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323753; cv=none; b=jqtxyvL9Y90szCTN5bvUsCxbnQw9P6Lh5HxcJv2hbNNIgXCxIG1lIUsPQCyq0q3ibPmsmZ+OSbZIxLnlSfUpgaahmq612rYnysZxt+o5zvD1lHHwi55C6uciOatf3b2iioRggjckLG3NEJs/yK10Wvyf4zqWwTqvOLoDWooRZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323753; c=relaxed/simple;
	bh=wmoTH6RDMvSrIitc+RyQ8z5eGj/rSYnzG0QzoUpsshA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrpJWtiT0S+WfboorblLXqG4AOED7GgkCxQfgcyg9o/dvysudub30JNl1LH+ONawH/CUYGXEIaGrfl6uBdaGq6bAbtdJfvDVZXAXkrumapFvLY3qDpMteFkAGfXzuGVlRi1wbS5+INhuryC7deBU7de+Qvx+B3DKHxlEqtxC9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ctwky1Bl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so288574a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323750; x=1730928550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcJ6rYdsw1OyRONz4zGVh02ld/8YsK6wUyzfWA/Y9e4=;
        b=ctwky1BlJ4LdpQj2KLWdI0KGmNxRPbAHE8a/a3hWCYzBGrdwimrLRrXaCdX5F6ikBz
         udRoPKJdO5MvENQcqF4UfT7GFuzLIDvWFCElxzrc5ZJ/o7rSkKcPBIRTbjYpH9z9HDyp
         A6TVM2uCy3+yg7GlLmwLvqOKvrVlAkPZ28MZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323750; x=1730928550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcJ6rYdsw1OyRONz4zGVh02ld/8YsK6wUyzfWA/Y9e4=;
        b=sV8Ph8bwmq9aI+cxLmfQckF6dC+e1GIl81ANbUrR0Gf+3vm8umzDiABJNijlncar2m
         a0xknAEkaohiCafzYpdKgpDtt4RSqg/YMOqmw9LtMqVliXEYjfP7BzNF1MdZBR++YsiT
         oULDGTGfVdxYxymILkkw6T9zSbEpwNxggI1X4++nTQG2TQzweEvKGFdxeCBbHfwWyK26
         ri2EgbkkznI85ybA5HQgRyXNJnpcztmre7f61QUgCGTWsOvdmJSb51GAv/UjdZfXQGpS
         YCVjHBEosp/f/YB6ILle2sY3Jjz/weMZyrImjNJY74NnO56lqnjIGUOm+LpHr+wxGKfJ
         D8ng==
X-Forwarded-Encrypted: i=1; AJvYcCXVLc+7djNrqU982ng+jOKDq8bfyWfGGlgTfIcEvWrBvB3K70s+IgqslRsDHqobfKGSAEMlqG2t+SkmsJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjyFufIyDlnHOdCIuFoOgost/hUcDozR/N/aNotuUkJMGZxf9
	xIEndoLvwbT3mhe1V98yqxz7I3i3lMrvijjqy0Cyp2Vt6sVWgWMInm2om+ld2g==
X-Google-Smtp-Source: AGHT+IHxkwiPUzOjIQu7smhe9Fr6RzmKM9yzxhOhZb+U58++hpr/bZMA54sfwCVhxTtriq/TmBMRSA==
X-Received: by 2002:a05:6a21:3984:b0:1d8:a759:524d with SMTP id adf61e73a8af0-1d9a83d60cfmr20785025637.18.1730323750045;
        Wed, 30 Oct 2024 14:29:10 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-720bc2eb76esm76989b3a.154.2024.10.30.14.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:09 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
Date: Wed, 30 Oct 2024 14:28:34 -0700
Message-ID: <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030212854.998318-1-abhishekpandit@chromium.org>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
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

(no changes since v1)

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
index 2f03190a9873..62263f1d3a72 100644
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
index 8380b22d26a7..181892bf1225 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -212,6 +212,7 @@ static const struct typec_altmode_ops tbt_altmode_ops = {
 
 static int tbt_altmode_probe(struct typec_altmode *alt)
 {
+	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct tbt_altmode *tbt;
 
 	tbt = devm_kzalloc(&alt->dev, sizeof(*tbt), GFP_KERNEL);
@@ -226,7 +227,7 @@ static int tbt_altmode_probe(struct typec_altmode *alt)
 	typec_altmode_set_drvdata(alt, tbt);
 	typec_altmode_set_ops(alt, &tbt_altmode_ops);
 
-	if (tbt_ready(alt)) {
+	if (port->auto_enter && tbt_ready(alt)) {
 		if (tbt->plug[TYPEC_PLUG_SOP_PP])
 			tbt->state = TBT_STATE_SOP_PP_ENTER;
 		else if (tbt->plug[TYPEC_PLUG_SOP_P])
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 85494b9f7502..e74f835c6859 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -403,6 +403,31 @@ static ssize_t active_store(struct device *dev, struct device_attribute *attr,
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
@@ -446,6 +471,7 @@ static DEVICE_ATTR_RO(svid);
 
 static struct attribute *typec_altmode_attrs[] = {
 	&dev_attr_active.attr,
+	&dev_attr_auto_enter.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_svid.attr,
 	&dev_attr_vdo.attr,
@@ -461,6 +487,10 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
 		if (!adev->ops || !adev->ops->activate)
 			return 0444;
 
+	if (attr == &dev_attr_auto_enter.attr)
+		if (!is_typec_port(adev->dev.parent))
+			return 0;
+
 	return attr->mode;
 }
 
@@ -564,6 +594,7 @@ typec_register_altmode(struct device *parent,
 	if (is_port) {
 		alt->attrs[3] = &dev_attr_supported_roles.attr;
 		alt->adev.active = true; /* Enabled by default */
+		alt->adev.auto_enter = !desc->no_auto_enter;
 	}
 
 	sprintf(alt->group_name, "mode%d", desc->mode);
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index d616b8807000..5336b7c92ca4 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -139,6 +139,7 @@ int typec_cable_set_identity(struct typec_cable *cable);
  * @svid: Standard or Vendor ID
  * @mode: Index of the Mode
  * @vdo: VDO returned by Discover Modes USB PD command
+ * @no_auto_enter: Only for ports. Disables auto enter which is default behavior.
  * @roles: Only for ports. DRP if the mode is available in both roles
  *
  * Description of an Alternate Mode which a connector, cable plug or partner
@@ -148,6 +149,7 @@ struct typec_altmode_desc {
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
2.47.0.163.g1226f6d8fa-goog


