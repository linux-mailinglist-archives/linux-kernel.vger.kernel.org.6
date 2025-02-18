Return-Path: <linux-kernel+bounces-519559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317DA39E08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AE163921
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3392698AD;
	Tue, 18 Feb 2025 13:53:02 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E6243387;
	Tue, 18 Feb 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886782; cv=none; b=jPOecxht6jE92S0mc8/H9VN67Bfs7Rvy0bk4DYz8vO7gnXjPfP4eJR9bV79N8ReDQlfUPDVYJOOcqsyEfkaYoGuP4oiIJqNnjsEDavXWPvOskSUChhl+NkHlhiHk68wBAgQ2f9rJyV2QtAQ0Spk4QWlTVYPuYo1qBeGg5T8D7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886782; c=relaxed/simple;
	bh=qg6tR2OJ5fUk+PNSPNlhAUrEokpSrd88BUu/FLoWZZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG8cjrNKl510s7GXm8i9ScF97CszT9BALnuHoGi4NoPtGfnFQ3/f5K1VY1XV4KZO8uclLl629uPPtxEF62v4KQu1Liuo+lW3MTj+TV5mpPnCqvObR6isel3skewmuzinzZjdEI3B6JapPvNGTsCNHJ361BYyGYzaurmYMcLlcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-868e8cf9e20so2880223241.3;
        Tue, 18 Feb 2025 05:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886778; x=1740491578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEMYvJ02y6eE/skRVfH3zjf1LQbRZ9uPnuefeC3IoK4=;
        b=ZDR0TNGT2aRUszR7hF/fU0/kFJnrmxkJf6Xt/hGbwcntuvw/0gFRhCK2jmSlq12l9U
         Ey2fVDVImwvd2hxgECoFzWd9+eKuw0x+t9JPmHhM38hLyswrUe5xMgcEtF4ZsO2X7bEF
         ObvutWbijQQ/C433cjoX3kKE7ps2U4OT1RCMhv7CTOhzReFP6+ECgaJM81kNlPYXpBCf
         1cS1IaRs6q39hpzT20jAuInA/3wFEwhMJQHs+jRDNgtiqf9HsfUqR5j/iY7xOHwBbqBB
         iD0Hszi6OwoXSN0iD6+Zt/qHOc2yZr5R4o2XfLOZp4DWhNMIQdv7pIs7v14JvMWbnlez
         nd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwWUS4MijVEdBdwmBezlRDDO3pMIqIJOdvNMsEGWbIQD2PmAB1FyhI6ELZYfLCLb2f8uGJPxwIA+JV9UI=@vger.kernel.org, AJvYcCXlMobpJsN7brnBs1ZOIECT7E2GIY3jXadzhXa/JEiAbLU4yIXlnG/qp4mZMzVndpFNPV9bmvD8HSCUQ3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmT6a3vtlnoMnabV0XVZ+ztfsyUhu//NfCs0+AO2fpDKO/tRj
	ZcCJ6MRSy62brh6kTauzA5NoMNokCfuGQ/oZcU54zNg3y8Gcc8L/Ok+xXZrQ
X-Gm-Gg: ASbGncv5jk+R0mojVhKFeowaq2vDmq80oTL+CoBGC5RAho5IEBUujZ6mg7PESujjyx6
	H11l7ND0rdNAPb4Pq6B0AqpoR6ZvfhM/RdRUe1HrrU5rIIEOdOYLQzUABBFvDkBo54B5WXfe6pJ
	YDz6ec44zzMeAYa4vLk8bcGPN6Dy7jCUadfMRyKXyD8v1YoyaN+bDDUlfhd3w3MbrGQhcVBUMt2
	wu6Bd7CiYBBeAU20rMyTI1T7drl/m/PWkpp/Ckc5d99sw1VilmhbFmSnjP6EhOba4+DfOvSaHhx
	vRdxMQlr7BU5bIPdy/LzY04irgCQMbhPflnXe2JQjfEsASQzycuSurFVtg==
X-Google-Smtp-Source: AGHT+IF1Ro/S8O5svSKZB96rUDRWsXa6girkn4hsNP60BWSy2k2OJOBigRaOS672YfZ+oGdc4FqQzA==
X-Received: by 2002:a05:6102:cca:b0:4bb:e511:15a6 with SMTP id ada2fe7eead31-4bd3fcd6f97mr7973838137.11.1739886778536;
        Tue, 18 Feb 2025 05:52:58 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bd3c9acda5sm1906921137.9.2025.02.18.05.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:52:58 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-520a48f37b4so1344086e0c.2;
        Tue, 18 Feb 2025 05:52:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrxvDx0+ivuwyqddQbf8VZPKLej6qLwQ16W4L0UFNoxbuQmigkqIgtpj68hu5vvnOerz4Mt7DZ2fkFLrU=@vger.kernel.org, AJvYcCW1y5Va5SDRLRodd95ZEpASJFYYY02drbXoOa7RkmqcL4Xf7vBn0K9LXiHrPRQXJAF/3d+DxKHPIxVfXnA=@vger.kernel.org
X-Received: by 2002:a05:6102:4b12:b0:4ba:9689:870e with SMTP id
 ada2fe7eead31-4bd3fe8cda3mr7352135137.21.1739886778052; Tue, 18 Feb 2025
 05:52:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-asoc-volume-limit-v1-1-b98fcf4cdbad@kernel.org>
In-Reply-To: <20250208-asoc-volume-limit-v1-1-b98fcf4cdbad@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 14:52:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXc8j14PwNnO2e3sPDCeS9fXx01qoMJHxWjxtuT3DrDNQ@mail.gmail.com>
X-Gm-Features: AWEUYZmYXLEgw1DblqJn6pERZY_THetfHNXj7RUJTuj4dr2XcgbmEMykqQHvEKo
Message-ID: <CAMuHMdXc8j14PwNnO2e3sPDCeS9fXx01qoMJHxWjxtuT3DrDNQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: ops: Enforce platform maximum on initial value
To: broonie@kernel.org, =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark, Martin,

On Sat, 8 Feb 2025 at 01:57, <broonie@kernel.org> wrote:
> From: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>
> Lower the volume if it is violating the platform maximum at its initial
> value (i.e. at the time of the 'snd_soc_limit_volume' call).
>
> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
> [Cherry picked from the Asahi kernel with fixups -- broonie]
> Signed-off-by: Mark Brown <broonie@kernel.orG>

Thanks for your patch, which is now commit 783db6851c1821d8 ("ASoC:
ops: Enforce platform maximum on initial value") in linux-next/master
next-20250218 sound-asoc/for-next

> --- a/sound/soc/soc-ops.c
> +++ b/sound/soc/soc-ops.c
> @@ -640,6 +640,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kco=
ntrol,
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
>
> +static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
> +{
> +       struct soc_mixer_control *mc =3D (struct soc_mixer_control *)kctl=
->private_value;
> +       struct snd_ctl_elem_value uctl;

sizeof(snd_ctl_elem_value) =3D 1224, causing:

    sound/soc/soc-ops.c:657:1: error: the frame size of 1232 bytes is
larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]

> +       int ret;
> +
> +       if (!mc->platform_max)
> +               return 0;
> +
> +       ret =3D kctl->get(kctl, &uctl);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (uctl.value.integer.value[0] > mc->platform_max)
> +               uctl.value.integer.value[0] =3D mc->platform_max;
> +
> +       if (snd_soc_volsw_is_stereo(mc) &&
> +           uctl.value.integer.value[1] > mc->platform_max)
> +               uctl.value.integer.value[1] =3D mc->platform_max;
> +
> +       ret =3D kctl->put(kctl, &uctl);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
>  /**
>   * snd_soc_limit_volume - Set new limit to an existing volume control.
>   *

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

