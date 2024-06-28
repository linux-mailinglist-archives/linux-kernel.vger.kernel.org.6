Return-Path: <linux-kernel+bounces-234250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C191C43D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014F61F22A43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54931CB307;
	Fri, 28 Jun 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKkydn+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4761E532
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593778; cv=none; b=faDlAOdr7awrf6bcqW+Ab/Jix06tbImbWoHrE9b3DbuC2jmQnpJplvEVmOMhSzLmEL1k9tIQ1sBvhZCyaGamHFGUfyWWBN7oN3kCKsaDI+EZvyE97IE7tVpuDSZHyF3CIn5fcB7Fvdmhg1B/FqfpgnVwjr+Ky1p3ZLgH2Wf9JEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593778; c=relaxed/simple;
	bh=0WV68lG8z7U0M2IBd6OXGcfby1CuBv/cFPR+bpj/7QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0ZTCl18z6DUevpuGywuXJO+KENHA6m1sTu6sCkx1ltYwoCzqJlTKCDtVgGGZeXyZ+QshP8CeNLckdwCAJ9F+1CyaHWz5iBUVBqCf/bBXSGZJvH/nVfui5WKKeP5m+aRdJA/DB2zsyB7/PqlO84MlazpSOYNVDeECqYQH20Thcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKkydn+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EACCC116B1;
	Fri, 28 Jun 2024 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719593777;
	bh=0WV68lG8z7U0M2IBd6OXGcfby1CuBv/cFPR+bpj/7QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKkydn+Kh6UHpj+9TdsVPt8bjIqibpvkuHRGmpdpUC3TMoIejF2dCI3eu7t+bDsAo
	 3V2XPmV/gYG2cbWFCq46YYgjgUJOJAZYdlIz1qwrbP2+7retMNn513eckLzLN7DC6O
	 Csu33RPmRO/sE6JpUFc42gpYBYG3veqi4wRB1bMJy9bAQFh3uUFwepUklyjR1N5pVo
	 TkwKsZMCv2mN7dlgeZ+9xkysQBpFg30vRjovyBhLqAjMtkMFR58Gt1r754IIkI26Nb
	 7qIaRscs2df1nsKRMWqMWCn6n4HKUjCRb/PWe/VjjREXMmpM2AK8KsqgFUmstD+5zk
	 4GlS3CQueOoCw==
Date: Fri, 28 Jun 2024 09:56:17 -0700
From: Kees Cook <kees@kernel.org>
To: liujinlong <mingliu6104@gmail.com>
Cc: thunder.leizhen@huawei.com, yonghong.song@linux.dev,
	ndesaulniers@google.com, song@kernel.org, ardb@kernel.org,
	maninder1.s@samsung.com, azeemshaikh38@gmail.com,
	linux-kernel@vger.kernel.org, liujinlong <liujinlong@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>,
	Mirsad Todorovac <mtodorovac69@gmail.com>
Subject: Re: [PATCH] sprint_symbol: Replace strcpy with memmove to handle
 potential overlap
Message-ID: <202406280952.28AFD754@keescook>
References: <20240604044228.2910712-1-liujinlong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604044228.2910712-1-liujinlong@kylinos.cn>

On Tue, Jun 04, 2024 at 12:42:28PM +0800, liujinlong wrote:
> In the function __sprint_symbol, replace strcpy with memmove to ensure
> correct behavior even if the source and destination buffers overlap.
> This change prevents potential undefined behavior flagged by recent
> compilers as [-Werror=restrict].
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liujinlong <liujinlong@kylinos.cn>
> ---
>  kernel/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 22ea19a36e6e..3c3a77fcd020 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -489,7 +489,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  		return sprintf(buffer, "0x%lx", address - symbol_offset);
>  
>  	if (name != buffer)
> -		strcpy(buffer, name);
> +		memmove(buffer, name, strlen(name) + 1);
>  	len = strlen(buffer);
>  	offset -= symbol_offset;

The warning is[1]:

>   CC      kernel/kallsyms.o
> In file included from ./include/linux/string.h:374,
>                  from ./arch/x86/include/asm/page_32.h:18,
>                  from ./arch/x86/include/asm/page.h:14,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./include/linux/spinlock.h:60,
>                  from ./include/linux/mmzone.h:8,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/mm.h:7,
>                  from ./include/linux/kallsyms.h:13,
>                  from kernel/kallsyms.c:15:
> kernel/kallsyms.c: In function ‘__sprint_symbol’:
> ./include/linux/fortify-string.h:122:33: error: ‘__builtin_strcpy’ source argument is the same as destination [-Werror=restrict]
>   122 | #define __underlying_strcpy     __builtin_strcpy
>       |                                 ^
> ./include/linux/fortify-string.h:787:24: note: in expansion of macro ‘__underlying_strcpy’
>   787 |                 return __underlying_strcpy(p, q);
>       |                        ^~~~~~~~~~~~~~~~~~~

But the code is already checking "name != buffer". Does anyone know
what is actually happening here where we have an _overlap_, but not
identical strings?

-Kees

[1] https://lore.kernel.org/lkml/202406271127.CEAE5F4E@keescook/

-- 
Kees Cook

