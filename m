Return-Path: <linux-kernel+bounces-249213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997592E890
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B36B1C21F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487BC15D5A4;
	Thu, 11 Jul 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hYfq4Al9"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6F1E892
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702428; cv=none; b=p+YYzfQZ+kOaVqSlGWvMR31ansQCK7agymKRteBGR91cachFI2Eqn/l+9lnFEvZiUjs8f9B5eWAev41YQsj2AR7uJQBknmQjY4dvArsQjmUrKP7GzrQ5qkw65B/5wQalFN+kMdUjJLDOQGwz0dRi/vD0Ybh150IXDp97CeB8fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702428; c=relaxed/simple;
	bh=lD6TbuiZ6k70yL928P+MNROtXO3M/N4zfZwxfNzyfE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjecGWLYr8qfVQiEubzPPKfOmLPyz1/T/oBz+9qxvY/UEwx8tN2bUng9EE86XbIITmKbolp/o23DaWM1v1VxiQPoHfsCnsJUgTnMbbvxIAXwjXdgzAqVE8oTBqFckMj4lRmvtLaRXADWdUw8wgVkg+xzTp9kUoM4o2qi60+WZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hYfq4Al9; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4F7721E53BD;
	Thu, 11 Jul 2024 14:53:35 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1720702415; bh=P0PSLu8WPQEzhXJpUAj3fWhxFWbRpRvdGMV58iTV82k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hYfq4Al9Dd1KJwLPJILIFL4GAOgwsTSArV1x1DIi6erZKeMa1BzwA/0b9zga2qO6Q
	 wsaCGmoLVAuYR97Uslvcm02osX2iJx7//agx0lqsV69Y9rW2SpMqUGG92+SNbg1/bj
	 H0wV3naa1QnEDWKuasT6RCmYqZiwtYfU+Y12kcBTfTaPEAjV5tb9AoEeNrcZsDZTb5
	 55FKB7QKZTMn8nPxCDJbVxW/+NiZkMkpKzmI8fL+o96k1ni926vheIVV94rhYeyGcx
	 YRKWWDQc7DTRUN/kxxYPDu9E59NIMBoDkH8MPcpo70QS9LGFIkVhq3mSePcDZiCS3F
	 Q/It4+1AzykFg==
Date: Thu, 11 Jul 2024 14:53:30 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: sunying@isrc.iscas.ac.cn
Cc: ebiederm@xmission.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, kexec@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhuhengbo@iscas.ac.cn
Subject: Re: [PATCH v1] riscv/kexec_file: Fix relocation type R_RISCV_ADD16
 and R_RISCV_SUB16 unknown
Message-ID: <20240711145330.6625c200@mordecai.tesarici.cz>
In-Reply-To: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>
References: <20240711083236.2859632-1-sunying@isrc.iscas.ac.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 08:32:36 +0000
sunying@isrc.iscas.ac.cn wrote:

> From: Ying Sun <sunying@isrc.iscas.ac.cn>
> 
> Runs on the kernel with CONFIG_RISCV_ALTERNATIVE enabled:
>   kexec -sl vmlinux
> 
> Error:
>   kexec_image: Unknown rela relocation: 34
>   kexec_image: Error loading purgatory ret=-8
> and
>   kexec_image: Unknown rela relocation: 38
>   kexec_image: Error loading purgatory ret=-8
> 
> The purgatory code uses the 16-bit addition and subtraction relocation
> type, but not handled, resulting in kexec_file_load failure.
> So add handle to arch_kexec_apply_relocations_add().
> 
> Tested on RISC-V64 Qemu-virt, issue fixed.
> 
> Co-developed-by: Petr Tesarik <petr@tesarici.cz>
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

Let me confirm I have seen this, and it is correct.

Petr T

> Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
> ---
>  arch/riscv/kernel/elf_kexec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 11c0d2e0becf..3c37661801f9 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -451,6 +451,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  			*(u32 *)loc = CLEAN_IMM(CJTYPE, *(u32 *)loc) |
>  				 ENCODE_CJTYPE_IMM(val - addr);
>  			break;
> +		case R_RISCV_ADD16:
> +			*(u16 *)loc += val;
> +			break;
> +		case R_RISCV_SUB16:
> +			*(u16 *)loc -= val;
> +			break;
>  		case R_RISCV_ADD32:
>  			*(u32 *)loc += val;
>  			break;


