Return-Path: <linux-kernel+bounces-406141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571A9C5B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D3B283267
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A232003D8;
	Tue, 12 Nov 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS0CEZb5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00B1FF056;
	Tue, 12 Nov 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423887; cv=none; b=EYBRC7/yG+HEbsvMuWaNdRXA/z2+xEQFdCF2x6JIHYBOKqMYEIFkpNUy/aqhLfHMMOlE1NtnI4xBIKkoOBwLGLVZkE0l+IaEdBIl/1cdoTlz2S/m3C9PxGoQ53sptqhmKDak8bD+kLp/CjTVLB7+uYrngSV0U+ftp8MO1c66qCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423887; c=relaxed/simple;
	bh=Sj/DqbSkLqKyDhTpxHU9yfo+vdWUF7Kxl6BtXT3ZXqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rb0z7CF19HMNpUd1bnlgPgPPh3QcygCN2T4PKcGV5oF3hNPqezsq1y/QUxsaNSGWaqnT1hKjGUqKwfvI2zhTZTq+QJhviyqXI0ctthS3S6AGuZ4KrUNam037+X1jgrSaZ9JiTROggvwibpER2Tu5mqdriOg1RcZXgQwcsUhP1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS0CEZb5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315baec69eso51134815e9.2;
        Tue, 12 Nov 2024 07:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731423883; x=1732028683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtvGrY83MuU2WwAvCz6mNdS+Ho9dIW5YSWzoNQlvz2Y=;
        b=nS0CEZb5lj00eZzgFaXp8W9Lm3pBSCmc2Bn8LlxtlkVObBr3EFvqu91ecLkOQ1aF42
         FgoDiOCR250JgUeI2I4nXc9UdOX2MqQR0B/3gCuYjxUwAfT1w3N26Qor11K3U2pKowDg
         eYnpAqR4r7zG1g6BAZ2Km7zhNf0sl6A4g8fwDxAYev9cSFMgnmE9hm9bqRcrOl8hrnwu
         margyuDDlB19SJS9csycx97N9kQ35iXK6K06b4O/T3AWn2Mrg+bluuY+S45WTGCkCPob
         jcLTA+TqmRSwcOYQsPIIBNr6Mn81hNqFhgFfVuUAJdaZ6xlcgIoRuDpyrc4rjcMSKmSu
         8ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423883; x=1732028683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtvGrY83MuU2WwAvCz6mNdS+Ho9dIW5YSWzoNQlvz2Y=;
        b=qvolngEORJnJrzEALYN48skSJd2fJbr2EdLVJdU+jDblvmdJntXNi2UxuZwFFzK/Dy
         U3B76hyKegm8JPr0BYt/YUx0tDeCAt/8kBbohD7Mcajk31p5vYN+hjwIZOkjncEAYVW2
         WZPCobKEYdwZUHCjwY4mlHK1e4jfgGljy0mX2g/2KWYsAEyb+eP3Psc3qT9uRoN74g+f
         4vbrAjFsKGvXROqa29lHbaA7pqEJ6xthQZFefkFf+Sc09nIOvqNPICifcDsHFVL3gE03
         8zuCb36wFdrXdEwSIzdr8wXDpihDeR0Ax1jGW1c64fLJe1G3vzu7MhhwN7SYvcHrgEji
         lDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuv6uftNii+PXlaLgmu+7Sf+tZB4kRBknUP6msHijTzGGDsB/1DOEjEY7vRLzPdhGv+LKqGMTXRLp7@vger.kernel.org, AJvYcCXFZ8smoO/1WPWDqVCepdOXCsgsq9vBbql3RmJ74SyF9eACc7cBaV3FA1xwaZ8oT2rHMRaBd/jLmawXprc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjYDoPJ39BdgPbWEtaI17tFgHZ6XxIPACgZWUdfn109inF6Ax
	Z5JGURSNZq5fW3VBPkS2wBdbtc9UjXWU53aAUSm0MibDLkGQHM/wjivBgXW9dYs=
X-Google-Smtp-Source: AGHT+IFs4IECMDreVXK8Dli2zQmHhd1IAJVkDyKgd0BeOo00MagGKo+m0y6jhiphQ3ttcDIFTQ7Fag==
X-Received: by 2002:a05:600c:3ca8:b0:426:616e:db8d with SMTP id 5b1f17b1804b1-432b7509717mr124217445e9.15.1731423882433;
        Tue, 12 Nov 2024 07:04:42 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm210159555e9.17.2024.11.12.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:04:41 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	b-liu@ti.com,
	johan@kernel.org
Cc: oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	snovitoll@gmail.com
Subject: [PATCH] drivers/usb: refactor min(), max() with min_t(), max_t()
Date: Tue, 12 Nov 2024 20:04:37 +0500
Message-Id: <20241112150437.3508388-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scanned the current drivers/usb code with `max\(.*\(` and `min\(.*\(`
regexp queries to find casting inside of min() and max() which
may lead to subtle bugs or even security vulnerabilities,
especially if negative values are involved.

Let's refactor to min_t() and max_t() specifying the data type
to ensure it's applicable for the both compareable arguments.
It should address potential type promotion issues and improves type safety.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/core/config.c                    |  2 +-
 drivers/usb/gadget/composite.c               | 12 ++++++------
 drivers/usb/gadget/configfs.c                |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  6 +++---
 drivers/usb/gadget/function/f_mass_storage.c |  8 ++++----
 drivers/usb/gadget/function/uvc_video.c      |  4 ++--
 drivers/usb/gadget/legacy/raw_gadget.c       |  4 ++--
 drivers/usb/gadget/udc/omap_udc.c            |  4 ++--
 drivers/usb/gadget/usbstring.c               |  2 +-
 drivers/usb/host/ehci-hcd.c                  |  2 +-
 drivers/usb/host/oxu210hp-hcd.c              |  4 ++--
 drivers/usb/host/r8a66597-hcd.c              |  2 +-
 drivers/usb/misc/usbtest.c                   |  3 ++-
 drivers/usb/mon/mon_bin.c                    |  2 +-
 drivers/usb/musb/musb_core.c                 |  2 +-
 drivers/usb/musb/musb_gadget_ep0.c           |  2 +-
 drivers/usb/musb/musb_host.c                 |  5 ++---
 drivers/usb/serial/io_edgeport.c             |  2 +-
 drivers/usb/serial/sierra.c                  |  2 +-
 drivers/usb/storage/sddr09.c                 |  4 ++--
 drivers/usb/storage/sddr55.c                 |  8 ++++----
 21 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 880d52c0949d..25a00f974934 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -924,7 +924,7 @@ int usb_get_configuration(struct usb_device *dev)
 			result = -EINVAL;
 			goto err;
 		}
-		length = max((int) le16_to_cpu(desc->wTotalLength),
+		length = max_t(int, le16_to_cpu(desc->wTotalLength),
 		    USB_DT_CONFIG_SIZE);
 
 		/* Now that we know the length, get the whole thing */
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index f25dd2cb5d03..8e8c3baa9d7e 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1844,7 +1844,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 					cdev->desc.bcdUSB = cpu_to_le16(0x0200);
 			}
 
-			value = min(w_length, (u16) sizeof cdev->desc);
+			value = min_t(u16, w_length, sizeof(cdev->desc));
 			memcpy(req->buf, &cdev->desc, value);
 			break;
 		case USB_DT_DEVICE_QUALIFIER:
@@ -1863,19 +1863,19 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		case USB_DT_CONFIG:
 			value = config_desc(cdev, w_value);
 			if (value >= 0)
-				value = min(w_length, (u16) value);
+				value = min_t(u16, w_length, value);
 			break;
 		case USB_DT_STRING:
 			value = get_string(cdev, req->buf,
 					w_index, w_value & 0xff);
 			if (value >= 0)
-				value = min(w_length, (u16) value);
+				value = min_t(u16, w_length, value);
 			break;
 		case USB_DT_BOS:
 			if (gadget_is_superspeed(gadget) ||
 			    gadget->lpm_capable || cdev->use_webusb) {
 				value = bos_desc(cdev);
-				value = min(w_length, (u16) value);
+				value = min_t(u16, w_length, value);
 			}
 			break;
 		case USB_DT_OTG:
@@ -1930,7 +1930,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			*(u8 *)req->buf = cdev->config->bConfigurationValue;
 		else
 			*(u8 *)req->buf = 0;
-		value = min(w_length, (u16) 1);
+		value = min_t(u16, w_length, 1);
 		break;
 
 	/* function drivers must handle get/set altsetting */
@@ -1976,7 +1976,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		if (value < 0)
 			break;
 		*((u8 *)req->buf) = value;
-		value = min(w_length, (u16) 1);
+		value = min_t(u16, w_length, 1);
 		break;
 	case USB_REQ_GET_STATUS:
 		if (gadget_is_otg(gadget) && gadget->hnp_polling_support &&
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index c82a6a0fba93..6499a88d346c 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1184,7 +1184,7 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
 	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
 	int res, l;
 
-	l = min((int)len, OS_STRING_QW_SIGN_LEN >> 1);
+	l = min_t(int, len, OS_STRING_QW_SIGN_LEN >> 1);
 	if (page[l - 1] == '\n')
 		--l;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2920f8000bbd..2ccf7f4e4db1 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -456,7 +456,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 		}
 
 		/* FFS_SETUP_PENDING and not stall */
-		len = min(len, (size_t)le16_to_cpu(ffs->ev.setup.wLength));
+		len = min_t(size_t, len, le16_to_cpu(ffs->ev.setup.wLength));
 
 		spin_unlock_irq(&ffs->ev.waitq.lock);
 
@@ -590,7 +590,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		/* unlocks spinlock */
 		return __ffs_ep0_read_events(ffs, buf,
-					     min(n, (size_t)ffs->ev.count));
+					     min_t(size_t, n, ffs->ev.count));
 
 	case FFS_SETUP_PENDING:
 		if (ffs->ev.setup.bRequestType & USB_DIR_IN) {
@@ -599,7 +599,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 			goto done_mutex;
 		}
 
-		len = min(len, (size_t)le16_to_cpu(ffs->ev.setup.wLength));
+		len = min_t(size_t, len, le16_to_cpu(ffs->ev.setup.wLength));
 
 		spin_unlock_irq(&ffs->ev.waitq.lock);
 
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 08e0d1c511e8..2eae8fc2e0db 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -500,7 +500,7 @@ static int fsg_setup(struct usb_function *f,
 		*(u8 *)req->buf = _fsg_common_get_max_lun(fsg->common);
 
 		/* Respond with data/status */
-		req->length = min((u16)1, w_length);
+		req->length = min_t(u16, 1, w_length);
 		return ep0_queue(fsg->common);
 	}
 
@@ -655,7 +655,7 @@ static int do_read(struct fsg_common *common)
 		 * And don't try to read past the end of the file.
 		 */
 		amount = min(amount_left, FSG_BUFLEN);
-		amount = min((loff_t)amount,
+		amount = min_t(loff_t, amount,
 			     curlun->file_length - file_offset);
 
 		/* Wait for the next buffer to become available */
@@ -1005,7 +1005,7 @@ static int do_verify(struct fsg_common *common)
 		 * And don't try to read past the end of the file.
 		 */
 		amount = min(amount_left, FSG_BUFLEN);
-		amount = min((loff_t)amount,
+		amount = min_t(loff_t, amount,
 			     curlun->file_length - file_offset);
 		if (amount == 0) {
 			curlun->sense_data =
@@ -2167,7 +2167,7 @@ static int do_scsi_command(struct fsg_common *common)
 	if (reply == -EINVAL)
 		reply = 0;		/* Error reply length */
 	if (reply >= 0 && common->data_dir == DATA_DIR_TO_HOST) {
-		reply = min((u32)reply, common->data_size_from_cmnd);
+		reply = min_t(u32, reply, common->data_size_from_cmnd);
 		bh->inreq->length = reply;
 		bh->state = BUF_STATE_FULL;
 		common->residue -= reply;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 57a851151225..23064626ddb7 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -78,7 +78,7 @@ uvc_video_encode_data(struct uvc_video *video, struct uvc_buffer *buf,
 
 	/* Copy video data to the USB buffer. */
 	mem = buf->mem + queue->buf_used;
-	nbytes = min((unsigned int)len, buf->bytesused - queue->buf_used);
+	nbytes = min_t(unsigned int, len, buf->bytesused - queue->buf_used);
 
 	memcpy(data, mem, nbytes);
 	queue->buf_used += nbytes;
@@ -104,7 +104,7 @@ uvc_video_encode_bulk(struct usb_request *req, struct uvc_video *video,
 	}
 
 	/* Process video data. */
-	len = min((int)(video->max_payload_size - video->payload_size), len);
+	len = min_t(int, video->max_payload_size - video->payload_size, len);
 	ret = uvc_video_encode_data(video, buf, mem, len);
 
 	video->payload_size += ret;
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 112fd18d8c99..20165e1582d9 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -782,7 +782,7 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
 	if (ret < 0)
 		goto free;
 
-	length = min(io.length, (unsigned int)ret);
+	length = min_t(unsigned int, io.length, ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
 	else
@@ -1168,7 +1168,7 @@ static int raw_ioctl_ep_read(struct raw_dev *dev, unsigned long value)
 	if (ret < 0)
 		goto free;
 
-	length = min(io.length, (unsigned int)ret);
+	length = min_t(unsigned int, io.length, ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
 	else
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 61a45e4657d5..38b1d90d026f 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -576,13 +576,13 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
 
 static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 {
-	unsigned packets = req->req.length - req->req.actual;
+	unsigned int packets = req->req.length - req->req.actual;
 	int dma_trigger = 0;
 	u16 w;
 
 	/* set up this DMA transfer, enable the fifo, start */
 	packets /= ep->ep.maxpacket;
-	packets = min(packets, (unsigned)UDC_RXN_TC + 1);
+	packets = min_t(unsigned int, packets, UDC_RXN_TC + 1);
 	req->dma_bytes = packets * ep->ep.maxpacket;
 	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
 			ep->ep.maxpacket >> 1, packets,
diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
index 75f6f99f8173..37a2f1b61cba 100644
--- a/drivers/usb/gadget/usbstring.c
+++ b/drivers/usb/gadget/usbstring.c
@@ -55,7 +55,7 @@ usb_gadget_get_string (const struct usb_gadget_strings *table, int id, u8 *buf)
 		return -EINVAL;
 
 	/* string descriptors have length, tag, then UTF16-LE text */
-	len = min((size_t)USB_MAX_STRING_LEN, strlen(s->s));
+	len = min_t(size_t, USB_MAX_STRING_LEN, strlen(s->s));
 	len = utf8s_to_utf16s(s->s, len, UTF16_LITTLE_ENDIAN,
 			(wchar_t *) &buf[2], USB_MAX_STRING_LEN);
 	if (len < 0)
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cbc0b86fcc36..6de79ac5e6a4 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -547,7 +547,7 @@ static int ehci_init(struct usb_hcd *hcd)
 		 * make problems:  throughput reduction (!), data errors...
 		 */
 		if (park) {
-			park = min(park, (unsigned) 3);
+			park = min_t(unsigned int, park, 3);
 			temp |= CMD_PARK;
 			temp |= park << 8;
 		}
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index ca3859463ba1..eaa34ee0a535 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -902,7 +902,7 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 
 	/* Find a suitable available data buffer */
 	for (i = 0; i < BUFFER_NUM;
-			i += max(a_blocks, (int)oxu->db_used[i])) {
+			i += max_t(int, a_blocks, oxu->db_used[i])) {
 
 		/* Check all the required blocks are available */
 		for (j = 0; j < a_blocks; j++)
@@ -3040,7 +3040,7 @@ static int oxu_hcd_init(struct usb_hcd *hcd)
 		 * make problems:  throughput reduction (!), data errors...
 		 */
 		if (park) {
-			park = min(park, (unsigned) 3);
+			park = min_t(unsigned int, park, 3);
 			temp |= CMD_PARK;
 			temp |= park << 8;
 		}
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 6576515a29cd..d693fdfaa542 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1336,7 +1336,7 @@ static void packet_read(struct r8a66597 *r8a66597, u16 pipenum)
 		buf = (void *)urb->transfer_buffer + urb->actual_length;
 		urb_len = urb->transfer_buffer_length - urb->actual_length;
 	}
-	bufsize = min(urb_len, (int) td->maxpacket);
+	bufsize = min_t(int, urb_len, td->maxpacket);
 	if (rcv_len <= bufsize) {
 		size = rcv_len;
 	} else {
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index caf65f8294db..8d379ae835bc 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -2021,7 +2021,8 @@ static struct urb *iso_alloc_urb(
 
 	for (i = 0; i < packets; i++) {
 		/* here, only the last packet will be short */
-		urb->iso_frame_desc[i].length = min((unsigned) bytes, maxp);
+		urb->iso_frame_desc[i].length = min_t(unsigned int,
+							bytes, maxp);
 		bytes -= urb->iso_frame_desc[i].length;
 
 		urb->iso_frame_desc[i].offset = maxp * i;
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index afb71c18415d..c93b43f5bc46 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -823,7 +823,7 @@ static ssize_t mon_bin_read(struct file *file, char __user *buf,
 	ep = MON_OFF2HDR(rp, rp->b_out);
 
 	if (rp->b_read < hdrbytes) {
-		step_len = min(nbytes, (size_t)(hdrbytes - rp->b_read));
+		step_len = min_t(size_t, nbytes, hdrbytes - rp->b_read);
 		ptr = ((char *)ep) + rp->b_read;
 		if (step_len && copy_to_user(buf, ptr, step_len)) {
 			mutex_unlock(&rp->fetch_lock);
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b24adb5b399f..61f3aee7b72e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1387,7 +1387,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 
 	/* expect hw_ep has already been zero-initialized */
 
-	size = ffs(max(maxpacket, (u16) 8)) - 1;
+	size = ffs(max_t(u16, maxpacket, 8)) - 1;
 	maxpacket = 1 << size;
 
 	c_size = size - 3;
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 6d7336727388..f0786f8fbb25 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -533,7 +533,7 @@ static void ep0_txstate(struct musb *musb)
 
 	/* load the data */
 	fifo_src = (u8 *) request->buf + request->actual;
-	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
+	fifo_count = min_t(unsigned, MUSB_EP0_FIFOSIZE,
 		request->length - request->actual);
 	musb_write_fifo(&musb->endpoints[0], fifo_count, fifo_src);
 	request->actual += fifo_count;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index bc4507781167..732ba981e607 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -798,10 +798,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		if (can_bulk_split(musb, qh->type))
-			load_count = min((u32) hw_ep->max_packet_sz_tx,
-						len);
+			load_count = min_t(u32, hw_ep->max_packet_sz_tx, len);
 		else
-			load_count = min((u32) packet_sz, len);
+			load_count = min_t(u32, packet_sz, len);
 
 		if (dma_channel && musb_tx_dma_program(dma_controller,
 					hw_ep, qh, urb, offset, len))
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 28c71d99e857..1fffda7647f9 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1129,7 +1129,7 @@ static int edge_write(struct tty_struct *tty, struct usb_serial_port *port,
 	spin_lock_irqsave(&edge_port->ep_lock, flags);
 
 	/* calculate number of bytes to put in fifo */
-	copySize = min((unsigned int)count,
+	copySize = min_t(unsigned int, count,
 				(edge_port->txCredits - fifo->count));
 
 	dev_dbg(&port->dev, "%s of %d byte(s) Fifo room  %d -- will copy %d bytes\n",
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 64a2e0bb5723..741e68e46139 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -421,7 +421,7 @@ static int sierra_write(struct tty_struct *tty, struct usb_serial_port *port,
 	unsigned long flags;
 	unsigned char *buffer;
 	struct urb *urb;
-	size_t writesize = min((size_t)count, (size_t)MAX_TRANSFER);
+	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
 	int retval = 0;
 
 	/* verify that we actually have some data to write */
diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index 03d1b9c69ea1..30ee76cfef05 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -752,7 +752,7 @@ sddr09_read_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
+	len = min_t(unsigned int, sectors, info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (!buffer)
 		return -ENOMEM;
@@ -997,7 +997,7 @@ sddr09_write_data(struct us_data *us,
 	 * at a time between the bounce buffer and the actual transfer buffer.
 	 */
 
-	len = min(sectors, (unsigned int) info->blocksize) * info->pagesize;
+	len = min_t(unsigned int, sectors, info->blocksize) * info->pagesize;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (!buffer) {
 		kfree(blockbuffer);
diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8227478a7ad..a37fc505c57f 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -206,7 +206,7 @@ static int sddr55_read_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min((unsigned int) sectors, (unsigned int) info->blocksize >>
+	len = min_t(unsigned int, sectors, info->blocksize >>
 			info->smallpageshift) * PAGESIZE;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL)
@@ -224,7 +224,7 @@ static int sddr55_read_data(struct us_data *us,
 
 		// Read as many sectors as possible in this block
 
-		pages = min((unsigned int) sectors << info->smallpageshift,
+		pages = min_t(unsigned int, sectors << info->smallpageshift,
 				info->blocksize - page);
 		len = pages << info->pageshift;
 
@@ -333,7 +333,7 @@ static int sddr55_write_data(struct us_data *us,
 	// a bounce buffer and move the data a piece at a time between the
 	// bounce buffer and the actual transfer buffer.
 
-	len = min((unsigned int) sectors, (unsigned int) info->blocksize >>
+	len = min_t(unsigned int, sectors, info->blocksize >>
 			info->smallpageshift) * PAGESIZE;
 	buffer = kmalloc(len, GFP_NOIO);
 	if (buffer == NULL)
@@ -351,7 +351,7 @@ static int sddr55_write_data(struct us_data *us,
 
 		// Write as many sectors as possible in this block
 
-		pages = min((unsigned int) sectors << info->smallpageshift,
+		pages = min_t(unsigned int, sectors << info->smallpageshift,
 				info->blocksize - page);
 		len = pages << info->pageshift;
 
-- 
2.34.1


