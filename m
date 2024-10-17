Return-Path: <linux-kernel+bounces-369250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2A9A1ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F36288F29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4818EFE4;
	Thu, 17 Oct 2024 06:40:02 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24471194AEA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147202; cv=none; b=amq1LGqM10zejY1brTJ3y8QRvrkH2gZsGoQXqHQecjHYxLh9D5ElC91boH79KsPwMFld8mYDJ/CkvtvC5RP4csd34Ph5nUGe6IDIZIDyBtAvY1HWaT5t0vFrdxDRJz0dBi9nDVmDLZ6XjAT0kNrQcLa3PbUQj5IOkW0kMtCz2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147202; c=relaxed/simple;
	bh=3MiH4pycqvZPT/08Ihmq2/dH8+TXtyK74EmfXaWbcGU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ku0y5FI8Qb1Ht0GKabrOmYCAF0NuLV2WCAbk87ma7IjeCbCsjuu3vLecHskweoMqAd5fKYpF90TlVqkYVoI+xMxRJ550EUYU5nPJDOpBl/tApii1d6hGIzHKwV5qgjEXeA2hpy2gl9rwZry+LF0wGhmhhQjsVMUfUpbFpcgIeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XTdST5fC6z1T8g5;
	Thu, 17 Oct 2024 14:38:01 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BF841401F4;
	Thu, 17 Oct 2024 14:39:55 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 17 Oct 2024 14:39:54 +0800
CC: <jonathan.cameron@huawei.com>, <yangyicong@hisilicon.com>,
	<will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/perf: hisi: Fix readl DDRC_VERSION stuck
To: Youwan Wang <youwan@nfschina.com>
References: <20241010084217.37540-1-youwan@nfschina.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <4c0097dd-6dd3-e4e6-14d1-d94a6d98bf5a@huawei.com>
Date: Thu, 17 Oct 2024 14:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241010084217.37540-1-youwan@nfschina.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/10/10 16:42, Youwan Wang wrote:
> The CPU of the device I am using is kunpeng 920,
> which can start normally with version 5.4 kernel.
> However, when installing version 6.6 kernel, the
> kernel gets stuck when loading the "hisi_dddrc_pmu"
> driver. I went to debug and found that it gets stuck
> when "readl (ddrc_pmu ->base+DDRC_VERSION)". I suspect

what does "stuck" mean here? do you see some hardware errors
or similiar? If so this should be an unexpected device and
your patch still doesn't address the issue, since you only make
the probe work but the device's still inaccessible so it
shouldn't be appeared in the system.

as Will mentions, this is probably a firmware issue. please
try to update to the latest firmware.

Thanks.

> that the hardware does not support it. My modification is:
> for the "HISI0233" device, according to the implementation
> of version 5.4 kernel, the identity is not obtained from
> the register. For "identifier" sysfs, identifier: 0
> 
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index b804e3738113..3cecad46b01f 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -321,6 +321,9 @@ static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
>  		return PTR_ERR(ddrc_pmu->base);
>  	}
>  
> +	if (strstr(pdev->name, "HISI0233"))
> +		return 0;
> +
>  	ddrc_pmu->identifier = readl(ddrc_pmu->base + DDRC_VERSION);
>  	if (ddrc_pmu->identifier >= HISI_PMU_V2) {
>  		if (device_property_read_u32(&pdev->dev, "hisilicon,sub-id",
> 

