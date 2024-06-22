Return-Path: <linux-kernel+bounces-225893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BACB9136FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375051F23896
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAD412D762;
	Sat, 22 Jun 2024 23:48:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1712B145
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719100126; cv=none; b=PDMxvkG9zV72Xjfj7dZEDOAopcMuYzBkm5AnQPn/FDIsdfBzNlvoX+yR2ZSj/PxuFI5rdJDhjCd9z4XPyRHbE5he+RnpspoXx7B1lpVk33FaJz73NMkwHP59CLB7CBIB21lyBGsIlBBKBnOddb1mXPSJ3lj5kY55UCJgKvv++Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719100126; c=relaxed/simple;
	bh=m3nqbwFmxC7Sdo+IHnK+iwQesH4KewnXiM7V15nf970=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s4M0NJjQc+Qge7yqh5MRldH+dOZoJTnwEWNmkKWqrKDg6eMhZht3+v+Q6ZE3qCTyMyP7B/sqJR2YpzfMLu1DOO1Lh9bxc5YL1h6ZdP2HjL67/MD2haRV7Cyv5z6iTMtTpSV0Mi91/gu8BB7f9QPTvFnnBFd10frEReIripZ1bCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATD-0002ce-5F; Sun, 23 Jun 2024 01:48:35 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-004Hkb-Gp; Sun, 23 Jun 2024 01:48:34 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1sLATC-000IWx-34;
	Sun, 23 Jun 2024 01:48:34 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v2 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Date: Sun, 23 Jun 2024 01:48:28 +0200
Message-Id: <20240403-uvc_request_length_by_interval-v2-0-12690f7a2eff@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxid2YC/42OTQ6DIBhEr9KwLg2C1dpV79EYgvApJAQtf9EY7
 17qCbp8k8mb2VEAbyCg52VHHrIJZnYF6PWCpBZuAmxUYUQJrUlNGE5Zcg+fBCFyC26Kmg8bNy6
 Cz8Ji0cKo7o9WdQ1DRTKIAHjwwkldNC5ZW8LFw2jWc/XdF9YmxNlv54lc/dK/93KFCe5q1si6r
 RrK2GsppRT97Mx6U4D64zi+42RfduYAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Avichal Rakesh <arakesh@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=m3nqbwFmxC7Sdo+IHnK+iwQesH4KewnXiM7V15nf970=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmd2LOtxKs5J/GlQj+sLuSzvSeP9/uRy1Iau0UA
 m+htolwfYuJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZndizgAKCRC/aVhE+XH0
 q9zxD/4ivwgzq2L1KHYwlp03H/3g/WNdaIqHnPOv8uMVo4A2IrU8eZMeFSLUlzLkoZozBXEB8wY
 ub6TcDLybYBt79DBWRYiWQIlRdCtT87JhUzETedwKgcWwUGu1/4uKaIGJwj/HRyz8j5YMyW15mM
 vmjhIlM8UpXZO8aUEdpndlTjS0asY78RFJNFuY8NO0e91GaKMe21Jo9/J4fpR9jpyLd8FgPDBJt
 1bpKUYyynT5Lf48Yh8qMyZPx8jUYgVvoZw177zF6sedCdphXDOanLwwIwWc+Cegpo17xbs4VQi3
 BJ3W0+whdW+HIkEBEKD4qKtFJOsAEXNxzjl65Oi1l+Xb8M5kgfRazlIXKbE8GYKOtXY9eE9EYOI
 ehGZal5IUbWZAS1XK4Al+TF9PNe7SDNC0QtrHC2KYv6zXyaGy/ckQYjfD2arRvXY+mBQsTRr7pK
 OBQ5Rhm0O/URsyrx8JMLXJIboEKO7ESeE4QTkNGtl/hJk1mhpsDzWzdKtKoSgOA8KElgL3KarHm
 /jZT0sd7vT074n6X00Db9wuOUAnDWra5pBKEYteuXGna/E6VolUe+ZeeKZuPg4KD1oe18EDhgt8
 8XgtIGrYrJn0EpppTSAgnu8Xo4cSQByqttprFLvp/FdH6DSvZ9h02FdSbRRZ9z1iMn8L/njaj6/
 9FYmaHKbyai0EOg==
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

This is an preperation to precalculate the request length based
on the actual per frame size for compressed formats.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- added header size into calculation of request size
- Link to v1: https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v1-0-9436c4716233@pengutronix.de

---
Michael Grzeschik (3):
      usb: gadget: function: uvc: set req_size once when the vb2 queue is calculated
      usb: gadget: uvc: add g_parm and s_parm for frame interval
      usb: gadget: uvc: set req_size and n_requests based on the frame interval

 drivers/usb/gadget/function/uvc.h       |  1 +
 drivers/usb/gadget/function/uvc_queue.c | 32 +++++++++++++++-----
 drivers/usb/gadget/function/uvc_v4l2.c  | 52 +++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc_video.c | 17 ++---------
 4 files changed, 81 insertions(+), 21 deletions(-)
---
base-commit: 819984a0dd3606b7c46fe156cd56a0dc0d604788
change-id: 20240403-uvc_request_length_by_interval-a7efd587d963

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


