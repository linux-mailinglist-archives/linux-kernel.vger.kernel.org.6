Return-Path: <linux-kernel+bounces-174315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB458C0CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AC01C21024
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68C14A0B8;
	Thu,  9 May 2024 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IfA2w+S6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DF14A0A9
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245114; cv=none; b=Ce842K6F9xUhznApqvLe+WOFwqVSf5J0HFYthg3OlDaQ/nJmU5UyWcXUblOCZjwiF3eKv6EF+kpuDBcoms/FsDDzlJVkL+dR1QRaby+KRaL9hmy5Ak76mfAZwLMesOMHol8Cj5fH0SVa55pODIGJGuSKA1otP/1MZRusphKfsLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245114; c=relaxed/simple;
	bh=97XaKPKk8jzzUIcm5De7fw/1qqOPyK9C7NjAdmsO8Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCWpVlpdMxfq8BC+nS+i66ABbRee0JnBLMdeqwI3ch8EWrte+JFg9e5nAkZDXt4sGFksU67UnwCfGXtW7eHX1ParNlLe5V4ZzLEG7SrjIpIuUp9L+RarpaJZQy52jpIZHX1iNQiN0z/M1QCfc9Yy2jq6QihRXU1D6VdEDr7pSlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IfA2w+S6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so7328481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715245110; x=1715849910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wiz5MoTmXNXCF7A/NdDpUQr0zJjTgt8byvzglF4DEc=;
        b=IfA2w+S6HCDmvwOLjwXXQBAT1CcGA4UuB/B1r3j8NrX92oeME0u5hIws7qlDYgecde
         JmFAHvoo/Zj+E/iR48ZA3j7XNoI6qaJbWSswvDd7e1rWfunx6UHpe6NQgZMp9Vl4YGRa
         hPFeSplKOsUS2RvIGswPCauFdlPiDuLiyrDWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245110; x=1715849910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wiz5MoTmXNXCF7A/NdDpUQr0zJjTgt8byvzglF4DEc=;
        b=WF/9NX9ju1hf0rAtWYWqiMphO68b9jf4P9ptgxJiRFkQt6pumQIKLDyyMb3HAABJJD
         QDpL0nDmahGBy38zcKo2IItYKvHh0NglP0NCZnXMEdHOE3dMWY1JIKsMO6QSI2NI+lUH
         aZChdQgWIilANhSXnBJvOH/To/g8gSid6miODhqSow9UPGSpPc2RXP4z9V3SEXYBZbam
         lNptbjsiMcPvKoxgciAPFMAxY+Ak3qvC6fPYZWEOS7HGYR6HvX8NY+ZGmR9CebkbTvrT
         CvOjgooLG7FdVVFD0YiJTI9hydCKkS2g3UWow2jMq2KmGkJJ/z4DgMeHVaNosD/pQT7c
         PPTA==
X-Forwarded-Encrypted: i=1; AJvYcCXfCLk8w/w8BnXHrT2iA04kLKTFpInJADmclfwjYEB3Y5m+6BkrlWYUqQDMGLzISUwUHTKdmLsUcUCvBlirYrqXs7fyod6EXuuyMHYN
X-Gm-Message-State: AOJu0YyMfgoFI8xr2HDqnyiFO0YV2Q/UWxEbIudFrlpzFHbEmyrth7pS
	oms8vAR8vy0CKP1k+JAH1usTzgkg5j0Hh3/H/WSy9kkJwP4kD6eQByGlLssehpTgSjS3Qq6g8zu
	+HrtycHQSCfUlKAqbMtZUT9IKnykwIbg6LYI2
X-Google-Smtp-Source: AGHT+IH9ObFL6J8WFDRyP8J9A5dWQL9UrJwiJ65mOUZ6bLzWBgApqNI6WPFqJ6HGRFDelg160CI2ttiR8RE+Eg7y928=
X-Received: by 2002:a2e:99d4:0:b0:2de:c6b5:2888 with SMTP id
 38308e7fff4ca-2e447194771mr32704081fa.3.1715245110374; Thu, 09 May 2024
 01:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
In-Reply-To: <20240509-8192-tdm-v1-1-530b54645763@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 May 2024 16:58:19 +0800
Message-ID: <CAGXv+5HYsKFpHWXE45N+4K1LbKA1Lan8rDHm6=+YvsY0CXKoMg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8192: fix register configuration for tdm
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:31=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> For DSP_A, data is a BCK cycle behind LRCK trigger edge. For DSP_B, this
> delay doesn't exist. Fix the delay configuration to match the standard.
>
> Fixes: 52fcd65414abfc ("ASoC: mediatek: mt8192: support tdm in platform d=
river")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  sound/soc/mediatek/mt8192/mt8192-dai-tdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/media=
tek/mt8192/mt8192-dai-tdm.c
> index 9ce06821c7d0f..49440db370af0 100644
> --- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
> +++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
> @@ -566,10 +566,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_sub=
stream *substream,
>                 tdm_con |=3D 1 << DELAY_DATA_SFT;
>                 tdm_con |=3D get_tdm_lrck_width(format) << LRCK_TDM_WIDTH=
_SFT;
>         } else if (tdm_priv->tdm_out_mode =3D=3D TDM_OUT_DSP_A) {
> -               tdm_con |=3D 0 << DELAY_DATA_SFT;
> +               tdm_con |=3D 1 << DELAY_DATA_SFT;
>                 tdm_con |=3D 0 << LRCK_TDM_WIDTH_SFT;
>         } else if (tdm_priv->tdm_out_mode =3D=3D TDM_OUT_DSP_B) {
> -               tdm_con |=3D 1 << DELAY_DATA_SFT;
> +               tdm_con |=3D 0 << DELAY_DATA_SFT;
>                 tdm_con |=3D 0 << LRCK_TDM_WIDTH_SFT;
>         }
>
>
> ---
> base-commit: 45db3ab70092637967967bfd8e6144017638563c
> change-id: 20240509-8192-tdm-cbf2a73c9dd3
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

