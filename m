Return-Path: <linux-kernel+bounces-268154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F269420E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D9C1C23505
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2B18CC01;
	Tue, 30 Jul 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpJMeF/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909318991F;
	Tue, 30 Jul 2024 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368632; cv=none; b=AUdeH1tnVP2JJy/b0ZJdRsxGW0iMDBlbZ5MnjZP6dL17I7c7YjsX+ljxPOpvnfKS676rksQtFLEdk2DgKWtvbrLaKZ1VplSyIheQW8E/Fdyb2shbC6D9O/vGpQkccbFKWzBE9jW4QPJ7GKbq5wiMuWFTJF3Qj7lqNwbS7y8UeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368632; c=relaxed/simple;
	bh=VpiOq6EFkVYobmmtpujUtbY2EDrMaIz8r37j6lzSw+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4x1nF7eClviC9ok2e5eBh642kCWqURJ8Aes77MjoZLNwqfl7ZyhGR/9i76iBRlUDgGzFFtmYpLXRua4fcYuSwPbunCPG8GGdwNT/8RBANzxBhGpo0JJgxjj5qFCZ2PakpLUW9FOqtawE+IZXuRkOXeU4iXGafMbFiMXCzJtDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpJMeF/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E84C32782;
	Tue, 30 Jul 2024 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368631;
	bh=VpiOq6EFkVYobmmtpujUtbY2EDrMaIz8r37j6lzSw+0=;
	h=From:To:Cc:Subject:Date:From;
	b=rpJMeF/ai0Ptkcc62zMu9iNiTx+1PkcLaXGYPG/jqz2MLQ/6xcNvnArP68d9H6Iza
	 8EaLLMELqYMvGoTM/tFBuqmiZ6l/e7VWULYXs0OqETS5v6ZZaeiXJwrlvsgASfIF4x
	 hwV9yrw0vz+Vw2Vdq6wXtmpga2Ftvmi7b5pnubZBJMKA0LTjcWv056V7oxUzFpt8t3
	 XTt+OoB5yWhCEs+UVph4NtunG+o7tVIaCS3kWBsRTLXCgELZKyFSJ32lYihYyJVoAT
	 P1sV0ofI642sxteBTn6ErJ1QKqFqrO9Kq+/tSHLEuYiZbZ4dXV0+j/iK7gXHFDAOJ+
	 cRPfd0uUTuy3Q==
From: Michael Walle <mwalle@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] usb: gadget: f_acm: make bInterfaceProtocol configurable
Date: Tue, 30 Jul 2024 21:43:37 +0200
Message-Id: <20240730194337.2583784-1-mwalle@kernel.org>
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
bInterfaceProtocol configurable.

This will also set bFunctionProtocol to the same value, see commit
5c8db070b448 ("USB: Change acm_iad_descriptor bFunctionProtocol to
USB_CDC_ACM_PROTO_AT_V25TER") for more details.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
See the following link for the filter logic:
https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/blob/main/src/mm-filter.c?ref_type=heads#L303
---
 .../ABI/testing/configfs-usb-gadget-acm       |  7 +++
 drivers/usb/gadget/function/f_acm.c           | 50 ++++++++++++++++++-
 drivers/usb/gadget/function/u_serial.h        |  4 ++
 3 files changed, 59 insertions(+), 2 deletions(-)

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
index 724b2631f249..b78f46586a0f 100644
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
+	opts->refcnt--;
+	mutex_unlock(&opts->lock);
 }
 
 static void acm_resume(struct usb_function *f)
@@ -761,7 +771,11 @@ static struct usb_function *acm_alloc_func(struct usb_function_instance *fi)
 	acm->port.func.disable = acm_disable;
 
 	opts = container_of(fi, struct f_serial_opts, func_inst);
+	mutex_lock(&opts->lock);
 	acm->port_num = opts->port_num;
+	acm->bInterfaceProtocol = opts->protocol;
+	opts->refcnt++;
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
+	if (opts->refcnt) {
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
 
@@ -843,6 +888,7 @@ static struct usb_function_instance *acm_alloc_instance(void)
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
+	opts->protocol = USB_CDC_ACM_PROTO_AT_V25TER;
 	opts->func_inst.free_func_inst = acm_free_instance;
 	ret = gserial_alloc_line(&opts->port_num);
 	if (ret) {
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index 901d99310bc4..1782d7d7f7be 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -17,6 +17,10 @@
 struct f_serial_opts {
 	struct usb_function_instance func_inst;
 	u8 port_num;
+	u8 protocol;
+
+	struct mutex lock;
+	int refcnt;
 };
 
 /*
-- 
2.39.2


