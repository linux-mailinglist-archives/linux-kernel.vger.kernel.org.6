Return-Path: <linux-kernel+bounces-284432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E29500EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCD9B23955
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221F186E30;
	Tue, 13 Aug 2024 09:09:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C917B427
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540181; cv=none; b=ZDMyb4/9xjGQJjQWhb5gpTgjMRo4/KCyo0Q11SnBMvlslQC0Dkgo871lwsRFgI/bx+srzSKZU958W4RsJ+e5IcPYeupKo98Dbl4Bf1esxSZWFyb+ZZz36IQMQ6iV2kg2t+vIUSYk2Ud86reVv1VcWrcHNITtIzZ0cLi6+AxdPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540181; c=relaxed/simple;
	bh=tOZZtUbdjZ9wahn0ThvKA3Yg/KRlMGeB9xgFv0kzY3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X0dKCBykR+JDvXPU1ixFSt0Rhwvc24zzWJSeyoXZl93DtwJSFJwy4U7PZY3FI5SuPn3rDrw1d0keirBarBNzLIV2qKSCWlQ733UlplOJrf3hUirT6ZDaLKsFB43nigN4mnjseke4Jl86/euYUSrWjIf/ModeYjvIWETlKlfB8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0002CH-SE; Tue, 13 Aug 2024 11:09:34 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-0005oe-55; Tue, 13 Aug 2024 11:09:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sdnX4-00G1eS-0F;
	Tue, 13 Aug 2024 11:09:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v4 00/10] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers
Date: Tue, 13 Aug 2024 11:09:24 +0200
Message-Id: <20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQiu2YC/5XOQW7DIBAF0KtErEOFGWrsrnqPKrKwGWIkC7uAU
 SLLd88423aRLP/X6P3ZWMLoMbGv08YiFp/8HCio84kNowlX5N5SZlJIJZQAvpahi/i7YsrdhOG
 ax66/dz5kjMVM3Gh09rPRtq2BEdKbhLyPJgwjMWGdJiqXiM7fnqs/F8qjT3mO9+cTpTral/dKx
 QVvFdSD0lUtAb4XOlpznIO/fVhkh1/ke6Yks5J1K5w2Ep3714T3TCBTWaMFgLWqaf6Y+74/AKw
 Z42WOAQAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=tOZZtUbdjZ9wahn0ThvKA3Yg/KRlMGeB9xgFv0kzY3E=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmuyLGt2SIgd0Fztaj+W5aoviwk16bEplonOJeB
 2DkMUderYyJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrsixgAKCRC/aVhE+XH0
 q8UfEAC4w2FsenyUMKAkozlJPywepfP2U0saM8sqX3JNSgCwRPFDoLmHMN8Dh/C266+e2ZtIeZf
 ubf0xBTrX0cnH1AFLwFw9bzsBKxWaylWgtfeTxwd1ovJEJlO7LLNhL6dxcAcqhFo3lA2exNX/Xg
 7471j4GdHfu6HEuXmLHgmV3/Jqb/JVnvTnVuZPJYvmp+mRadLwdXcsnpTu3AClyukoABJfR40Nz
 4Np2NxCJPEEKAtah2nANT/pzCp5SvrMoC+9l0YSjei4BCxvm1eek2TNaNtgr31/P7hSYkHKjHtx
 lZvHRq8m8YrZJlqUKKoT2etvJP87uiI7czNmrY/lUEiplYsvJ39/pzgItuHzJElw0YxCRqDT66/
 xAUxin1jrPIm/du3WufNMqEVhW7xf4X+0p5HF/NO0zXoErZ4O24O9H405mzwCUUQmqdFdYfGC80
 Czsx89iHNiWdQKn66ycmSxSr0DlA1GNy1GPyWpzQsNxv8W2S43SVWeUFw4kbdOVVfCr1meJLkJX
 2FQs1H7j+rSYxdMfJ6ErR0l8HPJuVzqHgZXs/VJNSs8cOLlGJy9SK5UZ07iyxOQ+tWbIZvkOEbx
 reXAHWz89DCikiHJelPlYmQyz3HRRwqtisBmQc8RMHobLCSe6WnbH8065T+m29PJDheTIQopeYp
 P8Cs9yWBWsJUSIw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This patch series is improving the size calculation and allocation of
the uvc requests. Using the selected frame duration of the stream it is
possible to calculate the number of requests based on the interval
length.

It also precalculates the request length based on the actual per frame
size for compressed formats.

For this calculations to work it was needed to rework the request
queueing by moving the encoding to one extra thread (in this case we
chose the qbuf) context.

Next it was needed to move the actual request enqueueing to one extra
thread which is kept busy to fill the isoc queue in the udc.

As a final step the series is increasing the minimum amount of
v4l2 buffers to 4 and allocates at least the amount of usb_requests
to store them in the usb gadgte isoc pipeline.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v4:
- fixed exit path in uvc_enqueue_buffer on loop break
- Link to v3: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v3-0-4da7033dd488@pengutronix.de

Changes in v3:
- Added more patches necessary to properly rework the request queueing
- Link to v2: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de

Changes in v2:
- added header size into calculation of request size
- Link to v1: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de

---
Michael Grzeschik (10):
      usb: gadget: uvc: always set interrupt on zero length requests
      usb: gadget: uvc: only enqueue zero length requests in potential underrun
      usb: gadget: uvc: remove pump worker and enqueue all buffers per frame in qbuf
      usb: gadget: uvc: rework to enqueue in pump worker from encoded queue
      usb: gadget: uvc: remove uvc_video_ep_queue_initial_requests
      usb: gadget: uvc: set req_size once when the vb2 queue is calculated
      usb: gadget: uvc: add g_parm and s_parm for frame interval
      usb: gadget: uvc: set req_size and n_requests based on the frame interval
      usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size
      usb: gadget: uvc: add min g_ctrl vidioc and set min buffs to 4

 drivers/usb/gadget/function/f_uvc.c     |   3 +-
 drivers/usb/gadget/function/uvc.h       |  14 +-
 drivers/usb/gadget/function/uvc_queue.c |  52 +++++--
 drivers/usb/gadget/function/uvc_queue.h |   1 +
 drivers/usb/gadget/function/uvc_v4l2.c  |  67 ++++++++-
 drivers/usb/gadget/function/uvc_video.c | 243 +++++++++++++-------------------
 drivers/usb/gadget/function/uvc_video.h |   1 +
 7 files changed, 221 insertions(+), 160 deletions(-)
---
base-commit: 38343be0bf9a7d7ef0d160da5f2db887a0e29b62
change-id: 20240403-uvc_request_length_by_interval-a7efd587d963

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


