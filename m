Return-Path: <linux-kernel+bounces-201954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974C8FC5D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0311C220D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4CD195FE5;
	Wed,  5 Jun 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C3vRmnba"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF4195FC3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575335; cv=none; b=Vun0QmRdL+rNZg0IziTonP9Ix3Gj+THyjcd/pCGx5HCHahQRy/2lxp6mCqF/Bqbg3t4vxcOUfidVKjwmpyDc4Wcnw/hT623U7w52lemku6ZcRVco+xXGBy9FcGS75SsNqnvw1FcDd7FjfYoimEwXCjCza9Bj04CK3+7sLthwPHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575335; c=relaxed/simple;
	bh=wwczkAnxiPnhiTU2luJ8i5BIFpa3mGxUm4/6rAw6d74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUcCkcO4YCOJS4hw/mdt2JSIBjCFO9T+5F+EEbYrX35gvIY2Dkec4L3MsnGHgiMJuXwVXzSf5iHW/AisgdNX8W7gyhlgp/7X0fSTdScrUp+Q0MqTh3jl2ijQFs+GmEwpP0FyvO6ZZgcelGlUsm2SRQ67w+yBpwxDUotPcoifPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C3vRmnba; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b894021cbso6241145e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717575332; x=1718180132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBJGp2n7Qi8iczry8F3rJYPAUsV9sny6tREW8YboOY4=;
        b=C3vRmnba8MFnJL4smuV5/tHhszOwASBsR2hcIClDtW60ccR1m2UlMAS9MfJJDwUG1D
         uIgnCFluUb6F05o3q9hOskfiXdbrOgPufnQI+XsSp8UZGwup2DADEDUo4XtBPdMRMj9m
         UiMCRemvV0ZExTGcL9tkEu0Cf5ldAEVFtyUOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575332; x=1718180132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBJGp2n7Qi8iczry8F3rJYPAUsV9sny6tREW8YboOY4=;
        b=EEaLGQELC+a+xIN1yuLX3lZ3gurY5wdh+lceyRfDUdMttrPLKzthOaFN8RJ3RtY1y7
         hxUqFb70eVTUPjmfuqyHAaTU029z8GDyndruP+sdI4JvWWfjSQ7JyRpQtNG6EZASn1lY
         apGQx/ZGkSiV9BWnoTSZpZNnb4C8/zhYwJMmzg/m7rPHg2jr8g5jhESNx09Yf+DW+dE7
         JNYVYrYdi0Tq+QpgBoEtN492VOSsHU/bLTU2Lsbdq2rzK+L2kEj3Vwr3IE5TzUGMNKZQ
         ppcbDmEibX/XFoiC5Vye8PGHARwYQKToTr2KUMhvX78Rbu1Sgz+jGXevuUlCzYXvQeUb
         gYgg==
X-Forwarded-Encrypted: i=1; AJvYcCWJkS312WIsmfxtRuDFsJqwKB6ktLeLtndL2Gw4iVVKxlGzc3tDAx/BQgP3Xl4uJPYXbyIj1cci9U8va39izQqwndqnYNbfLbeJrrU4
X-Gm-Message-State: AOJu0Yx0pT0VkYVlBoQG6y1us/spJ4RrdicllWoW44t5mncl1GDtXCZQ
	oLc/z8jP5AX2MIYc0Ewn/X7VIeD9Op/seCfVt3tsEUXO6P2jUAXjSv2HKvgNl/tZbOQgo7ZdrPy
	upGK8jwfPCRiGNJosctHGLYrhl4DtATBo7vrE
X-Google-Smtp-Source: AGHT+IFv2EhtdnevSPCvIeqSgMPmgn2c2ifR+LCf/RGmcOYSAbDEQu2piNDxPs8NQh7dFB09wa+cSR9ks7fS+1w/wzo=
X-Received: by 2002:ac2:4c92:0:b0:52b:84bd:344f with SMTP id
 2adb3069b0e04-52bab4fa611mr941691e87.53.1717575331623; Wed, 05 Jun 2024
 01:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
In-Reply-To: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Jun 2024 16:15:20 +0800
Message-ID: <CAGXv+5G3RjUOyGR2kqd1V-keQZLvBPaMmiW8BZgLGw6jcZe0nA@mail.gmail.com>
Subject: Re: [PATCH RFT] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol
 name collision
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 4:38=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> Since "Headphone Switch" kcontrol name has already been used by da7219,
> rename the control name from "Headphone" to "Headphones" to prevent the
> colision. Also, this change makes kcontrol name align with the one in

  ^ collision

> mt8186-mt6366-da7219-max98357.c.
>
> Fixes: 9c7388baa2053 ("ASoC: mediatek: mt8183-da7219-max98357: Map missin=
g jack kcontrols")
> Change-Id: I9ae69a4673cd04786b247cc514fdd20f878ef009
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
> This patch fix the kcontrol name collision in mt8183-da7219-max98357.c.
> Originally, the "Headphone" kcontrol is added to meet PulseAudio's and
> PipeWire's needs, but that patch was untested. Since I don't have
> either setup, I wonder if someone can test this patch.
> ---
>  sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/s=
oc/mediatek/mt8183/mt8183-da7219-max98357.c
> index acaf81fd6c9b..f848e14b091a 100644
> --- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> +++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
> @@ -31,7 +31,7 @@ struct mt8183_da7219_max98357_priv {
>
>  static struct snd_soc_jack_pin mt8183_da7219_max98357_jack_pins[] =3D {
>         {
> -               .pin    =3D "Headphone",
> +               .pin    =3D "Headphones",
>                 .mask   =3D SND_JACK_HEADPHONE,
>         },
>         {
> @@ -626,7 +626,7 @@ static struct snd_soc_codec_conf mt6358_codec_conf[] =
=3D {
>  };
>
>  static const struct snd_kcontrol_new mt8183_da7219_max98357_snd_controls=
[] =3D {
> -       SOC_DAPM_PIN_SWITCH("Headphone"),
> +       SOC_DAPM_PIN_SWITCH("Headphones"),
>         SOC_DAPM_PIN_SWITCH("Headset Mic"),
>         SOC_DAPM_PIN_SWITCH("Speakers"),
>         SOC_DAPM_PIN_SWITCH("Line Out"),
> @@ -634,7 +634,7 @@ static const struct snd_kcontrol_new mt8183_da7219_ma=
x98357_snd_controls[] =3D {
>
>  static const
>  struct snd_soc_dapm_widget mt8183_da7219_max98357_dapm_widgets[] =3D {
> -       SND_SOC_DAPM_HP("Headphone", NULL),
> +       SND_SOC_DAPM_HP("Headphones", NULL),
>         SND_SOC_DAPM_MIC("Headset Mic", NULL),
>         SND_SOC_DAPM_SPK("Speakers", NULL),
>         SND_SOC_DAPM_SPK("Line Out", NULL),
> @@ -680,7 +680,7 @@ static struct snd_soc_codec_conf mt8183_da7219_rt1015=
_codec_conf[] =3D {
>  };
>
>  static const struct snd_kcontrol_new mt8183_da7219_rt1015_snd_controls[]=
 =3D {
> -       SOC_DAPM_PIN_SWITCH("Headphone"),
> +       SOC_DAPM_PIN_SWITCH("Headphones"),
>         SOC_DAPM_PIN_SWITCH("Headset Mic"),
>         SOC_DAPM_PIN_SWITCH("Left Spk"),
>         SOC_DAPM_PIN_SWITCH("Right Spk"),
> @@ -689,7 +689,7 @@ static const struct snd_kcontrol_new mt8183_da7219_rt=
1015_snd_controls[] =3D {
>
>  static const
>  struct snd_soc_dapm_widget mt8183_da7219_rt1015_dapm_widgets[] =3D {
> -       SND_SOC_DAPM_HP("Headphone", NULL),
> +       SND_SOC_DAPM_HP("Headphones", NULL),
>         SND_SOC_DAPM_MIC("Headset Mic", NULL),
>         SND_SOC_DAPM_SPK("Left Spk", NULL),
>         SND_SOC_DAPM_SPK("Right Spk", NULL),
>
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240531-da7219-2281085838a5
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

