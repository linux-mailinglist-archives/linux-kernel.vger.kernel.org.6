Return-Path: <linux-kernel+bounces-277570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA394A320
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154C0B21CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2811C9DE6;
	Wed,  7 Aug 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LA5DFCsr";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LA5DFCsr"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2961C823E;
	Wed,  7 Aug 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020105; cv=none; b=uk2zutltZaQC4frSafnQu7meHdPGx6zJyNAfwrs7BRsSeT+U6/SqAfwmlV4Kx2P/9CPjDDbH1lNJVitD8Bumcx+xIQY87V8GDZi8vKtHFsf3CKIuAjCNpfhYFuB5C3rJB7gJoD4vGZ1t+3/NmxBJtoa70O1mMuXodB11l+GVWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020105; c=relaxed/simple;
	bh=K09HiZS7I0UslB7a5LuIle3oyJ7XG+v8URc4Dr4wmyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzPVu+vjOll+R9yjq5ezm0XVIJH07XrC4bBX2IeLiiE7ZYY+CycF6An3riIXMmJS90dpvejEnJXFCT41Oa0JlUFrzeUk53ss6UjvPmDVoLWsraiG7+CSe4HSNNDwIVJg7YONzni6025owYZl6N+JQPdqn28MT2C0Zjs3lnGyF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LA5DFCsr; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LA5DFCsr; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1723020101; bh=K09HiZS7I0UslB7a5LuIle3oyJ7XG+v8URc4Dr4wmyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LA5DFCsrvbesxP+CM/oxMGJVo8YfrJfZFGThMui+De7YS9IqTf+HCew7y5MYCLmYi
	 huZJKJRIHVyb5ZZPvhytPLgv+DNG5cxYMyPaTUGjtZFeEstwGPH/nzrgNxEGUtnFBs
	 Jv78ySKWp7lIpZ9iYZQQN8MmZSKxZ5NHIRx6UqvlsBtRcTZyBKJi83scHaZOCkzMId
	 OUnUzA+qDIkDGaqa0mjpTOl+Qq+sKaxeXyBE2E5JJC4+MSdw6AQY2osDsivrri9ARV
	 oNajCzt+BcMENm7qDR3al3CmQYMXPN4YpMAd22U6hSpaaxLCY8MIsPrRQdhDEJhSBr
	 HjeTRYngHXz+w==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 4CE4B4794CA;
	Wed,  7 Aug 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1723020101; bh=K09HiZS7I0UslB7a5LuIle3oyJ7XG+v8URc4Dr4wmyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LA5DFCsrvbesxP+CM/oxMGJVo8YfrJfZFGThMui+De7YS9IqTf+HCew7y5MYCLmYi
	 huZJKJRIHVyb5ZZPvhytPLgv+DNG5cxYMyPaTUGjtZFeEstwGPH/nzrgNxEGUtnFBs
	 Jv78ySKWp7lIpZ9iYZQQN8MmZSKxZ5NHIRx6UqvlsBtRcTZyBKJi83scHaZOCkzMId
	 OUnUzA+qDIkDGaqa0mjpTOl+Qq+sKaxeXyBE2E5JJC4+MSdw6AQY2osDsivrri9ARV
	 oNajCzt+BcMENm7qDR3al3CmQYMXPN4YpMAd22U6hSpaaxLCY8MIsPrRQdhDEJhSBr
	 HjeTRYngHXz+w==
Message-ID: <605b5ecc-a808-40b5-a532-9f373032c9c4@mleia.com>
Date: Wed, 7 Aug 2024 11:41:40 +0300
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
 <4210df09-1625-4865-a80c-8b38056ce172@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <4210df09-1625-4865-a80c-8b38056ce172@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240807_084141_348939_8BD894E0 
X-CRM114-Status: UNSURE (   7.94  )
X-CRM114-Notice: Please train this message. 

On 8/7/24 09:01, Krzysztof Kozlowski wrote:
> On 06/08/2024 22:13, Vladimir Zapolskiy wrote:
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: timerclk
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>
>> Since there is always just a single supply clock, there is no need to
>> specify "clock-names" as a required one, please change it.
> 
> ??? That's a conversion. Why do you expect changing several DTS files
> and maybe also driver? That's not needed for conversion. No.

I do not expect changing any DTS files, why? But I would be glad to see that
the clock-names property becomes optional in the first place and therefore
before the conversion.

--
Best wishes,
Vladimir

