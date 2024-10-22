Return-Path: <linux-kernel+bounces-376011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA33E9A9E93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2291C22029
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58B198A01;
	Tue, 22 Oct 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yETrigxZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CF154C19
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589648; cv=none; b=eXFIueyEVgBiMPdFTMk8r6fji7kOBneU+g+CAHT7EOT3HVV4Xk+rBUz3nXpMzJkHvI5TS3Zh3wzHf4/pnzpv592US3d20nnbwFthZJ1rTrwTyWd1BGycza+cGU52JyuzZnKV3WCWk4ARdb7Y8JXszBZCddIoDQjcVULp+NbceL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589648; c=relaxed/simple;
	bh=h6CKw/om6QYoivgiT9OJHWyBVfiX9oyq6x1FY2Omj8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjKyGf+oi4jpXt/QjPS0YECriD7frxGDrOkx0FyvwHDJhDIWqWiOfzo7EsVAfEvUZRh6GWH0eNWprnvDmhvvrmk9LxqlJ7L+Utvibbt8OzYE7PkslsHxuI5LUygWO6jLB8uMajkr5dm+imGLTyaqSz/F64SaOGVoaZccc+K0mxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yETrigxZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2551201f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729589644; x=1730194444; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZycHHif1XK15/J1/2rimbGE/T++GDZJvNYQ0hrutG4=;
        b=yETrigxZYw2fqeGCCAXH79Jrk1N7NUtCfsY5gcmX4v6Kk41rBMMXBp97OUMF29MdVQ
         AFRLxxrnrmL74uOSp1Mzz1BtSTNCUjZ9fIJ1CTXrT9nLUCku1gt9EyW4p11ae90JzmX1
         HoD85xtgzeCOfXiH6uOjKkchlyb9N1Q4fqQiyFPHHPQROlqdCKQf5QK6vwJk974QQtef
         7+G9iGHe7c7/YeZ1l4zJE2Lw7qzVoZp/ESGf3Cdk38UA1d/PWZ5NMDC4LPFGn4+ss3z+
         EX+LeeOXkp+t6KUSHt+y4wi2zeFrNs9LK3apdOh2zGse7nJ6LZA9B80veyBwFSzGsJar
         UfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729589644; x=1730194444;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZycHHif1XK15/J1/2rimbGE/T++GDZJvNYQ0hrutG4=;
        b=Oavi33ofUDpYa500QO0N8GwJsb1s+ht3cGSKSvSKZ8ofbCZP6r4AcnxpbJcCkohY2i
         8f9JUjn8FVc4bKhNiR13rlLfB0ej2JYvM2y+hNDPPQoxBiwiNIGNzrVvCeAf4zIrK7J3
         T8Fqp/IU7as27Hh6UbBs+dLTq4fDmq77qEk8DiJZvEvsPLhMym8ntJMAg/1F5ww+ZP5u
         nu7zknRVi2xUdldiKd5M1pFbFz7Z2FX+GYBlhZ2eFBUHOhmR93eBJhYgsiBiJwV+SgpR
         73JS1HvCP7R1bwH2eTOTuJV0RU1j+RYL7r7LpmPB69IDllEUHHCJoQWu+E6ICh0VeOeF
         4ctQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ/F8yNvH7nG37Ux96rnmWwTWKN5shCEn3VfUZDDDqlKpSPibljO/KP7Qmy+Hmtaer3q23oPJo6OPyqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2p/FMb1Q5+xfDa5gTERLXGKIhp0Bg/o2+JDr75wYoZgkn7lXz
	fpwsCLWFQkoUp5mwBqIDBRWKo+8L+72GEhLtV2G0bamCP2Ue0VMXfImRjrD4QPQ=
X-Google-Smtp-Source: AGHT+IF2AI9bQIr0tGScY7Bv5vlVywZpblspYP/H+5e4xTqZiXyoU9NwrHtaw3F1qCz0C5DcMMgfnA==
X-Received: by 2002:adf:f744:0:b0:37d:5103:8896 with SMTP id ffacd0b85a97d-37eab4ed1ddmr8572359f8f.41.1729589643781;
        Tue, 22 Oct 2024 02:34:03 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ef1c:ae40:1300:20c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37d25sm6220808f8f.23.2024.10.22.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:34:03 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>,  <devicetree@vger.kernel.org>,
  Kevin Hilman <khilman@baylibre.com>,  "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Philipp Zabel <p.zabel@pengutronix.de>,  Rob Herring <robh@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v4 3/5] dt-bindings: clock: axg-audio: document A1
 SoC audio clock controller driver
In-Reply-To: <20240913121152.817575-4-jan.dakinevich@salutedevices.com> (Jan
	Dakinevich's message of "Fri, 13 Sep 2024 15:11:50 +0300")
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
	<20240913121152.817575-4-jan.dakinevich@salutedevices.com>
Date: Tue, 22 Oct 2024 11:34:02 +0200
Message-ID: <1jzfmwjxbp.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> Add device tree bindings for A1 SoC audio clock and reset controllers.
>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++++++++++++++
>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 +++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> index fd7982dd4cea..df9eb8ce28dc 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
> @@ -18,6 +18,8 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - amlogic,a1-audio-clkc

This controller is missing aud_top clock input coming from the vad
controller, AFAICT.

> +      - amlogic,a1-audio-vad-clkc
>        - amlogic,axg-audio-clkc
>        - amlogic,g12a-audio-clkc
>        - amlogic,sm1-audio-clkc
> @@ -114,6 +116,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - amlogic,a1-audio-clkc
>                - amlogic,g12a-audio-clkc
>                - amlogic,sm1-audio-clkc
>      then:
> diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> new file mode 100644
> index 000000000000..6534d1878816
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#ifndef __A1_AUDIO_CLKC_BINDINGS_H
> +#define __A1_AUDIO_CLKC_BINDINGS_H
> +
> +#define AUD_CLKID_DDR_ARB		1
> +#define AUD_CLKID_TDMIN_A		2
> +#define AUD_CLKID_TDMIN_B		3
> +#define AUD_CLKID_TDMIN_LB		4
> +#define AUD_CLKID_LOOPBACK		5
> +#define AUD_CLKID_TDMOUT_A		6
> +#define AUD_CLKID_TDMOUT_B		7
> +#define AUD_CLKID_FRDDR_A		8
> +#define AUD_CLKID_FRDDR_B		9
> +#define AUD_CLKID_TODDR_A		10
> +#define AUD_CLKID_TODDR_B		11
> +#define AUD_CLKID_SPDIFIN		12
> +#define AUD_CLKID_RESAMPLE		13
> +#define AUD_CLKID_EQDRC			14
> +#define AUD_CLKID_LOCKER		15
> +#define AUD_CLKID_MST_A_MCLK_SEL	16
> +#define AUD_CLKID_MST_A_MCLK_DIV	17
> +#define AUD_CLKID_MST_A_MCLK		18
> +#define AUD_CLKID_MST_B_MCLK_SEL	19
> +#define AUD_CLKID_MST_B_MCLK_DIV	20
> +#define AUD_CLKID_MST_B_MCLK		21
> +#define AUD_CLKID_MST_C_MCLK_SEL	22
> +#define AUD_CLKID_MST_C_MCLK_DIV	23
> +#define AUD_CLKID_MST_C_MCLK		24
> +#define AUD_CLKID_MST_D_MCLK_SEL	25
> +#define AUD_CLKID_MST_D_MCLK_DIV	26
> +#define AUD_CLKID_MST_D_MCLK		27
> +#define AUD_CLKID_SPDIFIN_CLK_SEL	28
> +#define AUD_CLKID_SPDIFIN_CLK_DIV	29
> +#define AUD_CLKID_SPDIFIN_CLK		30
> +#define AUD_CLKID_RESAMPLE_CLK_SEL	31
> +#define AUD_CLKID_RESAMPLE_CLK_DIV	32
> +#define AUD_CLKID_RESAMPLE_CLK		33
> +#define AUD_CLKID_LOCKER_IN_CLK_SEL	34
> +#define AUD_CLKID_LOCKER_IN_CLK_DIV	35
> +#define AUD_CLKID_LOCKER_IN_CLK		36
> +#define AUD_CLKID_LOCKER_OUT_CLK_SEL	37
> +#define AUD_CLKID_LOCKER_OUT_CLK_DIV	38
> +#define AUD_CLKID_LOCKER_OUT_CLK	39
> +#define AUD_CLKID_EQDRC_CLK_SEL		40
> +#define AUD_CLKID_EQDRC_CLK_DIV		41
> +#define AUD_CLKID_EQDRC_CLK		42
> +#define AUD_CLKID_MST_A_SCLK_PRE_EN	43
> +#define AUD_CLKID_MST_A_SCLK_DIV	44
> +#define AUD_CLKID_MST_A_SCLK_POST_EN	45
> +#define AUD_CLKID_MST_A_SCLK		46
> +#define AUD_CLKID_MST_B_SCLK_PRE_EN	47
> +#define AUD_CLKID_MST_B_SCLK_DIV	48
> +#define AUD_CLKID_MST_B_SCLK_POST_EN	49
> +#define AUD_CLKID_MST_B_SCLK		50
> +#define AUD_CLKID_MST_C_SCLK_PRE_EN	51
> +#define AUD_CLKID_MST_C_SCLK_DIV	52
> +#define AUD_CLKID_MST_C_SCLK_POST_EN	53
> +#define AUD_CLKID_MST_C_SCLK		54
> +#define AUD_CLKID_MST_D_SCLK_PRE_EN	55
> +#define AUD_CLKID_MST_D_SCLK_DIV	56
> +#define AUD_CLKID_MST_D_SCLK_POST_EN	57
> +#define AUD_CLKID_MST_D_SCLK		58
> +#define AUD_CLKID_MST_A_LRCLK_DIV	59
> +#define AUD_CLKID_MST_A_LRCLK		60
> +#define AUD_CLKID_MST_B_LRCLK_DIV	61
> +#define AUD_CLKID_MST_B_LRCLK		62
> +#define AUD_CLKID_MST_C_LRCLK_DIV	63
> +#define AUD_CLKID_MST_C_LRCLK		64
> +#define AUD_CLKID_MST_D_LRCLK_DIV	65
> +#define AUD_CLKID_MST_D_LRCLK		66
> +#define AUD_CLKID_TDMIN_A_SCLK_SEL	67
> +#define AUD_CLKID_TDMIN_A_SCLK_PRE_EN	68
> +#define AUD_CLKID_TDMIN_A_SCLK_POST_EN	69
> +#define AUD_CLKID_TDMIN_A_SCLK		70
> +#define AUD_CLKID_TDMIN_A_LRCLK		71
> +#define AUD_CLKID_TDMIN_B_SCLK_SEL	72
> +#define AUD_CLKID_TDMIN_B_SCLK_PRE_EN	73
> +#define AUD_CLKID_TDMIN_B_SCLK_POST_EN	74
> +#define AUD_CLKID_TDMIN_B_SCLK		75
> +#define AUD_CLKID_TDMIN_B_LRCLK		76
> +#define AUD_CLKID_TDMIN_LB_SCLK_SEL	77
> +#define AUD_CLKID_TDMIN_LB_SCLK_PRE_EN	78
> +#define AUD_CLKID_TDMIN_LB_SCLK_POST_EN	79
> +#define AUD_CLKID_TDMIN_LB_SCLK		80
> +#define AUD_CLKID_TDMIN_LB_LRCLK	81
> +#define AUD_CLKID_TDMOUT_A_SCLK_SEL	82
> +#define AUD_CLKID_TDMOUT_A_SCLK_PRE_EN	83
> +#define AUD_CLKID_TDMOUT_A_SCLK_POST_EN	84
> +#define AUD_CLKID_TDMOUT_A_SCLK		85
> +#define AUD_CLKID_TDMOUT_A_LRCLK	86
> +#define AUD_CLKID_TDMOUT_B_SCLK_SEL	87
> +#define AUD_CLKID_TDMOUT_B_SCLK_PRE_EN	88
> +#define AUD_CLKID_TDMOUT_B_SCLK_POST_EN	89
> +#define AUD_CLKID_TDMOUT_B_SCLK		90
> +#define AUD_CLKID_TDMOUT_B_LRCLK	91
> +
> +#define AUD_CLKID_VAD_DDR_ARB		1
> +#define AUD_CLKID_VAD_PDM		2
> +#define AUD_CLKID_VAD_TDMIN		3
> +#define AUD_CLKID_VAD_TODDR		4
> +#define AUD_CLKID_VAD			5
> +#define AUD_CLKID_VAD_AUDIOTOP		6
> +#define AUD_CLKID_VAD_MCLK_SEL		7
> +#define AUD_CLKID_VAD_MCLK_DIV		8
> +#define AUD_CLKID_VAD_MCLK		9
> +#define AUD_CLKID_VAD_CLK_SEL		10
> +#define AUD_CLKID_VAD_CLK_DIV		11
> +#define AUD_CLKID_VAD_CLK		12
> +#define AUD_CLKID_VAD_PDM_DCLK_SEL	13
> +#define AUD_CLKID_VAD_PDM_DCLK_DIV	14
> +#define AUD_CLKID_VAD_PDM_DCLK		15
> +#define AUD_CLKID_VAD_PDM_SYSCLK_SEL	16
> +#define AUD_CLKID_VAD_PDM_SYSCLK_DIV	17
> +#define AUD_CLKID_VAD_PDM_SYSCLK	18
> +
> +#endif /* __A1_AUDIO_CLKC_BINDINGS_H */
> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> new file mode 100644
> index 000000000000..653fddba1d8f
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
> +
> +#define AUD_RESET_DDRARB	0
> +#define AUD_RESET_TDMIN_A	1
> +#define AUD_RESET_TDMIN_B	2
> +#define AUD_RESET_TDMIN_LB	3
> +#define AUD_RESET_LOOPBACK	4
> +#define AUD_RESET_TDMOUT_A	5
> +#define AUD_RESET_TDMOUT_B	6
> +#define AUD_RESET_FRDDR_A	7
> +#define AUD_RESET_FRDDR_B	8
> +#define AUD_RESET_TODDR_A	9
> +#define AUD_RESET_TODDR_B	10
> +#define AUD_RESET_SPDIFIN	11
> +#define AUD_RESET_RESAMPLE	12
> +#define AUD_RESET_EQDRC		13
> +#define AUD_RESET_LOCKER	14
> +#define AUD_RESET_TOACODEC	30
> +#define AUD_RESET_CLKTREE	31
> +
> +#endif /* _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H */

-- 
Jerome

