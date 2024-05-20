Return-Path: <linux-kernel+bounces-183607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C08C9B49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ECBB20A58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85463502B6;
	Mon, 20 May 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJJ3U3DS"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4F1CFBD;
	Mon, 20 May 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200986; cv=none; b=cRXtJifNbsyZf9ADjqrO6kItJyuv1x/cF2W35sNsifJ45MW3cMcVOMt3G1JkMwiTzM2MOwEy34RjGHpOd4LAVe7TLVuYUPJDUbZ/crZ8hfnWx9vgQCHcyMSqVGZIn8umbT1d7AbaA/qMxypDs86+GavtB4fwBXL9LK1cI6Ph9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200986; c=relaxed/simple;
	bh=LC2qoJdIGtupvpcVS0QLE1dFznneOVovlqEbNjd4DRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N/YH0ODZS1T+S7S9QBdhl0h2SDHdmhfegcS4GeZkd7zVQ+76GSipeyVunCmGRPBDSSdC/n7VP43YNz1ObVbZHzWs7H16CWXKQ60GeUOZVED/Zikw1JYCi7hEjjm40rO2KL5RA3+j5Bu3slQZwVpEim6IIK0oZElWbkzFtpSjgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cJJ3U3DS; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KATcdJ084310;
	Mon, 20 May 2024 05:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716200978;
	bh=LC2qoJdIGtupvpcVS0QLE1dFznneOVovlqEbNjd4DRI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cJJ3U3DS4TR9Bo+O2IbYOiMNp0pr8clySXxSfiXLO9wV4PoCfsnEstBtzLKguMu5e
	 asvRZU00K4Vcy7fSPfM0wnjXkD1aqiW/wucNJSncJI+Td260c4LHuJ2Dl6aXee1gAT
	 BDci6+zd2s7hrnHAcralRKu5jVqZRml9E4D6zy1I=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KATci6077230
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 05:29:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 05:29:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 05:29:37 -0500
Received: from [172.24.30.180] (lt5cd2489kgj.dhcp.ti.com [172.24.30.180])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KATYeS084169;
	Mon, 20 May 2024 05:29:34 -0500
Message-ID: <f10425b1-8b7c-45e2-9f69-285b3ae08c45@ti.com>
Date: Mon, 20 May 2024 15:59:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for multiple
 CAN instances
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240411201747.18697-1-b-kapoor@ti.com>
 <85ea2b33-05ac-400f-8017-5539d21ebe32@ti.com>
 <8d9a6dc7-7590-412d-aa81-18a6cf5d09ca@ti.com>
 <9c7f0e3d-4558-4a73-bbb1-ceb7ebe02cd9@ti.com>
 <e9e3ac5d-a048-4058-a5a1-205ded24cb8d@ti.com>
 <8ce03ffe-6440-432c-9bed-77e3a01ae150@ti.com>
 <ed7d36ba-56ab-43bd-8f3a-7556a2cba684@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <ed7d36ba-56ab-43bd-8f3a-7556a2cba684@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya

On 4/23/2024 12:35 PM, Bhavya Kapoor wrote:
> Hi Udit
>
> On 19/04/24 15:11, Kumar, Udit wrote:
>> [...]

>> Let me check if that can be done .

if you are planning to manage it through overlay then for this patch

LGTM,


>>> Regards
>>>
>>>>> Thanks.
>>>>>
>>>>> ~B-Kapoor
>>>>>
>>>>>>> CAN instance 4 in the main domain is brought on the evm through header
>>>>>>> J45. The CAN High and Low lines from the SoC are routed through a mux
>>>>>>> on the evm. The select lines need to be set for the CAN signals to
>>>>>>> reach to its transceiver on the evm. Therefore, add transceiver 3
>>>>>>> dt node to add support for this CAN instance.
>>>>>>>
>>>>>>> [..]

