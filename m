Return-Path: <linux-kernel+bounces-215315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA9909109
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3937C1C219F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293419DF51;
	Fri, 14 Jun 2024 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PH8QfGvY"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807B19E7C9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384749; cv=none; b=unuvTpqdFj5oM2hf7G6S+RZ06HFFlkP2NVMr3V4xD22ChLipA5TZrdT7P7F0ZYXY3f30Hbp/0zgMA2P22/lxIH5RhbsKne0QiBXO5KR0g3YIilgQKxOt7l/INDVj1AHiuk9s68VB9M3Ajv7nB/dngZGXXY/mO/OKwYEMjigpr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384749; c=relaxed/simple;
	bh=8KzlyxUtiQH9n4+dt2WeZEnMMpuBU8HGGEn+yCT/YA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iTgIm+A+aRxt9QrndRaq0eZPSkjVe4h/hfeA9s9Oi1gomScDq9LSjnGFnN3W6L4owFI6yKH5ud1FmFTCY556GJzgwz36mujSMBneKsMGX9+aopRJdXZuCvxWTbiEibY3bMP0Hq0kFAsNGvTBF6Kd0XveoJtG7X3vAaKtnj2BzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PH8QfGvY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f22d3abf1so2191850f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718384746; x=1718989546; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU9Tq2gv3Xr+OOG2Lgc2duprsrRaO/sCpRyvLtLfjWU=;
        b=PH8QfGvYVcHP0ipWc2zOj9zaQFRNiX+g8mHrYoassBdoubZeSv6dgBOHaQz8ddYOtY
         jEVnJczC0QcfQNwmo3HZ0q4ZMzdPxygv+guwzzuyX1WRnVSFQsQzWK4Nqp6KOHJ40J2Y
         qYmP+gjNRIyL+6O1LO0md/duFWNyS7yQKX+SrhU5otMP3kPwbHSW8289Sz6ct8c/nTde
         Q2LK0zvcOUJ7DmE7LDLxqTF4g7DQ61aAQ/HnAhyAsVxGAY3XVbL/yzGqEvJw9lZecFX9
         O0slPWX98fhCLIvlXPPzyRa3NsGlPN5TSXD59wHMM04zMV6+FnjLUhWLJ4DK4/572cLO
         jRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718384746; x=1718989546;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU9Tq2gv3Xr+OOG2Lgc2duprsrRaO/sCpRyvLtLfjWU=;
        b=SEy8A2CLu/qm5vQ04whEfYcNs2Amk6dAVaEqw/7YmHgeYZ8t3N9cdE/roItnlRN/1L
         C9X92F/rsExvcH5s/hWqQ7jROWUN8uBIREsZ4QG0BVLYjHFao3CfH61VYRuWBmXdpbhM
         tv3zqNEBZKfezIREmKMjlbiXED016x+vHTL3fo0gSQbYWE6aLAIopZ+/ahUGaSiFw71v
         iLk+/Hf1g7VyAtmuVNbnTf77fCvFwjoRkZMNzDdf0gYnVWtKFXgnJgctj7P/h98LGbCf
         bi4m0pKNKSYQOACfJQNDy/PnOmFMXlGNC3ghZLTmxkygdbC0nJV57OfvUStrHm5yyue/
         jN8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Vzh2dknYEhiT0fvFjbzMwu1ySG/Wn3qETLvlcq7uhixCaswIljYbw7U6qjO/qN3YguqYBGHSTskJyGRZQaZJzmx0kNsMZxXv8kFb
X-Gm-Message-State: AOJu0YyGABPn9NbukdzJTMSAnhTqP3GlhCLuVNEEG2ee6ZwDv+C9M6FR
	Fuo/P0Agbyd4P43rl1D50Ai6zfx+XJd8tLMfZlBTOiCc3SIpOaw8XnkgJIOhYmc=
X-Google-Smtp-Source: AGHT+IEiODVYEmrk+Rx+CKhFGkqkyheheemcrZvIKgkrbQLv/Jnn/OxMF175J3qFIGVvLOazoNSL1w==
X-Received: by 2002:adf:e2d1:0:b0:360:7c17:5936 with SMTP id ffacd0b85a97d-3607c175a00mr2323310f8f.58.1718384745808;
        Fri, 14 Jun 2024 10:05:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5374:7bd2:13de:845])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f0d71sm4896045f8f.86.2024.06.14.10.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:05:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Kevin Hilman <khilman@baylibre.com>,
  Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
  alsa-devel@alsa-project.org,  linux-sound@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org
Subject: Re: [PATCH RFC 1/3] ASoC: dt-bindings: amlogic,axg-sound-card:
 document clocks and clock-names
In-Reply-To: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-1-9f57d9e01834@linaro.org>
	(Neil Armstrong's message of "Fri, 14 Jun 2024 18:24:01 +0200")
References: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
	<20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-1-9f57d9e01834@linaro.org>
Date: Fri, 14 Jun 2024 19:05:44 +0200
Message-ID: <1j7cerihef.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 14 Jun 2024 at 18:24, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The sound card design is based on 3 reference PLL frequencies that
> are the root of all clock rates calculations.
>
> Today, those 3 frequencies are specified in DT via assigned-clocks,
> because they correspond to the basic audio use-case.
>
> It makes no sense to setup clock rates for a sound card without
> referencing the clocks for the sound card, mainly because at
> some point more complex audio use cases will be supported
> and those root rates would need to change.
>
> To solve this situation, let's legitimize the presence of assigned-clocks
> in the sound card by documenting those clocks, as it describes a true
> dependency of the sound card and paths the way of more complex
> audio uses-cases involving those root frequencies.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> index 5db718e4d0e7..676ff2731b86 100644
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
> @@ -26,6 +26,18 @@ properties:
>        A list off component DAPM widget. Each entry is a pair of strings,
>        the first being the widget type, the second being the widget name
>  
> +  clocks:
> +    maxItems: 3
> +    description:
> +      Base PLL clocks of audio susbsytem, used to configure base clock
> +      frequencies for different audio use-cases.
> +
> +  clock-names:
> +    items:
> +      - const: mpll0
> +      - const: mpll1
> +      - const: mpll2
> +

Thanks a lot for this series. This is going in the right direction
but requiring 3 clocks or naming them (whatever the name) is not
appropriate.

The purpose is for the sound card to get the necessary base rates it
needs for its operation.

So far it has always been 3 clocks because of the 3 usual family rates
and enough PLLs are available. But this is not required. There could be
none (very unlikely but possible if fixed clocks are or with slave setups),
one (probable on a1 from what I can tell), or even more than 3, if one
needs supports for unusual rates.

Also the PLLs are not necessarily the mplls, HiFi PLL is used on some
device. It could even be the GP0 or external slave clocks which is why
putting a limit the number of clocks would be arbitrary.

I think the following would better describe the HW:

clocks: true
assigned-clocks: true
assigned-clock-parents: true
assigned-clock-rates: true

Maybe just 'clocks: true' is enough since the presence of would allow
'assigned-clocks'

For sure, clock-names is not useful, for axg of gx compatible card at least.
All inputs are equal to the card, so index are enough if the card needed
to change rates are runtime (but it is very unlikely to happen, the
whole axg or gx system are meant to operate with fixed PLLs so it would
not be compatible)

>  patternProperties:
>    "^dai-link-[0-9]+$":
>      type: object

PS: I just noticed that my reply to your previous series was private.
    It was not meant to be. Sorry about that.

-- 
Jerome

