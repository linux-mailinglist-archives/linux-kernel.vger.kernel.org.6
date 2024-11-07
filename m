Return-Path: <linux-kernel+bounces-399130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE69BFB72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD631C20F50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3549BA50;
	Thu,  7 Nov 2024 01:27:54 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0517485
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730942874; cv=none; b=WXdNFgpDrbqWsoWotkQcqRFM2KvEBwHL4RJdyIeIx1xjZJFCPqLbCYqAZgW8kvPMOpl7XPFoeU8DLTFGG/CyJ1tyEio8GbmiI2Q6bny9YzcApF56TWwVYq88UyAYFl72xthd/9FQvxzeBWVSP4R75yzjb5T3dKHKyd97JSX4eKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730942874; c=relaxed/simple;
	bh=c97e6RumXveRoswKoNyMbHWw5+eRQGvyl4LHYEZ9yJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cr9I87SGG8JGXFpr686q9xmDd1O2WjJI8WiKXzJJOQItDo91w87sXp0cWnFiel/AX64V+wexXVtU8llYKBDXRjfv0PeERbOoKPAJGjqyVkeemzUQDa2fIGOt+RKi0XhF/9zCZYCtLHUz1QxXa4eJA5cLahSHLvkwS4fTUqqTNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkPXv3c7fz1SCCT;
	Thu,  7 Nov 2024 09:26:07 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E4F07180042;
	Thu,  7 Nov 2024 09:27:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 09:27:49 +0800
Message-ID: <ee6521c6-9038-ab16-0773-c9425aae54fd@huawei.com>
Date: Thu, 7 Nov 2024 09:27:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] phy: ocelot-serdes: Fix IS_ERR() vs NULL bug in
 serdes_probe()
Content-Language: en-US
To: <vkoul@kernel.org>, <kishon@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<florian.fainelli@broadcom.com>, <colin.foster@in-advantage.com>,
	<davem@davemloft.net>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241101061145.2282501-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241101061145.2282501-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Gentle ping.

On 2024/11/1 14:11, Jinjie Ruan wrote:
> dev_get_regmap() call can return a null pointer. It will not return
> error pointers. Thus apply a null pointer check instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: 672faa7bbf60 ("phy: phy-ocelot-serdes: add ability to be used in a non-syscon configuration")
> Acked-by: Colin Foster <colin.foster@in-advantage.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Add Acked-by.
> - Update the commit message as Markus suggested.
> ---
>  drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
> index 1cd1b5db2ad7..77ca67ce6e91 100644
> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
> @@ -512,8 +512,8 @@ static int serdes_probe(struct platform_device *pdev)
>  						    res->name);
>  	}
>  
> -	if (IS_ERR(ctrl->regs))
> -		return PTR_ERR(ctrl->regs);
> +	if (!ctrl->regs)
> +		return -EINVAL;
>  
>  	for (i = 0; i < SERDES_MAX; i++) {
>  		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);

