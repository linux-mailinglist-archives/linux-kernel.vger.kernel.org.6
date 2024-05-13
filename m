Return-Path: <linux-kernel+bounces-177768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D28C4468
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586CDB2130F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31715443A;
	Mon, 13 May 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US5XeI47"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E8153BEE;
	Mon, 13 May 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614701; cv=none; b=VVQ6Eoew9VX/+Xtv/x/YonDiAkoVCRgt5qkGjaECz3kaU7BGRKiS3qBHpx7WuXkI1ydIulmagbl3y3BmANcUT3MXQaE+COPIow8q4axrscEs2cffTTaldDG3I3E39jGriB7hNZE35qPFxuwwZRY+RFNtGEINWKxd5ClOaeqUyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614701; c=relaxed/simple;
	bh=D4Jesxp0goxfo4+RkqtmVUcnjRYiUHslXFAvBn18PIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9eKqG+2uxg0TzQevDzo3shjBXv2Sg7S6BSWTsxNdD883jjV3aaeXrV4CRWjW7edxJKblyUouFD7CvIWqBchgsqbT0MwAlwzAv52qwDb5xpJMpPy+HcMFNy0ugx9ym+bWQoZ8rIUpkAigjlcC/lbOnev2v5NVYJh0qq9mQ1UtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US5XeI47; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59e4136010so1161281166b.3;
        Mon, 13 May 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715614698; x=1716219498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwyN+SM57vzeVl611qrZpQ9hXHag66qCgwB27/VmmyA=;
        b=US5XeI47bp0EIzSEF6RCjXLmzqxl5eNlpkErlK7jziudh1+E0URZ9eKz6GtjMWNEfH
         tCQyk9B4MeNkayR8w8ndV9HGDDYOCGsbfJ+2POD+HvdUE7WqHN0341LmqVqP5parXF49
         GFI1uQLJJs8QMBllfFK33t+rgCqOfwsSPUYB865IqQRY4E9Trv7sXrZZRA/Ah3An9lOW
         RC1kKzhOzDdR2ot8j9+CnPCxTzcTk59mNY8VD9FtsV2o6bThRsqAwTuR+Rjh/sTZa/QN
         RuiBMQInuwUO//FuDPT1Enw8c/Z3KlnBxguPTIKAlz2jIlOWi5SLDPVovT/0G1qfBtoj
         verw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715614698; x=1716219498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwyN+SM57vzeVl611qrZpQ9hXHag66qCgwB27/VmmyA=;
        b=D50aWMqG62leXs1Hl4thl5rG0F23U1q8G0H/BjKNqO/4lCv+gJQq2Y2BGk2yJ4Htua
         40j2lWNKyluja4l58LKtxrIbLh0XMTIj7U2gEBuGIKqauqPaJvVdfT5VRnW0tcaLlZ3n
         7pg2F/lmpZ9mjSUt4h8IWEsuSw4Rj3nWT92jMyFn8fYxMntbmUNOmBgjKKtJuUcIcvgG
         +lBpLvMa2zzdSh6u1/O4yg2QGdcQIBr7DLv6hAWf9/nEpplRnVyUe1q2jUiCHfs4vauo
         e5b5Bv1WSnEHiFpC5vt/M1o2YwanzD/0FPkHDFnGlZU2BbbocN0rzux056/UattXG+a3
         HXdw==
X-Forwarded-Encrypted: i=1; AJvYcCU6cvPSO67d065hLFaOIhUvvXwsvcA2cAr8HLZ5+vsI8HGxHnH9Yse1o89o6hT1LtbGpuGV0lCDptgu70VvFLJgbu4iflY4ndHl9ZAnW5HtCMI07Wu0lIVwjX/g6AXzYt8Eqx8AhoU1dg==
X-Gm-Message-State: AOJu0YyYZjKjLPasoyJQ/4gkeZfL9rSTExSDOnrhGLKv8FxlW9+ilyzo
	CkeByeeinyWLYMH0qmsBJ+3bLuB9arLjey6rMChOG4U071I8D/jk2H+FA4Mf
X-Google-Smtp-Source: AGHT+IGTNJtlgQGQD4ibnubprYy9/aebeejMr1qpEPPXsn/mM3SWgJQhe7VU8Jgr2xjufacdWnm8yg==
X-Received: by 2002:a50:c010:0:b0:572:7e9f:c124 with SMTP id 4fb4d7f45d1cf-5734d59040bmr7010860a12.9.1715614697660;
        Mon, 13 May 2024 08:38:17 -0700 (PDT)
Received: from njaxe.localnet (host-79-55-54-147.retail.telecomitalia.it. [79.55.54.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c06sm6459548a12.85.2024.05.13.08.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 08:38:17 -0700 (PDT)
From: matteomartelli3@gmail.com
To: Matteo Martelli <matteomartelli3@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Date: Mon, 13 May 2024 17:38:16 +0200
Message-ID: <4072123.0gxhY3eTYf@njaxe>
In-Reply-To: <91fa1c1f-22ea-4f4a-9d87-a919ddf118cd@kernel.org>
References:
 <20240510131238.1319333-1-matteomartelli3@gmail.com>
 <20240510131238.1319333-2-matteomartelli3@gmail.com>
 <91fa1c1f-22ea-4f4a-9d87-a919ddf118cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 13 May 2024 10.53.57 CEST Krzysztof Kozlowski wrote:
> On 10/05/2024 15:00, Matteo Martelli wrote:
> > Add DT bindings documentation for the Everest-semi ES8311 codec.
> > 
> > Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
> > interface and I2C control.
> > 
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > ---
> >  .../bindings/sound/everest,es8311.yaml        | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/everest,es8311.yaml b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > new file mode 100644
> > index 000000000000..54fb58b9ab58
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/everest,es8311.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Everest ES8311 audio CODEC
> 
> This looks exactly like es8316, except of later added port. Are you sure
> you are not planning to add port later, which would make both schemas
> identical?

I did not pay enough attention to audio-graph-port property which is in
fact supported and could be added as well. Thus the es8311.yaml would be
identical to es8316.yaml. My guess is that I should just add the
"everest,es8311" compatible string to the existing es8316.yaml even if the
two drivers are separate (like for instance mediatek,mt8186-clock.yaml). Is
this correct?
If that's the case:
* should the evereset,es8316.yaml file be renamed to evereset,es831x.yaml?
* should I also add myself to the maintainers list of that schema?

> Best regards,
> Krzysztof
> 
> 

Thanks for your support,
Matteo Martelli




