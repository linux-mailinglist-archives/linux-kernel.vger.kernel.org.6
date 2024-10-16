Return-Path: <linux-kernel+bounces-368161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB939A0C18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B787B256A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3F20F5AB;
	Wed, 16 Oct 2024 13:58:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411820C03F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087107; cv=none; b=CMytzLReYQAbuq6jDTlqqft/sUcWVVKgvtnVAj4dFS9C8hwVrf8a1jwke+dY9ykevnE0eXJ0y8oIkEMSN88r5c3zeyascl7y4mfj0s35khmDikEzjnJGq+pSOjcHgun7NbwBkd04vKFkGZQd68Z6mhXMb697H2unJr2r6jXYlx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087107; c=relaxed/simple;
	bh=p1xoTdRWHxbpJYFPocjjD/k91A3hz/ET82iys+wS7Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlLaot25yXyv52xin+dO18o9mwKt9CYMkfceqIiUdRNOwHpNW86UL3ffrxfzx163jWv8/2JC8y7K8edMtbIxLCvY81S2DaRUYu3FFoMf7+XG6IWcDNx5g9aUtz7sih+2x8WW2n6J+JVdtaDRbn9sDIE7JL2n7VJutI7w0L8Itbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-0003H5-PT; Wed, 16 Oct 2024 15:58:21 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xd-002HjG-3B; Wed, 16 Oct 2024 15:58:21 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1t14Xc-00BU5S-3D;
	Wed, 16 Oct 2024 15:58:20 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 16 Oct 2024 15:58:12 +0200
Subject: [PATCH v7 7/9] usb: gadget: uvc: set nbuffers to minimum
 STREAMING_MIN_BUFFERS in uvc_queue_setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-uvc_request_length_by_interval-v7-7-e224bb1035f0@pengutronix.de>
References: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
In-Reply-To: <20240403-uvc_request_length_by_interval-v7-0-e224bb1035f0@pengutronix.de>
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
 bh=p1xoTdRWHxbpJYFPocjjD/k91A3hz/ET82iys+wS7Os=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBnD8Z7Om6EfinVW5Cow+C1IkkkMK4IdC0diReNx
 dzxIDjTu0CJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZw/GewAKCRC/aVhE+XH0
 q6uwD/0aizggiuVqSZMlzlvvriGjXgtsSLE3YyciXl3VVz5Hs1+fMvak+5wYsSXZ0IXcC4M+bWd
 XEhD6DsTGUlO0bXXnazYZ/JgPf+BUlegErqjYXAv9rDwVjprPQ1zaAEhAmCjX+0zJeI8y5azG0I
 aJcIb7qpsDGzL3406CvEAVj1bPq6e5bce7Uk2mmTnkAUiyVEIGoVheN9h2/blQ9F6gJyBfL1ziy
 mojFkGODORs5Zj0kXMu1YGY7128C1/8PyplPQw2uJwaXqsaCNCnDhL6jnMgHXhjNZOaHAepluEL
 KEglKE4ndvQlnRsBTmvtENL3SM0EQ0XklyDQt3UWvwNE1QHJHXsAAV9xARR/YNu73uEnFCYvjTu
 imiR5FostREvwqVmUB7cUMIqHTBDrjrKusRbnCmgBoKf00pFKEM13QnDN3xkTDr2+YL036VH9xj
 hrrIDElEZ2bxzVbDc8kKyR9yo6/TWJl2MNea6S7EHElESFo00khtO/13a9gaP7q81yCXD+FmeqU
 WLBAb1/YJ7R70lRW2MZv0TEIB4I9sxUt2QWkAL0BzCYZpH2G5NLGWYGHdtjDAP8YawUNCfXPbVP
 w5llwQ4oLrpYZ7I9+iWXh3YL5R1cLO7i39aE+qa17nKvpMS1ZRXYnf8+YyZdgrKqGcNOVIoaTtF
 UEHR2p13Grmj7MQ==
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
v5 -> v7: -
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


