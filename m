Return-Path: <linux-kernel+bounces-277574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1594A31E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A56287EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881C1CB323;
	Wed,  7 Aug 2024 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="NfObCo3G";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="NfObCo3G"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027A1C9DDA;
	Wed,  7 Aug 2024 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020241; cv=none; b=WB7tJXOGc93M6d8NYKn3pGU6+yK4rfeYdyBxLUtaTj2PE7l3IC+MWOjtcfBw5lphT7+01405tgjpVA/Luy1hvwd38mrOBCq5IpnT+sJKg365J6QxVxXkfRNdHrXHTz5ITjq/3chO2D2PlRIJoogs4AXWX1reDzGiHYQFGSq2+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020241; c=relaxed/simple;
	bh=u/Mw4fyAlodjRrrwnrvrPUdoZ1mdq0tHaoL1PPbqask=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnMdb1/83db7wd/OTLkjfCbXL8JEmA3PK45xFXJhro6MA3hWzT7cTpUXhN2/upEdurAbxIf3OfIqCRHuNNIaulQw7+mMXlOYByt3HF3WVk6VUynijsWNv11rPlTjg/88jm8fmxhfVoYtgirvdzoiSK4xg8VqmHGay6fR/V+Sz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=NfObCo3G; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=NfObCo3G; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1723020238; bh=u/Mw4fyAlodjRrrwnrvrPUdoZ1mdq0tHaoL1PPbqask=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NfObCo3Gsdd/bFYmVX700F6w5s3TNGxuCtVKkTZz/I1+ht43PkxUXrnxre7VVhWmW
	 UaGKH1KySEP3NDTtpJFbT69uAIhIm3qTUMY9QbBh2lgJv3Oq2+AXAXPFhqESgdlLi7
	 8po+oZ+Jdcf87kcu3fFQ8WeBEZfOYOni/jLva5CPyK2Yzvz1zJ+gzQrKEMigDg+CFH
	 /XZ4Ieera2i9xjD2jY9+7MxO/Sq2CYAAIAAuu8eBQNcd85/Cx1wRCc3B/4ZC2QwK4a
	 wtkgYZ5FLuz+gmLjPDm6sh4PWnyH+yeDTrpEl+1KnIkQsi03xBDkDhtZMTD9kgC+zX
	 CkcuS7Qv4wN9Q==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 2A1644794CA;
	Wed,  7 Aug 2024 08:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1723020238; bh=u/Mw4fyAlodjRrrwnrvrPUdoZ1mdq0tHaoL1PPbqask=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NfObCo3Gsdd/bFYmVX700F6w5s3TNGxuCtVKkTZz/I1+ht43PkxUXrnxre7VVhWmW
	 UaGKH1KySEP3NDTtpJFbT69uAIhIm3qTUMY9QbBh2lgJv3Oq2+AXAXPFhqESgdlLi7
	 8po+oZ+Jdcf87kcu3fFQ8WeBEZfOYOni/jLva5CPyK2Yzvz1zJ+gzQrKEMigDg+CFH
	 /XZ4Ieera2i9xjD2jY9+7MxO/Sq2CYAAIAAuu8eBQNcd85/Cx1wRCc3B/4ZC2QwK4a
	 wtkgYZ5FLuz+gmLjPDm6sh4PWnyH+yeDTrpEl+1KnIkQsi03xBDkDhtZMTD9kgC+zX
	 CkcuS7Qv4wN9Q==
Message-ID: <559ba896-4e0b-4202-822b-b68d456db773@mleia.com>
Date: Wed, 7 Aug 2024 11:43:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: nxp,lpc3220-timer: Convert to
 dtschema
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240731074544.208411-1-animeshagarwal28@gmail.com>
 <d1ac7446-143b-40d3-9f12-f734ab7cc31f@mleia.com>
 <1477822a-9622-4e21-aaf4-92877050ee82@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <1477822a-9622-4e21-aaf4-92877050ee82@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240807_084358_200648_98D56AE8 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message. 

On 8/7/24 09:02, Krzysztof Kozlowski wrote:
> On 06/08/2024 22:13, Vladimir Zapolskiy wrote:
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/lpc32xx-clock.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    timer@4004c000 {
>>> +        compatible = "nxp,lpc3220-timer";
>>> +        reg = <0x4004c000 0x1000>;
>>> +        interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
>>> +        clocks = <&clk LPC32XX_CLK_TIMER1>;
>>> +        clock-names = "timerclk";
>>> +    };
>>
>> I would appreciate, if you can use scripts/get_maintainer.pl in future.
> 
> It was used and everything is fine. What are you complaining here about?

This makes sense, sorry for the noise, and thank you for the correction!

--
Best wishes,
Vladimir

