Return-Path: <linux-kernel+bounces-380182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14159AE9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D71B245DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1051EBA0F;
	Thu, 24 Oct 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="lmQqy/ve"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B51E1311;
	Thu, 24 Oct 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782570; cv=none; b=C2U3ck1jBNT5437KsnYWYA8ntah/aX+P4fj22KteSoC/uvu6lMaYikjQbmW4OUBSOZKTYGgV7jFfrcss9UQsINyl3o8PHBvVom6zbh39FlPyowsdhi8rlwMBruekZ3Mm0DltYGCd4Hi9mrv/e1Rd3Ij1BAwRXqYhSPYwsRur6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782570; c=relaxed/simple;
	bh=u+txBytZKud+gGe1o4RcUBrww0xiQBse0T8zfTGZLDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tdFgAjHJbA95XLccnq2NN5f6jJEYIKCP+bZjl1EhNhj7sVDhvq3ZCbHwuP+sU7SxEo0tpquv5KkDy6jBPrsZirAq97eKZPAaKreYsYIdBTm/16unMjhSTtL/j94m7b020FR3nvdF3VrxYiPxKwkQSqIpaj6Qao7G6HxJWlZ882s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=lmQqy/ve; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1729782560; x=1730387360; i=benoit.monin@gmx.fr;
	bh=PDjBvTV7001OHXsNPTQyeo1iXm/jIi/1wXngvmzfhOk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lmQqy/vez6+3n5E9fMZecmcvZGmJhueSiFjcb06ZHtOYXRWmUCcka34/Qs0Uc3PK
	 Pw3z0fk+ahNIhK7CTLI6uie4vX+BIBY1IwYA3o+yLUdtzjav+7MyKK35+mhCpbA10
	 vttz6CgrgNadOIgDmCZFv0ReAPLvvFG2RM9Jc8ehJk0WdJjF2u3z3EbJHKuZXSoYz
	 VTClwZMgHs6RbnHIfExo2KF8TLEHGmIQqYrwg5T5tMQ8wZjCzkrIfj17PzyvXOono
	 5oUgGBOwH3dm+QUryxHF0/ZLcs/47nKXMo5rcE+UU1IvtcPLrtvBPyDdtQKEyvzsZ
	 ynnTL3v2x9AlADrq9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mFY-1u2XCG11GG-00yyNT; Thu, 24
 Oct 2024 17:09:20 +0200
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
Subject: [PATCH] USB: serial: option: add Quectel RG650V
Date: Thu, 24 Oct 2024 17:09:19 +0200
Message-ID: <20241024150919.53046-1-benoit.monin@gmx.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJPmPDO+9vwJaW4F2oS9VEFJZhbRc36ZKoypO1TclfLIVTzXXNf
 P6xCGcxyvNjrhVwDu5rMApM+cdZqutM70WK9HYXtxbsy170/AJm9WXLJLtDbqfxfh/DKgH8
 WOcPnesggWizF57BjOigh/8qYvJUeem7IY1z8qo4vLCVqvBTDBVW2FTOqkLzalX+m1QJxPm
 JC6DtfkrpMafLNvrkwEiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OygaSbnlxQU=;FmZ9S8cvW/GAQsdns0p7iDPnjRN
 uUydp81z9fHW8ha16fPJZ+aMnUqJfeXzYbvkEBrwumEGy2sN+q0aG/8nYitxJkzF9MkBFInI8
 +Owfxdl/lMLCyUc/xDwtVJOkvhdOwp34dyZhq70fZpVTkhv2sv/feAxiVIU2gbvRHP6TDsT0U
 QPx53Y0UekI6DFWuXwdMb8WgWPsgXaClM6KCNw8/SoTIoHUd4EnC0W0jJU9TsxqXQp360LFtO
 UCPZW8P4BlSG0Jtf6b33nGEI/fpaFFn53PVWfqeMxiZlIsswUGf4GhUwwi5nr7XG3yv80zTb8
 iY5c1vZEDsiMP4nZTnpv1xcnXWcvBnuOGT/49KqojTCgVuBUgBQdxG/8Bd/GL/4p5GQ3nunBD
 rQHY5aP6PLn6BhTMOsxh8kk7Q+MBBE2r0OCOUyXciVHTpaeRhbK8fj83qp8we5qT/fhRCX8Ro
 nTiat2V4YcBFYH1tJP4SXM0fOFKfIOXpIyNshtxqxHJCTC8CNjM87KH4BmSs28GfzAa/yo6C2
 Q0Var0FGdgfNyFJ9jjUiW4BQaz7lBvAGaS74wIwucQLkxPXIKFryh+7eDWNS4ldy4OFgv2Uo8
 /CrRRfvO3at18Hj3Gj/78JQ3HNqMZb9LSyh03oIOxVzblpXdrcar5o/Wl/g2e17RZoHwGt70B
 6OXdH3D433lNwq6e49pET6q3LECZ+BVzQePPhYiTzHwcjEiFY9GXWcDTdEJylKUmtb3/J4rWz
 EJq2NTGCSDCKinlIsUSHvXSSOXj7eEDwK78nP1Zu0HHWMDFsn5L6LmaWUWAWHdnSY1P/NV7fN
 eq+8dD9fs1CBRYVej4nwpWrg==

Add support for Quectel RG650V which is based on Qualcomm SDX65 chip.
The composition is DIAG / NMEA / AT / AT / QMI.

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D01 Dev#=3D  4 Spd=3D5000 M=
xCh=3D 0
D:  Ver=3D 3.20 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 9 #Cfgs=3D  1
P:  Vendor=3D2c7c ProdID=3D0122 Rev=3D05.15
S:  Manufacturer=3DQuectel
S:  Product=3DRG650V-EU
S:  SerialNumber=3Dxxxxxxx
C:  #Ifs=3D 5 Cfg#=3D 1 Atr=3Da0 MxPwr=3D896mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driver=
=3Doption
E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
I:  If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D9ms
I:  If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D9ms
I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3Dqmi_wwan
E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D1024 Ivl=3D0ms
E:  Ad=3D88(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D9ms
Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
=2D--
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4f18f189f309..aeaad2e1a24a 100644
=2D-- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -251,6 +251,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
+#define QUECTEL_PRODUCT_RG650V			0x0122
 #define QUECTEL_PRODUCT_EM061K_LTA		0x0123
 #define QUECTEL_PRODUCT_EM061K_LMS		0x0124
 #define QUECTEL_PRODUCT_EC25			0x0125
@@ -1273,6 +1274,8 @@ static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912=
Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916=
Q, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500=
K, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650=
V, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650=
V, 0xff, 0, 0) },

 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },

