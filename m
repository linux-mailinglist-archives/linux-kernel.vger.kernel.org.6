Return-Path: <linux-kernel+bounces-276092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1486948E45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C13328849D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D01C3F08;
	Tue,  6 Aug 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XcIOqxtJ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974E1BDA83
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945641; cv=none; b=JitiicCoorCVGB+HAlA0RUdwXrebPY78zxg/9V8u4PafDuCt3b5Kazh2VHrMVEw8Zit+9C7tICAG8kVi82hTBFhPGZNMPW0dyJW69oHVhPJn8zPG6X4Y7K/AITK3JvNmjeTeHaMVnKQqElby+pzO/no8Qb5qdYaWMmrj6WakL70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945641; c=relaxed/simple;
	bh=RJDDfvMiOEoXePnZA9Ms3FvFMFt5VD82QTI13DNz0nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+E5KajpyE6npU+Ng9D4ppkiPar3WIfe5N7jIfWq0vEH0a1T4IE0+qb2KBhnm6/aE/Hhbw6GYJWoPYC5k90JvrybKx/W/xqmFE3zpwBFnJXjiM0/19wT7kZYpWONpasWUIOjGSb0ZPxav7BsH4clj8tIgUdWzqPH/y+We5ufrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XcIOqxtJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a94aa5080so58416366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722945637; x=1723550437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFalGrV5LPuH5m9MtaZapm5ai3Cg5stQHsN8KCx3+Xs=;
        b=XcIOqxtJ5YIDhKWrW/wV6g9JfeRywxdLZZPhsZRTEZCEwVrOlr0MAMFTNxVaRwwE05
         9whHnp1ChzIoyTQBB8e8DHbSwYTWrl1OksCJPP08dZjN/+Q/dRPsR2P1il+Q3wKN2vIs
         SPy97wWm5oE4pppUkHYSKWRVN1zsOsVilX3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945637; x=1723550437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFalGrV5LPuH5m9MtaZapm5ai3Cg5stQHsN8KCx3+Xs=;
        b=bYwFu061X+vEOrN9QS5qFpH18qr/iKdV9ZKYuGFQRqZb8gkSYdbkKBCMxC3KPKJr+h
         aJ74CwIk+WHZGoNrfcGvzqDIE2DqNnw1mZjkSCEqZX2wLX4GNL6A19dXPIuydxlQwJkm
         9kQ1uvbMAUAwpK5igjf3ZHayEsiVMYQiiMRZ5IC/kudVVACD7lBZ+UrvVpd7Lp1TiMwi
         Pl7B2+7PevF21T0/CXoOr7J/WK0nEESAuqO+nkRgNacniAXQn40R8Z3pbAsuAYXU96M5
         611QfxBwc+UfesCZptCJ1/1s4stxxMD9DTi4qcA5YLYUCKVmV1uFVa5kPOMvOBgsVViO
         vFhg==
X-Forwarded-Encrypted: i=1; AJvYcCWg/1j/wyiuC10EFwc4fjJxkidqhsg764S0KffR/iOweF0zHTMOm/Cj5MkVfGsZd4tAs0ncHmLVVge8BHBQRLf1GFRsmThZbKN7SwWO
X-Gm-Message-State: AOJu0YxdlkoLq+/WTedJRt7aRTvw689LyHON1OJEzrVo92KkqiV3Wj89
	KfdjNvVbX3Xt3fhcn5tvj2FGCPc7rhUtRh4F85a4TjM3Pp887SGq60Y383F3DpPt3sLu9xyjk/g
	=
X-Google-Smtp-Source: AGHT+IHjFXEVFjcnoQQ8c6DKX0AaX28slllOLFr+refID70HkEwOlhuF7vap/NrrMV6uHRCGST/i0Q==
X-Received: by 2002:a17:907:86ab:b0:a7a:91e0:5f1b with SMTP id a640c23a62f3a-a7dc5201c66mr843898566b.68.1722945637322;
        Tue, 06 Aug 2024 05:00:37 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec285bsm538842266b.188.2024.08.06.05.00.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:00:36 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so541696a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:00:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW626b6lKDRzuBPp5XhIT7k2xzrWNirbwjuiutv4/ovevCNbLuHXmd7DhWRFpp5Cb+gAm2QkMkYikmwUmr3ZglSHCoTOjlz5iV527O+
X-Received: by 2002:a17:906:6a1c:b0:a7a:9ca6:524 with SMTP id
 a640c23a62f3a-a7dc4fe2dd4mr1109632666b.14.1722945635971; Tue, 06 Aug 2024
 05:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801084326.1472-1-yr.yang@mediatek.com>
In-Reply-To: <20240801084326.1472-1-yr.yang@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 6 Aug 2024 19:59:57 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngP9WvLBmbr6S2C5zs+47ap_FZqCJOJZxZnKOTapJ71eQ@mail.gmail.com>
Message-ID: <CAC=S1ngP9WvLBmbr6S2C5zs+47ap_FZqCJOJZxZnKOTapJ71eQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile
To: "yr.yang" <yr.yang@mediatek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi YR,

On Thu, Aug 1, 2024 at 4:43=E2=80=AFPM yr.yang <yr.yang@mediatek.com> wrote=
:
>
> From: YR Yang <yr.yang@mediatek.com>
>
> Add AFE Control Register 0 to the volatile_register.
> AFE_DAC_CON0 can be modified by both the SOF and ALSA drivers.
> If this register is read and written in cache mode, the cached value
> might not reflect the actual value when the register is modified by
> another driver. It can cause playback or capture failures. Therefore,
> it is necessary to add AFE_DAC_CON0 to the list of volatile registers.
>
> Signed-off-by: YR Yang <yr.yang@mediatek.com>

For this patch for MT8188:
Reviewed-by: Fei Shao <fshao@chromium.org>

And a side question: is the same also required in mt8195-afe-pcm.c?
Their volatile register sets look almost identical (except MT8195 has
some extra lines).

Regards,
Fei


> ---
> Changes in v2:
> - Modify commit message.
> - Link to v1: https://patchwork.kernel.org/project/linux-mediatek/patch/2=
0240801031030.31114-1-yr.yang@mediatek.com/
> ---
>  sound/soc/mediatek/mt8188/mt8188-afe-pcm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/media=
tek/mt8188/mt8188-afe-pcm.c
> index ccb6c1f3adc7..73e5c63aeec8 100644
> --- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
> @@ -2748,6 +2748,7 @@ static bool mt8188_is_volatile_reg(struct device *d=
ev, unsigned int reg)
>         case AFE_ASRC12_NEW_CON9:
>         case AFE_LRCK_CNT:
>         case AFE_DAC_MON0:
> +       case AFE_DAC_CON0:
>         case AFE_DL2_CUR:
>         case AFE_DL3_CUR:
>         case AFE_DL6_CUR:
> --
> 2.34.1
>
>

