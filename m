Return-Path: <linux-kernel+bounces-297048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805895B241
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F0FB27376
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318117E01A;
	Thu, 22 Aug 2024 09:44:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006287E0E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319877; cv=none; b=hxYoTo+Yk7tadQU/P0Rr7QFJ4f+SHaqo2Orf4iDkPAmhCSVMun5FAJ1d/cSb7j6YQZ9mFCgQ165EHAAb39MnrKlOWDMTi0vjIbwpVnUo64RhoQEkDEIn8pkUdpGKyfzBYakIATaP2oXQY41I8tqKOs2jf17iZeii0B8n+lMJO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319877; c=relaxed/simple;
	bh=3D9ZHo3QHJML/vRJOv2DtkZx4zGnczNKlAKsNOs1S3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Gb9WYj7GXeb+7k8rzp63eoY/68VkTKwHscl7ua66lOZjDOJZEII4VJrVskqANlAKPFgH+qVv7pdLoYss/PWwtqiAo7WtCjXaOGn6PMGGkbWUNl/QFoTuIMP0Sf+mykTxXYm0rAqXkVFh4p8KH5i34J+DkGk6JaeHAidPqKrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8014DA7;
	Thu, 22 Aug 2024 02:44:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F083F58B;
	Thu, 22 Aug 2024 02:44:32 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:44:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2] drivers/perf: Fix ali_drw_pmu driver interrupt status
 clearing
Message-ID: <ZscIersJMUIeWl6O@J2N7QTR9R3>
References: <2a70eaa3-f1c5-4803-948b-4b8eb86190c6@linux.alibaba.com>
 <1724297611-20686-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724297611-20686-1-git-send-email-renyu.zj@linux.alibaba.com>

Will, are you happy to pick this up?

Mark.

On Thu, Aug 22, 2024 at 11:33:31AM +0800, Jing Zhang wrote:
> The alibaba_uncore_pmu driver forgot to clear all interrupt status
> in the interrupt processing function. After the PMU counter overflow
> interrupt occurred, an interrupt storm occurred, causing the system
> to hang.
> 
> Therefore, clear the correct interrupt status in the interrupt handling
> function to fix it.
> 
> Fixes: cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 38a2947..c6ff1bc 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -400,7 +400,7 @@ static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
>  			}
>  
>  			/* clear common counter intr status */
> -			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, 1);
> +			clr_status = FIELD_PREP(ALI_DRW_PMCOM_CNT_OV_INTR_MASK, status);
>  			writel(clr_status,
>  			       drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
>  		}
> -- 
> 1.8.3.1
> 

