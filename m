Return-Path: <linux-kernel+bounces-279536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9B94BE9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385CA280E99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B918E029;
	Thu,  8 Aug 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dTyPPAXS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DA143726;
	Thu,  8 Aug 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124242; cv=none; b=Hxu9oJ8VqFB28DzsYe8PZ6puSLXDGy06HqcCsnsNXq3c3tiJ4sRTNPl0MX80oFmEaeW5iBt1dbd1PbTj5EqDZVJ4DGiPxf8g+mn/H8J7it2PAQD5rHxjx0HWaD2oFIApsKXUFdlrWPe1MHKAySnBJB0MnAMRErYQAnIxbnagL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124242; c=relaxed/simple;
	bh=6ry0RDTFUf4ToCxi2YgZQmo4tKypWu7LSfdRWrTUN00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VP+zDHxaVfq1JgwBRcltv27VKlRgUgrEnuwxkA7zAnaXf4AxdoGVcU9NxWxMV+nflGWe5Bw3hQeJK1DiVNR5SByTMsS3bdULUGXbA3Rjt3TirJPwpdTBJ7sCkhSirN1Z/fApJToIzbcj15RnfegnhIImXKU/Ju+W9gaOKxIuT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dTyPPAXS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478Db7f1085906;
	Thu, 8 Aug 2024 08:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723124227;
	bh=hgtx+C/a/XnP9A97FM9ameqqczBfUD/fUT+S0DTSdmA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dTyPPAXSKa+yN/W2G3VsdFN3LiGbIVTyLwxAeWqRWmyIARa49awdwvHaNPBJ1xcW1
	 SgFzPV3khTMfPVeF11kB8InGs1dnvGe6nTuJBYBSjP4CYCcck6bQwl6l/DfOAzx89M
	 zyfMMeFAZig9Khsvetgv/rH60OMr5U5XGCpKXIBU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478Db7v5031960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 08:37:07 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 08:37:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 08:37:07 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478Db74N033399;
	Thu, 8 Aug 2024 08:37:07 -0500
Message-ID: <1eb9a607-7b4d-46e3-99b5-5a14fb785f9a@ti.com>
Date: Thu, 8 Aug 2024 08:37:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62p: Remove 'reserved' status
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar
	<s-k6@ti.com>,
        Bryan Brattlof <bb@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
 <20240806214605.3379881-4-jm@ti.com>
 <20240807114605.ggieur532eh4usus@diagram>
 <65047cc9-011b-46d3-939e-b7733c2f0fe2@ti.com>
 <20240807152602.qtlqdne256mioogs@embroider>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240807152602.qtlqdne256mioogs@embroider>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/7/24 10:26 AM, Nishanth Menon wrote:
> On 10:13-20240807, Judith Mendez wrote:
>> Hi Nishanth,
>>
>> On 8/7/24 6:46 AM, Nishanth Menon wrote:
>>> On 16:46-20240806, Judith Mendez wrote:
>>>> From: Santhosh Kumar K <s-k6@ti.com>
>>>>
>>>> Remove 'reserved' status for MCU ESM node in AM62P device tree.
>>>
>>> Why?
>>
>> Main ESM reset is routed to the MCU ESM, hense enable
>> MCU ESM in DT to be able to reset the CPU.
> 
> please document that in the commit message - please review the rest
> of the patches as well. Is this problem present on other related AM6
> products as well - will be good to audit and fixup in the series?


Sure, am62x and am64x should be fine, only platform left to check is 
am65x. So will verify that and send v2 with commit message fixed,
thanks for reviewing!


~ Judith


