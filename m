Return-Path: <linux-kernel+bounces-436152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020039E81D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A3B164DDD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9D15443F;
	Sat,  7 Dec 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia8Jw+rk"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696238FA3;
	Sat,  7 Dec 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733600092; cv=none; b=nW3AMOVUoZ7se5i+SMV30IHiTxO8yksG/r/+poi15Jpd8m7LT4fefTPhRiAw+tOi3ugU/98b+guUu7cflUh1rQy1dsYzHMf34ZMKrEryTiUDo5oQPW4W/mbvT7ayVwIW6RYdh2O9zWJGh4n3B8EEqIMyYRD9hclGuu0pm+0kucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733600092; c=relaxed/simple;
	bh=nqfUvlFBcsmUoaIOQoYeZ2LXYPARR32h2U4vXTuKcMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IbvwoV/9m+S6g/bMqkOnYxUG/jhmIdt+bMDc2CJ83PE4mUaG7NTqn+BsTeQKQYbrXRqMfVW7fSojSniVtVStQguft1cjhueVWRPgugyNLDFJ3Bjc+t922GdZELuSzQYC9ZGqikAvrltXr/rcYUWsbN5TphFSeqGeLNPnWfQ++Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia8Jw+rk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so2755054a91.2;
        Sat, 07 Dec 2024 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733600090; x=1734204890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgFZ/HFaSDxfRBFEHC0Pm6A0foJnIzsL2AHmolvciag=;
        b=ia8Jw+rkyN63zaJ8nzgAVR9ekC7l9fqkU7KihIxC2qBRH4ws6k4PaGv+M9ThNa1SGj
         Oi2wApXFgsoZuK30XqQ/LRZ/GjSh7Z19wRcPMgx5rmWxEhsEnCT1J2MtGJTev4ou5wej
         tybagSn219qMQ7ktqueDWdbRnZipjt0ChKriwmz2k+Pv54l3uqq7Olfm09UWhVRTl2+s
         yMUKH3J3G4P0HsBW6w4bC6kQedASTCUULcqLVbdqNnrt3nDOf65T/i18mmN+d0TVMGqw
         z70YIbM1ZJM1DVDFhmlo0YJzczIC/lo0OG/FlwS6AyBbw1ZECspPljuO+fHJZiO8JD7X
         ILXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733600090; x=1734204890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgFZ/HFaSDxfRBFEHC0Pm6A0foJnIzsL2AHmolvciag=;
        b=wSAwHwpP4Sp+txvg3AZFu3kuzkqFpxB7yVRa473Idz4BAUIBLoiRjxnrnMEWCJpVUE
         H+imWFzulNmJiVcE8KZlsLedzjxbqsCPHHSkT5fK2ihSPjElcgsmDlzSFnsgZIt1xxLb
         BNhg5FITO+1d+v34yjqAOMWk0wEyzBJbt97SD3SS/9RE7AbrWqUyeGVjLxtLNlLRP/kp
         RyVbz5l7+yTftc+6FlrRgyxOUCvEQKSg4Xj5l6MKVNtp9WkZgoG/WwvZGJfGdkAVFAxh
         Z73Ipe+WLee1JvBxKBw1AS9pAEr8QQ/zHzjilEpvBW84F5yhx8ppi/pbmx9nPok8H9SK
         NYGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlBBGsXGuaLMSeZZO7k0jaRhQcwgL0UAgpcv2Pxcpf45eSAN/XwIlVAK2xeutlmi7EfDbbiZCrtVO68Xo=@vger.kernel.org, AJvYcCW4XN47YN+S+I856LPa6KVsVh19KHcgcLlDlKBBSwUvMGw5W6oIDovHY1A0KK1UuOczTCvDZBMlI+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFZSwdKRMEB0S9cNpng2FWxTVsFvDJJmGJtHGuL6PeAyhnuK0
	CydD1eaHhYy/N0i+FmWX1j1ObRo4Rx/j/sLWxLR8p3206oBm7ueH
X-Gm-Gg: ASbGncv192Bv3wtqpJMtxKttKbcLPagfsj77YzUdVkhIIquNaDII6mSCw8pS1kr1J3T
	LsYNg7z4gzub0rK88ZbaBvgjvjCKf2yetwc8App7k+n1P2XtOlDPdu/RgP/DoddOuUpKucsISmM
	+ZZPhHqRw249F6zBbEqFoU5+tqL6beMCdZkG/axNjQDGNtHGr+7zP2VZgYVtFUc2uWHITtpRdaO
	OQXsd2o4WKGCpIsZ3W3zB9ntnJTp8+BrbG8kvq2AP3mobQw4mrWzqpQV0eiG+xTv3hx0iFYMXHD
	4c/p9binPSXwOg==
X-Google-Smtp-Source: AGHT+IFM2JmBB2TpdEbZr5Hbim7/Qc7pjJTAUbw1qqYla7Q5TfkNTZF8/jlhgtk8x8dwW8W3ES4xAA==
X-Received: by 2002:a17:90b:2e51:b0:2ee:d18c:7d84 with SMTP id 98e67ed59e1d1-2ef6a6c10b4mr11737208a91.20.1733600089933;
        Sat, 07 Dec 2024 11:34:49 -0800 (PST)
Received: from MacBookAir.attlocal.net ([2600:1700:3bdc:8c10:984:d257:75a0:74fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff86d9sm7122491a91.1.2024.12.07.11.34.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Dec 2024 11:34:49 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: ckeepax@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH V5] Docs/sound: Update codec-to-codec documentation
Date: Sat,  7 Dec 2024 11:34:41 -0800
Message-Id: <20241207193441.15767-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
v5: took care of further review comments regarding some
wording from Charles Keepax. 

v4: sent wrong patch so corrected that in this.

v3: took care of comments from Charles Keepax and
as advised modified some details.

v2: Fixed the compilation error reported by Sphinx

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
2.39.5 (Apple Git-154)


