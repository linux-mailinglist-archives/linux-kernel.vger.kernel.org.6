Return-Path: <linux-kernel+bounces-270616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018D944220
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DD61F2215E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4EEC2;
	Thu,  1 Aug 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gn6MOnz2"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAD13957E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484905; cv=none; b=hZvFqgg4a2YCYytklZsuvCdwmypVnxjNdDlP8s7S4r3mKt4kmJHA3yixrN4TA9A6LzgIiR/PPb/VsrCPkKxe5po5LwY/I7Ko0sw7GJrlN8U2cDVFj6P+YYZGhgM+W2OiEPxDgdByfoAlw9qh32avLskIXFDzw8kG7outDLP3uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484905; c=relaxed/simple;
	bh=QJ3afN6yfO4Nhj/2k39dSxyb7w1Xy4bYsyPhJGKXyzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW6VT/y1Wol5K+F+2pOu20xVITh9qKo/GUFtSDolEwD65pIJCIfQ5dz/aMLf+p64NWYFlFssrv3vj261uz8NHhvXYMddL63DYxa/kDQ/IbBhaxq53a7bj5j9sb0oU45FuXwindKHlIQdY4FxQfTzkHXVnAvq2MLJUxhXbRgWTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gn6MOnz2; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efa9500e0so7905119e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722484902; x=1723089702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZhzJQ+a9Kym4MWHHdIYItKXwrHniaEz0NXbkAmGBpk=;
        b=Gn6MOnz2/2uPn029qZfzXXl0tjBbgEs5RCe2C9BbXxZMgJ5i0f8Hool2IWSmexdOmN
         90S+RG/lyPrSMF7ON9pJpaJPmh31ocs0qd442RzvrE2QQq6oBwxTarKWG2f4uc3C1u6A
         pjtldJpJQi0E3XpZXg3gs8sXypZ8bQeUUXHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484902; x=1723089702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZhzJQ+a9Kym4MWHHdIYItKXwrHniaEz0NXbkAmGBpk=;
        b=V1WngjcE3qzSuvfM/3hIuZ+TbO3UahVSqjYf4AMqzVUsDwPLkHbXUKyW3ps3qyhIAu
         spHfGRPT4drLfU0+O1oCnwzY+80yJqZeSOmshxKb6jU67kqE8R5GNCDfzNJ2sekcXvaM
         HbhXfoC2s/w1ZQ79dSANovkLerwkIOkSR5laIHmN3tGbLkpec37MUTv/y10yhCn2GpJ5
         jEEyRkVDnRzEJ9Agsxd3Ppfb91tRJKW/Og4SCRAwuYyl6wNBCoWKG5yUQ9vqY6nvVPPN
         CRGZLluGKLpLWi12TRDlYiW5UzAlYxS+dbqWDWxIfbm3fLow3WJ5bBO+ObAYte+qJP07
         Dgcg==
X-Forwarded-Encrypted: i=1; AJvYcCXfLf7squ2m+ufQG9FFyP4lTx6RB1UYSQTg8QEF8t7RNf+GfJV9vEtgItPNgFHvcuO+i0Se8kDKqdW/UxhJB7eEaJX+i/tpOEZ66uJP
X-Gm-Message-State: AOJu0YzMVOxBz27SKAp4XU3Scv8eem28XSr36atYg53gCzeKxxHP0t9W
	UNAIUsSXXxRx+b5cpuRNeTdBBkhOsAgcNZEcXAXNtKywioL8w1rsvBQdNJSlvFW0/ujbt4SsoZP
	To/1Wyri6DD53t10bH2354aUrK5tLIzJJL8GE
X-Google-Smtp-Source: AGHT+IFbtjXGKr6OpFxpL2naXVX3atufbKENiq30EYD5eQDXV5YXSmf+M0f6uFAMeZOGG4Sdlo5YmT711IgA5wFEMPY=
X-Received: by 2002:a05:6512:251f:b0:52e:a60e:3a08 with SMTP id
 2adb3069b0e04-530b61a607fmr640260e87.11.1722484901244; Wed, 31 Jul 2024
 21:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801031030.31114-1-yr.yang@mediatek.com>
In-Reply-To: <20240801031030.31114-1-yr.yang@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 1 Aug 2024 12:01:30 +0800
Message-ID: <CAGXv+5EYMgeNnQ3BU8cxy0a5aH8e+GbO=-OFVysU2MqBy+yQFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ASoC: mediatek: mt8188: add register to volatile_register
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

Hi,

On Thu, Aug 1, 2024 at 11:11=E2=80=AFAM yr.yang <yr.yang@mediatek.com> wrot=
e:
>
> From: YR Yang <yr.yang@mediatek.com>
>
> Add AFE Control Register 0 to volatile_register.
> AFE_DAC_CON0 can be modified by both SOF and ALSA driver.
> If this register read & write by cache mode,
> the cached value may be not the real value
> when the register modified by other side.
> It will cause playback or capture fail.
> Need add AFE_DAC_CON0 to volatile register.

You should mention this specific register in the patch subject.
Something like:

ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile


ChenYu

> Signed-off-by: YR Yang <yr.yang@mediatek.com>
>
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

