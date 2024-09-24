Return-Path: <linux-kernel+bounces-337087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EE984517
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775911F219C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7601A7057;
	Tue, 24 Sep 2024 11:44:22 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4419B5B5;
	Tue, 24 Sep 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178262; cv=none; b=oX5Kv60JMqvnK1rRwKEa2FBSH/IfT7GaaBbSNsJgh0eCnQ2CmS2xw5bqhQZhx8uxxMllF7R++9q1jagM0rfGy9gyvbtvEaa4YEk2AKuc009qwBZCY64N/KvMm0A62/pGgXt1430Dyur/SNgTmBnN2oB+2vY1CZTMyDjwOcJlWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178262; c=relaxed/simple;
	bh=voPM9RA68skveUvLrh8DSAA/KmOm8MVToLqfgfVCkr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gm0nZw1lq2fS96zjHNlPSlP7hDyBelrzxVNAi9Tu8kpgt3oW2OI28dvzU2ajUIJZTBvOR0FamuOdOFa8skzhuiYDcpegvXm3F9YpqbL5yBhXAsRaQRr4zoauDjopUfzh05Mn523Wn4bA9f1wWoOM9gK/4iGYBIAi+mFWDbLMqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6de05b9fd0bso43602117b3.1;
        Tue, 24 Sep 2024 04:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727178259; x=1727783059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGqXhKq0oVLFGXkOOmdjpXMuEBL+BCbru1yFH/7p29U=;
        b=LPdnd4JexhOxszEwY5Cs/vixcYpCmnLE1v29GEW8qU58FrTolY7pwvJga7c6GJftEJ
         gn6vkyNwQAOw7fYF4HjKE0cUi0Jnnl6L2x695rB+0m8r3N4AOMmnyv6sBy2sC1eHoD6E
         XMtmM6KcY2ZAn/sFQ4ZvqKjeH1m3Cq3U1qdVEd1oIPZDeuni491RD6tY1LdoPjUwNUxW
         UbCKB64mzyTbRLf/ViNOsNJaqgHKsRVbccb9QvOh2vfN9nYxpIuBgnYHcv4xoWvJ0QNS
         3Zfr8QRb7BXH0So8SQacj01x6ThFxubZSznFkcLBMqQh+MOJ4/KiIaLP+cGtz9KnCLsh
         A1lA==
X-Forwarded-Encrypted: i=1; AJvYcCUaHJpK6vVxIY8Ivda9tE2hkjGOa9HBvhRs7BkzC+kh7Rzr22v5NF5RjDsf3SVoZcmtaEc8apW2i1WhBORt@vger.kernel.org, AJvYcCVnXMivyHbaO6c8Jk95ZeL3xJYgUAesV2vUkTJ+4qimzHlYJj3ApkHNgbgACDd+UZMYY9dcvoP+nLDi@vger.kernel.org, AJvYcCXoSTWi82S1qJkliT/G1H7THgvJsEzXc/8qg2ZnO7jNAGqImNUYLkVtpyRIRyv5JuPjHLIFupv5PCAESU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSP8okof+T7LFXxDGX03iuFAJqrDmW4dBdPC2PkburmfZknTpO
	0vOEhQvdi0Cmpgzc7bjalBcHbpRksnxIPQA8ofwqg8bqj7XIBEbEsZyRXpyu
X-Google-Smtp-Source: AGHT+IEReg254Hpm5WHOwt34zykrxPoTzPib7bcBXcezXbaNsPec3eB7n3iC5KFj7psfZQHu2yxvow==
X-Received: by 2002:a05:690c:39c:b0:6e2:3e9:d89d with SMTP id 00721157ae682-6e203e9db3fmr35942027b3.38.1727178258920;
        Tue, 24 Sep 2024 04:44:18 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20ce8857dsm2244317b3.0.2024.09.24.04.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:44:18 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e04196b7603so3242933276.0;
        Tue, 24 Sep 2024 04:44:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULrbVaj/n1iW09qlsXEUymfkpYCbix4xzB54Dq23J+r+Pc1UmQ6M7A7JJ159W8cgWM1X/zyG3GvqfF7dKu@vger.kernel.org, AJvYcCWDMXf+n9hvx/bmSMlaFNGVnhPr4K6CruQfWxEAifnQdF3p8Doz/BhaWrqLk8La1jng2z24EhuRNLfTeoA=@vger.kernel.org, AJvYcCXnYdPCySHmBGoTsnGiJvjW56FxF6FcrmC5tTI84y55mG+9oCyktMT5UbAI7+N5k6wwIqlRymN8ZycD@vger.kernel.org
X-Received: by 2002:a05:690c:d82:b0:6e2:993:917c with SMTP id
 00721157ae682-6e20993a219mr25327247b3.2.1727178256981; Tue, 24 Sep 2024
 04:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226-audio-i350-v8-0-e80a57d026ce@baylibre.com> <20240226-audio-i350-v8-1-e80a57d026ce@baylibre.com>
In-Reply-To: <20240226-audio-i350-v8-1-e80a57d026ce@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Sep 2024 13:44:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtm+jGbbLXnCjPZZu_ZwpR-tCRuwbz0iQxUPkXG=g09A@mail.gmail.com>
Message-ID: <CAMuHMdXtm+jGbbLXnCjPZZu_ZwpR-tCRuwbz0iQxUPkXG=g09A@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] ASoC: codecs: add MT6357 support
To: amergnat@baylibre.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Nicolas Belin <nbelin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Thu, Sep 5, 2024 at 11:08=E2=80=AFAM <amergnat@baylibre.com> wrote:
> From: Nicolas Belin <nbelin@baylibre.com>
>
> Add the support of MT6357 PMIC audio codec.
>
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Thanks for your patch, which is now commit 5e2404493f9f6028 ("ASoC:
codecs: add MT6357 support").

> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2501,6 +2502,12 @@ config SND_SOC_ML26124
>  config SND_SOC_MT6351
>         tristate "MediaTek MT6351 Codec"
>
> +config SND_SOC_MT6357
> +       tristate "MediaTek MT6357 Codec"

Does this need dependencies?  The driver uses regmap, but it's not
immediately clear to me what is the backend (SPI?).

SND_SOC_MT6357 is selected by SND_SOC_MT8365_MT6357 in the next patch,
but I guess there can be other users, so making the SND_SOC_MT6357
symbol invisible ("tristate ... if COMPILE_TEST") is not an option?

Similar comments for the pre-existing SND_SOC_MT635[189] symbols,
but at least SND_SOC_MT6359 depends on MTK_PMIC_WRAP.

> +       help
> +         Enable support for the platform which uses MT6357 as
> +         external codec device.
> +
>  config SND_SOC_MT6358
>         tristate "MediaTek MT6358 Codec"
>         help

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

