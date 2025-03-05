Return-Path: <linux-kernel+bounces-547817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BCA50DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B807A6033
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F825D1FF;
	Wed,  5 Mar 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="axxSTK6e"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105525C71D;
	Wed,  5 Mar 2025 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211028; cv=none; b=Bs4/YUo2SHxGP4Tct4yThFIK0+s1+eQd4Ev7y5TURlki600rBW0BoZ6MhWj38/EvMA5Kd3GMVN+lqeJy+io3k79NsehAW1PlONcepNr5P9LlthbrRrJihG9BrAZUOzUml+bga31L9R1Ma/VYja3GswdC/5agjAfSIibBnM6TwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211028; c=relaxed/simple;
	bh=Kiw7vrhGC9Tr20MBqv3aGeVldfht4lH/YDUtMVAiVnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HhELV8ojoBlh7c1FisvEPfWG9cDnjGIbCjtFbh9WF15p0Kp8YQEg1g4om2s89cZeAEJ0HvBpaEBzwSCGDoCeBpvn1LH9dFQfVBQdGSw6+tJq8gcsuWMUfwoGbFTN6l043S5ssXrDHwx+8Lwylg0+Jvgx1tJ8PZ7W9UZ+r19aeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=axxSTK6e; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525Lhcoo3520081
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 5 Mar 2025 15:43:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741211019;
	bh=5gKsqhkj3z4aOY8JR1GfRGtUkvMlV0bDAct/H2T8opg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=axxSTK6ey9ptT04JWhEn+Rz2RMp8JtYQZeIgOxT1wgDIilACd55C9ZNn8VyrVENq5
	 9IIBnJHB1lQrJfh3dKGFrK0tdWkrjwiiQmnD8XaFBlZye5FFhKZjb4PCkYLdxPOIv1
	 NdeLkqdaTwJPbYsJTjnOZ2PiQVxhXTXmj+EETXSA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525Lhcnr004323;
	Wed, 5 Mar 2025 15:43:38 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 15:43:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 15:43:38 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525LhXF5093926;
	Wed, 5 Mar 2025 15:43:34 -0600
Message-ID: <11982b12-a359-467a-a6fc-e39adccca413@ti.com>
Date: Thu, 6 Mar 2025 03:13:33 +0530
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
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <CAL_Jsq++DUv5_LHg7sPNXDJZ84JtS94Rwr-WAb9hDWp6rJqZLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Rob,

On 3/5/2025 2:10 AM, Rob Herring wrote:
> On Tue, Mar 4, 2025 at 1:03 PM Vankar, Chintan <c-vankar@ti.com> wrote:
>>
>> Hello Rob,
>>
>> On 3/4/2025 9:09 PM, Rob Herring wrote:
>>> On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
>>>> DT-binding of reg-mux is defined in such a way that one need to provide
>>>> register offset and mask in a "mux-reg-masks" property and corresponding
>>>> register value in "idle-states" property. This constraint forces to define
>>>> these values in such a way that "mux-reg-masks" and "idle-states" must be
>>>> in sync with each other. This implementation would be more complex if
>>>> specific register or set of registers need to be configured which has
>>>> large memory space. Introduce a new property "mux-reg-masks-state" which
>>>> allow to specify offset, mask and value as a tuple in a single property.
>>>
>>> Maybe in hindsight that would have been better, but having 2 ways to
>>> specify the same thing that we have to maintain forever is not an
>>> improvement.
>>>
>>> No one is making you use this binding. If you have a large number of
>>> muxes, then maybe you should use a specific binding.
>>>
>>
>> Thank you for reviewing the patch. The reason behind choosing mux
>> subsystem is working and implementation of mmio driver. As we can see
>> that implementing this new property in mux-controller is almost
>> identical to mmio driver, and it would make it easier to define and
>> extend mux-controller's functionality. If we introduce the new driver
>> than that would be most likely a clone of mmio driver.
> 
> I'm talking about the binding, not the driver. They are independent.
> Generic drivers are great. I love them. Generic bindings, not so much.
> 
>> Let me know if implementation would be accepted by adding a new
>> compatible for it.
> 
> Adding a new compatible to the mmio driver? Certainly. That happens
> all the time.
> 
> I also didn't say don't use this binding as-is. That's fine too.
> 

Can you please review the following binding:

oneOf:
   - required: [ mux-reg-masks ]
   - required: [ mux-reg-masks-state ]

allOf:
   - if:
       required:
         - mux-reg-masks-state
     then:
       properties:
         idle-states: false

required:
   - compatible
   - '#mux-control-cells'

I think it won't disturb the current bindings and keep backward
compatibility with existing implementation.


Regards,
Chintan.


> Rob

