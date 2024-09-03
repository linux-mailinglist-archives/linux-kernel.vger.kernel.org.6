Return-Path: <linux-kernel+bounces-312758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE21969ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDD1B22F71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C31D096F;
	Tue,  3 Sep 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="ka3UXohR"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17B1C768B;
	Tue,  3 Sep 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360786; cv=none; b=g+SrvE357tpRj2sR2JR44fv8uQYJwGWc5I9gY+USBwOTKQ4v6wEqPYbrfmOUeYbrLhEuWR4tokNDa7QOhXhgvOdbBGR9yTcn8pzcCe7zLlahgrviiilwoGYGEA5MFlF7NzyWbqRN6Z2xgZNltRqpxm/PQRszIzzquS7uM8Zq6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360786; c=relaxed/simple;
	bh=2mqDap3tLyb1iBYpAdSuOkCzpJKEJ2gMXj0JaFFtmWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpahlFySuMFFePohk+GjSV7cVyhOmRMU8BY6i0nSyyKBOnUquY2uje4L8vMsZzF0/xyxkgPxbdus7S3rozwGK5UVsdwvznraErbpp7YXZfiDxtZESMGDHrS2QbEsUab4JON/FE3FlxL1xWASasw5DwKRcXqP8d557RQn1atLnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=ka3UXohR; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B25914425E;
	Tue,  3 Sep 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725360773;
	bh=2mqDap3tLyb1iBYpAdSuOkCzpJKEJ2gMXj0JaFFtmWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ka3UXohReW6AlqoRRdGYmzwTnTKz4jwCQBYXbTCjM6+Qv5B4TqY7vG97R8Dex+2cc
	 +ySrPTrOYzrZhEEF2cQWye+DpT3ZOxqfiBJn/mNYbvd5lziRPKe/hIsbU215eb0kko
	 mmGEhMbZnR6Lf+kQRVpdWrEzJTq3kBMiJ6YzsgRHX79rumCx302HCuCHkJYGuucJai
	 p1BYgwn1ENETm/qloyBHo4nXLydKYZNIHRYFRKq558BgiBk0JzhcADGvc0H79jejkI
	 um7NJYCxU1dA3nhxif1vFoznwyjyYSqcN/kfM8cU/IyrsP+kI+hKV6n4b30BmLb9Oz
	 hztNrOMcEI+Yw==
From: Asahi Lina <lina@asahilina.net>
Date: Tue, 03 Sep 2024 19:52:29 +0900
Subject: [PATCH v2 1/2] ALSA: usb-audio: Add quirk for RME Digiface USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rme-digiface-v2-1-71b06c912e97@asahilina.net>
References: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
In-Reply-To: <20240903-rme-digiface-v2-0-71b06c912e97@asahilina.net>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Hills <mark@xwax.org>, 
 Arun Raghavan <arun@arunraghavan.net>, Cyan Nyan <cyan.vtb@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725360771; l=8061;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=k1lIxh56gYjbH7gWwfa3Z3znqC8wZ+NZoh9pSjbmZVE=;
 b=BDZlUXyo0qDtpqglLPTONrkSCesCdeow47E/ZL2oDIqOnssrw2IjNVPEGxiAMx+iOYiBozFJb
 YBTLYng9EIYB6/k7v4BxicNm5e07QUhOGWMdQY22RAKYXGG9LUZLT4z
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

From: Cyan Nyan <cyan.vtb@gmail.com>

Add trivial support for audio streaming on the RME Digiface USB. Binds
only to the first interface to allow userspace to directly drive the
complex I/O and matrix mixer controls.

Signed-off-by: Cyan Nyan <cyan.vtb@gmail.com>
[Lina: Added 2x/4x sample rate support & boot/format quirks]
Co-developed-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 sound/usb/quirks-table.h | 171 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.c       |  58 ++++++++++++++++
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8d22de8bc2a9..631b9ab80f6c 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3604,6 +3604,175 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-
+{
+	/* Only claim interface 0 */
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+		       USB_DEVICE_ID_MATCH_PRODUCT |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_NUMBER,
+	.idVendor = 0x2a39,
+	.idProduct = 0x3f8c,
+	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
+	.bInterfaceNumber = 0,
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			/*
+			 * Three modes depending on sample rate band,
+			 * with different channel counts for in/out
+			 */
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 34, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_32000 |
+						SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 32000,
+					.rate_max = 48000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						32000, 44100, 48000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 18, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_64000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 64000,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						64000, 88200, 96000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 10, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_KNOT |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 128000,
+					.rate_max = 192000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						128000, 176400, 192000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 32, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_32000 |
+						SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 32000,
+					.rate_max = 48000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						32000, 44100, 48000,
+					}
+				}
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 16, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_64000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 64000,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						64000, 88200, 96000,
+					}
+				}
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 8, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_KNOT |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 128000,
+					.rate_max = 192000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						128000, 176400, 192000,
+					}
+				}
+			},
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 53c69f3069c4..f62631b54e10 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1389,6 +1389,27 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 	return 0;
 }
 
+static int snd_usb_rme_digiface_boot_quirk(struct usb_device *dev)
+{
+	/* Disable mixer, internal clock, all outputs ADAT, 48kHz, TMS off */
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			16, 0x40, 0x2410, 0x7fff, NULL, 0);
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			18, 0x40, 0x0104, 0xffff, NULL, 0);
+
+	/* Disable loopback for all inputs */
+	for (int ch = 0; ch < 32; ch++)
+		snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				22, 0x40, 0x400, ch, NULL, 0);
+
+	/* Unity gain for all outputs */
+	for (int ch = 0; ch < 34; ch++)
+		snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				21, 0x40, 0x9000, 0x100 + ch, NULL, 0);
+
+	return 0;
+}
+
 /*
  * Setup quirks
  */
@@ -1616,6 +1637,8 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		    get_iface_desc(intf->altsetting)->bInterfaceNumber < 3)
 			return snd_usb_motu_microbookii_boot_quirk(dev);
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		return snd_usb_rme_digiface_boot_quirk(dev);
 	}
 
 	return 0;
@@ -1771,6 +1794,38 @@ static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
 		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
 }
 
+static const int rme_digiface_rate_table[] = {
+	32000, 44100, 48000, 0,
+	64000, 88200, 96000, 0,
+	128000, 176400, 192000, 0,
+};
+
+static int rme_digiface_set_format_quirk(struct snd_usb_substream *subs)
+{
+	unsigned int cur_rate = subs->data_endpoint->cur_rate;
+	u16 val;
+	int speed_mode;
+	int id;
+
+	for (id = 0; id < ARRAY_SIZE(rme_digiface_rate_table); id++) {
+		if (rme_digiface_rate_table[id] == cur_rate)
+			break;
+	}
+
+	if (id >= ARRAY_SIZE(rme_digiface_rate_table))
+		return -EINVAL;
+
+	/* 2, 3, 4 for 1x, 2x, 4x */
+	speed_mode = (id >> 2) + 2;
+	val = (id << 3) | (speed_mode << 12);
+
+	/* Set the sample rate */
+	snd_usb_ctl_msg(subs->stream->chip->dev,
+		usb_sndctrlpipe(subs->stream->chip->dev, 0),
+		16, 0x40, val, 0x7078, NULL, 0);
+	return 0;
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1795,6 +1850,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x0dba, 0x5000):
 		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		rme_digiface_set_format_quirk(subs);
+		break;
 	}
 }
 

-- 
2.46.0


