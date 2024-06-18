Return-Path: <linux-kernel+bounces-219668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0A90D6C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F7DB2EE65
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2938DC3;
	Tue, 18 Jun 2024 14:52:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351E2139DA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722320; cv=none; b=fCKpcnAqSYWF/I6k6xhMSidKYQUtdHNTXVZvX7DhmfiQBvfivTsRp8v326kI2DWTo/DeQJIIWSN5d3x4HmrnDUdWhSKrkrLTVtg7DDR2rdOo2ENXQqU2EabaPPGLscJghYJT/X8FuKOj1gOEvNHLjAvtRnNkt0GS7i22hAWwugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722320; c=relaxed/simple;
	bh=JdxU76DpI5KkDSMb89wA0sDnG1t8b3veRymky71DvfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyLX4/lvF6gh9rhLaC2Kk114KkiYyLmJ+sFnWWd7naOOWiPOpI01F64qVc8CSdOPUmxIPwcgm5igmwgdffjWkY2RP84H2WCZgNSF6GBaidnPs61wvWvAuBAWZSX4GuXg0T1BHG/KixhM5a2L7XS9hncT8u7SQ4XYwRxdwl851AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C78DDA7;
	Tue, 18 Jun 2024 07:52:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89EB03F6A8;
	Tue, 18 Jun 2024 07:51:54 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:51:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Ensure that offlined CPUs are not using SME
Message-ID: <ZnGfA-kGqCjbDu90@J2N7QTR9R3>
References: <20240618-arm64-fpsimd-sme-cpu-die-v1-1-9a90d1a34918@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-arm64-fpsimd-sme-cpu-die-v1-1-9a90d1a34918@kernel.org>

On Tue, Jun 18, 2024 at 03:03:50PM +0100, Mark Brown wrote:
> When we use CPU hotplug to offline a CPU we may transition directly from
> running a task which was using SME to the CPU being offlined. This means
> that PSTATE.{SM,ZA} may still be set, indicating to the system that SME is
> still in use. This could create contention with other still running CPUs if
> the system uses shared SMCUs.

Does it actually cause contention if the CPU isn't issuing SME
instructions?

Is this theoretical or something you see in practice?

> For most systems this shouldn't be an issue, we should have PSCI or some
> other power management mechanism which will take care of this as part of
> offlining the CPU. However we do still have support for spin tables,

I don't think spin-table is relevant; there's no support whatsoever for
offlining CPUs with spin-table (and offlining will be rejected long
before cpu_die()).

> and it is possible that system firmware may not be ideally
> implemented, so let's explicitly disable SME during the process of
> offlining the CPU in order to ensure there's no spurious contention.

If this is an issue, surely it's the same with idle, or any other long
period spent in the kernel, or any long period where userspace leaves
the CPU in streaming mode?

It feels very odd that we should need to do something for cpu offlining
in particular.

Mark,

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/smp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 31c8b3094dd7..9e8fc6ac758a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -383,6 +383,10 @@ void __noreturn cpu_die(void)
>  	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
>  	cpuhp_ap_report_dead();
>  
> +	/* Ensure we are not spuriously contending any SMCU */
> +	if (system_supports_sme())
> +		sme_smstop();
> +
>  	/*
>  	 * Actually shutdown the CPU. This must never fail. The specific hotplug
>  	 * mechanism must perform all required cache maintenance to ensure that
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240617-arm64-fpsimd-sme-cpu-die-57205c7f220e
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
> 

