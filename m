Return-Path: <linux-kernel+bounces-442240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D22A9ED9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F8D161837
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB971F2375;
	Wed, 11 Dec 2024 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g25QaZNV"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF31F0E59
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956060; cv=none; b=dXIuF4mKs2WLxUIZx/7TSOz2+7l9/Z1q9kUTzJKdj8vLt/avbsbg+YrfSBw7KKKzIWOI44zl1h6FmMsM48Fg0NTuncjQPZ8wyhlZtIMo45PAxqyMYGnpC0L5bzrlVbKv6xlJeO6eQEGcKF/LElv0O2TFVZql8gC6jlWICUAohWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956060; c=relaxed/simple;
	bh=CxczlAVJ2KXIHFoak56IOVnj4UTzCb1FwfYB8pYAXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzTwHWm0iK1u3AxAMDrj/gT8Tw2+CH9IUgISyrCvFbVERs8UWkCuBBkptZGM+51Yx0WtqxcZ9kfBKL/oKyqifat/IRPS2g9nkAxaeqevueYJW4XJKehjxtTVCAn/PjJ/Bm1zZdNdV9anROL4YnWtycd/HJkOHI3g+p56tx8N5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g25QaZNV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-300392cc4caso49798161fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733956056; x=1734560856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OP5yTlQX9Qcr5Sy7oqm3jVaqriEDKIPmmSAXtfhzrP8=;
        b=g25QaZNVdLsi49hDDiQ8E7JV55EgTicKHuTYYH6lkrZFKd2ce8yPqbz+i/6yNX6QJd
         2xc3ubIZzfMdQ3qXza9FJbFo9XKQ2NISV20jH5RR5TZ/sMfU2zxHvHwRAiTtHViIYhmw
         j041ffngNuD+E15ZcolLVvr4QKNCF/sSkUStk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956056; x=1734560856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OP5yTlQX9Qcr5Sy7oqm3jVaqriEDKIPmmSAXtfhzrP8=;
        b=Cng2pnjFqCzjI5q+vPBgmOIVEKdR8LkS+YVHbVd92tDLhSHy6d6b+MxhjKGJAw59y0
         EseF+MlQDYpHIz6ANpaTEWi5oU9N29WvLQsgE2mH0uBzoVWkITDLAh5iFYR2HCeQq9Zq
         wufyGFtL9nHZfeKNzFBo/Z/4UsejKd/7QpaAOVj//cD/k463Y/Gwoi+CepRk6g9h/MrK
         VhXIpn5pGYxb3cLdF79uDCtDD5RiLqpln7L8GZWX0ZJtbwY0frsczET1ZLcdmciYeBGC
         okYgcm0+MA77My94gAUfDq3+J5VJCvh8mCkelw20lx3Xinug8wRGRU/r3g110YRF0BMd
         cM2g==
X-Forwarded-Encrypted: i=1; AJvYcCUij8cM9REPq7zGY6Kic6LcsfMIhK4O1m1OFhihL37raQKxd2UzfpAHutXlLbcQaXDvBYWKWLb0uICMEAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzld25/rH6tykcOAWCvAoZVkIFi38FKczhZ3uvVIaH04ILdCYeF
	auceuK+bBIo9cAZjNUKrTlCy+A8wHooPJ7dzsEPAJ4KVimkcPtQK5N/sBYDDOCRDJVVl17UuQNV
	E9g==
X-Gm-Gg: ASbGncsBDUJo9Jf98lQLXxNdOWV7P7B6onguZzFt3CGjrrN0UQ8B9mwM/8YEByirHai
	JCxiDoHH04YPgCfLO9sLfbrF0PrT2Ejbisqtdo8JGZY8kV+5ej7F93MB+Rx93uwh1isiTvy2CxM
	9reXF1OA1Q7VCprNOwuYt0GxDPmaZ6MdmAEkVVngh3UrraoELESzcewie0PjFD9c/NOqJNFSyId
	7G9tBw1w0NGru5OMHVuaBX+lYsdRPY6Aa/MWref/T8/3CJvtadWzn1edP963U+I+6Nvfcd28Al6
	PWTISDiwVY4a9eTdGQ7vNQ==
X-Google-Smtp-Source: AGHT+IH68iFYlkXwNxogz6r5CAUiLxBHsT3AYFt4HU87xFXKTG3ChA3WNnuNb0hwHn74mQ7zNliGSA==
X-Received: by 2002:a2e:a904:0:b0:2fb:5688:55c0 with SMTP id 38308e7fff4ca-30249ea74efmr3674031fa.38.1733956055722;
        Wed, 11 Dec 2024 14:27:35 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3022cd2c336sm8320601fa.23.2024.12.11.14.27.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 14:27:35 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3003e203acaso43171611fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMkFFlDx2d58g97lmZZDQ7GAp0Ec8G4E5Hpjm5itl0kf8VmizXNXf1I3hn4vqWUj6vvzD8ztfPJpUYChs=@vger.kernel.org
X-Received: by 2002:a05:651c:210c:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-30249e00c59mr4195391fa.2.1733956053624; Wed, 11 Dec 2024
 14:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com> <CAD=FV=XF+9wxZ5xNtO3Uy8QW9UY4tb+KR46jkondvBeQuVLsrA@mail.gmail.com>
 <6736db20-127b-45c3-ac90-3e3e359c343b@quicinc.com> <CAD=FV=VReNQ3nw+wfZizL7JjxEX9z=GwDEJAFzheNkW7rSrB5Q@mail.gmail.com>
 <65ded632-963a-4bfd-906c-1b09e916b5e0@quicinc.com>
In-Reply-To: <65ded632-963a-4bfd-906c-1b09e916b5e0@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 11 Dec 2024 14:27:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrXegUW7n0e5Lp6AMN9u492Rn1yFXCOzGRbs36VeKrMA@mail.gmail.com>
X-Gm-Features: AZHOrDnd4yPKzZ7z0r-DDC60k0pmk_2L5RUUePsjv7ZkRWOmo6qWozIHPBzjPco
Message-ID: <CAD=FV=WrXegUW7n0e5Lp6AMN9u492Rn1yFXCOzGRbs36VeKrMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_anupkulk@quicinc.com, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2024 at 9:27=E2=80=AFPM Viken Dadhaniya
<quic_vdadhani@quicinc.com> wrote:
>
> On 12/10/2024 11:12 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Dec 9, 2024 at 9:28=E2=80=AFPM Viken Dadhaniya
> > <quic_vdadhani@quicinc.com> wrote:
> >>
> >> On 12/4/2024 10:55 PM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Wed, Dec 4, 2024 at 7:03=E2=80=AFAM Viken Dadhaniya
> >>> <quic_vdadhani@quicinc.com> wrote:
> >>>>
> >>>> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> >>>> support SE(Serial Engine) firmware loading from the protocol driver =
and to
> >>>> select the data transfer mode, either GPI DMA (Generic Packet Interf=
ace)
> >>>> or non-GPI mode (PIO/CPU DMA).
> >>>>
> >>>> I2C controller can operate in one of two modes based on the
> >>>> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> >>>>
> >>>> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> >>>> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> >>>> ---
> >>>>    .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 ++++++=
+++++
> >>>>    1 file changed, 11 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qco=
m.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> index 9f66a3bb1f80..a26f34fce1bb 100644
> >>>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> >>>> @@ -66,6 +66,15 @@ properties:
> >>>>      required-opps:
> >>>>        maxItems: 1
> >>>>
> >>>> +  qcom,load-firmware:
> >>>> +    type: boolean
> >>>> +    description: Optional property to load SE (serial engine) Firmw=
are from protocol driver.
> >>>> +
> >>>> +  qcom,xfer-mode:
> >>>> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI D=
MA mode respectively.
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    enum: [1, 2, 3]
> >>>
> >>> I'm a little confused about this. I'll admit I haven't fully analyzed
> >>> your patch with actual code in it, but in the past "CPU DMA" mode and
> >>> "FIFO" mode were compatible with each other and then it was up to the
> >>> driver to decide which of the two modes made sense in any given
> >>> situation. For instance, last I looked at the i2c driver it tried to
> >>> use DMA for large transfers and FIFO for small transfers. The SPI
> >>> driver also has some cases where it will use DMA mode and then
> >>> fallback to FIFO mode.
> >>>
> >>> ...so what exactly is the point of differentiating between "FIFO" and
> >>> "CPU DMA" mode here?
> >>
> >> Yes, correct, Will update in V2.
> >> I plan to add 2 modes, GSI and non-GSI(PIO or DMA based on length).
> >>
> >>>
> >>> Then when it comes to "GSI DMA" mode, my understanding is that the
> >>> firmware for "GSI DMA" mode is always loaded by Trustzone because the
> >>> whole point is that the GSI mode arbitrates between multiple clients.
> >>> Presumably if the firmware already loaded the GSI firmware then the
> >>> code would just detect that case. ...so there shouldn't need to be an=
y
> >>> reason to specify GSI mode here either, right?
> >>>
> >>> -Doug
> >>
> >> GSI firmware is loaded from TZ per QUP, but to use GSI mode,
> >> we need to configure the SE to use GSI mode by writing into SE registe=
r
> >> QUPV3_SE_GENI_DMA_MODE_EN and SE_GSI_EVENT_EN. This register is
> >> used to configure data transfer mode for Serial Engine.
> >
> > Can't you detect it's in GSI mode without any device tree property
> > like the code does today?
> >
> > -Doug
>
> No, we can't detect GSI mode in the current design. The GSI firmware is
> loaded from the TZ side, while mode selection occurs on the APPS side
> based on the Device Tree property.

Presumably you can check to see if the geni firmware has already been
loaded before the kernel started, right? In the case that it's already
loaded, can't you fall back to the way that existing code detects GSI
mode? From reading `drivers/spi/spi-geni-qcom.c` I see that if the
FIFO is disabled then it assumes we must be in GSI mode...
Specifically, it checks:

readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;

The i2c code today (`drivers/i2c/busses/i2c-qcom-geni.c`) does the same.

So, essentially:

* If geni firmware has already been loaded, then check
FIFO_IF_DISABLE. If the FIFO is disabled it's GSI. If not then both
"CPU DMA" and "FIFO" are allowed.

* If geni firmware hasn't already been loaded then it's impossible to
be in GSI mode since GSI only makes sense if the geni firmware was
loaded before the kernel started. Thus we're in "CPU DMA" / "FIFO"
mode.

In both cases you don't need an attribute telling you whether to use
GSI mode or not, right?

-Doug

