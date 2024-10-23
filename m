Return-Path: <linux-kernel+bounces-378414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDF9ACFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8663A2830A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17901CACFE;
	Wed, 23 Oct 2024 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VJaIwZze"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9E4436E;
	Wed, 23 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699863; cv=none; b=GIDue9DC+EW7BvYfIn5fcnUbk5cZtHOLEGHuORIl+Pide3djwvMDKHUZZ626321hu/nMOXSwy1Ueg8bkFmJLs2XLbX6KXP9dbRm+QuaehtQAZxdAKM0VVkM3D3ijyh6LhUt8UkNMVdVbOMIlMM/lu1dWjUuNsTcgfAT6rTgWl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699863; c=relaxed/simple;
	bh=/fMnAKipRWz5meItYmPgZCeUikgfPL9WlLDpnr3UH6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=facjzPTpK3PmNUV2f1ujLjRy9kjAktQlFGm5CTYBpvQbijfuDPTAKeKTcaoUhbM6wFvgoGTIhByqyxw7IAlanKIzRynq4lZnvsYFD+W7eZB8Yy4LZkKwMBToJ4aKC5/QQq3YeDkfyHkGOmFrdpF103j/UaUjgcwixzND4G/RjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VJaIwZze; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2bpcl023824;
	Wed, 23 Oct 2024 11:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Qvw2a/fYBfF9qGLIUbJFY4FB2YChhHMN/toAQJizcTs=; b=
	VJaIwZzez6khEzVVUy1JhcCnPueuO9oFWbbL5sVBZnXqirsTRvd9hm1heDXFykXZ
	D8c0l0CkeacjVQ26Xu0tztytvxD8ennyhnwfIZqBHtk8bXhDbHbaeEJD8eSSN86E
	ajnYeQJRWiY76EMzZyrPxuaZMv3KzsHMaJIxk8OnH4Q4e50tKvEYPCMkaIvGvWve
	Y1EJyilxtC09+f8FSv+PNz59DHGchk+HK1ExQ9/V0+acknSwjlxf9h+uIquTjXlb
	SDjNBzflFCw0k3df23H7KEri4zgJTw4/MjkkLlvoVk7TBL/ad6Tywe9SaNrl+GGU
	uE25zWm0IAzL6MiIfUfA/g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jd634-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 11:10:51 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 17:10:49 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 17:10:49 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id D4EC582255A;
	Wed, 23 Oct 2024 16:10:49 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:10:48 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: anish kumar <yesanishhere@gmail.com>
CC: <perex@perex.cz>, <tiwai@suse.com>, <corbet@lwn.net>,
        <linux-sound@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
References: <20241020163706.87123-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241020163706.87123-1-yesanishhere@gmail.com>
X-Proofpoint-GUID: fEUCXbuS4poZkn211Kpz0IZ6zmn1WfLT
X-Proofpoint-ORIG-GUID: fEUCXbuS4poZkn211Kpz0IZ6zmn1WfLT
X-Proofpoint-Spam-Reason: safe

On Sun, Oct 20, 2024 at 09:37:06AM -0700, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---

The patch doesn't seem to apply cleanly for me, my system doesn't
seem to like:

Content-Type: text/plain; charset="y"

Not sure if that is a problem on my end or yours, but I am not
familiar with that encoding.

> v2: Fixed the compilation error reported by Sphinx
>  Documentation/sound/soc/codec-to-codec.rst | 296 +++++++++++++--------
>  1 file changed, 190 insertions(+), 106 deletions(-)
> 
> diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation/sound/soc/codec-to-codec.rst
> index 0418521b6e03..9d65fc74856a 100644
> --- a/Documentation/sound/soc/codec-to-codec.rst
> +++ b/Documentation/sound/soc/codec-to-codec.rst
> @@ -1,115 +1,199 @@
> -==============================================
> -Creating codec to codec dai link for ALSA dapm
> -==============================================
> +Codec-to-Codec Connections in ALSA
> +====================================
>  
> -Mostly the flow of audio is always from CPU to codec so your system
> -will look as below:
> -::
> +An ALSA-based audio system typically involves playback and capture
> +functionalities, where users may require audio file playback through

functionality would probably parse slightly better.

> +speakers or recording from microphones. However, certain systems
> +necessitate audio data routing directly between components, such as FM
> +radio to speakers, without CPU involvement. For such scenarios, ALSA

It would probably be more accurate to say "ASoC provides", I mean
I guess ASoC is a part of ALSA but this is definitely an ASoC
level feature.

> +provides a mechanism known as codec-to-codec connections, leveraging
> +the Dynamic Audio Power Management (DAPM) framework to facilitate
> +direct data transfers between codecs.
>  
> -   ---------          ---------
> -  |         |  dai   |         |
> -      CPU    ------->    codec
> -  |         |        |         |
> -   ---------          ---------
> +Introduction
> +------------
>  
> -In case your system looks as below:
> -::
> +In most audio systems, audio data flows from the CPU to the codec. In
> +specific configurations, such as those involving Bluetooth codecs,
> +audio can be transmitted directly between codecs without CPU
> +intervention. ALSA supports both architectures, and for systems that
> +do not involve the CPU, it utilizes codec-to-codec digital audio
> +interface (DAI) connections. This document discusses the procedure
> +for establishing codec-to-codec DAI links to enable such
> +functionalities.
>  
> +Audio Data Flow Paths
> +----------------------
> +
> +In a typical configuration, audio flow can be visualized as follows:
> +
> +.. code-block:: text
> +
> +    ---------          ---------
> +   |         |  dai   |         |
> +       CPU    ------->    codec
> +   |         |        |         |
> +    ---------          ---------
> +
> +In more intricate setups, the system may not involve the CPU but
> +instead utilizes multiple codecs as shown below. For instance,
> +Codec-2 acts as a cellular modem, while Codec-3 connects to a
> +speaker. Audio data can be received by Codec-2 and transmitted to
> +Codec-3 without CPU intervention, demonstrating the ideal conditions
> +for establishing a codec-to-codec DAI connection.
> +
> +.. code-block:: text
> +
> +                        ---------
> +                       |         |
> +                         codec-1 <---cellular modem
> +                       |         |
>                         ---------
> -                      |         |
> -                        codec-2
> -                      |         |
> -                      ---------
> -                           |
> -                         dai-2
> -                           |
> -   ----------          ---------
> -  |          |  dai-1 |         |
> -      CPU     ------->  codec-1
> -  |          |        |         |
> -   ----------          ---------
> -                           |
> -                         dai-3
> -                           |
> -                       ---------
> -                      |         |
> -                        codec-3
> -                      |         |
> +                            |
> +                          dai-1
> +                            ↓
> +    ----------          ---------
> +   |          |cpu_dai |         |
> +    dummy CPU  ------->  codec-2

Bringing the "dummy" into this is quite misleading, that really
relates to DPCM setups. DPCM lets one select any number of back
ends to service a given front end PCM, and often are abused to
achieve things that should really be implemented as C2C links.

> +   |          |        |         |
> +    ----------          ---------
> +                            |
> +                          dai-3
> +                            ↓
> +                        ---------
> +                       |         |
> +                         codec-3 ---->speaker
> +                       |         |
>                         ---------
>  
> -Suppose codec-2 is a bluetooth chip and codec-3 is connected to
> -a speaker and you have a below scenario:
> -codec-2 will receive the audio data and the user wants to play that
> -audio through codec-3 without involving the CPU.This
> -aforementioned case is the ideal case when codec to codec
> -connection should be used.
> -
> -Your dai_link should appear as below in your machine
> -file:
> -::
> -
> - /*
> -  * this pcm stream only supports 24 bit, 2 channel and
> -  * 48k sampling rate.
> -  */
> - static const struct snd_soc_pcm_stream dsp_codec_params = {
> -        .formats = SNDRV_PCM_FMTBIT_S24_LE,
> -        .rate_min = 48000,
> -        .rate_max = 48000,
> -        .channels_min = 2,
> -        .channels_max = 2,
> - };
> -
> - {
> -    .name = "CPU-DSP",
> -    .stream_name = "CPU-DSP",
> -    .cpu_dai_name = "samsung-i2s.0",
> -    .codec_name = "codec-2,
> -    .codec_dai_name = "codec-2-dai_name",
> -    .platform_name = "samsung-i2s.0",
> -    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> -            | SND_SOC_DAIFMT_CBM_CFM,
> -    .ignore_suspend = 1,
> -    .c2c_params = &dsp_codec_params,
> -    .num_c2c_params = 1,
> - },
> - {
> -    .name = "DSP-CODEC",
> -    .stream_name = "DSP-CODEC",
> -    .cpu_dai_name = "wm0010-sdi2",
> -    .codec_name = "codec-3,
> -    .codec_dai_name = "codec-3-dai_name",
> -    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> -            | SND_SOC_DAIFMT_CBM_CFM,
> -    .ignore_suspend = 1,
> -    .c2c_params = &dsp_codec_params,
> -    .num_c2c_params = 1,
> - },
> -
> -Above code snippet is motivated from sound/soc/samsung/speyside.c.
> -
> -Note the "c2c_params" callback which lets the dapm know that this
> -dai_link is a codec to codec connection.
> -
> -In dapm core a route is created between cpu_dai playback widget
> -and codec_dai capture widget for playback path and vice-versa is
> -true for capture path. In order for this aforementioned route to get
> -triggered, DAPM needs to find a valid endpoint which could be either
> -a sink or source widget corresponding to playback and capture path
> +Creating Codec-to-Codec Connections in ALSA
> +----------------------------------------------
> +
> +To create a codec-to-codec DAI in ALSA, a ``snd_soc_dai_link`` must be
> +added to the machine driver before registering the sound card.
> +During this registration, the core checks for the presence of
> +``c2c_params`` within the ``snd_soc_dai_link``, determining whether
> +to classify the DAI link as codec-to-codec.
> +
> +While establishing the PCM node, the ALSA core inspects this
> +parameter. Instead of generating a user-space PCM node, it creates
> +an internal PCM node utilized by kernel drivers. Consequently,

I am not sure I like the description of this as an internal PCM
node, I guess in some ways the core does use the same structures
it would for a PCM node, but it isn't really a PCM node. I
do like that you have added the additional note this will not be
visible through procfs though.

> +running ``cat /proc/asound/pcm`` will yield no visible PCM nodes.
> +
> +After this setup, the ALSA core invokes the DAPM core to connect a

Again really ASoC core here.

> +single ``cpu_dai`` with both ``codec_dais``. Boot-up logs will
> +display messages similar to:

That is definitely not what should be happening with a C2C link.
In the system you showed the diagram for above there should be a
connection between the CPU and codec-2, then two separate links
between codec-2 and codecs 1 and 3. No links should be present
between the CPU and codecs 1 or 3.

> +
> +.. code-block:: bash
> +
> +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> +   multicodec <-> cpu_dai mapping ok
> +   connected DAI link Dummy-CPU:cpu_dai -> codec-1:dai_1
> +   connected DAI link Dummy-CPU:cpu_dai -> codec-2:dai_2
> +

Yeah this is definitely mixing in a fair amount of DPCM stuff and
does not match the rest of the description.

> +To trigger this DAI link, a control interface is established by the
> +DAPM core during internal DAI creation. This interface links to
> +the ``snd_soc_dai_link_event`` function, which is invoked when a
> +path connects in the DAPM core. A mixer must be created to trigger
> +the connection, prompting the DAPM core to evaluate path
> +connections and call the ``snd_soc_dai_link_event`` callback with
> +relevant events.
> +
> +It is important to note that not all operations defined in
> +``snd_soc_dai_ops`` are invoked as codec-to-codec connections offer
> +limited control over DAI configuration. For greater control, a
> +hostless configuration is recommended. The operations typically

It is not clear to me what a "hostless configuration" is here.

> +executed in codec-to-codec setups include startup, ``hw_params``,
> +``hw_free``, digital mute, and shutdown from the
> +``snd_soc_dai_ops`` structure.
> +
> +Code Changes for Codec-to-Codec
> +----------------------------------
> +
> +The DAI link configuration in the machine file should resemble the
> +following code snippet:
> +
> +.. code-block:: c
> +
> +   /*
> +    * This PCM stream only supports 24-bit, 2 channels, and
> +    * 48kHz sampling rate.
> +    */
> +   static const struct snd_soc_pcm_stream dsp_codec_params = {
> +       .formats = SNDRV_PCM_FMTBIT_S24_LE,
> +       .rate_min = 48000,
> +       .rate_max = 48000,
> +       .channels_min = 2,
> +       .channels_max = 2,
> +   };
> +
> +   static struct snd_soc_dai_link dai_links[] = {
> +   {
> +       .name = "CPU-DSP",
> +       .stream_name = "CPU-DSP",
> +       .cpu_dai_name = "samsung-i2s.0",
> +       .codec_name = "codec-2",
> +       .codec_dai_name = "codec-2-dai_name",
> +       .platform_name = "samsung-i2s.0",
> +       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +                  | SND_SOC_DAIFMT_CBM_CFM,
> +       .ignore_suspend = 1,
> +       .c2c_params = &dsp_codec_params,
> +       .num_c2c_params = 1,
> +   },
> +   {
> +       .name = "DSP-CODEC",
> +       .stream_name = "DSP-CODEC",
> +       .cpu_dai_name = "wm0010-sdi2",
> +       .codec_name = "codec-3",
> +       .codec_dai_name = "codec-3-dai_name",
> +       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +                  | SND_SOC_DAIFMT_CBM_CFM,
> +       .ignore_suspend = 1,
> +       .c2c_params = &dsp_codec_params,
> +       .num_c2c_params = 1,
> +   },
> +   };
> +
> +This snippet draws inspiration from the configuration found in
> +``sound/soc/samsung/speyside.c``. The inclusion of the
> +``c2c_params`` indicates to the DAPM core that the DAI link is a
> +codec-to-codec connection.
> +
> +In the DAPM core, a route is established between the CPU DAI
> +playback widget and the codec DAI capture widget for playback, with
> +the reverse applying to the capture path. To trigger these routes,
> +DAPM requires valid endpoints, which can be either sink or source
> +widgets corresponding to the playback and capture paths,
>  respectively.
>  
> -In order to trigger this dai_link widget, a thin codec driver for
> -the speaker amp can be created as demonstrated in wm8727.c file, it
> -sets appropriate constraints for the device even if it needs no control.
> -
> -Make sure to name your corresponding cpu and codec playback and capture
> -dai names ending with "Playback" and "Capture" respectively as dapm core
> -will link and power those dais based on the name.
> -
> -A dai_link in a "simple-audio-card" will automatically be detected as
> -codec to codec when all DAIs on the link belong to codec components.
> -The dai_link will be initialized with the subset of stream parameters
> -(channels, format, sample rate) supported by all DAIs on the link. Since
> -there is no way to provide these parameters in the device tree, this is
> -mostly useful for communication with simple fixed-function codecs, such
> -as a Bluetooth controller or cellular modem.
> +To activate this DAI link widget, a lightweight codec driver for
> +the speaker amplifier can be implemented, following a similar
> +strategy to that in ``wm8727.c``. This driver should set the
> +necessary constraints for the device, even with minimal control
> +requirements.

Would actually be nice to include the note that any codec driver
should be fine, the original text does kinda give the impression
one would have to write a "thin codec driver" but if you already
have a driver thin or otherwise that would be fine. Perhaps
better to rephrase as a codec driver being required.

> +
> +It's crucial to append “Playback” and “Capture” suffixes to the
> +respective CPU and codec DAI names for playback and capture, as
> +the DAPM core links and powers these DAIs based on their naming
> +conventions.

Are you sure this is true? I could be wrong but I don't expect
the naming is critical in hooking up a c2c DAI.

> +
> +In a codec-to-codec scenario involving multiple codecs (above
> +bootup logs are for multicodec scenario), it is not feasible to
> +control individual codecs using dummy kcontrols or DAPM widgets.

I really am not sure what this means. What are we controlling
using dummy kcontrols? Why are we not using the real kcontrols
from the codec to control the codec?

> +This limitation arises because the CPU DAI is statically
> +connected to all codecs. Consequently, when a path is enabled,

Which it shouldn't be?

> +the DAPM core does not verify all the widgets that may be linked
> +to the mixer widget. It’s important to note that the mixer widget
> +serves as the trigger for these paths.
> +
> +Simple-audio-card configuration
> +----------------------------------
> +A dai_link in a "simple-audio-card" will automatically be
> +detected as codec-to-codec when all DAIs on the link belong to
> +codec components. The dai_link will be initialized with the
> +subset of stream parameters (channels, format, sample rate)
> +supported by all DAIs on the link. Since there is no way to
> +provide these parameters in the device tree, this is mostly useful
> +for communication with simple fixed-function codecs, such as a
> +Bluetooth controller or cellular modem.
> -- 
> 2.39.3 (Apple Git-146)
> 
> 

Thanks,
Charles

