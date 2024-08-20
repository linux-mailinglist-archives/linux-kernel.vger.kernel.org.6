Return-Path: <linux-kernel+bounces-293176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99B957BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B16DB22E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78442A99;
	Tue, 20 Aug 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esl8aNOw"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21914175A6;
	Tue, 20 Aug 2024 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122403; cv=none; b=SKjMyCiI3taSYTXVvMTT7QVDiMDLa6VsA9rw+o1oSoD+hc3mr5H8Ac98RjzFvkfM8E47s6N1hUj0bSIpnEWG1EylhDRFMVx5qiq37VZTcNaHRIzhIvkhlzojlnFbvGGP51EzLGpRXy6oh3WoiOcgMWKNZvQjZuVlHEpXkadS3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122403; c=relaxed/simple;
	bh=nG26NZ3S/KuNQ2SHcuxORshAwbQgT5QZdIv23N6ZCqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEXrynw7GopujN4xcwekAwBit7C9AKZBaKFGJnJjHlExOcQMRuvQVqL1QttfDk5hrjh+fXgZ+JQJzK/SzFdN5YAHEROXHLbns/vvLMHiy5qUQS54RWfWVsV1lWKYYqsvN1uZ/CEcskkV8KNk9c+zLAWwjviY6KHyaZmLRWt0O/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esl8aNOw; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d3cd4fa49so7023375ab.1;
        Mon, 19 Aug 2024 19:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724122401; x=1724727201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT6vSqFxRxEeg2TyE8vAmieBZnT3qlYo8e/6USKHH/E=;
        b=esl8aNOwrM9/pGSUK3mT/ImiWMOiKHes5qBFF72189Jvea5obBuc5y9FwLKywxtsm1
         k86UNLuHMEqAOXQ6vlL4FSqiEnCDpgtfyMOphrIA67pXKkscnwmmOUyQJIVvbVn7OnqW
         p039d4Iw3qqUHDIimRmTayuOjyoVBzrpq/k48epoZTzT5DBFm8vovQlaRMFlNyvT+RtJ
         LQVEtSkO2ZHjNX7igCYI7pnH+QAIC/ZI58I1k3AKvted9RlirRjpsPwRJMDyy12z81g+
         JDV793Gm4Jzj3HmGMzR/HpqAHXRNrsaz2MmZ9ShP3i4Nhv/z4536R5AQWY/VnBjt/cUG
         8c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724122401; x=1724727201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fT6vSqFxRxEeg2TyE8vAmieBZnT3qlYo8e/6USKHH/E=;
        b=uWUtjTkGf69loTx5zBn43IGJ+Q/dZogyJoQjFDUL5C+Z8HaxJj2tE7vGQuPuATtt+C
         MUPU86L1J/eLegRy9TfiIiA7ZCScEC3RAviyD6G7/1uqAz6yPsxgalF/7B/mG8vEwKUa
         loIRcdSy3IXZ7J7wl5ZY/sDDHsdJzOzk40MpvQYTxix0xIcf8aZ7KzORIey4NfbKfdYz
         T0Xphj3jJfv+0OfgxSwRceR4bxy39a01u4Z8PCJ7kjcnEaqAFYDpHzyZeSdQXBJSxxWf
         59ejV+VyefzrK+9kKc87B4YGrM2pxYGNt2mb0eseBqZpCOEhVX0V4+7cuCakfZA7kPeH
         MNpA==
X-Forwarded-Encrypted: i=1; AJvYcCVEi1OzzzSGdGeAVQc0NsUfXjVNShlftsMeq+jVtCccuiXAzToFJDrB4+YUrEKu5s1fxawCkNCKbc5jCjE=@vger.kernel.org, AJvYcCWMFwHpiDvQeQmL261cifx/FzHbl+HHpOigokys+MZ14BBIrdUGgTSMeyK79+52uApIsWCveA3wVJYPqpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDsNsyIMd2wiCZmCql+ch8aMmrcZtJxC+Q9jSjb5Lym03wGam6
	XaV1OL1/xGLcfYIQUaFRD1ztEoln0984qZsEYqq/NmkSQDDrRZUFwjctqu89azL7waz7K8iYztx
	lhA7jfV8PF9Y9mOm2c1FbUCGLGlw=
X-Google-Smtp-Source: AGHT+IGl4gRPN5RAOxKXugMK43Dh6VHASCDS5Twf9YsdPNqPWrRzvf3PhVgc7lqQMpYhRDm7MWOvnuVY3lUtLNY/Lo4=
X-Received: by 2002:a05:6e02:20cb:b0:39d:4d2d:d0de with SMTP id
 e9e14a558f8ab-39d56dd773emr21812545ab.3.1724122401038; Mon, 19 Aug 2024
 19:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
 <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com> <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
In-Reply-To: <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 20 Aug 2024 10:53:10 +0800
Message-ID: <CAA+D8ANDAxS42=9zOLQY_h_ihvJCmaXzE+_iZyxbSuikqt1CBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:42=E2=80=AFPM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 8/16/24 12:42, Shengjiu Wang wrote:
> > Implement the ASRC memory to memory function using
> > the compress framework, user can use this function with
> > compress ioctl interface.
> >
> > Define below private metadata key value for output
> > format, output rate and ratio modifier configuration.
> > ASRC_OUTPUT_FORMAT 0x80000001
> > ASRC_OUTPUT_RATE   0x80000002
> > ASRC_RATIO_MOD     0x80000003
>
> Can the output format/rate change at run-time?

Seldom I think.

>
> If no, then these parameters should be moved somewhere else - e.g.
> hw_params or something.

This means I will do some changes in compress_params.h, add
output format and output rate definition, follow Jaroslav's example
right?


>
> I am still not very clear on the expanding the SET_METADATA ioctl to
> deal with the ratio changes. This isn't linked to the control layer as
> suggested before, and there's no precedent of calling it multiple times
> during streaming.

Which control layer? if you means the snd_kcontrol_new?  it is bound
with sound card,  but in my case,  I need to the control bind with
the snd_compr_stream to support multi streams/instances.

>
> I also wonder how it was tested since tinycompress does not support this?

I wrote a unit test to test these ASRC M2M functions.

>
>
> > +static int fsl_asrc_m2m_fill_codec_caps(struct fsl_asrc *asrc,
> > +                                     struct snd_compr_codec_caps *code=
c)
> > +{
> > +     struct fsl_asrc_m2m_cap cap;
> > +     __u32 rates[MAX_NUM_BITRATES];
> > +     snd_pcm_format_t k;
> > +     int i =3D 0, j =3D 0;
> > +     int ret;
> > +
> > +     ret =3D asrc->m2m_get_cap(&cap);
> > +     if (ret)
> > +             return -EINVAL;
> > +
> > +     if (cap.rate_in & SNDRV_PCM_RATE_5512)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_55=
12);
>
> this doesn't sound compatible with the patch2 definitions?
>
> cap->rate_in =3D SNDRV_PCM_RATE_8000_768000;

This ASRC M2M driver is designed for two kinds of hw ASRC modules.

one cap is : cap->rate_in =3D SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_5=
512;
another is : cap->rate_in =3D SNDRV_PCM_RATE_8000_768000;
they are in patch2 and patch3


>
> > +     if (cap.rate_in & SNDRV_PCM_RATE_8000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_80=
00);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_11025)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_11=
025);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_16000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_16=
000);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_22050)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_22=
050);
>
> missing 24 kHz

There is no SNDRV_PCM_RATE_24000 in ALSA.

>
> > +     if (cap.rate_in & SNDRV_PCM_RATE_32000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_32=
000);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_44100)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_44=
100);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_48000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_48=
000);
>
> missing 64kHz

Yes, will add it.

Best regards
Shengjiu Wang

>
> > +     if (cap.rate_in & SNDRV_PCM_RATE_88200)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_88=
200);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_96000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_96=
000);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_176400)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_17=
6400);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_192000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_19=
2000);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_352800)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_35=
2800);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_384000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_38=
4000);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_705600)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_70=
5600);
> > +     if (cap.rate_in & SNDRV_PCM_RATE_768000)
> > +             rates[i++] =3D snd_pcm_rate_bit_to_rate(SNDRV_PCM_RATE_76=
8000);
> > +
> > +     pcm_for_each_format(k) {
> > +             if (pcm_format_to_bits(k) & cap.fmt_in) {
> > +                     codec->descriptor[j].max_ch =3D cap.chan_max;
> > +                     memcpy(codec->descriptor[j].sample_rates, rates, =
i * sizeof(__u32));
> > +                     codec->descriptor[j].num_sample_rates =3D i;
> > +                     codec->descriptor[j].formats =3D k;
> > +                     j++;
> > +             }
> > +     }
> > +
> > +     codec->codec =3D SND_AUDIOCODEC_PCM;
> > +     codec->num_descriptors =3D j;
> > +     return 0;
>
>

