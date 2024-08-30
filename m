Return-Path: <linux-kernel+bounces-308595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CC0965F52
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4159E28CC14
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632E18890C;
	Fri, 30 Aug 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PT4RcJEE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BA17B516
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013928; cv=none; b=rlcNB5dfyTAnmtOBYLi5mTuP/tZ/4KyQUiI/OVx4t6oqx8NsqeTJS8EAP3YYajbpmgNgCFCxoDx0t3as5fTe2ymigB/kFehxfPNNpqx84LsOB96RkG9Gt/L2jX0gS2IG4UNRB3sTyiW6U/qy6nu7LmjNUTYhvorDfkFxjqlYkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013928; c=relaxed/simple;
	bh=Mh8KzWt85+9N1r4Lufrg/2nGIRU7Lfvq9ZLv9/UZ2HA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBh+67tsq/Rr5+bq2t4kiwcSjVRZ+wbtz1niOYEtKEfEkb0CsVzdh0WKTjvAcEHXimookDqLKdevozvcJyJiQ7CXe76gUjCYrNBYFHsO/SJBPIHVPCcTYjKub8ZsbimhWgGiXJTZDMeQlKwfDKyOvuJxC3l8vJw6kzUDBw+NkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PT4RcJEE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UAVuu3060179;
	Fri, 30 Aug 2024 05:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725013916;
	bh=w4Jzaq0Y7/xiEjF91drQYyJ41nHthb2pShJ9sOCFt0I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=PT4RcJEE65NDkJrya4c9jfSR8fxM7HxzF757dvi8J5N2NdZotmhGddsdeo8skRxYw
	 vpVCIbe5DnIp2qNmqxGbNYI7xbdUplGTDw3Dt2eutcOKz9l/MseOJC/PQ8I4VM/lO0
	 Tu2ZrOfYiqvg45fD7tcApFRdEwi7X0oGJMFxyc9M=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UAVuvu032558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:31:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:31:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:31:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UAVtJ4116324;
	Fri, 30 Aug 2024 05:31:55 -0500
Date: Fri, 30 Aug 2024 05:31:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <krzk@kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
Message-ID: <20240830103155.5vs2hdokw6yysq47@finance>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830063228.3519385-3-ruanjinjie@huawei.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:32-20240830, Jinjie Ruan wrote:
> Use the dev_err_probe() helper to simplify error handling
> during probe.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Split into 2 patches.
> ---
>  drivers/soc/ti/knav_dma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index 15e41d3a5e22..eeec422a46f0 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -708,17 +708,13 @@ static int knav_dma_probe(struct platform_device *pdev)
>  	struct device_node *node = pdev->dev.of_node;
>  	int ret = 0;
>  
> -	if (!node) {
> -		dev_err(&pdev->dev, "could not find device info\n");
> -		return -EINVAL;
> -	}
> +	if (!node)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "could not find device info\n");
>  
>  	kdev = devm_kzalloc(dev,
>  			sizeof(struct knav_dma_pool_device), GFP_KERNEL);
> -	if (!kdev) {
> -		dev_err(dev, "could not allocate driver mem\n");
> -		return -ENOMEM;
> -	}
> +	if (!kdev)
> +		return dev_err_probe(dev, -ENOMEM, "could not allocate driver mem\n");

These make no sense to me :( -> just using dev_err_probe when there is
no chance of -EPROBE_DEFER ?

>  
>  	kdev->dev = dev;
>  	INIT_LIST_HEAD(&kdev->list);
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

