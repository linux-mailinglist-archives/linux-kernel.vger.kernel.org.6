Return-Path: <linux-kernel+bounces-449855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F849F56F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370071884A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C81F76C7;
	Tue, 17 Dec 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0YYqwDk+"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087315E5D4
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464414; cv=none; b=hBv9v6z7ySd6zaACodJ5ZQQYp1qZfy1Do88dAHzuHStExz0+zJwrGNwpqD8do32spPpwXQDII6gYcqxcCOSdIvsbXaMBT9oP8qMsRAQhaSxOx8jFSyaj5CmCK7K31RIaUctLyUsh19qkzDRCV4U9ZLYcfO8PMrE0simYZGYLAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464414; c=relaxed/simple;
	bh=+ZsH4UeSBPSyKG8vh5YPM5ov0AXNq2mnAkodnwhopNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFarrp8wrYOvP6P/7IjiCf5qOeXrVsUxw0wKlCFxCmv35OgtUFGrIFrd3jtdyQOuefBmve/Seev/r4CqFPXhPS8MSv6TPGJf6lPqwXmaaIEIwidEhbH6zIDO7JsLYrAJ+6a1Jvxsi2O9rac4LQdAT9ak0JODuuSGruY4VYZnkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0YYqwDk+; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 90A2C2C02A5;
	Wed, 18 Dec 2024 08:40:08 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1734464408;
	bh=b5KDmLExP657TqKNx6vXyelVH528QSvEPPmisl7tMMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0YYqwDk+tA79pSTSI8TkrlCe2fvoAeEA0oPUgaw9+VBRFyu5Y3PK+7lBDbPIeTBqO
	 FMRh4DhG8ijkvW4tl+n5dUaZDujpTi1y+yGG1ya+MMLdtjWuMeBNiwoHZ80E/pyupd
	 cpRltHrqByT/w/t/bsmGPVcX7g0SsLAsomR+2a06MTrmwn6yp9y0MQkZMCfUkqHO8+
	 /5E4MXsdRP0B1tc1d4hFHrmqrl4J2KjAj2YUYUN0PUbF1dQxlQXKJK51h5V1472q4S
	 mmhbu4l0AjuQqI/AMwApFTomQ1l3PJnR6Lr1M6WA2OkUDh/GUUFEYVS1PwiOa4wsHW
	 0aWWR5OJPcXaQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6761d3980000>; Wed, 18 Dec 2024 08:40:08 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6A83A13EDC3;
	Wed, 18 Dec 2024 08:40:08 +1300 (NZDT)
Message-ID: <c656bd3f-4ad0-4c2b-8d91-1c81f7e41c52@alliedtelesis.co.nz>
Date: Wed, 18 Dec 2024 08:40:08 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: smatch usage (was Re: [PATCH v2 4/4] net: mdio: Add RTL9300 MDIO
 driver)
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20241216031346.2626805-1-chris.packham@alliedtelesis.co.nz>
 <20241216031346.2626805-5-chris.packham@alliedtelesis.co.nz>
 <20241216164814.GH780307@kernel.org>
 <cf77f08d-0516-4adf-a701-9589f0d99eb5@alliedtelesis.co.nz>
 <20241217103509.GO780307@kernel.org>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20241217103509.GO780307@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=6761d398 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=07d9gI8wAAAA:8 a=5yFChxMeTJAmNQc2H8MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

(culled the cc list)

On 17/12/2024 23:35, Simon Horman wrote:
> + Dan Carpenter
>
> On Tue, Dec 17, 2024 at 10:47:10AM +1300, Chris Packham wrote:
>> On 17/12/2024 05:48, Simon Horman wrote:
>>> On Mon, Dec 16, 2024 at 04:13:46PM +1300, Chris Packham wrote:
>>>> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
>>>> switches with integrated SoC. There are 4 physical SMI interfaces on the
>>>> RTL9300 but access is done using the switch ports so a single MDIO bus
>>>> is presented to the rest of the system.
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ...
>
>>>> +		if (smi_addr[0] > MAX_SMI_BUSSES)
>>> Hi Chris,
>>>
>>> Should this condition be
>>>
>>> 		if (smi_addr[0] >= MAX_SMI_BUSSES)
>> Yes. You are correct.
>>>> +			return dev_err_probe(dev, -EINVAL, "illegal smi bus number %d\n",
>>>> +					     smi_addr[0]);
>>>> +
>>>> +		if (smi_addr[1] > MAX_SMI_ADDR)
>>>> +			return dev_err_probe(dev, -EINVAL, "illegal smi addr %d\n", smi_addr[1]);
>>>> +
>>>> +		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
>>>> +			priv->smi_bus_isc45[smi_addr[0]] = true;
>>> Otherwise it seems that smi_bus_isc45 may overflow here.
>>>
>>> Flagged by Smatch.
>> Sounds like something I should start looking at for myself. Have you got a
>> link to share?
> Hi Chris,
>
> Smatch is here: https://github.com/error27/smatch
> And my usage of it is informed by
> https://blogs.oracle.com/linux/post/smatch-static-analysis-tool-overview-by-dan-carpenter

Thanks, I did find the repo.or.cz mirror and 
https://lwn.net/Articles/691882/ after I searched a bit.

>
> FWIIW, I run it usking kchecker on individual source files.
>
> I've also CCed the author, Dan Carpenter, for good measure.

Odd thing is I can't seem to reproduce any error report on my buggy 
code. I've tried `make O=build_smatch CHECK="~/src/smatch/smatch 
-p=kernel" C=1` and `O=build_smatch ~/src/smatch/smatch_scripts/kchecker 
--spammy drivers/net/mdio/mdio-realtek-rtl.c`

> ...
>

