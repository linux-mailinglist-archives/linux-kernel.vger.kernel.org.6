Return-Path: <linux-kernel+bounces-512808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D1A33E13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C90D3A594E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20350227EA6;
	Thu, 13 Feb 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ModjNzAz"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7F227E82;
	Thu, 13 Feb 2025 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445988; cv=none; b=p9uPtPA+Dr/bJjsQapMTTxzuKwbtWgoc3SXBZgTLHedCvrhcZushoamwRKo8mPQgSN9oDTGvsu6iXa998GV1gWWPY/l5dnI6AJWYyXEQiJbPIkd+NcDhLQ88oyX1tuFogrk/9dho6gtip80Q95bMfYtkQhyVRzdaTTEHzQc99dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445988; c=relaxed/simple;
	bh=cnh/7/zjc5DJNspE8+HHSdkJj2bWRf+SQNBW74wjlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX0g542lGOAeqVrJfEPQ2pMXFf7ZekKWTChuieKBKYOHLUuHyHJdlnqLgrnPJrfmeCVOqjm9I3gGDcGP2uUNOOKnDXntfOR6HWi96KhJ0GOZzjnGCNXQ03RIg9FsR9wVYePSSDTQ4dLmhq4vd9KQveJPg9FPhUg7o0FieeAvMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ModjNzAz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46fa764aac2so5150551cf.1;
        Thu, 13 Feb 2025 03:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739445985; x=1740050785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUTfDmvy5Bhdv7Ab6yYlWq1JIjBJXsMdnuekE4YJLOk=;
        b=ModjNzAzJbMYhBnvvUnUcKyxR91nBIKPI7TAKCBFoyYZsYb2dz7ljqLZZRM4ujTsUJ
         rLiGYPS2cdqxYpA1pFpRYbJb5ZHE5UuhxnTNvB0lspGE/qvn/EMwdRqiNKszpWFdwtT9
         gzwi2xqDjbAlP40SPD6XGlcMESKYUtNog0RnnaaZXjHSZSqhJ6iVSKU8yC62Y+VFYPmf
         wQG/YCEnD2gbconYVKlH8ukTXzTdgmJ6fJjrXcxOCBuY2ejrahdAT3koZZNdeeWyrn7i
         hRco0uP0uScK1Ogh+1929Rgz4GmzA+t166QqTrlMS+95hzb8grcm4GSsYjmSPXvbCxTi
         LIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739445985; x=1740050785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUTfDmvy5Bhdv7Ab6yYlWq1JIjBJXsMdnuekE4YJLOk=;
        b=j8T4/jTwhP9yrwkZ4pOcZgw4miMuZii1pzXmWgJ73lvQZEwLvv2KGM77pTRFTzHqxd
         ePBc6kF+z8aHkvR6DKhdCX1nwYF0c0yBKTFgv63rGk3npaRFZqARKRBpWiQdW6vkdayS
         lyTzSGEEYxLDAY3xDVewpQwLeK6G6so9Co1v7dwphsUmI582g0SgGjxDiCzUKUPQZNPK
         kB0nPZH1Izz5vNJekHCNcnJVaxr17Z/mXxY5Avl2NLr0pl6r0lh0X0BasDvrkXgmJl66
         n7TP8FOZPN1TvnPWqMvkhbN7yt0ERv/wt2ESVorID82QFlUURFfkodMDu5DcUPkZNDxv
         teSA==
X-Forwarded-Encrypted: i=1; AJvYcCVXgNz7jhVD0OPKAVzTd7vMfiSNMaVkW4WF80eQwcXHEBs60Ftc9ZizJg6NjIY1bE/OhhFQ9VwKoP0msAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybx5h5dqX4R360idUHaOa0yd7Xzf2Ksf6ERTYT24o46j87cO1f
	RIiaFnsTyLZ4LZQ42UfIw3d6/LPyRggwhgL7J6ksnp+qd5gYh4uc
X-Gm-Gg: ASbGncsmrrKw21+WQwbBPWcnMLwn7N8IhDA6QWnwfV4DftnezdEXnsYws/ANzOHNaJV
	Gvg8DB3BEhvxvz1Z99wdC25/LoviOUYWYcRKk3ycURv49Utzz7ygfEw4+wveSjM7ToUkbtBOyW2
	SKpaTAx58qXbeMIcZflmYldgWP7AUmeqTh3zmsL/2/YDGBQIHv6DjSkPvlAjnn2d3hhYsYrLycQ
	i3+JztwfkKrrakcxMPAs/uoZnHPrtNy52gL7AhzyokZ8P41ip4Dbme1Lm3Qihvw+2w=
X-Google-Smtp-Source: AGHT+IHarKxPF7Mq1Va3dpnA4qdWkYz+da0eCf7AiIm5qMplxsfMjqtaZ8SbX7mt6EAyGdIMQeVqtQ==
X-Received: by 2002:ac8:5ac5:0:b0:467:57c8:ca31 with SMTP id d75a77b69052e-471bedbbe05mr52875421cf.46.1739445985449;
        Thu, 13 Feb 2025 03:26:25 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c29e9428sm6781241cf.7.2025.02.13.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:26:24 -0800 (PST)
Date: Thu, 13 Feb 2025 19:26:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: reset: add generic bit reset controller
Message-ID: <bzzwckg2ac2q4fkcp5jju5ubqmget3jdwmvcubdmc4xp3slmwn@hn4kmkotfnfw>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <20250213020900.745551-2-inochiama@gmail.com>
 <de7dedf98e2085c895a93ba56c4e5fa50e298d05.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7dedf98e2085c895a93ba56c4e5fa50e298d05.camel@pengutronix.de>

On Thu, Feb 13, 2025 at 11:08:59AM +0100, Philipp Zabel wrote:
> On Do, 2025-02-13 at 10:08 +0800, Inochi Amaoto wrote:
> > Some SoCs from Aspeed, Allwinner, Sophgo and Synopsys have
> > a simple reset controller by toggling bit. It is a hard time
> > for each device to add its own compatible to the driver.
> > Since this device share a common design, it is possible to
> > add a common device to reduce these unnecessary change.
> > 
> > Add common binding for these kind generic reset controller.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../bindings/reset/reset-simple.yaml          | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/reset-simple.yaml b/Documentation/devicetree/bindings/reset/reset-simple.yaml
> > new file mode 100644
> > index 000000000000..77584e23e8e8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/reset-simple.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/reset-simple.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic BIT Reset Controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@gmail.com>
> > +
> > +description:
> > +  Some reset controller devices uses a simple method to perform
> > +  assert/deassert by toggling bit. Some SoCs from Aspeed, Allwinner,
> > +  Sophgo and Synopsys have this kind of reset controller instances.
> 
> I think some properties should be documented that make reset
> controllers "simple" according to this binding.
> 
> For example, right now, the reset-simple driver assumes the following:
> 
>   - There is a single, contiguous range of 32-bit registers.
>   - All bits in each register directly control a reset line.
>      - There are no self-deasserting resets.
>      - There are no timing requirements.
>      - The bits are exclusively resets, nothing else.
>   - All bits behave the same, so all reset bits are either
>     active-high or all are active-low.
>   - The bits can be read back, but the read status may
>     be active-low independently from the writes.
> 

Thanks, I will add these assumes in to the binding.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - reset-simple-high
> > +      - reset-simple-low
> 
> I wonder if it would be better to have a single
> 
>   compatible:
>     const: reset-simple
> 
> and a boolean property, e.g.
> 
>   active-low:
>     type: boolean
> 
> like in leds/common.yaml. Also it should be documented clearly what
> this means for reads and writes.
> 

Yeah, it is better to have a property instead of defining a base
compatible. With this property, there are two ways to process this
property with existing device:

1. If device has defined the data, the active-low is ignored
2. If device has defined the data, the active-low will overwrite
   the device data.

I wonder which one is better?

> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    reset-controller@1000000 {
> > +        compatible = "reset-simple-high";
> 
> The example should probably include a SoC specific compatible?
> 
> regards
> Philipp

I think it is OK. But I think it should be added when a
specific compatible is coming.

Regards,
Inochi

