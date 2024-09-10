Return-Path: <linux-kernel+bounces-322715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E0972CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B62E1C23E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1F18787C;
	Tue, 10 Sep 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mP9LecOs"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DC16A957;
	Tue, 10 Sep 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958837; cv=none; b=Muxrz07phiiyFjmVp4O10sRxynHwBYM2KKl668t5VXNxQfVobIKV0Mb6vEG4aiW6n9sjcQU+M84vnvk2dInLtzDnbUP/eb26cX2BM8evDzZWL1+2LBeC6Tgo9OCMHF8ptNiNidLSXszabQnZj7k2lnsCLumx2QYhpBmfYobnjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958837; c=relaxed/simple;
	bh=gKIOXWk8XFw+NBoYrB/b5DFLbg0bA9+VpNV/DgItObs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+mz3Yvna1mVOMZfI2tz5cHtaTARRUdfTnAiy3GAUzDZ0LST+MJ174xQ6ujzuqqFRtH0JD3aa5LmEoM4EvQ68v+U1KsQlwmzfnemjP2iNyEIBQEGif4hzeMg8Q608OOwDXckh35WbK9tk7Gsdtb6uGhmGLPu62pVJVqG1tChde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mP9LecOs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725958834; x=1757494834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKIOXWk8XFw+NBoYrB/b5DFLbg0bA9+VpNV/DgItObs=;
  b=mP9LecOsaphvb6SIrBRFITBOU96t0eGhSsFJCcFNXEGRHJpsKxUw5bDT
   Ua5IJHe2il2iW/Rdv1cA0elreP0SeZ9ieNd1suSqC9rkEZ43VX50PucDx
   MPE+5UQwldLVQKJFR+4MWj33YZYM0k5jLOhVdutuaSNZbjiXoIO9fGeHY
   cHpASw9WcZhbu2QyohE1nZwAB26S8LzXdeFx2LzPjHCjFpYiteacjzfia
   vrK31tMWH00iysQf+nb0wP6W5Y2bFveqjpfF2nd9UGE4l6vXLGn/U27tf
   jvyUKKEnpE9KBbRX/WeUjrJdJlowO9yFNf4QacNTL8TjaPQ479DBFNEuF
   A==;
X-CSE-ConnectionGUID: Hr8gDLTiSAu2y7wQ9bR3sA==
X-CSE-MsgGUID: lkbXYb+CRoWQUYO7YRv/qw==
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="34688000"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2024 02:00:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 10 Sep 2024 01:59:55 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 10 Sep 2024 01:59:53 -0700
Date: Tue, 10 Sep 2024 08:59:52 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] dt-bindings: phy: sparx5: document lan969x
Message-ID: <20240910085952.azwmrvuntyvuc3nb@DEN-DL-M70577>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
 <20240909-sparx5-lan969x-serdes-driver-v2-8-d695bcb57b84@microchip.com>
 <wd3gzn3lpmw64qor3xslif6rnp7htycfhu33pa2xpxvv6mrwqe@nv6pcwkstywe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <wd3gzn3lpmw64qor3xslif6rnp7htycfhu33pa2xpxvv6mrwqe@nv6pcwkstywe>

> >  maintainers:
> >    - Steen Hegelund <steen.hegelund@microchip.com>
> > +  - Daniel Machon <daniel.machon@microchip.com>
> >
> >  description: |
> >    The Sparx5 SERDES interfaces share the same basic functionality, but
> > @@ -62,12 +63,26 @@ description: |
> >    * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
> >    * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
> >
> > +  lan969x has ten SERDES10G interfaces that share the same features, operating
> > +  modes and data rates as the equivalent Sparx5 SERDES10G interfaces.
> > +
> >  properties:
> >    $nodename:
> >      pattern: "^serdes@[0-9a-f]+$"
> >
> >    compatible:
> > -    const: microchip,sparx5-serdes
> > +    oneOf:
> > +      - enum:
> > +          - microchip,sparx5-serdes
> > +          - microchip,lan9691-serdes
> > +      - items:
> > +          - enum:
> > +              - microchip,lan9698-serdes
> > +              - microchip,lan9696-serdes
> > +              - microchip,lan9694-serdes
> > +              - microchip,lan9693-serdes
> > +              - microchip,lan9692-serdes
> 
> If there is going to be a new version, keep rather increasing/growing
> alphanumerical order, but no need to resend just for this.

Ack.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
>

Thanks for reviewing!

/Daniel

