Return-Path: <linux-kernel+bounces-188545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F48CE342
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6558D1F23048
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE585920;
	Fri, 24 May 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AasbsFK8"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5D84D02
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542373; cv=none; b=f4NZJC9sK+yhZGLD6EvuHPk1Swe32jVh41khenGDY7YayOklaZMWMsXbF2vGPyTdaxjbbDFXgZdcDMQD1q1/zcLyFGKN07kyjNOOhRHq0v4IzPVme7enGaIZ5QZP5fLMfNLTz7YmB6Q0oE4WyWG+mAynKHKvyWe5Q3ZZz0HhFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542373; c=relaxed/simple;
	bh=S5WIHfo/GVVFuV2a8N3J3V/bskkP4vgyxo9cxv7VQAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/eUI/+l79cExrA/lQc/S+/V5oswL/jlvPsZj1UyqDhb1uc96a9LH1u5/+XqCRC9sutKcqNInpfcsbp0brfTb6F5ALXAQjobGFrDgvV/an0oggbhFRYBo93P9Hd9CucMe+2t19dpBjUT3hRwvV4FV73QOQE5RnJvC7TNKKXadPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AasbsFK8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-df7607785e9so1389091276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716542369; x=1717147169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFC/Wq6r2ZnocxgGVbxbRurbvlwJyoIDrYIsqw3lJqc=;
        b=AasbsFK8Mt/PBkyaFq4wDhGGCDNTzpxMQ1Mwa29niqtT3epguk2PVIEfb9sc3EadZP
         FklJq+xk0xVWrT4Oc7bdebK+3oHdLd0476OGs+6I9Tl6C+tslihGZZjAA8jurcuO7S0E
         WPvda+m4XLP+XP4E9CGlLt2qTM6nthiWNjd8k4HVi/EnK7Ouf4dywmuElXhqbyHKgqgs
         BUb67NX40RL9ApGWYisP4HvOAocfawqNpguvbSGYvgJerlevu1vlxKAUyD8qsV7wkU0E
         jyrJoiGUNr/PyPc0Dqu6L/MXrvX11cdH3cpGY6Iigvu8GwMDeViM8r3Xf9bF9E8uIvGv
         e7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716542369; x=1717147169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFC/Wq6r2ZnocxgGVbxbRurbvlwJyoIDrYIsqw3lJqc=;
        b=gs0OHz4TdSTygUcWAUs2AI6HaU/TIoTNaITkopRdlLsryWLP7Ow/on6u3Ck+B4kg++
         /CC/EyIffURkInY/D2hxTGQ40A5TB0C4/MIS7AIRUH/WFHKnI5ToGFHTjOxeU8pUSKWs
         7QgK9gvpGLybunPW9S9o91fVz1QV82Jq1lnN893LppRFQuE33wpQF/wAa0As8vjKhRr/
         wvMuMEusm7CnJ/UXjB5NJw6YZPkMyRX+lOh6okejjbsAP57XQHE0Pf7+CTS/3/RuEf4H
         DKhHW4onivzWOSrXII4dwmvQgYbFWnkiAGArBkrt1CGaMVS1VO4diLeEGlA3OwoS14p6
         N7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCW/UXX574iWld6sOVPVLLoEU2xaWBsxB9sDgKIQqzyblNajZ9H12ZiGGxg7PdmD4SON04zoxOI2krIWuX0Mk2reN3QfAzPfYi5fAxn4
X-Gm-Message-State: AOJu0YyNgShhoTYXL6FIikimIKErcQgn+eCqPKBUMbsFrD3XTA6GH3O4
	1ZW3A26+hKi6q8NIYCO1A63TNj8aY3vzMW/iloRE3bMKTkHhtcvIIBNhQ9l6cQXlkrqLSbrinD7
	zrrRcwcATFFRQfqYXpPz9qAPwwJTNfS0+RhFcsg==
X-Google-Smtp-Source: AGHT+IHQOGkX6tTv+H0dG9M4HcslJIDthMVJK/fTaxTSoTTh7UEYLllN3SvzcSDRZhpNnspLGW/VvYGgTEt21HlMSwo=
X-Received: by 2002:a25:adc2:0:b0:df7:695a:1cee with SMTP id
 3f1490d57ef6-df77221c3b5mr1532190276.50.1716542369346; Fri, 24 May 2024
 02:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524035350.3118981-1-quic_mohs@quicinc.com> <865adb41-fd27-d303-5f0f-a68a814f41ab@quicinc.com>
In-Reply-To: <865adb41-fd27-d303-5f0f-a68a814f41ab@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 24 May 2024 12:19:18 +0300
Message-ID: <CAA8EJprDb0fk0G1wrzB99EG=HAm5tw1Mz=mSd5mDMptDOoUb2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for QCM6490 and QCS6490
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_rohkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 07:06, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>
> On 5/24/2024 9:23 AM, Mohammad Rafi Shaik wrote:
> > This patchset adds support for sound card on Qualcomm QCM6490 IDP and
> > QCS6490 RB3Gen2 boards.
>
> Please ignore this abounded patch series. No need for review.

In future please use a logical prefix for the cover letter too. This
helps other developers to understand whether they are interested or
not.

>
> Thanks,
> Rafi.
> >
> > Changes since v1:
> >       - Use existing sc8280xp machine driver instead of separate driver.
> >       - Modify qcs6490 compatible name as qcs6490-rb3gen2.
> >
> > Mohammad Rafi Shaik (2):
> >    ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd QCS6490 sound card
> >    ASoC: qcom: sc8280xp: Add support for QCM6490 and QCS6490
> >
> >   Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
> >   sound/soc/qcom/sc8280xp.c                                | 2 ++
> >   2 files changed, 4 insertions(+)
> >
>
>


-- 
With best wishes
Dmitry

