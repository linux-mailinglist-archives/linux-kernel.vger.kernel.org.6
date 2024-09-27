Return-Path: <linux-kernel+bounces-341426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0015987FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556A6B21FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA91891B7;
	Fri, 27 Sep 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QLSmztuc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2D17ADF9;
	Fri, 27 Sep 2024 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424132; cv=none; b=gY5zN6U45UzoIXIz+Ge5lHvRmDm8Hm9Sy/jkMPCSJvDFstUZYYEA2xthbVWryjAs3pjZJyrNad4DiW0oEqxEF9KtRFZciG6LX5wAdFw3LzDFdbCqMH0Z/zO0r6NhenYHAb/xafLN3+Xmv3i7A4hDQsJGubaURSwmEy0u+JJxu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424132; c=relaxed/simple;
	bh=UjG+AW3XkETGoYj/hG0y6HDZiabj/vW+w6RW0BAihzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ+B372ra/YP4cyYG4Axjg+qEQv3Qsb+Wq641SMyUJmOiivkKSIgdI3w04nkDRqEMXaL5p4tWWxDsO7KF6nOC/LkQEnqoSQpAjciVifPI2gyOTa7B1taR6U/Wem/dXeJQzdngOZqQ5coUC43PkwO6fGRlpideZv98bKFrnNJ9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QLSmztuc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VrHmD3qjrTGLP9NWMXSPhKgSjDl2KVnQsH7jouH3UsI=; b=QLSmztucKNR9BO55sYkVhudf8M
	zxv4k5lSfkeSk9O/fAfcX+6YrDVdYAJ4BXUdhMzUt2GlIDFp/VFi+wKbizLPemDqINc5q+BdwGlUm
	KAnzGihqcTR1VEqDfA2GidGdVaB2FTCyLA8yd7BT4TW8+UoXXAbiaZo2ii5a4iBGMkQnOXWyl3spz
	+gJXa6F4pqt+uGWneO8VsAP4tnIbY/vMfzfv1OvTOw+xB/IDp/iSneW81xEAthSAqdmYAKW0MP8O5
	N3L0b4Ay2DAgQ3cq0ZE9q7Jf/H1RL4z47VoVXe7EyTTu8/MQDeH6/vscyWyejC0MGjVqwVs6UNSYX
	kH7HbgnQ==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1su5vT-00009l-Ez; Fri, 27 Sep 2024 10:02:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Frank Wang <frawang.cn@gmail.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
Subject:
 Re: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add rk3576
Date: Fri, 27 Sep 2024 10:02:05 +0200
Message-ID: <20816071.Yz81rIOvuz@phil>
In-Reply-To: <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
References:
 <20240926103223.29538-1-frawang.cn@gmail.com>
 <7944f4dd-96f0-40df-8c91-523409e3cb20@gmail.com>
 <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Krzysztof,

Am Freitag, 27. September 2024, 09:30:30 CEST schrieb Krzysztof Kozlowski:
> On 27/09/2024 09:01, Frank Wang wrote:
> > Hi Krzysztof,
> > 
> > On 2024/9/26 22:19, Krzysztof Kozlowski wrote:
> >> On 26/09/2024 12:32, Frank Wang wrote:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - rockchip,rk3576-usb2phy
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          minItems: 3
> >>> +          maxItems: 3
> >> Read one more time the example I gave you. Top-level constraints are
> >> saying max one clock.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Sorry for overlooking this, I will set both "clocks" and "clock-names" 
> > to true, and add the else case below the above codes for the "old" SoCs.
> > Just like the below.
> > 
> > -  clocks:
> > -    maxItems: 1
> > +  clocks: true
> > 
> > -  clock-names:
> > -    const: phyclk
> > +  clock-names: true
> 
> For the third time, read the code I gave you. Do you see something like
> this there? Why doing all the time something different than existing code?

On vacation right now so late to the party, and somewhat confused :-) .

I've tried to find the code you mentioned, but did fail.
In [0] you mention "maybe oneOf". The other replies in that version were
about the ordering needing to stay for the older phy variants.

[1] in v2 has that NAK thing and [2] from v3 references that example again

I am probably just blind, but could use a pointer.


Because I think going with a
  - if:
      properties:
        compatible:
          contains:
            enum:
              - rockchip,rk3576-usb2phy
    then:
      properties:
        clocks:
          minItems: 3
          maxItems: 3
        clock-names:
          items:
            - const: phyclk
            - const: aclk
            - const: aclk_slv
    else:
      properties:
        clocks:
          maxItems: 1
        clock-names:
          const: phyclk

block should actually make sure each variant will check for the appropriate
number of clocks?

And having clocks:true in the main part then makes sure that the property
is not getting marked as:
arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dtb: usb2-phy@0: 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/phy/rockchip,inno-usb2phy.yaml#


Heiko


[0] https://lore.kernel.org/lkml/snccizbw6thn3lhwad4xppp7vqii4p56ttl2gufwc3ke7vfckf@e4b7nvwwtdfr/
[1] https://lore.kernel.org/lkml/2a4200ac-3ea2-4449-94ac-c4b9f37ad800@kernel.org/#t
[2] https://lore.kernel.org/lkml/ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org/



