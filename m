Return-Path: <linux-kernel+bounces-310410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B8967C5A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7695B1F21781
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91913185B5E;
	Sun,  1 Sep 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="XR1/krCJ"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD72C190;
	Sun,  1 Sep 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725226759; cv=none; b=XLokdkRS+sMk25c7rPYQ+IlmGtmWa273obZ+SN0CTwQoabDO6saNthn6Rh97mbcbRZ2TRLzpcBgJqxziwZjmHptyayI+06sw4uJpM/ivHMBd5fdzIIo3bDif/r51MHXc8E2SMuxJsadGAAQnMpejPa9bjKbVMkd8bpPabcilsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725226759; c=relaxed/simple;
	bh=gs1K+vNC6pkOTzHJW+nknDkYFuXO4XFIE+JWNnhJSP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbPAS4x7UKmxtV7hAR6ZoXGFMt2kKld2P+pJQ7esyYo0+Mx2eYc7LgBqJTBbXBLH7E+O86qWo0xfs+V8Z9X72W8f0mpLt/yD/mMDpk3UZ0pp7W9OipBn6jY/3XYUF5rAP16I4wsEIT1fQem09t8+zH4hX5AycttRossyV0iIdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=XR1/krCJ; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 9BA5843F4C;
	Sun,  1 Sep 2024 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1725226326;
	bh=gs1K+vNC6pkOTzHJW+nknDkYFuXO4XFIE+JWNnhJSP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XR1/krCJtsvZsHAp1bTnGM9yeVqusTRTXCJOXrS7y4X6HlgcUN+X5WQ+/30Ca/V5I
	 IZe+LwMMgPusOO8bOg6/+QsfpZSlGmmnkZs7PtjZAkInAr9JRpzBF/dBiYR1XY1o7M
	 24X1ETuaHU58SBUmIXLhnv0J6kdU4anjyZO7zCIYUsKENLI8iLGIkarBD3MUeH8KS8
	 eOparAQEdusyHtULeVHzSi+pmoIngS3NDfsyqs0GmyLl9m2zADSOBxismCjDtaSARc
	 VzilYkQV58us3D75WEiz9qUaJN4OtxjxSo8gaG4McV/ezS9ix/+nehhAT8poa3XvBO
	 mXqgpbSb20Fdg==
From: Asahi Lina <lina@asahilina.net>
Date: Mon, 02 Sep 2024 06:31:50 +0900
Subject: [PATCH 1/2] ALSA: usb-audio: Add quirk for RME Digiface USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-rme-digiface-v1-1-6e88472a2744@asahilina.net>
References: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
In-Reply-To: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: "Geoffrey D. Bennett" <g@b4.vu>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Mark Hills <mark@xwax.org>, 
 Arun Raghavan <arun@arunraghavan.net>, Cyan Nyan <cyan.vtb@gmail.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725226324; l=8737;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=AFgJQODefGZGYmwXcwid1VQbLxKcvAIzfp88cJKMw1E=;
 b=1N3s0LnIepDjybXz1YmTWcxd6z3N40RlspCzMBCeoDcNO73yafPjrzfbChXb7+0VirmLzMPAM
 jRwOUgg6SvJAVbnceSqGTjp+NyUbBKCzvGWe85aPy11EOeOfdbyfadS
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
 sound/usb/quirks-table.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.c       |  58 +++++++++++++++
 2 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 73abc38a5400..47fd18791396 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -4546,6 +4546,194 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			/*
+			 * Three modes depending on sample rate band,
+			 * with different channel counts for in/out
+			 */
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 34, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 18, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 10, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 32, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 16, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
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
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 8, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+						USB_ENDPOINT_USAGE_IMPLICIT_FB,
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
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea063a14cdd8..3e44595add89 100644
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


