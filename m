Return-Path: <linux-kernel+bounces-282062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB894DF49
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A732A2816DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAB44C66;
	Sun, 11 Aug 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUF8AxXh"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F436B;
	Sun, 11 Aug 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723334535; cv=none; b=fQzhhjapJU4KUYG0f1YyrNpXKXJBZhQL5NwUFbruYPmhIyQCloRqPkrGIpdKXXrQWFZR1ujUszGB9d1aAUF5fOviwd5zza3n+FRHs0phHFWsE8jGoVPeuZz4J9cNPLOZNtb7WdOPgQjTYG5zJMUKJsx+kt4rGB1uOICGxbAN4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723334535; c=relaxed/simple;
	bh=Fc1MI3uzcEs/lkc9eCR9uPpqLTtdg3/44WIVOdwaWLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bw6bSrVm80kRTlaymGZVfDKKda/zhmNHGfBCt0JC/e9LVOzb84m/1D/JixVLfFro7Dt+3UvFuX5Ojs9YxFGNY0kGm1FLqCwgBSKVvqPGpiRvO42N1PIGyZ9BJbJHg5H0mqpPG+TCy1TEzQVxySuEdHKny+dtHfEFLquBEc6J9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUF8AxXh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1da036d35so213307485a.0;
        Sat, 10 Aug 2024 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723334532; x=1723939332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4RpNyGhY0Mvr/9Yex043xHAZDyACS5R17GBWVQgLcM=;
        b=gUF8AxXhUzdQOQ/re+iTL5ihxyzZiGOSafpAvSMcTrcrnY4mATryf5s43IYQBzMqGg
         KAA1JACcEKtoo5XTn2cF0GFwiJWhsQ/vPDDuplIArycTrKHLbluxZdG6vMTJH7LXfnyg
         j5KxZLUTCesOEdWc29dY8oo1LRN37xG+BgkK2p9csxQdjg94rAWMo4mzokfaKLylvxyP
         PXlchsWJhQAsyQ02uRqxLphxqYsaYX8KcZao9jsUYQHQla2CyayZf4FMzvxtFaCwjyoj
         1BRTCknEuNtQXXl0r6j1Ssx3exoJkdmKeBPt0mwFiuuBsSMiyiU9mkW3yHljCZ2yb7bN
         PD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723334532; x=1723939332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4RpNyGhY0Mvr/9Yex043xHAZDyACS5R17GBWVQgLcM=;
        b=Z1wSh2wWMv54hfQbwJHM5uTjuUaxLUyt9wnLZlfaU7L34O5cuoAbG2C9Cfvcmu/7VQ
         NZGnGSs48ZGJzCncygTREoDh7tUF7dLE8KADrPF/r+/Z+7zgXrrS8ychhH/nul4YkftF
         pt3zKQVVnoNGz1WIOlX/PgFU3AsfNPuLc9e7FJBuyFcfvYy/yC+hOhIeS9V5z5fQWz2E
         CxuW5rhNq+28MfNTFuEXgdXloUer+ZmqzUkZVPdUpQzvZXGiyzw+St8VnUK8OCvJ4FIK
         oxWSyFZYGWR9yO+XK/YvCC5gprtTBmVsiUHbgugGl4Y9CvuplusWPADA0dre6PnDvzsb
         GZPg==
X-Forwarded-Encrypted: i=1; AJvYcCUlwMgIIuKkUjMCCyfW5//y4Evu4IFrqIDKX1LJErNmQsCrK8okKVsVEknQRgOnRRpRRUs1b74s37zjJeDSY4VyXCcd8uKrxlXcwlQHduGzQ58bdnA7A8xRCQdciCEtvoiVyY42tD7u
X-Gm-Message-State: AOJu0YzHGk6ZZZ93jVFOW53NIOvX+Oe/+Q81/VUm5fbMBffAeLzhs0u8
	9GFFHpw1vhWDRxYY5SiJr7m2Q/3wXRyD43xw/UcLxRpztwMPAA0WN2ph4BDq
X-Google-Smtp-Source: AGHT+IFNVcHYslRmgU+23Qcp/0y0ZU6U6+71Hs3JAXb7CrHpx1QGZUw+waSJreV6+r0dcx5oIuE+gA==
X-Received: by 2002:a05:620a:4014:b0:7a3:5fa3:328 with SMTP id af79cd13be357-7a4c182be74mr718322885a.54.1723334531356;
        Sat, 10 Aug 2024 17:02:11 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e0ddfasm106531685a.126.2024.08.10.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 17:02:10 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Cercueil <paul@crapouillou.net>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sands <david.sands@biamp.com>,
	Chris Wulff <crwulff@gmail.com>
Subject: [PATCH v5] usb: gadget: f_fs: add capability for dfu functional descriptor
Date: Sat, 10 Aug 2024 20:00:05 -0400
Message-ID: <20240811000004.1395888-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sands <david.sands@biamp.com>

Add the ability for the USB FunctionFS (FFS) gadget driver to be able
to create Device Firmware Upgrade (DFU) functional descriptors. [1]

This patch allows implementation of DFU in userspace using the
FFS gadget. The DFU protocol uses the control pipe (ep0) for all
messaging so only the addition of the DFU functional descriptor
is needed in the kernel driver.

The DFU functional descriptor is written to the ep0 file along with
any other descriptors during FFS setup. DFU requires an interface
descriptor followed by the DFU functional descriptor.

This patch includes documentation of the added descriptor for DFU
and conversion of some existing documentation to kernel-doc format
so that it can be included in the generated docs.

An implementation of DFU 1.1 that implements just the runtime descriptor
using the FunctionFS gadget (with rebooting into u-boot for DFU mode)
has been tested on an i.MX8 Nano.

An implementation of DFU 1.1 that implements both runtime and DFU mode
using the FunctionFS gadget has been tested on Xilinx Zynq UltraScale+.
Note that for the best performance of firmware update file transfers, the
userspace program should respond as quick as possible to the setup packets.

[1] https://www.usb.org/sites/default/files/DFU_1.1.pdf

Signed-off-by: David Sands <david.sands@biamp.com>
Co-developed-by: Chris Wulff <crwulff@gmail.com>
Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
v5: More documentation, expanded commit message, corrected to _BITUL
v4: Clean up unneeded change, switch to BIT macros, more documentation
https://lore.kernel.org/all/20240805000639.619232-2-crwulff@gmail.com/
v3: Documentation, additional constants and constant order fixed
https://lore.kernel.org/all/CO1PR17MB54197F118CBC8783D289B97DE1102@CO1PR17MB5419.namprd17.prod.outlook.com/
v2: https://lore.kernel.org/linux-usb/CO1PR17MB54198D086B61F7392FA9075FE10E2@CO1PR17MB5419.namprd17.prod.outlook.com/
v1: https://lore.kernel.org/linux-usb/CO1PR17MB5419AC3907C74E28D80C5021E1082@CO1PR17MB5419.namprd17.prod.outlook.com/
---
 Documentation/usb/functionfs-desc.rst | 39 +++++++++++
 Documentation/usb/functionfs.rst      |  2 +
 Documentation/usb/index.rst           |  1 +
 drivers/usb/gadget/function/f_fs.c    | 12 +++-
 include/uapi/linux/usb/ch9.h          |  8 ++-
 include/uapi/linux/usb/functionfs.h   | 97 ++++++++++++++++++++++++---
 6 files changed, 147 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/usb/functionfs-desc.rst

diff --git a/Documentation/usb/functionfs-desc.rst b/Documentation/usb/functionfs-desc.rst
new file mode 100644
index 000000000000..39649774da54
--- /dev/null
+++ b/Documentation/usb/functionfs-desc.rst
@@ -0,0 +1,39 @@
+======================
+FunctionFS Descriptors
+======================
+
+Some of the descriptors that can be written to the FFS gadget are
+described below. Device and configuration descriptors are handled
+by the composite gadget and are not written by the user to the
+FFS gadget.
+
+Descriptors are written to the "ep0" file in the FFS gadget
+following the descriptor header.
+
+.. kernel-doc:: include/uapi/linux/usb/functionfs.h
+   :doc: descriptors
+
+Interface Descriptors
+---------------------
+
+Standard USB interface descriptors may be written. The class/subclass of the
+most recent interface descriptor determines what type of class-specific
+descriptors are accepted.
+
+Class-Specific Descriptors
+--------------------------
+
+Class-specific descriptors are accepted only for the class/subclass of the
+most recent interface descriptor. The following are some of the
+class-specific descriptors that are supported.
+
+DFU Functional Descriptor
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When the interface class is USB_CLASS_APP_SPEC and the interface subclass
+is USB_SUBCLASS_DFU, a DFU functional descriptor can be provided.
+The DFU functional descriptor is a described in the USB specification for
+Device Firmware Upgrade (DFU), version 1.1 as of this writing.
+
+.. kernel-doc:: include/uapi/linux/usb/functionfs.h
+   :doc: usb_dfu_functional_descriptor
diff --git a/Documentation/usb/functionfs.rst b/Documentation/usb/functionfs.rst
index d05a775bc45b..f7487b0d8057 100644
--- a/Documentation/usb/functionfs.rst
+++ b/Documentation/usb/functionfs.rst
@@ -25,6 +25,8 @@ interface numbers starting from zero).  The FunctionFS changes
 them as needed also handling situation when numbers differ in
 different configurations.
 
+For more information about FunctionFS descriptors see :doc:`functionfs-desc`
+
 When descriptors and strings are written "ep#" files appear
 (one for each declared endpoint) which handle communication on
 a single endpoint.  Again, FunctionFS takes care of the real
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
index 9f88de9c3d66..2ebdba111a8f 100644
--- a/include/uapi/linux/usb/functionfs.h
+++ b/include/uapi/linux/usb/functionfs.h
@@ -3,6 +3,7 @@
 #define _UAPI__LINUX_FUNCTIONFS_H__
 
 
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
@@ -37,6 +38,31 @@ struct usb_endpoint_descriptor_no_audio {
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
+#define DFU_FUNC_ATT_CAN_DOWNLOAD	_BITUL(0)
+#define DFU_FUNC_ATT_CAN_UPLOAD		_BITUL(1)
+#define DFU_FUNC_ATT_MANIFEST_TOLERANT	_BITUL(2)
+#define DFU_FUNC_ATT_WILL_DETACH	_BITUL(3)
+
+
 struct usb_functionfs_descs_head_v2 {
 	__le32 magic;
 	__le32 length;
@@ -104,23 +130,38 @@ struct usb_ffs_dmabuf_transfer_req {
 
 #ifndef __KERNEL__
 
-/*
+/**
+ * DOC: descriptors
+ *
  * Descriptors format:
  *
+ * +-----+-----------+--------------+--------------------------------------+
  * | off | name      | type         | description                          |
- * |-----+-----------+--------------+--------------------------------------|
+ * +-----+-----------+--------------+--------------------------------------+
  * |   0 | magic     | LE32         | FUNCTIONFS_DESCRIPTORS_MAGIC_V2      |
+ * +-----+-----------+--------------+--------------------------------------+
  * |   4 | length    | LE32         | length of the whole data chunk       |
+ * +-----+-----------+--------------+--------------------------------------+
  * |   8 | flags     | LE32         | combination of functionfs_flags      |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | eventfd   | LE32         | eventfd file descriptor              |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | fs_count  | LE32         | number of full-speed descriptors     |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | hs_count  | LE32         | number of high-speed descriptors     |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | ss_count  | LE32         | number of super-speed descriptors    |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | os_count  | LE32         | number of MS OS descriptors          |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | fs_descrs | Descriptor[] | list of full-speed descriptors       |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | hs_descrs | Descriptor[] | list of high-speed descriptors       |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | ss_descrs | Descriptor[] | list of super-speed descriptors      |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | os_descrs | OSDesc[]     | list of MS OS descriptors            |
+ * +-----+-----------+--------------+--------------------------------------+
  *
  * Depending on which flags are set, various fields may be missing in the
  * structure.  Any flags that are not recognised cause the whole block to be
@@ -128,71 +169,111 @@ struct usb_ffs_dmabuf_transfer_req {
  *
  * Legacy descriptors format (deprecated as of 3.14):
  *
+ * +-----+-----------+--------------+--------------------------------------+
  * | off | name      | type         | description                          |
- * |-----+-----------+--------------+--------------------------------------|
+ * +-----+-----------+--------------+--------------------------------------+
  * |   0 | magic     | LE32         | FUNCTIONFS_DESCRIPTORS_MAGIC         |
+ * +-----+-----------+--------------+--------------------------------------+
  * |   4 | length    | LE32         | length of the whole data chunk       |
+ * +-----+-----------+--------------+--------------------------------------+
  * |   8 | fs_count  | LE32         | number of full-speed descriptors     |
+ * +-----+-----------+--------------+--------------------------------------+
  * |  12 | hs_count  | LE32         | number of high-speed descriptors     |
+ * +-----+-----------+--------------+--------------------------------------+
  * |  16 | fs_descrs | Descriptor[] | list of full-speed descriptors       |
+ * +-----+-----------+--------------+--------------------------------------+
  * |     | hs_descrs | Descriptor[] | list of high-speed descriptors       |
+ * +-----+-----------+--------------+--------------------------------------+
  *
  * All numbers must be in little endian order.
  *
  * Descriptor[] is an array of valid USB descriptors which have the following
  * format:
  *
+ * +-----+-----------------+------+--------------------------+
  * | off | name            | type | description              |
- * |-----+-----------------+------+--------------------------|
+ * +-----+-----------------+------+--------------------------+
  * |   0 | bLength         | U8   | length of the descriptor |
+ * +-----+-----------------+------+--------------------------+
  * |   1 | bDescriptorType | U8   | descriptor type          |
+ * +-----+-----------------+------+--------------------------+
  * |   2 | payload         |      | descriptor's payload     |
+ * +-----+-----------------+------+--------------------------+
  *
  * OSDesc[] is an array of valid MS OS Feature Descriptors which have one of
  * the following formats:
  *
+ * +-----+-----------------+------+--------------------------+
  * | off | name            | type | description              |
- * |-----+-----------------+------+--------------------------|
+ * +-----+-----------------+------+--------------------------+
  * |   0 | inteface        | U8   | related interface number |
+ * +-----+-----------------+------+--------------------------+
  * |   1 | dwLength        | U32  | length of the descriptor |
+ * +-----+-----------------+------+--------------------------+
  * |   5 | bcdVersion      | U16  | currently supported: 1   |
+ * +-----+-----------------+------+--------------------------+
  * |   7 | wIndex          | U16  | currently supported: 4   |
+ * +-----+-----------------+------+--------------------------+
  * |   9 | bCount          | U8   | number of ext. compat.   |
+ * +-----+-----------------+------+--------------------------+
  * |  10 | Reserved        | U8   | 0                        |
+ * +-----+-----------------+------+--------------------------+
  * |  11 | ExtCompat[]     |      | list of ext. compat. d.  |
+ * +-----+-----------------+------+--------------------------+
  *
+ * +-----+-----------------+------+--------------------------+
  * | off | name            | type | description              |
- * |-----+-----------------+------+--------------------------|
+ * +-----+-----------------+------+--------------------------+
  * |   0 | inteface        | U8   | related interface number |
+ * +-----+-----------------+------+--------------------------+
  * |   1 | dwLength        | U32  | length of the descriptor |
+ * +-----+-----------------+------+--------------------------+
  * |   5 | bcdVersion      | U16  | currently supported: 1   |
+ * +-----+-----------------+------+--------------------------+
  * |   7 | wIndex          | U16  | currently supported: 5   |
+ * +-----+-----------------+------+--------------------------+
  * |   9 | wCount          | U16  | number of ext. compat.   |
+ * +-----+-----------------+------+--------------------------+
  * |  11 | ExtProp[]       |      | list of ext. prop. d.    |
+ * +-----+-----------------+------+--------------------------+
  *
  * ExtCompat[] is an array of valid Extended Compatiblity descriptors
  * which have the following format:
  *
+ * +-----+-----------------------+------+-------------------------------------+
  * | off | name                  | type | description                         |
- * |-----+-----------------------+------+-------------------------------------|
+ * +-----+-----------------------+------+-------------------------------------+
  * |   0 | bFirstInterfaceNumber | U8   | index of the interface or of the 1st|
+ * +-----+-----------------------+------+-------------------------------------+
  * |     |                       |      | interface in an IAD group           |
+ * +-----+-----------------------+------+-------------------------------------+
  * |   1 | Reserved              | U8   | 1                                   |
+ * +-----+-----------------------+------+-------------------------------------+
  * |   2 | CompatibleID          | U8[8]| compatible ID string                |
+ * +-----+-----------------------+------+-------------------------------------+
  * |  10 | SubCompatibleID       | U8[8]| subcompatible ID string             |
+ * +-----+-----------------------+------+-------------------------------------+
  * |  18 | Reserved              | U8[6]| 0                                   |
+ * +-----+-----------------------+------+-------------------------------------+
  *
  * ExtProp[] is an array of valid Extended Properties descriptors
  * which have the following format:
  *
+ * +-----+-----------------------+------+-------------------------------------+
  * | off | name                  | type | description                         |
- * |-----+-----------------------+------+-------------------------------------|
+ * +-----+-----------------------+------+-------------------------------------+
  * |   0 | dwSize                | U32  | length of the descriptor            |
+ * +-----+-----------------------+------+-------------------------------------+
  * |   4 | dwPropertyDataType    | U32  | 1..7                                |
+ * +-----+-----------------------+------+-------------------------------------+
  * |   8 | wPropertyNameLength   | U16  | bPropertyName length (NL)           |
+ * +-----+-----------------------+------+-------------------------------------+
  * |  10 | bPropertyName         |U8[NL]| name of this property               |
+ * +-----+-----------------------+------+-------------------------------------+
  * |10+NL| dwPropertyDataLength  | U32  | bPropertyData length (DL)           |
+ * +-----+-----------------------+------+-------------------------------------+
  * |14+NL| bProperty             |U8[DL]| payload of this property            |
+ * +-----+-----------------------+------+-------------------------------------+
  */
 
 struct usb_functionfs_strings_head {
-- 
2.43.0


