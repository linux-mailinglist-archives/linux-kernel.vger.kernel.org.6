Return-Path: <linux-kernel+bounces-180627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D98C70F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AF72837A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9106A11182;
	Thu, 16 May 2024 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uI5t7c1L"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7119479;
	Thu, 16 May 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834112; cv=none; b=WXgopBPKixhRuexqs5Q2sogTLRWZHaTeTl7R4hx+H3chii0BxfcfZ6d3NsGB+jxNrUVsOfzMrzxZlm0itfuhkc/I3lbnKy9Fq8priQA/0wEm4iWYr7sqqbW8f4dq1bgcgvaGqfHZRlV3p6vkB+FL6kf7Cllkp9pgfgYE0Zw4AvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834112; c=relaxed/simple;
	bh=R6g6Kbz23JJuHxxGxKU5UfnHFtwBCQKTbu8wuwF8h5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R6KXXKu6Yc0PV4bvkC4wOSLzM9nyfaGO7qKyS07Rc8ZAu8Wdwba9y1DpWk0yxbubNbch28ifMp+lEhgR9FqCF28VojFHTSDvIxX8cR4s/Yi1Qq4CcpG7YklZ+PSMmR8k3TrDN8qeaoyjP2eCtejUAJttr9IR+wCGDZeP8+p7TB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uI5t7c1L; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G4Z5po060121;
	Wed, 15 May 2024 23:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715834105;
	bh=qhrqxFtYpRU+Vl8uqo5rJIfOPHbM+LsyiYwbd5rWZWk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uI5t7c1LCpyJVLQe80TqhMKXhpmYZmEXhxdlUsnx6FawlrJIIxl02+UDS77h/BtqK
	 jTPIX4euwj7vG1WR8xckJRjmlEgpyhr1KgVW+MJ9GwRGaU10B2XSqR1TajnOPIhDaM
	 JvzcvZgEKfq7cEYk8+hbRv4dxrl9533Ty8gkuRno=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G4Z5CW019414
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 23:35:05 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 23:35:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 23:35:05 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G4Z2Mj100716;
	Wed, 15 May 2024 23:35:02 -0500
Message-ID: <a5a4db25-01a6-eec0-53fe-166029f71aec@ti.com>
Date: Thu, 16 May 2024 10:05:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] usb: cdns3: Add quirk flag to enable suspend
 residency
Content-Language: en-US
To: <peter.chen@kernel.org>, <pawell@cadence.com>, <rogerq@kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240516042845.31211-1-r-gunasekaran@ti.com>
 <20240516042845.31211-2-r-gunasekaran@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240516042845.31211-2-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/16/24 9:58 AM, Ravi Gunasekaran wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
> this bit to be set to workaround a lockup issue with PHY
> short suspend intervals [1]. Add a platform quirk flag
> to indicate if Suspend Residency should be enabled.
> 
> [1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
> i2409 - USB: USB2 PHY locks up due to short suspend
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Change log:
> ----------
> 
> Changes since v1:
> ----------------
> * Grouped the susp_ctrl register update along with
>   existing CDNS3 snippet as suggested by Peter Chen
> 
> v1: https://lore.kernel.org/all/20240514092421.20897-1-r-gunasekaran@ti.com/#t

[...]

> -	u32 state;
> +	u32 state, reg;
>  	int ret;
>  
>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> @@ -433,12 +433,21 @@ int cdns_drd_init(struct cdns *cdns)
>  			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>  					      &cdns->otg_v1_regs->ien;
>  			writel(1, &cdns->otg_v1_regs->simulate);
> +
> +			if (cdns->pdata &&
> +			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
> +				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
> +				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
> +				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
> +			}
> +
>  			cdns->version  = CDNS3_CONTROLLER_V1;
>  		} else {
>  			dev_err(cdns->dev, "not supported DID=0x%08x\n", state);
>  			return -EINVAL;
>  		}
>  
> +

Please ignore this patch. I didn't notice this.
I will send a v3 fixing it.


>  		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
>  			 readl(&cdns->otg_v1_regs->did),
>  			 readl(&cdns->otg_v1_regs->rid));
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index d72370c321d3..1e2aee14d629 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
>  /* OTGREFCLK - bitmasks */
>  #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
>  
> +/* SUPS_CTRL - bitmasks */
> +#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
> +
>  /* OVERRIDE - bitmasks */
>  #define OVERRIDE_IDPULLUP		BIT(0)
>  /* Only for CDNS3_CONTROLLER_V0 version */

-- 
Regards,
Ravi

