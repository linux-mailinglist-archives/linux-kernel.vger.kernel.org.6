Return-Path: <linux-kernel+bounces-183125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4E38C94FA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEB41C20ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835184C627;
	Sun, 19 May 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holesch.de header.i=simon@holesch.de header.b="Au/xsyQZ"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA288481A5;
	Sun, 19 May 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128432; cv=none; b=VQ65dG7xQ76H37G5iNUVH2Izfga9iBmgpwiMscdg1fyIdUwqAxpmzCj3jd18TGweuwtmitdGDKlyTP7uuEby3G1EKxPIGWljY7laI4qkRAI6BAg6rK8xcPaMPWldogqsMONO4dHpph3nGmLX+HlO0RROoO28FJlQDBES+JHpEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128432; c=relaxed/simple;
	bh=BdRenKhE9AoURtk+e0tvVp4/r07Rd9R5Nz+LPkppaKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+McSUvgbguu0OuboUELNnwRDrduVBE3zEOxDQgvhpZ22IjRtacT9e0ARC1EVZjxlcie0lDpQJP2VdfBQaJSzJMjk0zIZkTN2A8gQKxMmwKyn7TilLtNpJWcAnp9Kg/U7NDeWKY2+HiOMwe5gBsZm3qe7beIZBWmzoDVTenoul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holesch.de; spf=pass smtp.mailfrom=holesch.de; dkim=pass (2048-bit key) header.d=holesch.de header.i=simon@holesch.de header.b=Au/xsyQZ; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holesch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holesch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holesch.de;
	s=s1-ionos; t=1716128408; x=1716733208; i=simon@holesch.de;
	bh=V/rkqwTkUlpGLQVnFawbGWTuYkSjydDaVEN2loFqvtA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Au/xsyQZVIGemmbwJH1ewY+ANQ6IalGlU8MCXntwh9DRTAv+9rnP//v39jX2YeWQ
	 ujVDvjdf8Q9gsLufytpzVbDxQpjWQKEX1Ue77YICakuEl+aZPfHKmgayAi9zs9HJ1
	 u8srfIlF0By2jxWhaKwu8WulW+U6DnatxW3Ka+qhta4w3WySW/WJOt1L9gqNy9szu
	 oSZoK9d4jVcJdNL/hQj3p471tnf6NA98fEEBXtTbdnucsez8pP1kIlvO2+At58fs0
	 uzgMJTY5cXx7FMqh9G6s+29WkjDIks4xN2Ofcc1rL7iq86sYaG/NXLIoPurFr19Wc
	 K5xny/JfOt1QTl5hIQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([79.254.36.181]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MT9v5-1rycfX0Q8N-00UWbY; Sun, 19 May 2024 16:20:08 +0200
From: Simon Holesch <simon@holesch.de>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Holesch <simon@holesch.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] usbip: Don't submit special requests twice
Date: Sun, 19 May 2024 16:15:38 +0200
Message-ID: <20240519141922.171460-1-simon@holesch.de>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuIM0LrIHXfgd6BCXcWG1d98RfXPzx9wCdF35N5UOl0kx7MBC24
 uOgUmId1n808YPfWBoSTQdfZgbGebE1c5aEmeCIimHZzhji34nTZRmPxn/QM4Eu7cxayo3J
 xEOtamCLHFosglfVcX4jB3cfqdpgTxqBC3g7Y5/XOrwpETtti3+jeD/Nr3iui+A+yVC5LTW
 Cir172NYTJOgjMxWj2uKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HxSfFBth9NA=;Zbv8j8CJ1WVbFdo8kh1skvECp1z
 gzTM/q79IBFHvLaLCBcgtBYVB80Hv0dkjxsNb9bHi214PUyglOXOO9LskYPwtWDwdX/FSKemc
 D2DurpjUomv0hTkOLY4tZ5aMO0eSOKOysvmdNydpp2KNXpX4fi1dx9Gdg0l8wv3ezuBL310nG
 Yodo0vy7U6m0X8+K1Tazn1nkMMf7pqjyI2t63KaOliPtvByUCG8PVLyVJyllzChaTeZliZWxZ
 1ezONUZQcdbKPlVds7PeGnw7D9Fe7egyHB9Pj/GxwKPKKkMop3ST5P88JxV50q1AezTGsAqCt
 tX1vMLEXuKjorx6OtgX5ZJFFetKWdufE4GQ1XBc5SArwRurbuNzSQtJDu88YcgkI8A5damcaP
 0hXd5UzanbPg42Urpp8WXOjfi9Vxvp6/tILIPB9K6PNgjtphidwJId8jxPGuU9IvZj0XVT0FX
 9j2AQD2LXeXKKKV23mikfXWkppOIa6E8uPqXxE406sgQgjzDPIcNR4H/TQzU7Wct6lmdmnxrA
 sRU/n58SBhlVtqIcHZFnWn54ZgmsO0Zpp4ZKTCiFw/vLzOqNjeoRur0RrKVidTw9dR8Hc8xdZ
 OLFafhsNYzXlGRKS2h9ab1Ds0eg9zEE8wxBPAh4z6XK/auc/qADKamzp1VC69zogPLeLYSXZH
 rNIIhrnhsL7aK0DPVI4ciFOACEVEUZQILkOxd+lNr0OqRL8Q/AG/guMXTsPIipaMDWugRJ+6z
 Bgj99QXWyBdoBV44tYdAAsdWfM7rFwrxGBJTgOb7c+FIf0rBXyGsak=

Skip submitting URBs, when identical requests were already sent in
tweak_special_requests(). Instead call the completion handler directly
to return the result of the URB.

Even though submitting those requests twice should be harmless, there
are USB devices that react poorly to some duplicated requests.

One example is the ChipIdea controller implementation in U-Boot: The
second SET_CONFIGURATION request makes U-Boot disable and re-enable all
endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
reinit").

Signed-off-by: Simon Holesch <simon@holesch.de>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Hongren Zheng <i@zenithal.me>
Tested-by: Hongren Zheng <i@zenithal.me>
=2D--

Changes in v5:
- add comment for global is_tweaked flag
- fix typo in commit message

Changes in v4:
- fix compile error

Changes in v3:
- handle errors in tweak_* routines: send URB if tweaking fails

Changes in v2:
- explain change in commit message

 drivers/usb/usbip/stub_rx.c | 77 ++++++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index fc01b31bbb87..6338d818bc8b 100644
=2D-- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -144,53 +144,62 @@ static int tweak_set_configuration_cmd(struct urb *u=
rb)
 	if (err && err !=3D -ENODEV)
 		dev_err(&sdev->udev->dev, "can't set config #%d, error %d\n",
 			config, err);
-	return 0;
+	return err;
 }

 static int tweak_reset_device_cmd(struct urb *urb)
 {
 	struct stub_priv *priv =3D (struct stub_priv *) urb->context;
 	struct stub_device *sdev =3D priv->sdev;
+	int err;

 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");

-	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
+	err =3D usb_lock_device_for_reset(sdev->udev, NULL);
+	if (err < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
-		return 0;
+		return err;
 	}
-	usb_reset_device(sdev->udev);
+	err =3D usb_reset_device(sdev->udev);
 	usb_unlock_device(sdev->udev);

-	return 0;
+	return err;
 }

 /*
  * clear_halt, set_interface, and set_configuration require special trick=
s.
+ * Returns 1 if request was tweaked, 0 otherwise.
  */
-static void tweak_special_requests(struct urb *urb)
+static int tweak_special_requests(struct urb *urb)
 {
+	int err;
+
 	if (!urb || !urb->setup_packet)
-		return;
+		return 0;

 	if (usb_pipetype(urb->pipe) !=3D PIPE_CONTROL)
-		return;
+		return 0;

 	if (is_clear_halt_cmd(urb))
 		/* tweak clear_halt */
-		 tweak_clear_halt_cmd(urb);
+		err =3D tweak_clear_halt_cmd(urb);

 	else if (is_set_interface_cmd(urb))
 		/* tweak set_interface */
-		tweak_set_interface_cmd(urb);
+		err =3D tweak_set_interface_cmd(urb);

 	else if (is_set_configuration_cmd(urb))
 		/* tweak set_configuration */
-		tweak_set_configuration_cmd(urb);
+		err =3D tweak_set_configuration_cmd(urb);

 	else if (is_reset_device_cmd(urb))
-		tweak_reset_device_cmd(urb);
-	else
+		err =3D tweak_reset_device_cmd(urb);
+	else {
 		usbip_dbg_stub_rx("no need to tweak\n");
+		return 0;
+	}
+
+	return !err;
 }

 /*
@@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *s=
dev,
 	int support_sg =3D 1;
 	int np =3D 0;
 	int ret, i;
+	int is_tweaked;

 	if (pipe =3D=3D -1)
 		return;
@@ -580,8 +590,11 @@ static void stub_recv_cmd_submit(struct stub_device *=
sdev,
 		priv->urbs[i]->pipe =3D pipe;
 		priv->urbs[i]->complete =3D stub_complete;

-		/* no need to submit an intercepted request, but harmless? */
-		tweak_special_requests(priv->urbs[i]);
+		/*
+		 * all URBs belong to a single PDU, so a global is_tweaked flag is
+		 * enough
+		 */
+		is_tweaked =3D tweak_special_requests(priv->urbs[i]);

 		masking_bogus_flags(priv->urbs[i]);
 	}
@@ -594,22 +607,32 @@ static void stub_recv_cmd_submit(struct stub_device =
*sdev,

 	/* urb is now ready to submit */
 	for (i =3D 0; i < priv->num_urbs; i++) {
-		ret =3D usb_submit_urb(priv->urbs[i], GFP_KERNEL);
+		if (!is_tweaked) {
+			ret =3D usb_submit_urb(priv->urbs[i], GFP_KERNEL);

-		if (ret =3D=3D 0)
-			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
-					pdu->base.seqnum);
-		else {
-			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
-			usbip_dump_header(pdu);
-			usbip_dump_urb(priv->urbs[i]);
+			if (ret =3D=3D 0)
+				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
+						pdu->base.seqnum);
+			else {
+				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
+				usbip_dump_header(pdu);
+				usbip_dump_urb(priv->urbs[i]);

+				/*
+				 * Pessimistic.
+				 * This connection will be discarded.
+				 */
+				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
+				break;
+			}
+		} else {
 			/*
-			 * Pessimistic.
-			 * This connection will be discarded.
+			 * An identical URB was already submitted in
+			 * tweak_special_requests(). Skip submitting this URB to not
+			 * duplicate the request.
 			 */
-			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
-			break;
+			priv->urbs[i]->status =3D 0;
+			stub_complete(priv->urbs[i]);
 		}
 	}

=2D-
2.45.1


