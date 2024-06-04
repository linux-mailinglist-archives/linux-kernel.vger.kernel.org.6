Return-Path: <linux-kernel+bounces-199908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961938FA79C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A712867F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5B139CFA;
	Tue,  4 Jun 2024 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RWZTDlRi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FE713957E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464852; cv=none; b=g4It9jFfQMcM/LcfTaoneXRpPVftj8gqa4AhYrtUEc4SbVWgFX+IT1fxKvT0ThGG+a1bHeOphxPD5NZ4kvDFeQvbJMWz5+Yz2AAJDNkAqgGnDwye83P5T9+O6Ftwy7Ip25Tbx1PKX8TxfccIUgteDl0TrQcU2VAj+fjWE1DxJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464852; c=relaxed/simple;
	bh=gU1Fx1GfKkbB7MyBjDci5PwEsJLxp6mBN0DeKWihvIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ke6KAkwpcNIthQQNMDLZsdgrdOhglP+6fRqzg314FZel6vgw33tix59VcgA1/DfAOb9anj8Uzqc2IVv8fWQB0IFAxdItD226LXCU6wSmRxchs0OmgHpi5ecTsH4UrJui0z6ZZqECCvAf1p4Lzo5eAH6pkE0xPzjWzEGhm40AxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RWZTDlRi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4541Y3c0101001;
	Mon, 3 Jun 2024 20:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717464843;
	bh=u4JTtTFaZn1Az1/n9VAvAUmZEnh8DwZmiDEI0s+4lkM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RWZTDlRiS97e9L10Rh9BBfXe7vooGC6NECVIZeR9QI5WBMNlF/+Vfwxe0H56IEq6z
	 2d9R6X5hHCqyGF+3HB2Q2Y47OWfeBDezjrrpdUUHARqtuEJHDwR9avukjw0VwKnogG
	 7ZwYDfkW7vyNpgMrJt4soBTP951lZ1chsw8PyZI0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4541Y3dN098142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 20:34:03 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 20:34:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 20:34:02 -0500
Received: from [10.249.139.5] ([10.249.139.5])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4541XxvA123748;
	Mon, 3 Jun 2024 20:34:00 -0500
Message-ID: <85020e6a-35c8-403c-8e85-3f37902093db@ti.com>
Date: Tue, 4 Jun 2024 07:03:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH] Fix nr_types assignment for TPS6594/3 and
 TPS65224
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <u-kumar1@ti.com>, <bhargav.r@ltts.com>,
        <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>
References: <20240603192500.645586-1-s-ramamoorthy@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240603192500.645586-1-s-ramamoorthy@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Shree

On 04-Jun-24 12:55 AM, Shree Ramamoorthy wrote:
> Fixes: 00c826525fba ("regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators")
> 

Your fixes tag must go after the commit message, along with your 
Signed-off-by; see [1]

[1] 
https://lore.kernel.org/linux-kernel/20240521094758.2190331-1-n-francis@ti.com/

> Marked as resend to include the correct Fixes: tag.
> 
> TPS6594/3 and TPS65224's nr_types assignment were incorrectly swamped in
> probe(), leading to memory underallocation and a NULL pointer error.
> Error detected in and solution tested on J7200 EVM.
> 
> Error logs:
> [   13.974024] Call trace:
> [   13.974025]  _regulator_put.part.0+0x40/0x48
> [   13.974028]  regulator_register+0x2b0/0xa00
> [   13.974031]  devm_regulator_register+0x58/0xa0
> [   13.974035]  tps6594_regulator_probe+0x4e0/0x5f0 [tps6594_regulator]
> ...
> [   13.974178] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
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

Thanks for spotting this fix!

-- 
Thanking You
Neha Malcom Francis

