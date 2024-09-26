Return-Path: <linux-kernel+bounces-341159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C1987BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726571C21267
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A21B14EA;
	Thu, 26 Sep 2024 23:37:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D71B07A7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393873; cv=none; b=PZ6Y4hcL5zJkxvcuZHR+F+vPeRAAWuvdGT/78eTrRa7qLlPjnlTnm3XF6GeNSLNcTnM2du56ZpqAf4bnY6WlfpxIXzdj78gqVsajAdzK6ZXL4xlAlbdbJNsgutwUI6X7Lv9WsZjRUSAhYoQKEChhdKEAQPmmdZ8XMKgaoTtEQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393873; c=relaxed/simple;
	bh=GlxGAsd23VV3lUatm50JekhYbc4Lb1uZFg1dGAKjLpM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oYf8Zt+IggviZVUVzO8O7rCXT1KqGyC0oqJRzgVYgbnkKH/K69RpcVnmhFb1A98qTALcc45dy2kAbdCRWKjb/LHTBi9qm1VqmafUZXHhV7KtezEIqcX7zz+EedKogC45sQuF2UcusoLnA2UOhkmpWfEtGyzAKIIvAS7gapSAe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-0007WG-WA; Fri, 27 Sep 2024 01:37:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3M-001nOR-Bw; Fri, 27 Sep 2024 01:37:44 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sty3L-005IAz-2r;
	Fri, 27 Sep 2024 01:37:44 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v5 0/9] usb: gadget: uvc: effectively fill the udc isoc
 pipeline with available video buffers and fixes
Date: Fri, 27 Sep 2024 01:37:39 +0200
Message-Id: <20240403-uvc_request_length_by_interval-v5-0-2de78794365c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEPw9WYC/5XOQW7DIBAF0KtErEuFZ4ixu+o9qsjCMMRIFk4Bo
 0SR7x6SbbOol/9r9P7cWaLoKbGvw51FKj75JdRw/DgwM+lwJu5tzQwESCEF8rWYIdLvSikPM4V
 znobxNviQKRY9c63I2WOnbN8iq8ioE/Ex6mCmyoR1nmt5ieT89bX6c6p58ikv8fZ6ojTP9t97p
 eGC9xJbI1XTAuL3pR6tOS7BXz8tsadfYJ8J1Wyg7YVTGsi5tybuM7Ga0molEK2VXffWlPtMWU2
 jARyiBGjpj7lt2wNpzBZS4gEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>, 
 Jayant Chowdhary <jchowdhary@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3740;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=GlxGAsd23VV3lUatm50JekhYbc4Lb1uZFg1dGAKjLpM=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBm9fBElV8xAqHyzYu7qi70YDMg8PlNRKx/wNvpK
 ols7x1TVOGJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZvXwRAAKCRC/aVhE+XH0
 q5mQD/0TR7UGdUVUyrruEl8g5Qe+9mpCYh02ntGclBOuMIP4JdtihGQ3ol4rgUo/OxyQecByjF3
 wC/bGOUQcwBnJpQ7uYXg+QPsaIAs9IEgI76W/x1Zr5tsyWS4R/+0w2V2qu9WziwZI4AVBXSor6s
 T+M/5mmEP/yAFh4WAt7eb8FbukZkfxFREF4KBTk+i+b2rM8GK+mriUjwI00zlVnoYIG2+qDUohw
 cNjmqXi1hE2uomDpwCmc2rFoqCe0K7WosWl/RD8cT8Gc/dpHkMq95tmXesBzO3Pq7L7O9cDx0jS
 4cT9kjc/p1gCIbADlTWQwd5wa20YwvBJorCz4Dh2XIZ5d0pIeQ8PoWT2ta56q1nb2ZXKW3bVFaq
 s6NS9a3SygaYAuX+L1eNbv7S+1AsHBItD+kLJfeoJS7BUxHdEY3yQwcfVoxuOorxg9WaDJ9Z++X
 yZOyKHxx2e1DicCdqe4QZ5OrAEPG57d0o735EqYY/nVQtveWggETWQPpPByX4owTlPnSqpqEZCF
 p6Dkhq/avGkWnjCzyzN2iMfB/PHDXtK7YuOETTDFpSRPR+9huScojXOCPUtf5fxp+Pz2yj5x+sf
 MK30h8AFaSqkJsE2fIFP0UPjsaOBXOsqhR4HNdr1y1JOVJRFaw3OJGV1E3lqLH1tUD3nezTxC0w
 bl9YB/5QlQ67xSw==
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

 drivers/usb/gadget/function/Makefile    |   5 +
 drivers/usb/gadget/function/f_uvc.c     |   2 +
 drivers/usb/gadget/function/uvc.h       |  13 ++
 drivers/usb/gadget/function/uvc_queue.c |  26 ++--
 drivers/usb/gadget/function/uvc_queue.h |   2 +
 drivers/usb/gadget/function/uvc_trace.c |  11 ++
 drivers/usb/gadget/function/uvc_trace.h |  60 ++++++++
 drivers/usb/gadget/function/uvc_v4l2.c  |  55 +++++++
 drivers/usb/gadget/function/uvc_video.c | 264 +++++++++++++++++++-------------
 9 files changed, 318 insertions(+), 120 deletions(-)
---
base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
change-id: 20240403-uvc_request_length_by_interval-a7efd587d963

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


