Return-Path: <linux-kernel+bounces-256020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B596F9347D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322D31F21FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7050E53373;
	Thu, 18 Jul 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c6QbtYWm"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934C91E495
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282934; cv=none; b=UR//4qS2bEeDTdxldrzZ3ut/wORZ2N4qffJNVw2B/psglPHG/YKg+j4dEWTlqNB7nl7Z8iCLzvDT34DwCu7bZQgWxr2vbsqedWt3hzMoatHNZoK0At7sAlTES2nv7AZdw47L2BXocCjtGNyDi5hmvhwbp/rmHoLmnceWc1+bnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282934; c=relaxed/simple;
	bh=ZegcCl/GlPv/utyNLL6/bM9sMNKAtaNRsXaLmtQ5CHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rngQjopJWzJ4Jzt27Phyg8tn15gZRgMnBeLh01l6W4dWpfYuv/D25wPMUXKh3PO2ymY0id1Y5H198ylVl4ow9iMxhiXhKFZsnltXhz4y5tFonhcXNNxfVQMIa806JRYpFEPncu1oLPrNO0DRLHvi4+OATcJodPRHn8pmtOWnJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c6QbtYWm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FSp2v
	95tkSIfbt1VFh0n0vhdmzySiMpH/D6OFSlbU5M=; b=c6QbtYWmrEULUyCcd6bfg
	1Cr+y3kancLBPaDq6S/4YJ5TWmMd++4S0uLWnQoSOiWvYBNwnNbk2d4tfTQ/Nf9a
	CoGgWq1IOgfi8qMmt/ohQZ7dtGcMp8wKoDxDF4xB/VoiVnTHYcAugpzTaJ8UeRL6
	GjiMszuQS/LwdAzi0FpWXE=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wD3vzY+sZhmlum7Aw--.54868S2;
	Thu, 18 Jul 2024 14:07:59 +0800 (CST)
From: wangdicheng <wangdich9700@163.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdich9700@163.com>,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2] ALSA: usb-audio: Fix microphone sound on HD webcam.
Date: Thu, 18 Jul 2024 14:07:56 +0800
Message-Id: <20240718060756.15322-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vzY+sZhmlum7Aw--.54868S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw43JFy5tFyrCF45Xw13urg_yoWrCFW3pr
	1Iya97Jryktr17Xr48CayUu3yrXws2y398Ca4qkwna9ryfK34rta47t3yDAayakrWrC34j
	qryjy3yqg3y5Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGYLkUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiRwQgT2V4KWD5UgAAsT

I own an external usb Webcam, HD webcam, which had low mic volume and
inconsistent sound quality. Video works as expected.

(snip)
[   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
[   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
[   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
[   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
[   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
[   96.092610][ 2] [ T3680] usb 5-2.2: Warning! Unlikely big volume range (=4096), cval->res is probably wrong.
[   96.102436][ 2] [ T3680] usb 5-2.2: [5] FU [Mic Capture Volume] ch = 1, val = 0/4096/1

Set up quirk cval->res to 16 for 256 levels,
Set GET_SAMPLE_RATE quirk flag to stop trying to get the sample rate.
Confirmed that happened anyway later due to the backoff mechanism,
After 3 failures.

All audio stream on device interfaces share the same values,
apart from wMaxPacketSize and tSamFreq :

      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass         1 Audio

Interface Descriptor:
  bLength                 9
  bDescriptorType         4
  bInterfaceNumber        3
  bAlternateSetting       4
  bNumEndpoints           1
  bInterfaceClass         1 Audio
  bInterfaceSubClass      2 Streaming
  bInterfaceProtocol      0
  iInterface              0
  AudioStreaming Interface Descriptor:
    bLength                 7
    bDescriptorType        36
    bDescriptorSubtype      1 (AS_GENERAL)
    bTerminalLink           3
    bDelay                  1 frames
    wFormatTag         0x0001 PCM
  AudioStreaming Interface Descriptor:
    bLength                11
    bDescriptorType        36
    bDescriptorSubtype      2 (FORMAT_TYPE)
    bFormatType             1 (FORMAT_TYPE_I)
    bNrChannels             1
    bSubframeSize           2
    bBitResolution         16
    bSamFreqType            1 Discrete
    tSamFreq[ 0]        48000
  Endpoint Descriptor:
    bLength                 9
    bDescriptorType         5
    bEndpointAddress     0x86  EP 6 IN
    bmAttributes            5
      Transfer Type            Isochronous
      Synch Type               Asynchronous
      Usage Type               Data
    wMaxPacketSize     0x0064  1x 100 bytes
    bInterval               4
    bRefresh                0
    bSynchAddress           0
    AudioStreaming Endpoint Descriptor:
      bLength                 7
      bDescriptorType        37
      bDescriptorSubtype      1 (EP_GENERAL)
      bmAttributes         0x01
        Sampling Frequency
      bLockDelayUnits         0 Undefined
      wLockDelay         0x0000
(snip)

Testing patch provides consistent good sound recording quality and volume range.

(snip)
[   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
[   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
[   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
[   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
[   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
[   96.110630][ 3] [ T3680] usbcore: registered new interface driver snd-usb-audio
[   96.114329][ 7] [ T3677] usb 5-2.2: Found UVC 1.00 device HD webcam (1bcf:2281)
[   96.167555][ 7] [ T3677] usbcore: registered new interface driver uvcvideo

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
V1 -> V2: align the space,Update code to v6.8-rc3,and make modifications based on it
---
 sound/usb/mixer.c  | 7 +++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..d1bdb0b93bda 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1211,6 +1211,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2281): /* HD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09712e61c606..f222532d4d43 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2185,6 +2185,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.25.1


