Return-Path: <linux-kernel+bounces-403312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33649C33F6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 18:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDDE1F2123B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229713A868;
	Sun, 10 Nov 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhIPJ3wK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D04D8D1;
	Sun, 10 Nov 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731259314; cv=none; b=lNP63zfKOwc1ByXhFGKnw0u/RDg1cPGpcNFmf3ETEumDAiFx0ySAx/gvM2pqRClayxC/0x73AtngY/rN/UXawP06iJB7+h0hdFm2zrsecq/VsWxQ1GjI9cp6kL5k++Sui1ApnSecnIk0NUmOAYnweF36Ab8FqiCcQ3fszxu+5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731259314; c=relaxed/simple;
	bh=2FcSsXY+10WWOV0Bi0RlXieUG2QaCbLbUd6Z5ZVXiMM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=m4ddEd1l7rSXOnwT/uEO0QtBmOU5wkVTNSOtr4aEQc9oHv+V4n6EI6+tMR3SEXEVH7dduyaFtM4nizFVSrVwJKVFYvyqAtEb+/+YywipF6d1UUpslV/wI3H0SNUbwefyJMF+l5A8YnCiI2qJGkbBFRoooQjG4REBB6EQPyiWkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhIPJ3wK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eac969aso21251445e9.1;
        Sun, 10 Nov 2024 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731259311; x=1731864111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mokPi9ZL3cxamUAuRmzofp9mo1EVl430YFmYNrUNf6s=;
        b=OhIPJ3wKwF4IPU0fgLE4rm1pT2V3RndZpJ7Wp/X87obuT0HDn/TDA5ZZhYhBX8Ifk6
         RZBXCI4NsNfWcQ0kgz99szZHNAru+Vi4Xedo9S0JLp53GqG21QmITtZEN4YDDkqcwUB5
         s5atgwdxoDX4j/uGZ9TJEc/rG0yDe0tfP2n+RfvjUPXZ2FVoDC4vPFWSTgtiL366rBSG
         d0Gc+OnbB3OFB+fniwJCG2UZeZorBC71d37eFNKljb/EXEivR45XtD1tkpC5Gp6Ya19F
         ZfxtzLSwDqSSjdTsreOh37wnpq1w6dUnXseNIMjTwu1bqNsfXEXGB7OFDUQFyd75w0uZ
         0skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731259311; x=1731864111;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mokPi9ZL3cxamUAuRmzofp9mo1EVl430YFmYNrUNf6s=;
        b=BrYKq/+vcXPPb1jwEhvcchdtRSylRGASmAG5/62GwI2/v6XS7983JKuFcr5OBg1n5A
         RWxF3wE50pA5ym+hEkgKYakTgwxH9zbkaQ2QRDelmauJ2NapePs1smz9dXupZnp48Erv
         xn/H9Q68y+jeNt6oosYWO0hUjIyxJyVdkkzgKZ49VGD1stM4JjXhTaoBo5cZLGjFPQbh
         Z+Wphq0t8mDDAo3J0zY1TTG1WDmP0iSdN3Fy2MV6uiXBJkLfzMj8TXwNElsP0oB/PrEJ
         RN6bTbV0RWQspyB5cnU0CTv8KPAXMSa8J/P/r8mVo+t2nvxejgexZRXXzwCjNjJtEWyA
         +1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHX5PuEiX+Mn5g6tVsu2vQk92r2y8Sg5cSwiQnnH4N8aEAmag4DF7n/iygTsfFCz2szz0pYyYLmcP31fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEYXB3+fI8FhcGCErCqmErLem+dzy3yHTGm+MvP2VOE7tXPqv
	GvWI4+hSDkBvZyabYrUBh1h1FBJWV9xanZldsQhnGSWME0ZYUvNp
X-Google-Smtp-Source: AGHT+IESnmez5aUFqH9bv/RhCPqIHamNdFaHEORyPgHrx0l52Ivn8ocPy2wWqEKnaQsgH9NRO7Ffzg==
X-Received: by 2002:a05:600c:3c9d:b0:431:4fbd:f571 with SMTP id 5b1f17b1804b1-432b74ce199mr82614475e9.13.1731259310376;
        Sun, 10 Nov 2024 09:21:50 -0800 (PST)
Received: from [192.168.216.100] (public-gprs9991.centertel.pl. [87.96.39.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda137dbsm10659370f8f.110.2024.11.10.09.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 09:21:49 -0800 (PST)
Message-ID: <4ee1ead4525f78fb5909a8cbf99513ad0082ad21.camel@gmail.com>
Subject: [PATCH v2] usb: musb: Fix hardware lockup on first Rx endpoint
 request
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 10 Nov 2024 18:21:48 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

There is a possibility that a request's callback could be invoked from
usb_ep_queue() (call trace below, supplemented with missing calls):

req->complete from usb_gadget_giveback_request
	(drivers/usb/gadget/udc/core.c:999)
usb_gadget_giveback_request from musb_g_giveback
	(drivers/usb/musb/musb_gadget.c:147)
musb_g_giveback from rxstate
	(drivers/usb/musb/musb_gadget.c:784)
rxstate from musb_ep_restart
	(drivers/usb/musb/musb_gadget.c:1169)
musb_ep_restart from musb_ep_restart_resume_work
	(drivers/usb/musb/musb_gadget.c:1176)
musb_ep_restart_resume_work from musb_queue_resume_work
	(drivers/usb/musb/musb_core.c:2279)
musb_queue_resume_work from musb_gadget_queue
	(drivers/usb/musb/musb_gadget.c:1241)
musb_gadget_queue from usb_ep_queue
	(drivers/usb/gadget/udc/core.c:300)

According to the docstring of usb_ep_queue(), this should not happen:

"Note that @req's ->complete() callback must never be called from within
usb_ep_queue() as that can create deadlock situations."

In fact, a hardware lockup might occur in the following sequence:

1. The gadget is initialized using musb_gadget_enable().
2. Meanwhile, a packet arrives, and the RXPKTRDY flag is set, raising an
   interrupt.
3. If IRQs are enabled, the interrupt is handled, but musb_g_rx() finds an
   empty queue (next_request() returns NULL). The interrupt flag has
   already been cleared by the glue layer handler, but the RXPKTRDY flag
   remains set.
4. The first request is enqueued using usb_ep_queue(), leading to the call
   of req->complete(), as shown in the call trace above.
5. If the callback enables IRQs and another packet is waiting, step (3)
   repeats. The request queue is empty because usb_g_giveback() removes the
   request before invoking the callback.
6. The endpoint remains locked up, as the interrupt triggered by hardware
   setting the RXPKTRDY flag has been handled, but the flag itself remains
   set.

For this scenario to occur, it is only necessary for IRQs to be enabled at
some point during the complete callback. This happens with the USB Ethernet
gadget, whose rx_complete() callback calls netif_rx(). If called in the
task context, netif_rx() disables the bottom halves (BHs). When the BHs are
re-enabled, IRQs are also enabled to allow soft IRQs to be processed. The
gadget itself is initialized at module load (or at boot if built-in), but
the first request is enqueued when the network interface is brought up,
triggering rx_complete() in the task context via ioctl(). If a packet
arrives while the interface is down, it can prevent the interface from
receiving any further packets from the USB host.

The situation is quite complicated with many parties involved. This
particular issue can be resolved in several possible ways:

1. Ensure that callbacks never enable IRQs. This would be difficult to
   enforce, as discovering how netif_rx() interacts with interrupts was
   already quite challenging and u_ether is not the only function driver.
   Similar "bugs" could be hidden in other drivers as well.
2. Disable MUSB interrupts in musb_g_giveback() before calling the callback
   and re-enable them afterwars (by calling musb_{dis,en}able_interrupts(),
   for example). This would ensure that MUSB interrupts are not handled
   during the callback, even if IRQs are enabled. In fact, it would allow
   IRQs to be enabled when releasing the lock. However, this feels like an
   inelegant hack.
3. Modify the interrupt handler to clear the RXPKTRDY flag if the request
   queue is empty. While this approach also feels like a hack, it wastes
   CPU time by attempting to handle incoming packets when the software is
   not ready to process them.
4. Flush the Rx FIFO instead of calling rxstate() in musb_ep_restart().
   This ensures that the hardware can receive packets when there is at
   least one request in the queue. Once IRQs are enabled, the interrupt
   handler will be able to correctly process the next incoming packet
   (eventually calling rxstate()). This approach may cause one or two
   packets to be dropped (two if double buffering is enabled), but this
   seems to be a minor issue, as packet loss can occur when the software is
   not yet ready to process them. Additionally, this solution makes the
   gadget driver compliant with the rule mentioned in the docstring of
   usb_ep_queue().

There may be additional solutions, but from these four, the last one has
been chosen as it seems to be the most appropriate, as it addresses the
"bad" behavior of the driver.

Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any=
 context.")
Cc: stable@vger.kernel.org
Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
---
v2: Add fixes and cc to stable tags

 drivers/usb/musb/musb_gadget.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.=
c
index bdf13911a1e5..c6076df0d50c 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1161,12 +1161,19 @@ void musb_free_request(struct usb_ep *ep, struct us=
b_request *req)
  */
 void musb_ep_restart(struct musb *musb, struct musb_request *req)
 {
+	u16 csr;
+	void __iomem *epio =3D req->ep->hw_ep->regs;
+
 	trace_musb_req_start(req);
 	musb_ep_select(musb->mregs, req->epnum);
-	if (req->tx)
+	if (req->tx) {
 		txstate(musb, req);
-	else
-		rxstate(musb, req);
+	} else {
+		csr =3D musb_readw(epio, MUSB_RXCSR);
+		csr |=3D MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_P_WZC_BITS;
+		musb_writew(epio, MUSB_RXCSR, csr);
+		musb_writew(epio, MUSB_RXCSR, csr);
+	}
 }
=20
 static int musb_ep_restart_resume_work(struct musb *musb, void *data)

base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
--=20
2.39.5



