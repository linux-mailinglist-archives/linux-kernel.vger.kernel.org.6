Return-Path: <linux-kernel+bounces-234165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C286991C308
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A3D1C2206E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E21C8FA2;
	Fri, 28 Jun 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OSxY7Xll"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7611DDCE;
	Fri, 28 Jun 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590294; cv=none; b=SNBt9EoSZmwfeDZ7mVqL01uwEp1L2IR/48sOxKOkiWHIu0FZ3xm1sX1M7KNli499WdbXxAbr+zvQ4w7YHEFUuXu6ecT+gh03DS5Xz+xq8uxPniK8B9oqPpD6XSD4Ay6DUFhoB7lIBZ/9XZa/j5TBjhVWLX1xP5rwV7wKdcp5L9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590294; c=relaxed/simple;
	bh=qSyfUZRhIYm81WysBaE9QTBFV50mLFB3nk25UK46qyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wp075KI/ySHfGghIFsvPlsvk5SpUchCYadx1JAdpyhyt/CqVn6yZkrZg31qudXaZQMJ5HbJiBZrjicrqsXMvLBUO8uag9VfrKtJiSLXzTFNI/QhTIZWfhj6GPT6JaIBL4p2qMtdT3sd9l56aqJMcg886cj7cJgP3SfN4C7GiSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OSxY7Xll; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFvr26011342;
	Fri, 28 Jun 2024 10:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719590273;
	bh=1WLmlIL5ljAVKXiYskw3f7MwXsEfMQXSwRhFlqHHNtU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OSxY7XllP/UBKGNuyCwEqtB2tr0G77ZSkUw9UOl5WWEh5EBtdhDXhWHs4wO/tYCZr
	 WCmgnfHVRGPBk5ju7y6XgyFdbAouWZeLIQ8eQOloIc57a8h0q99uu7beZhFYYh05sw
	 /SWFRBc2P7RGAChkZS4cbjVAKe6fKclnBPSCZrkU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFvr7o012400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:57:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:57:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:57:53 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFvlHh028474;
	Fri, 28 Jun 2024 10:57:48 -0500
Message-ID: <64b78ba2-776c-1de6-4c13-001d11000ff0@ti.com>
Date: Fri, 28 Jun 2024 21:27:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Add global CMA reserve area
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Randolph Sapp <rs@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, "Khasim, Syed Mohammed" <khasim@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
 <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew, Vignesh,

On 24/06/24 22:03, Andrew Davis wrote:
> On 6/14/24 12:58 PM, Randolph Sapp wrote:
>> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
>>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
>>> These SoCs do not have MMU and hence require contiguous memory pool to
>>> support various multimedia use-cases.
>>>
>>> Brandon Brnich (1):
>>>    arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
>>>
>>> Devarsh Thakkar (2):
>>>    arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
>>>    arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
>>>
>>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
>>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
>>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>>   3 files changed, 24 insertions(+)
>>
>> I'm still a little torn about putting this allocation into the device tree
>> directly as the actual required allocation size depends on the task.
>>
> 
> That is the exact reason this does not belong in DT. For everyone *not*
> using the most extreme case (12x decodes at the same time), this is
> all wasted space. If one is running out of CMA, they can add more on
> the kernel cmdline.
> 

I disagree with this. The 12x decode for 480p is not an extreme use-case this
is something VPU is capable to run at optimum frame-rate (12x 1080p it can't)
and as the AM62A7 is meant to be AI + multimedia centric device, per the
device definition we were given the requirements to support a list of
multimedia use-cases which should work out of box and 12x decode for 480p was
one of them as device is very much capable of doing that with optimum
performance and I don't think it is right to change these requirements on the fly.

The AM62A7 board has 4 GiB of DDR and we have been using this CMA value since
more than a year, I have never heard anyone complain about out of memory or
CMA starvation and it suffices to requirements of *most use-cases*, but if for
some specific use-case it doesn't suffice, user can change it via kernel cmdline.

The kernelcmdline suggestion doesn't suffice out of box experience required,
we don't want to ask the user to reboot the board everytime they run out of CMA.


>> If it's allowed though, this series is fine for introducing those changes. This
>> uses the long-tested values we've been using on our tree for a bit now. The
>> only
>> thing that's a little worrying is the missing range definitions for devices
>> with
>> more than 32bits of addressable memory as Brandon has pointed out. Once that's
>> addressed:
>>
>> Reviewed-by: Randolph Sapp <rs@ti.com>
>>
>> Specifying these regions using the kernel cmdline parameter via u-boot was
>> brought up as a potential workaround. This is fine until you get into distro
>> boot methods which will almost certainly attempt to override those. I don't
>> know. Still a little odd. Curious how the community feels about it.
>>
>> Technically the user or distro can still override it with the cmdline parameter
>> if necessary, so this may be the best way to have a useful default.
>>
> 

Unlike above, this solution is independent of distro as it should be as we
want that all the supported multimedia use-cases should work out of box. This
solution is nothing illegal as CMA region carveouts are not a kernel
deprecated feature.

> The most useful default is one that doesn't eat 576 MiB of memory "just in case".
> Needing that much CMA is the exception case and should be the one that requires
> adding something to the kernel cmdline.
> 

I disagree with this, I would have agreed if this point was made in context of
generic device, but we are forgetting here that AM62A7 is a AI+multimedia
centric device and customers expect multimedia use-cases to work out of box.

We have 4 GiB RAM and if carving out 576 MiB is helping achieve all major
multimedia use-cases then what's the problem ? What exactly is failing for you
? If some specific scenarios are getting hurt then in that case overlays or
kernel cmdline option can be used to override the cma.

I feel we are over-complicating things here and going back-and-forth each
cycle even though there are no competing alternatives present today.
And this blocks out of box experience, as today even the basic HDMI and GPU
use-cases don't work out of box.

I had also discussed around this with community on last OSS summit as
discussed here [1] were it was suggested too to use this solution as adopted
by other vendors.

[1]: https://lore.kernel.org/all/0eee0424-f177-808f-3a86-499443155ddb@ti.com/

Regards
Devarsh

