Return-Path: <linux-kernel+bounces-431486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7089E3EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FBFB26D01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54840204F7A;
	Wed,  4 Dec 2024 15:17:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD41B0F34
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325421; cv=none; b=U13GkJIWwE2Rj3dif0/PCe5kBGzpGQaxB4nwbFsFTF9/63flUcmfx44oj9Vl2O7J/Vlk92hBaq4nH2F+tuNqCEQWXKlN2EtLvRrVRNyO21w1InzruperuPfeq34c5InT0vu2+d5IH03SNqqr77dqEr63A9U7gsPSvq7/wslfwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325421; c=relaxed/simple;
	bh=snS7sYQoySg+075/kCzr8GpOyL7IkvNcwzYTnmHfZPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aci45NWb8BQM0TqCei7kyy3lW+kH5uVUhewRwFdTsVW22v8Pw/0eVAvLyqTxVfbXhK0ppk6cXLdn63jQoBriU5EmZ9M0+BOv64HuFoAzisKVSTfRuWSzHnf9/0b77JdUaXxXWxh0pgtw8vtUcU/PGRBfP1NUF5Qq6EvZ3n1nCCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC8961063;
	Wed,  4 Dec 2024 07:17:24 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582A83F5A1;
	Wed,  4 Dec 2024 07:16:56 -0800 (PST)
Date: Wed, 4 Dec 2024 15:16:50 +0000
From: Leo Yan <leo.yan@arm.com>
To: yuanfang zhang <quic_yuanfang@quicinc.com>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org, james.clark@linaro.org,
	alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight-etm4x: add isb() before reading the TRCSTATR
Message-ID: <20241204151650.GA1976757@e132581.arm.com>
References: <20241204112332.3706137-1-quic_yuanfang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204112332.3706137-1-quic_yuanfang@quicinc.com>

Hi Yuanfang,

Recently I just acrossed this part, so some comments.

On Wed, Dec 04, 2024 at 07:23:32PM +0800, yuanfang zhang wrote:
> 
> From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> 
> As recommended by section 4.3.7 ("Synchronization when using system
> instructions to progrom the trace unit") of ARM IHI 0064H.b, the
> self-hosted trace analyzer must perform a Context synchronization
> event between writing to the TRCPRGCTLR and reading the TRCSTATR.
> 
> Fixes: ebddaad09e10 ("coresight: etm4x: Add missing single-shot control API to sysfs")
> Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
> ---
> Change in V2:
> Added comments in the code.
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 66d44a404ad0..decb3a87e27e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -906,6 +906,13 @@ static void etm4_disable_hw(void *info)
>         tsb_csync();
>         etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
> 
> +       /*
> +        * As recommended by section 4.3.7 ("Synchronization when using system
> +        * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
> +        * self-hosted trace analyzer must perform a Context synchronization
> +        * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
> +        */
> +       isb();

As described in the doc, the "isb" is only required for system
instructions case.  It is good to only apply the ISB on system
register case:

        if (!csa->io_mem)
                isb();

>         /* wait for TRCSTATR.PMSTABLE to go to '1' */
>         if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>                 dev_err(etm_dev,

As mentioned in system register case: "Arm recommends that the
self-hosted trace analyzer always executes an ISB instruction after
programming the trace unit registers, to ensure that all updates are
committed to the trace unit before normal code execution resumes."

And for MMIO case:

"When the memory is marked as Device-nGnRE or stronger.
 ...
 - Poll TRCSTATR to ensure the previous write has completed.
 — Execute an ISB operation."

Thus we need to add an ISB after polling.

        isb();

For consistent behaviour, a relevant thing is the dsb(sy) in
etm4_enable_hw().  I do not think the dsb(sy) is necessary, as the
driver uses the sequence "write TRCPRGCTLR + polling TRCSTATR" to
ensure the data has been populated to trace unit, the polling
operations somehow act as a read back.  And the ETM manual does not
mention the requirement for DSB when enabling trace unit.  Thus, we
should remove dsb(sy) (maybe use a separte patch).

Mike / Suzuki / James, please confirm if my conclusions are valid.

Thanks,
Leo

