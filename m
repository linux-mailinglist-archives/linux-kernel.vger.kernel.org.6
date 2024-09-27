Return-Path: <linux-kernel+bounces-341517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678198810B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979FA1C22807
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BDB189906;
	Fri, 27 Sep 2024 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lhAIHtlK"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E86183CAD
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428011; cv=none; b=LFeYLL04teJsaJkaju9R6MRoHz7wyDIeqxsZJQ9uDaJ914nrGOAiWXB1ylRgdVeA6zE6+0ca0pI4xWW2xOTaNmSpeLSIeghRuP3czEZ1Q4DAz/tINtP+89nHymfSEGICJArMGDcerRUFpRC7g4u5G1GIP/uA7zvqVcxrw2kGmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428011; c=relaxed/simple;
	bh=p/tL/mEtgxya4nQTMT45w11AbEgp01edlss3aQNmTWA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiJ4mZgq5tk3AHMk6Yk3VNMpDV0f5FQCS9ebX90dtI9VzMlgPJQBMVe+djNLHOlrpDqD6AzxOCVjfGWHqidU8a+66ZYgpJucWy6bDha/JPJ/ZwIFNMF11IjDz9QRfRqSvjQRMqpR5/deiRl2CE0TXrDtKZpJl829MlUGIa2CU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lhAIHtlK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D5CBA3F135
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727427999;
	bh=TdWwWyYx3NSL/g/B28NaT9+skLBhcn0OqBIgUz2KJ8c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lhAIHtlKLzOc98JwocjSQC3GsGpOljY/wcQVby16/ExexJePfRoeV8NB0ec7sadBA
	 oal1Fcpujpirm3N9zqGn7exhqxfdG4s21CtEZTEWWGIz/vt7kn6MHDD6UzymOV8xlZ
	 7PuwRE1/jknCpLZczUgt6zumK0dQ63AdlAyryKayHOPp60UkEV2edSgeFz9DZqxmtP
	 peKXrLeFLJzdIF5ZgsY49LND93nxIBpKi2uPXzoilE6M+G2rb6sja50f5kfbv4/XD1
	 n5jJZ1sPB61ZcH9OZ9ogUdkXSJkmVo2KAcnaIX2DszTxkJc9pus8U0q4486WJb90Y4
	 WwC+muPh+jukA==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-286fa354e34so1311376fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427998; x=1728032798;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdWwWyYx3NSL/g/B28NaT9+skLBhcn0OqBIgUz2KJ8c=;
        b=aUY5W1H1j1EHyBhza3izyaUcwayPpw7s/fjYjrmeBwFmxn85Ci22NebeMSHp0dy4g5
         qHmJg3i6qp1ZRmmS1Xfc/vv6OOhhhYUDJNsy9XKVp6pv6kH1dYXPk0euwxcii1Nnnr25
         QXMECSMMbDu8AFKhi3lBDRVcZhI2Jv8bzdX3nYUXerLC9UpjBfjFBjMZKzy38bSwRL+5
         Gc0X9cjMXnFcn//OU+ELNa/bD1mMxptznsWOrgZ1lnRGFLg2wEqPdCaCjRsL8WRjkqdW
         /mBEofJ6QLpulHbQGsZz3UCYPLu1XoQMqcRv+OcSzryTRHdEY/6QE2OehV7yao2M5WG/
         pULQ==
X-Forwarded-Encrypted: i=1; AJvYcCXntvxbSYFbDLa4m98K2qtDSeDFYnrhrmmlQy49XDqxdZzC62vHWPnMN2t83H6QXc630nnvTIwPhs8vmCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNhkHwQWg7i2hWazDLnfpvbUpRDVzQjMpILk4yef8/RQwTrxy
	mdJ0WBdXT9QB9c2h5J6ENC7fJAPYNiSCVevcgYNJig5x7hRhTryOMbeqr2EY/pqwEZhmV3X6ify
	sU3xNrcdr8AqFpfdmpbNabgUhhLTRmOgMQMB4iVpDP+uoARP62Uvtc6nsxZ430AM0xUrsK6kvXn
	TknFHi4CBBKNV6Uqh/kRuH5F+usFFNoTaCAmJMY/eUUDVhvRIR9Gmd
X-Received: by 2002:a05:6871:1c7:b0:277:fd73:8f82 with SMTP id 586e51a60fabf-28710c28d08mr1801227fac.45.1727427998419;
        Fri, 27 Sep 2024 02:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv+HoVG+UamQzP9HYGm4dvtX0uDQArn9ex/l2o6/iZbKaH7H7PMWWqDndToxE25AX6dEyIqQ8K4thbHVn/x+E=
X-Received: by 2002:a05:6871:1c7:b0:277:fd73:8f82 with SMTP id
 586e51a60fabf-28710c28d08mr1801204fac.45.1727427998028; Fri, 27 Sep 2024
 02:06:38 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Sep 2024 02:06:37 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZvYJfrPx75FA1IFC@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com> <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1> <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch> <ZvYJfrPx75FA1IFC@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 27 Sep 2024 02:06:37 -0700
Message-ID: <CAJM55Z8DeGJs=ASgdErEVWagy_f8JMWVe_TEWJWAcrUbzoDjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
To: Drew Fustini <dfustini@tenstorrent.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> On Thu, Sep 26, 2024 at 09:30:32PM +0200, Andrew Lunn wrote:
> > On Thu, Sep 26, 2024 at 12:13:06PM -0700, Drew Fustini wrote:
> > > On Thu, Sep 26, 2024 at 08:39:29PM +0200, Andrew Lunn wrote:
> > > > > +&mdio0 {
> > > > > +	phy0: ethernet-phy@1 {
> > > > > +		reg = <1>;
> > > > > +	};
> > > > > +
> > > > > +	phy1: ethernet-phy@2 {
> > > > > +		reg = <2>;
> > > > > +	};
> > > > > +};
> > > >
> > > > Two PHYs on one bus...
> > >
> > > Thanks for pointing this out. I will move phy1 to mdio1.
> >
> > ???
> >
> > Are you saying the two PHYs are not on the same bus?
>
> Sorry, this is my first time working on an Ethernet driver and I
> misunderstood.
>
> Sipeed only shares the schematic of the baseboard for the LPi4a [1].
> There are pages for GMAC Ethernet0 and GMAC Ethernet1. Each shows 4 MDIO
> differential pairs going into a SG4301G transformer.
>
> I believe that RTL8211F-CG phy chips are on the LM4A SoM board which
> contains the TH1520 SoC. Unfortunately, Sipeed does not provide a
> schematic of the SoM so its hard for me to inspect how the phy chips are
> wired up.
>
> Vendor kernel [2] that Sipeed uses has:
>
> 	mdio0 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "snps,dwmac-mdio";
>
> 		phy_88E1111_0: ethernet-phy@0 {
> 			reg = <0x1>;
> 		};
>
> 		phy_88E1111_1: ethernet-phy@1 {
> 			reg = <0x2>;
> 		};
> 	};
>
> so I think that does mean they are on the same MDIO bus.

It depends how you look at it. The SoC has two MACs and they can both
control their own MDIO bus. However MDIO of both MACs are pinmux'ed to
the same pins on the SoC. So the solution above just mux the pins to
GMAC0 and let that control both PHYs. Alternatively I guess one could
let each GMAC control their own phy on their own MDIO bus and then
switch pinmux settings everytime you need to need to talk to one or
the other.

/Emil

