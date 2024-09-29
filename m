Return-Path: <linux-kernel+bounces-343124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D89896FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04341F2112F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D417BB13;
	Sun, 29 Sep 2024 18:59:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A56F2E6
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636380; cv=none; b=p8aWAxXpPAr4ZPm1snDW9W6vf3jiU1DSXfJOpdMVFV4O1P5vBrqM5/zxxtHM6DBMVGWMInqY8HYAT6ftqjhcq4On5s1Zp72JD6xrxmLiqtKtMNh7Co2IUWv+pdgazwja2n7aJPRUQg4chlokPyg6se0uvAIn5Chxc4XGQCDiO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636380; c=relaxed/simple;
	bh=/U43Y8aGcmzcxzXv+PaUGk5zmq/qPekProSrrAIpWOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsMJfO33waNtqqIwl5P3rEsg3DDV4VdZwZYjQfBI5zgM4sU9yoymecWPcdG2XLEM2y0+7pMlmn79hINTF9sb6oneEyDbzWGNUYCDof/6KzklBXRrtHvf8dJVe+7+ov9axKJZms4MxK53T19vWMWol6hyDXdReIzTCdCfzdiD3f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053r-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002RoA-1X; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-32;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:28 +0200
Subject: [PATCH v6 8/9] usb: gadget: uvc: add trace of enqueued and
 completed requests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-8-08c05522e1f5@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4461;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=/U43Y8aGcmzcxzXv+PaUGk5zmq/qPekProSrrAIpWOw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOSf/qznxVRZC+vvW01WhvqdVTildn7mQpTs
 pGKbVHs1miJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkgAKCRC/aVhE+XH0
 q1YgD/0WCyun+tWR3YvArZw9ZEVPGEjuRpwapw09R4ugwHgO8ymO8tCeSLwV+N1cHt/+iF9ozpQ
 m6OnXkmjgTbaNXocL8UcqiO+ThBVXOuFDMHMq99EFQu7AIFbfnYDP6fH5pSllv3B2DoWW/T7na8
 uZni47qwusES/FiYSq7YBpmHZaWSe2nu18afMHKc9ugDOWjeK2El0cnmnIB91Y3ZJYiRZ2G99QC
 2WQSF5pjL4pBXVAhh8GWjnAVGPU8U4e8ZJ3sDc7sbFw9/lFRf48pZHISSynKXG0vsdJOrwopv+V
 4dod0gF9BhtNsVZwshnnOHzTkQZVu0YYjlKU6sSAMM8L1gWElfo12XbxObFLt1ZJLJdIE6vo/Tl
 jJtN6VfwRgHnkYmWJS64w0/NLc0XaBWmPBMT2evoKQJ8rXn7CIOx1LilKOGiHCGHVUbydpyy0kn
 HKXEu5KNcdQqtTOvhAlUY6vYowJ7XaRtolgfGpZJiScAg/DzzxugU4NstVvwlByGgo7/Z4+5xhe
 swhgRwYjWZh/uGSAZosscBkHrsPVkuBOHrScs1jdme+ubagGc20zdtJCippbj1KuydoLqGMpm3w
 khRTIP5/4gVhQRgmKAMk2TX5+kZ2/Fw3cg8UVQnqUJJxLuYkXrg9OSNvM01DaJZ4czFR26YD7B/
 M39JLGMrQvEeLEA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch is adding trace events for each request that is being
enqueued into the hw and will be completed. This way it is possible
to track the fill status of the gadget hardware and find potential
issues.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v6:
 - fixed compile rule as module
 - reordered header files
v1 -> v5:
 - new patch
---
 drivers/usb/gadget/function/Makefile    |  3 ++
 drivers/usb/gadget/function/uvc_trace.c | 11 ++++++
 drivers/usb/gadget/function/uvc_trace.h | 60 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_video.c |  5 +++
 4 files changed, 79 insertions(+)

diff --git a/drivers/usb/gadget/function/Makefile b/drivers/usb/gadget/function/Makefile
index 87917a7d4a9be..92b695388611b 100644
--- a/drivers/usb/gadget/function/Makefile
+++ b/drivers/usb/gadget/function/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_USB_F_UAC1_LEGACY)	+= usb_f_uac1_legacy.o
 usb_f_uac2-y			:= f_uac2.o
 obj-$(CONFIG_USB_F_UAC2)	+= usb_f_uac2.o
 usb_f_uvc-y			:= f_uvc.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_configfs.o
+ifneq ($(CONFIG_TRACING),)
+    usb_f_uvc-y			+= uvc_trace.o
+endif
 obj-$(CONFIG_USB_F_UVC)		+= usb_f_uvc.o
 usb_f_midi-y			:= f_midi.o
 obj-$(CONFIG_USB_F_MIDI)	+= usb_f_midi.o
diff --git a/drivers/usb/gadget/function/uvc_trace.c b/drivers/usb/gadget/function/uvc_trace.c
new file mode 100644
index 0000000000000..d384f6d8221a5
--- /dev/null
+++ b/drivers/usb/gadget/function/uvc_trace.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace.c - USB UVC Gadget Trace Support
+ *
+ * Copyright (C) 2024 Pengutronix e.K.
+ *
+ * Author: Michael Grzeschik <m.grzeschik@pengutronix.de>
+ */
+
+#define CREATE_TRACE_POINTS
+#include "uvc_trace.h"
diff --git a/drivers/usb/gadget/function/uvc_trace.h b/drivers/usb/gadget/function/uvc_trace.h
new file mode 100644
index 0000000000000..04c33cf43cc2d
--- /dev/null
+++ b/drivers/usb/gadget/function/uvc_trace.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * trace.h - USB UVC Gadget Trace Support
+ *
+ * Copyright (C) 2024 Pengutronix e.K.
+ *
+ * Author: Michael Grzeschik <m.grzeschik@pengutronix.de>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM uvcg
+
+#if !defined(__UVCG_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __UVCG_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include <linux/usb/gadget.h>
+#include <asm/byteorder.h>
+
+DECLARE_EVENT_CLASS(uvcg_video_req,
+	TP_PROTO(struct usb_request *req, u32 queued),
+	TP_ARGS(req, queued),
+	TP_STRUCT__entry(
+		__field(struct usb_request *, req)
+		__field(u32, length)
+		__field(u32, queued)
+	),
+	TP_fast_assign(
+		__entry->req = req;
+		__entry->length = req->length;
+		__entry->queued = queued;
+	),
+	TP_printk("req %p length %u queued %u",
+		__entry->req,
+		__entry->length,
+		__entry->queued)
+);
+
+DEFINE_EVENT(uvcg_video_req, uvcg_video_complete,
+	TP_PROTO(struct usb_request *req, u32 queued),
+	TP_ARGS(req, queued)
+);
+
+DEFINE_EVENT(uvcg_video_req, uvcg_video_queue,
+	TP_PROTO(struct usb_request *req, u32 queued),
+	TP_ARGS(req, queued)
+);
+
+#endif /* __UVCG_TRACE_H */
+
+/* this part has to be here */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE uvc_trace
+
+#include <trace/define_trace.h>
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 0287a56fa50ad..115524b79ebd7 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -19,6 +19,7 @@
 #include "uvc.h"
 #include "uvc_queue.h"
 #include "uvc_video.h"
+#include "uvc_trace.h"
 
 /* --------------------------------------------------------------------------
  * Video codecs
@@ -271,6 +272,8 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 
 	atomic_inc(&video->queued);
 
+	trace_uvcg_video_queue(req, atomic_read(&video->queued));
+
 	return ret;
 }
 
@@ -408,6 +411,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 */
 	queue_work(video->async_wq, &video->pump);
 
+	trace_uvcg_video_complete(req, atomic_read(&video->queued));
+
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
 	kthread_queue_work(video->kworker, &video->hw_submit);

-- 
2.39.5


