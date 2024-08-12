Return-Path: <linux-kernel+bounces-282923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4294EA93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C11F22651
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CB16EB7A;
	Mon, 12 Aug 2024 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GxosKveu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555516EB65
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457638; cv=none; b=lMsTIFEzZjxlvZK41Woda9pAVy6SYptPJ9z+0BiBr2y2yzlz9pu36OXJsRcopgcfwpa3a1kJXVU4/3hRbbwe6H05UGIfdVP6pxl7alx/q5HjTEkME0pw/YKwmvbXNtbvac+G/xXtCIE4sO4JNYDLEJ5B/MuKlcOhue0oI3p61y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457638; c=relaxed/simple;
	bh=V8qaoAnw8/RyT2FcihHWbdEKS799eh7cG4UN0oy1lw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u40XL9WhwtHESu6pxSE4v8K76c3YiHpat72gXCxfcAgyaoX8u+92tRQ3CXkXPtwR1Hh86bAP+NAfh0lB6K1buutBZVU/yBgKSPDE5+2jK5658GpCbzZCiB+1QhYW5A9mBS5HUIFcvmjiuxsyUPcCQOzmqbCsREK1E/zdFPhLIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GxosKveu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CABoIJ058174;
	Mon, 12 Aug 2024 05:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723457510;
	bh=jetBjWlaxcB1THwlxqi2YhaDriyDPW2lWzkPmfG3rNo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GxosKveut4rFochjGgKtdHu8RfoG8lwgdu01ZprsjXwBU7dUP9q5GAn9UyZ1Xb1ZD
	 qt6OU8hfXIIcRUo+m2+jho8z236iHACZ31AutpzW492Cor4v/RIN0kdf6iLbbZb0O4
	 EfHiiTLUxbFcFRagtUpVI6SIFjizruk+ORhEBLWg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CABoaO030952
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 05:11:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 05:11:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 05:11:49 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CABnaQ117106;
	Mon, 12 Aug 2024 05:11:49 -0500
Date: Mon, 12 Aug 2024 15:41:48 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/4] firmware: ti_sci: add CPU latency constraint
 management
Message-ID: <20240812101148.wpybfhqkd2kponp7@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809135347.2112634-5-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On Aug 09, 2024 at 15:53:47 +0200, Markus Schneider-Pargmann wrote:
> From: Kevin Hilman <khilman@baylibre.com>
> 
> During system-wide suspend, check if any of the CPUs have PM QoS
> resume latency constraints set.  If so, set TI SCI constraint.
> 
> TI SCI has a single system-wide latency constraint, so use the max of
> any of the CPU latencies as the system-wide value.
> 
> Note: DM firmware clears all constraints at resume time, so
> constraints need to be checked/updated/sent at each system suspend.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 5cbeca5df313..481b7649fde1 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -9,6 +9,7 @@
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
>  #include <linux/bitmap.h>
> +#include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> @@ -19,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/property.h>
>  #include <linux/semaphore.h>
>  #include <linux/slab.h>
> @@ -3639,7 +3641,25 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>  static int ti_sci_suspend(struct device *dev)
>  {
>  	struct ti_sci_info *info = dev_get_drvdata(dev);
> -	int ret;
> +	struct device *cpu_dev;
> +	s32 val, cpu_lat = 0;
> +	int i, ret;
> +
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> +		for_each_possible_cpu(i) {
> +			cpu_dev = get_cpu_device(i);
> +			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
> +			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT)
> +				cpu_lat = max(cpu_lat, val);
> +		}
> +		if (cpu_lat && cpu_lat != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +			dev_dbg(cpu_dev, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);

An interesting observation was made which caused us to suspect this
code, the CPU on which the latency was actually being set was not being
printed here. It was always the cpu3

cpu cpu3: ti_sci_suspend: sending max CPU latency=100

If you look at how this print comes, it's always after all the cpu
indices have run, so by then the cpu_dev value will have always become
= nproc in the system. This makes debugging it confusing.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

