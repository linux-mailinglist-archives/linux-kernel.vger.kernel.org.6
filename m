Return-Path: <linux-kernel+bounces-252649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC8931656
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CB31C2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873118EA8D;
	Mon, 15 Jul 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZskHtPJ6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84A18EA75;
	Mon, 15 Jul 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052189; cv=none; b=gCStBrlo1AOaljzo5fmo9CjzmEwVmIA63gXhnLxbDEtIwemLRCKOQvgXbPjd3+jeDpVNCQe+KJ6r5Fji7QzTHQDh3wkUO9LSCnx2qxsVGmNPZuECOsVq32KRImmoZKsraiqLEYfHwNiuAWGi4jgJ2ooogRZRQGq4aHDURd8rtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052189; c=relaxed/simple;
	bh=EM5soLNIU0GEGT7BLLfbdqZY6GjzHIh+YpJqH/9wcBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l55yq5KyxOXJXyHi3LGGcPfrzgyqoC4Bi6oVHJnBPEM/DT2QyLQfmhAeBufbnBFfkS8LBUSU7RswIJvbrwmKMaBKZs/LWaPXOVPJAIrYD570hcs+XBel45uOFKYHTDk5wBaA9Rpwgkq035gYwuuHohngCydKsQ15z8YtKdWoG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZskHtPJ6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FE2d9K053380;
	Mon, 15 Jul 2024 09:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721052159;
	bh=DUKogu1jQnOGI+yRt7sMIp8u112mzxlrLc4tGaMpla8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZskHtPJ6PnRo0A1eD261cw2/H3NsAVCy1+mlnZ+Yl2KGdOaEZUixbFx5Q+gab+CUb
	 DGU4YbRQ+LFzAwG+pZvvFWs/Odl6lScql6Mc3SeIj0lnpewXvx6pl5kLqDd032691a
	 BM+tHcdp99dDqBLVZnAFYdITz3BmIi0Jt5HYNDsU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FE2dx1018610
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 09:02:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 09:02:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 09:02:39 -0500
Received: from [128.247.75.151] (ula0511493.dhcp.ti.com [128.247.75.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FE2chG118703;
	Mon, 15 Jul 2024 09:02:38 -0500
Message-ID: <458e6141-abed-4301-ae76-c242c903ef61@ti.com>
Date: Mon, 15 Jul 2024 09:02:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
To: Francesco Dolcini <francesco@dolcini.it>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220321155417.13267-1-bb@ti.com>
 <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
 <766dceb1-222a-401b-95e3-69b7fb331411@ti.com>
 <20240710073811.GA4855@francesco-nb>
Content-Language: en-US
From: Logan Bristol <l-bristol@ti.com>
In-Reply-To: <20240710073811.GA4855@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Hello Francesco,

On 7/10/24 02:38, Francesco Dolcini wrote:
> Hello Logan
> 
> On Tue, Jul 09, 2024 at 11:20:24AM -0500, Logan Bristol wrote:
>> On 3/22/22 13:14, Krzysztof Kozlowski wrote:
>>> On 21/03/2022 16:54, Bryan Brattlof wrote:
>>>> Texas Instrument's am642 is one of many k3 based, low cost, low power,
>>>> chips designed to work in a wide range of applications spanning an even
>>>> wider range of industries that TI is actively developing
>>>>
>>>> With its pin-mux and peripheral rich designs, these chips will likely
>>>> have a multitude of custom device trees that range wildly from one
>>>> another and (hopefully) guarantee an influx of variants into the kernel
>>>> in the coming years
>>>>
>>>> With overlays no longer a thing, I wanted to ask for opinions on how
>>>> we can best help integrate these dt files as they begin to be developed
>>>>
>>>> I also wanted to introduce a skeletonized (nothing but uart) device tree
>>>> to give others a good starting point while developing their projects.
>>>
>>> Real hardware as DTS please. There is no need to add some skeleton for
>>> specific SoC. What if every SoC goes that way?
>>>
>>> Feel free to create re-usable components in DTSI ways, still reflecting
>>> some hardware parts.
>>>
>>
>> I am working on a project for the AM62 and came across this email thread.
>>
>> Following Krzysztof's direction, I am wanting to submit a DTSI to serve
>> as a minimal configuration for the existing boards based on the AM62
>> SoC, which are currently defined by bloated DTS files.
>>
>> This DTSI file can be consumed by other board DTS files to reduce the
>> configuration. Krzysztof, could this be merged upstream?
> 
> Can you elaborate a little bit what you meant as bloated dts file? Why
> would you need different DTSI files compared to the existing one?
> Which problem are you trying to solve (make some example, be specific
> please).
> 
> My experience with verdin am62 (k3-am62-verdin*dts*) was pretty smooth,
> I was just able to use the SOC dtsi file and use it to define my own
> board (and I had the same good experience with other SOC/Vendors).
> 
> Francesco
> 

The resulting DTB after compiling AM62 SoC DTSI files initializes a
large number of devices. A DTSI that initializes a minimal configuration
that is immediately functional across SoC variations could be used on
existing boards for test and debug purposes to isolate root cause of
failure. It could also serve as a minimal configuration for board bringup.

Thanks,
Logan Bristol

