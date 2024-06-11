Return-Path: <linux-kernel+bounces-209548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115B903785
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A63B1C217B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984CB176AAE;
	Tue, 11 Jun 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KtLjpyTB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4D1176AA4;
	Tue, 11 Jun 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097074; cv=none; b=jLgDOacjZBnAcqDC0nh2yU+bS+vtHb3gV7VPhN7Lxoc0SLeW+W9tpyznd5x0MissC6zQNlZjZgXF9JtCZsSj5qvZItvqHajLlyZ0thAU0qKhosgE0PfxEbEQCPcrPtsVKn7DZ+fHHZC52iwWu4LFbdQXykt8pYyjxNfZLfwx+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097074; c=relaxed/simple;
	bh=zmH1E41DFb8pRkpXRRS6Noq44edg6tyfERftPWJLAHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+7apl9epLMQV3LoPJwWtRsVrzcpnV1yn1BCK3eddcx0eHKLL6KQrz9XB4XE8gwqFjUQhzlJpXKhxMfUIcPIiunYC2hY4Xb8Z8DNe1Fh6spNq8KeNKFPt5rbOdPVik9f+5BIheSxkGZ5nXK/D1lq7GXOlKKE+WghoNohR/JU2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KtLjpyTB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B9An18073013;
	Tue, 11 Jun 2024 04:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718097049;
	bh=yZa8C9jUa8dLXbUrDtikuvwUOOpHZWeXqC20zO6Crb8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KtLjpyTBJzALKNTNjJfi5QjjtmRy/Goy27CmVbZP+txdfRToHAl8y69VBjHj87QaO
	 NdvwnZCiCWhx12TIPrHY99O8n2mr/mp1AqKZVcme3D11MLHXiHsNA3VeERzIq1HrnS
	 eaqYKNzrvJiWhOrzR3hB90RjO/wIA1/Y9VFGzmI0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B9Am0u017159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 04:10:49 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 04:10:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 04:10:48 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B9Ah2F073692;
	Tue, 11 Jun 2024 04:10:44 -0500
Message-ID: <9e7d3f9b-c762-40cd-9d0d-2f071aa3c371@ti.com>
Date: Tue, 11 Jun 2024 14:40:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
CC: <nm@ti.com>, <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
 <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
 <902f024a-b0a1-4a0a-94e2-7cec064a91c6@ti.com>
 <6959494a-98ba-4ccf-973c-14d079b76f27@kernel.org>
 <975c90b1-6657-40c6-a336-7f1f58acf531@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <975c90b1-6657-40c6-a336-7f1f58acf531@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 11/06/24 14:24, Siddharth Vadapalli wrote:
> On Mon, Jun 10, 2024 at 10:31:07PM +0300, Roger Quadros wrote:
> 
> [...]
> 
>>> Based on your suggestion, you seem to propose the following hierarchy:
>>> k3-am62p-{main,mcu,thermal,wakeup}.dtsi = AM62P specific data
>>> k3-am62p.dtsi = k3-am62p-j722s-common-main.dtsi +
>>> 		k3-am62p-j722s-common-mcu.dtsi +
>>> 		k3-am62p-j722s-common-wakeup.dtsi +
>>> 		k3-am62p-j722s-common-thermal.dtsi +
>>> 		k3-am62p-{main,mcu,thermal,wakeup}.dtsi +
>>> 		<delta-5>
>>> k3-am62p5.dtsi = k3-am62p.dtsi + <delta-2>
>>> k3-j722s-{main,mcu,thermal,wakeup}.dtsi = J722S specific data
>>> k3-j722s.dtsi = k3-am62p-j722s-common-main.dtsi +
>>> 		k3-am62p-j722s-common-mcu.dtsi +
>>> 		k3-am62p-j722s-common-wakeup.dtsi +
>>> 		k3-am62p-j722s-common-thermal.dtsi +
>>> 		k3-j722s-{main,mcu,thermal,wakeup}.dtsi +
>>> 		<delta-6>
>>
>> What is the equivalent of k3-am62p5.dtsi here?
>> That should contain k3-j722s.dtsi + CPU and OPP stuff.
>>
>> I suppose it should be named specific to the SoC variant part number?
> 
> AM62P (https://www.ti.com/product/AM62P) has two variants:
> 1. 2 Arm Cortex-A53 => AM62P3
> 2. 4 Arm Cortex-A53 => AM62P5
> Both variants will share the common k3-am62p.dtsi
> 
> J722S (https://www.ti.com/product/TDA4VEN-Q1) has only one variant:
> 4 Arm Cortex-A53 => J722S
> Which is currently identical to AM62P5 w.r.t. the number of A53s.
> 
> So there isn't an equivalent of AM62P5/k3-am62p5.dtsi for J722S.
> k3-j722s.dtsi is a combination of k3-am62p.dtsi and k3-am62p5.dtsi.
> 


Historically AM6xx devices have had CPUs in separte file as there are OPNs with different number of CPU cores Hence, how about
k3-am62p5.dtsi => k3-am62p.dtsi + k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-am62p-main.dtsi (USB2 and other deltas specific to AM62P)

and since J722s has no variants with less than 4 cores (and along the lines of rest of J7xx devices):

k3-j722s.dtsi => k3-am62p-j722s-common-{main,mcu,wakeup}.dtsi + k3-j722s-main.dtsi (USB3, C7x and other deltas specific to J722s;


-- 
Regards
Vignesh

