Return-Path: <linux-kernel+bounces-527146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51762A407E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EF19C4F40
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFB20A5DE;
	Sat, 22 Feb 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="ABVOlES/";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="ujfBiNk5"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C36FC3;
	Sat, 22 Feb 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224181; cv=none; b=exn47O3uYRyGiG16ZW3SHRXR6p/6/RYW3qMKIcJvYxtijmL8H7CMDoKeklbakgdJX9oZn+3GohIRc1rKua+mSBrQw9rc8DPEI+bd3LlWdUBKh2XKQ9bbbsxlp1uljPR4/2yJrtXoOgMWQn9pdgCXlLxqGtqmPG7NlkroXs6pQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224181; c=relaxed/simple;
	bh=SOwH0X3o/HhmS2t6HTuMd4f+rDYK0rxVnzjVPLbUQq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOnCQixG19Lf3WZlQmm9f6ozYVICcTXt3i8EJRL0uLP236aTqGMcgfbXHG3xSInEXqA+RUYefQ3B3i5sYBRiIJcdfc+5ZMh+kb2u8aulLKmCfsO2xkQceCGKAjNZojr5Al4i6PRylwOmChgrkh2nX9Gs8K9AJJQCaSpTwdSFUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=ABVOlES/; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=ujfBiNk5; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 5ED23122FE26;
	Sat, 22 Feb 2025 03:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740224177; bh=SOwH0X3o/HhmS2t6HTuMd4f+rDYK0rxVnzjVPLbUQq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ABVOlES/GvScXjONNVDQvu/S0Hs0wPhbGU2RDAYy2cEeih5WIoQHqUmafU13fxDFu
	 YsWFXJluYDlaEhjHUYJtm2u/bMA+KvTfONDIopxwdKbEsNXl97hmYRAj+c2EU+Hw3p
	 aedeLCEuNoaB0KPVlAkQ7MYLSueCdk9AD24hVdyeB8ILjIz+UYi6NcQ+cBwz+nZ3B5
	 rufn8cDIc5M/ZRIN1c1aQh0Bo731er7upOX6k9iMX7l3fRbu1OlRImXED2Fh7wYcTZ
	 m6Bv/z5YeJlkg0VNvaVFDSz/rgmlcKN7K5jzF/dAIfusm/7qdgudQVhZFY23ha9iDJ
	 eIMiVIe5K6luw==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g1TN3FBn8qRe; Sat, 22 Feb 2025 03:36:13 -0800 (PST)
Received: from ketchup (unknown [183.217.80.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id A95BC122FE25;
	Sat, 22 Feb 2025 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740224173; bh=SOwH0X3o/HhmS2t6HTuMd4f+rDYK0rxVnzjVPLbUQq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujfBiNk57CUKu+M7ljRJ0+19wzyuQi2TwhupqBRWE2X11DD7xojiJc8aH0nGqrQoO
	 TRAGFEfGaWX/oiqAjv1Es0p6ALLAmtUospfJZV4CkJPT5E82aSN/F9LTdzFPP8ZDhf
	 3qJlfAh1xm2cinokwTI4NuRutnBj7HD1c0v+GB69Enj4+A6qJ/3bbmh5Z0MUnbRyfA
	 oLSLnZU+Gfebcy1tEnnKWUyi2SoCuZzL3zf0snIAMOy+Af/Vh+P462eOicyqiuPPZ/
	 gsNYyP+yc0R/g2KdgmZ6Utb9q+qkFadB29zPBxIPZdkKhBlsWhX1k82nPc8YyvHejt
	 Wo/go59RUiKOA==
Date: Sat, 22 Feb 2025 11:36:00 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Message-ID: <Z7m2oNXbwJ06KtLQ@ketchup>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-4-heylenay@4d2.org>
 <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup>
 <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup>
 <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
 <3e196e9c-c942-4026-8d6c-69c9930bebd5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e196e9c-c942-4026-8d6c-69c9930bebd5@kernel.org>

On Sat, Feb 22, 2025 at 10:52:02AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2025 09:41, Haylen Chu wrote:
> > 
> >>> 	};
> >>>
> >>> For the other two clock controllers (APBS and APBC), syscons are really
> >>> unnecessary and it's simple to fold them.
> >>
> >>
> >> I don't follow. Do we talk about children or syscon compatible?
> > 
> > APBS region contains only clock (PLL) bits and APBC region contains only
> > reset and clock bits, so I was thinking about dropping the syscon nodes
> > and changing their compatible to spacemit,k1-plls and
> > spacemit,k1-cru-apbc.
> > 
> > In summary, my plan is,
> > 
> > - For MPMU, APMU and APBC region, keep the binding in soc/spacemit.
> >   They'll be reset, clock and power controllers, with compatible
> >   "spacemit,k1-syscon-*".
> > - For APBS region, write a new binding clock/spacemit,k1-plls, as it
> >   contains only PLL-related bits. It acts as clock controller.
> > - All split children will be eliminated, there'll be only four device
> >   nodes, one for each region, matching the datasheet.
> > - Put all clock-related binding definition of SpacemiT K1 in
> >   dt-bindings/clock/spacemit,k1-ccu.h
> > 
> > Is it fine for you?
> > 
> 
> That did not explain hardware to me.

Sorry if my replies haven't made things clear. I'm goint to make a
(hopefully) more clear conclusion,

> You assume that some way, maybe
> through magical crystal ball, I know your hardware and will tell you
> what to do.
>
> No.
> 
> I have dozens of other patches in my inbox. It's you who should explain
> the hardware in simple, concise way so we can judge whether DT
> description is correct.
> 
> Again: define what is the actual device, what is its address space, what
> are its possible *separate* and *distinctive* children.

The series covers four seperate blocks,

- Application Power Manage Unit, APMU
- Main Power Manage Unit, MPMU
- APB Bus Clock Unit, APBC
- APB Spare, APBS

they're clearly separate blocks and have their own distinct, separate
address spaces, confirmed by the Address Mapping section in the TRM[1].

These four blocks provide hardware bits for three purposes: power
management, reset signals and clocks. Not every block is capable of all
the three functionalities,

- APMU, MPMU: power, reset, clock
- APBC: clock, reset
- APBS: clock

Reset and clock bits, if present, always stay in the same register.
Power management bits stay in others. These two types of registers
interleave if present in the same block (APMU and MPMU case).

These blocks have no child: power, clock and reset definitions differ
from block to block, no reusable nodes could be split from them.

Hope this conclusion will help the reviewing. Please tell if something
is unclear.

> 
> Best regards,
> Krzysztof

Thanks,
Haylen Chu

[1]: https://developer.spacemit.com/documentation?token=LzJyw97BCipK1dkUygrcbT0NnMg

