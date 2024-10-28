Return-Path: <linux-kernel+bounces-384799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E59B2E95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD421C215BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE81D416E;
	Mon, 28 Oct 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jVNNxM6+"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15D1D5171
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113872; cv=none; b=Dking/orCqw1UCYhuyer8Ktvcv2m0UCCJr4MRmnKrXbxBi8imtNSlXHhLIMigSejD5POCIZwXtLeYUwC70wuw8Fubcil0q4ZcPBYyshoqWum2m8KOKyPd5mL2ce9si1eCVt0I/Ibhuv96kBNPSJ1A2qxS/ubNkIz3TNeztJCwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113872; c=relaxed/simple;
	bh=ZgTV9zpZbKQQXLQ5wQfQWN0K4yKV8OzqkCwsGVG8/BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbIksoO0moWd4ogWYx/Tk0FPR0d6334K9Zb4v989iP4soLoH0BG7KkAlwcSaRkEot+Tw0+OZZtO+3r7jtkgZl9sof93hMhtYVqbhFhCeEJK2pwcmvth9t/oavBxnd5RF4i74UdZNc9pQFTl2rzN8oZ94AsnNXcbaJf4WWEqE1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jVNNxM6+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d32d82bd8so996685e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730113867; x=1730718667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVZy5IrMKfr30Sb+HXmGpWXo6EuG4COK1gDvgq9aZn8=;
        b=jVNNxM6+gyx8R8uUeXABZTmRx1Nr1e+EbD4QAVL6vo65ks5SGf2YRGl83/HIi3e9qk
         nhBkcPYRKvb121HeFy8c2JQG0ToZVEU6Hsx+YAcy+4KIb/oWxHr2TP6YWu3b+AZpfS6A
         kA0afJs7eesfYIlmXiZi/Hd+JHXu+UVDCUEqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113867; x=1730718667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVZy5IrMKfr30Sb+HXmGpWXo6EuG4COK1gDvgq9aZn8=;
        b=LruRz/oerEYpuQAhdWAmdQBxlsXxMDTL9BLwoW9YHdfG1tpiSsGC63igNDOo6QFG62
         w6ILhsmU0muYS2X0/4TE4/511KZvsKO+stnkFFcH1tdXWOAfy7dMuuGrVL+Zgi+JIxhK
         cITzdkbtRqE8kt+TVxyEdRcZJocy7ecg/9H9G7bbKwHe5YUqr9sG53FnKKIs/NfHw1Jg
         PfVLvB7sXnqdGoNTjEgHH2k2WlenJCTeXOJKWYUP6JIU2Zt5tmdtrG3zYx6HSwFduYMr
         eZZ8fpgBzv89vG9dwjpZqmwU7p7b5aM4HtE3VsibgNMpdi0/QibP9pfCwRLnu7I7bBfu
         Yp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9CBdY5jgZoiIbMLoOY1ZiKwny0V9br721lr/iZZOjRnIycOF3Ckh2kCP00EjDnacirpekhHrTtm/9zUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbGI4DzPCLUwnjlP96VEMgpYbByqWD4RZUZqdy357hLaFvXtI
	VXIF3ja+erXd7drClkntw7+byQ1KnYqKeqKglZBBXQu98GDm0zSO2PlBfKGNurYscrzx2y08dk8
	=
X-Google-Smtp-Source: AGHT+IF8BpwhdgOXsSdeZxb6yrYhxgK8xl5qcu2lXMcJyFZrNL/vtP/+p2yJoKHv0PicZgGvxesoYA==
X-Received: by 2002:a05:6122:3196:b0:50d:3ec1:154b with SMTP id 71dfb90a1353d-51014ff8598mr4082217e0c.3.1730113866707;
        Mon, 28 Oct 2024 04:11:06 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-510048c4ed2sm827768e0c.54.2024.10.28.04.11.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:11:04 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-84fc0209e87so1059665241.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCMRw2cuVSLU1bWNYBSpVYFrEs6+eFUURdnPr3R6yWBYUm8UlLGm7ttYQn7IcEa6hnv++8XdPZwDad/ZE=@vger.kernel.org
X-Received: by 2002:a05:6122:3d01:b0:50d:99e4:dea6 with SMTP id
 71dfb90a1353d-51015055166mr3900796e0c.7.1730113863969; Mon, 28 Oct 2024
 04:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025104548.1220076-1-fshao@chromium.org> <20241025104548.1220076-2-fshao@chromium.org>
 <5vmfh2nkxtpzt2vk4j6ghro7z5stoyvry3enzoqepg6hjxqrho@fofs5cwa2iqq>
In-Reply-To: <5vmfh2nkxtpzt2vk4j6ghro7z5stoyvry3enzoqepg6hjxqrho@fofs5cwa2iqq>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 28 Oct 2024 19:10:27 +0800
X-Gmail-Original-Message-ID: <CAC=S1njPjtvhsc+voNK447wbQmRiN0xVDi-jgOmba4NLRiNi0Q@mail.gmail.com>
Message-ID: <CAC=S1njPjtvhsc+voNK447wbQmRiN0xVDi-jgOmba4NLRiNi0Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add adsp
 and dai-link properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:54=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 25, 2024 at 06:44:41PM +0800, Fei Shao wrote:
> > Add "mediatek,adsp" property for the ADSP handle if ADSP is enabled on
> > the platform.
>
> We see this from the diff.
>
> > Add "mediatek,dai-link" property for the required DAI links to configur=
e
> > sound card.
>
> We see this from the diff.
>
> >
> > Both properties are commonly used in the MediaTek sound card driver.
>
> If they are used, why suddenly they are needed? What changed?

Nothing has changed. These should have been added altogether when the
binding was first introduced. This patch is to fill the gaps and fix
dtbs_check warnings, like I mentioned in the cover letter.
I can add a line in the commit message saying it's to fix the warning
in addition to the cover letter, if that's preferred.

>
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  .../bindings/sound/mediatek,mt8188-mt6359.yaml         | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt=
6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.=
yaml
> > index f94ad0715e32..701cedfa38d2 100644
> > --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.ya=
ml
> > +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.ya=
ml
> > @@ -29,6 +29,16 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description: The phandle of MT8188 ASoC platform.
> >
> > +  mediatek,adsp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of MT8188 ADSP platform.
>
> And what is the difference between ASoC and ADSP platforms? What are
> they used for?

I'm not a MediaTek or audio folks, and I'm afraid that I'm not the
best person to explain the details accurately in front of experts on
the list... I know it's an audio DSP but that explains nothing.
MediaTek didn't provide a meaningful explanation in the tree or
commits, and I want to avoid adding additional but likely misleading
descriptions from someone who doesn't have enough knowledge,
potentially causing even more confusing situations in the future.
Plus, the same changes were accepted as-is in the past, so I assumed
they might be self-explanatory to people who are familiar with the
matter.

>
> > +
> > +  mediatek,dai-link:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description:
> > +      A list of the desired dai-links in the sound card. Each entry is=
 a
> > +      name defined in the machine driver.
>
> The list is provided below. I don't understand why do you need it. Your
> msg is pretty useless - you describe what you do, instead of why.

I think this is used to explicitly list the intermediate but hidden
DAIs, but again, there's not much info about them unless MediaTek can
explain more details and why they need a vendor property for this.

Regards,
Fei

>
> Best regards,
> Krzysztof
>

