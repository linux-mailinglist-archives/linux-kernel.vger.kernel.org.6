Return-Path: <linux-kernel+bounces-547882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB997A50EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A19165C44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFA266F0F;
	Wed,  5 Mar 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ayMv7PO4"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB29266F03;
	Wed,  5 Mar 2025 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213854; cv=none; b=Pg8Cttvb5TaiEwEgwbqYGuT3YV7JwkR0XdE1aoe2uYvqCvydxZhNdiZ+CMeIV438Hlry0d+gxXmqqRjGlaPPofGeSlhUQB0lRo7J2SPEhNlC8+6BTM2IJ97KojIXO2b7qC6y+4wPTVYMb1+J598TLVQraIlyrPaSrws9r55vHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213854; c=relaxed/simple;
	bh=jIbhpdAu56/1q1bMu6qwe0wIwmWzbhWIw8DRF5eEJto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ML0GYsdtpDlb6wnJA4ntb+EmJIAigl1GiOBCUxLq2uBwg52kCgOudWok2PEcTc1skdvM+7FgLRenvJO5rxLeQO1F98jL0itIgDu7TROTTI9wDRZHC3WxCl0O6b5zL82RNsMYniNZ5d1431AU/kBVMhUE2rd3JVmqV4YtQMdve3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ayMv7PO4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525MUjxj3981899
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 16:30:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741213845;
	bh=4kewPcEMUmFbsbrupfxd01igsHD0J5ywgLnA98niNvw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ayMv7PO4YzQUptJId8unXR0ZzDqG3IhsOz0eokbedD4ho/0uPtwo/iH6R64lWK6AT
	 XSR58tqfRDIO7Nvbc0I2/JAw2oLr8QMeTITV1jyeUU6Zn1hQ6dFw8GDMWmqdPAUhq1
	 KtbdK0ES+DmbzrTXvLNJuRKDN+xUoEdsq+QL9S38=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 525MUjHw085149
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 16:30:45 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 16:30:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 16:30:44 -0600
Received: from [10.250.148.85] ([10.250.148.85])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525MUc9c086007;
	Wed, 5 Mar 2025 16:30:40 -0600
Message-ID: <b6fdfe6e-dbd3-4dc8-acf2-f2983f150df1@ti.com>
Date: Thu, 6 Mar 2025 04:00:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth
 Menon <nm@ti.com>
References: <20250304102306.2977836-1-c-vankar@ti.com>
 <20250304102306.2977836-2-c-vankar@ti.com>
 <20250304153959.GA2654372-robh@kernel.org>
 <66283781-69d6-4d0a-ada4-3a6bf4744a37@ti.com>
 <CAL_Jsq++DUv5_LHg7sPNXDJZ84JtS94Rwr-WAb9hDWp6rJqZLQ@mail.gmail.com>
 <11982b12-a359-467a-a6fc-e39adccca413@ti.com>
 <CAL_JsqLb5hrYD_-dqW5ELtbXohd8a1UL7nOuP2a9ZhE+3+f=eA@mail.gmail.com>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <CAL_JsqLb5hrYD_-dqW5ELtbXohd8a1UL7nOuP2a9ZhE+3+f=eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Rob,

On 3/6/2025 3:44 AM, Rob Herring wrote:
> On Wed, Mar 5, 2025 at 3:43 PM Vankar, Chintan <c-vankar@ti.com> wrote:
>>
>> Hello Rob,
>>
>> On 3/5/2025 2:10 AM, Rob Herring wrote:
>>> On Tue, Mar 4, 2025 at 1:03 PM Vankar, Chintan <c-vankar@ti.com> wrote:
>>>>
>>>> Hello Rob,
>>>>
>>>> On 3/4/2025 9:09 PM, Rob Herring wrote:
>>>>> On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
>>>>>> DT-binding of reg-mux is defined in such a way that one need to provide
>>>>>> register offset and mask in a "mux-reg-masks" property and corresponding
>>>>>> register value in "idle-states" property. This constraint forces to define
>>>>>> these values in such a way that "mux-reg-masks" and "idle-states" must be
>>>>>> in sync with each other. This implementation would be more complex if
>>>>>> specific register or set of registers need to be configured which has
>>>>>> large memory space. Introduce a new property "mux-reg-masks-state" which
>>>>>> allow to specify offset, mask and value as a tuple in a single property.
>>>>>
>>>>> Maybe in hindsight that would have been better, but having 2 ways to
>>>>> specify the same thing that we have to maintain forever is not an
>>>>> improvement.
>>>>>
>>>>> No one is making you use this binding. If you have a large number of
>>>>> muxes, then maybe you should use a specific binding.
>>>>>
>>>>
>>>> Thank you for reviewing the patch. The reason behind choosing mux
>>>> subsystem is working and implementation of mmio driver. As we can see
>>>> that implementing this new property in mux-controller is almost
>>>> identical to mmio driver, and it would make it easier to define and
>>>> extend mux-controller's functionality. If we introduce the new driver
>>>> than that would be most likely a clone of mmio driver.
>>>
>>> I'm talking about the binding, not the driver. They are independent.
>>> Generic drivers are great. I love them. Generic bindings, not so much.
>>>
>>>> Let me know if implementation would be accepted by adding a new
>>>> compatible for it.
>>>
>>> Adding a new compatible to the mmio driver? Certainly. That happens
>>> all the time.
>>>
>>> I also didn't say don't use this binding as-is. That's fine too.
>>>
>>
>> Can you please review the following binding:
>>
>> oneOf:
>>     - required: [ mux-reg-masks ]
>>     - required: [ mux-reg-masks-state ]
>>
>> allOf:
>>     - if:
>>         required:
>>           - mux-reg-masks-state
>>       then:
>>         properties:
>>           idle-states: false
>>
>> required:
>>     - compatible
>>     - '#mux-control-cells'
>>
>> I think it won't disturb the current bindings and keep backward
>> compatibility with existing implementation.
> 
> Wasn't that the case before? There's nothing really different here.
> 

No, the binding before was not considering "mux-reg-masks" as required
property which was breaking actual dt-binding. In this binding, one of
the properties from "mux-reg-masks" or "mux-reg-masks-state" is required
which keeps the binding as it is unless someone wants to use
"mux-reg-masks-state".

Regards,
Chintan.

> Rob

