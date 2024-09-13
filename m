Return-Path: <linux-kernel+bounces-327503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432649776E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680821C2390C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9A1D31BB;
	Fri, 13 Sep 2024 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlnGhnne"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879782AD17;
	Fri, 13 Sep 2024 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726194572; cv=none; b=u5cNyOmJzaM3XR3vMXvwmIKEo9e4dmJf6Qu5rg1ztATu/Z4EgCZRjvutN2MGvYBkzQS9afnlTASNiCa6NO7mLR2E/XbFw6SnYkPHTA10CmTl+PvOEERrGrOHk3JAoZbWn4lrVU8+Ygp5qekt1WH7sbtAFL1wiugud8CjBvzKN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726194572; c=relaxed/simple;
	bh=wDB/MmaREIlVIheggTMUFzevQWctTktcCq/9Zzf0yhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKL3XrvP579/7lR+80clEpe8jrGTVL1GtweBqYe1f0sSJj4T+jgHfWITicI2bWPqMMYD5tDjTg16Ug/NUbyijxh4abbHwVy99gYnsHXulKnmNU7BAdjyg7mD60L8hcswRF6+f4u0LA9Oq+LwpQaJv9+3MDqOZAo99sNVzQ5vkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlnGhnne; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a08d3144d9so290555ab.0;
        Thu, 12 Sep 2024 19:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726194569; x=1726799369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTMhgEbsFwO+pBfHozMIUKTCxeSJ9rkkx6pXiVEJYI4=;
        b=BlnGhnnexsyq9cE/vQSppMohKNQJZCC0ZUYd87fRRBHQ8GYKhhHwskb+AtbGFjhx2E
         FAiAWXBHNyX8J/mk5FxROaY+EYnrhNRV8OFBUnUZ6lY4PY2x3LT8cWnnycsVx7TOBYqs
         5OXsPBz5X8wEDfyaJTJ9k1r7JYoQEw7u+G3gFZFLv4FwPVWPdJZo9fbAAVlQke48f+xZ
         wWsXqmslAr2Ua+T2YUYgdjuYjEVFq5qKLpS73712jUuIpAE6VLpHYLNcsw1+yfN30+w9
         Oe/P4kKx5fXIL9LgBqHEf4WXSq7of9RcyTwjTOq2/gubNWnyMMhGW7XWo41iT5qYCVEr
         bG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726194569; x=1726799369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTMhgEbsFwO+pBfHozMIUKTCxeSJ9rkkx6pXiVEJYI4=;
        b=t3UjzXbubXicS9NAsqMtg6jGtUVn8L0Hw18/T7HIX0U/DL5z4M+SWvUrTKDeUi7jOz
         0AdXBvYTA2+4cQrp45WxKJaZ8LpverzM1/HhVi65xtsedhGdg+/g2gg6E0UNLYyei9Gd
         E6dZ6VzkRyuERoQSi7y9mwr0Wo4fs2d+HV2ZfNRVJrkqNGxJdwQ+xYsg/p46kehvuALp
         bs4MVmjNYWrHcBiTJLignQlapv7VGMP7pE67miAQWFBcwK+FAGFkjOIBR1hwV2u8ijy4
         fGyrXAQcKPdxijZwL9qV8+uI3BVPO8/31B4Yq0Ourkzlfg9p/I6QKWCZmnlC/evnrG9Z
         eO2w==
X-Forwarded-Encrypted: i=1; AJvYcCV2dKvCLNGcsHokGmjW0weHUvjqXztoGzdatLX4yk4oVRp72zGFC3cDbpMob/aBMv5ZRhD5tlQZ4sxgy+Q=@vger.kernel.org, AJvYcCVDvjjmmKKUkcoaqRUO/O7WiATfyFtdrY2GTEQjxUT0wuop2Os8EFONtAToWGBM9fUVh0cK0Oe698hugR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymycPVggg3Dmckyd8mIGBfSgYbouBOHQ9W1N1EnkPbSlRceBfJ
	s8gFeqHWrll9urWrGDwJnQzO1HX8vejb6Z0aWcum7ptyDnn+X87gGSB/f1YQYQLYupaCpikMH+Q
	+Ohg5H7WzNMLfJ/XIVaKTvF0bJjQ=
X-Google-Smtp-Source: AGHT+IENKLUdj9+ZkJdPontbPGNcWKf/93O8fVsmGBQhknsCe7sTxPjA/0aEHZIrgYGLHSh2qlW9DaOFsfh/RDk3zVc=
X-Received: by 2002:a05:6e02:12c5:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a0848eb2admr53336035ab.5.1726194569381; Thu, 12 Sep 2024
 19:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1725615837-24872-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1725615837-24872-1-git-send-email-shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 13 Sep 2024 10:29:13 +0800
Message-ID: <CAA+D8AOkQOanya6RViXfk_=CmNmCWx-N3cb-0SjMhSy0AA7LeA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] ASoC: fsl: add memory to memory function for ASRC
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:05=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> This function is base on the accelerator implementation
> for compress API:
> https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.5991=
1-1-perex@perex.cz/

Hi Jaroslav

    Shall I add this patch to my patch set next time? Last time I
reported an issue
about "list_for_each_entry_safe_reverse", I can help to add it.  or
will you send
another version by yourself?

Best regards
Shengjiu Wang

>
> Audio signal processing also has the requirement for memory to
> memory similar as Video.
>
> This asrc memory to memory (memory ->asrc->memory) case is a non
> real time use case.
>
> User fills the input buffer to the asrc module, after conversion, then as=
rc
> sends back the output buffer to user. So it is not a traditional ALSA pla=
yback
> and capture case.
>
> Because we had implemented the "memory -> asrc ->i2s device-> codec"
> use case in ALSA.  Now the "memory->asrc->memory" needs
> to reuse the code in asrc driver, so the patch 1 and patch 2 is for refin=
ing
> the code to make it can be shared by the "memory->asrc->memory"
> driver.
>
> Other change is to add memory to memory support for two kinds of i.MX ASR=
C
> modules.
>
> changes in v3:
> - use Jaroslav's suggestion for header file compress_params.h (PATCH 01)
> - remove the ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE definition
> - remove ASRC_RATIO_MOD in this version because it uses .set_metadata()
>   Will wait Jaroslav's update or other better method in the future.
> - Address some comments from Pierre.
>
> changes in v2:
> - Remove the changes in compress API
> - drop the SNDRV_COMPRESS_SRC_RATIO_MOD
> - drop the SND_AUDIOCODEC_SRC and struct snd_dec_src
> - define private metadata key value
>   ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE/ASRC_RATIO_MOD
>
> Shengjiu Wang (6):
>   ALSA: compress: Add output rate and output format support
>   ASoC: fsl_asrc: define functions for memory to memory usage
>   ASoC: fsl_easrc: define functions for memory to memory usage
>   ASoC: fsl_asrc_m2m: Add memory to memory function
>   ASoC: fsl_asrc: register m2m platform device
>   ASoC: fsl_easrc: register m2m platform device
>
>  include/uapi/sound/compress_params.h |  23 +-
>  sound/soc/fsl/Kconfig                |   1 +
>  sound/soc/fsl/Makefile               |   2 +-
>  sound/soc/fsl/fsl_asrc.c             | 179 ++++++-
>  sound/soc/fsl/fsl_asrc.h             |   2 +
>  sound/soc/fsl/fsl_asrc_common.h      |  70 +++
>  sound/soc/fsl/fsl_asrc_m2m.c         | 727 +++++++++++++++++++++++++++
>  sound/soc/fsl/fsl_easrc.c            | 261 +++++++++-
>  sound/soc/fsl/fsl_easrc.h            |   4 +
>  9 files changed, 1260 insertions(+), 9 deletions(-)
>  create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c
>
> --
> 2.34.1
>

