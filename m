Return-Path: <linux-kernel+bounces-179396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C178C5FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1861C21EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5538FB6;
	Wed, 15 May 2024 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="APiXXqrM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8823838A;
	Wed, 15 May 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746988; cv=none; b=TVSlVKlA2DeXPEg3KJXZ3eHWXyyHeh/IkCkvPnm1ZiMDdFR5zaPmHO3QSzUi796Zwq7VXJTUwYPglmX7FtqFSGfAXC7h0joUmRqRzmmR3fzGk8bAzX05PWvVh1DcOJTcKIzdFNXcMpF0uLoC6X/iVJYmxNtATHhts1j9hWBsb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746988; c=relaxed/simple;
	bh=8Awiz0PiHu6C/jaD0D9ripLDiAz+9a7E4CdPN8/555k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GsmFOVqBPXw7JcFfoSvxO3ocZNXxgeyxIus3Z9pKujMY6bsKnlNgL9G+Ta8rkA9p0/U/gbG82Jkx6N1YO8TSXknddJO89lb957k0T3skB3nA6aRn2T15Ul8SQjlPgAkIue9JbNBB/7ZuPAmEHOfifL3ZsGYHmalK87AQbz6sX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=APiXXqrM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F4N0jF113734;
	Tue, 14 May 2024 23:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715746980;
	bh=dufjzbsl5o++moeU25RHOlPciEN9mhqeZLQAsIfEYzg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=APiXXqrMhZExx5yeQ/ZiMxCJJ4B4NjOCYKszWnjOWlLLlr+pvw2oYXWBM41a8HKh+
	 qftph4v1GSJmPb5kBEkJfr63TqD7tZOWFfl6YsKEKglfKcDEK8MbGiOVcYirz+Xk1o
	 0SiwOv0vB/2EKVrvS5qERkRUZnhasBxc7Fk1feRA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F4N01k117463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 23:23:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 23:23:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 23:23:00 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F4MvTO025252;
	Tue, 14 May 2024 23:22:58 -0500
Message-ID: <dde63edb-9057-2d33-032a-8ee25e981c72@ti.com>
Date: Wed, 15 May 2024 09:52:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] usb: cdns3: Add quirk flag to enable suspend
 residency
Content-Language: en-US
To: Peter Chen <peter.chen@kernel.org>
CC: <pawell@cadence.com>, <rogerq@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240514092421.20897-1-r-gunasekaran@ti.com>
 <20240514092421.20897-2-r-gunasekaran@ti.com>
 <20240515013838.GA3279984@nchen-desktop>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240515013838.GA3279984@nchen-desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/15/24 7:08 AM, Peter Chen wrote:
> On 24-05-14 14:54:20, Ravi Gunasekaran wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>>
>> Some platforms (e.g. ti,j721e-usb, ti,am64-usb) require
>> this bit to be set to workaround a lockup issue with PHY
>> short suspend intervals [1]. Add a platform quirk flag
>> to indicate if Suspend Residency should be enabled.
>>
>> [1] - https://www.ti.com/lit/er/sprz457h/sprz457h.pdf
>> i2409 - USB: USB2 PHY locks up due to short suspend
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---

[...]

>>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>> @@ -439,6 +439,13 @@ int cdns_drd_init(struct cdns *cdns)
>>  			return -EINVAL;
>>  		}
>>  
>> +		if (cdns->pdata &&
>> +		    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
>> +			reg = readl(&cdns->otg_v1_regs->susp_ctrl);
>> +			reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
>> +			writel(reg, &cdns->otg_v1_regs->susp_ctrl);
>> +		}
>> +
> 
> It is better put this above (just above code cdns->version  =
> CDNS3_CONTROLLER_V1;)
> 

You mean here, to group it with CDNS3 v1?

else if (OTG_CDNS3_CHECK_DID(state)) {                                               
      cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
                            &cdns->otg_v1_regs->ien;
      writel(1, &cdns->otg_v1_regs->simulate);

+     if (cdns->pdata &&
+	  (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+	      reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+	      reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+	      writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+     }
      dns->version  = CDNS3_CONTROLLER_V1;
} else

> Peter
>>  		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
>>  			 readl(&cdns->otg_v1_regs->did),
>>  			 readl(&cdns->otg_v1_regs->rid));
>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> index d72370c321d3..1e2aee14d629 100644
>> --- a/drivers/usb/cdns3/drd.h
>> +++ b/drivers/usb/cdns3/drd.h
>> @@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
>>  /* OTGREFCLK - bitmasks */
>>  #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
>>  
>> +/* SUPS_CTRL - bitmasks */
>> +#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
>> +
>>  /* OVERRIDE - bitmasks */
>>  #define OVERRIDE_IDPULLUP		BIT(0)
>>  /* Only for CDNS3_CONTROLLER_V0 version */
>> -- 
>> 2.17.1
>>
> 

-- 
Regards,
Ravi

