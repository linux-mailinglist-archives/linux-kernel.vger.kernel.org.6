Return-Path: <linux-kernel+bounces-300513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB195E4A3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83A01C208EA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40E16B385;
	Sun, 25 Aug 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1hjOthV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB98C07;
	Sun, 25 Aug 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609098; cv=none; b=VJpQLKq94KDOiMRt82TMJMi7mfwIB8sHxdeDXdz4zGkYOKEDnlS6JI5KVcPzUWQTv012wGD0KCtyvDAuBN/wM/wkzTKudSyny/y3nEoY5QY2ZFxN8QxOGERSzbAB8VInhssxUXFUHN7S0RiztQmEQ38N9xfFBUKkF6Pb2Y9OQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609098; c=relaxed/simple;
	bh=0lZDn9YR+LNnYGFzzSd9xXOiSOo0EKcuD0+7KcpicHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXkHJ/xDTa8fjZ93ahJtb8RV2XdLt7ktx4MuXZY8Q1t8Qm5k2c9RzuCln5GdXLCCgAOj4JJ8c8E4VuhFOL8zDNeOojzhrTX951R9H33Issm5pAI/NX/Bfxh74qQAVhrnq56Zns96K7GR1LFpDi7HMwKF6XDGlzUXxAE4cVa+8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1hjOthV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB3AC32782;
	Sun, 25 Aug 2024 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724609097;
	bh=0lZDn9YR+LNnYGFzzSd9xXOiSOo0EKcuD0+7KcpicHc=;
	h=From:To:Cc:Subject:Date:From;
	b=m1hjOthVq1zs7WCdV/55LphSJ2sSwBkgHTyl+6ucsaddoyZE6F9qG5oNb9IbH+2Wd
	 0VJmv9NRM5h0ki9E1YNkB5SJblqYlyWJDbXhmxiqQtjEuHXaP9pa4iYqaMRaVxeKo2
	 +yT+Rmt3KV/E4Gj0TlMSYxC4seatH6NpNqyJCMuSJzoJI/EG2N4K3mkvGjJRj4GFA7
	 eRhozCj5n+nIzJw4npbzmSGQJfUHCO4Wb5wzkpIku0tdkeHymOMa9puRwiV1xukJ9A
	 Uwc29pFUYzjJNhghlkjLl1a4SW5y7bkqY3/oMjNe9S3nPMc6aAyHk5k7T3uEFljL4G
	 wT6UcqmeLRmDA==
From: Michael Walle <mwalle@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2] usb: gadget: f_acm: make bInterfaceProtocol configurable
Date: Sun, 25 Aug 2024 20:04:46 +0200
Message-Id: <20240825180446.3757073-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bInterfaceProtocol is hardcoded to USB_CDC_ACM_PROTO_AT_V25TER. This
will lead to problems with ModemManger which will gladly try to probe
that port as a modem if the gadget also has a network function.
ModemManager will try to send AT commands to the ACM port. Make the
bInterfaceProtocol configurable. For this, track the number of instances
and only allow write to the property if there are no intances (yet).

This will also set bFunctionProtocol to the same value, see commit
5c8db070b448 ("USB: Change acm_iad_descriptor bFunctionProtocol to
USB_CDC_ACM_PROTO_AT_V25TER") for more details.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
See the following link for the filter logic:
https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/blob/main/src/mm-filter.c?ref_type=heads#L303

v2:
 - rename refcnt to instances
 - add a comment what the mutex will protect
 - mention the intention of "instances" in the commit message

---
 .../ABI/testing/configfs-usb-gadget-acm       |  7 +++
 drivers/usb/gadget/function/f_acm.c           | 52 ++++++++++++++++++-
 drivers/usb/gadget/function/u_serial.h        |  4 ++
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-acm b/Documentation/ABI/testing/configfs-usb-gadget-acm
index d21092d75a05..25e68be9eb66 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-acm
+++ b/Documentation/ABI/testing/configfs-usb-gadget-acm
@@ -6,3 +6,10 @@ Description:
 		This item contains just one readonly attribute: port_num.
 		It contains the port number of the /dev/ttyGS<n> device
 		associated with acm function's instance "name".
+
+What:		/config/usb-gadget/gadget/functions/acm.name/protocol
+Date:		Aug 2024
+KernelVersion:	6.13
+Description:
+		Reported bInterfaceProtocol for the ACM device. For legacy
+		reasons, this defaults to 1 (USB_CDC_ACM_PROTO_AT_V25TER).
diff --git a/drivers/usb/gadget/function/f_acm.c b/drivers/usb/gadget/function/f_acm.c
index 724b2631f249..7061720b9732 100644
--- a/drivers/usb/gadget/function/f_acm.c
+++ b/drivers/usb/gadget/function/f_acm.c
@@ -41,6 +41,7 @@ struct f_acm {
 	struct gserial			port;
 	u8				ctrl_id, data_id;
 	u8				port_num;
+	u8				bInterfaceProtocol;
 
 	u8				pending;
 
@@ -89,7 +90,7 @@ acm_iad_descriptor = {
 	.bInterfaceCount = 	2,	// control + data
 	.bFunctionClass =	USB_CLASS_COMM,
 	.bFunctionSubClass =	USB_CDC_SUBCLASS_ACM,
-	.bFunctionProtocol =	USB_CDC_ACM_PROTO_AT_V25TER,
+	/* .bFunctionProtocol = DYNAMIC */
 	/* .iFunction =		DYNAMIC */
 };
 
@@ -101,7 +102,7 @@ static struct usb_interface_descriptor acm_control_interface_desc = {
 	.bNumEndpoints =	1,
 	.bInterfaceClass =	USB_CLASS_COMM,
 	.bInterfaceSubClass =	USB_CDC_SUBCLASS_ACM,
-	.bInterfaceProtocol =	USB_CDC_ACM_PROTO_AT_V25TER,
+	/* .bInterfaceProtocol = DYNAMIC */
 	/* .iInterface = DYNAMIC */
 };
 
@@ -663,6 +664,9 @@ acm_bind(struct usb_configuration *c, struct usb_function *f)
 		goto fail;
 	acm->notify = ep;
 
+	acm_iad_descriptor.bFunctionProtocol = acm->bInterfaceProtocol;
+	acm_control_interface_desc.bInterfaceProtocol = acm->bInterfaceProtocol;
+
 	/* allocate notification */
 	acm->notify_req = gs_alloc_req(ep,
 			sizeof(struct usb_cdc_notification) + 2,
@@ -719,8 +723,14 @@ static void acm_unbind(struct usb_configuration *c, struct usb_function *f)
 static void acm_free_func(struct usb_function *f)
 {
 	struct f_acm		*acm = func_to_acm(f);
+	struct f_serial_opts	*opts;
+
+	opts = container_of(f->fi, struct f_serial_opts, func_inst);
 
 	kfree(acm);
+	mutex_lock(&opts->lock);
+	opts->instances--;
+	mutex_unlock(&opts->lock);
 }
 
 static void acm_resume(struct usb_function *f)
@@ -761,7 +771,11 @@ static struct usb_function *acm_alloc_func(struct usb_function_instance *fi)
 	acm->port.func.disable = acm_disable;
 
 	opts = container_of(fi, struct f_serial_opts, func_inst);
+	mutex_lock(&opts->lock);
 	acm->port_num = opts->port_num;
+	acm->bInterfaceProtocol = opts->protocol;
+	opts->instances++;
+	mutex_unlock(&opts->lock);
 	acm->port.func.unbind = acm_unbind;
 	acm->port.func.free_func = acm_free_func;
 	acm->port.func.resume = acm_resume;
@@ -812,11 +826,42 @@ static ssize_t f_acm_port_num_show(struct config_item *item, char *page)
 
 CONFIGFS_ATTR_RO(f_acm_, port_num);
 
+static ssize_t f_acm_protocol_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%u\n", to_f_serial_opts(item)->protocol);
+}
+
+static ssize_t f_acm_protocol_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct f_serial_opts *opts = to_f_serial_opts(item);
+	int ret;
+
+	mutex_lock(&opts->lock);
+
+	if (opts->instances) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = kstrtou8(page, 0, &opts->protocol);
+	if (ret)
+		goto out;
+	ret = count;
+
+out:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(f_acm_, protocol);
+
 static struct configfs_attribute *acm_attrs[] = {
 #ifdef CONFIG_U_SERIAL_CONSOLE
 	&f_acm_attr_console,
 #endif
 	&f_acm_attr_port_num,
+	&f_acm_attr_protocol,
 	NULL,
 };
 
@@ -832,6 +877,7 @@ static void acm_free_instance(struct usb_function_instance *fi)
 
 	opts = container_of(fi, struct f_serial_opts, func_inst);
 	gserial_free_line(opts->port_num);
+	mutex_destroy(&opts->lock);
 	kfree(opts);
 }
 
@@ -843,7 +889,9 @@ static struct usb_function_instance *acm_alloc_instance(void)
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
+	opts->protocol = USB_CDC_ACM_PROTO_AT_V25TER;
 	opts->func_inst.free_func_inst = acm_free_instance;
+	mutex_init(&opts->lock);
 	ret = gserial_alloc_line(&opts->port_num);
 	if (ret) {
 		kfree(opts);
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index 901d99310bc4..e1274338ea61 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -17,6 +17,10 @@
 struct f_serial_opts {
 	struct usb_function_instance func_inst;
 	u8 port_num;
+	u8 protocol;
+
+	struct mutex lock; /* protect instances */
+	int instances;
 };
 
 /*
-- 
2.39.2


