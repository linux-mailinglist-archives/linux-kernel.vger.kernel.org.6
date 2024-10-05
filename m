Return-Path: <linux-kernel+bounces-351861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEBE9916FC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE94B2145A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F8F15278E;
	Sat,  5 Oct 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBZ8V1LL"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE969139578;
	Sat,  5 Oct 2024 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134355; cv=none; b=ZGecUiyAAZpunqHT1s1Q5vFl2+8OyeT3xH1ySVRF0kh7AHh3uLFRNwQv8x5JkxXO8L4RWkU8x+srFNHt7mwOZdo50Rx4xLLrIs2pICLs5voWQjXYLez6s6I7hqX+8VaxQ6xgcvyqmHfpm8I3LNE692dB17M7NqtMiHf/mluqDVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134355; c=relaxed/simple;
	bh=Fc95niQy5Am9SGNxcXL9hBnn2J1a6JcTWIjBRH2DIr0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=prToeNQ1HobP6HKD+X5DAMaxYOajUrKVCJAxVtALviQw/iBf8glTNGaIIUhaqvVmxuaTcZDqmSwNQ9yUie59PRZXE7tGxo/3Bu4rcXtyr7BnQZp5u/jYTpxexjR0CCOE4T1jj9fxM1hMMaA5TmLnmO4hL5O54+C0ASXfp1evvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBZ8V1LL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so30265035e9.0;
        Sat, 05 Oct 2024 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728134352; x=1728739152; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FhwMKQ2Eg2+xEIM8wuSzW1EX1nc8rapqiPN7Vp8nekY=;
        b=lBZ8V1LLihQFLKMdnLbFj+SYUKrDRe6VV5szCQzbDOZC9WiEHSRYCki4gUVGg2ale/
         MXSKiOE2b/MvCxDdJcIyKMda9LdzF1bTjubdmYZC7U6XPnImBiNxsodRyaieVyGcWNnL
         iQqhuyC252DVs6InTqi33QX/Yjz9+5RHZXfUEvi/5yMjPjj//r+yxUNY/zP4d8H0mL6A
         BdgOM5XQ87vYtK9wTVLzM+jIJ1V/Hfkl6T1gFTI728JIiyz1/nCEoRfOqMWwfNcDMg4k
         W0wvePXtsitYgodLNQ92bWhCok0oCMHZMHH2R6sZW4W7YwzEX1dh3Ke0HuygL2O6Nfct
         O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728134352; x=1728739152;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhwMKQ2Eg2+xEIM8wuSzW1EX1nc8rapqiPN7Vp8nekY=;
        b=KDt9IE3mG9ElUoCfm3I0QTDK6N3uNuVvO/VhFsIABtaQAaVGxHOOr24j3QgAL6VszH
         xGBjsf9HwkNoGJOIRZi4BQb5JGaxgwXImd/+f9KLrTgIYKB+ibueermI7yxGXUApc/NW
         YqnU9r8c1JBE7AYcjI8nkmDIyYBvhbUO4PoPN7iAvxug+q4r5dGQmIBbYnV5CWoqFp+h
         bLy20BIUG6pqRymgmLryME4OGeAQ4i+sE70ESYox4cua8wdzSZ2x2cMry8k0wmshOLtR
         FT+rqC9sGoxggXcZoz0P71PYBBoHkNRdaPfXm9crEWxT9UjthLzB+SKf/go/ACPxbNBO
         goUg==
X-Forwarded-Encrypted: i=1; AJvYcCUaScVyfRaCv14QDKIrrPpSWVB8UCe1M1CzdDKY2AZKYDKBiyYvLf4umPap9AFfaS/nz89ArbFvGNBfzcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8aueKVuwemQj2j1nS3hiOg5XU+HzZgfQGndSemICXDFyhwGS
	abXBtj+doKcByEQbDbIg3+W+zRSRZxKdolTJtVwuXccG5VgXaGULtJA8CQ==
X-Google-Smtp-Source: AGHT+IED40GR3k1qnvTHbxCNp7zWaqdT/5YXzwkTBKagjxcfCP049/irZlmUgEujQgddY/F1V1moyA==
X-Received: by 2002:adf:ecca:0:b0:374:c56e:1d4d with SMTP id ffacd0b85a97d-37d0e8f7539mr3536669f8f.54.1728134351908;
        Sat, 05 Oct 2024 06:19:11 -0700 (PDT)
Received: from [192.168.216.102] (public-gprs35668.centertel.pl. [91.94.11.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a541sm1766657f8f.34.2024.10.05.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:19:11 -0700 (PDT)
Message-ID: <e905e5d9c3e76786f154a87d54690fe1a90d755a.camel@gmail.com>
Subject: [PATCH] usb: musb: Fix hardware lockup on first Rx endpoint request
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 05 Oct 2024 15:19:10 +0200
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

Signed-off-by: Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>
---
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

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
--=20
2.30.2


