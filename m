Return-Path: <linux-kernel+bounces-384807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EB69B2EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE803283B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5E1DD554;
	Mon, 28 Oct 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fHTmNORu"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C71D95B0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114092; cv=none; b=IBX9gMW8pcd8otDIpxQV6j8r6U1MMJ6tTc6l/BlfG29qIioESsvW+UIizqvlexllhgQmGaatyNyt9ytzOn5pIidim3ZOreu+ZPkSEvO6Ta8XP9L0sdfT8DbdJmroGvCuM7oP4pUK98dACzeHJ25pfQVkQjpjmqtOTTiuTWiCFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114092; c=relaxed/simple;
	bh=rZV1CslZk1B8arY+dKaXuzo5OLwD/6vbUj85cb0sG88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tplAL3+6NXXfRAkOhKQtt5XBcTCmGubS6CS468isr8FkYTfhC1IKev6X4tpwwZtDnDu4sxQUXD2vn6BiMXSWD2vTRzgO3ic2URtb4zWm/0bcs4wcJN0wKpyFGrTn1VffuAXES34Y1L9TVaeXW869Y0QeBcwbqyr++sSikXxupTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fHTmNORu; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d2e71de18so1251030e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730114089; x=1730718889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJAyl38jEw54JK8vLB+Jw3zg1/RGB44yP0anG4AqfEo=;
        b=fHTmNORuiYWZYyKnWufrERyTY3SU0//FXasX7ZwubuoWb357FaWDkqEwnIlmfo2Jxx
         3LBdgdcsZkH9SetTnxhLCM7yRhzR9BnDIolsph1gMxMNqqOJPgbZwgzKLDV7RGauRMzK
         nPsz1HZQP440hBvjPqSA2lvvHw2al8SCsRLVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730114089; x=1730718889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJAyl38jEw54JK8vLB+Jw3zg1/RGB44yP0anG4AqfEo=;
        b=b566l4nBpJbLlhUhYWFU3yE6RqD5xxlPnEUvRL1IXk4hpm2E4AmQ1GOTLWE7NgJisO
         IRh/GeqZHJKLF3ksRpeNg+gz+28RjGnunawCT8hFAO+j4HwoXmrwTUmIfyULAJB9aqnO
         QPaVakF83T0OpLjQecQnwN1GW8i1luNjI5CIE+rrDtBpl5yom3TUrWsgkgmFhuSeElIX
         B/T6ZB7z9c1ZhT5f3Bf4c93vE2YyTLUjBImNMWKKgFc9Gjnf4wDfOHnI86VkvsIyNuvi
         YFw90a9ha9NLenAf2hMlbCJs1HE8nZvY84zCQovy1Otvu9Nq4nnpd5Vdf4G5J01QvbZG
         NIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWAzATG5Jh7jJfUOlFYqeOxPum+jbvxdlzQMJBCg+9GKH7tlGKNp8uAkUuQZgSBkJLAPYpqA7Ln3qnasg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTmkAycQzlbAO9JhkP26RZ0vQZvJmoAyqcZ8DcI6lXz6sYbzh
	zuiRcTskFuoeNDLiE5NPX2FeJsI7U3qVtdIDH9CnpryeIzx3b4i2jJcEEo0u7a5uJWqyIEWL3Vw
	=
X-Google-Smtp-Source: AGHT+IFj6auiQZ9oLK1lPFvspCbNz5hDsCo0RRU8etAwysfWa5wxCjA3XQylZxnh5hhkmqbr9vXbKQ==
X-Received: by 2002:a05:6122:2226:b0:50d:5ab3:5209 with SMTP id 71dfb90a1353d-5101510ef9cmr4989837e0c.8.1730114088985;
        Mon, 28 Oct 2024 04:14:48 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-510043d1e2fsm820702e0c.29.2024.10.28.04.14.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 04:14:47 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d5d6f9fdaso1243974e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqBSSLJWNoPLV3hEthaqlTbFnJ0yPXMaHvXfGAhnjWN7oe/NdVzHxiYu/FZ7uqkmekGMz4XKP2WDmmjaQ=@vger.kernel.org
X-Received: by 2002:a05:6122:1699:b0:50d:583b:934b with SMTP id
 71dfb90a1353d-5101510e5a4mr4976737e0c.10.1730114086990; Mon, 28 Oct 2024
 04:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025104548.1220076-1-fshao@chromium.org> <20241025104548.1220076-4-fshao@chromium.org>
 <i6eljb2nzhwr4bd55dbudsra3sni2hhk2eqgu3gttatwvnolt4@w4uhrklbyop3>
In-Reply-To: <i6eljb2nzhwr4bd55dbudsra3sni2hhk2eqgu3gttatwvnolt4@w4uhrklbyop3>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 28 Oct 2024 19:14:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1njm-YDo=e9Eh7Y_qkLJMa+SK63s8Nre54d0sV0V59DonQ@mail.gmail.com>
Message-ID: <CAC=S1njm-YDo=e9Eh7Y_qkLJMa+SK63s8Nre54d0sV0V59DonQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: maxim,max98390: Refernce common
 DAI properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:55=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Oct 25, 2024 at 06:44:43PM +0800, Fei Shao wrote:
> > Reference dai-common.yaml schema to support '#sound-dai-cells' and
> > 'sound-name-prefix' properties.
>
> Why? Is this a DAI?

I'll add a line to say this is a DAI and the patch fixes dtbs_check errors.

>
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >  Documentation/devicetree/bindings/sound/maxim,max98390.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yam=
l b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > index deaa6886c42f..5bd235cf15e6 100644
> > --- a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > @@ -9,6 +9,9 @@ title: Maxim Integrated MAX98390 Speaker Amplifier with=
 Integrated Dynamic Speak
> >  maintainers:
> >    - Steve Lee <steves.lee@maximintegrated.com>
> >
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> >  properties:
> >    compatible:
> >      const: maxim,max98390
>
> Missing dai cells - how many DAIs are there?

Acked. Will add
"#sound-dai-cells":
    const 0

>
> Best regards,
> Krzysztof
>

