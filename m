Return-Path: <linux-kernel+bounces-293567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B595816A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877B1281BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287D18A947;
	Tue, 20 Aug 2024 08:54:44 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494918E352;
	Tue, 20 Aug 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144083; cv=none; b=EJnBzuu9cWz4JAVPyNl2qjYcADFCBJ3EaGH84FiNlLDB+CdRddzROivGET6k1BxYJHbbx7c0YDWiwjvRAjEcHJkMGRThDEuN7gzXjI92lsbLZpKDimAP/UXtPd2MSVH4zg4XoqUrjgzDiTzfjtJC+x7HJpDMd+Bd72Oi//ZVnDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144083; c=relaxed/simple;
	bh=288MkP3JqUQevQlkGrbOta9LibnOtTMr1XKPO1zHzE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MXHsHqR5+hTHVBqYWohgs47JBwOVuWm3e0VvHRApiF8j5dJapETbEOeKfMtXtNHEwkXPx8rxYhGIXYBgacOhNXUGGABHYIGSxekB5FwMGBlbEwa+gviMGrfLygiItaAlVF8pOhW8QHcJ8bXHEEHAaj9a2VIe2xkZF5SABov1av0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wp3725pvrz2Cn5v;
	Tue, 20 Aug 2024 16:49:34 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A69F1401F2;
	Tue, 20 Aug 2024 16:54:34 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 16:54:33 +0800
Message-ID: <ae6a4702-3225-620c-e83b-b8736ac486a8@huawei.com>
Date: Tue, 20 Aug 2024 16:54:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in
 probe()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Anup Patel
	<apatel@ventanamicro.com>
CC: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <a5a628d6-81d8-4933-81a8-64aad4743ec4@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/20 16:42, Dan Carpenter wrote:
> The devm_platform_ioremap_resource() function doesn't return NULL, it
> returns error pointers.  Fix the error handling to match.
> 
> Fixes: 2333df5ae51e ("irqchip: Add RISC-V advanced PLIC driver for direct-mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/irqchip/irq-riscv-aplic-main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
> index 28dd175b5764..981fad6fb8f7 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -175,9 +175,9 @@ static int aplic_probe(struct platform_device *pdev)
>  
>  	/* Map the MMIO registers */
>  	regs = devm_platform_ioremap_resource(pdev, 0);
> -	if (!regs) {
> +	if (IS_ERR(regs)) {
>  		dev_err(dev, "failed map MMIO registers\n");
> -		return -ENOMEM;
> +		return PTR_ERR(regs);

LGTM
Reviewed-by:  Jinjie Ruan <ruanjinjie@huawei.com>

>  	}
>  
>  	/*

