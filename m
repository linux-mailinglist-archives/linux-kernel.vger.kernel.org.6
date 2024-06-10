Return-Path: <linux-kernel+bounces-208515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683DF90261B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1170B1F2486D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5EF1422BF;
	Mon, 10 Jun 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q4SLHeE6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFC13F458;
	Mon, 10 Jun 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034779; cv=none; b=LEknSRTeMwbJT0DYmQYKvvH8bloV7ceDCYsD6Ia03vgbru8GZOj5b+Vrc8v2O/7/+4MNNnyMETmBPnMU3NRTMLV3qYk9oJc7CvemPVq11e6X4ynttcj9XF9JGujUBGyipTWPHj+yVYDRFW4O04mM03HE9OEX1bUuPptTCE9Tks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034779; c=relaxed/simple;
	bh=jJ0lLOS8+GjQB/5OhMauyEXKdWa5z09hZgstiDsDy7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K1ysUMSodXuQudBHecrcxWGbPKghlqHE2K1JAQVZM4NnWV42j0fYG6+cie+95zcfu7DDdW6q1wGrsbmOvl9KU0C3oj7UPkJNtmD6SM0RDNtAxMdmxHsVk2NqldVSejfJhS0QhDyJHfofsCGSHzfkA+OJYCWFMeO4XTwKx2MMK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q4SLHeE6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AFqmiS024075;
	Mon, 10 Jun 2024 10:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718034768;
	bh=FHTZhcWmvU7dwIjNS/g9TeU8//My8070jXlzryYYIHo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=q4SLHeE6BpCCmsMxB6wpGWJYn9eCd0bKgRPrTe2uCeCLmz2k9gzFlaG+WmqBQl84L
	 UlggX04ObFaQnlGlk+YzDcdHKloHwvRrre9Al/sK/oLGaRfcAOtTT30KEmM0cAc6mt
	 DiJCdtwRSAyhViJnKjEjdR3w2a1wSPKj8GwCm0g0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AFqmRC043958
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 10:52:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 10:52:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 10:52:47 -0500
Received: from [10.249.48.175] ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AFqlea069415;
	Mon, 10 Jun 2024 10:52:47 -0500
Message-ID: <e820d497-9327-8d8b-d1b2-7f6707e593aa@ti.com>
Date: Mon, 10 Jun 2024 10:52:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
To: Bryan Brattlof <bb@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20240605124859.3034-1-hnagalla@ti.com>
 <20240605124859.3034-5-hnagalla@ti.com>
 <20240606171620.h3twptxb5mrxbqxh@bryanbrattlof.com>
Content-Language: en-US
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20240606171620.h3twptxb5mrxbqxh@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/6/24 12:16, Bryan Brattlof wrote:
>> +
>> +		c7x_0_memory_region: c7x-memory@99900000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0x00 0x99900000 0x00 0x01efffff>;
>> +			no-map;
>> +		};
>>   	};
> This seems highly specific to the demos we're currently running for our
> reference boards. If someone wants to develop their own app say with
> Zypher they would instantly need to change this.
> 
> If these absolutely need to be in here could they go in a TI-demo overly?
> 
> ~Bryan
Hey Bryan,
You are correct, these carveouts match the TI provided firmware 
binaries. Ideally, these could go into an overlay. Just following the 
carveout model used with the rest of the TI SoCs (AM6x/J72x), to avoid 
confusion to the users.

