Return-Path: <linux-kernel+bounces-555573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B50BA5B9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7128B1892A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E32222C4;
	Tue, 11 Mar 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="clqEGs7D"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A32222CA;
	Tue, 11 Mar 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678131; cv=none; b=EUxKxtmclnhpU1nwGXDuk3DDuXOD4ZcXQSwPELXfF1rbNXGS7l5pgXn36CAU/zcqp1o45AKdvIG8yTcoBq7M7xCl51uVQXiMnT/5qM7sVCkARxyfOJWuTXEZcIDkNStK8CJJClbOBOzBf0HgP+gwZk8oa/5pDAUKqC15ppCu9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678131; c=relaxed/simple;
	bh=tS59wv2oRJS3ZEDR20fU+3B7NhAcIQZIUM+9nIVYeMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BQykO7Y3WOB5H74eJd06caZ3UGWPEp+PnC1zEv4pE2TWaziGNBP1F7nhsLTszdpnLKeEWRnDegA/Fj38ORVFismq+spktbmYGpiqGdNPV8PhB9KZtwVlVzi/jbdxm95lw+dUQ9QaRvM5sD8CcPGxaQ1h130aCSvFypthiBZFv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=clqEGs7D; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B7S0Ds644784
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 02:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741678080;
	bh=PbzRBzD4zy1+woI1kw2/XmxJI77CaWyhRb9Se95W7PI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=clqEGs7DEHEsKaeENmPF1f7pqFSp3QgVfxlDlCYu/oVNDolvtnCKDqdbHlSjPzb95
	 2m1ZsLm7e+NylWm0dsInjHa0bGykRmvn14PvWYpEgJ3mVs6VfL2j/g63VPdbSrpOJh
	 6LMluOUQDRQVTnJ8DlqkCR5Ah1rH4kg0/PugVLvM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B7S0kc061754
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Mar 2025 02:28:00 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 02:27:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 02:28:00 -0500
Received: from [10.24.68.192] (dhcp-10-24-68-192.dhcp.ti.com [10.24.68.192])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B7RuHV002607;
	Tue, 11 Mar 2025 02:27:56 -0500
Message-ID: <8f03c097-e2c1-452a-85e2-90accbac7443@ti.com>
Date: Tue, 11 Mar 2025 12:57:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add J722S CSI support
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC: <linux-kernel@vger.kernel.org>, <jai.luthra@linux.dev>,
        <y-abhilashchandra@ti.com>
References: <20250218185452.600797-1-vaishnav.a@ti.com>
 <174133309362.1072814.5440404016847301624.b4-ty@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <174133309362.1072814.5440404016847301624.b4-ty@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 07/03/25 16:06, Vignesh Raghavendra wrote:
> Hi Vaishnav Achath,
> 
> On Wed, 19 Feb 2025 00:24:47 +0530, Vaishnav Achath wrote:
>> This series adds support for CSI2RX capture on J722S EVM
>> and enables IMX219 and OV5640 overlays to enables
>> 4 sensors on EVM, this provides a reference for a user to
>> enable a different sensor on any of the ports.
>>
>> Test logs:
>> IMX219: https://gist.github.com/vaishnavachath/60cc2ef257601f27f28a315f8cf669c4
>> OV5640: https://gist.github.com/vaishnavachath/648202286d4d34d4d25f7c8c9db8b8bd
>>
>> [...]
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/5] arm64: dts: ti: k3-j722s-main: Add BCDMA CSI overrides
>       commit: fb1b230bf9c45f5d6579dc329c2aafcd1263b70a
> [2/5] arm64: dts: ti: k3-j722s-main: Add CSI2RX nodes
>       commit: 8fea4519f625e6c1b05078f2ecea252b7b28b06e
> [3/5] arm64: dts: ti: k3-j722s-evm: Add camera peripherals
>       commit: ce553288ad2368f0d27e47b39a23121a825a2b33

> [4/5] arm64: dts: ti: k3-j722s-evm: Add overlay for quad IMX219
>       commit: c24ccb1cd77fb44087b2f7008d99626796b33ca4
> [5/5] arm64: dts: ti: k3-j722s-evm: Add overlay for TEVI OV5640
>       commit: 938806652b0a3c90d67e7137c91708d06940b03d

I have dropped 4 and 5 due to issues Rob pointed out in the other thread.

-- 
Regards
Vignesh
https://ti.com/opensource


