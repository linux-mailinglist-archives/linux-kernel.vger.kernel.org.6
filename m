Return-Path: <linux-kernel+bounces-274885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21469947DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04601F259D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32599165EFD;
	Mon,  5 Aug 2024 15:21:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE115C12C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871299; cv=none; b=XeZAGY9gvksVIsecNuqU4mNDzbgMNbMjTsUwEPJ2DTYOPlSdw/xx8dmVnSpaP+xVoF5gLMM/dcu4hc9bOgNZpjac5tMdpRzjM71lCuwNvn0Ak/ToRhC0qBuPuEV1Ji+bJaxrHdK9H9YYV4FSp+9iIuZNMfuYjwP6SlbqDUUu9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871299; c=relaxed/simple;
	bh=A/vqyXp/hKQN+7A1d03rM+V+SeUwjGDuw/srEI979pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ypZoLB7hzXcrS1ynrSwLOpJA36+MRcNPGGPYseXzFuw0951MJ/JtPFQQRi7IGMXAhGyes7MrjgmdVp7+Y06NkM9y6042NmDS6bkgruOUlF6gyfH+swe5nBNAH1y3/Ay5BYtR2qmkahBKNoAYMjM3RSM54B128xlYu5e/mmWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C30C4AF0B;
	Mon,  5 Aug 2024 15:21:36 +0000 (UTC)
Date: Mon, 5 Aug 2024 16:21:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: ajones@ventanamicro.com, sunilvl@ventanamicro.com, xiaobo55x@gmail.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: ACPI: NUMA: initialize all values of
 acpi_early_node_map to NUMA_NO_NODE
Message-ID: <ZrDt_isszRHkFuLu@arm.com>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
 <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>

On Mon, Aug 05, 2024 at 11:30:24AM +0800, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Fixes: e18962491696 ("arm64: numa: rework ACPI NUMA initialization")
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/arm64/kernel/acpi_numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 0c036a9a3c33..2465f291c7e1 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -27,7 +27,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

The patch makes sense but is there any issue currently without it?
Trying to assess whether it needs a stable backport.

-- 
Catalin

