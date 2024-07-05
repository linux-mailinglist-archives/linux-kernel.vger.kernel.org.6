Return-Path: <linux-kernel+bounces-242102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C192838A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2511282E65
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BECA145B26;
	Fri,  5 Jul 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IGrkMXYM"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE72BD18;
	Fri,  5 Jul 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167472; cv=none; b=rRGvibCtfZkG9WEyK5fhwZ241CALRf9BId/CHC5Y5p2U3BuR5L4k0RYryK1N8Mi13gcJV8ZpK0vqyazm3mY4oy7WZqUtNW1jsp6Ezez41hemTaqMp71+oaVKqPfnpabPh+59SrF/1S7QhGzo/B6ja29KaJD1A499gYNHws9tfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167472; c=relaxed/simple;
	bh=N62di29Oedf7GoIGih7+uiyJQLoR834Yqg6nabF1rSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cy8nwHu7x1jroX7FkERHKZBvYzI4rcvmzemZFTJm1ugjOFzu3d+hBy61AkHXIcL/64Tcb9P7YCwS17LoY9LizIqhMkFuK4dVTE9YAetVI6BpSHfydfm7hn/li1qaPFIsDz3SUFS29en+JYXT+uN6TA7LQ/1uFgYbRAqq19sUejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IGrkMXYM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bLr8/
	EeBth9+HcrumTkeLcx679O6m9o8qb++SNgq8HI=; b=IGrkMXYMUFegPJEDu9jR9
	JuXacEhWUT0SPR6zarzhka6C71UtDF4kJIoQLw4u88wZEMFEOqhzdSb2guvleX1b
	HUsgk2O+3mAgn9vOj5kQj+XfNOvSup8kpkinC3CEPktGKNrWRLOXw8UO8PZwfV4o
	wfjQMsd+pikzZIQEG24j5w=
Received: from localhost.localdomain (unknown [223.104.77.193])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3vwoWrIdmYRHZBg--.27334S2;
	Fri, 05 Jul 2024 16:17:27 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: option: add support for Foxconn T99W651
Date: Fri,  5 Jul 2024 16:17:09 +0800
Message-Id: <20240705081709.105496-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vwoWrIdmYRHZBg--.27334S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1kCFy3Jr47uF4DAF4Dtwb_yoW8CrW8pF
	n0yryavrWDWayrXFyDtrn3Zr95uan3K3ySgasrAw4aqFyfZrs7t3sFyFy8XF17Kr4rKrnF
	vrs0yrWUKF1kJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRhNVhUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxkTZGV4KIaf7wAAsq

T99W651 is a RNDIS based modem device. There are 3 serial ports
need to be enumerated: Diag, NMEA and AT.

Test evidence as below:
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e145 Rev=05.15
S:  Manufacturer=QCOM
S:  Product=SDXPINN-IDP _SN:93B562B2
S:  SerialNumber=82e6fe26
C:  #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
I:  If#=0x6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)

0&1: RNDIS, 2:AT, 3:NMEA, 4:DIAG, 5:QDSS, 6:ADB
QDSS is not a serial port.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 178760bc7b92..4a43cec86db7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2294,6 +2294,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
+	  .driver_info = RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
-- 
2.25.1


