Return-Path: <linux-kernel+bounces-410581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E139CDD88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E21BB28375
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B91B3937;
	Fri, 15 Nov 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RlXyi7R1"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AE18FDCE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670283; cv=none; b=tAxrsyFLOa4gRSyfbIhwoEFYT8sXFtvDHPCLkipKTzaGLb0GakmOr+qbh2/ZZ73d0FHe4Z6KYASh8ryzfTf82NyZxPoQq+hWyUQ+faAD7dYFtfixOg9Ei7ShsE65BBE2d448DAjTQ9E419/NcDIeYGxcsngnWYGXj6Cbg2VwqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670283; c=relaxed/simple;
	bh=l54LTsYXRGOH22n3P5VsvhHKDQkfWZy4HLRCAbJh7pY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZVI2/cFeTdXtW63x0u6yzQ9jATIb82M40EU2uRyxMuAnX0drg6LHOBVXToQf9kEfszz8/xwvWGnwOMPHW2hOigNUfjjKVT/ljjYANtZG0xKhzNV0MmeQwqBfabOPs4H4aILNuF7ofroy7+0KuOjik/i8FXlmiBv4sl/jG8PkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RlXyi7R1; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9ed49edd41so298461666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731670278; x=1732275078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnRQ5k2W4KQtF3o50oAe39uq4EEsE5sLc3WraeZijZ8=;
        b=RlXyi7R1oVjBGt3pSGrEzeuqWc16Rc/WZf/iMGw59d1t/dUiIwx7uNeZ8LN5Hpoh2I
         TdaJi6EvvnDxuPrmGQLRUqLOquTzlSpMmRd0STffg7woOQ0MV5i2sljdaW5f4IzCo/1P
         zx05xBqVU6bijQMisUHQMilSNDRQUv70+KXoj1k6p0kQIsoRR/rA/eM4SDLmRAbUqZPX
         aXjen26iKj8k7X0vrOwQbB0t/6N9y0iMPeatxr2WW8z4ETMkabh2eUOnEjXaTTU+VO68
         6bh/Pc7AKeOWvwPEgHjSEDT77gxHdBq+3fURJCFgrmd3s5UphhilCMqPR+AEwnrbqxhg
         d/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731670278; x=1732275078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnRQ5k2W4KQtF3o50oAe39uq4EEsE5sLc3WraeZijZ8=;
        b=mysjej7R7REAUJFZoHi5s8mk1IFMscAd/RP9lECVr2XTmf/c9BejD5Z1nqjOJUK/on
         mKyaIjSbnjEgTq1+jpQC9x4UnBb6ieAbCOJ8cqBiol2fpg6ljESqlkQHkpThiNnW+Gzu
         sNVNbrg38DRHY8v2Q22hW3svZErHqX9BJqqXeNgcS/v2HBlvqUPRG3pX3WyezxoNhAaZ
         gniCGCm0qeKPbNswHI6rhTrY/b98yEtI2yGkE8cViFpK/YvVjRGU+CUvYsH1c4aPT5RT
         NPa+Wib30yhLY4lWXB6AHDfEcoVWcJo/80wPSimi1Tqx4hXvQJORjIpVRKQzAI9+zSgh
         k+iw==
X-Forwarded-Encrypted: i=1; AJvYcCVpCNoNwk7z5894nBkZ53CYkXdvewhNPIwoGYbB+Ghmubd5/se6XUda5gTXCA3NO7xnr4k3SAxMqluNokc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlfOWNb4nmIiNU79o14edviXuMcfCGDlNqvQ3evcXm2xpsDtV
	hkUrEHQRLY97jy5F5ba/NUdTv+VP/ormH+81VY449azIDEEPuFRUSR4kDk2LM68=
X-Google-Smtp-Source: AGHT+IGGVV57uzrNc0ydJB35BuAQW3PLmwezoY7ro9Htuqv6FaxtVtfdaNQjMW38HVtyAVFZlg/ZLA==
X-Received: by 2002:a17:907:6eaa:b0:a9e:df65:372b with SMTP id a640c23a62f3a-aa4835525d6mr182898666b.52.1731670277871;
        Fri, 15 Nov 2024 03:31:17 -0800 (PST)
Received: from localhost (host-79-19-144-50.retail.telecomitalia.it. [79.19.144.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a40sm168760666b.4.2024.11.15.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:31:17 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 15 Nov 2024 12:31:45 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 01/12] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <ZzcxIYKcZ-z6ubrZ@apocalypse>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <914978925d34cfb5bee10fe92603f98763af48b0.1730123575.git.andrea.porta@suse.com>
 <cxwzmlzafgdu2uarcx7mdv4p32zig7efatcg4dzmctho6mvykl@dgwvf3ltcjmo>
 <ZyNK0RxJKdNCV11N@apocalypse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyNK0RxJKdNCV11N@apocalypse>

Hi Krzysztof,

On 10:16 Thu 31 Oct     , Andrea della Porta wrote:
> Hi Krzysztof,
> 
> On 08:23 Tue 29 Oct     , Krzysztof Kozlowski wrote:
> > On Mon, Oct 28, 2024 at 03:07:18PM +0100, Andrea della Porta wrote:
> > > Add device tree bindings for the clock generator found in RP1 multi
> > > function device, and relative entries in MAINTAINERS file.
> > > 
> > > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > > ---
> > >  .../clock/raspberrypi,rp1-clocks.yaml         | 62 +++++++++++++++++++
> > >  MAINTAINERS                                   |  6 ++
> > >  .../clock/raspberrypi,rp1-clocks.h            | 61 ++++++++++++++++++
> > >  3 files changed, 129 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > >  create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > new file mode 100644
> > > index 000000000000..a123dd619f8e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> > > @@ -0,0 +1,62 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RaspberryPi RP1 clock generator
> > > +
> > > +maintainers:
> > > +  - Andrea della Porta <andrea.porta@suse.com>
> > > +
> > > +description: |
> > > +  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
> > > +  VIDEO), and each PLL output can be programmed though dividers to generate
> > > +  the clocks to drive the sub-peripherals embedded inside the chipset.
> > > +
> > > +  Link to datasheet:
> > > +  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: raspberrypi,rp1-clocks
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    description:
> > > +      The index in the assigned-clocks is mapped to the output clock as per
> > > +      definitions in include/dt-bindings/clock/raspberrypi,rp1-clocks.h.
> > 
> > You still describe how current driver matches assigned-clocks to your
> > output clocks. That's not the property of clock-cells and that's not how
> > assigned-clocks work.
> 
> This description is taken by another upstream binding, please see
> Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
> 
> Its purpose is to let the user know how clock-cell number specified
> in assigned-clocks is mapped to the clock provided by this generator.
> Since some of these clocks are shared among peripherals, their frequency
> cannot be set by consumers, so it's the provider itself (i.e. the clock
> device described with this binding) that should take care of them.
> The renesas example has assigned-clocks specified though, please see below.
> 
> > 
> > There are no assigned clocks in your DTS, so this is really irrelevant
> > (or not correct, choose).
> 
> In the first revision of this patchset (please see [1] and following messages)
> I had the assigned-clocks setup in the example while trying to explain their
> purpose, but Conor said those didn't seem to be relevant, hence I dropped them.
> Maybe I had to be more incisive on that.
> So, I'd be inclined to retain the description as it is and reintroduce some
> assigned-clocks in the example as in the renesas one, would it be ok for you?

Since I'm on the verge of producing a new patchset revision, may I kindly ask
some comments on this? Is it ok for you?

Many thanks,
Andrea

> 
> > 
> > 
> > > +    const: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: xosc
> > 
> > What is the purpose of clock-names if you do not use it? Drop.
> 
> Ack.
> 
> > 
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#clock-cells'
> > > +  - clocks
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
> > > +
> > > +    rp1 {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        clocks@c040018000 {
> > > +            compatible = "raspberrypi,rp1-clocks";
> > > +            reg = <0xc0 0x40018000 0x0 0x10038>;
> > > +            #clock-cells = <1>;
> > > +            clocks = <&clk_rp1_xosc>;
> > > +            clock-names =  "xosc";
> > 
> > Only one space after '='.
> 
> I will drop the name since the driver will not refer to it via clk_get()
> but will use clk_parent_data::index.
> 
> Many thanks,
> Andrea
> 
> [1] - https://lore.kernel.org/all/20240822-refutable-railroad-a3f111ab1e3f@spud/
> 
> > 
> > Best regards,
> > Krzysztof
> > 

