Return-Path: <linux-kernel+bounces-217011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6A90AAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E108FB2A025
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF9B193062;
	Mon, 17 Jun 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="cMEnLm7d"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AA1922EF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616842; cv=none; b=MlXuQmk4Bmpv0GWWP9hVWnia2HB5gVtkhBwHNeIUo29/2JENHTjARxafptX8W5mobZZIwaCNbJEF5GH8JBA5n1z9c5L8FnyXvdd8pgxCqVhJrs1J5aPjxYNS2f9JHnasZI37Rf85agDHOVQlgANJENJjXce7hNNykeW3xW5+tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616842; c=relaxed/simple;
	bh=7NSvCXohwZLOOlJWIUDNVZNNLgZsT49wKsS05NVWjKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5Yxq8PPckHK92F9YarSehCdlpu3DC9SCoyS0JFYJImmfxDBGV4WWQhh75H4c+uczPuWaap/HsVuy0E6jy5ku1Um/oxzbo3Y//qNJk+vdmg8QIjI/DLd5un0jEQnb2TGLw3cWjglyYBzWHRsR3QSZ6OjBfC9gJyiP/bhHKPHMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=cMEnLm7d; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7979198531fso308852685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718616838; x=1719221638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dwjk23maxDbhwXR6knY3QoiO7g9DUPuAbXWMaxi9WAo=;
        b=cMEnLm7d6rQXhTRW5L2AZ7V5TKBCztTO8KfFVrdF/clZ8fsAx8wMA56OQAuSsJ1GTf
         S1SlRlKjbU+mBs4ArY0kAghfr/raUNz/EQUTYSnYCgLqrnK9wjzV1AYbXrK+ObCTk6fA
         IfRq/QPSJL1GEPInW4UtjBDtHndx1u1LDWOv8cbgftXz/esjc8ArW7MxPVoIg+zvxKyu
         yJ1Ub9KUiPflSMCCRcFIL23KY4GJqkl9pvpANkSTXLiRIZKrJ0udfrUBJI/UHMtpnDnK
         zyoBFWhiOTFAVeUylZ6R6THjQfF7RydR0aR1Apu/Lhn1XOat0LPYPx/gmUCw4pqc6Xio
         RY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616838; x=1719221638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dwjk23maxDbhwXR6knY3QoiO7g9DUPuAbXWMaxi9WAo=;
        b=uO/VNM8uz8SPa8KuO/7mbszAUc13l1P692mu619YuRXTeKqswCFOdnFe+OqfW+0H81
         bGmctpn3T+4Dkyd671/pvI8wbqYjwv9FRSI3jJ75j13yrbVfgOLV7ornQkCOcmcL7pBe
         jk0ffwa4fsA9yPHOyKzwc26zMtRRkS41w6pwv5Sh8jU3Gc+Rbfw5vhR+dmEwCrYZBA7h
         0w73UrxR9Az3g6obHOHxOH3NCNPGV0X1CrHefo90TnUuBHVyPCDDGlDC7EpJaqVvm19U
         N636p1tDhqUvFJ+BFGM2Iw/rXSM2bA2bU6lv/ZEcrg+8Dd/Emdk2ztBwBHckELsWdE8s
         s9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+//73/j9Mv/XaH3ao0fZACyYPEzsOH0eHwoOaSHDDw2s+iV+6ycaxGAJ4wNZxaUVPZwsVpQuZqKZvzV7rd5VjScJzfpyX9i49LI56
X-Gm-Message-State: AOJu0YxooKA761JjRuItMB1U++S01f5yT2/2Da4x2zRX4Pjvofkx9nvd
	i3+U7ZHjUGop01w8PPo/xFrnIXPMsw7rRh7fAJvmjHWGYlmNvfsD0LiXuWN/fDZesWCMIR+3oY6
	xdrOa867Kow1iAgjlPRRbCkVK79reJYwtELzFdA==
X-Google-Smtp-Source: AGHT+IEAX5KtNwSxz024jCUDuTs+t2XcQ1Uu/1Qu8JcsorpEu10yK9me2YfmiTGJCyrzuk8/c2n+Pk4pb6M+8oQC+gs=
X-Received: by 2002:a0c:fbc2:0:b0:6b2:9c0d:4849 with SMTP id
 6a1803df08f44-6b2afb7bb5cmr87920016d6.0.1718616838197; Mon, 17 Jun 2024
 02:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
 <20240614163500.386747-1-piotr.wojtaszczyk@timesys.com> <20240614163500.386747-2-piotr.wojtaszczyk@timesys.com>
 <83cbf43e-c927-449f-8b7e-5c8d3ee8cece@kernel.org>
In-Reply-To: <83cbf43e-c927-449f-8b7e-5c8d3ee8cece@kernel.org>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Mon, 17 Jun 2024 11:33:47 +0200
Message-ID: <CAG+cZ06EeXUDiLsDXkz+6EHqJwpvv2MWwfpvB8AYw0=ZhUkTfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, "J.M.B. Downing" <jonathan.downing@nautel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 12:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.

I'm sorry about that, it won't happen again.

> > +  dma-vc-names:
>
> Missing vendor prefix... but I don't really get what's the point of this
> property.

Is "nxp,lpc3xxx-dma-vc-names" acceptable?

>
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description: |
> > +      names of virtual pl08x dma channels for tx and rx
> > +      directions in this order.
> > +    minItems: 2
> > +    maxItems: 2
>
> What part of hardware or board configuration this represents?
>
> It wasn't here and nothing in changelog explained it.

That's information which DMA signal and mux setting an I2S interface uses.
It's a name (bus_id field) of platform data entry from phy3250.c in
[PATCH v3 3/4].
It's used by snd_soc_dai_init_dma_data() in [PATCH v3 4/4] to give the
dmaengine a
hint which dma config to use. The LPC32xx doesn't have yet a dmamux driver =
like
lpc18xx-dmamux.c therefore it still uses platform data entries for
pl08x dma channels
and 'SND_DMAENGINE_PCM_FLAG_NO_DT | SND_DMAENGINE_PCM_FLAG_COMPAT'
flags in the devm_snd_dmaengine_pcm_register().
Typically instead of this platform data you would use regular 'dma'
and 'dma-names' if it had
proper dmamux driver like lpc18xx-dmamux.c

>
> Drop.
>
>
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +

The "dai-common.yam" doesn't declare a default value for this so
isn't it required? It's declared in others yaml files like:
Documentation/devicetree/bindings/sound/qcom,q6apm.yaml


--
Piotr Wojtaszczyk
Timesys

