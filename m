Return-Path: <linux-kernel+bounces-557273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4266A5D61F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DAA1728B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1CF1E51F1;
	Wed, 12 Mar 2025 06:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RAGgEdWN"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9341E32C5;
	Wed, 12 Mar 2025 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760850; cv=none; b=Y4m8YQHtGj/sv4FdGNiKjZQTmw+7GoQHPFGQRfraN+WL4TklDx+HpjfFpzOk/ULx3WOHptLGb3rvrpHW4gcBnqzN8TSL1T+2Y3bCtLJ2+ljnaOVjeXeuF0NsM6s2X6hs8MuPKHNx8AwFuF2yVV/szEb4TE9muE5ZMe4VsKqys+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760850; c=relaxed/simple;
	bh=jffXpVAwbEZbtDDoz5EcvNcEDAQkHwgudQccWL27bnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iTGQ5QWxTnY0NHJ1GVHwfm0RNHdTVwxUbNDPfVBLInTpwnEfUkCi9Mp/qSeeENDLG1UUGoP10QVrN1ThiNsBHAMTU6xck+acDi+5LWv0UmaRCmaZWnAUGt7rI7C5nol/y58f2St/2/5FXnR8o4Jup7rc+Cur3Uq1s5y9C5nLOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RAGgEdWN; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52C6QqDM1502234
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 01:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741760812;
	bh=DnPiYLU+W55E9DeSsjm78osM0IQbGrhucNB0Egl1iXE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RAGgEdWN3M1TDMMXpL03T6WxLCjAHuHjghMiPlxxYlDK9Jb31NaT0VlNnyKuaFI2x
	 6XKGpBBRXxmxP8W6ViWQMxuLAYto884WyEXmyrTqeldl4tO0ZstmpimioCC0+xlFvK
	 QlmiDO5xkP3ChG9OFcVeOEGb3RTtCy94fviievJc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52C6Qqr1112070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 01:26:52 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 01:26:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 01:26:51 -0500
Received: from [172.24.227.96] (hkshenoy.dhcp.ti.com [172.24.227.96])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52C6Qg59073673;
	Wed, 12 Mar 2025 01:26:43 -0500
Message-ID: <de0cb22d-d251-4b0b-8fc7-e8b5a891a527@ti.com>
Date: Wed, 12 Mar 2025 11:56:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: drm/bridge: Add no-hpd property
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Harikrishna Shenoy <h-shenoy@ti.com>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jani.nikula@intel.com>, <j-choudhary@ti.com>,
        <sui.jingfeng@linux.dev>, <viro@zeniv.linux.org.uk>,
        <r-ravikumar@ti.com>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250205115025.3133487-1-h-shenoy@ti.com>
 <20250205115025.3133487-2-h-shenoy@ti.com>
 <efd89cf8-2f83-44fd-8bdf-aa348d4d9659@kernel.org>
 <h24gpx6cxm4s6gzcunjnswubtvqask5dewi3udulmntsuieklm@w3pw4ig3t7gm>
Content-Language: en-US
From: Harikrishna Shenoy <a0512644@ti.com>
In-Reply-To: <h24gpx6cxm4s6gzcunjnswubtvqask5dewi3udulmntsuieklm@w3pw4ig3t7gm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 05/02/25 19:03, Dmitry Baryshkov wrote:
> On Wed, Feb 05, 2025 at 12:52:52PM +0100, Krzysztof Kozlowski wrote:
>> On 05/02/2025 12:50, Harikrishna Shenoy wrote:
>>> From: Rahul T R <r-ravikumar@ti.com>
>>>
>>> The mhdp bridge can work without its HPD pin hooked up to the connector,
>>> but the current bridge driver throws an error when hpd line is not
>>> connected to the connector. For such cases, we need an indication for
>>> no-hpd, using which we can bypass the hpd detection and instead use the
>>> auxiliary channels connected to the DP connector to confirm the
>>> connection.
>>> So add no-hpd property to the bindings, to disable hpd when not
>>> connected or unusable due to DP0-HPD not connected to correct HPD
>>> pin on SOC like in case of J721S2.
>>>
>>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>>
>> Why are you sending over and over the same? You already got feedback.
>> Then you send v2. You got the same feedback.
>>
>> Now you send v3?
>>
>> So the same feedback, but this time: NAK
> 
> Krzysztof's email forced me to take a look at the actual boards that you
> are trying to enable. I couldn't stop by notice that the HPD signal
> _is_ connected to a GPIO pin. Please stop hacking the bridge driver and
> use the tools that are already provided to you: add the HPD pin to the
> dp-controller device node. And then fix any possible issues coming from
> the bridge driver not being able to handle HPD signals being delivered
> by the DRM framework via the .hpd_notify() callback.
> 
> TL;DR: also a NAK from my side, add HPD gpio to dp-controller.
> 
We tried implementing a interrupt based HPD functionality as HPD signal 
is connected to GPIO0_18 pin, we were able to get interrupt based HPD 
working however to route this signal to SoC we are loosing audio 
capability due to MUX conflict. Due to board level limitations to
route the signal to SoC, we will not be able to support interrupt
based HPD and polling seems a possible way without loosing on audio 
capability.

Link to schematics zip:
https://www.ti.com/tool/J721S2XSOMXEVM#design-files
File:sprr439b/PROC118E4_RP/PROC118E4(001)_SCH.pdf, Page 17, MUX1

Regards,
Hari


