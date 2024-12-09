Return-Path: <linux-kernel+bounces-438591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06AF9EA335
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCC71611DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8A21505D;
	Mon,  9 Dec 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoODyZ4s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703D17836B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788585; cv=none; b=QAWOlPxh6b/3Gs8Xx3r3lMFiQ8VO8zG7bm4AO8zxy8AV0Y73nwYINOy5akKVfjBjXUnxKFWO23eXiKp22RYYrIkPQK48iJR0XKlmoc2KyL6DEyB16RFk4N31SiobDs/voORsA8Z7SH5ig6m95wF3RwZzv3NpnSvCq98wMZNeYSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788585; c=relaxed/simple;
	bh=8nls+6emlMYU+2UVPHOrkwylBu+VOxlMuIHza7apa3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biDdj40eT6+UvHGkR3atkn2ziZi3AtsDRl7iDKej3/eqKrJUdEfAbhbYdEGPFu9S0X3tnl/hZjxmZVwlBrCTsRir1Gx6D+uPo6vnJ3h2AFIBfm1ehTT7yk5khmAYQfRLRvx2/q7gATmDm8784BYzj//FCighVoQcMNLWBRMeld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoODyZ4s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IqZbj015578
	for <linux-kernel@vger.kernel.org>; Mon, 9 Dec 2024 23:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DTCQCSqJkGvrF7Qnrq/uQxbOaJBMueDBFYwtdXSF5EE=; b=BoODyZ4s9MShb/T/
	JeeYQjpnD8Pq50zavEvGNNv3JSMJjrZ4zdYeVbh/Oo3lI05t3zpFoZgJhRpLRaSb
	y5fDMzzFGDKrHE7Ynj6qAz5o6zFzHISnN4+6mqqQt7j5ww2KPfMvtqX3mFX57bGT
	sOUklaUiJ+blDxlEKy/2f5XwJjUhL/wa7wYTQLr6lotVwaIcm3/fUmwDSQ+T+/EJ
	fTO6WmrVo/SLilIB7ysjXkUUeYHA8Fldi250a0nMECw29utJYZ/fBRdknF3BgcDt
	K6JHCcrlPeRF7puX2dLYT9sG3qwk8PD7guxX440W7ecemk0BV23G3YgR/N0/Ry68
	DAf4Eg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dy8tt4du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:56:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2efa0eb9cfeso1538062a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788581; x=1734393381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTCQCSqJkGvrF7Qnrq/uQxbOaJBMueDBFYwtdXSF5EE=;
        b=Y6QEOhz/M95iI1vzrLHoJ81Y4MrL2RkpxiORU9i1gTYnPEAdDqT/aa3O5ZpEEtEknw
         u26s5HWiHueeURqGuhlN3v9csXR7LyYgXai47epCvMuWxS4NRCq2tjjiQnedGPBgVvZE
         c5mQa5tO6QgVpWfraOByWTOQpvYyEy+/imCvRwo7xeKYnV6DBBRHONBGHscCHPoOXszR
         du7C0lr4g0M0MH4gbTRJiI1sGsw3XduWbtgisdPmXF0prkJ3PmnKzg9njiUMwX80G+4f
         tr4ZcMunKO0MVxmh3tzOK2NDPEphTGWIC27w9jTpSsJK0Bl3B0gv5J44qEhT19lb4gJi
         qdBw==
X-Gm-Message-State: AOJu0YxXeRxIdz6ZRE8cfQFNIT/QzQ6FFIFoIo5Lv/w5x8mVWX8UoGbS
	4CPm7jYbZ5TI6zO5GQQKlguHj7UgTKPmI83dwX5YnrgC/YI7OpmeP1dfKuZlU78E3Sgjq62Oljl
	oIlgpPNGnyADnbjnKTY8Qp+xjILThkH4FcBxTSoWga0FvQmu5Ul9GjBv57A2GIr4=
X-Gm-Gg: ASbGncs65S+aD6Ju5s3WiTHnAo6u0VmGSRWioIxYAKoCUK5+6963T20EGfceZYulW+U
	wd6n1qQrIL3Q7i3A9H/vXHCwjtsdjXnxMfjIz2jjfqHsV2UDKeTPqCKMagJ9dVDllFmQex5/9+V
	Qv1GmbA/KYLuoWApC7A0q4+WqaMk9oZ+Kf+Pf6mpBbx90p8tbg5LIg7wI6k4Ooq81LOSJTVz6md
	R80uJ7XW8mmw7SzJFccPaIi8PcZAUWpzBuyTI7Ju01MHrzToHj5UL1RJuuny5WMehsYsVH41ZEq
	YNbFvYzWryMcfOM=
X-Received: by 2002:a17:90b:180a:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2efd5b0470cmr1873758a91.15.1733788581349;
        Mon, 09 Dec 2024 15:56:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkNyFkX/d6wU8IDF6jZ24Jj8GwEZ93U88ca4Fy4hIzHoFjcRXz9lI7LFAd7X4hFBHRrhnIVQ==
X-Received: by 2002:a17:90b:180a:b0:2ea:8aac:6ac1 with SMTP id 98e67ed59e1d1-2efd5b0470cmr1873734a91.15.1733788580934;
        Mon, 09 Dec 2024 15:56:20 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45f7eae2sm8591830a91.7.2024.12.09.15.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:56:20 -0800 (PST)
Message-ID: <a10e34df-bbd8-462a-8851-51eabda87775@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 15:56:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: hisilicon: kunpeng_hbmdev: Add support for
 controling the power of hbm memory
To: Zhang Zekun <zhangzekun11@huawei.com>, xuwei5@hisilicon.com,
        lihuisong@huawei.com, Jonathan.Cameron@huawei.com
Cc: linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
References: <20241206112812.32618-1-zhangzekun11@huawei.com>
 <20241206112812.32618-2-zhangzekun11@huawei.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241206112812.32618-2-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oIoceq3FWU4ddn41J_hZcNbnHz-ej3R9
X-Proofpoint-GUID: oIoceq3FWU4ddn41J_hZcNbnHz-ej3R9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090186

On 12/6/24 03:28, Zhang Zekun wrote:
> Add a driver for High Bandwidth Memory (HBM) devices, which will provide
> user space interfaces to power on/off the HBM devices. In Kunpeng servers,
> we need to control the power of HBM devices which can be power consuming
> and will only be used in some specialized scenarios, such as HPC. HBM
> memory devices in a socket are in the same power domain, and should be
> power off/on together.
> 
> HBM devices will be configured with ACPI device id "PNP0C80", and be used
> as a cpuless numa node. HBM devices in the same power domain will be put
> into the same container. ACPI function "_ON" and "_OFF" are reponsible
> for power on/off the HBM device, and notify the OS to fully online/offline
> the HBM memory.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---

...

> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
> index 6d7c244d2e78..b3ca7d6f5d01 100644
> --- a/drivers/soc/hisilicon/Kconfig
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -21,4 +21,16 @@ config KUNPENG_HCCS
>  	  health status and port information of HCCS, or reducing system
>  	  power consumption on Kunpeng SoC.
>  
> +config KUNPENG_HBMDEV
> +	bool "add extra support for hbm memory device"
> +	depends on ACPI_HOTPLUG_MEMORY
> +	select ACPI_CONTAINER
> +	help
> +	  The driver provides methods for userpace to control the power
> +	  of HBM memory devices on Kunpeng soc, which can help to save
> +	  energy. The functionality of the driver would require dedicated
> +	  BIOS configuration.
> +
> +	  If not sure, say N.
> +
>  endmenu
> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
> index 226e747e70d6..08048d73586e 100644
> --- a/drivers/soc/hisilicon/Makefile
> +++ b/drivers/soc/hisilicon/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
> +obj-$(CONFIG_KUNPENG_HBMDEV)	+= kunpeng_hbmdev.o
...
> diff --git a/drivers/soc/hisilicon/kunpeng_hbmdev.c b/drivers/soc/hisilicon/kunpeng_hbmdev.c
> new file mode 100644
> index 000000000000..1945676ff502
> --- /dev/null
> +++ b/drivers/soc/hisilicon/kunpeng_hbmdev.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Huawei Technologies Co., Ltd
> + */

...

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhang Zekun <zhangzekun11@huawei.com>");

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. My usual guidance is to add the
missing MODULE_DESCRIPTION() to avoid such warnings. But in this case,
due to how your Kconfig & Makefile are defined, this can NEVER be built
as a module, and hence I'd remove all of the MODULE_*() macros.

/jeff

