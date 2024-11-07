Return-Path: <linux-kernel+bounces-400025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333B9C07E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485532867F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728BB20FAB1;
	Thu,  7 Nov 2024 13:46:05 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E112DDBE;
	Thu,  7 Nov 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987165; cv=none; b=mrCwSSctk5KN/Q58L6O9ZlbXTXU9qCyjuZMa+SElNG6cphhh0h+JcxeH4jelgTge+uRcXe3T7QMQeWtYFXZBqETzBzIGL3S1SqH562wMY6oztJ5wbm7tgzoypex+nZKASAyHaPaDAbIBTw7unTtCLIKy8sUm49dQgpH1RD47xK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987165; c=relaxed/simple;
	bh=AO5LLAj2ZoEfmi/bLAhhUcxI/SsQAksgM6swakcmW9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d5K846ZlONIgMdwStK3euyGbKG8zZL8tPQ51FBDa9tJ12t1TN3rps9R9Hzvtb0u00VHbRXdpQ5e6HQnEyH4y0SyivnRdPFhA8HewZOWxV22piyuyIob+wsV1GTcprVrBr4CVbCR+1wu1O7ctFe0a1qfXU8TyS3QdEiCCGQk7yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XkjxJ5DLQzQsbf;
	Thu,  7 Nov 2024 21:44:52 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A1F114039F;
	Thu,  7 Nov 2024 21:46:01 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 7 Nov 2024 21:46:00 +0800
Message-ID: <cb94d71e-d421-4781-adf1-301da10f4d6a@huawei.com>
Date: Thu, 7 Nov 2024 21:45:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: clk-axi-clkgen: fix division by zero in
 axi_clkgen_calc_params()
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <lars@metafoo.de>,
	<mturquette@linaro.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
References: <20241026072344.976154-1-quzicheng@huawei.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20241026072344.976154-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500016.china.huawei.com (7.185.36.70) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Gentle ping.

On 2024/10/26 15:23, Zicheng Qu wrote:
> In the axi_clkgen_set_rate() function, parameters fin and fout are
> checked in advance to ensure they are not equal to zero. However, in the
> axi_clkgen_calc_params() function, they might become zero after /= 1000.
> This could lead to a division by zero error when calculating
> fvco_max_fract * d_max / fin or DIV_ROUND_CLOSEST(fvco, fout). The same
> issue occurs in the axi_clkgen_determine_rate() function, where there
> is no check to ensure they are non-zero.
>
> Fixes: 0e646c52cf0e ("clk: Add axi-clkgen driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>   drivers/clk/clk-axi-clkgen.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index bf4d8ddc93ae..369b15a2660e 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -344,7 +344,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
>   	uint32_t filter;
>   	uint32_t lock;
>   
> -	if (parent_rate == 0 || rate == 0)
> +	if (parent_rate < 1000 || rate < 1000)
>   		return -EINVAL;
>   
>   	axi_clkgen_calc_params(limits, parent_rate, rate, &d, &m, &dout);
> @@ -392,6 +392,9 @@ static int axi_clkgen_determine_rate(struct clk_hw *hw,
>   	unsigned int d, m, dout;
>   	unsigned long long tmp;
>   
> +	if (req->best_parent_rate < 1000 || req->rate < 1000)
> +		return -EINVAL;
> +
>   	axi_clkgen_calc_params(limits, req->best_parent_rate, req->rate,
>   			       &d, &m, &dout);
>   

