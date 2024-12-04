Return-Path: <linux-kernel+bounces-431488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C689E3E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951141658FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4B20C00E;
	Wed,  4 Dec 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="k/dZG5Nz"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9720ADC6;
	Wed,  4 Dec 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325633; cv=pass; b=FcEdIU1gKTlHhRs9thHYQ/auleoyVu6cZgT8WXiB6MRB8KPSqbXWUsDXvbCnxr8eQL6EDm4gb32ENYDuiZFxW56QNNbr6wggMab2h+v82t+BCRNPhflraF29Ra/xuCg1sTAj/zgG9Zpxddk65styaaJagwqU5qAyKGhp789nZtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325633; c=relaxed/simple;
	bh=YOfJO3KymLpYLzHF6rSp/544+zHcPFtShcEEO2QXklM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ow2V5DoxTojgN9OQMOFIQPlo6OFjidvz0aX5w4VnetO57TFqYaCWLFKKlqr9OA6h8h7f7HVdI8t0oWlBPu2wGykZbYvg8T3ZV1YoNjg7KpF7lXJ06QT+eznEkZ61Mc8a8D0b+qpbavmU1r8Fl4FHGaEPCh3tBIQ9rvUTnhHlOlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=k/dZG5Nz; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733325609; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a6RR7DwL5ayYIcjwQDme9GLUnZEcoCOfD6ethvExWbY7Vuu10K+RSRaN86I6A0UngE1UsuuCtGmjf40fVFMp5TrsEfMTcyl4jWAyvJnDgLCjV1kRJSLlaj+PvMxrcMTIsaby5cG11Hq2uC2q/OizjudA+WvDSsC/Wm91zpdRV2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733325609; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i3ymZkGj3xTUPIgsuRfPuW/ehiFQMz3EpFlA0K8nQSw=; 
	b=afSZUkzXpEVk0QFFwkqj7uVvO7i9Zf675UKoHizQZvn7RiLzrhp4llF8W6XRO9K1d+wcE8KGfYp3RL0Jqoc2YmH0XtJ220zv6iBWnWHGDwUxT3qW5x8F7QWA5KhehcNfZcjB5++bKNJeIDEc7uXy+jy5/i1ux5OtHdW+lClPU+w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733325609;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=i3ymZkGj3xTUPIgsuRfPuW/ehiFQMz3EpFlA0K8nQSw=;
	b=k/dZG5Nzy1HnHuQs5mxU8L0AuwrHrWMyYqNpk/Bf/qWDygLihxMUL3YsEy6IOYFB
	omFxmAYoo90lXpUIAOpwyatts2bMdo2YfiaU6T6ZTbefjD4PDN0MwYDVAkT8yGOIF/p
	J41yirqu81SsTqjx6yHCGtu9Z+zpq2pcvmjKGfbU=
Received: by mx.zohomail.com with SMTPS id 173332560800963.522745827080826;
	Wed, 4 Dec 2024 07:20:08 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/2] sound: usb: enable DSD output for ddHiFi TC44C
Date: Wed,  4 Dec 2024 17:19:53 +0200
Message-ID: <20241204151954.658897-1-adrian.ratiu@collabora.com>
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
index 00101875d9a8..4897d7de7529 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2265,6 +2265,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x154e, 0x300b, /* Marantz SA-KI RUBY / SA-12 */
 		   QUIRK_FLAG_DSD_RAW),
+	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x154e, 0x500e, /* Denon DN-X1600 */
 		   QUIRK_FLAG_IGNORE_CLOCK_SOURCE),
 	DEVICE_FLG(0x1686, 0x00dd, /* Zoom R16/24 */
-- 
2.45.2


