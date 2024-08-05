Return-Path: <linux-kernel+bounces-274046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9179471E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9726AB20AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 00:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4493F1C36;
	Mon,  5 Aug 2024 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWUmon6G"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC019E;
	Mon,  5 Aug 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722816955; cv=none; b=JyIIfLUeEMT2cKPEnd0MEx739bLhySK4kNlmyP+bfonAVX0ysFKgUzPmO9AijoVsF8Bvy6/KaB2uS+dD7ncuf1kldUOpM7NTYbpP6BvlbTyb1wLazuv6Pv5YU1ehAqJlIzOlgyQdBZ1tFgQ+ZYZ0n7M3S5S3vjEeEuRq6N7sqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722816955; c=relaxed/simple;
	bh=gz0B23fUUHPjcaUv2MaGLIyA3vGJZuK0je8BcordKDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/VkG1GIN+aZjNNV5RvR4ilPqT+sz03uIpmUETSzANwEeOYRCKAFFmXz1kx5TX/IQYAI7V3A+9V9AUrewcDbd/PGYQ6DxEXwj8duiCiYr0YOVa70yRmZbNjeiOor1xU1ufk1i9bvfUsii0NWN1u2ZIk9lhZMwa5PfVuxZ+US0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWUmon6G; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b79b93a4c9so43528986d6.1;
        Sun, 04 Aug 2024 17:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722816952; x=1723421752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhLN8uECkwRqPw38h8IiXspwBGvbvvcothYP3DCCl3I=;
        b=IWUmon6GpbHi61fim8Sar0VmX+iy/KZVUpc5tinM84jcHB7Xbe06lE0aigOQjQG04q
         /rcoEwQnMX3/tAX10OmqOKHiHHeOU2YCUwJywy3UD48Z/HdV5GQowLCgNJwxS5cA5di8
         zRp+R42PcJqqiBrfteMHWyPU+WVc0EhmvROAEYsT9SfuJm+6SPV5aPtPdKXoqxjjN0M0
         8s1bYYQWLopsZLLt7ZsVw6FcUmbUYviezEROvFG3bc/K0eV2AfmpofxAqdhdDN4Ks1pI
         6Sbf0+lb6CE58qstZkmfac7JHZ1wWNkMw9+WuBDYEebp3agqyRFDZbK7eyv0kkufHE84
         1Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722816952; x=1723421752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhLN8uECkwRqPw38h8IiXspwBGvbvvcothYP3DCCl3I=;
        b=QE6yL18iiBWvPERfagIVCro/16qHMLKZa3OuIGiD/VwZN2pluxH2bZbBTtBcUpyzKk
         mcK2jZoP5dpLqMqEC60ybRdwJHTCKSPxjx5NaG/xSzT0pdIcnsQ5Q9Nx5dwo48K3nEMl
         kjaFP2EMG2d7PiJ397N9EbFq49qUQPoAEYLsTNgf4UVCuvYZM8ey0j67a3lid6S+lvZM
         3vTMB+aAlxqTZyith/9qxfb9kRAgjERPZAjJhsAsQ/FcIBt5FBzwui6Q6GQVHnts+MCt
         T0747hJX4foVrT1TaBVaqG0t8/NX0qKng6fm/ti0S+mN8Xu4lbng5d3EH2yHGdLAAkqC
         QfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVIoKwwXt8Cwtw1e7CLeo6EPMlG10Gh2DvSfkKKasab9/5dlICL6HUkvVnnzetxNyY6N6MgwXrE7KbkvlIVSDszEy4zVfOi7IBnPjWxoN5UGHf2h8J7vWFx0NE47VTfdsfJkX51EHr4
X-Gm-Message-State: AOJu0YxtZzfz7/xXn4s6tL5E5xJqsiAJJWQGXPv+DHdEEaLWGN6RoNjJ
	YqHwYl8r4LWyXeHWiXisOkEoKT4ky6jjTZ1cM5x0zTK70mOYLQlTW+zTLdAP
X-Google-Smtp-Source: AGHT+IHV//JZnLnfAkG9TIXs7r0sGd1uERG/Gt6dMxAlFjf98bEx76Y6b/QfXwJsn7EyngIu3ZwJLw==
X-Received: by 2002:a05:6214:2af:b0:6b5:2062:dd5c with SMTP id 6a1803df08f44-6bb91d619e2mr218884426d6.8.1722816951888;
        Sun, 04 Aug 2024 17:15:51 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76b93asm30041276d6.28.2024.08.04.17.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 17:15:51 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Cercueil <paul@crapouillou.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jeff Layton <jlayton@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sands <david.sands@biamp.com>,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH v4] usb: gadget: f_fs: add capability for dfu run-time descriptor
Date: Sun,  4 Aug 2024 20:06:40 -0400
Message-ID: <20240805000639.619232-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sands <david.sands@biamp.com>

From: David Sands <david.sands@biamp.com>

Add the ability for FunctionFS driver to be able to create DFU Run-Time
descriptors.

Signed-off-by: David Sands <david.sands@biamp.com>
Co-developed-by: Chris Wulff <crwulff@gmail.com>
Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
v4: Clean up unneeded change, switch to BIT macros, more documentation
v3: Documentation, additional constants and constant order fixed
https://lore.kernel.org/all/CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com/
v2: https://lore.kernel.org/linux-usb/CO1PR17MB54198D086B61F7392FA9075FE10E2@CO1PR17MB5419.namprd17.prod.outlook.com/
v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419AC3907C74E28D80C5021E1082@CO1PR17MB5419.namprd17.prod.outlook.com/
---
 Documentation/usb/functionfs-desc.rst | 22 ++++++++++++++++++++++
 Documentation/usb/functionfs.rst      |  2 ++
 Documentation/usb/index.rst           |  1 +
 drivers/usb/gadget/function/f_fs.c    | 12 ++++++++++--
 include/uapi/linux/usb/ch9.h          |  8 ++++++--
 include/uapi/linux/usb/functionfs.h   | 25 +++++++++++++++++++++++++
 6 files changed, 66 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/usb/functionfs-desc.rst

diff --git a/Documentation/usb/functionfs-desc.rst b/Documentation/usb/functionfs-desc.rst
new file mode 100644
index 000000000000..73d2b8a3f02c
--- /dev/null
+++ b/Documentation/usb/functionfs-desc.rst
@@ -0,0 +1,22 @@
+======================
+FunctionFS Descriptors
+======================
+
+Interface Descriptors
+---------------------
+
+Standard USB interface descriptors may be added. The class/subclass of the
+most recent interface descriptor determines what type of class-specific
+descriptors are accepted.
+
+Class-Specific Descriptors
+--------------------------
+
+DFU Functional Descriptor
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When the interface class is USB_CLASS_APP_SPEC and  the interface subclass
+is USB_SUBCLASS_DFU, a DFU functional descriptor can be provided.
+
+.. kernel-doc:: include/uapi/linux/usb/functionfs.h
+   :doc: usb_dfu_functional_descriptor
diff --git a/Documentation/usb/functionfs.rst b/Documentation/usb/functionfs.rst
index d05a775bc45b..4f96e4b93d7b 100644
--- a/Documentation/usb/functionfs.rst
+++ b/Documentation/usb/functionfs.rst
@@ -70,6 +70,8 @@ have been written to their ep0's.
 Conversely, the gadget is unregistered after the first USB function
 closes its endpoints.
 
+For more information about FunctionFS descriptors see :doc:`functionfs-desc`
+
 DMABUF interface
 ================
 
diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
index 27955dad95e1..826492c813ac 100644
--- a/Documentation/usb/index.rst
+++ b/Documentation/usb/index.rst
@@ -11,6 +11,7 @@ USB support
     dwc3
     ehci
     functionfs
+    functionfs-desc
     gadget_configfs
     gadget_hid
     gadget_multi
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index d8b096859337..ba5c6e4827ba 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2478,7 +2478,7 @@ typedef int (*ffs_os_desc_callback)(enum ffs_os_desc_type entity,
 
 static int __must_check ffs_do_single_desc(char *data, unsigned len,
 					   ffs_entity_callback entity,
-					   void *priv, int *current_class)
+					   void *priv, int *current_class, int *current_subclass)
 {
 	struct usb_descriptor_header *_ds = (void *)data;
 	u8 length;
@@ -2535,6 +2535,7 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 		if (ds->iInterface)
 			__entity(STRING, ds->iInterface);
 		*current_class = ds->bInterfaceClass;
+		*current_subclass = ds->bInterfaceSubClass;
 	}
 		break;
 
@@ -2559,6 +2560,12 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 			if (length != sizeof(struct ccid_descriptor))
 				goto inv_length;
 			break;
+		} else if (*current_class == USB_CLASS_APP_SPEC &&
+			   *current_subclass == USB_SUBCLASS_DFU) {
+			pr_vdebug("dfu functional descriptor\n");
+			if (length != sizeof(struct usb_dfu_functional_descriptor))
+				goto inv_length;
+			break;
 		} else {
 			pr_vdebug("unknown descriptor: %d for class %d\n",
 			      _ds->bDescriptorType, *current_class);
@@ -2621,6 +2628,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 	const unsigned _len = len;
 	unsigned long num = 0;
 	int current_class = -1;
+	int current_subclass = -1;
 
 	for (;;) {
 		int ret;
@@ -2640,7 +2648,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 			return _len - len;
 
 		ret = ffs_do_single_desc(data, len, entity, priv,
-			&current_class);
+			&current_class, &current_subclass);
 		if (ret < 0) {
 			pr_debug("%s returns %d\n", __func__, ret);
 			return ret;
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 44d73ba8788d..91f0f7e214a5 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -254,6 +254,9 @@ struct usb_ctrlrequest {
 #define USB_DT_DEVICE_CAPABILITY	0x10
 #define USB_DT_WIRELESS_ENDPOINT_COMP	0x11
 #define USB_DT_WIRE_ADAPTER		0x21
+/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
+#define USB_DT_DFU_FUNCTIONAL		0x21
+/* these are from the Wireless USB spec */
 #define USB_DT_RPIPE			0x22
 #define USB_DT_CS_RADIO_CONTROL		0x23
 /* From the T10 UAS specification */
@@ -329,9 +332,10 @@ struct usb_device_descriptor {
 #define USB_CLASS_USB_TYPE_C_BRIDGE	0x12
 #define USB_CLASS_MISC			0xef
 #define USB_CLASS_APP_SPEC		0xfe
-#define USB_CLASS_VENDOR_SPEC		0xff
+#define USB_SUBCLASS_DFU			0x01
 
-#define USB_SUBCLASS_VENDOR_SPEC	0xff
+#define USB_CLASS_VENDOR_SPEC		0xff
+#define USB_SUBCLASS_VENDOR_SPEC		0xff
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/uapi/linux/usb/functionfs.h b/include/uapi/linux/usb/functionfs.h
index 9f88de9c3d66..40f87cbabf7a 100644
--- a/include/uapi/linux/usb/functionfs.h
+++ b/include/uapi/linux/usb/functionfs.h
@@ -37,6 +37,31 @@ struct usb_endpoint_descriptor_no_audio {
 	__u8  bInterval;
 } __attribute__((packed));
 
+/**
+ * struct usb_dfu_functional_descriptor - DFU Functional descriptor
+ * @bLength:		Size of the descriptor (bytes)
+ * @bDescriptorType:	USB_DT_DFU_FUNCTIONAL
+ * @bmAttributes:	DFU attributes
+ * @wDetachTimeOut:	Maximum time to wait after DFU_DETACH (ms, le16)
+ * @wTransferSize:	Maximum number of bytes per control-write (le16)
+ * @bcdDFUVersion:	DFU Spec version (BCD, le16)
+ */
+struct usb_dfu_functional_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bmAttributes;
+	__le16 wDetachTimeOut;
+	__le16 wTransferSize;
+	__le16 bcdDFUVersion;
+} __attribute__ ((packed));
+
+/* from DFU functional descriptor bmAttributes */
+#define DFU_FUNC_ATT_CAN_DOWNLOAD	BIT(0)
+#define DFU_FUNC_ATT_CAN_UPLOAD		BIT(1)
+#define DFU_FUNC_ATT_MANIFEST_TOLERANT	BIT(2)
+#define DFU_FUNC_ATT_WILL_DETACH	BIT(3)
+
+
 struct usb_functionfs_descs_head_v2 {
 	__le32 magic;
 	__le32 length;
-- 
2.43.0


