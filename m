Return-Path: <linux-kernel+bounces-380613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEAA9AF3A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFF3B21042
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494421FF04A;
	Thu, 24 Oct 2024 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iefadd3x"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338B16E89B;
	Thu, 24 Oct 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729801689; cv=none; b=juKeNqar0RWLcT+hHpvNf0gZBJg9/3GN+ud/p6tgFxGSsty9BzczqmXLQ1+GmaV9EEwzgClkNIhwJirll7XkquZWndZV9q0MOwar4QXtenTCDkvT0a1/mYLHTsLHU1rPv1RbAlF9qhUFniE6spGTnh7FxFKc51D0MNLKNeoT7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729801689; c=relaxed/simple;
	bh=1zRaAal0Ub4ybSuelZJSs/qUFr2JAzBYrN5IrU31+V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9IvPzySiU1S75yZdMitDj8Pmv6UllpnH3oY/HjtnKNzk2gH2eTbw0aipWubM/dtXCJPm3Q+cDvE8pdwTnLU+yW2Xx4hyA/YcxCbll1Uszl8HXgdcfZR2JlpBRYyg1qb1GgIjr6Y7HlfnmjYoCTWwk2efhpLg4GXOTNiZtGNcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iefadd3x; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so13939271fa.1;
        Thu, 24 Oct 2024 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729801683; x=1730406483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ7DddYGZGbGahshFE0UpL4VbfpgyCVVDIbKx6PjMk8=;
        b=Iefadd3xeHpik8zqW+pa4ZUW3+fEnA0ZJKR4xtzZyQbiik4Oy5+mdNFyiRKMgfc1xv
         plgBj+FY4NT55KVLwPR+NDcofsTDpuwAZUt8G61kZoAW8CzhJThiPvPKftoKTTW9xTfu
         j0vzG9ynOpsSt28Xg1ztmYNoeykOCFfAcmt0XIUpAFjRHxLefO8KtblnZVpNJWTgVlGt
         iFCNSqZE0KXuPutJyeP9mjyBbHQT9bi9GE1kN0TmLQNDGnVvcFJt6HhGeRMCHz2gFWY9
         hzY/jZDNn9J5hoaNP99fBTCrG+q7TpnkaY0wP3PQqlQSx0O/ud4do8LoHy2flZEx6E3v
         /8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729801683; x=1730406483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ7DddYGZGbGahshFE0UpL4VbfpgyCVVDIbKx6PjMk8=;
        b=PCS1tUOl3GNYbcfaCYn+rlNdZMxYTE34/KPEt+mgLEaT2jueovA1TkFCTIq3AgFnZU
         6YuST8ApMg4GhVZzAj/PcNS1huNSevYXJpXaxCrYm1+FpgFURQVdH6NWtU3TUCwTrXi4
         rU9UplVqiEVoSm50iNqQuC4hmmg9u6MIE83um7UegoDLJ0Tt//jN0lLjPqqylFeYi+/H
         3ByKjlHZ4EPWuDjhJ0vUxRjkTRWubT4u5UEQsO5VuQCwoPapNEXj7OyJtXboN41/W0s+
         EqHoaYCckanKserjMyv7+Mv9OAcRnt5aqEuAHkZEd0y8hzcxI5VrdHZQ04ARg1VVQw8T
         tByg==
X-Forwarded-Encrypted: i=1; AJvYcCVAUSYEbp63aJMDiT05v8lY0+THCBE/PaVRsoTZOWXjnYLUYhMi4O02lAfjTDjsAtZBn7UZitEFjMSIeiGl@vger.kernel.org, AJvYcCVbJ2vplQYwgOyxn+4Q9jZ1VqtX1YSmxsvZ8WLVgRWKqKKQWgFCvtQn04vuvzIa2h/ohZnFXVVl+Yk=@vger.kernel.org, AJvYcCX3fQVKYl/sI5w0WGzbALhmUpBP6WPgE87f/tO5nedkruf7yr2LBGjcMAgBp2WqdOKmEEJYwytDu3ezMsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB/dTDr5CPzdR2JrOnIzOihchw1gNc6LBl+BF/Rw8RXgNEUT0
	jeNedH/1eBjO94mtODeyn60BO+JXC/uIg/fwsqv8jUon4JxPqsV2TxfS9vz0Acid13pnIyYmdwR
	VIyFcTyyaoNRIBPnbm/ee/52wca8=
X-Google-Smtp-Source: AGHT+IE9Wbs5CHWJgS8ATfaSV+s5mL0Ex10E0OCYwbXcDLGTkipv+vRmFzaGfAEY47GobWEzWVab0LRqbtUK+c3V4q4=
X-Received: by 2002:a2e:a9a4:0:b0:2fa:c46a:eb4e with SMTP id
 38308e7fff4ca-2fc9d2ddc2fmr44587201fa.3.1729801683148; Thu, 24 Oct 2024
 13:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020163706.87123-1-yesanishhere@gmail.com> <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
In-Reply-To: <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 24 Oct 2024 13:27:51 -0700
Message-ID: <CABCoZhDQCYwReG2q9pGNPaLaOxd2OjjQ8j14QgujTFDNmG1Seg@mail.gmail.com>
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:10=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Sun, Oct 20, 2024 at 09:37:06AM -0700, anish kumar wrote:
> > Updated documentation to provide more details
> > for codec-to-codec connection.
> >
> > Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > ---
>
> The patch doesn't seem to apply cleanly for me, my system doesn't
> seem to like:
>
> Content-Type: text/plain; charset=3D"y"
>
> Not sure if that is a problem on my end or yours, but I am not
> familiar with that encoding.
>
> > v2: Fixed the compilation error reported by Sphinx
> >  Documentation/sound/soc/codec-to-codec.rst | 296 +++++++++++++--------
> >  1 file changed, 190 insertions(+), 106 deletions(-)
> >
> > diff --git a/Documentation/sound/soc/codec-to-codec.rst b/Documentation=
/sound/soc/codec-to-codec.rst
> > index 0418521b6e03..9d65fc74856a 100644
> > --- a/Documentation/sound/soc/codec-to-codec.rst
> > +++ b/Documentation/sound/soc/codec-to-codec.rst
> > @@ -1,115 +1,199 @@
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -Creating codec to codec dai link for ALSA dapm
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Codec-to-Codec Connections in ALSA
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -Mostly the flow of audio is always from CPU to codec so your system
> > -will look as below:
> > -::
> > +An ALSA-based audio system typically involves playback and capture
> > +functionalities, where users may require audio file playback through
>
> functionality would probably parse slightly better.
>
> > +speakers or recording from microphones. However, certain systems
> > +necessitate audio data routing directly between components, such as FM
> > +radio to speakers, without CPU involvement. For such scenarios, ALSA
>
> It would probably be more accurate to say "ASoC provides", I mean
> I guess ASoC is a part of ALSA but this is definitely an ASoC
> level feature.
>
> > +provides a mechanism known as codec-to-codec connections, leveraging
> > +the Dynamic Audio Power Management (DAPM) framework to facilitate
> > +direct data transfers between codecs.
> >
> > -   ---------          ---------
> > -  |         |  dai   |         |
> > -      CPU    ------->    codec
> > -  |         |        |         |
> > -   ---------          ---------
> > +Introduction
> > +------------
> >
> > -In case your system looks as below:
> > -::
> > +In most audio systems, audio data flows from the CPU to the codec. In
> > +specific configurations, such as those involving Bluetooth codecs,
> > +audio can be transmitted directly between codecs without CPU
> > +intervention. ALSA supports both architectures, and for systems that
> > +do not involve the CPU, it utilizes codec-to-codec digital audio
> > +interface (DAI) connections. This document discusses the procedure
> > +for establishing codec-to-codec DAI links to enable such
> > +functionalities.
> >
> > +Audio Data Flow Paths
> > +----------------------
> > +
> > +In a typical configuration, audio flow can be visualized as follows:
> > +
> > +.. code-block:: text
> > +
> > +    ---------          ---------
> > +   |         |  dai   |         |
> > +       CPU    ------->    codec
> > +   |         |        |         |
> > +    ---------          ---------
> > +
> > +In more intricate setups, the system may not involve the CPU but
> > +instead utilizes multiple codecs as shown below. For instance,
> > +Codec-2 acts as a cellular modem, while Codec-3 connects to a
> > +speaker. Audio data can be received by Codec-2 and transmitted to
> > +Codec-3 without CPU intervention, demonstrating the ideal conditions
> > +for establishing a codec-to-codec DAI connection.
> > +
> > +.. code-block:: text
> > +
> > +                        ---------
> > +                       |         |
> > +                         codec-1 <---cellular modem
> > +                       |         |
> >                         ---------
> > -                      |         |
> > -                        codec-2
> > -                      |         |
> > -                      ---------
> > -                           |
> > -                         dai-2
> > -                           |
> > -   ----------          ---------
> > -  |          |  dai-1 |         |
> > -      CPU     ------->  codec-1
> > -  |          |        |         |
> > -   ----------          ---------
> > -                           |
> > -                         dai-3
> > -                           |
> > -                       ---------
> > -                      |         |
> > -                        codec-3
> > -                      |         |
> > +                            |
> > +                          dai-1
> > +                            =E2=86=93
> > +    ----------          ---------
> > +   |          |cpu_dai |         |
> > +    dummy CPU  ------->  codec-2
>
> Bringing the "dummy" into this is quite misleading, that really
> relates to DPCM setups. DPCM lets one select any number of back
> ends to service a given front end PCM, and often are abused to
> achieve things that should really be implemented as C2C links.

Aha, understood. For C2C we need a thin dummy codec driver
which acts as a cpu driver in the ASoC code right?

Based on the code from bells.c, below is the C2C and we do provide
a CPU driver, even though in actual it is a codec driver.

SND_SOC_DAILINK_DEFS(wm2200_dsp_codec,
DAILINK_COMP_ARRAY(COMP_CPU("wm0010-sdi2")),
DAILINK_COMP_ARRAY(COMP_CODEC("wm2200.1-003a", "wm2200")));

Perhaps, I can just remove the "dummy" from the diagram above.

>
> > +   |          |        |         |
> > +    ----------          ---------
> > +                            |
> > +                          dai-3
> > +                            =E2=86=93
> > +                        ---------
> > +                       |         |
> > +                         codec-3 ---->speaker
> > +                       |         |
> >                         ---------
> >
> > -Suppose codec-2 is a bluetooth chip and codec-3 is connected to
> > -a speaker and you have a below scenario:
> > -codec-2 will receive the audio data and the user wants to play that
> > -audio through codec-3 without involving the CPU.This
> > -aforementioned case is the ideal case when codec to codec
> > -connection should be used.
> > -
> > -Your dai_link should appear as below in your machine
> > -file:
> > -::
> > -
> > - /*
> > -  * this pcm stream only supports 24 bit, 2 channel and
> > -  * 48k sampling rate.
> > -  */
> > - static const struct snd_soc_pcm_stream dsp_codec_params =3D {
> > -        .formats =3D SNDRV_PCM_FMTBIT_S24_LE,
> > -        .rate_min =3D 48000,
> > -        .rate_max =3D 48000,
> > -        .channels_min =3D 2,
> > -        .channels_max =3D 2,
> > - };
> > -
> > - {
> > -    .name =3D "CPU-DSP",
> > -    .stream_name =3D "CPU-DSP",
> > -    .cpu_dai_name =3D "samsung-i2s.0",
> > -    .codec_name =3D "codec-2,
> > -    .codec_dai_name =3D "codec-2-dai_name",
> > -    .platform_name =3D "samsung-i2s.0",
> > -    .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> > -            | SND_SOC_DAIFMT_CBM_CFM,
> > -    .ignore_suspend =3D 1,
> > -    .c2c_params =3D &dsp_codec_params,
> > -    .num_c2c_params =3D 1,
> > - },
> > - {
> > -    .name =3D "DSP-CODEC",
> > -    .stream_name =3D "DSP-CODEC",
> > -    .cpu_dai_name =3D "wm0010-sdi2",
> > -    .codec_name =3D "codec-3,
> > -    .codec_dai_name =3D "codec-3-dai_name",
> > -    .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> > -            | SND_SOC_DAIFMT_CBM_CFM,
> > -    .ignore_suspend =3D 1,
> > -    .c2c_params =3D &dsp_codec_params,
> > -    .num_c2c_params =3D 1,
> > - },
> > -
> > -Above code snippet is motivated from sound/soc/samsung/speyside.c.
> > -
> > -Note the "c2c_params" callback which lets the dapm know that this
> > -dai_link is a codec to codec connection.
> > -
> > -In dapm core a route is created between cpu_dai playback widget
> > -and codec_dai capture widget for playback path and vice-versa is
> > -true for capture path. In order for this aforementioned route to get
> > -triggered, DAPM needs to find a valid endpoint which could be either
> > -a sink or source widget corresponding to playback and capture path
> > +Creating Codec-to-Codec Connections in ALSA
> > +----------------------------------------------
> > +
> > +To create a codec-to-codec DAI in ALSA, a ``snd_soc_dai_link`` must be
> > +added to the machine driver before registering the sound card.
> > +During this registration, the core checks for the presence of
> > +``c2c_params`` within the ``snd_soc_dai_link``, determining whether
> > +to classify the DAI link as codec-to-codec.
> > +
> > +While establishing the PCM node, the ALSA core inspects this
> > +parameter. Instead of generating a user-space PCM node, it creates
> > +an internal PCM node utilized by kernel drivers. Consequently,
>
> I am not sure I like the description of this as an internal PCM
> node, I guess in some ways the core does use the same structures
> it would for a PCM node, but it isn't really a PCM node. I
> do like that you have added the additional note this will not be
> visible through procfs though.

thanks.
>
> > +running ``cat /proc/asound/pcm`` will yield no visible PCM nodes.
> > +
> > +After this setup, the ALSA core invokes the DAPM core to connect a
>
> Again really ASoC core here.
>
> > +single ``cpu_dai`` with both ``codec_dais``. Boot-up logs will
> > +display messages similar to:
>
> That is definitely not what should be happening with a C2C link.
> In the system you showed the diagram for above there should be a
> connection between the CPU and codec-2, then two separate links
> between codec-2 and codecs 1 and 3. No links should be present
> between the CPU and codecs 1 or 3.

Got it, I will try to convey the same in the diagram but ascii art is hard =
:)

Can you help clarify my understanding (based on the dapm code walkthrough),
when the mixer control is triggered, the CPU widgets gets triggered
thereby triggering codec2 widgets and as there is a static connection
between codec1 and codec2 it gets also triggered and the same thing
happens to codec3 as it is also linked to codec2?

Also, as the widgets are linked to dai ops, all the ops gets triggered as w=
ell.

>
> > +
> > +.. code-block:: bash
> > +
> > +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> > +   multicodec <-> cpu_dai mapping ok
> > +   connected DAI link Dummy-CPU:cpu_dai -> codec-1:dai_1
> > +   connected DAI link Dummy-CPU:cpu_dai -> codec-2:dai_2
> > +
>
> Yeah this is definitely mixing in a fair amount of DPCM stuff and
> does not match the rest of the description.

I guess what you meant is that C2C doesn't care about the above
connection as it uses DAPM widget connection to trigger the path
right? So, even if this connection doesn't exist C2C will still work.

Reason why I am asking is that I saw the above logs when I
added a C2C connection.

>
> > +To trigger this DAI link, a control interface is established by the
> > +DAPM core during internal DAI creation. This interface links to
> > +the ``snd_soc_dai_link_event`` function, which is invoked when a
> > +path connects in the DAPM core. A mixer must be created to trigger
> > +the connection, prompting the DAPM core to evaluate path
> > +connections and call the ``snd_soc_dai_link_event`` callback with
> > +relevant events.
> > +
> > +It is important to note that not all operations defined in
> > +``snd_soc_dai_ops`` are invoked as codec-to-codec connections offer
> > +limited control over DAI configuration. For greater control, a
> > +hostless configuration is recommended. The operations typically
>
> It is not clear to me what a "hostless configuration" is here.

What I meant to convey is, if the user wants all pcm ops to get called in
order then he can use "Hostless FE" and connect to backend use as a normal =
PCM.

>
> > +executed in codec-to-codec setups include startup, ``hw_params``,
> > +``hw_free``, digital mute, and shutdown from the
> > +``snd_soc_dai_ops`` structure.
> > +
> > +Code Changes for Codec-to-Codec
> > +----------------------------------
> > +
> > +The DAI link configuration in the machine file should resemble the
> > +following code snippet:
> > +
> > +.. code-block:: c
> > +
> > +   /*
> > +    * This PCM stream only supports 24-bit, 2 channels, and
> > +    * 48kHz sampling rate.
> > +    */
> > +   static const struct snd_soc_pcm_stream dsp_codec_params =3D {
> > +       .formats =3D SNDRV_PCM_FMTBIT_S24_LE,
> > +       .rate_min =3D 48000,
> > +       .rate_max =3D 48000,
> > +       .channels_min =3D 2,
> > +       .channels_max =3D 2,
> > +   };
> > +
> > +   static struct snd_soc_dai_link dai_links[] =3D {
> > +   {
> > +       .name =3D "CPU-DSP",
> > +       .stream_name =3D "CPU-DSP",
> > +       .cpu_dai_name =3D "samsung-i2s.0",
> > +       .codec_name =3D "codec-2",
> > +       .codec_dai_name =3D "codec-2-dai_name",
> > +       .platform_name =3D "samsung-i2s.0",
> > +       .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> > +                  | SND_SOC_DAIFMT_CBM_CFM,
> > +       .ignore_suspend =3D 1,
> > +       .c2c_params =3D &dsp_codec_params,
> > +       .num_c2c_params =3D 1,
> > +   },
> > +   {
> > +       .name =3D "DSP-CODEC",
> > +       .stream_name =3D "DSP-CODEC",
> > +       .cpu_dai_name =3D "wm0010-sdi2",
> > +       .codec_name =3D "codec-3",
> > +       .codec_dai_name =3D "codec-3-dai_name",
> > +       .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> > +                  | SND_SOC_DAIFMT_CBM_CFM,
> > +       .ignore_suspend =3D 1,
> > +       .c2c_params =3D &dsp_codec_params,
> > +       .num_c2c_params =3D 1,
> > +   },
> > +   };
> > +
> > +This snippet draws inspiration from the configuration found in
> > +``sound/soc/samsung/speyside.c``. The inclusion of the
> > +``c2c_params`` indicates to the DAPM core that the DAI link is a
> > +codec-to-codec connection.
> > +
> > +In the DAPM core, a route is established between the CPU DAI
> > +playback widget and the codec DAI capture widget for playback, with
> > +the reverse applying to the capture path. To trigger these routes,
> > +DAPM requires valid endpoints, which can be either sink or source
> > +widgets corresponding to the playback and capture paths,
> >  respectively.
> >
> > -In order to trigger this dai_link widget, a thin codec driver for
> > -the speaker amp can be created as demonstrated in wm8727.c file, it
> > -sets appropriate constraints for the device even if it needs no contro=
l.
> > -
> > -Make sure to name your corresponding cpu and codec playback and captur=
e
> > -dai names ending with "Playback" and "Capture" respectively as dapm co=
re
> > -will link and power those dais based on the name.
> > -
> > -A dai_link in a "simple-audio-card" will automatically be detected as
> > -codec to codec when all DAIs on the link belong to codec components.
> > -The dai_link will be initialized with the subset of stream parameters
> > -(channels, format, sample rate) supported by all DAIs on the link. Sin=
ce
> > -there is no way to provide these parameters in the device tree, this i=
s
> > -mostly useful for communication with simple fixed-function codecs, suc=
h
> > -as a Bluetooth controller or cellular modem.
> > +To activate this DAI link widget, a lightweight codec driver for
> > +the speaker amplifier can be implemented, following a similar
> > +strategy to that in ``wm8727.c``. This driver should set the
> > +necessary constraints for the device, even with minimal control
> > +requirements.
>
> Would actually be nice to include the note that any codec driver
> should be fine, the original text does kinda give the impression
> one would have to write a "thin codec driver" but if you already
> have a driver thin or otherwise that would be fine. Perhaps
> better to rephrase as a codec driver being required.

ok
>
> > +
> > +It's crucial to append =E2=80=9CPlayback=E2=80=9D and =E2=80=9CCapture=
=E2=80=9D suffixes to the
> > +respective CPU and codec DAI names for playback and capture, as
> > +the DAPM core links and powers these DAIs based on their naming
> > +conventions.
>
> Are you sure this is true? I could be wrong but I don't expect
> the naming is critical in hooking up a c2c DAI.

tested this on my board and you are right. Will remove this.

>
> > +
> > +In a codec-to-codec scenario involving multiple codecs (above
> > +bootup logs are for multicodec scenario), it is not feasible to
> > +control individual codecs using dummy kcontrols or DAPM widgets.
>
> I really am not sure what this means. What are we controlling
> using dummy kcontrols? Why are we not using the real kcontrols
> from the codec to control the codec?

Our system includes a DSP that can generate audio(not audio to be
honest but can be considered as a audio channel) independently,
without CPU involvement. This audio needs to be sent to speakers
via codecs, even when playback isn't occurring.

We modeled all codecs as a C2C having one single snd_soc_dai_link
with multiple codecs. So, now we can control all codecs using mixer
control which we created as a part of C2C path completion.

However, we got a new usecase where we shouldn't turn on all the
codecs when mixer control is used for C2C, instead user should be able
to specify which codec should get turned on.

So, I attempted to add one more dummy mixer as part of C2C mixer
path, follishly thinking that if the dummy mixer is not enabled, C2C
won't allow the corresponding codec to get turned on. After reading
the code, I saw that in C2C implementation it doesn't check for
widget power status when turning on the path and nor check if the
path is complete or not before calling the pcm ops.

This is what I am listing as a drawback but I guess I can remove
that as it is by design because we can probably have multiple
snd_soc_dai_link C2C and then we can control them individually.

>
> > +This limitation arises because the CPU DAI is statically
> > +connected to all codecs. Consequently, when a path is enabled,
>
> Which it shouldn't be?
>
> > +the DAPM core does not verify all the widgets that may be linked
> > +to the mixer widget. It=E2=80=99s important to note that the mixer wid=
get
> > +serves as the trigger for these paths.
> > +
> > +Simple-audio-card configuration
> > +----------------------------------
> > +A dai_link in a "simple-audio-card" will automatically be
> > +detected as codec-to-codec when all DAIs on the link belong to
> > +codec components. The dai_link will be initialized with the
> > +subset of stream parameters (channels, format, sample rate)
> > +supported by all DAIs on the link. Since there is no way to
> > +provide these parameters in the device tree, this is mostly useful
> > +for communication with simple fixed-function codecs, such as a
> > +Bluetooth controller or cellular modem.
> > --
> > 2.39.3 (Apple Git-146)
> >
> >
>
> Thanks,
> Charles

