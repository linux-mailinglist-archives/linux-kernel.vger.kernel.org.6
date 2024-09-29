Return-Path: <linux-kernel+bounces-343123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A751F9896F9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674ADB210BA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2F16B391;
	Sun, 29 Sep 2024 18:59:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DCE6BFCA
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636380; cv=none; b=Acpdz6psY9QppUAo8ds5s+QuDro++98hw/RvefJ3GSJA59Lod8FqKr1hMiwwmh2Pjf/wSdBDYfgRrYmMbUJlKzjXCXVSQDo5f6gIJiVVi9vkjnYRVAsIKJogtl9PwpDiH+Djp3xnMfBGgBunD4MUZY/z+PlmhmntiGj76g7a5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636380; c=relaxed/simple;
	bh=vDOpCLv2CodGLKEpn/CIA0Ki8MmgeH3jN/oYwO6TfJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCsHMa1oX1kt1xT1eHM8U5sU9pSDK7j2uilfzk6oXI+lMva2/ny5hUgRqWgsOjmqkLW7WSXz7aOzG0UgBZuWtRwrFESHj6EG0kWZ4Skk+MCjTKau+UYbss8u2si5caVGmdXpr4UCNsod6Npt5k7e4lRyDWE6tg2P7hDzTUp3dDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053q-KM; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-002Ro9-0s; Sun, 29 Sep 2024 20:59:31 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-31;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Sun, 29 Sep 2024 20:59:27 +0200
Subject: [PATCH v6 7/9] usb: gadget: uvc: set nbuffers to minimum
 STREAMING_MIN_BUFFERS in uvc_queue_setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v6-7-08c05522e1f5@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=vDOpCLv2CodGLKEpn/CIA0Ki8MmgeH3jN/oYwO6TfJ4=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aORsM89Bni7vKaUD/qPI80rRYmZGWy9Rh52m
 4mCe1TQJLqJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjkQAKCRC/aVhE+XH0
 qwgSD/wPcPsDKNVphESBHZPbJMp4JgvWOw37Xa9EBmM+e3SDYuEmcZWVOI/cZSwEEBww7klDLFP
 AqjPzXtJGCqxaCn33AMtp5e0bJNhr83bonSn1epfwrc67u4BslyR9ZM4CkdLHp1ZrZaodeG7l1L
 0kpJGFjbmCLIXMSDLhfcPxcB7i8jZQWKH+YWTno1C42bNh7Ui0VfcOfhubTq6n54LdCLTPlmcwW
 M6c7EkczeCCARyOJrGhepZl/ijLw/hS+4SU2ef5ldoJts9D89ws7+JiVIFRrCXwukpcVXCa0Pfc
 nanbrgS6L4i8MSzIkQ3axtvgPtEXLy02hfOCp19lOHMlhV2D0tQIjPiGuTMKpkE1UWI0ijnT+yV
 xIRKAvdpl6/80OSXihT6n2UdsIuw87RRx5oN83WldDPL/oSWUIJEiyekwI/akmiEF0y+e1ydMxG
 WG5VcxMuIx7kfuLGNXjnbaoBBMx59d620ve+IEPvDSDD9WBlDJYQ/15A/2M/WLB+iSxAT6UWQN5
 l+ETST3KIB4tVtQ0pAxCQqH3WLwSjJ8DmuQBPl78CB/bz6dJtezuoETSNk12UbcdHisYvMJvrZd
 Ru4ZtsXn8nzf1P5sRv/2vfcaTl+YJyCl+j2PKv/CPpRaf1Jcd1qjcaCsxRsLQqsmS3V7sNe17R+
 n32ZctIf26wLSEA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

We set the minimum amount of v4l2 buffers that is possibly be pending
to UVCG_STREAMING_MIN_BUFFERS which is two. This way the driver will
always have at least one frame pending to be encoded while the other
is being enqueued in the hardware.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
v5 -> v6: -
v4 -> v5:
 - using STREAMING_MIN_BUFFERS set the min nbuffers
 - renamed the patch since the function changed
 - removed the g_ctrl function
 - reordered this patch in the series
v1 -> v4: -
---
 drivers/usb/gadget/function/uvc.h       | 2 ++
 drivers/usb/gadget/function/uvc_queue.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index bedb4ef42864f..6f44dd7323150 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -74,6 +74,8 @@ extern unsigned int uvc_gadget_trace_param;
 #define UVCG_REQ_MAX_INT_COUNT			16
 #define UVCG_REQ_MAX_ZERO_COUNT			(2 * UVCG_REQ_MAX_INT_COUNT)
 
+#define UVCG_STREAMING_MIN_BUFFERS		2
+
 /* ------------------------------------------------------------------------
  * Structures
  */
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 6757a4e25a743..5eaeae3e2441c 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -21,6 +21,7 @@
 #include <media/videobuf2-vmalloc.h>
 
 #include "uvc.h"
+#include "uvc_video.h"
 
 /* ------------------------------------------------------------------------
  * Video buffers queue management.
@@ -47,6 +48,8 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 
 	if (*nbuffers > UVC_MAX_VIDEO_BUFFERS)
 		*nbuffers = UVC_MAX_VIDEO_BUFFERS;
+	if (*nbuffers < UVCG_STREAMING_MIN_BUFFERS)
+		*nbuffers = UVCG_STREAMING_MIN_BUFFERS;
 
 	*nplanes = 1;
 

-- 
2.39.5


