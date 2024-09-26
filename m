Return-Path: <linux-kernel+bounces-341162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897B987BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA9D1C22F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9F1B29D7;
	Thu, 26 Sep 2024 23:37:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4D1B07C2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393874; cv=none; b=Fz61ryfJumx2heD9Yzep4kGuQMrIMT1alX1gqtvsylhaOlGW2qQIHRCXJHOQCLm6iN4mf92fKyn26Np7K1sThsKMWpJcRJEOu9Q1FpN5EJo1LW3UwBRQLm8XPpqdxYWKR1uRCvMRD4ZrBy3dINhCfIEL6Y+Xk3x7nQD5+1ZVh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393874; c=relaxed/simple;
	bh=VlRem29ucC+ZWWE+AHehS7FAtKKyvZ57k+KTI5b6wDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nz2hqB1gHc7j9JkB0+mrq/DJ6xUgQt43T57Zq/rS4EhJpxNXe7ISBso2AEnXfrqGiUv+bgsencnOUPYzxwtG3keHF7d86ujc5xgm1wEhbfch2TQseJ7JhkQfXzgv1judcjp0yhLnfM4zBw+9m6l+WVRxiUSm/ak7QsL3ubTNJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3N-0007WQ-5C; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOZ-F4; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-2z;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Fri, 27 Sep 2024 01:37:47 +0200
Subject: [PATCH v5 8/9] usb: gadget: uvc: add trace of enqueued and
 completed requests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v5-8-2de78794365c@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4417;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=VlRem29ucC+ZWWE+AHehS7FAtKKyvZ57k+KTI5b6wDg=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBHDQXHElrvv/5Z4Ckfoxzv2S0Lc53+rO3on
 m9GF92+S6uJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRwAKCRC/aVhE+XH0
 q8MUD/0aO99vLHJlXPsRlCXFwFFg9kge+w17rxzW8sCT8p61UaQTccYRVEA3MGJjEA33ywaFXiQ
 zT2t0DstAVsCeEoxXRmzolHOXjaPdU8UbvqGT50RxwPo5Ymuskj3tyFo5THB6CLZD6oE7K7AG1a
 4+jbQOuhXXjWUdOFm4CCZy4eb0Pxw6onDFwI/25V2RAaE5Wf2bQ15kKysyLIcgRQB3bIs9sxy2Q
 oFi3YVqmoSFqJLxxUmiOMecw6CF6bC6DoyYE8av4UUfHP6PuWc5wQfCUc9eu+2PbWyVocS+qQyz
 Vo10W1JD8zxRjxosRTGVvv0FbkQaALqr1wBHuIaBZkB36iF/fIwObYGLFnj8HkirVxXMCXKeByV
 7fMioJGaSuYCtzdcWAEbspkxGWjH5SSQB52Hdu1LIqp6VbXbOmAnLtsxmjmCUCfJ3ucEbYwpaBB
 hwPVKbVKKlgbzCAdApygS+QMWal0HpeKX7To4B0weL6EmqU7+ZsdJFVYLpiGwCE371epTn9OiU8
 GVQ7TB/L135nVzunOHZvbeXrCscUZEeZyteMWOBZIIthDNBKKE6CjTQGpYYfM6QXwIrA5neer/C
 RkX3N68LRsaUfM2VXVoDdoGxgGUvnyMyIRepBilFxSobTJYo33jessTbnhIdRIMX0SSNv4DbTNS
 47r2PFsBHfHApJQ==
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
v1 -> v5: - new patch
---
 drivers/usb/gadget/function/Makefile    |  5 +++
 drivers/usb/gadget/function/uvc_trace.c | 11 ++++++
 drivers/usb/gadget/function/uvc_trace.h | 60 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_video.c |  5 +++
 4 files changed, 81 insertions(+)

diff --git a/drivers/usb/gadget/function/Makefile b/drivers/usb/gadget/function/Makefile
index 87917a7d4a9be..99b2bab4cc32f 100644
--- a/drivers/usb/gadget/function/Makefile
+++ b/drivers/usb/gadget/function/Makefile
@@ -42,6 +42,11 @@ usb_f_uac2-y			:= f_uac2.o
 obj-$(CONFIG_USB_F_UAC2)	+= usb_f_uac2.o
 usb_f_uvc-y			:= f_uvc.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_configfs.o
 obj-$(CONFIG_USB_F_UVC)		+= usb_f_uvc.o
+ifeq ($(CONFIG_USB_F_UVC),y)
+  ifneq ($(CONFIG_TRACING),)
+    obj-$(CONFIG_USB_F_UVC)	+= uvc_trace.o
+  endif
+endif
 usb_f_midi-y			:= f_midi.o
 obj-$(CONFIG_USB_F_MIDI)	+= usb_f_midi.o
 usb_f_midi2-y			:= f_midi2.o
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
index 0000000000000..43b9544d56550
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
+#include <asm/byteorder.h>
+#include <linux/usb/gadget.h>
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


