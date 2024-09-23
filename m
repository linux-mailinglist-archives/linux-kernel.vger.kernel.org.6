Return-Path: <linux-kernel+bounces-335646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3697E87F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9EB1F21D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C001946A4;
	Mon, 23 Sep 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glHTcSa4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268B1940B0;
	Mon, 23 Sep 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083317; cv=none; b=Ktw2DmVTTsQhq2D5j1LXZBMsIEDPlOHe5K3RX467iU+DPGuutuAneJYTWmWAJmEWJffbudejdNqfX4rX9dubWIcsRXcZl39dhFFTdvYcCdwQTk+l90tEMsjd6VIUxTZf47aqkFcIpVfZsIgbzAjOpa/Y5uU0qIRwapRlTDb0ZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083317; c=relaxed/simple;
	bh=CX0tpMejE8TCcdZeZTgX9STkkwRQOi0a5VrFsm2kRlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXmv9Eu7UEETYJjbVmLkU3QjtL2ZLe1Y5x9sLjKc4GTgSLOxLr5hOMvfWodMhc4xF6rZWJVvgNZMS/4f9tjbgdm9CR34iTw8kjCD7YK3+GarEUOGpyHKm/VGlQP5yIDcGMnS25zq9bMWJzmS96r0PdDAqmMo3iO0fEevwghqU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glHTcSa4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d446adf6eso646646066b.2;
        Mon, 23 Sep 2024 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727083314; x=1727688114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BeTrBA1N+lrnARk4DKq2IC2AoEA+AXYxT54TqSLaEmk=;
        b=glHTcSa4QAtGl9hY6GXkj1TlrU545n1wY8n06Of6tpqArYBK9PkeUio8ZUankamseE
         0+dHdntPzkLViYCjqDYsWKcICXnwgsrJ1JzZzWYrm773RGAZY4uRISMwlj6+s9rWPFJU
         syMsUbYPkeqPrFWSqky6LPRLCBL8rBJgQW46A/JcFAhOr/LZcrerXOKsNX05k59Ehf9x
         +7PeoQfrgfcJtEou5nx2s2NdSLDYQwaAb0frx7Mm3r+quINn2i+Xobx0Qk/BASTEQ5eC
         bcPlKmjMtk0Ir19OTrcmJiIzfOL4irj5qOm19nW8tfDEUYDDeFQ9bi9PBzXTcpl8MqUb
         zJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083314; x=1727688114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeTrBA1N+lrnARk4DKq2IC2AoEA+AXYxT54TqSLaEmk=;
        b=Ya1M5oKq3RJ0ikThHAvTteqg6wXeeOMyZmtdmAmTVY4WA+5bE3MUywMwWqKBMDBhRL
         NCwbj3Ur8Lng1zTTqKfy41qnUtMUrL+Y2CzwGTDAXAxLzouffaRiViD50U96clwFkkLw
         X5fWr/HEGyoFIexsj11sY77FORlI+kOrpRXyOWsYwmeNXLJo9oxeR0Jeh/2hZdd3LODD
         g5PmfZ8ZZr6+ggiXwV+jo+2QZkc+3dbEpaCu+MejpSRe8KxiUqFMY3EgmG9f/PVEP91y
         CRO8de4NISgjwGUJXgXCmu4pe//HIryIxZ/fZjX4jetnA3ZhDNOYeI8UApoXlHwXBkPw
         5YDw==
X-Forwarded-Encrypted: i=1; AJvYcCW/CCCjqOpdxklPI2DMVJwTB1ZkkSlel7+xE5mcEnZjNuRxqW3Mpx/WNvYqU3d5S5DLTGzlLNmTQJsAgoFf@vger.kernel.org, AJvYcCWM/UX7F6CPGwgw5ibQuxPPdMyHk1d92J5YI3AK0ILv+PZGYN5PhLEoMADrQKfECgROPhqM6AIdkO1S@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4m0EA6KAs07n6BXS74v/7DDGZmwu3VVvLhkmR5mkefa1EXJi
	Woew2uRjGD3qkqasqWT80LCQR9BPMl7b7h7zRBRph3CmVTPXRAKgqri3ut9GnR1v5wz/0yaxX9v
	8xUKR6XLGibgOIbzZtHzqJu2kvg==
X-Google-Smtp-Source: AGHT+IHjgBHsrSF7iNusLMRgxzz/fWBBlO0MNCoYDwKJjaxi1mIfKT0+RFXnJc+GyzvY9qykBS2XovckNAslXQJxNNU=
X-Received: by 2002:a17:907:c7c3:b0:a86:96ca:7f54 with SMTP id
 a640c23a62f3a-a90d4fde858mr992207466b.21.1727083314069; Mon, 23 Sep 2024
 02:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920181231.20542-1-erezgeva@nwtime.org> <20240920181231.20542-4-erezgeva@nwtime.org>
 <2fo7pndjqieq6lfydmq2pnwb374oqoqnrcsezycgougmr7mtl5@2wm6fe3inf5u>
In-Reply-To: <2fo7pndjqieq6lfydmq2pnwb374oqoqnrcsezycgougmr7mtl5@2wm6fe3inf5u>
From: Erez <erezgeva2@gmail.com>
Date: Mon, 23 Sep 2024 11:21:17 +0200
Message-ID: <CANeKEMPjLYbBi0AXkEdNum=kqtVe_mfTcVf4zUvJsszVhnh+pw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Erez Geva <erezgeva@nwtime.org>, linux-mtd@lists.infradead.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Sept 2024 at 22:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Sep 20, 2024 at 08:12:29PM +0200, Erez Geva wrote:
> > From: Erez Geva <ErezGeva2@gmail.com>
> >
> > Some flash devices need OTP parameters in device tree.
> > As we can not deduce the parameters based on JEDEC ID or SFDP.
> >
> > Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> > ---
> >  .../bindings/mtd/jedec,spi-nor.yaml           | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index 6e3afb42926e..4f7bb3f41cb1 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -90,6 +90,43 @@ properties:
> >        the SRWD bit while writing the status register. WP# signal hard strapped to GND
> >        can be a valid use case.
> >
> > +  otp-n-regions:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Some flash devices need OTP parameters in the device tree.
> > +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> > +      This parameter indicates the number of OTP regions.
>
> OTP regions where? In DTS? On flash itself?

Where can OTP regions be?
Can you please be serious?
If you have any suggestions, I am happy to hear.
I did ask before.

>
> > +      The value must be larger or equal to 1 and mandatory for OTP.
>
> Don't repeat constraints in free form text. Add proper minimum and

Sure, I will add a minimum.

> default, although it is confusing - property is not required but it is
> mandatory for OTP?

You are welcome to suggest a better rephrase.
Using OTP settings is optional.
If you set OTP then the number of regions and region length are mandatory.
While offset and base are optional for OTP settings.


>
>
>
> > +
> > +  otp-len:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Some flash devices need OTP parameters in the device tree.
> > +      As we can not deduce the parameters based on JEDEC ID or SFDP.
>
> Don't repeat the same.

Is there a grouping description?

>
> > +      This parameter indicates the size (length) in bytes of an OTP region.
>
> What if each region has different length? Is it possible?

Yes, there are. Old Mactronix have chips with the first region bigger
than the second region.
As these are old chips, we may skip the support of them.

>
> > +      Currently the driver supports symmetric OTP,
> > +       which means all regions must use the same size.
>
> Drop unneeded space in front.

OK

>
> > +      The value must be positive and mandatory for OTP.
>
> Same comments as before.
>
> > +
> > +  otp-offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Some flash devices need OTP parameters in the device tree.
> > +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> > +      This parameter indicates the offset in bytes of
> > +       an OTP region relative to its previous.
> > +      User can omit it if the offset equals the length.
> > +      Or in case we have a single OTP region.
> > +
> > +  otp-base:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Some flash devices need OTP parameters in the device tree.
> > +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> > +      This parameter indicates the base in bytes of the first OTP region.
> > +      User can omit it if the base is zero.
>
> so default: 0?

Sure.

>
> I am not sure, but all this looks like duplicated description of nvmem
> cells or some sort of partitions.
>
> Considering that this is first time the binding mentions OTP, I really
> do not get what you are doing it. If the properties are to stay, please
> describe better the problem (and hardware!) in commit msg.

OK, good point.

Thanks for the feedback.

>
> Best regards,
> Krzysztof
>

