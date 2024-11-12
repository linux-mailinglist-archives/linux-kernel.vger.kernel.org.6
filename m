Return-Path: <linux-kernel+bounces-406255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8FA9C5CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5F1F224A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3413C204012;
	Tue, 12 Nov 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0PmKXXL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4A2038A2;
	Tue, 12 Nov 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427112; cv=none; b=baXwR7oOToObOKTTdFzFn9gqhPiGhlM7gcHKVQSkjSiqwW9YmJiXVjjSPA2sA7F2XZjNJKPRT4Aqivrab9JQb6VGgNEEFu4/nVv5Wb6PxXiNfzHBmkdH53SfLLUkJ5Y29o0ahPnuGpJvOwbxeOmGPLURW/vfHYnatoZp6lCeD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427112; c=relaxed/simple;
	bh=wC9mZ39C44jdIYeQTKZVxRinkEPaPJNuk0gKXTbFhyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHm0Kd18K2RIJSvuuj8XnilNW0GaiXNF01hAD8M7C0EJ4h3GSBUZEN0A3SuX5u8jOtUVcGaMDPWIF7FcR5vs+t3sYmRbSBop5brmFmiXufPVaDXZ8fBwJQYuHjO33kPes6nU8eUI1uu4josAk0fab1OpbTGQ12ggyVUT9ExANnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0PmKXXL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so4133922f8f.3;
        Tue, 12 Nov 2024 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427108; x=1732031908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLrKR8h0hMM7F++0PtBceneF9LUpCKVWB9g0O0i5f7A=;
        b=b0PmKXXLreUICb/X96rLy2D7GXUgtGUFO34MOtv7FRbxbX/6aGBkO8dcttHD9a/ijM
         +0vrpFuaDelUgGcHTKpm6nK4U8XFjfuARcQAQam1tdFRI0NFLwSeD0jiadboPKv7p9sK
         ADJ2JwDOJzBZOoMnd6vbwryKnChABT32lSI4owEYvPfyCqJUzLBO9keF1F4KcXk6Nwwm
         caZoVWWLZUodKK9+U49g/mlzORVU6ivZ6Z/Lx9CnTlhIQkJ8v6yEx+ldNrBjL0MihXn1
         VsIyjXUiUBTVzJR5HAjG0iUwh8Nvxf26h/bZY6FklwJqDINpNyeV5Xl57oysfGNskc7k
         /9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427108; x=1732031908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLrKR8h0hMM7F++0PtBceneF9LUpCKVWB9g0O0i5f7A=;
        b=JcO8JdXqzfV2QJxSoEKzz0kZVWG61TZ9b0KOAgrMLFeTvIF9eRgPZLr/TLq7aPUu42
         s/H0wBU4U3/BZx5ZY1oGdgRQMEHjuDJO20mlrBNest0AUmhayNFqlB2sCNaXJ6y7JDQ3
         SwdwSvMCi+PODaV3AGsm5x4VWPsjMn3jG54JwN+x+sIBZUYBAWaHgwI/YwJ68yhgRsWS
         nNzOI6oZD7QWRGrS8AshQHT6oMYyIKWdrIft7waMt+oIUe0Uhb7Ne+y+Hwer1+QDGJkl
         IcRNG/ly1Jj7rqCtDX5BZx5GUAAxwiMhvXzerPqmkCfclAbTUvSOGYY2LQzrxeZZ1AW+
         Nj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVxHUAVULLFOJqlINQvEAUjoPfu3RpI7sT081XimUwBBbKS0Qs9wg/qNViZ33mQc2BkzvEu66GiPNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoR0nEo81RKtnc9MvZQdDrFfxSIqhsKXHpXNVGwiEtMTt/s/nk
	pH7fqSXBw0CV3ZXIxhjty9FZ/GYLG1HZShSCD3bG5iLQ33ui44zU
X-Google-Smtp-Source: AGHT+IF3sw83754J0k0uX9EzFSvgiWJVjoGFNkxu6Hq3hSCgGmn6YnA7dLKZdiABcowBY9Z5P5qLlA==
X-Received: by 2002:a05:6000:1849:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-381f1872412mr13268838f8f.26.1731427108114;
        Tue, 12 Nov 2024 07:58:28 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:27 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 1/8] drivers/usb/gadget: refactor min with min_t
Date: Tue, 12 Nov 2024 20:58:10 +0500
Message-Id: <20241112155817.3512577-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t() instead of casted min().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/gadget/composite.c               | 12 ++++++------
 drivers/usb/gadget/configfs.c                |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  6 +++---
 drivers/usb/gadget/function/f_mass_storage.c |  8 ++++----
 drivers/usb/gadget/function/uvc_video.c      |  4 ++--
 drivers/usb/gadget/legacy/raw_gadget.c       |  4 ++--
 drivers/usb/gadget/udc/omap_udc.c            |  4 ++--
 drivers/usb/gadget/usbstring.c               |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

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
-- 
2.34.1


