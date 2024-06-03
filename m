Return-Path: <linux-kernel+bounces-199514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3258D87F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B011F22F59
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA3137764;
	Mon,  3 Jun 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E7yRObjS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA2262B6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435912; cv=none; b=o8o9oCEmhGdmyIfJN+/DTiLA2ivGmtUBHC6UHrwpLexS+H+y9wr5wnYWASFb+kj0GR+Hbuw4IdF9Bl/el6vOTE6LV6Z1XQc67dGbfb1QokrQ8vU9aglOqxMoLUWOOTdgls25cpym+nOf27+7KViHo64vGdizRDHD6kxir9vOZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435912; c=relaxed/simple;
	bh=vGhYcr0+gYUyTAifot4Vhtgw/itqf24EiBKozbQQf5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fWuQj8P4oH3yjRmzQ3AMag7LP684PD8jgnx97WhIzeNaN6uP8S4IWRrHPHKgANNSchxMsI1+8jDlVCqulYFTDfdqG1SH2GE1zZiQsc3z96UiH7DvT0J05p3udKPBAHoXv8JSebfDnH2ne7g2NYfBtX+6U+KXhFW3oW7YTHCUhec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E7yRObjS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453HVi9m015573;
	Mon, 3 Jun 2024 12:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717435904;
	bh=kRDCV0dmaLYdBq6EzHV1AR1oRsGqL12bPgTrR83mOKw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E7yRObjS9cDNDlsg/5DzYhrwXdTiMUUVDQcnGUMEvJ1gRob5MblfrbijV7QTKyiFZ
	 NwxfGDxTsPKvFNxAUeocE38LuLOl5NxtApsanMRJVmmjEMQ2ubita9it6sFIE2/gE/
	 qfVpiaGHc+y4u7dG99dZBXIKiFIi8rsVEw/dLbhY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453HViSo116201
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:31:44 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:31:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:31:44 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453HVf7i051902;
	Mon, 3 Jun 2024 12:31:42 -0500
Message-ID: <117f2292-b2a1-470f-8d88-80f325f3341b@ti.com>
Date: Mon, 3 Jun 2024 23:01:40 +0530
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
CC: <m-leonard@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
        <bhargav.r@ltts.com>, <m.nirmaladevi@ltts.com>
References: <20240603170524.643010-1-s-ramamoorthy@ti.com>
 <20240603170524.643010-2-s-ramamoorthy@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240603170524.643010-2-s-ramamoorthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 03/06/24 22:35, Shree Ramamoorthy wrote:
> Swap nr_types assignment for TPS6594/3 and TPS65224.
> Issue detected with v6.10-rc1 and tested using a TI J7200 EVM board.
> 
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

Please add a appropriate Fixes: tag

>  drivers/regulator/tps6594-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
> index 4a859f4c0f83..b66608ab2546 100644
> --- a/drivers/regulator/tps6594-regulator.c
> +++ b/drivers/regulator/tps6594-regulator.c
> @@ -660,11 +660,11 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
>  	} else if (tps->chip_id == TPS65224) {
>  		nr_buck = ARRAY_SIZE(tps65224_buck_regs);
>  		nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
> -		nr_types = REGS_INT_NB;
> +		nr_types = TPS65224_REGS_INT_NB;
>  	} else {
>  		nr_buck = ARRAY_SIZE(buck_regs);
>  		nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
> -		nr_types = TPS65224_REGS_INT_NB;
> +		nr_types = REGS_INT_NB;
>  	}
>  
>  	reg_irq_nb = nr_types * (nr_buck + nr_ldo);
> --

-- 
Regards
Vignesh

