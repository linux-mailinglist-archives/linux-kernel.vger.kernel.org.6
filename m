Return-Path: <linux-kernel+bounces-221117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF5C90EEE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749111F215C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F9147C6E;
	Wed, 19 Jun 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzhczgTI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B21E492
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803984; cv=none; b=OYzSegrS8Gyq77d42ayOQ3iPEHkmX1kIFLltBPaUYsdrnJ3zDgNbYxOP5o1pGjyZHcm0ugLUwAYFkPFXyRmNwSYjRwWyIoBK+TekeJ4r9s+gyAeOdedjFmBraBMJZzbvg/Up/8Gv/ZC4u9AEPr2PobsUvo84Qzjg2ewN3cQyDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803984; c=relaxed/simple;
	bh=cXx5NUHhqlxc6cafd7sTdps6tZxJqDAhS3XY1Phuj1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRQmmYZCaHCV/3rjRN5lQe1DKFJKyiHkkohM6Raoz0ptPbHR1YTNdpEMLVxZQ78w7y5cuv6717cdKKa73vIbu3i3Lto++4AQqvch1AMGolUKCH0JnCFbm/RPmWEDsEEGQ4IURbr4yfSth464dMpsacEbso/ciuUmo38FMTFkyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzhczgTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97689C32786;
	Wed, 19 Jun 2024 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718803984;
	bh=cXx5NUHhqlxc6cafd7sTdps6tZxJqDAhS3XY1Phuj1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzhczgTIRyBDNWGzGauAT3G2Oej6hlyTNTfHpbprV5+PvMZLyrueFIbhOSvAwJweg
	 6RrF4IbERvR3V4w4Fb39anT/pU1NfWMYahU/fBJcMQCNb7kj9126OIRnn/+htT3G5w
	 sCUUpoUrTQvLEmSJGtugOzPJk+AGAolkSYIampZrWKI2nDWX8TEJgv+ApvIER9gZtu
	 j0eX985u/AnuLSqxL/Nt4V+9+jueBT38OcqFZWg1YI8hbDzpvuQyrG+6X8pnWv2Mvx
	 LEaKidLVBAeg8KzoP2yZFl0+Gj/nQo/uIB37ZuSUVS0vCAvKbTw0BHp6zNkeP1/Th3
	 NLumK4yOWWnUg==
Date: Wed, 19 Jun 2024 14:32:59 +0100
From: Will Deacon <will@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, dianders@chromium.org,
	swboyd@chromium.org, sumit.garg@linaro.org, frederic@kernel.org,
	scott@os.amperecomputing.com, misono.tomohiro@fujitsu.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: Fix missing IPI statistics
Message-ID: <20240619133258.GA3526@willie-the-truck>
References: <20240607074716.4068975-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607074716.4068975-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jun 07, 2024 at 03:47:16PM +0800, Jinjie Ruan wrote:
> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
> is missing in display.
> 
> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using pseudo-NMI")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 31c8b3094dd7..7f9a5cf0f3b8 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -1039,7 +1039,8 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  		}
>  
>  		ipi_desc[i] = irq_to_desc(ipi_base + i);
> -		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> +		if (i < NR_IPI)
> +			irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>  	}

Please can you show the contents of /proc/interrupts before and after
this patch and put that in the commit message? I'm not seeing how the
two new IPIs get picked up by arch_show_interrupts().

Thanks,

Will

