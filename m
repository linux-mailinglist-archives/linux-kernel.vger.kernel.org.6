Return-Path: <linux-kernel+bounces-235109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE391D03F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590F7B212A3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0903BBC9;
	Sun, 30 Jun 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMKo3aCu"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A774084C;
	Sun, 30 Jun 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719731388; cv=none; b=fb1IkbsqUXpO5qwHNHY8x0lqy6fDIPqoLjgcDwmO0pTdZ8YBYEhzclARWMtohcRwXWDudrP4181CAHBSFzuwydCQy+l+QdZsps6Dv3+2Ik8Rysh0K9DIXK3QweCFl+RYkqQKT3jALyKNjZ6nmx48lpGYf5RVEVYMIKwbw0heA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719731388; c=relaxed/simple;
	bh=+sX6ULmlLv/0jScNyfAwutPCjz4FV6sRoYcqNTUuPcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IPr8SoSM6CmqrT77qrY4i/dWHWBHBF0rYVirdWXPo55qVzOYjUFAQSDe519EwLv1TRQihlf6gkHC/o0SOYc25aHcCHZZk1rEwLzJ5VYjHKe6YhPI+2+QYHH9fMzG1/8jZ15IHxjNKL/EEe6gNdTsI5FXBIqMccLxNeg89QoWkTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YMKo3aCu; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45U79di2084201;
	Sun, 30 Jun 2024 02:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719731379;
	bh=EnLzB75c23YJnuba7kDcKU7PP1s2SR97VQiBuiWzAkM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YMKo3aCuU8h2ytQM1eQIjVgmFuFMbHm29ICxh6UdEM+TgB1HgLr1KCoHbZxMIVZLS
	 DMCimp8YUBRqwUSY3JVgxDKjIbVNFck59RdZmxMovPgBzps7LKfODq2kHB/ZClHxq7
	 4lJkT6CZBklm13N4gt+pGMiqqjDKeDHX0RB4MmuE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45U79dPQ068587
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 30 Jun 2024 02:09:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 30
 Jun 2024 02:09:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 30 Jun 2024 02:09:39 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45U79Xkw001404;
	Sun, 30 Jun 2024 02:09:34 -0500
Message-ID: <0ca809d0-3d0f-47d1-b5e7-aa78d65d7917@ti.com>
Date: Sun, 30 Jun 2024 12:39:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add global CMA reserve area
To: Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Andrew Davis
	<afd@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
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
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <D2BSORIL5C7T.3B8EAANVQ7TX5@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 28/06/24 22:05, Randolph Sapp wrote:
> On Fri Jun 28, 2024 at 10:57 AM CDT, Devarsh Thakkar wrote:
>> Hi Andrew, Vignesh,
>>
>> On 24/06/24 22:03, Andrew Davis wrote:
>>> On 6/14/24 12:58 PM, Randolph Sapp wrote:
>>>> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
>>>>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
>>>>> These SoCs do not have MMU and hence require contiguous memory pool to
>>>>> support various multimedia use-cases.
>>>>>
>>>>> Brandon Brnich (1):
>>>>>    arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
>>>>>
>>>>> Devarsh Thakkar (2):
>>>>>    arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
>>>>>    arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
>>>>>
>>>>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
>>>>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
>>>>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>>>>   3 files changed, 24 insertions(+)
>>>>
>>>> I'm still a little torn about putting this allocation into the device tree
>>>> directly as the actual required allocation size depends on the task.
>>>>
>>>
>>> That is the exact reason this does not belong in DT. For everyone *not*
>>> using the most extreme case (12x decodes at the same time), this is
>>> all wasted space. If one is running out of CMA, they can add more on
>>> the kernel cmdline.
>>>
>>
>> I disagree with this. The 12x decode for 480p is not an extreme use-case this
>> is something VPU is capable to run at optimum frame-rate (12x 1080p it can't)
>> and as the AM62A7 is meant to be AI + multimedia centric device, per the
>> device definition we were given the requirements to support a list of
>> multimedia use-cases which should work out of box and 12x decode for 480p was
>> one of them as device is very much capable of doing that with optimum
>> performance and I don't think it is right to change these requirements on the fly.
>>
>> The AM62A7 board has 4 GiB of DDR and we have been using this CMA value since
>> more than a year, I have never heard anyone complain about out of memory or
>> CMA starvation and it suffices to requirements of *most use-cases*, but if for
>> some specific use-case it doesn't suffice, user can change it via kernel cmdline.
>>
>> The kernelcmdline suggestion doesn't suffice out of box experience required,
>> we don't want to ask the user to reboot the board everytime they run out of CMA.
>>
>>
>>>> If it's allowed though, this series is fine for introducing those changes. This
>>>> uses the long-tested values we've been using on our tree for a bit now. The
>>>> only
>>>> thing that's a little worrying is the missing range definitions for devices
>>>> with
>>>> more than 32bits of addressable memory as Brandon has pointed out. Once that's
>>>> addressed:
>>>>
>>>> Reviewed-by: Randolph Sapp <rs@ti.com>
>>>>
>>>> Specifying these regions using the kernel cmdline parameter via u-boot was
>>>> brought up as a potential workaround. This is fine until you get into distro
>>>> boot methods which will almost certainly attempt to override those. I don't
>>>> know. Still a little odd. Curious how the community feels about it.
>>>>
>>>> Technically the user or distro can still override it with the cmdline parameter
>>>> if necessary, so this may be the best way to have a useful default.
>>>>
>>>
>>
>> Unlike above, this solution is independent of distro as it should be as we
>> want that all the supported multimedia use-cases should work out of box. This
>> solution is nothing illegal as CMA region carveouts are not a kernel
>> deprecated feature.
> 
> Right. I support this change for at least introducing a usable default. 32M of
> CMA is barely enough to run glmark2 under Weston once everything's up and
> running.
> 
> As I said before, the user or distro can still override the dt CMA block with
> the cma kernel parameter if they aren't happy with the default block.
> Unfortunately this is about the only way to have a usable default value to fall
> back on.
> 


Given the number of SoMs and non TI EVMs that are about to come out with
AM62A/P and AM67s, we need to provide a consistent way of being able to
support multimedia IPs out of the box. Modifying cmdline may not always
be feasible given distro defaults don't always provide a way to do so.

So I am inclined to queue first 2 patches unless there is another way t
achieve this.

[...]

-- 
Regards
Vignesh

