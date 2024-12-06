Return-Path: <linux-kernel+bounces-434415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779949E6672
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068321885F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6351DAC81;
	Fri,  6 Dec 2024 04:40:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F091D7992;
	Fri,  6 Dec 2024 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460057; cv=none; b=kDECf5yT5DCzGTCjLCZbs9Lq+dTdOYC74znWEVnmjW52SeYEsOuBTZKmjMCwKHFWUE+SAv6aSmi57uS4UA0+L/kb4EtBjNjPA4oVbO/TvyASnoj+t3COOhXrNx9S+a7RJu5HBZPSzFkvQEaYhRM889QSpTnW1huXmGAmrgDJomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460057; c=relaxed/simple;
	bh=l6yU7EFV2DWH8QMiN44xfukKeyx8cYOUr0adyde+ZsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JercXY505oWSLIPHFMVDOz11KNuq8CozUXSEjIJyrqbZkzXEmhezi5JcKTBUGWg959PeU1IRwND87+9rmTU90C81sCTAEGCk9ouJcsGidi1cpF+3b+aGBeKcQmcON4F+rq4rxj6GfxFq1wvrDIcK2RoVg9tt54spEkb93Hh8GTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03BDC169E;
	Thu,  5 Dec 2024 20:41:19 -0800 (PST)
Received: from [10.163.50.12] (unknown [10.163.50.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99B7B3F58B;
	Thu,  5 Dec 2024 20:40:45 -0800 (PST)
Message-ID: <c1f2ba9e-6f2d-4c7e-9956-6d3b183d3e05@arm.com>
Date: Fri, 6 Dec 2024 10:10:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, ardb@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 cl@os.amperecomputing.com
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
 <20241126085647.4993-3-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241126085647.4993-3-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 14:26, Huang Shijie wrote:
> The default kernel is rodata=on which means

Right but this is true only after the update in the series.

        if (!strcmp(arg, "on")) {
                rodata_enabled = rodata_full = true;
                return true;
        }

rodata_full is always "true" via 'rodata=on' and does not depend
on the config RODATA_FULL_DEFAULT_ENABLED anymore, so it can be
dropped. Please update this commit message with these context as
well.

> CONFIG_RODATA_FULL_DEFAULT_ENABLED is always enabled by default.
> So we can remove CONFIG_RODATA_FULL_DEFAULT_ENABLED now.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig       | 14 --------------
>  arch/arm64/mm/pageattr.c |  2 +-
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4316b1fe8bf8..a9ca305a31d8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1653,20 +1653,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
>  	  When taking an exception from user-space, a sequence of branches
>  	  or a firmware call overwrites the branch history.
>  
> -config RODATA_FULL_DEFAULT_ENABLED
> -	bool "Apply r/o permissions of VM areas also to their linear aliases"
> -	default y
> -	help
> -	  Apply read-only attributes of VM areas to the linear alias of
> -	  the backing pages as well. This prevents code or read-only data
> -	  from being modified (inadvertently or intentionally) via another
> -	  mapping of the same memory page. This additional enhancement can
> -	  be turned off at runtime by passing rodata=[off|on] (and turned on
> -	  with rodata=full if this option is set to 'n')
> -
> -	  This requires the linear region to be mapped down to pages,
> -	  which may adversely affect performance in some cases.
> -
>  config ARM64_SW_TTBR0_PAN
>  	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
>  	depends on !KCSAN
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 39fd1f7ff02a..6eef08d8451e 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -20,7 +20,7 @@ struct page_change_data {
>  	pgprot_t clear_mask;
>  };
>  
> -bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
> +bool rodata_full __ro_after_init = true;
>  
>  bool can_set_direct_map(void)
>  {

This patch can still follow the first one but after folding in the
third patch.

