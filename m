Return-Path: <linux-kernel+bounces-437042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D459E8E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F224C161FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541F21505F;
	Mon,  9 Dec 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YkwqjcUV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD51BC4E;
	Mon,  9 Dec 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735203; cv=pass; b=HXTThB+S+rfsFpxQyMuyVSm0xvyc3IEgz26AacDFNbJ6fqRBLeNYhfh5uRbOv3RvtGaQIE99H/A617BJZm884R6m1NtNsUFy2mKvj7K1cwIMnVtrTibvlgNZiVpWWah66/sp/mC9nFUgfsXc6TSori2BmOtDGV0LCWilb30SB6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735203; c=relaxed/simple;
	bh=4Ea0Pz+e/ExxlNNkTMRnpFpMzVFHjjaMVYEaEDbltQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyqOTLWiXfuZYzSzyJEAMeonyA/wshvNBFw+jkZNso8XqgCEnT9FPhnI0QfNZDbqscKAecbRVmb+Chn/JhQ+y8edVwJSZiL+MxeM/B3mYI2QxTAW8K7zNg8YCXWmsjo+mPReljz2G1plVZ3GURIo1u2HBlXcIbcnJjp/tk5DXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YkwqjcUV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733735181; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gY6IKDzvaPQJLSycO91aDs+Gz8/y+kkUScwIDFbPQCKue+kM8wD/2zB6czcu+lpURrDsxCMVWsff+vsv+AO+NKAHZZBKW1t+VofBt97voP+xnjMX3vbYyUKPWPfapuQm7jsPa9sJsvBUyzaeQL8hxPzzRjiCukNWbOo0iqrsI8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733735181; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NhtMpw7Wc9C5BjidxiYPbReNykhkjKAdEHBXK+B5fOE=; 
	b=jdcm/QRRmksd8Vf2UwaX1F1urs6h+y+YkQmhlsbCZB3vdmJ8tT/TdzO6Yrk7V/94IAYOngX/vM0mns3nonAs28J/Zui2bI09EjYH+VUO7mxAiT1KAWJordEGmoPAryhKs6YpGgb5M501fkTVI7ncg6A2uc7G1F8Xq3/uQh7Fqyg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733735181;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NhtMpw7Wc9C5BjidxiYPbReNykhkjKAdEHBXK+B5fOE=;
	b=YkwqjcUVp4zuyzARQrx3L6zDq8076rWgMryADyqX0Y5epJcFFiNKct8wPgY4elXQ
	RIFQXn1QJcCxpmu/4W+9HDHw3IzLWJta/ZaYuEb59U5LPntFDDFylAEljGBFekA+Q+P
	nQT2xGQpmmSindqk04GTugqZwr05Jysa9jYNJxYw=
Received: by mx.zohomail.com with SMTPS id 1733735176961977.1158312190503;
	Mon, 9 Dec 2024 01:06:16 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 1/2] sound: usb: enable DSD output for ddHiFi TC44C
Date: Mon,  9 Dec 2024 11:05:28 +0200
Message-ID: <20241209090529.16134-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This is a UAC 2 DAC capable of raw DSD on intf 2 alt 4:

Bus 007 Device 004: ID 262a:9302 SAVITECH Corp. TC44C
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 [unknown]
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x262a SAVITECH Corp.
  idProduct          0x9302 TC44C
  bcdDevice            0.01
  iManufacturer           1 DDHIFI
  iProduct                2 TC44C
  iSerial                 6 5000000001
.......
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      32
      iInterface              0
	AudioStreaming Interface Descriptor:
          bLength                16
          bDescriptorType        36
          bDescriptorSubtype     1 (AS_GENERAL)
          bTerminalLink          3
          bmControls             0x00
          bFormatType            1
          bmFormats              0x80000000
          bNrChannels            2
          bmChannelConfig        0x00000000
          iChannelNames          0
.......

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 00101875d9a8..0e97d076a113 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2323,6 +2323,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2522, 0x0007, /* LH Labs Geek Out HD Audio 1V5 */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
+	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
-- 
2.45.2


