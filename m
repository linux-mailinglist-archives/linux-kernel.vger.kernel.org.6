Return-Path: <linux-kernel+bounces-390668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1429B7CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39C32822E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565531A08B6;
	Thu, 31 Oct 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="hwRJQmwr"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B2127B56;
	Thu, 31 Oct 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385320; cv=none; b=upY9dS34miT674d+5GrvfWo2dx3G+3KlNdYfgMV7r+0EcT75sJq1CJtiMFZCxO5XBHBLYcLmF+K3S4PWTAW8SA70v3hEn+u6X4Hk1R0GkUBeY+AkVKoQPxiJjS+wkdKuomGplkRie1FB/WsrCNEmZjdG6HCJcpiZD29OcEcZu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385320; c=relaxed/simple;
	bh=6n3NaF0whd9qg4xGC826BnFf5iZrFxIuvNVTdKeKwyM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Pin8wL+Uqx0yj+rRGWwK0EnP29rYraJYgiO6zaUbzOn1QEeq1Y4KWjMj4IErlaWmiVORmQZ9/xs7SdLvicvjK1Zg9B9s5TXLJVFAwp454uNGekGzaVzdtOR7u3Jpk8APGB/ZBwEuzqhivl7bKN+4xxKHxtpjyfVFgaGVx1NLwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=hwRJQmwr; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730385317;
	bh=6n3NaF0whd9qg4xGC826BnFf5iZrFxIuvNVTdKeKwyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwRJQmwrFYT6ykY/ekESOcjW3v6tFj2bE6QIxkApk2LVsQ51qNSthzZqb8dSJ+z5G
	 H/GcYPVNWoY/Ej3t9YBiWx1xYdWb6RL8h3g+EnMpb88MPsfadobQIrk//LevFeQxl6
	 hNOunhUXMtH5rxkINUbaIcrHxGjbEMtDQGnEZEyuYd01qaN9o9Cqx6Ti8krK3Meunw
	 9F/H9rU1hJV/NBS1di/pFs0U/A1DD0qHYUupljp46SIEe010i+rQ4JXVEeh+TudFQ9
	 22NmFJ45YBztNlsIUaMUnCzw52CxxEToVHsQjof6SdjVhDQteeKKOCaTpM+9Z8Wjdf
	 Nb2hnr4GwfkRw==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Oct 2024 11:35:14 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette
 <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar
 <vireshk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li
 <tiny.windzz@gmail.com>, Parthiban <parthiban@linumiz.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: phy: sun50i-a64: add a100
 compatible
In-Reply-To: <20241031113651.4ab4f8c7@donnerap.manchester.arm.com>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-4-masterr3c0rd@epochal.quest>
 <20241031113651.4ab4f8c7@donnerap.manchester.arm.com>
Message-ID: <f33a995dc08e03af06f3f78864d77503@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/31 8:36 am, Andre Przywara wrote:
> On Thu, 31 Oct 2024 04:02:16 -0300
> Cody Eksal <masterr3c0rd@epochal.quest> wrote:
> 
>> The USB PHY found in the A100 is similar to that found in the D1. Add 
>> a
>> compatible for the A100.
>> 
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Careful with that: you made quite some changes compared to v1, which 
> Rob
> ACKed, so I wouldn't carry over his tag here.
I had made a note of this a few days ago, but it slipped through my 
pre-submission review. I'm terribly sorry; won't make this mistake in 
the future.

- Cody

> Cheers,
> Andre
> 
>> ---
>> Changes in V2:
>>  - Update binding to allow using the D1 as a compatible.
>> 
>>  .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml     | 10 
>> +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml 
>> b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
>> index f557feca9763..21209126ed00 100644
>> --- 
>> a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
>> @@ -15,9 +15,13 @@ properties:
>>      const: 1
>> 
>>    compatible:
>> -    enum:
>> -      - allwinner,sun20i-d1-usb-phy
>> -      - allwinner,sun50i-a64-usb-phy
>> +    oneOf:
>> +      - enum:
>> +          - allwinner,sun20i-d1-usb-phy
>> +          - allwinner,sun50i-a64-usb-phy
>> +      - items:
>> +          - const: allwinner,sun50i-a100-usb-phy
>> +          - const: allwinner,sun20i-d1-usb-phy
>> 
>>    reg:
>>      items:

