Return-Path: <linux-kernel+bounces-439016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79F9EA988
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E022884A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C24E22D4D0;
	Tue, 10 Dec 2024 07:27:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A81FCCE6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815634; cv=none; b=mk2CLXDabssceRrezNIMUFlnxk/jgHsaRboeTRoi/M3d4FcPSl95rrQFQU4GKUgfeRVRCNFWJmBACbxCTl6wHJy8u1YcMANUTRVhd36p9hj/PoJaZZGQ9yTHKl/ShADumYw5GjR9TLi/xoXUkFwQ5R0oEn2D1yAOitXnlgbg9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815634; c=relaxed/simple;
	bh=cL1XLdx0ar7bGjJEheDDFTNMvNXlWQD5UGrEf/6Ikgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pn1Gs+I/h9w3MBv6H0umbI8lt7+gM9HFqhHe7/oUiOe4kyXxViWVFU9KRcukj8kIfBKGvavEzqDOSxYDrYoMyCvG9J7IeKgdfvWYFEYXlBWvUguZUqRq2i7bx78c3+mU5GZWJn5oH83MIXFtJgbxG9x2ty6v5VxEPuc4GS5mMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E857EFEC;
	Mon,  9 Dec 2024 23:27:38 -0800 (PST)
Received: from [10.163.48.173] (unknown [10.163.48.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04C83F720;
	Mon,  9 Dec 2024 23:27:06 -0800 (PST)
Message-ID: <767de5f8-a650-4acf-966e-528fd08b09bb@arm.com>
Date: Tue, 10 Dec 2024 12:57:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, corbet@lwn.net
Cc: patches@amperecomputing.com, cl@linux.com, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 ardb@kernel.org, inux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
 <20241209072020.4743-3-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241209072020.4743-3-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A small nit:

arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED

On 12/9/24 12:50, Huang Shijie wrote:
> After patch "arm64: refacotr the rodata=xxx",
> the "rodata=on" becomes the default.
> 
>      ......................................
> 	if (!strcmp(arg, "on")) {
> 		rodata_enabled = rodata_full = true;
> 		return true;
> 	}
>      ......................................
> 
> The rodata_full is always "true" via "rodata=on" and does not
> depend on the config RODATA_FULL_DEFAULT_ENABLED anymore,
> so it can be dropped.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/Kconfig       | 14 --------------
>  arch/arm64/mm/pageattr.c |  2 +-
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cbfd357f94a6..1c69982302ed 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1666,20 +1666,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
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

Otherwise LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

