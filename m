Return-Path: <linux-kernel+bounces-343120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174AE9896F4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F331C20930
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862B74059;
	Sun, 29 Sep 2024 18:59:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21155E53
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727636379; cv=none; b=L8coH6BXrbFtSeSHgiUG5v+HO3vXCAPL+TjkcJXfrfz6+m5yr9f/Y0X+3wtetKDrWIRjtM4t/o/gk0yyDb6jJ/9sV4o/TMVS4xvMHNDD5KNCvfyKBg3W3fSuhLyU9etFINCIClvY/6DsDKOpCTXOKZW54UF3LXTmqOzdQoWH2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727636379; c=relaxed/simple;
	bh=DBByY8mttVZ5H5VD0vsSgB1v9bTYRyRgpVk1H6Ih54o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FFfWKNwF4fmfI8MOC9xvY1tP++XfB2pB12ne/U4aL9S1HEp/jB7rdJ6852HMSKzM+1j3b2KNs8JJO4aFhSsg/+miPypcExxj3UnynB4gjfurjqS92Zv+6UE8EoMeJJL9ZlKbgYW1t09u7yaoPAGYsA7SQUxfk+uuneAjdWt/dPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8l-00053m-KL; Sun, 29 Sep 2024 20:59:31 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-002Ro3-V6; Sun, 29 Sep 2024 20:59:30 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1suz8k-0029Vj-2u;
	Sun, 29 Sep 2024 20:59:30 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v6 0/9] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers and fixes
Date: Sun, 29 Sep 2024 20:59:20 +0200
Message-Id: <20240403-uvc_request_length_by_interval-v6-0-08c05522e1f5@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIij+WYC/5XQwWrEIBAG4FdZPNdiRqNJT32PUoLRcSMEs1Uju
 yx595q9Nofm+A/D9w/zJAmjx0Q+Lk8Ssfjkl1CDfLsQM+lwReptzQQYCCYYp2sxQ8SfFVMeZgz
 XPA3jY/AhYyx6plqhs22nbC85qcioE9Ix6mCmyoR1nuvwFtH5+6v167vmyae8xMfriNLs03/3l
 YYy2gsujVCNBM4/b3VpzXEJ/v5ukex+gXMmVLMB2TOnNKBzhyY/Z/JqCqsV49xa0XWHpjhnimo
 aDeA4FwASD832nNlWEyyqTu1fbc0fc9u2X2MfXbk2AgAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3952;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=DBByY8mttVZ5H5VD0vsSgB1v9bTYRyRgpVk1H6Ih54o=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm+aOJ6Clr2ObwoIh4xGvNowwqlHTJlni7HlcT/
 9RRsLxwcteJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvmjiQAKCRC/aVhE+XH0
 q1z6EACFu7AhcbV9rv4dVQsb3lTO7Q3hcTyuvv0Vd14QwcIFbDfmoxPMA1/Y7N6YL61JEpCCzez
 2aS+Ao2lmzKtsIwwcRFws8Df+HIPH4Hdc6Ic4MkNRXdb0l6HWaszuos7q9jn6snPWk0rv/6L/xw
 ZpF+x8EY5Yscu9RXr0h+Lv0tV5svCgxQ8wtNeAG+/Dbiv6IU+y/q8HG54EEkXA81q3WKzqkJTim
 i0UG6FyE+9NnQC5aqDhBklTIFd9oMbcu6cy5qYWKCT9fpeqL7yuqc4DMBNWB/qTZ+t0z2oouKHs
 5pRkwai40ivBVqX8S6sZKcz3q4lQ7dMxQ4zKEwIyvtFtRtcrg5oLrEjXL2BOKfSW3BPcHFYo//H
 s2t9ibJ8cq7dHj1R5rf0WlRkrPSGZzYpBGrTdFqKPqjgCisaozzlPa2zVR/6VmcDXO8StEynLhm
 TdDywgDLPJijCWLeSnQIMUP6V2/6lB5kZzypn5evIMsqW6Oh8kjff3zgfv8Xzdw4QdFSzdT1zkB
 yy4ue+uynWVAZeDptXmT4WbsUW9pF2GpF/ztpdoOHXUcSnLC0t6XLjxPXrva9pE7G4/Cz2gkS77
 8hzLpu1l5ZHwH0mbryZunkA9zrP3lKj3gRBiu6Nts3doAuUEzS7yZ9jJ/GhzpDYZvqXAtTl7YrS
 a+G6uLi7TczdNlQ==
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

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v6:
- fixes in: ("usb: gadget: uvc: add trace of enqueued and completed requests")
- Link to v5: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de

Changes in v5:
- dropped: ('usb: gadget: uvc: remove pump worker and enqueue all buffers per frame in qbuf')
- squashed ('usb: gadget: uvc: rework to enqueue in pump worker from encoded queue') and ('usb: gadget: uvc: remove uvc_video_ep_queue_initial_requests'))
- squashed ('usb: gadget: uvc: set req_size once when the vb2 queue is calculated') and ('usb: gadget: uvc: set req_size and n_requests based on the frame interval')
- replaced ('usb: gadget: uvc: add min g_ctrl vidioc and set min buffs to 4') with ('usb: gadget: uvc: set nbuffers to minimum STREAMING_MIN_BUFFERS in uvc_queue_setup')
- added ('usb: gadget: uvc: wake pump everytime we update the free list')
- added ('usb: gadget: uvc: add trace of enqueued and completed requests')
- added ('usb: gadget: uvc: dont call usb_composite_setup_continue when not streamin')
- some patch reordering
- Link to v4: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v4-0-ca22f334226e@pengutronix.de

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
Michael Grzeschik (9):
      usb: gadget: uvc: wake pump everytime we update the free list
      usb: gadget: uvc: only enqueue zero length requests in potential underrun
      usb: gadget: uvc: rework to enqueue in pump worker from encoded queue
      usb: gadget: uvc: add g_parm and s_parm for frame interval
      usb: gadget: uvc: set req_size and n_requests based on the frame interval
      usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size
      usb: gadget: uvc: set nbuffers to minimum STREAMING_MIN_BUFFERS in uvc_queue_setup
      usb: gadget: uvc: add trace of enqueued and completed requests
      usb: gadget: uvc: dont call usb_composite_setup_continue when not streaming

 drivers/usb/gadget/function/Makefile    |   3 +
 drivers/usb/gadget/function/f_uvc.c     |   2 +
 drivers/usb/gadget/function/uvc.h       |  13 ++
 drivers/usb/gadget/function/uvc_queue.c |  26 ++--
 drivers/usb/gadget/function/uvc_queue.h |   2 +
 drivers/usb/gadget/function/uvc_trace.c |  11 ++
 drivers/usb/gadget/function/uvc_trace.h |  60 ++++++++
 drivers/usb/gadget/function/uvc_v4l2.c  |  55 +++++++
 drivers/usb/gadget/function/uvc_video.c | 264 +++++++++++++++++++-------------
 9 files changed, 316 insertions(+), 120 deletions(-)
---
base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
change-id: 20240403-uvc_request_length_by_interval-a7efd587d963

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


