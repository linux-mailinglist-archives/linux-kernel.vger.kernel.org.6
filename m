Return-Path: <linux-kernel+bounces-556814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF2FA5CEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E97189AB03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65F2641E3;
	Tue, 11 Mar 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bdb9Gojx"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960A25EF8E;
	Tue, 11 Mar 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720148; cv=none; b=hS535lED0TFYd6Beq4cReG+b0gi/m0VygtRzdL5zqNctwFtl8KrlBA55KAzy6asVlfQpxujAAPzHJ1LFVKmppNoR5Ttf09ju3sTsf9/mqu9Ke81xC0aTdbC9+2lptpz7RsGVqk+7BH42retDmOvuBDwhQWUqtf2FmIY+CyRUXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720148; c=relaxed/simple;
	bh=ALgeYULD97jCKLsl3qy0loXJ7HEmXrOCIreJopYWrd0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqc71rPC9M4VvCrrjvqV1y+6XKmDeqwrjS2j6qV3GXZo/PHs6EU7GD9RwOQ5MyvIrtNOYiBEOeS/oxJoTKgMQqqV0C4B+D36DkrNdrNGXrUX3c7WytaCgGsOYY9AcDBTU0vkeA7qcu7XrNmaUkrOYDRsDb+AyV6X2GZYvZVitvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bdb9Gojx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso64989455e9.1;
        Tue, 11 Mar 2025 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741720144; x=1742324944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QBYt0BHsxul+nTaYflhpms2js1nZoTfEFczz9ZKES00=;
        b=Bdb9GojxgdD60vEMRrrtiwfHwxC19pjYgxqZwImc5G5a/vqAzrE+bJ7ecly9Hb8uFA
         3ojZyy0N3iBcp2RIfTY6tuzWEY8Q7653C4qM8W9UfJ6LKcOGNXfy4qwZYs2w/1qPViqG
         1S5+BZGDMMfPZf6kLLCdusbFZU/Fr5uN5N/ZA3MgypUzIz+Wnd9v8hWiKBBVlYvQAPlC
         wRwN+VJc39VuhHTQm9kPZOWpce7/X9IViJdGKWSZMwnrB4ks7IYYw1cvBG1mbpdFashF
         PwKZOHa5a+3RF1pM4dwOpX+U8iWWwhhj+XYPEs4jGSksxV0HulFz9gfyuCfdL4NSaMxf
         YTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741720144; x=1742324944;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBYt0BHsxul+nTaYflhpms2js1nZoTfEFczz9ZKES00=;
        b=ah6kPeVsFfVX9agZOAVsgiMrYHT49GqgzL5O3+cPTcV55fW2mnDEIJVcp03c+BT51Q
         EBsQDmhN7+Bj+d9ESuAFnzvU9OuS8FxXs2WMECHAiWNh4u9aHpIlP3aKM52kN3nv+lah
         JDzUBi3UG2PEG79mcFVxztlQr1W7Mt/ZCfu20JoC39+NAknaLEpx+u0vUxA+nfCz+yhA
         6SdXkNnrVBA98oqChvNUMX8M5XJoN1Y+LOcQAaVfGpordX4hWrEbP3eQu9jJOyM69qMP
         kbl8VpOEr+NOqZx8VxOtsbH8CTSvtGqbJTQ/PPgAcPRNceSikvb5xW2FhYDUxC9j1874
         xRlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxYndxkIvm7H52a3qSE3zG1ZlIfxpv2jVM2BgY5+WJHHSTwLtzLfgZu4g+eSFJYXrNzZOiDiiaIKaYNaO7@vger.kernel.org, AJvYcCVQxtuQ6+9QucF+0mz95tBTzX95TmyxuKQZnhF3B3jzakcGLcCPZuibsitenK/Uyw66H1P1kHG7lWgx@vger.kernel.org, AJvYcCX+yEikgLk+V7jQG/w7xvfZt5MB/D/yV4ccVylpOR7NoEleURQ8lAHmH3pNDZ8IAqlVHfHn7rVLT+SL@vger.kernel.org, AJvYcCXPCFziVBOqeZgYHigfXaELkOcGR1n6+gB0/SkT93eBAAxz8wRHD0hxlDGcXDe9qUmn8arm+QceAr5g@vger.kernel.org
X-Gm-Message-State: AOJu0YynmZsfBxd3vtFNj2FnLOM2PXfjGYvbZw5cXTvQh2QiSpURq5gH
	QQgmFYr/jxRIMfOi4uJNRBlG1FIbhUtBr8QJ9Go4EPu31EsvWU8C
X-Gm-Gg: ASbGnctLpXKShySXuoVvElfJFf2M3yxFwOWZ3NHRVI6LL76UhhMheXjgsfMsKAEoQ8Y
	8Ct9BpQIFU7/yWHZF/19juUEF9GaqFj4vdZU/nXQViGmBNpzGJz7Z5M3y+0ztIPEClimeYNYb9h
	N5lNWdrXLa4dFeL4Lhx3yHopI89MRV7tz6EosLWt9O/ynfoWTJe/0IoQ3NaOdepUbyo51qBqs5C
	OuvZkzA8BNXxIuDvporxJP76KaDNSwydlhfDOBYpvfQMxWteNOzX2v4Y0DxBQkT63Lza98NCQIk
	tzJabLlgSis08jJNf7XoOcOxkiIjjM0vZOz5UmstYmEwfv8Mgc+ZBznofgAdNQNYhuRPNub0tZl
	gfqxNV5MJE9/H
X-Google-Smtp-Source: AGHT+IEVvLB1J5PdZXBMZwLdi5Sfx5U8w2F5CDI5YD3a5o/Tqdo42jSaYp7CF55JMp1UKEuKA0N/8w==
X-Received: by 2002:a05:600c:5618:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-43cdfb7e4b1mr144023345e9.25.1741720144407;
        Tue, 11 Mar 2025 12:09:04 -0700 (PDT)
Received: from Ansuel-XPS. (58.43.196.178.dynamic.cust.swisscom.net. [178.196.43.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf7c8249bsm81906155e9.7.2025.03.11.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:09:03 -0700 (PDT)
Message-ID: <67d08a4f.7b0a0220.8fe9e.44fd@mx.google.com>
X-Google-Original-Message-ID: <Z9CKTrERYllmbczJ@Ansuel-XPS.>
Date: Tue, 11 Mar 2025 20:09:02 +0100
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
 <67cec328.170a0220.27ecbc.9c6e@mx.google.com>
 <026296c8-a460-43ca-a423-0fa38269fbc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026296c8-a460-43ca-a423-0fa38269fbc2@kernel.org>

On Mon, Mar 10, 2025 at 12:41:06PM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2025 11:47, Christian Marangi wrote:
> > On Mon, Mar 10, 2025 at 10:21:45AM +0100, Krzysztof Kozlowski wrote:
> >> On 09/03/2025 14:29, Christian Marangi wrote:
> >>> Add Documentation for Airoha EN7581 SCU.
> >>>
> >>> Airoha EN7581 SoC expose registers to control miscellaneous pheriperals
> >>> via the SCU (System Controller Unit).
> >>>
> >>> Example of these pheriperals are reset-controller, clock-controller,
> >>> PCIe line speed controller and bits to configure different Serdes ports
> >>> for USB or Ethernet usage.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  .../mfd/airoha,en7581-scu-sysctl.yaml         | 68 +++++++++++++++++++
> >>>  1 file changed, 68 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> >>> new file mode 100644
> >>> index 000000000000..d7dc66f912c1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
> >>> @@ -0,0 +1,68 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/mfd/airoha,en7581-scu-sysctl.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Airoha EN7581 SCU (System Controller Unit)
> >>> +
> >>> +maintainers:
> >>> +  - Christian Marangi <ansuelsmth@gmail.com>
> >>> +
> >>> +description:
> >>> +  Airoha EN7581 SoC expose registers to control miscellaneous
> >>> +  pheriperals via the SCU (System Controller Unit).
> >>> +
> >> One more comment - there is no such thing as "sysctl" in your hardware.
> >> Look at the SCU binding which clearly says that it is the hardware you
> >> are duplicating here, so the "System Control Unit".
> >>
> >> So you have existing "This node defines the System Control Unit of the
> >> EN7523 SoC" and you add one more node which defines the "System Control
> >> Unit", so you have two "System Control Unit" device nodes?
> >>
> >> Look also what Stephen asked for:
> >>
> >> https://lore.kernel.org/all/20220106013100.842FCC36AEB@smtp.kernel.org/
> >>
> >> so how system-controller can now became clock-controller? Now, it was
> >> the system controller since the beginning.
> >>
> > 
> > The main problem here (and we had a similar problem with GPIO and PWM)
> > is that the Vendor (Airoha) wasn't so bright in placing the different
> > registers for the SoC so we have case where everything is mixed and not
> > one after another... 
> > 
> > Example we have 
> > - CLK register part 1
> > - Some bits that configure PCIe
> > - CLK register part 2
> > - GPIO
> > - CLK register part 3
> > - ...
> 
> This does not explain that binding said "This node defines the System
> Control Unit".
> 
> So what are you adding here if not SCU?
>

With "This node defines the System Control Unit" I mean, the entire
register space of the IP block is defined and each child specifically
define each part of the IP block.

> > 
> > The driver solution for this is syscon and the simple-mfd node
> > structure.
> 
> Let's keep driver entirely separate, we don't talk about them and mixing
> arguments won't make it easier.
> 

Ok.

> > 
> > Now the main problem is how to modle this in DT. There are lots of case
> > where the simple-mfd model is used (like the one proposed) but probably
> > this is not accepted anymore. But again this should be clearly stated or
> > we have a chicken-egg problem when other devs implement similar thing and
> > have to implement simple MFD driver to handle this. (and driver
> > maintainers say "Use the simple-mfd model like it was already done)
> 
> simple-mfd has nothing to do here. Describe the hardware - what is the SCU?
> 
> 

As I said below, SCU is just the name used in Airoha Documentation for
this IP block. In this register space there are multiple things so it's
not strictly a clock-controller (as it's currently defined)

It was proposed as clock-controller previously as we weren't aware this
IP block was used also for other usage that a strict clock controller.

> > 
> > For this specific case (and to give an answer to the clock patch after
> > this) the problem is that this register space was originally used only
> > to control the clock and I wasn't aware that it was also used to control
> > USB. Now that I'm implementing support for it, the disaster happened.
> > 
> > So In short SCU is lots of thing, both a system-controller, a
> > clock-controller and even a reset-controller.
> 
> And you have bindings for that already. Done.
> 

It's currently defined in DTS as clock-controller, should we change it
to system-controller to make it more clear?

> > 
> > To make it short, 2 different solution:
> > 1. We can keep the current node structure of the node-controller and add a
> > child node for the SSR part (with a dedicated compatible).
> 
> No, you do not add child nodes just because you want some drivers.
> 
> What is SSR? How is it a device?

SSR is the name used in Documentation for the register used to configure
the Serdes and PCIe port.

> 
> > 2. Those property need to be be defined in the clock-controller node?
> 
> In the SCU node. Do you have only one SCU or more?

Strictly speaking it's one register space. One clock-controller, one
reset-controller and one set of SSR registers, and from what I can
understand it's ALWAYS "One device/compatible for Register space"

The simple-mfd pattern can't really work for case like this where in one
register space there are multiple stuff.

Is everything clear now?

To summarize:
- no child nodes
- add additional property for SSR in the SCU .yaml

> 
> > 
> > The ideal solution is 1. Does it work for you?
> > 
> > Sorry for the long post and hope you understand why this mess of
> > reworking the binding.
> > 
> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel

