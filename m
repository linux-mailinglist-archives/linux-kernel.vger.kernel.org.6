Return-Path: <linux-kernel+bounces-308604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A7965F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862331C215F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98018FDCD;
	Fri, 30 Aug 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JEGrKo/X"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7A18B49E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014345; cv=none; b=KFpMlcgzNfZgroagldueSNgN7I5/zA+vZacdfSloSRlwiz173RTE1ekHzrzlQOPjMLME+1daCkeQ1PhU93LiZjGeiduj/N5BTnHOyUFcLP9CSFygEX8OvB2tzFvd8XO0cO6aqZA/gHRUZmbJOTrCSe1ptsPZAUEW07FjFJc5PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014345; c=relaxed/simple;
	bh=nc7EPYQZLZ9mGInDChn49DCwpjgSr14D/xSOSirBVbM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJazNC0PhfoMQAM7IxwOWjrLywdAgqNTIbWr41ma6JFhF5DqWwy2c6iACRPUnXY2Ol/nMLdYLp5RWNSJLujsjaMroH89Ul9kMqisxt/PoSP6B4duCIaYYlv9kFEGhxekYAH7DODjiRRFHkVdpoW+aTgEYm8oJBuPO3pGVzKwps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JEGrKo/X; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UAcqXe099229;
	Fri, 30 Aug 2024 05:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725014332;
	bh=HaNK8zZsoTDfHhugOTFYaanU7CgVVFnIdrRtyLi5HSA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JEGrKo/XvCDq+JhCT6By8AZPQItvxt8N4GaIvKy3R1SW7nGzuEhBMo5VRd2WppoUi
	 5T5LFOXwLTHDe6sdQLtGzTqkHlXa1LC/UBGMAMyWRhfhfVzse0u2JUDy+9qo0tBUyu
	 sTS5wtIBcZguW/N9V7HAArYUE1FoWRzm4ZSNpY1k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UAcqUN087799
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:38:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:38:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:38:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UAcqvb123302;
	Fri, 30 Aug 2024 05:38:52 -0500
Date: Fri, 30 Aug 2024 05:38:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH -next v2 4/4] soc: ti: knav_qmss_queue: Simplify with
 dev_err_probe()
Message-ID: <20240830103852.umhwdwz6n4z3v7pg@woven>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-5-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830063228.3519385-5-ruanjinjie@huawei.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:32-20240830, Jinjie Ruan wrote:
> Use the dev_err_probe() helper to simplify error handling
> during probe.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Split into 2 patches.
> - Rebased the newest next.
> - Update the commit message.
> ---
>  drivers/soc/ti/knav_qmss_queue.c | 33 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index 02983f8ba1b6..d583a86028af 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -1091,10 +1091,8 @@ static int knav_queue_setup_regions(struct knav_device *kdev,
>  
>  	for_each_child_of_node_scoped(regions, child) {
>  		region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
> -		if (!region) {
> -			dev_err(dev, "out of memory allocating region\n");
> -			return -ENOMEM;
> -		}
> +		if (!region)
> +			return dev_err_probe(dev, -ENOMEM, "out of memory allocating region\n");


These make no sense to me :( -> just using dev_err_probe when there is
no chance of -EPROBE_DEFER ?
>  
>  		region->name = knav_queue_find_name(child);
>  		of_property_read_u32(child, "id", &region->id);
> @@ -1407,10 +1405,8 @@ static int knav_queue_init_qmgrs(struct knav_device *kdev,
>  
>  	for_each_child_of_node_scoped(qmgrs, child) {
>  		qmgr = devm_kzalloc(dev, sizeof(*qmgr), GFP_KERNEL);
> -		if (!qmgr) {
> -			dev_err(dev, "out of memory allocating qmgr\n");
> -			return -ENOMEM;
> -		}
> +		if (!qmgr)
> +			return dev_err_probe(dev, -ENOMEM, "out of memory allocating qmgr\n");
>  

Neither this

>  		ret = of_property_read_u32_array(child, "managed-queues",
>  						 temp, 2);
> @@ -1505,10 +1501,8 @@ static int knav_queue_init_pdsps(struct knav_device *kdev,
>  
>  	for_each_child_of_node_scoped(pdsps, child) {
>  		pdsp = devm_kzalloc(dev, sizeof(*pdsp), GFP_KERNEL);
> -		if (!pdsp) {
> -			dev_err(dev, "out of memory allocating pdsp\n");
> -			return -ENOMEM;
> -		}
> +		if (!pdsp)
> +			return dev_err_probe(dev, -ENOMEM, "out of memory allocating pdsp\n");

or this

>  		pdsp->name = knav_queue_find_name(child);
>  		pdsp->iram =
>  			knav_queue_map_reg(kdev, child,
> @@ -1784,16 +1778,12 @@ static int knav_queue_probe(struct platform_device *pdev)
>  	u32 temp[2];
>  	int ret;
>  
> -	if (!node) {
> -		dev_err(dev, "device tree info unavailable\n");
> -		return -ENODEV;
> -	}
> +	if (!node)
> +		return dev_err_probe(dev, -ENODEV, "device tree info unavailable\n");
>  
>  	kdev = devm_kzalloc(dev, sizeof(struct knav_device), GFP_KERNEL);
> -	if (!kdev) {
> -		dev_err(dev, "memory allocation failed\n");
> -		return -ENOMEM;
> -	}
> +	if (!kdev)
> +		return dev_err_probe(dev, -ENOMEM, "memory allocation failed\n");

or here.

>  
>  	if (device_get_match_data(dev))
>  		kdev->version = QMSS_66AK2G;
> @@ -1810,8 +1800,7 @@ static int knav_queue_probe(struct platform_device *pdev)
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret < 0) {
>  		pm_runtime_disable(&pdev->dev);
> -		dev_err(dev, "Failed to enable QMSS\n");
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to enable QMSS\n");

Do you see -EPROBE_DEFER chance here? Please explain.

>  	}
>  
>  	if (of_property_read_u32_array(node, "queue-range", temp, 2)) {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

