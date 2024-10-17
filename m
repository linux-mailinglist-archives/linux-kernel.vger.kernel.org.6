Return-Path: <linux-kernel+bounces-369319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539489A1BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F511C214A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729E1CC8A0;
	Thu, 17 Oct 2024 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtUl97Qw"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08439FE5;
	Thu, 17 Oct 2024 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150437; cv=none; b=lWtPoNtsz2CybECpXUrnEWmtplF/PR76qyNaPlkkGcJfObJ+hiZK/v9N1Vg3hg/jstvo1fPbYHJSsCW0w+TtsUCgNtlXulaQ2dvKwkFu9jD40oIvmOFGZo2i2wRul6dVo9Y7hABdDAvqTQxuSutc8Go6xyP5hjIa7xf4aGDjyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150437; c=relaxed/simple;
	bh=5+1x8Jr8C9v+63fReMusHIbfjF9BtC+9mkkKuoLh+jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ntG0OG2PefbcBTbaQxT/MgFbVJIQgx1esaP3/+deqFDlgCXla4BW98LD+iJH5tSwM/rIlS8IYQBwxVF+dl+pJWvDaOPXchPm8RvgVSqVUvPDYMMZ5NiVJ2062B9okEmyLAcCpJMWDQdTSXiTaPSiubmSVTDUu7f05mPKVXvK5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtUl97Qw; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3b8b34be9so2661365ab.2;
        Thu, 17 Oct 2024 00:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729150435; x=1729755235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDZbysglnG1tM5WoUhmkv9d5GU0ZjJsKjGj9otsKzxQ=;
        b=BtUl97QwS9MTLzoJEzb2UQqCr4Af9QEghgHe4uV4mFjUFBScsj/GKyeHYa0lQwFT0r
         96j1f460iiC3DCx6oqEOfGBX3+74Cj4FVLvycstXtVpMEY+Qop4/xYaLpqJYBMZhVe3L
         zdECF1tObh9rDhfmkNjDxPjRXJwRuHpN6NtjP2HV8WRZB1EEBahVCZ8nkNz6eqDJX36W
         +GTVSKACVYgJdHs/x5HhFA8M8/HY9CwGjFkTogLsjwaWl0JP4LMsrupEtEheO22Qq34x
         NWfNwa1rrwhRvPD26gQz7+YTEUBzt+l2EMgCa2nkcV3jFtzcUJJwTXNBH0pGTHBe7vMM
         Gung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150435; x=1729755235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDZbysglnG1tM5WoUhmkv9d5GU0ZjJsKjGj9otsKzxQ=;
        b=b3osFc91EE2k5xPcNNasRH6gbQhaDAX/b6HpDO/CuuiiFqslCuyzg5r+9QShpbg+4t
         d8H5kEMYyEff+5C1R70CFNsXf3sglF7tOqetySOuayJ44IJfFfknFeX70V7e9C9rKNRI
         SkpCVOC7MTJnFx9fDthy49Jjxh+x02GRt6iTTu+BKBWCFhQUCU0+YBt3Hb2ys3Q9oQhS
         dYWTa2vLxAIsPIqvtbovc3ljvk/D8ZsYn3lTxmZqkw2AFl0mH27xkU82mPHE/JjHRowc
         2QvjEKH+6xbqDojnhGmzxNmuysqvf9rLp5mz8uLM3XTywIzPOvdc45mzFjGu5SGAeQbh
         IDQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9zOkyES6SRAtD5xf/981WB9eKSP39hOZQErKiWU22agNv4pZU4W9P9vD4mw4YbmZ0eBHpTxkyuC4=@vger.kernel.org, AJvYcCUskbmWRXvxpHzTQHIQY5GrtcFlC/vModI/BFHII7TGOiK6U0LlUj4bv1labfqf3RPnfIFOGuBQb5pDKpeI@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdAj6J6FBvZh5B/dXaA5nfWUp01RT1LUkYh5eW9ziGJO/sH+O
	h1ziKyAWZcvov9XVzsl5NysmqqKvhLDa+UDiOimlAGApRcHaXgwn
X-Google-Smtp-Source: AGHT+IFC/fmLLxywhYV2eEaxJ+fDgwKLJtnEMYUy6ZQXLfmdRQR5Z5Gu+psqnuakxu2YgJ+IGPeOHA==
X-Received: by 2002:a05:6e02:1446:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a3bcdbb5acmr166033125ab.7.1729150434691;
        Thu, 17 Oct 2024 00:33:54 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:69dd:aaa0:3d22:e047])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c7068d1sm4407455a12.75.2024.10.17.00.33.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Oct 2024 00:33:54 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] Docs/sound: Update codec-to-codec documentation
Date: Thu, 17 Oct 2024 00:33:31 -0700
Message-Id: <20241017073331.70069-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Updated documentation to provide more details
for codec-to-codec connection.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/sound/soc/codec-to-codec.rst | 258 ++++++++++++++-------
 1 file changed, 169 insertions(+), 89 deletions(-)

diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
index 0418521b6e03..d77de03cace6 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -1,10 +1,31 @@
-==============================================
-Creating codec to codec dai link for ALSA dapm
-==============================================
+Codec-to-Codec Connections in ALSA
+====================================
 
-Mostly the flow of audio is always from CPU to codec so your system
-will look as below:
-::
+An ALSA-based audio system typically involves playback and capture
+functionalities, where users may require audio file playback through
+speakers or recording from microphones. However, certain systems
+necessitate audio data routing directly between components, such as FM
+radio to speakers, without CPU involvement. For such scenarios, ALSA
+provides a mechanism known as codec-to-codec connections, leveraging
+the Dynamic Audio Power Management (DAPM) framework to facilitate
+direct data transfers between codecs.
+
+Introduction
+------------
+
+In most audio systems, audio data flows from the CPU to the codec. In
+specific configurations, such as those involving Bluetooth codecs,
+audio can be transmitted directly between codecs without CPU
+intervention. ALSA supports both architectures, and for systems that
+do not involve the CPU, it utilizes codec-to-codec digital audio
+interface (DAI) connections. This document discusses the procedure
+for establishing codec-to-codec DAI links to enable such
+functionalities.
+
+Audio Data Flow Paths
+----------------------
+
+In a typical configuration, audio flow can be visualized as follows:
 
    ---------          ---------
   |         |  dai   |         |
@@ -12,104 +33,163 @@ will look as below:
   |         |        |         |
    ---------          ---------
 
-In case your system looks as below:
-::
+In more intricate setups, the system may not involve the CPU but
+instead utilizes multiple codecs as shown below. For instance,
+Codec-2 acts as a cellular modem, while Codec-3 connects to a
+speaker. Audio data can be received by Codec-2 and transmitted to
+Codec-3 without CPU intervention, demonstrating the ideal conditions
+for establishing a codec-to-codec DAI connection.
 
                        ---------
                       |         |
-                        codec-2
+                        codec-1 <---cellular modem
                       |         |
                       ---------
                            |
-                         dai-2
-                           |
+                         dai-1
+                           ↓
    ----------          ---------
-  |          |  dai-1 |         |
-      CPU     ------->  codec-1
+  |          |cpu_dai |         |
+   dummy CPU  ------->  codec-2
   |          |        |         |
    ----------          ---------
                            |
                          dai-3
-                           |
+                           ↓
                        ---------
                       |         |
-                        codec-3
+                        codec-3 ---->speaker
                       |         |
                        ---------
 
-Suppose codec-2 is a bluetooth chip and codec-3 is connected to
-a speaker and you have a below scenario:
-codec-2 will receive the audio data and the user wants to play that
-audio through codec-3 without involving the CPU.This
-aforementioned case is the ideal case when codec to codec
-connection should be used.
-
-Your dai_link should appear as below in your machine
-file:
-::
-
- /*
-  * this pcm stream only supports 24 bit, 2 channel and
-  * 48k sampling rate.
-  */
- static const struct snd_soc_pcm_stream dsp_codec_params = {
-        .formats = SNDRV_PCM_FMTBIT_S24_LE,
-        .rate_min = 48000,
-        .rate_max = 48000,
-        .channels_min = 2,
-        .channels_max = 2,
- };
-
- {
-    .name = "CPU-DSP",
-    .stream_name = "CPU-DSP",
-    .cpu_dai_name = "samsung-i2s.0",
-    .codec_name = "codec-2,
-    .codec_dai_name = "codec-2-dai_name",
-    .platform_name = "samsung-i2s.0",
-    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-            | SND_SOC_DAIFMT_CBM_CFM,
-    .ignore_suspend = 1,
-    .c2c_params = &dsp_codec_params,
-    .num_c2c_params = 1,
- },
- {
-    .name = "DSP-CODEC",
-    .stream_name = "DSP-CODEC",
-    .cpu_dai_name = "wm0010-sdi2",
-    .codec_name = "codec-3,
-    .codec_dai_name = "codec-3-dai_name",
-    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-            | SND_SOC_DAIFMT_CBM_CFM,
-    .ignore_suspend = 1,
-    .c2c_params = &dsp_codec_params,
-    .num_c2c_params = 1,
- },
-
-Above code snippet is motivated from sound/soc/samsung/speyside.c.
-
-Note the "c2c_params" callback which lets the dapm know that this
-dai_link is a codec to codec connection.
-
-In dapm core a route is created between cpu_dai playback widget
-and codec_dai capture widget for playback path and vice-versa is
-true for capture path. In order for this aforementioned route to get
-triggered, DAPM needs to find a valid endpoint which could be either
-a sink or source widget corresponding to playback and capture path
+Creating Codec-to-Codec Connections in ALSA
+----------------------------------------------
+
+To create a codec-to-codec DAI in ALSA, a ``snd_soc_dai_link`` must be
+added to the machine driver before registering the sound card.
+During this registration, the core checks for the presence of
+``c2c_params`` within the ``snd_soc_dai_link``, determining whether
+to classify the DAI link as codec-to-codec.
+
+While establishing the PCM node, the ALSA core inspects this
+parameter. Instead of generating a user-space PCM node, it creates
+an internal PCM node utilized by kernel drivers. Consequently,
+running ``cat /proc/asound/pcm`` will yield no visible PCM nodes.
+
+After this setup, the ALSA core invokes the DAPM core to connect a
+single ``cpu_dai`` with both ``codec_dais``. Boot-up logs will
+display messages similar to:
+
+.. code-block:: bash
+
+   ASoC: registered pcm #0 codec2codec(Playback Codec)
+   multicodec <-> cpu_dai mapping ok
+   connected DAI link Dummy-CPU:cpu_dai -> codec-1:dai_1
+   connected DAI link Dummy-CPU:cpu_dai -> codec-2:dai_2
+
+To trigger this DAI link, a control interface is established by the
+DAPM core during internal DAI creation. This interface links to
+the ``snd_soc_dai_link_event`` function, which is invoked when a
+path connects in the DAPM core. A mixer must be created to trigger
+the connection, prompting the DAPM core to evaluate path
+connections and call the ``snd_soc_dai_link_event`` callback with
+relevant events.
+
+It is important to note that not all operations defined in
+``snd_soc_dai_ops`` are invoked as codec-to-codec connections offer
+limited control over DAI configuration. For greater control, a
+hostless configuration is recommended. The operations typically
+executed in codec-to-codec setups include startup, ``hw_params``,
+``hw_free``, digital mute, and shutdown from the
+``snd_soc_dai_ops`` structure.
+
+Code Changes for Codec-to-Codec
+----------------------------------
+
+The DAI link configuration in the machine file should resemble the
+following code snippet:
+
+.. code-block:: c
+
+   /*
+    * This PCM stream only supports 24-bit, 2 channels, and
+    * 48kHz sampling rate.
+    */
+   static const struct snd_soc_pcm_stream dsp_codec_params = {
+       .formats = SNDRV_PCM_FMTBIT_S24_LE,
+       .rate_min = 48000,
+       .rate_max = 48000,
+       .channels_min = 2,
+       .channels_max = 2,
+   };
+
+   static struct snd_soc_dai_link dai_links[] = {
+   {
+       .name = "CPU-DSP",
+       .stream_name = "CPU-DSP",
+       .cpu_dai_name = "samsung-i2s.0",
+       .codec_name = "codec-2",
+       .codec_dai_name = "codec-2-dai_name",
+       .platform_name = "samsung-i2s.0",
+       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+                  | SND_SOC_DAIFMT_CBM_CFM,
+       .ignore_suspend = 1,
+       .c2c_params = &dsp_codec_params,
+       .num_c2c_params = 1,
+   },
+   {
+       .name = "DSP-CODEC",
+       .stream_name = "DSP-CODEC",
+       .cpu_dai_name = "wm0010-sdi2",
+       .codec_name = "codec-3",
+       .codec_dai_name = "codec-3-dai_name",
+       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+                  | SND_SOC_DAIFMT_CBM_CFM,
+       .ignore_suspend = 1,
+       .c2c_params = &dsp_codec_params,
+       .num_c2c_params = 1,
+   },
+   };
+
+This snippet draws inspiration from the configuration found in
+``sound/soc/samsung/speyside.c``. The inclusion of the
+``c2c_params`` indicates to the DAPM core that the DAI link is a
+codec-to-codec connection.
+
+In the DAPM core, a route is established between the CPU DAI
+playback widget and the codec DAI capture widget for playback, with
+the reverse applying to the capture path. To trigger these routes,
+DAPM requires valid endpoints, which can be either sink or source
+widgets corresponding to the playback and capture paths,
 respectively.
 
-In order to trigger this dai_link widget, a thin codec driver for
-the speaker amp can be created as demonstrated in wm8727.c file, it
-sets appropriate constraints for the device even if it needs no control.
-
-Make sure to name your corresponding cpu and codec playback and capture
-dai names ending with "Playback" and "Capture" respectively as dapm core
-will link and power those dais based on the name.
-
-A dai_link in a "simple-audio-card" will automatically be detected as
-codec to codec when all DAIs on the link belong to codec components.
-The dai_link will be initialized with the subset of stream parameters
-(channels, format, sample rate) supported by all DAIs on the link. Since
-there is no way to provide these parameters in the device tree, this is
-mostly useful for communication with simple fixed-function codecs, such
-as a Bluetooth controller or cellular modem.
+To activate this DAI link widget, a lightweight codec driver for
+the speaker amplifier can be implemented, following a similar
+strategy to that in ``wm8727.c``. This driver should set the
+necessary constraints for the device, even with minimal control
+requirements.
+
+It's crucial to append “Playback” and “Capture” suffixes to the
+respective CPU and codec DAI names for playback and capture, as
+the DAPM core links and powers these DAIs based on their naming
+conventions.
+
+In a codec-to-codec scenario involving multiple codecs (above
+bootup logs are for multicodec scenario), it is not feasible to
+control individual codecs using dummy kcontrols or DAPM widgets.
+This limitation arises because the CPU DAI is statically
+connected to all codecs. Consequently, when a path is enabled,
+the DAPM core does not verify all the widgets that may be linked
+to the mixer widget. It’s important to note that the mixer widget
+serves as the trigger for these paths.
+
+Simple-audio-card configuration
+----------------------------------
+A dai_link in a "simple-audio-card" will automatically be
+detected as codec-to-codec when all DAIs on the link belong to
+codec components. The dai_link will be initialized with the
+subset of stream parameters (channels, format, sample rate)
+supported by all DAIs on the link. Since there is no way to
+provide these parameters in the device tree, this is mostly useful
+for communication with simple fixed-function codecs, such as a
+Bluetooth controller or cellular modem.
-- 
2.39.3 (Apple Git-146)


