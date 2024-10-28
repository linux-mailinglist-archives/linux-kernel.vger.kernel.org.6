Return-Path: <linux-kernel+bounces-385706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB769B3A97
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E8282388
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979651DE3D2;
	Mon, 28 Oct 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgyOSysK"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186D18B03;
	Mon, 28 Oct 2024 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144491; cv=none; b=Y9KWwYYANNJRMLOVJaohRQx+w2GI5pwOT9BlmwC4C/2BKVyvD8WnKczLiSuvDblE9rfPSu5aFnXsJmsHOb8HGGbutl8hhfesKeqVJ/reDcfILAqYojOZzK3iD3W7pp8MaruGgk0Cp2tSobFa2YjTdJQREVdXuOTSH9dt8ThvLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144491; c=relaxed/simple;
	bh=hBl1sYNtrFLUewWMKMHIRpfo5/AinVFZAjPNm/oYJDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sj2eu0SdKgovJJ5BAnBnhQKf1IKhiym2ROue6HDJSGxdudQZHB5EyUopi7XvfQuIVxtOBroPlSfeVmiB/gnJ/HgtNHOtnPROenCtIJZEY83Ge1fLF0DYvBFsBwKvF7rUWV/f9XyYcfQapBquZfunouG+XBuhLJPKJJlY6kbnbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgyOSysK; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718065d6364so2358935a34.3;
        Mon, 28 Oct 2024 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730144488; x=1730749288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JgEbEcCSZiSK7etjTaCFqcwxtnmWkrk3M5C6kawkqBY=;
        b=MgyOSysKVJeIEnym4V6xgqIdQlf1RSqDMfGK60CxMeXjjUSm4W1LNSei9AISz+xPx5
         M82lSlqAX/TAZQHVgzR7Crhz8NWcn2P8JM3+HcWvvtqHrqrVtfWSLlubjgoWn1fiMvbX
         k/4/6WzL5wthvaEjGNXB6g7FQYMnhiwzt6EI5VA2pS9Z5yI5G+4hJMqZh39s4Dw52f0V
         waDNxpOnt+mqTgDTVnzoEBN0P+R3ko8wBgTcsmZTOrs6vyDj5yvJ7XzB6F4G0QeCayif
         O/SFA4JBqtimZXyjTelIsKm8qfzzWd39eRyc/rZJ3V16P2WKkf0YuFV7HBgDWjkODVsT
         M7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144488; x=1730749288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgEbEcCSZiSK7etjTaCFqcwxtnmWkrk3M5C6kawkqBY=;
        b=fPYEJdCyFnr0b03iZ9oqpNzEe1furDX7rKBpJeBtc9uDzHC/IfELuwkz/71hRCuRZ3
         y9DB3RFw3kWG+wfVoDqIn/jEVRU1A6DpdpLEvggJfaeiBZjSUobNlRXgQUGoAeY3TSy2
         ajkEETY2bAPyIfgZahH38Fk8EM0eC//+4ifl9lbL9rIs7MJpxqrqCTLs25tLl0E4elNY
         7yWwYnSmUF09BT5JliV1f93pUNdyz9kccrbAU2PLxi3uVHeCVMWqtzptNWNMB/LnE9yX
         8ZMRGeMwZpKetnEYn1NwE4VDuJZ9e+3+hoCx1p7tI1G3bJoLRA2D94VaQ81Dwb/fsxnM
         HAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXXOH14IL5YgpugIlUjNgmCPIBxCQJTaoHqcZTE64thZUZRAuPluQZJUd0BIG09s9bW2xzYwYH6KQqY1c=@vger.kernel.org, AJvYcCVjMrH3Dw5W35efBxzSkrat8qOc7N5ffrgFLLypKdMuwgmEYpth7IGXQGvDxkQVzNU9e8mezFNIeKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQN5P2bz+G9K9p7BlE8vnicqH3QqA9LRFK1HQDrppezRi02bc1
	1NYhmgiw2coQMKJPNmQUqEFcCyWs3oYxxGn9fPYpodj05fNkclInHE1YrHWnuCY=
X-Google-Smtp-Source: AGHT+IEoy3bGFooKkVmNhM6ZnO64UDWfv0W8S2Hu3LbH0eF1ytlcKlPXTpQbGippZvj+SaHJleIroA==
X-Received: by 2002:a05:6870:6108:b0:27c:475c:ab34 with SMTP id 586e51a60fabf-29051aec7dcmr7013063fac.2.1730144487729;
        Mon, 28 Oct 2024 12:41:27 -0700 (PDT)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:2997:e60e:7ac2:23b9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29035da583esm2197366fac.21.2024.10.28.12.41.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 12:41:26 -0700 (PDT)
From: anish kumar <yesanishhere@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	ckeepax@opensource.cirrus.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V3] Docs/sound: Update codec-to-codec documentation
Date: Mon, 28 Oct 2024 12:41:21 -0700
Message-Id: <20241028194121.41993-1-yesanishhere@gmail.com>
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
for codec-to-codec connection.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
v3: took care of comments from Charles Keepax and
as advised modified some details.

v2: Fixed the compilation error reported by Sphinx
 Documentation/sound/soc/codec-to-codec.rst | 296 +++++++++++++--------
 1 file changed, 190 insertions(+), 106 deletions(-)


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


