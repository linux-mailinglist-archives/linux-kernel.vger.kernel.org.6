Return-Path: <linux-kernel+bounces-293458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75016957FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322A0283F27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BFB188CDA;
	Tue, 20 Aug 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1b3ShQ7"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FC149005;
	Tue, 20 Aug 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139460; cv=none; b=pnytJg+Y3BxnRYCLPu6Lm/yiTNKGQR8EMD8lCLSRm7KrADsSF8yUKR96TqKZpkUFAHlfctmeD2S1WNpKtyMXIY49I1WRLkavjSQ1eSnGqaomxOm8Nt78X10ysaSEgeCC4ljQOxQ8zIFXaNRoXvmFkq+djYT22j0WXT+6mA01Nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139460; c=relaxed/simple;
	bh=4zZ6M7Ya7uObhyci5a+8mX8MoZoL6bCmSF/ThL0R+08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW2Z9wle9sDPw4TUMVhvipoyFu+bkzI/Zusr4fY+BBPNlyPcub+KT3NViny52bKedfloYmlpZ2ZtxX/L7fq2vgbGvajuylsgF3YAkx7TXmoEa3newIPl29x1vT2uN0VdXRZdqYQTzAY8e0YMvQSePXl37pZFMCGYERW/k8YZndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1b3ShQ7; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39b32f258c8so20220405ab.1;
        Tue, 20 Aug 2024 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724139457; x=1724744257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESAgy9UsFkZjXObfHjLXJ6mFs9WzkZOFNGN0vocQLSg=;
        b=e1b3ShQ7MiOIGsFJkmqdsrCRexZlMWGB4kaoviJ0ql/eBek7zdwABsQbx2hTc/foVx
         Pf6TUX7x86g9MMiwNAXjCkFUfxcbopa6dgLzKfZz4u9N5X4gbwSNkqKX8XxE98M9EHF1
         tAdOO+bjYqn7EFqEPhHj9kP+fVUGEnZLp0cqgH6SDnSQt9prKgWyn4KJccHKlT3v0sB4
         odgXl5fbrGuk8o8OLMoM75QSGDkM1IM7Z4BzrgOkO0xl128wTcSJv0IbCHUi5nV2Clqo
         rJOiroCMys4ftwWLWgcqX8uWtSjetObcl95wf5WWm8euIBhmq09IQT9rE5NgujkrYfhH
         JzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139457; x=1724744257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESAgy9UsFkZjXObfHjLXJ6mFs9WzkZOFNGN0vocQLSg=;
        b=EEMXbqwVcnO8tEPiJScA7rsZWqWfFeFwnqwD0UKXFHmU0CMezsPKmqzT3bhNYJzmL3
         gh50PU6iuyKVLIX6GTX4c6A5lP+tysYGgjN/K7W9D1mJhlnOaJqRxrfQarGqhSvYjzR9
         TrDzqr/Qs3eWwlR4pC/oGst5AS5s0jtQ1v/glK05WNlciZh8rZAT68C0eh0SJiABOOGB
         JvsjKkCqPqevjF4JSdA5JH7SYII8ZPzgbQrfTolWDlDbutHPRUjNXu5Kpwe/T7jdw+NW
         iFf+oIp9iCID3FcdVf+07yLiEATIzYt8e3NYcBUTdyXIceJOkwWVbTlcvbO4vRQtSC+d
         5Brg==
X-Forwarded-Encrypted: i=1; AJvYcCVUI6mGomIgXpXueWfknLfqJtu0TEppMDaXU4baRJsYEHrPy/c5Hl2lsMY5T90iLol7ukCMSlkWaRQmzjI=@vger.kernel.org, AJvYcCXx7M/WALmaHEBjrJvsaoMXXSKsfGZOKgNxKNtKL9x29PjV2tJm7UW3uHBO5DQbgzhdFqiXD9eNGbHwwXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemYtxplobh2+9xv0decB2LCJ8tz1WkW1BzMkqqAnkXp0ihYrn
	zMszco37s4JjmJ1cBlPLvTfZsTpJy6yq2owLxDdFQPP7ojkYczejjiBV4+nr7fsExO+yPsIFQtm
	M66bgQMOcsvXWLzs2yeqxt8xb6Uk=
X-Google-Smtp-Source: AGHT+IF3Z75tnUCIWaHElh56/4EfY+u1ZLx/Lr/zVfzQqGwkZqc/a+ZOpnEs7iqOAwYF28bTrcvMJNXJwNSMy8sllm4=
X-Received: by 2002:a05:6e02:144b:b0:39a:16b2:7290 with SMTP id
 e9e14a558f8ab-39d56e2aaf8mr34555605ab.9.1724139457335; Tue, 20 Aug 2024
 00:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
 <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com> <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
 <CAA+D8ANDAxS42=9zOLQY_h_ihvJCmaXzE+_iZyxbSuikqt1CBw@mail.gmail.com> <ceb54a27-144b-40ed-8de5-482f2b0664a0@linux.intel.com>
In-Reply-To: <ceb54a27-144b-40ed-8de5-482f2b0664a0@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 20 Aug 2024 15:37:26 +0800
Message-ID: <CAA+D8ANqb89UavAXTiHvcHyv9uMt8_MYR9hfBaxEJDPNy5C=-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:59=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 8/20/24 04:53, Shengjiu Wang wrote:
> > On Mon, Aug 19, 2024 at 3:42=E2=80=AFPM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 8/16/24 12:42, Shengjiu Wang wrote:
> >>> Implement the ASRC memory to memory function using
> >>> the compress framework, user can use this function with
> >>> compress ioctl interface.
> >>>
> >>> Define below private metadata key value for output
> >>> format, output rate and ratio modifier configuration.
> >>> ASRC_OUTPUT_FORMAT 0x80000001
> >>> ASRC_OUTPUT_RATE   0x80000002
> >>> ASRC_RATIO_MOD     0x80000003
> >>
> >> Can the output format/rate change at run-time?
> >
> > Seldom I think.
> >
> >>
> >> If no, then these parameters should be moved somewhere else - e.g.
> >> hw_params or something.
> >
> > This means I will do some changes in compress_params.h, add
> > output format and output rate definition, follow Jaroslav's example
> > right?
>
> yes, having parameters for the PCM case would make sense.
>
> >> I am still not very clear on the expanding the SET_METADATA ioctl to
> >> deal with the ratio changes. This isn't linked to the control layer as
> >> suggested before, and there's no precedent of calling it multiple time=
s
> >> during streaming.
> >
> > Which control layer? if you means the snd_kcontrol_new?  it is bound
> > with sound card,  but in my case,  I need to the control bind with
> > the snd_compr_stream to support multi streams/instances.
>
> I can only quote Jaroslav's previous answer:
>
> "
> This argument is not valid. The controls are bound to the card, but the
> element identifiers have already iface (interface), device and subdevice
> numbers. We are using controls for PCM devices for example. The binding
> is straight.
>
> Just add SNDRV_CTL_ELEM_IFACE_COMPRESS define and specify the compress
> device number in the 'struct snd_ctl_elem_id'.
> "

I don't think it is doable,  or at least I don't know how to do it.

My case is just one card/one device/one subdevice.  can't use it to
distinguish multi streams.

>
> >> I also wonder how it was tested since tinycompress does not support th=
is?
> >
> > I wrote a unit test to test these ASRC M2M functions.
>
> This should be shared IMHO, usually when we add/extend a new interface
> it's best to have a userspace test program that can be used by others.

After Jaroslav updates the tinycompress,  I can update this example to it.

>
> >>> +static int fsl_asrc_m2m_fill_codec_caps(struct fsl_asrc *asrc,
> >>> +                                     struct snd_compr_codec_caps *co=
dec)
> >>> +{
> >>> +     struct fsl_asrc_m2m_cap cap;
> >>> +     __u32 rates[MAX_NUM_BITRATES];
> >>> +     snd_pcm_format_t k;
> >>> +     int i =3D 0, j =3D 0;
> >>> +     int ret;
> >>> +
> >>> +     ret =3D asrc->m2m_get_cap(&cap);
> >>> +     if (ret)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_5512)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
5512);
> >>
> >> this doesn't sound compatible with the patch2 definitions?
> >>
> >> cap->rate_in =3D SNDRV_PCM_RATE_8000_768000;
> >
> > This ASRC M2M driver is designed for two kinds of hw ASRC modules.
> >
> > one cap is : cap->rate_in =3D SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RA=
TE_5512;
> > another is : cap->rate_in =3D SNDRV_PCM_RATE_8000_768000;
> > they are in patch2 and patch3
> >
> >
> >>
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_8000)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
8000);
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_11025)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
11025);
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_16000)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
16000);
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_22050)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
22050);
> >>
> >> missing 24 kHz
> >
> > There is no SNDRV_PCM_RATE_24000 in ALSA.
>
> Right, but that doesn't mean 24kHz cannot be supported. We use
> constraints in those cases. see quote from Takashi found with a 2s
> Google search
>
> https://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/06935=
6.html
>
> "
> CONTINUOUS means that any rate between the specified min and max is
> fine, if no min or max is specified any rate is fine. KNOT means there
> are rates supported other than the standard rates defines by ALSA, but
> the other rates are enumerable. You'd typically specify them by
> explicitly listing them all and use a list constraint or you'd use one
> of the ratio constraints.
> "
>
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_32000)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
32000);
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_44100)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
44100);
> >>> +     if (cap.rate_in & SNDRV_PCM_RATE_48000)
> >>> +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_=
48000);
> >>
> >> missing 64kHz
> >
> > Yes, will add it.
>

