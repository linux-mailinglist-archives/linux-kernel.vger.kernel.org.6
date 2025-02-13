Return-Path: <linux-kernel+bounces-512643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78931A33C08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2033A28CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815D211A3C;
	Thu, 13 Feb 2025 10:06:20 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951B20E717;
	Thu, 13 Feb 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441180; cv=none; b=ZZeLkj3sEIfdf6/G3RtYcv1Kyp8pLvjjjnmL0OgZP90IxOpVbwTYIFjOsFiqgLsnW5knmb994uqoOGBX3iAvZnn//QDOHDATsl35S8RP2f4W47z1xVX7E0YrglFQWRiwTmpArAC+A+WtPGv3TmuqJORHqVftUjq7ID8tY7iwUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441180; c=relaxed/simple;
	bh=T1BdMlO7VJaJKDxI8etm5Q6HJrt/8gfc9adcoeDYceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGwKsvqjYI/vxQLjXzwTaiAP+HZsRYUY1vdPKhqVPf722rWdhWIdFiWC4k4Ws87CT4qkk1+p3isS9llqYj83XFoGsm0p/4XzCdlLdYP/QPO1eueSfuHRyqdiMVKRF3gPPjx704Wvaunja4VIX4SKV21vvd2cIvrZGDIJAoo1EI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86712bc0508so223221241.2;
        Thu, 13 Feb 2025 02:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441176; x=1740045976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ET9GwN+uLjDsvjU0KoNteKFJwQHfNy0LS4Dkz43P3s=;
        b=Ca+M329fsIdv/BiirchHDP7bZkiUwxhWMOnc0yeoyzPBdycc5gyEH23mpQwZ/QtNjT
         Pg9NICtB7xw8xl4RVQ73lyW9NLZvUpef7bMfDLFimx9yhr2gHtXY8P/qvixEhs1Hpogd
         43sxcN/I8/q+yORrdU9h3s5iiZHuKbdgRuLVRrexBToHzmzZiiwh7TPqlrPscQrccoTt
         yVQ3y0SbWEW1y5AMMwYjHVqIymWlst+sFzXEfsgoxiAvXJJIZ1E/zReeUZER1DSY2Q61
         srYtnTwckvdP3/uUmZlCOiOYxqGXW0zPrbPe4oc3yKMzdU/jw3AgphQP3PxQs08SIc4I
         9OYA==
X-Forwarded-Encrypted: i=1; AJvYcCVB9aESpdvFhtRoTfxTTFqt5KHjgef+gihYhUOdTimzzIxYH4IAWGO+xvS/S3UG6N55PJOGRL75IA==@vger.kernel.org, AJvYcCVqXXChvCKyJcJ37ZX7YXvkJTtGK3T79hlY2slt+zV4mVaQGDHkejG+dSehiaeALbhcpTyOGq5na7Wb@vger.kernel.org, AJvYcCVspMsVd74xHACDqlLHNPO3G+DEWSZF26wvAlz2hdxE/E4LlPVP0iNUNNtQSAovrh1kgT5OESK1ZYOnrzM8@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAQx7Uqwwd52ohN14mLrzRCjNULIsHfrmskOI8FsZXMNZO6+x
	JmOrjcyemFKHE7kP9q865zM44qrnHTT9PEk/ciERJGkbf5Z0NAoZq5o9k8NMKSY=
X-Gm-Gg: ASbGnctsPCCBrCBohKibuXIij2/kVHZxNefx/CNsgGWR1dNL+aOM6VC6kWOtPPlgtgg
	DDXoqOciMC3TzxftX8SCyt9D9WVCvA6Y0G+VcHICiZseU2iCW7+4vdIIqwsl0bTYnzEjW5j9Jda
	T4r8qgjWDLDRJeg5sj+6qD4JNNjQ2izHfS8/H0am1DIvtxKr97qrShylhcxU+PKQqOMcUQ9N+tY
	T/ONEV92pJ+0h45dkJMW86l5fSPQ3P6QsDHO73rGJjL/rLHFlfhrUPc8hf3G+ALxYIi7bprFH5+
	o1cEhL3WopwX+8Er/BJ8CXLzq59d4Kf8b3p5+QQRSPasCnOkA6jEVA==
X-Google-Smtp-Source: AGHT+IGfNX90gCBdtZkdzhWrKS8JhWviOfIzc4W2sfpPM9ktet7w2YDVHo5/tEOjsvI+xoFCWKt2Tg==
X-Received: by 2002:a05:6102:4410:b0:4bb:5d61:1252 with SMTP id ada2fe7eead31-4bbf231517emr6577066137.23.1739441175984;
        Thu, 13 Feb 2025 02:06:15 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e857f2desm136820241.10.2025.02.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:06:14 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bbb9a50baeso128476137.0;
        Thu, 13 Feb 2025 02:06:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU168t336kiCfJUaXrT7fnCP427bbjJWlrBmWNYfly0Zb6Es4X704hAIKTyhK1/hpvzMgBic04ZobXi@vger.kernel.org, AJvYcCXcbnE15I4ZljSvXuP0EPBI/qpslXzSKYGPGZI0utKfcVLY5POyXg7NUFgfo1lO5g/m7Rwcmo3ZIQ==@vger.kernel.org, AJvYcCXx43eomOVokwZyR7Xh665mFUAKhwoEntkRuI1bMD1FTjfYrkw/GP9dSl7GNrkTK9/GiydBvIcjdBXHm6gN@vger.kernel.org
X-Received: by 2002:a05:6102:3f94:b0:4b6:18b3:a4db with SMTP id
 ada2fe7eead31-4bbf21c8337mr7301506137.8.1739441174414; Thu, 13 Feb 2025
 02:06:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com> <20250205-clk-ssc-v2-1-fa73083caa92@nxp.com>
In-Reply-To: <20250205-clk-ssc-v2-1-fa73083caa92@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Feb 2025 11:06:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWn+sKiC1B4MF1vHwS2ArFYQXGzpYi2EcsyERPSCc9bvQ@mail.gmail.com>
X-Gm-Features: AWEUYZlvlExVgKAlPqcQ55dSJRN4GqYY50RVEAwpoHERFHUH_dWoi8JrSM7k46E
Message-ID: <CAMuHMdWn+sKiC1B4MF1vHwS2ArFYQXGzpYi2EcsyERPSCc9bvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] clk: Introduce clk_hw_set_spread_spectrum
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Abel Vesa <abelvesa@kernel.org>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Hi Peng,

On Wed, 5 Feb 2025 at 10:51, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Add clk_hw_set_spread_spectrum to configure a clock to enable spread
> spectrum feature. set_spread_spectrum ops is added for clk drivers to
> have their own hardware specific implementation.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for your patch!

> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -84,6 +84,28 @@ struct clk_duty {
>         unsigned int den;
>  };
>
> +/* Aligned with dtschema/schemas/clock/clock.yaml */
> +enum clk_ssc_method {
> +       CLK_SSC_CENTER_SPREAD,
> +       CLK_SSC_UP_SPREAD,
> +       CLK_SSC_DOWN_SPREAD,
> +};
> +
> +/**
> + * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
> + *
> + * @modfreq:           Modulation frequency
> + * @spreadpercent:     Modulation percent

E.g. Renesas R-Car V4M also supports 0.5%, 1.5%, and 2.5%.

> + * @method:            Modulation method
> + * @enable:            Modulation enable or disable
> + */
> +struct clk_spread_spectrum {
> +       unsigned int modfreq;
> +       unsigned int spreaddepth;
> +       enum clk_ssc_method method;
> +       bool enable;

Do you envision a use case for having a separate enable flag?
The alternative would be to add an extra enum value above:

    CLK_SSC_NO_SPREAD = 0,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

