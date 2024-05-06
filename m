Return-Path: <linux-kernel+bounces-170447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B174C8BD6E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FC228286B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CBB15B989;
	Mon,  6 May 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmj5lHWV"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735B446AC;
	Mon,  6 May 2024 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715031177; cv=none; b=e7xK0dMQRrS0iNrkHYqiTV14WGSCGP1ij0WQynE2IpYaLOyVNzsdVY5lsaxSk3Acs3Uw2v7hQhqZhW8JLh6aEfydZDmpjpE+ESRBUFGbD6bsPtwpn0inWqSPpkTXgC1v47uVe2sistW35I78Tizs/iH8oPWKJvZOXM28WTzyzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715031177; c=relaxed/simple;
	bh=dzRQB9uibS55Go/XXVLUjbbtqEd9ieofAZ3ha4n8qS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T609tqUpcG0CAtqxKejYdtJbJuXNkPxk6eRrMP/lknpxX6zDp3ieQpiqEhA5JXYUNuw7pPVMpGCTE0ceF1dfKnH9/S8v6iQvv5wOI1tiva1JfU/zMfjCKtwSIzcYQnPhR5Ceepma+0jtlXalCMsWbPGHkKMvab2mBgHr/ctFF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmj5lHWV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso1993692b3a.0;
        Mon, 06 May 2024 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715031175; x=1715635975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06aTth4DtNNPEbNBcti5kUwq84Dsg7H5rl164l4ZB70=;
        b=mmj5lHWVZwoIE0levlZyzVjBZ3JbpJ1vxybknZSlmEg2QWSlq77LXZoLjLB9aNITf1
         4adrnGXBiio6jp3N3hJUKqfJrtul8xggwIV0mtxL4VFpn+iQGXomfxmHxMPL9F1fnbDr
         RYXGjlY5XXhgEAg5JjlALfzGV8Qqiu4B4SPZV/x+zObAEHGcwtaK5HFW5+Fm37GSpZAs
         ys5X3LYk9zl3VM2rNFkLmAPBBJNubqcgOCGugCEd1U95gEU2HIRmBqeJeTtwGzf+SsI8
         FrzJPObi9LJZthLiZNvfJewA0N4k54hRwBGNTDNKIZOfnVTbs6HxMIA/5mx6Vnd/g1Pz
         C8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715031175; x=1715635975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06aTth4DtNNPEbNBcti5kUwq84Dsg7H5rl164l4ZB70=;
        b=ZgMInOkt4GoyGSjJL5DuCCa8Ww3oK+VukMUt6CHEW3/GkD6wPLjGv9NNqujB6PMoPJ
         AGBJQ5HbZW0/DbD7AebgUfFshreTSSdE7rd4Oyt/bqRroStj+dOJd+FzpO/WdSIEYkFJ
         9Tgk254SWp411bFAlnFWaE1lgpBqUO2US1r0DsKKPgfc9WxBgxaCAwAO6ne75Jqhgjs0
         LWEi/bIx5Bjo361Ik6n+vWVJyxLI/mpnaGUOFi5qaMr0aclYhd6ePaNTe+WiD3JUsaev
         rCsmzjHnfoL5S5IqcfwNuBLvpiN+5KKrm/Hf8LF2jmgihPgG6o9vd5nLxJa0EI3cp3ab
         wY8A==
X-Forwarded-Encrypted: i=1; AJvYcCVM5CjHtYd5myJkEZU4/YVyxwrFo3zUpRaqkubXuah4xcb7JLtbqdQ2dl7HKhizDAeLNMxiNv0SeImR2GSoeCa0ce2la2B0IBgFo+SptuvM+GRPlX31hdq8Z3P/py6/Snuo44znP8tOqVg=
X-Gm-Message-State: AOJu0YyahO4nS/vkdB4v+wUL/jtnJraXc35mU86keB1weLnhgHvhiV/x
	A6r8HqFyXNiWKUGVWNzU3+97r6WARV5HPDrGPCOQXVGK9PTGaJ34kTmQ+887sHY=
X-Google-Smtp-Source: AGHT+IEqwGT2bJ9qXEomFOySpmG2vJ7f/p5vGZ2IsmN9Di5t2TYg90whcEqfo2ChqZ9bwlx3jY+3TQ==
X-Received: by 2002:a05:6a00:1d11:b0:6f4:8008:5cd3 with SMTP id a17-20020a056a001d1100b006f480085cd3mr3517776pfx.34.1715031174882;
        Mon, 06 May 2024 14:32:54 -0700 (PDT)
Received: from thought.. ([181.170.161.59])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b006f447d95de9sm6913308pfd.29.2024.05.06.14.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:32:54 -0700 (PDT)
From: Manuel Barrio Linares <mbarriolinares@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Manuel Barrio Linares <mbarriolinares@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	dengxiang <dengxiang@nfschina.com>,
	Max McCarthy <mmccarthy@mcintoshlabs.com>,
	Christos Skevis <xristos.thes@gmail.com>,
	Alexander Tsoy <alexander@tsoy.me>,
	Julian Sikorski <belegdol+github@gmail.com>,
	Jussi Laako <jussi@sonarnerd.net>,
	Lukasz Tyl <ltyl@hem-e.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] ALSA: usb-audio: Add sampling rates support for Mbox3
Date: Mon,  6 May 2024 18:32:38 -0300
Message-ID: <20240506213240.6191-1-mbarriolinares@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <87mspakltl.wl-tiwai@suse.de>
References: <87mspakltl.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for all sample rates supported by the hardware,
Digidesign Mbox 3 supports: {44100, 48000, 88200, 96000}

Fixes syncing clock issues that presented as pops. To test this, without
this patch playing 440hz tone produces pops.

Clock is now synced between playback and capture interfaces so no more
latency drift issue when using pipewire pro-profile.
(https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3900)

Signed-off-by: Manuel Barrio Linares <mbarriolinares@gmail.com>
---
v2: Cleaned up code. Explicit __le32 usage.
v3: Get rid of sparse warnings
v4: Fixed wrong use of usb_sndctrlpipe to usb_rcvctrlpipe, lines 1743 and 1768

 sound/usb/quirks-table.h | 38 +++++++++++++--------
 sound/usb/quirks.c       | 74 +++++++++++++++++++++++++++++++---------
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 5d72dc8441cbb..73abc38a54006 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3013,21 +3013,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 2,
 					.altsetting = 1,
 					.altset_idx = 1,
 					.attributes = 0x00,
-					.endpoint = 0x01,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_OUT,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
+					.sync_ep = USB_RECIP_INTERFACE | USB_DIR_IN,
+					.sync_iface = 3,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 1,
+					.implicit_fb = 1,
 				}
 			},
 			{
@@ -3035,22 +3042,25 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = &(const struct audioformat) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 4,
 					.iface = 3,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.endpoint = 0x81,
 					.attributes = 0x00,
+					.endpoint = USB_RECIP_INTERFACE | USB_DIR_IN,
 					.ep_attr = USB_ENDPOINT_XFER_ISOC |
 						USB_ENDPOINT_SYNC_ASYNC,
 					.maxpacksize = 0x009c,
-					.rates = SNDRV_PCM_RATE_48000,
-					.rate_min = 48000,
-					.rate_max = 48000,
-					.nr_rates = 1,
+					.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+							SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
 					.rate_table = (unsigned int[]) {
-						48000
-					}
+						44100, 48000, 88200, 96000
+					},
+					.implicit_fb = 0,
 				}
 			},
 			{
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 09712e61c606e..58156fbca02c7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -984,21 +984,13 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 	return 0;
 }
 
-static void mbox3_setup_48_24_magic(struct usb_device *dev)
+static void mbox3_setup_defaults(struct usb_device *dev)
 {
 	/* The Mbox 3 is "little endian" */
 	/* max volume is: 0x0000. */
 	/* min volume is: 0x0080 (shown in little endian form) */
 
-
-	/* Load 48000Hz rate into buffer */
-	u8 com_buff[4] = {0x80, 0xbb, 0x00, 0x00};
-
-	/* Set 48000Hz sample rate */
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x0001, &com_buff, 4);  //Is this really needed?
-	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
-			0x01, 0x21, 0x0100, 0x8101, &com_buff, 4);
+	u8 com_buff[2];
 
 	/* Deactivate Tuner */
 	/* on  = 0x01*/
@@ -1008,6 +1000,8 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 		0x01, 0x21, 0x0003, 0x2001, &com_buff, 1);
 
 	/* Set clock source to Internal (as opposed to S/PDIF) */
+	/* Internal  = 0x01*/
+	/* S/PDIF    = 0x02*/
 	com_buff[0] = 0x01;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			1, 0x21, 0x0100, 0x8001, &com_buff, 1);
@@ -1113,9 +1107,11 @@ static void mbox3_setup_48_24_magic(struct usb_device *dev)
 			1, 0x21, 0x0107, 0x4201, &com_buff, 2);
 
 	/* Toggle allowing host control */
+	/* Not needed
 	com_buff[0] = 0x02;
 	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
 			3, 0x21, 0x0000, 0x2001, &com_buff, 1);
+	 */
 
 	/* Do not dim fx returns */
 	com_buff[0] = 0x00;
@@ -1259,26 +1255,27 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 	descriptor_size = le16_to_cpu(get_cfg_desc(config)->wTotalLength);
 
 	if (descriptor_size != MBOX3_DESCRIPTOR_SIZE) {
-		dev_err(&dev->dev, "Invalid descriptor size=%d.\n", descriptor_size);
+		dev_err(&dev->dev, "MBOX3: Invalid descriptor size=%d.\n", descriptor_size);
 		return -ENODEV;
 	}
 
-	dev_dbg(&dev->dev, "device initialised!\n");
+	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
 		&dev->descriptor, sizeof(dev->descriptor));
 	config = dev->actconfig;
 	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
-		dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
-	dev_dbg(&dev->dev, "mbox3_boot: new boot length = %d\n",
+		dev_dbg(&dev->dev, "MBOX3: error usb_reset_configuration: %d\n", err);
+
+	dev_dbg(&dev->dev, "MBOX3: new boot length = %d\n",
 		le16_to_cpu(get_cfg_desc(config)->wTotalLength));
 
-	mbox3_setup_48_24_magic(dev);
-	dev_info(&dev->dev, "Digidesign Mbox 3: 24bit 48kHz");
+	mbox3_setup_defaults(dev);
+	dev_info(&dev->dev, "MBOX3: Initialized.");
 
 	return 0; /* Successful boot */
 }
@@ -1734,6 +1731,46 @@ static int pioneer_djm_set_format_quirk(struct snd_usb_substream *subs,
 	return 0;
 }
 
+static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
+				const struct audioformat *fmt)
+{
+	__le32 buff4 = 0;
+	u8 buff1 = 0x01;
+	u32 new_rate = subs->data_endpoint->cur_rate;
+	u32 current_rate;
+
+	// Get current rate from card and check if changing it is needed
+	snd_usb_ctl_msg(subs->dev, usb_rcvctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
+	current_rate = le32_to_cpu(buff4);
+	dev_dbg(&subs->dev->dev,
+			 "MBOX3: Current configured sample rate: %d", current_rate);
+	if (current_rate == new_rate) {
+		dev_dbg(&subs->dev->dev,
+			"MBOX3: No change needed (current rate:%d == new rate:%d)",
+			current_rate, new_rate);
+		return;
+	}
+
+	// Set new rate
+	dev_info(&subs->dev->dev,
+			 "MBOX3: Changing sample rate to: %d", new_rate);
+	buff4 = cpu_to_le32(new_rate);
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8101, &buff4, 4);
+
+	// Set clock source to Internal
+	snd_usb_ctl_msg(subs->dev, usb_sndctrlpipe(subs->dev, 0),
+					0x01, 0x21, 0x0100, 0x8001, &buff1, 1);
+
+	// Check whether the change was successful
+	buff4 = 0;
+	snd_usb_ctl_msg(subs->dev, usb_rcvctrlpipe(subs->dev, 0),
+					0x01, 0x21 | USB_DIR_IN, 0x0100, 0x8101, &buff4, 4);
+	if (new_rate != le32_to_cpu(buff4))
+		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1755,6 +1792,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x08e4, 0x0163): /* Pioneer DJM-850 */
 		pioneer_djm_set_format_quirk(subs, 0x0086);
 		break;
+	case USB_ID(0x0dba, 0x5000):
+		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
+		break;
 	}
 }
 
-- 
2.45.0


