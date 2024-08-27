Return-Path: <linux-kernel+bounces-302587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D09960091
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B028B21C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE3629E4;
	Tue, 27 Aug 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D3bQb5c6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02246BA;
	Tue, 27 Aug 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734497; cv=none; b=gk8Pa+plqyD9yNkLbnvWZKOOcILNA4x3fn7oNSKQZzR5S8crt4j0fqU4oOr/sWN807VliXylgnkf3xq5EQlqVKwJVlDRybAT/S/PYhMeDYapH6HfTLYZvtR8CJirQBoxr7gXaMph6e3JwM1i2E5jNOvHUzMQhhVwV7sBsZSZ3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734497; c=relaxed/simple;
	bh=LTRjkNWpPIJV+y1DqNWSjY3HaokQAegTXhNwvzVcyOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YjItmrjn/u2Clm8jvqhw0LqlWq40pkq/jViOnGp3NU7FnDvzkpG+98d3OVCyuetFJJ0iDWKXu9kV7MhXzMtPVaa95FF7YJv1iIH/IkHdUmgv3E0Wmq9Vg3ZOqjA3h+b7iOV/OLgfE1JVD4p0VyXg0MeOVurynKI5yZUUC0ku0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D3bQb5c6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47R4siaS009374;
	Mon, 26 Aug 2024 23:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724734484;
	bh=Ey+E+1b4RzgL6/GdPYzmE944PKZywYIjd3t1l/eIaUI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=D3bQb5c68aUg5JsomvUgF/4MfuEHcKT/DPmKJIVJykPSXx6pklM107CEmJEAa0pje
	 keyerlBVueUcIM8GLsAfSAwGwil1nwHyAsMKo+Cdah+FgtbVMFPoZiDHcaPwKkAe+t
	 /SD9zUWqj2KhaebMDymHwiuvrAGL6ZgyRL64kHiQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47R4siEA050447
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 23:54:44 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 23:54:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 23:54:44 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47R4sd0m030791;
	Mon, 26 Aug 2024 23:54:40 -0500
Message-ID: <2beb4f12-c485-4af5-86ef-a481f6f7ecae@ti.com>
Date: Tue, 27 Aug 2024 10:24:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] arm64: dts: ti: k3-j7200-som-p0: Change timer
 nodes status to reserved
To: Krzysztof Kozlowski <krzk@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>,
        <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240826104821.1516344-1-b-padhi@ti.com>
 <20240826104821.1516344-2-b-padhi@ti.com>
 <276ee20c-beeb-4607-b435-11bfd188ccef@kernel.org>
 <e7aa7d45-8d5f-4f5f-bba4-b9e0f77d8a6a@kernel.org>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <e7aa7d45-8d5f-4f5f-bba4-b9e0f77d8a6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 26/08/24 18:07, Krzysztof Kozlowski wrote:
> On 26/08/2024 12:54, Krzysztof Kozlowski wrote:
>> On 26/08/2024 12:48, Beleswar Padhi wrote:
>>> The remoteproc firmware of R5F in the MAIN voltage domain use timers.
>>> Therefore, change the status of the timer nodes to "reserved" to avoid
>>> any clash. Usage is described as below:
>>>
>>> 	+===================+==========================+
>>> 	|  Remoteproc node  |        Timer Node        |
>>> 	+===================+==========================+
>>> 	| main_r5fss0_core0 | main_timer0, main_timer2 |
>>> 	+-------------------+--------------------------+
>>> 	| main_r5fss0_core1 | main_timer1              |
>>> 	+-------------------+--------------------------+
>>>
>>> Fixes: c8a28ed4837c ("arm64: dts: ti: k3-j7200: Add general purpose timers")
>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> You keep sending the same. Where is the changelog? Why so many same
>> patchsets? Why so many resends without changes?
> OK, now cover letter came and I see the changelog. Some hickup on mail
> servers.


I understand the mistake. From next time, will mention changelogs in 
patches as well as cover letter.

>
> Best regards,
> Krzysztof
>

