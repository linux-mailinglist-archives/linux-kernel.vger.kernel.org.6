Return-Path: <linux-kernel+bounces-553993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F4A591A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F893ABEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900D228375;
	Mon, 10 Mar 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA/O1xfD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5C227E81;
	Mon, 10 Mar 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603629; cv=none; b=YEawyGU53KSXUH339En/kFVjkq7KhdpjD1IBTS1BzPWnVfUp7QC9Mz6xoAoX6OJs87ZppJJty0YuhFj2vMO+WCgZMO8/+8pK/2kQLgRe07BIHh3M/GnxWg3YcqRDH0CZjBWAp2GyVwgTCcDtar9Aw1xGG+Y/sjsyhQvMVXVTyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603629; c=relaxed/simple;
	bh=sOvLZP+VqkI4T4xcNYsIMRF59AWaSNQz51sz8tdlEz0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrH6kGidA+CBifTmAxAS2mWv7AxvqATgylUMhpuxA+Uap6NfuoIg5YavB7aRHmhyoUjzb8n3BuktRo7kAuS5gZrgZql3ZW6PaeoufN0kqy0+yfjnh74qV67ZtEm9ZFcEyuEMhM1S7+SHt/ZQImQk+X7iGQzhCKOimjpD9bHq+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA/O1xfD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5e7fd051bso3584395a12.0;
        Mon, 10 Mar 2025 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741603625; x=1742208425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l5DEa09wiscb4LqtVRJpNAy3hWViEqi+/FfXF2zENFo=;
        b=JA/O1xfDQ7WTsaAHYR08uZ0NZZlmngQDFtAR2tRTZWco3ttk32R1MlhCKMBp1w2j7U
         iIShUcmL9R2kUQlhPsT7Pu4phVVGWrPvr4udT/Wy3TdNK6tYqC09PP/L24Cgxqa4Ifbi
         i/t2nG7BCrt9QWVrxGW2TwWovEPh8sBvli+EYRWobtEPo/NmddRWyF7CB2tSA2vgHEjy
         EnhnLb4jt3axjumnCJgkPlJOdahv9fTNzJ/srYIo0B5bsM8PPy0EvjYhla7mTom5R/fp
         RG2vH+PtaxnbUqCZGCvgwD+E9a6WK0b6/UDbBw/ruAnNdZ323AxSoMs+CD/bGCMyvy2G
         Du6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603625; x=1742208425;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5DEa09wiscb4LqtVRJpNAy3hWViEqi+/FfXF2zENFo=;
        b=pkKP3iaM627zFkn+4I7hJ52Yk+XSlXb0QCi6Vm9gZku4+rguifGvlO1hPVbGOS3oAb
         eQx4Jaa7Jaiwk5LUxI9VteH3kljAkFTNGb5RhPSURMfMavzxC641YyEzLUhE6lRc2kko
         7Cem5hK1smgFEUquXaM/AN9PSrjaGWZE1ybylS+9aQ0l/II6BEu8g7bRPiZU49KF+1xV
         bQKNXs3xLDAntOcXXlSgnBdcwUTCwWJHy1eL+EX4KnZhe8ZJHk0LR4bMfOmiJl1xRs1p
         ooUUd3wE5OcljHT1tUmyrAAU8St8MGZ5Pgkfpb2LUKdfkThBgL9HHR4fGTujGvgt9eWW
         6EGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJb/TP2nnunb+xYHqi7XqiJVY11egWorG5+8nRBcJEJPIHpkEkpfHb8mb1wHXPRfsaCMmXw8ifvWSJDxfP@vger.kernel.org, AJvYcCV22bG86Wh4GEyfZf2fP6RodOfN/FPQ1EgS+IgIyumVKWabyfFP81ThU77iPTe8vURaVScxn7GuN31z@vger.kernel.org, AJvYcCV7wtCAlAmP1fd5xPV3Tn336tV9mKikndZCZrJBUHLuE2gxfgI/QfbGXQnofzlRNLjvdspsd8q0zhJ9@vger.kernel.org, AJvYcCW9hpr0QppceicN8IqUui5sj7uEfWbtaP84nCj69TnvTO6ZtOY+xh9UTKCOOTCyttY+DaYV37cZuynD@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1giPLRsfPNH/kgFwxe+fKR35vEFv2+LGJ5ZvfDN+k/zG4yqo
	DeeDDOUaYwB53CTYTw0Q+GRT2190rEw7naASVDnYzrs2PivAsEsy
X-Gm-Gg: ASbGnctaryibrvgk2FKbyUeY5jTTbOzUIrXogt4bBfk2QU+7ufeK9WQPT6LNMfQEL4d
	1GAb592bGIE6THIx/PeseM4Qyyl9sSXkcRV7zxkK0lMeLUOiDbYy0Tn2vLNkoCcBjWn45fjd5/Q
	8CEZn2UtIGY7BmWG4Gd/PNyuxvybw/FlwnfcS0Sny7WVtMdXz/S97uyLN5Usnr8WKhSpwx7llLf
	1li7wo6jMRGIT+855vhRxhJyGLj2aQ3aQeNjvD39DZ3P9dTrfPodndW5TLVM36bh6w/yVJRdHsT
	xL5rfigbbRZPBJl4kzaHdEAezB7kQWDpgCCn1mz/SQ==
X-Google-Smtp-Source: AGHT+IGY9ZNuN9LrERXjHUYAwL4h4LC1ygOPlOz0b6pfTQ2hSZ2sXX5rhh5cw2fWoVRERYPwHIfVrQ==
X-Received: by 2002:a17:907:8281:b0:abf:67d7:7816 with SMTP id a640c23a62f3a-ac2525dceb2mr1171265566b.3.1741603625111;
        Mon, 10 Mar 2025 03:47:05 -0700 (PDT)
Received: from Ansuel-XPS. ([85.119.46.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943d8absm742184666b.20.2025.03.10.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:47:04 -0700 (PDT)
Message-ID: <67cec328.170a0220.27ecbc.9c6e@mx.google.com>
X-Google-Original-Message-ID: <Z87DJANlBejnqJHR@Ansuel-XPS.>
Date: Mon, 10 Mar 2025 11:47:00 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 05/13] dt-bindings: mfd: add Documentation for Airoha
 EN7581 SCU
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-6-ansuelsmth@gmail.com>
 <c1227083-a4ea-4dac-a9db-d6a5386c0437@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1227083-a4ea-4dac-a9db-d6a5386c0437@kernel.org>

On Mon, Mar 10, 2025 at 10:21:45AM +0100, Krzysztof Kozlowski wrote:
> On 09/03/2025 14:29, Christian Marangi wrote:
> > Add Documentation for Airoha EN7581 SCU.
> > 
> > Airoha EN7581 SoC expose registers to control miscellaneous pheriperals
> > via the SCU (System Controller Unit).
> > 
> > Example of these pheriperals are reset-controller, clock-controller,
> > PCIe line speed controller and bits to configure different Serdes ports
> > for USB or Ethernet usage.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../mfd/airoha,en7581-scu-sysctl.yaml         | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> > new file mode 100644
> > index 000000000000..d7dc66f912c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/airoha,en7581-scu-sysctl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 SCU (System Controller Unit)
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  Airoha EN7581 SoC expose registers to control miscellaneous
> > +  pheriperals via the SCU (System Controller Unit).
> > +
> One more comment - there is no such thing as "sysctl" in your hardware.
> Look at the SCU binding which clearly says that it is the hardware you
> are duplicating here, so the "System Control Unit".
> 
> So you have existing "This node defines the System Control Unit of the
> EN7523 SoC" and you add one more node which defines the "System Control
> Unit", so you have two "System Control Unit" device nodes?
> 
> Look also what Stephen asked for:
> 
> https://lore.kernel.org/all/20220106013100.842FCC36AEB@smtp.kernel.org/
> 
> so how system-controller can now became clock-controller? Now, it was
> the system controller since the beginning.
>

The main problem here (and we had a similar problem with GPIO and PWM)
is that the Vendor (Airoha) wasn't so bright in placing the different
registers for the SoC so we have case where everything is mixed and not
one after another... 

Example we have 
- CLK register part 1
- Some bits that configure PCIe
- CLK register part 2
- GPIO
- CLK register part 3
- ...

The driver solution for this is syscon and the simple-mfd node
structure.

Now the main problem is how to modle this in DT. There are lots of case
where the simple-mfd model is used (like the one proposed) but probably
this is not accepted anymore. But again this should be clearly stated or
we have a chicken-egg problem when other devs implement similar thing and
have to implement simple MFD driver to handle this. (and driver
maintainers say "Use the simple-mfd model like it was already done)

For this specific case (and to give an answer to the clock patch after
this) the problem is that this register space was originally used only
to control the clock and I wasn't aware that it was also used to control
USB. Now that I'm implementing support for it, the disaster happened.

So In short SCU is lots of thing, both a system-controller, a
clock-controller and even a reset-controller.

To make it short, 2 different solution:
1. We can keep the current node structure of the node-controller and add a
child node for the SSR part (with a dedicated compatible).
2. Those property need to be be defined in the clock-controller node?

The ideal solution is 1. Does it work for you?

Sorry for the long post and hope you understand why this mess of
reworking the binding.

-- 
	Ansuel

