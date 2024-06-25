Return-Path: <linux-kernel+bounces-229790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A39917432
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6F21C22C74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93D17F375;
	Tue, 25 Jun 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ri7RUWAZ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494D1465A8;
	Tue, 25 Jun 2024 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354218; cv=none; b=BoHDpP2swAoji8Rn/8mdnX1mqQfXjD1GQNJSWLChzX3l5sN1j6uVcoThtxbMhkRggYnO86gP0AO9EdNGcZBPuoljQGvHaaitgmGvkqwYHGbX4Yhx+v5Xk62Jyb5b0xaY/RaACUtXFbwNjdsHPnm4ZO06U12cyobXKRcuFZhL/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354218; c=relaxed/simple;
	bh=xOBhoQwilOC6RKK8cibFbpZQ6aSPbs5hgW2z6bmpcTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJg7Cj/6H+N7VBM9Ue5BWwPQ6QeERXHutmk/iN+2y5Pk+Q+vj8UL7CDaFHHl6S7U1W3W1RHYhYx6aR5KxJ8YO7B0PhxVGbDeBiueCgBahp3mQCYTm8tLKCdyGD24ZuPeSpY5dyIcod5436A5CWkHk2XOxkLBZNkRy5aTl2iI2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ri7RUWAZ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PMNNvG047458;
	Tue, 25 Jun 2024 17:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719354203;
	bh=EX4bniwi4WwAftSjs3/qB5CdYkqk9BcigpRAE9JoEOg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Ri7RUWAZMT7mjsY7HmZU+fCkcIpnQQ5K0cMF8YYJMQ1cO1tpK64lGwIPHjkJqYzII
	 Yv9wSmnP68dZTy/L1W/DW6dssmoU2uyZQOH3VDOfWDYDmmhdQ6mT8dXRMAYg8yHRve
	 f3dKAsqpyrK0MBDmxHdNuem5bmrmxSFqnZ/XCLx4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PMNN66008530
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:23:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 17:23:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 17:23:23 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PMNMKI069659;
	Tue, 25 Jun 2024 17:23:22 -0500
Message-ID: <c3f4a289-03b1-48a5-a3dd-7cb7ca594055@ti.com>
Date: Tue, 25 Jun 2024 17:23:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add
 simple-mfd to compatible items
To: Jan Kiszka <jan.kiszka@siemens.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625164528.183107-1-afd@ti.com>
 <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
 <7fbb62b3-cc71-4fa8-a0c4-fca558292c75@siemens.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <7fbb62b3-cc71-4fa8-a0c4-fca558292c75@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/25/24 2:46 PM, Jan Kiszka wrote:
> On 25.06.24 18:49, Andrew Davis wrote:
>> On 6/25/24 11:45 AM, Andrew Davis wrote:
>>> This node contains a child which is only probed if simple-mfd is in the
>>> compatible list. Add this here.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> ---
>>
>> This patch depends on https://www.spinics.net/lists/kernel/msg5253666.html
>>
> 
> But is that patch already scheduled for 6.10 as well?

I don't think so.. But only [patch 2/2] from this series needs applied
back to 6.10 to fix the issue. This one [Patch 1/2] just removes a dts warning.

Andrew

> 
> Jan
> 

