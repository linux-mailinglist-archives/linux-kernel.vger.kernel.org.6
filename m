Return-Path: <linux-kernel+bounces-199499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629EC8D87C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC814B2179C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075681369B1;
	Mon,  3 Jun 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KFQx7REV"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864611366
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434991; cv=none; b=J1jg757kndHWz3yXiYNgybXXgPNCuVUG+qLnR67/yVLhFPMDqgDSkuoaIeHffo9M/sUiVR/4U2yaENUzb1e63wMwRkJY6+MXqnFpfCeHO/pvBlm6i9J7RUJlTDXm5iS9HLFAlYK9yTKDQKx6q3BdcZxtnPQ6AhGVTBFWQX3xXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434991; c=relaxed/simple;
	bh=1368XZAvzlfC/6803RyQGyJa+BTzFz3YES/xqB6au6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oSDPpDfD//Lj71AX3iAF7DkOdsa2tXt3J2x9ocBayy62jHfRgwwiuIArnJMpKkXxWZkxLMdLDXVF863r4qz03lga4znMZovU0bU7GFuCdx5MLg5wFazZUC7Puu85fm6egbe34ypfUbo7l6GceHA3IrgHAlkrTIihM0cxNgP99UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KFQx7REV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453HGNCg009033;
	Mon, 3 Jun 2024 12:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717434983;
	bh=JChILJzlq2tt8JMM3AnaoiRSRjrx9BEIpoWfEuiUXbQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KFQx7REV8f093OpCRqjan8tKKRYmcbERbnAKSFriISMOYW3nD5Wwna+ZsRzcP5Tj8
	 r/F4vUbU1eHr327ocFiTyF2NStiekgVxYznGZRutky9Xjc2a7bjlQ+w+FWPl0aT78t
	 +zoElKAWLwMbhqGB6RnCh6yUwlAI0LsEaAawvuto=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453HGN9l023264
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:16:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:16:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:16:22 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453HGJm0026382;
	Mon, 3 Jun 2024 12:16:20 -0500
Message-ID: <63167c3f-f583-4b2d-83c8-632827594ebb@ti.com>
Date: Mon, 3 Jun 2024 22:46:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Correct nr_types assignment for TPS6594/3 and
 TPS65224
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <n-francis@ti.com>, <bhargav.r@ltts.com>,
        <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>
References: <20240603170524.643010-1-s-ramamoorthy@ti.com>
 <20240603170524.643010-2-s-ramamoorthy@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240603170524.643010-2-s-ramamoorthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 6/3/2024 10:35 PM, Shree Ramamoorthy wrote:
> Swap nr_types assignment for TPS6594/3 and TPS65224.
> Issue detected with v6.10-rc1 and tested using a TI J7200 EVM board.


Please prefix line, where you want this patch to go

like tiL6.6 or so


> Log:
> [   13.974024] Call trace:
> [   13.974025]  _regulator_put.part.0+0x40/0x48
> [   13.974028]  regulator_register+0x2b0/0xa00
> [   13.974031]  devm_regulator_register+0x58/0xa0
> [   13.974035]  tps6594_regulator_probe+0x4e0/0x5f0 [tps6594_regulator]
> ...
> [   13.974178] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
>
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> ---
>   drivers/regulator/tps6594-regulator.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
> index 4a859f4c0f83..b66608ab2546 100644
> --- a/drivers/regulator/tps6594-regulator.c
> +++ b/drivers/regulator/tps6594-regulator.c
> @@ -660,11 +660,11 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>   	} else if (tps->chip_id == TPS65224) {
>   		nr_buck = ARRAY_SIZE(tps65224_buck_regs);
>   		nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
> -		nr_types = REGS_INT_NB;
> +		nr_types = TPS65224_REGS_INT_NB;
>   	} else {
>   		nr_buck = ARRAY_SIZE(buck_regs);
>   		nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
> -		nr_types = TPS65224_REGS_INT_NB;
> +		nr_types = REGS_INT_NB;
>   	}
>   
>   	reg_irq_nb = nr_types * (nr_buck + nr_ldo);
> --

