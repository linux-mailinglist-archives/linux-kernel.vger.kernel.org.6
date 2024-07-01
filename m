Return-Path: <linux-kernel+bounces-236246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A662091DF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3531C2110F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157414D430;
	Mon,  1 Jul 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="d58UWAuG"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0714B08E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837199; cv=none; b=GbRu6a21xThc21Gj2fv2Rd2ozALyi1/P6fYRhxrgWQjFq4ubIwpevWMcrchARKHQT9CSAVvOUJdVZpOXg2MIWLPlzmgoTRbVMi530SccLSDIzOZyAugncZ7n9/eHypZcNh1UrFWcYhObWO6cOIAEdjEgOkuUrRb1HIcPk/aqZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837199; c=relaxed/simple;
	bh=tFDvO15Mebnvmfdq0XPYH2VtssE1jRAQuVZNBRHfY/0=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBhWsJ7avGJI/gRxwwIyQHTd9d6G+LpNN8ugB1AVx47Gf7G7gI2SmqO35NLD6Q8fs8xZhCk8ReEgXnJsCb+18aVGYiyzHjJqbgpbJPlVCXvZC9GHbQFeApXBsis1njSswP2sgBQ3sC1RH7ld36zXOdsV6d6rt1z4P6+eJVzfZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=d58UWAuG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C9EE63F919
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719837195;
	bh=d0e/e2pXlpxb22nPKrMuU5Hax3H7AOyGMYL3diD46zE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=d58UWAuG4qx2AGva5p2nBSw9vPujmE18aaXtvS08C4Xxt3ErMELnDY2XyAW/yT/0H
	 8ghJ79gQu4EDcE1p19nVVv9EUV/k+yWrujDM9jcT3pf8ZYAHCNtNAkhlzJRBZkvtdZ
	 xnvrOxMs1GDO7vE2lwDjxwepTff/npUAnLCY880fdERbuR7AGpcTdUcn/1w3u0ljlR
	 NXVd1t9tMcw+KR/DjB9akR0j1AGGvZ4HvUWObSWqLXBX5OLVNCCmy3a+IMm/O7VLeg
	 N85qkXLc+EQ2XHHYwwXiqCZ++BgDKX1xwsQSESXVkm89Z5GLz10qoibvtBaUQGyKtA
	 lbMeSQ5bTcNpw==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43fb02db6d2so38875751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837193; x=1720441993;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0e/e2pXlpxb22nPKrMuU5Hax3H7AOyGMYL3diD46zE=;
        b=GyDqKJsZEb2tbceLHQkOgJX/AlvWSD+UL1N55wSdkdoPM5NzCmllpEXpg8lRPcDiKF
         fk2x88rarHB6JSL63o6ZFU0I1BEHyZEfA5jvFSAOaHRB1RUO4zKqBXdJp7sRNanhYCWu
         qFM4faoRc3uSZ4mLln+aZ0Gtha5iADHtERRU38ragsWXxUUFQoVzzLri5oEAx74qE3kZ
         kZIuN17xJX1QzHVZ3WVoakmXhADDeEcqawFGLMX2WsH4TZcTIpRiD/LGntzw1lRaEyz8
         V0ormhSoEbsH2uy1cZOOv+ZBiGLMQci/IezH2QtIecr3mQNoqFQfFStVYsNvsCTj6zDB
         dytA==
X-Gm-Message-State: AOJu0YxtcV18vaT20HyxbJFSXx7x3o8ybLWzcz6pE/k7qs8RJz94UQcU
	6h8ryqF507F7Gxs1+/dAOOAt59F1+EYmMn31cra0FiFkDXh25PnJ3+qkyTsHao8P6L5uTUBwv7Q
	HXJaRvw/a8o7IBKFTZQFASc6VqGsOcqu1AviBR9S1+5VpnG4xJegnY2Sudv7anFS5XJIeI6dJMf
	G8YsaaPO+RCnb40JslZCrnjAhe7PaT/+fJgE7wNHt3Mud68eCH+8n+
X-Received: by 2002:a05:622a:188e:b0:43f:ee9d:c2ce with SMTP id d75a77b69052e-44662e6a81cmr77375021cf.45.1719837193094;
        Mon, 01 Jul 2024 05:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh4KuzfoIjzU8YO1Hl9u0fOt1wzZ3+gb6jLWL+lbAdzwOQZo03t1//Q2PkHrWASmLQlr+nTGkCz6Z3Ea4CYF8=
X-Received: by 2002:a05:622a:188e:b0:43f:ee9d:c2ce with SMTP id
 d75a77b69052e-44662e6a81cmr77374811cf.45.1719837192686; Mon, 01 Jul 2024
 05:33:12 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jul 2024 12:33:10 +0000
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z9xF6_WCcg02xJJfu=UCOj=4m64BXvJTaV4vX09WLhc0w@mail.gmail.com>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
 <20240103132852.298964-2-emil.renner.berthing@canonical.com>
 <20240115173657.GA999912-robh@kernel.org> <CAJM55Z9xF6_WCcg02xJJfu=UCOj=4m64BXvJTaV4vX09WLhc0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 1 Jul 2024 12:33:10 +0000
Message-ID: <CAJM55Z-ds0ZtFCKnpFyGnWidSjj6eORW+5gBPBjdidJxSLynwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: pinctrl: Add thead,th1520-pinctrl bindings
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

Emil Renner Berthing wrote:
> Rob Herring wrote:
> > On Wed, Jan 03, 2024 at 02:28:38PM +0100, Emil Renner Berthing wrote:
> > > Add bindings for the pin controllers on the T-Head TH1520 RISC-V SoC.
> > >
> > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > ---
> > >  .../pinctrl/thead,th1520-pinctrl.yaml         | 372 ++++++++++++++++++
> > >  1 file changed, 372 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> > > new file mode 100644
> > > index 000000000000..d3ad7a7cfdd1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
> > > @@ -0,0 +1,372 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pinctrl/thead,th1520-pinctrl.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: T-Head TH1520 SoC pin controller
> > > +
> > > +maintainers:
> > > +  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > +
> > > +description: |
> > > +  Pinmux and pinconf controller in the T-Head TH1520 RISC-V SoC.
> > > +
> > > +  The TH1520 has 3 groups of pads each controlled from different memory ranges.
> > > +  Confusingly the memory ranges are named
> > > +    PADCTRL_AOSYS  -> PAD Group 1
> > > +    PADCTRL1_APSYS -> PAD Group 2
> > > +    PADCTRL0_APSYS -> PAD Group 3
> > > +
> > > +  Each pad can be muxed individually to up to 6 different functions. For most
> > > +  pads only a few of those 6 configurations are valid though, and a few pads in
> > > +  group 1 does not support muxing at all.
> > > +
> > > +  Pinconf is fairly regular except for a few pads in group 1 that either can't
> > > +  be configured or has some special functions. The rest have configurable drive
> > > +  strength, input enable, schmitt trigger, slew rate, pull-up and pull-down in
> > > +  addition to a special strong pull up.
> > > +
> > > +  Certain pads in group 1 can be muxed to AUDIO_PA0 - AUDIO_PA30 functions and
> > > +  are then meant to be used by the audio co-processor. Each such pad can then
> > > +  be further muxed to either audio GPIO or one of 4 functions such as UART, I2C
> > > +  and I2S. If the audio pad is muxed to one of the 4 functions then pinconf is
> > > +  also configured in different registers. All of this is done from a different
> > > +  AUDIO_IOCTRL memory range and is left to the audio co-processor for now.
> >
> > It is still not clear to me if each instance is a different programming
> > model or the same with just different connections. The latter should
> > be the same compatible string. That needs to be answered in *this*
> > patch, not a reply.
>
> Hi Rob,
>
> Sorry for the late response. I honestly don't know exactly what you mean by
> differenty programming models and what the difference is, so I'll need a bit of
> help with what you want me to write here.
>
> Any driver for the TH1520 SoC (not just Linux) would need some way to discern
> between the 3 pin controllers so they know how many pins to control and what
> pinmux settings are valid. Basically they'd need the data in the three
> th1520_group{1,2,3}_pins arrays in the driver and a way to know which of them
> to use.
>
> https://lore.kernel.org/linux-riscv/20240103132852.298964-3-emil.renner.berthing@canonical.com/
>
> Another solution would be to just have one compatible value, and then let the
> driver figure out which of the 3 pin controllers it's probing from the base
> physical memory address. That would work fine.
>
> A third solution would be to encode the data in those three arrays into the
> device tree, but I thought we didn't want to encode register information in
> device trees.

Hi Rob,

Any chance you could give me some advice on this, or should I just send it
again as is?

Other patchsets depend on this. Eg.:
https://lore.kernel.org/all/20240618-i2c-th1520-v3-0-3042590a16b1@bootlin.com/

/Emil

