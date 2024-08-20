Return-Path: <linux-kernel+bounces-293613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904059581F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8552863EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EB18B472;
	Tue, 20 Aug 2024 09:18:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F0818A95B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145532; cv=none; b=j+HCtJ8SrpJ7Vo/ZXdmaA018qJAPa7zWbfqkK0UD4DyA0gFvoIEiDHzwL38HG3BWNBafnsw5PSY2rSuKByMrDPmEbNQ2m6gCSE3m3wQ6iiJ1sON8J7y8WtH4JCOg2xkVjSL7iiEibniFPiZpt5sk0QAJg+zUKxz8yBkBmfwED30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145532; c=relaxed/simple;
	bh=1s6gGceHy5Uo5gfMeCeEseFPANcEsao7kINLgdBuJE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9M3vMSODh6ub7kUEmbPP8xIAkA07CYoF/vftEw1ZvYbRTSA3itN6hNwf5GjQwVARW4iaFWULj9A2oPqEt1emU1bisFvsUnFfps4O2CJyRgr/kH2BsZxciNrip0uGFc6tO6+M8lMesglp+rlADoMEAvd4qE6fYdyS4Wxhj27tL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025ABDA7;
	Tue, 20 Aug 2024 02:19:16 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037253F66E;
	Tue, 20 Aug 2024 02:18:48 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:18:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] drivers/perf: Fix ali_drw_pmu driver interrupt status
 clearing
Message-ID: <ZsRfdn58mPLRIfVk@J2N7QTR9R3>
References: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724068110-45239-1-git-send-email-renyu.zj@linux.alibaba.com>

On Mon, Aug 19, 2024 at 07:48:30PM +0800, Jing Zhang wrote:
> The alibaba_uncore_pmu driver forgot to clear all interrupt status
> in the interrupt processing function. After the PMU counter overflow
> interrupt occurred, an interrupt storm occurred, causing the system
> to hang.
> 
> Therefore, clear the correct interrupt status in the interrupt handling
> function to fix it.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Presumably this should have

Fixes: cf7b61073e4526ca ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")

... right?

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

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

