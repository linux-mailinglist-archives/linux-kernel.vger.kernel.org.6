Return-Path: <linux-kernel+bounces-234687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293291C973
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843B11C22CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D830823D1;
	Fri, 28 Jun 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SHh2hKNE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95646F30A;
	Fri, 28 Jun 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719615994; cv=none; b=mueXzFvlcvpIIqWHUrHBrPdcZg2CMgD3NqjBpeLCyX21QzF/+hgAdTGOz8QO2uoKbt/7zFwSZTUnc1iDXgejqLMRPvP4iFbKcjd30Kd/8wdfjESJwRXPeZp4mOwjbbKl17Jr82Avo0XMFSSjWGTMpWig+d5xq4eT3gg1hM+TXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719615994; c=relaxed/simple;
	bh=CJFC1i/rFNcMAu2c0rgyW0EJOBSzUMuWmmIGpUhihYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WVW+tbsXyAKxvEz2+AbFQFWh6RFjVfEuytjuOIl1kqfKZuC/4Igu46hbq7XBYCy/r0wN9eKSXAMdkAz896NgZ+DiaMnjxXaosZxzInaaUUSoTvwO0TDjrnnv5IQSRf8uktvt5zhLpHYwNhL0Vn7v1ZHbfwqAA6NflZpNohD6XjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SHh2hKNE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SN6I0Y096817;
	Fri, 28 Jun 2024 18:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719615978;
	bh=qvdjnBB+g2iBGUqRGrha8gu64eIVrsfmJ+nP8zaZi+g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SHh2hKNE/mQPe/0oOZy/auoSKa+tZFsRcS0lp4BczDZIQ80llbIMmD1jbIOygC4Yu
	 1qwcwZpRDTzifsfrRiAlA/CnhxbfNMft67oeH6sSszwtCzDvSf9AoMqjbEk+0+GqzZ
	 WmrLrR1+pJwhQN9uiOrbl1bKcOlyHaT9KHr9dUzQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SN6IaG066063
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 18:06:18 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 18:06:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 18:06:18 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SN6HPl098510;
	Fri, 28 Jun 2024 18:06:18 -0500
Message-ID: <0a58eda0-7c11-4d4d-ab85-2b3831a1c758@ti.com>
Date: Fri, 28 Jun 2024 18:06:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add
 simple-mfd to compatible items
To: Rob Herring <robh@kernel.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Tony
 Lindgren <tony@atomide.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625164528.183107-1-afd@ti.com>
 <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
 <7fbb62b3-cc71-4fa8-a0c4-fca558292c75@siemens.com>
 <c3f4a289-03b1-48a5-a3dd-7cb7ca594055@ti.com>
 <20240628213833.GA250523-robh@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240628213833.GA250523-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/28/24 4:38 PM, Rob Herring wrote:
> On Tue, Jun 25, 2024 at 05:23:22PM -0500, Andrew Davis wrote:
>> On 6/25/24 2:46 PM, Jan Kiszka wrote:
>>> On 25.06.24 18:49, Andrew Davis wrote:
>>>> On 6/25/24 11:45 AM, Andrew Davis wrote:
>>>>> This node contains a child which is only probed if simple-mfd is in the
>>>>> compatible list. Add this here.
>>>>>
>>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>>> ---
>>>>
>>>> This patch depends on https://www.spinics.net/lists/kernel/msg5253666.html
>>>>
>>>
>>> But is that patch already scheduled for 6.10 as well?
>>
>> I don't think so.. But only [patch 2/2] from this series needs applied
>> back to 6.10 to fix the issue. This one [Patch 1/2] just removes a dts warning.
> 
> Both or none should be applied...
> 

Both should be applied to master.

Only [2/2] is a fix that should then be backported to v6.10.x to fix an issue in v6.10.

[1/2] has a dependency on a patch that will not be in v6.10 so it cannot be backported,
but luckily [1/2] is just a fix for a DTB check warning. [2/2] doesn't depend on [1/2].
So no issue there, [2/2] should backport cleanly all by itself.

Andrew

