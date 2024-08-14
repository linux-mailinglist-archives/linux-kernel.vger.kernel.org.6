Return-Path: <linux-kernel+bounces-286466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F26951B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17841286CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4C1109;
	Wed, 14 Aug 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfbpsWXk"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1751B0132;
	Wed, 14 Aug 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640154; cv=none; b=bX8zw7vR9rgKKvt3e9BsieImwlniXOqJKRV9OdNQQh8OS7OLHkWf6CRgp1UivCT4s0w5bzoDwFTAlsxi0VlgF+m4Z1I7V7lVe6b3YGkM50hx5TcSGwMxyE8r8NozWN8svLNw+cf4Xu/h2QChxMUlc+sJIeJdzCpb6oLWqJzRD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640154; c=relaxed/simple;
	bh=AKHoInAiNpz4W0qL5uvAdqdHUclP257FAwWuWak7qYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxaFRRWBbNnLmlQ8yS/Wylyu0GpJsJRHw9+yqCwN+dlVZjEIeG+C7qldnP4Qn8yEdbvujCybtToHpKv7uBl1LONwCGTDVhkbL/9N2Bv2DrzeP4ifltdZvz1PjRimVy3a4y24dZtufHhkxznhwdQB96yNnVwi4VPZ6pFiLEJXwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfbpsWXk; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b7a8cada97so36765596d6.3;
        Wed, 14 Aug 2024 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723640151; x=1724244951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vcx1v9d+WEL1YiI/v8FPLPy17w3cjEaZK5ipMASS+A=;
        b=jfbpsWXkkB3g8431M6ng2uME5PaB6B8s9hR6fsjBtwc4vP/N5UCdvPnaAEvuajeJPY
         XCdaIYvRf0SSqj4FxbjJ50p+1fup2rmS0n0JIwYmfdVuznDAMfArNI1hj+ACeGJTJiSo
         nvsjpVGJEkKqSZ5l0V25L9uz8CNAeFVyuN1VDSOe+i8trI1XNUJm9LicdY12+3w0GAd8
         idxe+7mAQJo9a4B99qF0mj1C7cR+7xiZomTMFk8imt9E3IuoVVyIjx0QEYYmFhmLfsjH
         OzL6RKVIcTtkfUIdKnBlA/q+/w782uEX3tRLPwvRPN+ns9rM11+AQqlIvdpo8uzVYzbr
         RuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640151; x=1724244951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vcx1v9d+WEL1YiI/v8FPLPy17w3cjEaZK5ipMASS+A=;
        b=j74ugupfeV7r9FLjsRdHhapC3V9GinFchGYhZ7UN7QucK4ErNeR4eeCxPAq1DGsVY4
         /rfuJHiGYJI+oS7/PvQdqg5kSfTNHt90AYuDlLEt+B6cGN72bfTGvR6md5w+5xNJO7Ek
         02XrUX/leMgkTm3cLMG0lQGa/gWLclVv8BTuHSpjVx9iQgEdi/vLjLugiNOm9xUkv2Yh
         nrrw6Bt8btinvOr4DVfKXHNr8Vd5WYnoCwdak3CXCdzKDbBSNqFawAcH2gMV+xpwXcad
         FLqA9hC76YS1hTOfSG9O+4h24/7x/OswZ/lZpyTGWQm7WWoTWrWhtnm4KN8h6wVvCI9J
         j58Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSOF5XYmNCSMqc3cPQXn7T1ZZ2wFowo+eNxKpVxMPabON2aB5eZ5INOVl2n5EisVOByr0lFBSYOuO5zP9Clf7DXl+qH6HSMhhNpCiY
X-Gm-Message-State: AOJu0YzZmrYq8cvmtganW2DKQMsw2/Wb+jQJEBafOy6q9LgUOt5yvjek
	jcXM4//apon85wA9m2jnMfG+kwgJILj58fZ3kLbR279VDCtICYVw/tUGYA==
X-Google-Smtp-Source: AGHT+IGz44YSr6FREIpfWEduR6SJEiL3k+drhZvfCwNQjF/NvIg/F3bslGC0kpljla9fufnVw5IV5Q==
X-Received: by 2002:a05:6214:2c03:b0:6b5:46bf:be2c with SMTP id 6a1803df08f44-6bf5d1e8030mr28448606d6.27.1723640150744;
        Wed, 14 Aug 2024 05:55:50 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c62119sm43461676d6.4.2024.08.14.05.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:55:49 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konstantin Aladyshev <aladyshev22@gmail.com>,
	David Sands <david.sands@biamp.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <Chris.Wulff@biamp.com>,
	Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH v4] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
Date: Wed, 14 Aug 2024 08:55:26 -0400
Message-ID: <20240814125525.3917130-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <Chris.Wulff@biamp.com>

While supporting GET_REPORT is a mandatory request per the HID
specification the current implementation of the GET_REPORT request responds
to the USB Host with an empty reply of the request length. However, some
USB Hosts will request the contents of feature reports via the GET_REPORT
request. In addition, some proprietary HID 'protocols' will expect
different data, for the same report ID, to be to become available in the
feature report by sending a preceding SET_REPORT to the USB Device that
defines what data is to be presented when that feature report is
subsequently retrieved via GET_REPORT (with a very fast < 5ms turn around
between the SET_REPORT and the GET_REPORT).

There are two other patch sets already submitted for adding GET_REPORT
support. The first [1] allows for pre-priming a list of reports via IOCTLs
which then allows the USB Host to perform the request, with no further
userspace interaction possible during the GET_REPORT request. And another
[2] which allows for a single report to be setup by userspace via IOCTL,
which will be fetched and returned by the kernel for subsequent GET_REPORT
requests by the USB Host, also with no further userspace interaction
possible.

This patch, while loosely based on both the patch sets, differs by allowing
the option for userspace to respond to each GET_REPORT request by setting
up a poll to notify userspace that a new GET_REPORT request has arrived. To
support this, two extra IOCTLs are supplied. The first of which is used to
retrieve the report ID of the GET_REPORT request (in the case of having
non-zero report IDs in the HID descriptor). The second IOCTL allows for
storing report responses in a list for responding to requests.

The report responses are stored in a list (it will be either added if it
does not exist or updated if it exists already). A flag (userspace_req) can
be set to whether subsequent requests notify userspace or not.

Basic operation when a GET_REPORT request arrives from USB Host:

- If the report ID exists in the list and it is set for immediate return
  (i.e. userspace_req == false) then response is sent immediately,
userspace is not notified

- The report ID does not exist, or exists but is set to notify userspace
  (i.e. userspace_req == true) then notify userspace via poll:

	- If userspace responds, and either adds or update the response in
	  the list and respond to the host with the contents

	- If userspace does not respond within the fixed timeout (2500ms)
	  but the report has been set prevously, then send 'old' report
	  contents

	- If userspace does not respond within the fixed timeout (2500ms)
	  and the report does not exist in the list then send an empty
	  report

Note that userspace could 'prime' the report list at any other time.

While this patch allows for flexibility in how the system responds to
requests, and therefore the HID 'protocols' that could be supported, a
drawback is the time it takes to service the requests and therefore the
maximum throughput that would be achievable. The USB HID Specification
v1.11 itself states that GET_REPORT is not intended for periodic data
polling, so this limitation is not severe.

Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading
showed that userspace can typically respond to the GET_REPORT request
within 1200ms - which is well within the 5000ms most operating systems seem
to allow, and within the 2500ms set by this patch.

[1] https://lore.kernel.org/all/20220805070507.123151-2-sunil@amarulasolutions.com/
[2] https://lore.kernel.org/all/20220726005824.2817646-1-vi@endrift.com/

Signed-off-by: David Sands <david.sands@biamp.com>
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
---
v4: cleaned up a warning
v3: rebased to usb-next, checkpatch cleanup (formatting, lore.kernel.org links)
https://lore.kernel.org/all/20240810141834.640887-2-crwulff@gmail.com/
v2: https://lore.kernel.org/all/CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com/
v1: https://lore.kernel.org/all/20230215231529.2513236-1-david.sands@biamp.com/
---
 drivers/usb/gadget/function/f_hid.c | 272 +++++++++++++++++++++++++++-
 include/uapi/linux/usb/g_hid.h      |  40 ++++
 include/uapi/linux/usb/gadgetfs.h   |   2 +-
 3 files changed, 306 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/usb/g_hid.h

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 93dae017ae45..997837369e3d 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -15,13 +15,21 @@
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 #include <linux/usb/g_hid.h>
+#include <uapi/linux/usb/g_hid.h>
 
 #include "u_f.h"
 #include "u_hid.h"
 
 #define HIDG_MINORS	4
 
+/*
+ * Most operating systems seem to allow for 5000ms timeout, we will allow
+ * userspace half that time to respond before we return an empty report.
+ */
+#define GET_REPORT_TIMEOUT_MS 2500
+
 static int major, minors;
 
 static const struct class hidg_class = {
@@ -31,6 +39,11 @@ static const struct class hidg_class = {
 static DEFINE_IDA(hidg_ida);
 static DEFINE_MUTEX(hidg_ida_lock); /* protects access to hidg_ida */
 
+struct report_entry {
+	struct usb_hidg_report report_data;
+	struct list_head node;
+};
+
 /*-------------------------------------------------------------------------*/
 /*                            HID gadget struct                            */
 
@@ -75,6 +88,19 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
+	/* get report */
+	struct usb_request		*get_req;
+	struct usb_hidg_report		get_report;
+	bool				get_report_returned;
+	int				get_report_req_report_id;
+	int				get_report_req_report_length;
+	spinlock_t			get_report_spinlock;
+	wait_queue_head_t		get_queue;    /* Waiting for userspace response */
+	wait_queue_head_t		get_id_queue; /* Get ID came in */
+	struct work_struct		work;
+	struct workqueue_struct		*workqueue;
+	struct list_head		report_list;
+
 	struct device			dev;
 	struct cdev			cdev;
 	struct usb_function		func;
@@ -524,6 +550,173 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
 	return status;
 }
 
+static struct report_entry *f_hidg_search_for_report(struct f_hidg *hidg, u8 report_id)
+{
+	struct list_head	*ptr;
+	struct report_entry	*entry;
+
+	list_for_each(ptr, &hidg->report_list) {
+		entry = list_entry(ptr, struct report_entry, node);
+		if (entry->report_data.report_id == report_id)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void get_report_workqueue_handler(struct work_struct *work)
+{
+	struct f_hidg *hidg = container_of(work, struct f_hidg, work);
+	struct usb_composite_dev *cdev = hidg->func.config->cdev;
+	struct usb_request		*req;
+	struct report_entry *ptr;
+	unsigned long	flags;
+
+	int status = 0;
+
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	req = hidg->get_req;
+	if (!req) {
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+		return;
+	}
+
+	req->zero = 0;
+	req->length = min_t(unsigned int, min_t(unsigned int, hidg->get_report_req_report_length,
+							      hidg->report_length),
+					  MAX_REPORT_LENGTH);
+
+	/* Check if there is a response available for immediate response */
+	ptr = f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);
+	if (ptr && !ptr->report_data.userspace_req) {
+		/* Report exists in list and it is to be used for immediate response */
+		req->buf = ptr->report_data.data;
+		status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		hidg->get_report_returned = true;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	} else {
+		/*
+		 * Report does not exist in list or should not be immediately sent
+		 * i.e. give userspace time to respond
+		 */
+		hidg->get_report_returned = false;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+		wake_up(&hidg->get_id_queue);
+#define GET_REPORT_COND (!hidg->get_report_returned)
+		/* Wait until userspace has responded or timeout */
+		status = wait_event_interruptible_timeout(hidg->get_queue, !GET_REPORT_COND,
+					msecs_to_jiffies(GET_REPORT_TIMEOUT_MS));
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+		req = hidg->get_req;
+		if (!req) {
+			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+			return;
+		}
+		if (status == 0 && !hidg->get_report_returned) {
+			/* GET_REPORT request was not serviced by userspace within timeout period */
+			VDBG(cdev, "get_report : userspace timeout.\n");
+			hidg->get_report_returned = true;
+		}
+
+		/* Search again for report ID in list and respond to GET_REPORT request */
+		ptr = f_hidg_search_for_report(hidg, hidg->get_report_req_report_id);
+		if (ptr) {
+			/*
+			 * Either get an updated response just serviced by userspace
+			 * or send the latest response in the list
+			 */
+			req->buf = ptr->report_data.data;
+		} else {
+			/* If there are no prevoiusly sent reports send empty report */
+			req->buf = hidg->get_report.data;
+			memset(req->buf, 0x0, req->length);
+		}
+
+		status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	}
+
+	if (status < 0)
+		VDBG(cdev, "usb_ep_queue error on ep0 responding to GET_REPORT\n");
+}
+
+static int f_hidg_get_report_id(struct file *file, __u8 __user *buffer)
+{
+	struct f_hidg			*hidg = file->private_data;
+	int ret = 0;
+
+	ret = put_user(hidg->get_report_req_report_id, buffer);
+
+	return ret;
+}
+
+static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *buffer)
+{
+	struct f_hidg			*hidg = file->private_data;
+	struct usb_composite_dev	*cdev = hidg->func.config->cdev;
+	unsigned long	flags;
+	struct report_entry *entry;
+	struct report_entry *ptr;
+	__u8 report_id;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	if (copy_from_user(&entry->report_data, buffer,
+				sizeof(struct usb_hidg_report))) {
+		ERROR(cdev, "copy_from_user error\n");
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	report_id = entry->report_data.report_id;
+
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	ptr = f_hidg_search_for_report(hidg, report_id);
+
+	if (ptr) {
+		/* Report already exists in list - update it */
+		if (copy_from_user(&ptr->report_data, buffer,
+				sizeof(struct usb_hidg_report))) {
+			ERROR(cdev, "copy_from_user error\n");
+			kfree(entry);
+			return -EINVAL;
+		}
+		kfree(entry);
+	} else {
+		/* Report does not exist in list - add it */
+		list_add_tail(&entry->node, &hidg->report_list);
+	}
+
+	/* If there is no response pending then do nothing further */
+	if (hidg->get_report_returned) {
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+		return 0;
+	}
+
+	/* If this userspace response serves the current pending report */
+	if (hidg->get_report_req_report_id == report_id) {
+		hidg->get_report_returned = true;
+		wake_up(&hidg->get_queue);
+	}
+
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+	return 0;
+}
+
+static long f_hidg_ioctl(struct file *file, unsigned int code, unsigned long arg)
+{
+	switch (code) {
+	case GADGET_HID_READ_GET_REPORT_ID:
+		return f_hidg_get_report_id(file, (__u8 __user *)arg);
+	case GADGET_HID_WRITE_GET_REPORT:
+		return f_hidg_get_report(file, (struct usb_hidg_report __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 {
 	struct f_hidg	*hidg  = file->private_data;
@@ -531,6 +724,8 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &hidg->read_queue, wait);
 	poll_wait(file, &hidg->write_queue, wait);
+	poll_wait(file, &hidg->get_queue, wait);
+	poll_wait(file, &hidg->get_id_queue, wait);
 
 	if (WRITE_COND)
 		ret |= EPOLLOUT | EPOLLWRNORM;
@@ -543,12 +738,16 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 			ret |= EPOLLIN | EPOLLRDNORM;
 	}
 
+	if (GET_REPORT_COND)
+		ret |= EPOLLPRI;
+
 	return ret;
 }
 
 #undef WRITE_COND
 #undef READ_COND_SSREPORT
 #undef READ_COND_INTOUT
+#undef GET_REPORT_COND
 
 static int f_hidg_release(struct inode *inode, struct file *fd)
 {
@@ -641,6 +840,10 @@ static void hidg_ssreport_complete(struct usb_ep *ep, struct usb_request *req)
 	wake_up(&hidg->read_queue);
 }
 
+static void hidg_get_report_complete(struct usb_ep *ep, struct usb_request *req)
+{
+}
+
 static int hidg_setup(struct usb_function *f,
 		const struct usb_ctrlrequest *ctrl)
 {
@@ -649,6 +852,7 @@ static int hidg_setup(struct usb_function *f,
 	struct usb_request		*req  = cdev->req;
 	int status = 0;
 	__u16 value, length;
+	unsigned long	flags;
 
 	value	= __le16_to_cpu(ctrl->wValue);
 	length	= __le16_to_cpu(ctrl->wLength);
@@ -660,14 +864,20 @@ static int hidg_setup(struct usb_function *f,
 	switch ((ctrl->bRequestType << 8) | ctrl->bRequest) {
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_GET_REPORT):
-		VDBG(cdev, "get_report\n");
+		VDBG(cdev, "get_report | wLength=%d\n", ctrl->wLength);
 
-		/* send an empty report */
-		length = min_t(unsigned, length, hidg->report_length);
-		memset(req->buf, 0x0, length);
+		/*
+		 * Update GET_REPORT ID so that an ioctl can be used to determine what
+		 * GET_REPORT the request was actually for.
+		 */
+		spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+		hidg->get_report_req_report_id = value & 0xff;
+		hidg->get_report_req_report_length = length;
+		spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
 
-		goto respond;
-		break;
+		queue_work(hidg->workqueue, &hidg->work);
+
+		return status;
 
 	case ((USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
 		  | HID_REQ_GET_PROTOCOL):
@@ -793,6 +1003,14 @@ static void hidg_disable(struct usb_function *f)
 		spin_unlock_irqrestore(&hidg->read_spinlock, flags);
 	}
 
+	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
+	if (!hidg->get_report_returned) {
+		usb_ep_free_request(f->config->cdev->gadget->ep0, hidg->get_req);
+		hidg->get_req = NULL;
+		hidg->get_report_returned = true;
+	}
+	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
+
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 	if (!hidg->write_pending) {
 		free_ep_req(hidg->in_ep, hidg->req);
@@ -902,6 +1120,14 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 	return status;
 }
 
+#ifdef CONFIG_COMPAT
+static long f_hidg_compat_ioctl(struct file *file, unsigned int code,
+		unsigned long value)
+{
+	return f_hidg_ioctl(file, code, value);
+}
+#endif
+
 static const struct file_operations f_hidg_fops = {
 	.owner		= THIS_MODULE,
 	.open		= f_hidg_open,
@@ -909,6 +1135,10 @@ static const struct file_operations f_hidg_fops = {
 	.write		= f_hidg_write,
 	.read		= f_hidg_read,
 	.poll		= f_hidg_poll,
+	.unlocked_ioctl	= f_hidg_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = f_hidg_compat_ioctl,
+#endif
 	.llseek		= noop_llseek,
 };
 
@@ -919,6 +1149,15 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_string	*us;
 	int			status;
 
+	hidg->get_req = usb_ep_alloc_request(c->cdev->gadget->ep0, GFP_ATOMIC);
+	if (!hidg->get_req)
+		return -ENOMEM;
+
+	hidg->get_req->zero = 0;
+	hidg->get_req->complete = hidg_get_report_complete;
+	hidg->get_req->context = hidg;
+	hidg->get_report_returned = true;
+
 	/* maybe allocate device-global string IDs, and patch descriptors */
 	us = usb_gstrings_attach(c->cdev, ct_func_strings,
 				 ARRAY_SIZE(ct_func_string_defs));
@@ -1004,9 +1243,24 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	hidg->write_pending = 1;
 	hidg->req = NULL;
 	spin_lock_init(&hidg->read_spinlock);
+	spin_lock_init(&hidg->get_report_spinlock);
 	init_waitqueue_head(&hidg->write_queue);
 	init_waitqueue_head(&hidg->read_queue);
+	init_waitqueue_head(&hidg->get_queue);
+	init_waitqueue_head(&hidg->get_id_queue);
 	INIT_LIST_HEAD(&hidg->completed_out_req);
+	INIT_LIST_HEAD(&hidg->report_list);
+
+	INIT_WORK(&hidg->work, get_report_workqueue_handler);
+	hidg->workqueue = alloc_workqueue("report_work",
+					  WQ_FREEZABLE |
+					  WQ_MEM_RECLAIM,
+					  1);
+
+	if (!hidg->workqueue) {
+		status = -ENOMEM;
+		goto fail;
+	}
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
@@ -1016,12 +1270,16 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	return 0;
 fail_free_descs:
+	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");
 	if (hidg->req != NULL)
 		free_ep_req(hidg->in_ep, hidg->req);
 
+	usb_ep_free_request(c->cdev->gadget->ep0, hidg->get_req);
+	hidg->get_req = NULL;
+
 	return status;
 }
 
@@ -1256,7 +1514,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 	struct f_hidg *hidg = func_to_hidg(f);
 
 	cdev_device_del(&hidg->cdev, &hidg->dev);
-
+	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 }
 
diff --git a/include/uapi/linux/usb/g_hid.h b/include/uapi/linux/usb/g_hid.h
new file mode 100644
index 000000000000..b965092db476
--- /dev/null
+++ b/include/uapi/linux/usb/g_hid.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+#ifndef __UAPI_LINUX_USB_G_HID_H
+#define __UAPI_LINUX_USB_G_HID_H
+
+#include <linux/types.h>
+
+/* Maximum HID report length for High-Speed USB (i.e. USB 2.0) */
+#define MAX_REPORT_LENGTH 64
+
+/**
+ * struct usb_hidg_report - response to GET_REPORT
+ * @report_id: report ID that this is a response for
+ * @userspace_req:
+ *    !0 this report is used for any pending GET_REPORT request
+ *       but wait on userspace to issue a new report on future requests
+ *    0  this report is to be used for any future GET_REPORT requests
+ * @length: length of the report response
+ * @data: report response
+ * @padding: padding for 32/64 bit compatibility
+ *
+ * Structure used by GADGET_HID_WRITE_GET_REPORT ioctl on /dev/hidg*.
+ */
+struct usb_hidg_report {
+	__u8 report_id;
+	__u8 userspace_req;
+	__u16 length;
+	__u8 data[MAX_REPORT_LENGTH];
+	__u8 padding[4];
+};
+
+/* The 'g' code is used by gadgetfs and hid gadget ioctl requests.
+ * Don't add any colliding codes to either driver, and keep
+ * them in unique ranges.
+ */
+
+#define GADGET_HID_READ_GET_REPORT_ID   _IOR('g', 0x41, __u8)
+#define GADGET_HID_WRITE_GET_REPORT     _IOW('g', 0x42, struct usb_hidg_report)
+
+#endif /* __UAPI_LINUX_USB_G_HID_H */
diff --git a/include/uapi/linux/usb/gadgetfs.h b/include/uapi/linux/usb/gadgetfs.h
index 835473910a49..9754822b2a40 100644
--- a/include/uapi/linux/usb/gadgetfs.h
+++ b/include/uapi/linux/usb/gadgetfs.h
@@ -62,7 +62,7 @@ struct usb_gadgetfs_event {
 };
 
 
-/* The 'g' code is also used by printer gadget ioctl requests.
+/* The 'g' code is also used by printer and hid gadget ioctl requests.
  * Don't add any colliding codes to either driver, and keep
  * them in unique ranges (size 0x20 for now).
  */
-- 
2.43.0


