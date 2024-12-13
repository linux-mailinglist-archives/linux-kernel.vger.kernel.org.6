Return-Path: <linux-kernel+bounces-444366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74139F05B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F7018873C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B025192D9D;
	Fri, 13 Dec 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkDRKHUJ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB351F95E;
	Fri, 13 Dec 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075961; cv=none; b=LD2RWWyQTEq5EpTIWHnauYQ+DPAfjW/bkoHZC6zV2xXaSCRJfRrZMF4x/ssoyX3YO1V2i7vEXhfbopYzsBf6HsHf4vL0w6Ic7dDa1HiUDZN+AnkPlLeWB8i70zzijoTNhZDqRXVARwQAqEl02f2l5yXraDUdmM/+WX9CW05C6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075961; c=relaxed/simple;
	bh=rRjQS4jUL/JtWYebcDUqXrzPaB5dEzGbEPQpMDmOxAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk8u/U9iyGjuTeAbA/8SyEG8DnV50Qz9vKk4fgiN2FEcQicRN3d4LVyKMkCM8/0Aa/U08cgtRUBjeLpzEWb085vIp2fq2q5p+gSl7/PipO04t+41fyBMcCH3sG8vWH7XIChi5XoxohfJ7OWll58bDhbiI86fpQf5dhs8TiVcV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkDRKHUJ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a7deec316aso5319505ab.1;
        Thu, 12 Dec 2024 23:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734075959; x=1734680759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYYkz5wo0agid+Six8DIqpuAadZaRu0O1Lrum3LM5+Y=;
        b=YkDRKHUJHzwAIYKk6+ib25vD2fXUUCKtH06Tdjgs6q2f9SHWVsTimY/nE30k0qs16O
         +0UetSfHkFXMOgoEphqb1v5Uu41XB5st8MyGj0Fvz7KWmlMBU+/PciCxFidaHgjuP+/0
         YBiRUWF5hXJWlrW9PmNs7OYVzByxGkJu06hYdEpqm6TH9uFHq+9Chuyjp+0OAlNGjWE0
         iXDnmnYEjqkJn90FyunHlpT5SIOGxmWeUJUXblyuNJwPVZ4/vN+879EWtIQk+8ExNUOW
         0d0jKkAi8p6Jl6yMkHO0PmDBC4Hl6XilIUmmyUV9uvK/x8tPcGliB+9EUrswLUI+cyv6
         JtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734075959; x=1734680759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYYkz5wo0agid+Six8DIqpuAadZaRu0O1Lrum3LM5+Y=;
        b=kGMH12Ovp/2flK3Bv0/k70+AlrgJ1PMT/yLHQP2W76NIZzneAfmj7d0Hj7n8n63K+a
         n+h1RjynEUrp74PLpGGfdkbP7QtoE+1dE+nvFuv++4CMD4WKNpAbW6M+QRe2nC5r/SNj
         rH6hfyHuRAqfJkZpGBET91wddW+c5KbXy5abP9mOqAyn2tMalwITl2Ltqof2ZdBwPk4n
         vhJBqcWCu5Ss3i2Mplrk4Wk67p/3bEbycEqRhixXOxf8LGGPIeKS6ZJHyugiRMThlBI4
         UD7H0bxS5ZxqgoVxxrnwxX32k4nw8IhlR7w2D3sBLjYU4HZXxFkQ6OwdnetSaoZWEL4I
         xu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC9iVVZvM3IU4l5NnlGS94FhV4e/TvVjHq7wjG+39U9EWIJh6sCLO1EkxfzPgLYmM7DCp2naGvjVU7ra0=@vger.kernel.org, AJvYcCXzqwmFfYARNXEWnQ/VXuIWRUVqMWpPZ+dXrt4iyb133EER6ew7wu3ZEhOeisZxKNItWZtmxDMf3q8tF4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wuQeaclPpNvGuKDy8fZdIR4ROdS5tPC+03Q6YBIfPUvQKGhu
	zLRCACDotoAtws68eeTh2i71zIN8C5glthY4kY3p/AUYfjRb06dSAC407DFM7+gvWgMBcCJZWqQ
	pfm29xop6Jrkq3UWRlBIqaEe50Oo=
X-Gm-Gg: ASbGncsaFAKp1+g8qoa5Bipt+rCIJTqkeNjZYrw+UMzqbBntUdLKbJ35LKAmt7r/W+H
	Ef+lGWT4AJOF0YKT/BzrVrvATtg/o42krX0mUFw==
X-Google-Smtp-Source: AGHT+IEZp59bOt9C+xTIkk05sua6DTUcqnvF1/4kOUynOScRvwUkj4Pb9JtHkrWiwmRLpAQs8Kn/IRepKMWS2L8ZLWk=
X-Received: by 2002:a05:6e02:168b:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3aff8c91543mr15440795ab.21.1734075958652; Thu, 12 Dec 2024
 23:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212074509.3445859-1-shengjiu.wang@nxp.com>
 <20241212074509.3445859-5-shengjiu.wang@nxp.com> <58b4a167-5a13-49b2-9b08-58c3041b772b@sirena.org.uk>
In-Reply-To: <58b4a167-5a13-49b2-9b08-58c3041b772b@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 13 Dec 2024 15:45:46 +0800
Message-ID: <CAA+D8AMKLFJx3Z03rLthaH-7_tAmb8c1c4wCSOee-t5uxZg2oA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:45=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Dec 12, 2024 at 03:45:07PM +0800, Shengjiu Wang wrote:
> > Implement the ASRC memory to memory function using
> > the compress framework, user can use this function with
> > compress ioctl interface.
> >
> > This feature can be shared by ASRC and EASRC drivers
>
> This breaks an x86 allmodconfig build (using GCC 13):
>
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:186:68: warning: =E2=80=
=98struct snd_compr_task_runtime=E2=80=99 declared inside parameter list wi=
ll not be visible outside of this definition or declaration
>   186 | static void asrc_m2m_device_run(struct fsl_asrc_pair *pair, struc=
t snd_compr_task_runtime *task)
>       |                                                                  =
  ^~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98asr=
c_m2m_device_run=E2=80=99:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:212:26: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   212 |         in_buf_len =3D task->input_size;
>       |                          ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:279:13: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   279 |         task->output_size =3D out_dma_len;
>       |             ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:451:49: warning: =E2=80=
=98struct snd_compr_task_runtime=E2=80=99 declared inside parameter list wi=
ll not be visible outside of this definition or declaration
>   451 |                                          struct snd_compr_task_ru=
ntime *task)
>       |                                                 ^~~~~~~~~~~~~~~~~=
~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl=
_asrc_m2m_comp_task_create=E2=80=99:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:465:13: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   465 |         task->input =3D dma_buf_export(&exp_info_in);
>       |             ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:466:24: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   466 |         if (IS_ERR(task->input)) {
>       |                        ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:467:35: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   467 |                 ret =3D PTR_ERR(task->input);
>       |                                   ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:475:13: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   475 |         task->output =3D dma_buf_export(&exp_info_out);
>       |             ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:476:24: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   476 |         if (IS_ERR(task->output)) {
>       |                        ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:477:35: error: invalid us=
e of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
>   477 |                 ret =3D PTR_ERR(task->output);
>       |                                   ^~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:523:48: warning: =E2=80=
=98struct snd_compr_task_runtime=E2=80=99 declared inside parameter list wi=
ll not be visible outside of this definition or declaration
>   523 |                                         struct snd_compr_task_run=
time *task)
>       |                                                ^~~~~~~~~~~~~~~~~~=
~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl=
_asrc_m2m_comp_task_start=E2=80=99:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:528:35: error: passing ar=
gument 2 of =E2=80=98asrc_m2m_device_run=E2=80=99 from incompatible pointer=
 type [-Werror=3Dincompatible-pointer-types]
>   528 |         asrc_m2m_device_run(pair, task);
>       |                                   ^~~~
>       |                                   |
>       |                                   struct snd_compr_task_runtime *
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:186:92: note: expected =
=E2=80=98struct snd_compr_task_runtime *=E2=80=99 but argument is of type =
=E2=80=98struct snd_compr_task_runtime *=E2=80=99
>   186 | static void asrc_m2m_device_run(struct fsl_asrc_pair *pair, struc=
t snd_compr_task_runtime *task)
>       |                                                             ~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:534:47: warning: =E2=80=
=98struct snd_compr_task_runtime=E2=80=99 declared inside parameter list wi=
ll not be visible outside of this definition or declaration
>   534 |                                        struct snd_compr_task_runt=
ime *task)
>       |                                               ^~~~~~~~~~~~~~~~~~~=
~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:540:47: warning: =E2=80=
=98struct snd_compr_task_runtime=E2=80=99 declared inside parameter list wi=
ll not be visible outside of this definition or declaration
>   540 |                                        struct snd_compr_task_runt=
ime *task)
>       |                                               ^~~~~~~~~~~~~~~~~~~=
~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:10: error: =E2=80=98s=
truct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_create=E2=80=
=99
>   623 |         .task_create =3D fsl_asrc_m2m_comp_task_create,
>       |          ^~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:24: warning: excess e=
lements in struct initializer
>   623 |         .task_create =3D fsl_asrc_m2m_comp_task_create,
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:24: note: (near initi=
alization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:10: error: =E2=80=98s=
truct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_start=E2=80=
=99
>   624 |         .task_start =3D fsl_asrc_m2m_comp_task_start,
>       |          ^~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:23: warning: excess e=
lements in struct initializer
>   624 |         .task_start =3D fsl_asrc_m2m_comp_task_start,
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:23: note: (near initi=
alization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:10: error: =E2=80=98s=
truct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_stop=E2=80=
=99
>   625 |         .task_stop =3D fsl_asrc_m2m_comp_task_stop,
>       |          ^~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:22: warning: excess e=
lements in struct initializer
>   625 |         .task_stop =3D fsl_asrc_m2m_comp_task_stop,
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:22: note: (near initi=
alization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:10: error: =E2=80=98s=
truct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_free=E2=80=
=99
>   626 |         .task_free =3D fsl_asrc_m2m_comp_task_free,
>       |          ^~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:22: warning: excess e=
lements in struct initializer
>   626 |         .task_free =3D fsl_asrc_m2m_comp_task_free,
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:22: note: (near initi=
alization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl=
_asrc_m2m_init=E2=80=99:
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:701:41: error: =E2=80=98S=
ND_COMPRESS_ACCEL=E2=80=99 undeclared (first use in this function); did you=
 mean =E2=80=98SNDRV_COMPRESS_AVAIL=E2=80=99?
>   701 |         ret =3D snd_compress_new(card, 0, SND_COMPRESS_ACCEL, "AS=
RC M2M", compr);
>       |                                         ^~~~~~~~~~~~~~~~~~
>       |                                         SNDRV_COMPRESS_AVAIL
> /build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:701:41: note: each undecl=
ared identifier is reported only once for each function it appears in
> cc1: some warnings being treated as errors

Hi Mark

     I can't reproduce this issue with 'make allmodconfig'.
I tried the branches: for-6.13/for-6.14/for-next.

     I suspect you are using the wrong branch, because I can
reproduce this issue on for-6.12. which is caused by the below
commit that is only applied from for-6.13.
04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")

    But could you please tell me your steps in detail?, so that I can
try more.

Best regards
Shengjiu Wang

