Return-Path: <linux-kernel+bounces-355870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46C995837
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006D428AC8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990E215013;
	Tue,  8 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV/iA3fz"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADF215005
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418413; cv=none; b=IJkdOCRUZ4joONVcn0/yAwRmVTXs8aULONbgRpglirrEtPLmOksIalljqSbHW+SsKzEbzTUbRlpB7kCyg7CZ9fPjmaTZFLs/Yu9HuIVQNLSl+5Uz/TU3w2rS3woiRmxzhSNKrE9KEEazBZpsJcaOwg6M085AbkGiUxoqjQ5ftvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418413; c=relaxed/simple;
	bh=T6ZzmdcjLjX3GK+0OmAJNC2sD1QzsQ16CmrmYVRnvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRw4/DSwF2osXpQBuHnHr8Ww8Nwh3ChGv7lrjKJze6rNDR97H8G6yl1Hnr+s0wUHuaE3+7eF5uV6iIFCu67St1Vn/lRUD1VZG0Zjm1vNwHkihj6JBatmAsX4gxBGpiajR7rgYLIBvCqwA/laawkm4mXkFk2IhvkiQEiGeQOw2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV/iA3fz; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so703225066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728418410; x=1729023210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmuwFmbfSIJuwGIXfm5wbk7j1VdL6R7jwHhgcf2vJwo=;
        b=hV/iA3fzlQBRILPkYEETWftzrW+tMPYwLR7SqI6eVpM7YV8LiPMO+BkHeYAAXavFsD
         AzmQNdGb5/koLwDIVraEAftIuBUUsqtAtNuYyIfyJsMK+II4/QB8ym4WhmGYfIiRHRYn
         zgnLH7JYl1aU6NSYcrSFyT75DgrOGB4an6yFBi7lmPBs+b4U+GLdneacQMo0x+kVV3ce
         yw5WP2Tm33EgXdqgGv1dJVwwDylR0itFBjY4QXcSQD6WsQc3gzpNuPijmQ66fq6wnYEw
         E/ZEGLnYg77bywZonX0kI75hTaxmbmBloZ9+B7QL20ZjhbwMbbYmLlSr5Kf9INd/gjeV
         l5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728418410; x=1729023210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmuwFmbfSIJuwGIXfm5wbk7j1VdL6R7jwHhgcf2vJwo=;
        b=AhBCI971pPAZgl7F6U08qBUNHByp1V/5Po/JVayYDC7rHvfhJXJnRyU0lnxy+WiLvq
         qq0vGuGCsz3jUwO+46em6nxoDxDnv2ROXEJHqoUgIgUKSsFjEu2HyB3FHFHscoypSth3
         /p1EfVWfMWRygv+QvwlbPi1o+52H3ch0KztFvccRkgtmnmrco9U1v1jo0qwmbW5OSHCQ
         aFGkVstXmiU/6Y6ur54uzEIf4CRJsx4q9xW8Q9dZc9poaAfKvbg1iB7s3YUUXBp4JoiR
         AUFJZSL2PWcyUFtdSEzM/0L0AYIx1ghkWsohUx0W5Eosd37GYBX+zNep/9I+2Wmo5M0L
         yUHg==
X-Gm-Message-State: AOJu0YwU+K8VpnohtgeAyR5nV77NhPk1C/ZGc9eTxPKA16qdrWNtgxdG
	j4nZeMXN7K3inSgMjHr8pOBfW5TRZRhzTDmbd916JHQ7rr8dGD9WnXsRDUYm
X-Google-Smtp-Source: AGHT+IG0ZBsKhdgcJxedyaFZB3jZQDfIMBGGpP/spK+SBrnKMoEMHeajFa+bvn+zRFVne20jxRPyww==
X-Received: by 2002:a17:907:c14:b0:a99:5560:a84f with SMTP id a640c23a62f3a-a995560a972mr779972266b.31.1728418409537;
        Tue, 08 Oct 2024 13:13:29 -0700 (PDT)
Received: from nuke-vm-u22.fritz.box ([2a02:8071:8284:5500:d65:a31d:4cae:9b9d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e62392csm553941366b.52.2024.10.08.13.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:13:29 -0700 (PDT)
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maximilian Schneider <max@schneidersoft.net>
Subject: [PATCH v3 1/5] can: gs_usb.c: add usb endpoint address detection at driver probe step
Date: Tue,  8 Oct 2024 22:09:13 +0200
Message-ID: <20241008201107.38520-1-ak.alexander.kozhinov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <[PATCH v2] can: gs_usb.c: add usb endpoint address detection at driver probe step>
References: <[PATCH v2] can: gs_usb.c: add usb endpoint address detection at driver probe step>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is an approach made to implement gs_usb firmware/driver based on
Zephyr RTOS. It was found that USB stack of Zephyr RTOS overwrites USB
EP addresses, if they have different last 4 bytes in absence of other
endpoints.

For example in case of gs_usb candlelight firmware EP-IN is 0x81 and
EP-OUT 0x02. If there are no additional USB endpoints, Zephyr RTOS will
overwrite EP-OUT to 0x01. More information can be found in the
discussion with Zephyr RTOS USB stack maintainer here:

https://github.com/zephyrproject-rtos/zephyr/issues/67812

There are already two different gs_usb FW driver implementations based
on Zephyr RTOS:

1. https://github.com/CANnectivity/cannectivity
   (by: https://github.com/henrikbrixandersen)
2. https://github.com/zephyrproject-rtos/zephyr/compare/main...KozhinovAlexander:zephyr:gs_usb
   (by: https://github.com/KozhinovAlexander)

At the moment both Zephyr RTOS implementations use dummy USB endpoint,
to overcome described USB stack behavior from Zephyr itself. Since
Zephyr RTOS is intended to be used on microcontrollers with very
constrained amount of resources (ROM, RAM) and additional endpoint
requires memory, it is more convenient to update the gs_usb driver in
the Linux kernel.

To fix this problem, update the gs_usb driver from using hard coded
endpoint numbers to evaluate the endpoint descriptors and use the
endpoints provided there.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Maximilian Schneider <max@schneidersoft.net>
Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index bc86e9b329fd..f3eb447267f9 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -43,9 +43,6 @@
 #define USB_XYLANTA_SAINT3_VENDOR_ID 0x16d0
 #define USB_XYLANTA_SAINT3_PRODUCT_ID 0x0f30
 
-#define GS_USB_ENDPOINT_IN 1
-#define GS_USB_ENDPOINT_OUT 2
-
 /* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
  * for timer overflow (will be after ~71 minutes)
  */
@@ -336,6 +333,9 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+
+	u8 ep_in;
+	u8 ep_out;
 };
 
 /* 'allocate' a tx context.
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
-			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
+			  usb_rcvbulkpipe(parent->udev, parent->ep_in),
 			  hf, dev->parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
@@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	}
 
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, GS_USB_ENDPOINT_OUT),
+			  usb_sndbulkpipe(dev->udev, dev->parent->ep_out),
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
@@ -926,7 +926,7 @@ static int gs_can_open(struct net_device *netdev)
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
 					  usb_rcvbulkpipe(dev->udev,
-							  GS_USB_ENDPOINT_IN),
+							  dev->parent->ep_in),
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
@@ -1421,6 +1421,18 @@ static int gs_usb_probe(struct usb_interface *intf,
 	struct gs_device_config dconf;
 	unsigned int icount, i;
 	int rc;
+	struct usb_host_interface *host_iface;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
+
+	host_iface = intf->cur_altsetting;
+
+	/* Find common bulk endpoints reverse */
+	rc = usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_out, NULL,
+											NULL);
+	if (rc) {
+		dev_err(&intf->dev, "Required endpoints not found\n");
+		return rc;
+	}
 
 	/* send host config */
 	rc = usb_control_msg_send(udev, 0,
@@ -1466,6 +1478,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, parent);
 	parent->udev = udev;
 
+	/* store the detected endpoints */
+	parent->ep_in = ep_in->bEndpointAddress;
+	parent->ep_out = ep_out->bEndpointAddress;
+
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
 
-- 
2.43.0


From d0b4d3b1f5fd1b4c33bc5d8f83ed49d04a2286c4 Mon Sep 17 00:00:00 2001
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Date: Tue, 8 Oct 2024 21:25:51 +0200
Subject: [PATCH v3 2/5] can: gs_usb.c: store pipe instead of endpoint address

This change implements nitpick: instead of storing the ep_in and ep_out in your priv, you can
instead directly store the result of usb_rcvbulkpipe(parent->udev,
parent->ep_in) and usb_sndbulkpipe(dev->udev, dev->parent->ep_out).

Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f3eb447267f9..e6511af5f692 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -334,8 +334,8 @@ struct gs_usb {
 	unsigned int hf_size_rx;
 	u8 active_channels;
 
-	u8 ep_in;
-	u8 ep_out;
+	unsigned int pipe_in;
+	unsigned int pipe_out;
 };
 
 /* 'allocate' a tx context.
@@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
-			  usb_rcvbulkpipe(parent->udev, parent->ep_in),
+			  parent->pipe_in,
 			  hf, dev->parent->hf_size_rx,
 			  gs_usb_receive_bulk_callback, parent);
 
@@ -819,7 +819,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	}
 
 	usb_fill_bulk_urb(urb, dev->udev,
-			  usb_sndbulkpipe(dev->udev, dev->parent->ep_out),
+			  dev->parent->pipe_out,
 			  hf, dev->hf_size_tx,
 			  gs_usb_xmit_callback, txc);
 
@@ -925,8 +925,7 @@ static int gs_can_open(struct net_device *netdev)
 			/* fill, anchor, and submit rx urb */
 			usb_fill_bulk_urb(urb,
 					  dev->udev,
-					  usb_rcvbulkpipe(dev->udev,
-							  dev->parent->ep_in),
+					  dev->parent->pipe_in,
 					  buf,
 					  dev->parent->hf_size_rx,
 					  gs_usb_receive_bulk_callback, parent);
@@ -1479,8 +1478,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 	parent->udev = udev;
 
 	/* store the detected endpoints */
-	parent->ep_in = ep_in->bEndpointAddress;
-	parent->ep_out = ep_out->bEndpointAddress;
+	parent->pipe_in = usb_rcvbulkpipe(parent->udev, ep_in->bEndpointAddress);
+	parent->pipe_out = usb_sndbulkpipe(parent->udev, ep_out->bEndpointAddress);
 
 	for (i = 0; i < icount; i++) {
 		unsigned int hf_size_rx = 0;
-- 
2.43.0


From 6515df86641c6eda6dc3e3c4a8f1fc8625835f89 Mon Sep 17 00:00:00 2001
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Date: Tue, 8 Oct 2024 21:37:13 +0200
Subject: [PATCH v3 3/5] can: gs_usb.c: use reverse xmas tree declaration

This change implements request: Move this declaration up (c.f. the Reverse christmas tree declarations).

Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e6511af5f692..a88448dbc6af 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1412,6 +1412,8 @@ static int gs_usb_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
+	struct usb_host_interface *host_iface;
 	struct gs_host_frame *hf;
 	struct gs_usb *parent;
 	struct gs_host_config hconf = {
@@ -1420,8 +1422,6 @@ static int gs_usb_probe(struct usb_interface *intf,
 	struct gs_device_config dconf;
 	unsigned int icount, i;
 	int rc;
-	struct usb_host_interface *host_iface;
-	struct usb_endpoint_descriptor *ep_in, *ep_out;
 
 	host_iface = intf->cur_altsetting;
 
-- 
2.43.0


From cddd8290dd877eddcac31366ae69188b79fc35e8 Mon Sep 17 00:00:00 2001
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Date: Tue, 8 Oct 2024 21:40:59 +0200
Subject: [PATCH v3 4/5] can: gs_usb.c: use rforward usb endpoints search

This change implements request: Any specific reason for doing this in reverse? The previous
GS_USB_ENDPOINT_IN and GS_USB_ENDPOINT_OUT macros were respectively 1
and 2, so at the beginning. And in such a case, the normal search
would find those quicker.

Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a88448dbc6af..24f715f9c436 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1426,8 +1426,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 	host_iface = intf->cur_altsetting;
 
 	/* Find common bulk endpoints reverse */
-	rc = usb_find_common_endpoints_reverse(host_iface, &ep_in, &ep_out, NULL,
-											NULL);
+	rc = usb_find_common_endpoints(host_iface, &ep_in, &ep_out, NULL, NULL);
 	if (rc) {
 		dev_err(&intf->dev, "Required endpoints not found\n");
 		return rc;
-- 
2.43.0


From b65448554e172c8b419605411248d83846764a1d Mon Sep 17 00:00:00 2001
From: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
Date: Tue, 8 Oct 2024 21:43:10 +0200
Subject: [PATCH v3 5/5] can: gs_usb.c: skip new variable declaration

This change implements nipick: no need to declare a new variable for host_iface which is used
only once.

Signed-off-by: Alexander Kozhinov <ak.alexander.kozhinov@gmail.com>
---
 drivers/net/can/usb/gs_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 24f715f9c436..d93410682d4b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1413,7 +1413,6 @@ static int gs_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *ep_in, *ep_out;
-	struct usb_host_interface *host_iface;
 	struct gs_host_frame *hf;
 	struct gs_usb *parent;
 	struct gs_host_config hconf = {
@@ -1423,10 +1422,9 @@ static int gs_usb_probe(struct usb_interface *intf,
 	unsigned int icount, i;
 	int rc;
 
-	host_iface = intf->cur_altsetting;
-
 	/* Find common bulk endpoints reverse */
-	rc = usb_find_common_endpoints(host_iface, &ep_in, &ep_out, NULL, NULL);
+	rc = usb_find_common_endpoints(intf->cur_altsetting,
+									&ep_in, &ep_out, NULL, NULL);
 	if (rc) {
 		dev_err(&intf->dev, "Required endpoints not found\n");
 		return rc;
-- 
2.43.0


