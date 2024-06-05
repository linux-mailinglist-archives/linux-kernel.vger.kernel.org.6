Return-Path: <linux-kernel+bounces-201666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F08FC183
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC61C22DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1134C62A;
	Wed,  5 Jun 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVrrSsqq"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEAF503
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553198; cv=none; b=pVAU4YRd/cfrj/CRzccdPH7ow+Cl5WL/ZDiar7n9y4Qik1eeUe+sJuWaJvN9S4zWdOkgO7XDlP7R0QQCf9XX01kwDVK5BsxjC91dCfC42Efx0UfHFb2f+kfG+SPiS43rUOiGeNHYtle5RQXroqLgfV1wMDn3DnbSTTNO5WX5OHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553198; c=relaxed/simple;
	bh=ReFUp7pweTh2zzhDpxSwTrxIMDTmjvQ8dRKlAIkhyPY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DfGtiFKQ74d7ZLn0nk/f5wEXqf72pU6YhsBYgKs9S6RIpu/sdU3hU2AfjiMsqLEvuFZ2bAYIUNjAXaQ2mkye2256ie0ditVtTKi3c0wBsSIkDcKJ+rQ/BgZ1WO/sLoiDiCTD5pWFKRzRu8hLE5tAe20hYi7bO2Ail71oxR6nrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVrrSsqq; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717553192; h=Message-ID:Subject:Date:From:To;
	bh=+hLssxSftTAbTK2MPi0VtFqUyURlszSjmWyA2r06aas=;
	b=oVrrSsqqdu8KbJx3rdGORmvX7f9YjcNZiOlZ1I7xsBw9jtaYvEDMfRqBRZ6Nuc4VbRJjoaK08T81yaq0NBHtn4X7KNtYK0w6+F4Y4YY86b5LvCYueq8ZoUZO0fW+llUpMO89N47dxrgEGVaVzpeuGWMPBqoHfCMi75Kv151x624=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W7sYmF-_1717553191;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7sYmF-_1717553191)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 10:06:32 +0800
Message-ID: <1717553058.033336-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
Date: Wed, 5 Jun 2024 10:04:18 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 Youling Tang <tangyouling@kylinos.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev,
 mengqinggang@loongson.cn,
 cailulu@loongson.cn,
 wanglei@loongson.cn,
 luweining@loongson.cn,
 Yujie Liu <yujie.liu@intel.com>,
 Tejun Heo <tj@kernel.org>,
 Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20240604150741.30252-1-xry111@xry111.site>
In-Reply-To: <20240604150741.30252-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Tue,  4 Jun 2024 23:07:41 +0800, Xi Ruoyao <xry111@xry111.site> wrote:
> GAS <= 2.41 does not support generating R_LARCH_{32,64}_PCREL for
> "label - ." and it generates R_LARCH_{ADD,SUB}{32,64} pairs instead.
> objtool cannot handle R_LARCH_{ADD,SUB}{32,64} pair in __jump_table
> (static key implementation) and etc. so it will produce some warnings.
> This is causing the kernel CI systems to complain everywhere.
> 
> For GAS we can check if -mthin-add-sub option is available to know if
> R_LARCH_{32,64}_PCREL are supported.
> 
> For Clang, we require Clang >= 18 and Clang >= 17 already supports
> R_LARCH_{32,64}_PCREL, so we can always assume Clang is fine for
> objtool.
> 
> Note that __jump_table is not generated by the compiler so
> -fno-jump-table is completely irrelevant for this issue.
> 

Hi Xi Ruoyao,

I want to know does this patch fix the following warning:
https://lore.kernel.org/all/202406040645.6z95FW1f-lkp@intel.com/ ?

Thanks.

> Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
> Closes: https://lore.kernel.org/loongarch/Zl5m1ZlVmGKitAof@yujie-X299/
> Closes: https://lore.kernel.org/loongarch/ZlY1gDDPi_mNrwJ1@slm.duckdns.org/
> Closes: https://lore.kernel.org/loongarch/1717478006.038663-1-hengqi@linux.alibaba.com/
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=816029e06768
> Link: https://github.com/llvm/llvm-project/commit/42cb3c6346fc
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Kconfig       | 5 ++++-
>  arch/loongarch/Kconfig.debug | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e38139c576ee..e461a6c59f15 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -143,7 +143,7 @@ config LOONGARCH
>  	select HAVE_LIVEPATCH
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_NMI
> -	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS
> +	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
> @@ -273,6 +273,9 @@ config AS_HAS_LBT_EXTENSION
>  config AS_HAS_LVZ_EXTENSION
>  	def_bool $(as-instr,hvcl 0)
>  
> +config AS_HAS_THIN_ADD_SUB
> +	def_bool $(cc-option,-Wa$(comma)-mthin-add-sub) || CC_IS_CLANG
> +
>  menu "Kernel type and options"
>  
>  source "kernel/Kconfig.hz"
> diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
> index 98d60630c3d4..8b2ce5b5d43e 100644
> --- a/arch/loongarch/Kconfig.debug
> +++ b/arch/loongarch/Kconfig.debug
> @@ -28,6 +28,7 @@ config UNWINDER_PROLOGUE
>  
>  config UNWINDER_ORC
>  	bool "ORC unwinder"
> +	depends on HAVE_OBJTOOL
>  	select OBJTOOL
>  	help
>  	  This option enables the ORC (Oops Rewind Capability) unwinder for
> -- 
> 2.45.2
> 

