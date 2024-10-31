Return-Path: <linux-kernel+bounces-391314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A609B850F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F9D1F25571
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C561CF5E2;
	Thu, 31 Oct 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAWfAvbV"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F61CCEF0;
	Thu, 31 Oct 2024 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409271; cv=none; b=phMdIHBtSigpIB5wbhNKoOL2zu8NZ9RW+tuQTdyeZV1dfyjpB5Rj+tlOljMVmhz/98rnAJkboKLjN3eC37BDisgGG6VrHibSCS0CCIBgFJ01tice3fGsWgA3raUYi87kulVI5E+EsJ6xfjn+7GEm/G5EocdwrURoHEqPiZZNTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409271; c=relaxed/simple;
	bh=RRtrqqMbfo9WLcBqXvrnr6HPvDcT59O7mv2nBeXr0Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R/nV7mvcdlgivQrMBjEw7xBIH+QqCK3pyDjw4TjFBeKnrFuq0tjcKQJKtuXUnDR1NHXSViNrnm9TOOVdA79YwYsW1GIcWdeoNlyoP8NpJIIo1NO+ijtDvDazhkFlgJcMFpHX8+x0F7VLfYZQ14XLrXjsTVPWQjoG2HpqDTv+VO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAWfAvbV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7181caa08a3so707929a34.0;
        Thu, 31 Oct 2024 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409264; x=1731014064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPazV1JVZ+rJiB4cQZzsaPS5152uN4daTfkLyJT4WL0=;
        b=HAWfAvbVlaHK3ojko53XJaeW8IaKaFFXYNmY/FFYXWjmlzL1KwKTMebuxlYQmFzLco
         qyY9TG13Kvn+/HjHcPbKlX6ffiYctopgJ3Hmi78KBrRqWzJ1uAK9PYAGJcGhAm3LyYU8
         nszOHsu6uUfE1Qj7Ov6xWcSDhJnTvKW+ZnpVi2l2KwQ7KUCU+BAdM0HvcvwCx5KOM0MS
         wSrS3F776cDULRpl/lw7AO3bDUqVuP+iP9YeRdFOvVM+dGNs+8iH7UiWgCcenDRFAqXL
         Jnx+wqZbwbzU6f0aVhgTS8oISh6HD+5LPqhUSa71gSfYzsqV4FEOnoL1TltZAuq6V3rz
         o4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409264; x=1731014064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPazV1JVZ+rJiB4cQZzsaPS5152uN4daTfkLyJT4WL0=;
        b=ZZniWaaO23p4WmuCYocy+Sci51Sv4PPCwvG0Tm0CnIxYnskDi8wPY1CnpEB5OFNBYh
         vAyFItKnzi5NhSsZFIltNDTRy9nEosWuARNPT7LnXmrTRSs46njfCU058ChkkPQW3s1v
         yKvO9Yh3tcicTCH2RmFork5IURIpkhi3YE4L+yFjHXzvGdkPqWL0EmtRCKXyl6wj2Q8m
         TaC0nRO6sm1qGyk0N885TcsOsMXU37xrc7zOcD4dpLZx/Os2uAj8q2/oinRJty6ZsRq6
         KU5/gSoPuo8qKOgzjkdRZ+g3cmody95GYVwyHR/qp2WBGf8qtbXbRvEZLGuPYj3zfGxk
         WErw==
X-Forwarded-Encrypted: i=1; AJvYcCUnpoSvzdLwrGvEq1cVXTO9/h1XR18Lem6fddhb/BLEq33Km52tSKF5yY4vXNF286P5iqVvff9kgN+DH7o=@vger.kernel.org, AJvYcCVU/px0dH8A+j9CPWaD0B2MzgcLCpffuCfblfQc6Jt1obGWuoaK/bvDt8hbxG3RThX4vv+ecybM4ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3G/6luQqFXZfpPQgfEqKUOSI42z6V5xWJ9vCwd8cbAwdF9cV
	nvCRnJ24YAoNi0dnuvvzXmEF8VtOl+r4koOWOF6GGO3GlaQMzEE5
X-Google-Smtp-Source: AGHT+IFmYaap2Wni351x1VdRzRSrUnsTkvh8m8muoKEvpD74QBB2JR0XQJa/rmqeyVecvmJNm7NyyA==
X-Received: by 2002:a05:6830:71aa:b0:718:12af:7efa with SMTP id 46e09a7af769-71867e65410mr24330292a34.0.1730409263823;
        Thu, 31 Oct 2024 14:14:23 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:7d08:cd12:4b73:5f28])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc7ec84sm490292a34.38.2024.10.31.14.14.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 14:14:22 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V4] Docs/sound: Update codec-to-codec documentation
Date: Thu, 31 Oct 2024 14:14:11 -0700
Message-Id: <20241031211411.58726-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updated documentation to provide more details
for codec-to-codec connection especially around
the scenarios and DAPM core details for C2C
creation.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
v4: sent wrong patch so corrected that in this.

v3: took care of comments from Charles Keepax and
as advised modified some details.

v2: Fixed the compilation error reported by Sphinx
 Documentation/sound/soc/codec-to-codec.rst | 296 +++++++++++++--------
 1 file changed, 190 insertions(+), 106 deletions(-)

 Documentation/sound/soc/codec-to-codec.rst | 307 ++++++++++++++-------
 1 file changed, 208 insertions(+), 99 deletions(-)

diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
index 0418521b6e03..c0d6e831ae4b 100644
--- a/Documentation/sound/soc/codec-to-codec.rst
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -1,115 +1,224 @@
-==============================================
-Creating codec to codec dai link for ALSA dapm
-==============================================
+Codec-to-Codec Connections in ALSA
+==================================
 
-Mostly the flow of audio is always from CPU to codec so your system
-will look as below:
-::
+An ALSA-based audio system typically involves playback and capture
+functionality, where users may require audio file playback through
+speakers or recording from microphones. However, certain systems
+necessitate audio data routing directly between components, such as FM
+radio to speakers, without CPU involvement. For such scenarios, ASoC(
+ALSA system on chip) provides a mechanism known as codec-to-codec (C2C)
+connections, leveraging the Dynamic Audio Power Management (DAPM)
+framework to facilitate direct data transfers between codecs.
 
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
+intervention. ASoC supports both architectures, and for systems that
+do not involve the CPU, it utilizes C2C digital audio
+interface (DAI) connections. This document discusses the procedure
+for establishing C2C DAI links to enable such functionality.
+
+Audio Data Flow Paths
+---------------------
+
+In a typical configuration, audio flow can be visualized as follows:
+
+.. code-block:: text
+
+    ---------          ---------
+   |         |  dai   |         |
+   |    CPU   -------->  codec  |
+   |         |        |         |
+    ---------          ---------
+
+In more intricate setups, the system may not involve the CPU but
+instead utilizes multiple codecs as shown below. For instance,
+Codec-2 acts as a cellular modem, while Codec-3 connects to a
+speaker. Audio data can be received by Codec-2 and transmitted to
+Codec-3 without CPU intervention, demonstrating the ideal conditions
+for establishing a C2C DAI connection.
+
+.. code-block:: text
 
                        ---------
                       |         |
-                        codec-2
+                      | codec-1  <---cellular modem
                       |         |
                       ---------
                            |
-                         dai-2
-                           |
-   ----------          ---------
-  |          |  dai-1 |         |
-      CPU     ------->  codec-1
-  |          |        |         |
-   ----------          ---------
+                         dai-1
+                           ↓
+    ---------          ---------
+   |         |cpu_dai |         |
+   |   CPU    ------->  codec-2 |
+   |         |        |         |
+    ---------          ---------
                            |
                          dai-3
-                           |
+                           ↓
                        ---------
                       |         |
-                        codec-3
+                      | codec-3  --->speaker
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
-respectively.
-
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
+In the diagram above, two kinds of use cases can be supported:
+
+  1. Host music playback: CPU -> codec-2 -> codec-3 -> Speaker
+
+     When an application on the host plays audio, ASoC informs the DAPM
+     (Dynamic Audio Power Management) core that the main CPU DAI
+     (Digital Audio Interface) is now an active source. DAPM then parses
+     through the audio graph until it finds the speaker sink.
+
+     The act of playing audio triggers the following power-up sequence:
+
+     - The ``CPU -> codec-2`` DAI is activated.
+     - DAPM powers up the C2C  DAI link between codec-2 and codec-3, as
+        it is part of the active audio path.
+
+  2. Cellular call: codec-1 -> codec-2 -> codec-3 -> Speaker
+
+     In this case, the host is not involved at all. The modem acts as the
+     audio source, and DAPM powers up everything between it and the sink
+     (i.e., the speaker). This power-up sequence involves:
+
+     - The C2C DAI link between codec-1 and codec-2.
+     - The C2C DAI link between codec-2 and codec-3.
+
+     DAPM ensures that all necessary components in the audio path from the
+     modem to the speaker are powered up, enabling direct audio playback
+     from the modem without host intervention.
+
+
+Creating Codec-to-Codec Connections in ALSA
+-------------------------------------------
+
+To create a C2C DAI in ALSA, a ``snd_soc_dai_link`` must be
+added to the machine driver before registering the sound card.
+During this registration, the core checks for the presence of
+``c2c_params`` within the ``snd_soc_dai_link``, determining whether
+to classify the DAI link as C2C.
+
+While establishing the PCM node, the ASoC core inspects this
+parameter. Instead of generating a user-space PCM node, it creates
+an internal PCM node utilized by kernel drivers. Consequently,
+running ``cat /proc/asound/pcm`` will yield no visible PCM nodes.
+
+Boot-up logs will display message similar to:
+
+.. code-block:: text
+
+   ASoC: registered pcm #0 codec2codec(Playback Codec)
+
+To trigger this DAI link, a control interface is established by the
+DAPM core during internal DAI creation. This interface links to
+the ``snd_soc_dai_link_event`` function, which is invoked when a
+path connects in the DAPM core. A mixer must be created to trigger
+the connection, prompting the DAPM core to evaluate path
+connections and call the ``snd_soc_dai_link_event`` callback with
+SND_SOC_DAPM_*_PMU and SND_SOC_DAPM_*_PMD events.
+
+It is important to note that not all operations defined in
+``snd_soc_dai_ops`` are invoked as C2C connections offer
+limited control over DAI configuration. The operations typically
+executed in C2C setups include startup, ``hw_params``, ``hw_free``,
+digital mute, and shutdown from the ``snd_soc_dai_ops`` struct.
+
+Code Changes for Codec-to-Codec
+-------------------------------
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
+To better understand the configuration inspired by the setup found in
+``sound/soc/samsung/speyside.c``, here are several key points:
+
+1. The presence of ``c2c_params`` informs the DAPM core that the DAI link
+   represents a C2C connection.
+
+2. ``c2c_params`` can be an array, and ``num_c2c_params`` defines the size
+   of this array.
+
+3. If ``num_c2c_params`` is 1:
+
+   - The C2C DAI is configured with the provided ``snd_soc_pcm_stream``
+     parameters.
+
+4. If ``num_c2c_params`` is greater than 1:
+
+   - A kcontrol is created, allowing the user to select the index of the
+     ``c2c_params`` array to be used.
+
+This flexible approach enables dynamic configuration of C2C
+connections based on runtime requirements.
+
+In the DAPM core, a route is established between the CPU DAI
+playback widget and the codec DAI capture widget for playback, with
+the reverse applying to the capture path. To trigger these routes,
+DAPM requires valid endpoints, which can be either sink or source
+widgets corresponding to the playback and capture paths, respectively.
+
+To activate this DAI link widget, codec driver is required.
+If it doesn't exist, thin codec driver can be implemented,
+following a similar strategy to that in ``wm8727.c``. This driver
+should set the necessary constraints for the device, even with
+minimal control requirements.
+
+
+Simple-audio-card configuration
+-------------------------------
+
+A dai_link in a "simple-audio-card" will automatically be
+detected as C2C when all DAIs on the link belong to
+codec components. The dai_link will be initialized with the
+subset of stream parameters (channels, format, sample rate)
+supported by all DAIs on the link. Since there is no way to
+provide these parameters in the device tree, this is mostly useful
+for communication with simple fixed-function codecs, such as a
+Bluetooth controller or cellular modem.
-- 
2.39.3 (Apple Git-146)


