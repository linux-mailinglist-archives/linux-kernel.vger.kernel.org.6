Return-Path: <linux-kernel+bounces-312002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE139690C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38275283522
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450A4A06;
	Tue,  3 Sep 2024 00:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azxADvZ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5D1A4E62
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725324864; cv=none; b=DSxxj8GzlONuOxgsebA20mv34SsgyYAVevnXDsyNHvNp4tn2ujUfsPEXoJGGofn0hJiwKUFcYnmtFZwE3I4wszhVwwQZ7WL9TVaicCgdHJ+pJlEnEEDlRUfT/bjKsawdaWBoRiBY1ihWLTfXv6LT2PxnAKHRTdDAOuamaMTGBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725324864; c=relaxed/simple;
	bh=PcGrK34WfaOT41arniGBOCZWp4Nbd4SJ0LJW2GsW2XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYUawsKoWrsTyN4KdbdI/oqQ19y3zRKsSVpHVvX/d44QF05VSI/S+5wr9e5vP4iKRENc5z8wpeD+Fs2Lqg55RjjQqv2yG/8D+nG17y1zLF0kB6Q62A82TqxAYstV2RCiqMiRs1L/64FonoBWzFqqjVFOpawMS1E5of0LbQc+lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azxADvZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4608C4CEC2;
	Tue,  3 Sep 2024 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725324864;
	bh=PcGrK34WfaOT41arniGBOCZWp4Nbd4SJ0LJW2GsW2XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azxADvZ0j15BfNU2DzUHEzWMNXCSNTKeFCu0w/CTbYf838uxk1WBDnCRH5wTGPPE1
	 XXtsokI1j5tt/8f65q5A5kxYRbC/aBc5es2l5PtqM/r8LJf/wsiFWZMMMOVQ7dactm
	 isBtM4qp9BewzK1XJenJzCabFm2aFQTMTrcBTVbZDpt+INSdbLQfd7txhu9uiwZcce
	 Rg4nNMWDsDJ2z8nALvdcxh3EytXuvec2DiZ8iCXl+pbW7Lc6MX0XwEi7ler5Jcjbv5
	 VZklMFAP8IyRyPkuSVhJObU48lcix6aoV2mx3AULq5y5Om8yk0VNe/yXvJoy1K1bqm
	 9ZcAxA8vqBCAg==
Date: Mon, 2 Sep 2024 17:54:22 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] firmware: ti_sci: add CPU latency constraint
 management
Message-ID: <20240903005422.GA4638@thelio-3990X>
References: <20240829201606.1407773-1-msp@baylibre.com>
 <20240829201606.1407773-5-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829201606.1407773-5-msp@baylibre.com>

Hi Markus,

On Thu, Aug 29, 2024 at 10:16:05PM +0200, Markus Schneider-Pargmann wrote:
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
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 8482b7077eef..d5d64e5ffbd7 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) "%s: " fmt, __func__
>  
>  #include <linux/bitmap.h>
> +#include <linux/cpu.h>
>  #include <linux/debugfs.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> @@ -20,6 +21,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>
>  #include <linux/property.h>
>  #include <linux/semaphore.h>
>  #include <linux/slab.h>
> @@ -3669,7 +3671,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>  static int __maybe_unused ti_sci_suspend(struct device *dev)
>  {
>  	struct ti_sci_info *info = dev_get_drvdata(dev);
> -	int ret;
> +	struct device *cpu_dev, *cpu_dev_max = NULL;
> +	s32 val, cpu_lat = 0;
> +	int i, ret;
> +
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> +		for_each_possible_cpu(i) {
> +			cpu_dev = get_cpu_device(i);
> +			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);

This change is now in -next as commit 458d22d2e064 ("firmware: ti_sci:
add CPU latency constraint management"), where it breaks the build
when this driver is built as a module because dev_pm_qos_read_value() is
not exported to modules:

  ERROR: modpost: "dev_pm_qos_read_value" [drivers/firmware/ti_sci.ko] undefined!

Obviously exporting it would fix the build but sometimes that is
controversial, hence just the report.

> +			if (val != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +				cpu_lat = max(cpu_lat, val);
> +				cpu_dev_max = cpu_dev;
> +			}
> +		}
> +		if (cpu_dev_max) {
> +			dev_dbg(cpu_dev_max, "%s: sending max CPU latency=%u\n", __func__, cpu_lat);
> +			ret = ti_sci_cmd_set_latency_constraint(&info->handle,
> +								cpu_lat, TISCI_MSG_CONSTRAINT_SET);
> +			if (ret)
> +				return ret;
> +		}
> +	}
>  
>  	ret = ti_sci_prepare_system_suspend(info);
>  	if (ret)
> -- 
> 2.45.2
> 

