Return-Path: <linux-kernel+bounces-236455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F791E28E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2591F1C21B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3D16939B;
	Mon,  1 Jul 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZfXrnzs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9646436;
	Mon,  1 Jul 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844432; cv=none; b=gVrJjisCCnDiS8qmu8wIDRhQcGFXYkHUiANmH+QZfo3bVTVjrvvS1ZHs7QfrZ3f45G0+MflIiqaKRm5Ydy1wkB4fKKiKZJ3QECwMksFxTjCj1S6Ub2coZbZRr6yTP3GAOldT7uzOAMaClSLdSvQ5byyTbqN+7d0pfbSlRs5hYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844432; c=relaxed/simple;
	bh=+iCXElHKsakjBNZHRBYyd/uKF1oKtn8yvJ3Z3RbdYU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABoFviHZsUrq7RTPonC61FLpvS/sFBrTF2mx8GPbyzWF5Ra69j71+FQCIrfok26PNxaUUKgJNHAt8dc/vrFFQOIDdT53Y7UfiPHd4HOoCtpGUDZDQqtffDwgRSwFiQzCa345GsdqeAX8f803F4B+jQGG+bxD5rtX5DfJHJ/K/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KZfXrnzs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461EXgp9045694;
	Mon, 1 Jul 2024 09:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719844422;
	bh=OZ7ubyk2G9Zgv9GAmOmXmRknkb4fsGFEUSJJeKTTT+A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KZfXrnzsPhvp748NcJC5WdG61puQIGarlKFzEM9i2vJduUyaDmJ9f7yOxOUZQrglL
	 RVif5uCCkpaa/60V4nI2LeOygJePgfSZUlXBDnViGO7FGOe0pVieFAioben+Dk7/ZE
	 54ZVuOuWqX/gYvOKx9gDF6NrAJT7Q1yk99tDZGxI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461EXgHJ126900
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 09:33:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 09:33:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 09:33:41 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461EXfst032070;
	Mon, 1 Jul 2024 09:33:41 -0500
Message-ID: <2f1f25b5-86c1-4a60-8f71-519658d5f88a@ti.com>
Date: Mon, 1 Jul 2024 09:33:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add global CMA reserve area
To: Vignesh Raghavendra <vigneshr@ti.com>, Randolph Sapp <rs@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, "Khasim, Syed Mohammed" <khasim@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
 <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
 <64b78ba2-776c-1de6-4c13-001d11000ff0@ti.com>
 <D2BSORIL5C7T.3B8EAANVQ7TX5@ti.com>
 <0ca809d0-3d0f-47d1-b5e7-aa78d65d7917@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <0ca809d0-3d0f-47d1-b5e7-aa78d65d7917@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/30/24 2:09 AM, Vignesh Raghavendra wrote:
> 
> 
> On 28/06/24 22:05, Randolph Sapp wrote:
>> On Fri Jun 28, 2024 at 10:57 AM CDT, Devarsh Thakkar wrote:
>>> Hi Andrew, Vignesh,
>>>
>>> On 24/06/24 22:03, Andrew Davis wrote:
>>>> On 6/14/24 12:58 PM, Randolph Sapp wrote:
>>>>> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
>>>>>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
>>>>>> These SoCs do not have MMU and hence require contiguous memory pool to
>>>>>> support various multimedia use-cases.
>>>>>>
>>>>>> Brandon Brnich (1):
>>>>>>     arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
>>>>>>
>>>>>> Devarsh Thakkar (2):
>>>>>>     arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
>>>>>>     arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
>>>>>>
>>>>>>    arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
>>>>>>    arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
>>>>>>    arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>>>>>    3 files changed, 24 insertions(+)
>>>>>
>>>>> I'm still a little torn about putting this allocation into the device tree
>>>>> directly as the actual required allocation size depends on the task.
>>>>>
>>>>
>>>> That is the exact reason this does not belong in DT. For everyone *not*
>>>> using the most extreme case (12x decodes at the same time), this is
>>>> all wasted space. If one is running out of CMA, they can add more on
>>>> the kernel cmdline.
>>>>
>>>
>>> I disagree with this. The 12x decode for 480p is not an extreme use-case this
>>> is something VPU is capable to run at optimum frame-rate (12x 1080p it can't)
>>> and as the AM62A7 is meant to be AI + multimedia centric device, per the
>>> device definition we were given the requirements to support a list of
>>> multimedia use-cases which should work out of box and 12x decode for 480p was
>>> one of them as device is very much capable of doing that with optimum
>>> performance and I don't think it is right to change these requirements on the fly.
>>>
>>> The AM62A7 board has 4 GiB of DDR and we have been using this CMA value since
>>> more than a year, I have never heard anyone complain about out of memory or
>>> CMA starvation and it suffices to requirements of *most use-cases*, but if for
>>> some specific use-case it doesn't suffice, user can change it via kernel cmdline.
>>>
>>> The kernelcmdline suggestion doesn't suffice out of box experience required,
>>> we don't want to ask the user to reboot the board everytime they run out of CMA.
>>>
>>>
>>>>> If it's allowed though, this series is fine for introducing those changes. This
>>>>> uses the long-tested values we've been using on our tree for a bit now. The
>>>>> only
>>>>> thing that's a little worrying is the missing range definitions for devices
>>>>> with
>>>>> more than 32bits of addressable memory as Brandon has pointed out. Once that's
>>>>> addressed:
>>>>>
>>>>> Reviewed-by: Randolph Sapp <rs@ti.com>
>>>>>
>>>>> Specifying these regions using the kernel cmdline parameter via u-boot was
>>>>> brought up as a potential workaround. This is fine until you get into distro
>>>>> boot methods which will almost certainly attempt to override those. I don't
>>>>> know. Still a little odd. Curious how the community feels about it.
>>>>>
>>>>> Technically the user or distro can still override it with the cmdline parameter
>>>>> if necessary, so this may be the best way to have a useful default.
>>>>>
>>>>
>>>
>>> Unlike above, this solution is independent of distro as it should be as we
>>> want that all the supported multimedia use-cases should work out of box. This
>>> solution is nothing illegal as CMA region carveouts are not a kernel
>>> deprecated feature.
>>
>> Right. I support this change for at least introducing a usable default. 32M of
>> CMA is barely enough to run glmark2 under Weston once everything's up and
>> running.
>>
>> As I said before, the user or distro can still override the dt CMA block with
>> the cma kernel parameter if they aren't happy with the default block.
>> Unfortunately this is about the only way to have a usable default value to fall
>> back on.
>>
> 
> 
> Given the number of SoMs and non TI EVMs that are about to come out with
> AM62A/P and AM67s, we need to provide a consistent way of being able to
> support multimedia IPs out of the box. Modifying cmdline may not always
> be feasible given distro defaults don't always provide a way to do so.
> 

We need to keep thinking then. I empathize with desire to put
configuration in Device Tree. DT feels like a great spot for it,
it is ubiquitous on these boards and has a good bit of tooling around
it. We are already describing the hardware, why not configure it here
too? But the reason we do not want to go down that road is simple:
DT takes away use-case flexibility. A lack of flexibility is fine for
hardware which is unchanging, but not for configuration.

Device policy and configuration must be left to userspace.

It is not for us to decide how folks should use our hardware, and
that is what we are doing when we configure it in DT.

For configuration that must happen in early boot before userspace is
available (such as kernel stdout and memory carveouts) we have the
kernel cmdline. If we find something that cannot be done today though
the cmdline, then we should add that support to the cmdline, not
give up and just hide the configuration in DT.

What this series does is already available on the kernel cmdline.
Our bootloader can provide sane defaults on the cmdline today.
If the worry is that distros will override this default then
go fix those distros.

> So I am inclined to queue first 2 patches unless there is another way t
> achieve this.
> 

Our lack of creativity in finding better solutions to this issue is
not an excuse to add more junk to DT..

Andrew

> [...]
> 

