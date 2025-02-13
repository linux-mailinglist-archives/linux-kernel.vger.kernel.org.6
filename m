Return-Path: <linux-kernel+bounces-512800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD094A33DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2361885E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0522154D;
	Thu, 13 Feb 2025 11:23:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3721D3C0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445796; cv=none; b=gdrcWrY6bRH1SOLJnr2cxHdN7z9opS5dNQqbN2B3XLlGVIK6Ge0Uga4P/5ldc7Sz0RqtBBM4IQVEvHcVQDSPWZEgmMVOd9eiZSFv+z5X96EP33c5D7G0cn+jhCxAi/fDUTgOLsJl4J6zFRQXCcqrq+e2HvaSoBdjq3fujQ15dlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445796; c=relaxed/simple;
	bh=cddqufEgLLKLyo1oLhiFxeLfp5GsjGgyraqTl5Aq+yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcj2oM+E1pBURn1y7Zmm+M7M+V1ZzMgtGrELIkzhBJubG7OnpqHwwifS/8dtrBeWxBYXANmjiTBWYBjgMUM5FISdf6cXtu7Y/Tyg/H1VFtj8fxCf5kEhzD0sg20PUMn2EzJ4o90QeDPohhqjPAC1DJJ9SbHvU+y6iRZr/l09j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4A621756;
	Thu, 13 Feb 2025 03:23:34 -0800 (PST)
Received: from [10.1.32.44] (e122027.cambridge.arm.com [10.1.32.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D143F6A8;
	Thu, 13 Feb 2025 03:23:12 -0800 (PST)
Message-ID: <5504fadd-6174-41c4-90a8-d3ae7f76d7f6@arm.com>
Date: Thu, 13 Feb 2025 11:23:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm: Make GENERIC_PTDUMP dependent on MMU
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: christophe.leroy@csgroup.eu, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250213040934.3245750-1-anshuman.khandual@arm.com>
 <20250213040934.3245750-4-anshuman.khandual@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250213040934.3245750-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 04:09, Anshuman Khandual wrote:
> There is no page table dump without a MMU. Make this dependency at generic
> level and drop the same from riscv platform instead.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

As Christophe has pointed out - this is broken. The select will override
the dependency you've added in GENERIC_PTDUMP. Generally have "depends
on" for symbols that are "select"ed is broken. I'd suggest just dropping
this patch.

Steve

> ---
>  arch/riscv/Kconfig | 2 +-
>  mm/Kconfig.debug   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7612c52e9b1e..c4cdba6460b8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -112,7 +112,7 @@ config RISCV
>  	select GENERIC_IRQ_SHOW_LEVEL
>  	select GENERIC_LIB_DEVMEM_IS_ALLOWED
>  	select GENERIC_PCI_IOMAP
> -	select GENERIC_PTDUMP if MMU
> +	select GENERIC_PTDUMP
>  	select GENERIC_SCHED_CLOCK
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index a51a1149909a..c08406760d29 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -214,6 +214,7 @@ config DEBUG_WX
>  	  If in doubt, say "Y".
>  
>  config GENERIC_PTDUMP
> +	depends on MMU
>  	bool
>  
>  config PTDUMP_CORE


