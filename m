Return-Path: <linux-kernel+bounces-373320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A767F9A553F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632252812A3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED4194A65;
	Sun, 20 Oct 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMK+NFCC"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D51194088;
	Sun, 20 Oct 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729442235; cv=none; b=GLE2bu5DnVcrr6YncjmpOG4QQa4geKE0+z/Nr7krVqijKWEN4Ye7qlBs56G3CUiQdd7F9abmK7isbxsdv7kREKHRCQMftnRAYys39hQIkHaMxW9oLYn0laQ7GJEj6bISLndESlj5mNiZceJn0LWy/gFHmY3XlnP/M9n/nP4wAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729442235; c=relaxed/simple;
	bh=rvmJz+Wgyw/Cmr6DHb2hnQsmuQuHObEl2EJfqkXpHJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=O5IRCJzsuHwnOXrXAq+5LXyrpbcwhTbZKlXFSqolUPOTtChZLg7kbOWIUhu+alysLNNlXd1R1VtsK15QymziuKU5cJezE33y+dyzwuEy98BOlCMFv5VP+JVdz89pIFpB6RifQGacw9zH6XKw05sjGYDVet6lEvmnZShLHXjE5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMK+NFCC; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e6089a1d39so397295b6e.0;
        Sun, 20 Oct 2024 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729442232; x=1730047032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUohUFPfAAQM1V0jLQ2nBPzf1tOOoZZVZknADFBS9ug=;
        b=MMK+NFCCmD++gGeVGJhIw1AMcF77QdUjTPGxoXPWJOhJLmQqvmGbQmoBsF6xivfVNM
         m34CJTCciVLdCi0MVm/wvO1ztxHsMaQCxOuK8IyqFdEJUSK60lB4ugKWBAJloXLJnk7O
         hkpRR+XGMzfijxkYyCrJcA1JYnNWWYV6847Rb3Ac6Zf8rH3Wm7n6ABgTb2LTpKoJ/6wt
         ivMiU25HbWzs9gFn/JGPUGoZdrebW57cDWEwJPEJ1hpWwk9Q/5ee94G3D9umSPR0t0Ep
         VInG4ngZoxQqHV6D4v2eM7MVJSJVUYvT3FKQacdSL9JdQmvLGwUf25Suf1p1ZuRLNBiY
         5xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729442232; x=1730047032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUohUFPfAAQM1V0jLQ2nBPzf1tOOoZZVZknADFBS9ug=;
        b=g5t8aGWNGxF0FxtMEdX4EBTrt5t3eLsPSetWOjKT0fuPsCpzAdSTK8HhoyJ5vvUBkl
         Q6Z9sn7u6V6y7tq1XsdGIP5umhiTU0Nw/pqP9sjsi6PphAF5wOpn6AiNdDVtwi0sBv75
         cKV456exe02iVNqHkTBWZ1TFyxZ1P257R+kC2ucPT6rZcxlpbOWboMft8///CR5pLF41
         pHcObU5IkICX6mvRySv7g4dIK8/pRj6RNRHTIiXmIoxUMcLZgydMzGm+7GmUy3orYNKp
         G0nY8kHOWP09Bj2+ACYXMiBKOBWsZCNkYHTOnBOE+b2y4vpLQ942uxXsfpYbxfNJ07jY
         PoEw==
X-Forwarded-Encrypted: i=1; AJvYcCUC0Dhi+kozpf4y98rRG5G3GohFO2TpFCsG6X4jAorf0KzsdFdl3OMlOdNQCrzWcBVWpdgSVAxwWNLk7U0M@vger.kernel.org, AJvYcCVV+mIJ+vk/66qPO+FmngXiZOVO/d6TK6glj7ii7i9gbSnTSQ41xTrEf1LbokzzP9KuDZNAZdRUjiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0ZFKjmvjLrZsdholtSt5hzdZMKnyJTKaFJ/W32MRlWV0wpMw
	lZjDMoKGU3v0Uo4urTsy9y3HcSPAzuc98mc1vmMeSn6t/kW4o3Ap
X-Google-Smtp-Source: AGHT+IG6+mIWPHmpWUMZjAqmQaaJ3YFMC0wFIwCJCqedRc7enzXGUi0+XwzjPPjecghNZnq972rEaA==
X-Received: by 2002:a05:6808:3a0d:b0:3e0:4ecb:e90b with SMTP id 5614622812f47-3e602c4f9dfmr7235183b6e.1.1729442232067;
        Sun, 20 Oct 2024 09:37:12 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:183b:c6cf:8f19:74f6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ebb7a0925dsm391778eaf.12.2024.10.20.09.37.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Oct 2024 09:37:10 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH v2] Docs/sound: Update codec-to-codec documentation
Date: Sun, 20 Oct 2024 09:37:06 -0700
Message-Id: <20241020163706.87123-1-yesanishhere@gmail.com>
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
v2: Fixed the compilation error reported by Sphinx
 Documentation/sound/soc/codec-to-codec.rst | 296 +++++++++++++--------
 1 file changed, 190 insertions(+), 106 deletions(-)

diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
index 0418521b6e03..9d65fc74856a 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -1,115 +1,199 @@
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
 
-   ---------          ---------
-  |         |  dai   |         |
-      CPU    ------->    codec
-  |         |        |         |
-   ---------          ---------
+Introduction
+------------
 
-In case your system looks as below:
-::
+In most audio systems, audio data flows from the CPU to the codec. In
+specific configurations, such as those involving Bluetooth codecs,
+audio can be transmitted directly between codecs without CPU
+intervention. ALSA supports both architectures, and for systems that
+do not involve the CPU, it utilizes codec-to-codec digital audio
+interface (DAI) connections. This document discusses the procedure
+for establishing codec-to-codec DAI links to enable such
+functionalities.
 
+Audio Data Flow Paths
+----------------------
+
+In a typical configuration, audio flow can be visualized as follows:
+
+.. code-block:: text
+
+    ---------          ---------
+   |         |  dai   |         |
+       CPU    ------->    codec
+   |         |        |         |
+    ---------          ---------
+
+In more intricate setups, the system may not involve the CPU but
+instead utilizes multiple codecs as shown below. For instance,
+Codec-2 acts as a cellular modem, while Codec-3 connects to a
+speaker. Audio data can be received by Codec-2 and transmitted to
+Codec-3 without CPU intervention, demonstrating the ideal conditions
+for establishing a codec-to-codec DAI connection.
+
+.. code-block:: text
+
+                        ---------
+                       |         |
+                         codec-1 <---cellular modem
+                       |         |
                        ---------
-                      |         |
-                        codec-2
-                      |         |
-                      ---------
-                           |
-                         dai-2
-                           |
-   ----------          ---------
-  |          |  dai-1 |         |
-      CPU     ------->  codec-1
-  |          |        |         |
-   ----------          ---------
-                           |
-                         dai-3
-                           |
-                       ---------
-                      |         |
-                        codec-3
-                      |         |
+                            |
+                          dai-1
+                            ↓
+    ----------          ---------
+   |          |cpu_dai |         |
+    dummy CPU  ------->  codec-2
+   |          |        |         |
+    ----------          ---------
+                            |
+                          dai-3
+                            ↓
+                        ---------
+                       |         |
+                         codec-3 ---->speaker
+                       |         |
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


