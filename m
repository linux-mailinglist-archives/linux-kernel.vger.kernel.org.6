Return-Path: <linux-kernel+bounces-566069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90467A672C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479353ABA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923520B1F3;
	Tue, 18 Mar 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxctdvia"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA620B1FE;
	Tue, 18 Mar 2025 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297469; cv=none; b=dCzi95LZHSLqWG28/KJhy7qjwD4PKu4M7KOKelvPq0myjGFO0QD0QWsegA1DexCB3T6N2Lc4dJDOvrKXApMRwL+b8hPSaLdoglkwY0xulp5MwHgvKAqzJLPTIkW1id+RKtiR/boKetKb4xk4eFuQy4iGQkUgsG63rIklemBdUes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297469; c=relaxed/simple;
	bh=kxndd+gmt8x5LRoL0YBDmYnHkE5/msuSYIUck6xVs8w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBVOe/A+rMnZOigEFOq/PXyWADg1LC8XyZJmtVJk/97OT2rZEVUKZKAAiHmsPF6dT1Rf6D1U83zg8L+naUYpV1hplu4SuiO1XvsEL+3c9SV3OML/tysClWeWwQ4k4cY6PaLNvOZhfBZnWntE28aKqB7rt0mIOXrqf1PO6OcSkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxctdvia; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso33685215e9.1;
        Tue, 18 Mar 2025 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297466; x=1742902266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oeWK8KnE02poaU2apmgZYe7NYIk2mK6ZRM9x7EecA0A=;
        b=DxctdviapLtKOOdP9WKNGbFyejFU8zj4Sn0zxgIJindQ5N+5RbpTfcrAs/IXlHbQGU
         Zg1Nh59UzIQUG6j7L8WGeHm7AqDbCcFT3nzyk2csme1De8Hqvw5Lujd4cX8Rc0GUOflC
         xatTKIto9ZNMU96haoolJ6QWAr0u4tqWRwG4+2eBMEv5+y3Q9KolfXn9tFZ8qA5KZytp
         q3+GoYdBxG5FklDUI2eY/lULKvgoazNri5nCtYOScrjxDQXRGblNv/0MTo4KjOHoNzFC
         pJOby53NmJTPqJtANBjGAltyEMlxchczOJSv1m4smjdsAxhzydHw/rk8YRKd+WwUM4zC
         eP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297466; x=1742902266;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeWK8KnE02poaU2apmgZYe7NYIk2mK6ZRM9x7EecA0A=;
        b=TuiMaxQmoupfnxJQTugCC5D3+V7ieKOQDmh3umhZuij4sxBnRfYArWe6+tl9jPASNB
         kAUP5Cm757qJ30XWl3k/o5qqlkBNKOy90/chEZQds0y45jpy+1ibZ/WMCz6Z61XU1vPh
         SeqOcdKsl/wjAXHpcuswGqWPeIyA//yBmHLS828K3tIbXusyrasrJEPlCB+GHGiAy9Ab
         uj0r0TAiC96w23lOssB6KuBsPCPp529g+ILlo0RXaeuBQTFpQ9hSXua7RMwGlBLXO8AM
         /Qer6cnAb7+xzw5wLZJWO3hppN4xmkraKrLY0TdO4QrpQkp0fej1FQS29tdr0AJsm/eA
         OsPg==
X-Forwarded-Encrypted: i=1; AJvYcCVen/nmAXAUhdW+t53y9HFYcaL0j+t7CdLGRp166OSS9UofAUZQSsvK14Hwe/sAIbDWH0pd6UnXP3tJ@vger.kernel.org, AJvYcCVl8dahB6SG02KE4HO5lrPdsFdcPLrazbx2Dkn9FYer1T/8zDpEzuU/7ZVp7Zk8LY45wnXUpNMsm4jvkxTu@vger.kernel.org, AJvYcCWZjje2qsmBLCh1Z8SSuEZqilwBIiTwV/49NZMAEOBMbQDg6VYoiZvjxkdh5PPz6+qGI36CKYZbRr4X@vger.kernel.org, AJvYcCXV/cBr9F4KYPCDDeizW294PJPElCtHwB/Gic9iFqsQWj3z9RTYBkkd6Hkbfh26RfMcmFJr+tmhH2/+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87Iemf0/PUvUT+W5si0RZrsDtLzZtoif59MRYVg32KuvbFLOP
	PnX3nA/HWZYOK4AVDiRxwdtctgZ4ZQlJhmKWRL5LESZFJVxWebD9
X-Gm-Gg: ASbGncv6ozNEVyRgSKxtGtt8SrdsPRo+r0dCy3q8u17E4je7YfLXwUb6wSU5Ym9I9hs
	QwevAeATG286EpUST12tMVjOy5BMzOYVL9UeVuvXbauGkeAcKdS3n1IqpZYrcknew/ORSNow7bu
	ftL43spUiPpScEcoE8tJE3a2nGe/EPZOLE/5bik2cdk1v0RiqtUoBB8TgU9Z1wiA7ZP9l9eRUG8
	BHwhjBYWkgJYq1inyJJcuw4KIHEO1FF7U6tuCktTB2WU6vcT1oJxGXWke4BrqCistaxC80y7W7+
	uDUPPkcqk8D/iqkqCFKO6v0IqrW6BwakoZWgvdpiIcKFONkf4E2066spgg//WZRC3wC+hj9hymF
	h
X-Google-Smtp-Source: AGHT+IFpi+zFuJ8XXOnGn4TOSQKOE+/3yFEH37sz6LbTqTOZGYuC+54cInlqBrHl+fxwxahe/rNImA==
X-Received: by 2002:a5d:47c9:0:b0:390:e311:a8c7 with SMTP id ffacd0b85a97d-3971cd57eb0mr15913025f8f.5.1742297465853;
        Tue, 18 Mar 2025 04:31:05 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881187sm17594872f8f.41.2025.03.18.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:31:05 -0700 (PDT)
Message-ID: <67d95979.050a0220.166852.25e6@mx.google.com>
X-Google-Original-Message-ID: <Z9lZdFMUpqWwpsA2@Ansuel-XPS.>
Date: Tue, 18 Mar 2025 12:31:00 +0100
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
Subject: Re: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
 <20250309132959.19045-10-ansuelsmth@gmail.com>
 <4f16d239-f540-45d5-b67a-767b09f1c70c@kernel.org>
 <67d0862f.df0a0220.375bd.6b15@mx.google.com>
 <4a9ac302-dfbe-4d76-a634-a445957c313c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ac302-dfbe-4d76-a634-a445957c313c@kernel.org>

On Sun, Mar 16, 2025 at 06:01:02PM +0100, Krzysztof Kozlowski wrote:
> On 11/03/2025 19:51, Christian Marangi wrote:
> >>
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum: [0, 1]
> >>
> >> I don't understand why do you need index property here (which are
> >> usually not allowed).
> >>
> > 
> > Eh... As said in the description this is really to differentiate the 2
> > different physical port...
> > 
> > Each port have a dedicated oscillator for calibration and these
> > calibration are identified by an offset (all placed one after another in
> > a separate register space).
> 
> So different oscillators? Then describe the oscillator and its differences.
> 
> Different programing model? Different compatible.
> 
> Other difference? Depending what is the difference.
> 
> But there is no such thing as "different port ID" based on your
> description above. You just claimed that they are different, but you do
> not put that difference to hardware description. Instead you encode that
> difference in the drivers and it should be opposite. The DTS, so the
> hardware description, should tell you the difference. And I am sorry,
> but in 99% of cases "I am the first phy" and "I am the second" is not
> the actual difference we are interested in.
>

Ok to make it as clear as possible. (hope I don't contraddict with the
previous statement) (actually yes the "separate register space statement
was wrong and sorry for the confusion")

- 2 USB port
- USB 2.0 needs to be calibrated with an oscillator
- Each USB port have his own dedicated oscillator somewhere in the HW
- Each USB port have at the same offset a register to SELECT the
  oscillator. This register refer to the same oscillator selection in
  the HW.
  
  Example:
  reg 0x1fac0100 MASK 27:26 can be set to source out of oscillator 0,1,2
  reg 0x1fae0100 MASK 27:26 can be set to source out of oscillator 0,1,2

  Both register refer to the same oscillators in hardware (hence each
  port should select the correct one)
  Selecting oscillator 0 for both USB port is problematic.

With this in mind is it ok if I describe this with something like

airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL0>;

and some dt-bindings include

#define AIROHA_USB2_MONCLK_SEL0 0
#define AIROHA_USB2_MONCLK_SEL1 1
#define AIROHA_USB2_MONCLK_SEL2 2
#define AIROHA_USB2_MONCLK_SEL3 3

Or an enum of string like "osc0", "osc1", "osc2"...?

> > 
> > Oscillator 0 for physical port 0
> > Oscillator 1 for physcial port 1
> > 
> > And model this is a bit problematic without an additional property, any
> > hint for this?
> > 
> Best regards,
> Krzysztof

-- 
	Ansuel

