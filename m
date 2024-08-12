Return-Path: <linux-kernel+bounces-282746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D8E94E817
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1494F1C216C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA15C143;
	Mon, 12 Aug 2024 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inqu+CfZ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB413E40F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449126; cv=none; b=MHT8lhvQQtKwB4AvG43fvvtuJpq4FgQgFj8/PLMoF45rMS/jfrpvsppRirCVEa506/KamILCu5g3OtljUXj360xu8R6ZtSJmWZwSPOmHk91AejzuI0kNHXtHkn1qjXeYn63cvd8BCW6iD3GlTPyqy996QMoRndRwbNI3fGKjWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449126; c=relaxed/simple;
	bh=yvpMoTRUe6dat3iXqCgvQr7amgD6HGaXbYKHELE9Vo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcYApI3U320DmLnbe9MVURuu3pY4ctrk8Xfe7ibn3HIfS72LE9LQRWBCVFjb8mrIdhXc1d9PU9WSwDXDOKAJ4EttjvFXzckXu4vcLFgncDX6ncB0ouCSOz6DcimbPc1kvCjBi7/hzklspSw8mNFLdp+56yhGSQ41EYnyFRGqOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inqu+CfZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so2873532a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723449124; x=1724053924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1z3ARtVF1s4UZ4JEYCZ6xJziJ0obK5gkoF7QAQAYKO4=;
        b=Inqu+CfZoo+8wds9ImSLHf3dOxMfqixAvDkyKG2Kuw2NnYrlUuzwOcwvb6I6YZEeGl
         NEJKha2I1ocN9FhgSWCk4PA2U2vkPZxrLw8qaGnNNvWW02fDrcwFgUn845d45JUa7u4U
         4FOql3NYcgBNfiwEwOlSLTkd38WETgKGyPCR3JuqwkhH6JTta8uf2kPmH38I6Ikvp/na
         o3WJgCDY/8sPDpmy11n1isGFlYp3V6IMezGj+jQ23n1hodcWae+WmB13bigfWXQ0jdPm
         QV3VSkKYEed1pu+iKbFxVBrrEf+FeoGC58prM7YBn+Nv1wf6qYMtCEGAv6+DqpFpwViL
         h8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723449124; x=1724053924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1z3ARtVF1s4UZ4JEYCZ6xJziJ0obK5gkoF7QAQAYKO4=;
        b=QixmTxZkoHPGYa6gXuLCe4S3LrDfZ8B4hkX00Vw5MNjCMxHWR4oHtZqKyoijWDvK8I
         y39uj3uTgLJKxmsvhoZTh3YC3k0dHW+HBdpCp7mvzdfGcKVbEeqeXr+8pC8A8CgJb8o5
         Mgi8vHvl3Y9WSoARZdCem520VEj+lgGRERYPWyfDdNpScfhFRiWIKGHxBlA69UAcNMTl
         Kz29GDFxfaZTs8SLL0W+izV2ACe7lCV5yDG7fhF5k1urGqARypymfAhACKnUlBMSMTIa
         1TIGMgHF4l5HPrt6CzZ9Cm08lEzBFwxs+235AMTbsnCz4HFJVl4gx+vRQ2/gpaI3X4MY
         H19Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcIU5Zq/NPgRwAtLL+sunIs2XJoeK85p4vj1don30spdbZH/gA8tlPxcl5McIOPbGE/0Rzww6RG5lh9dfmxKU4ucftqjsdyGBYf+kW
X-Gm-Message-State: AOJu0YzNKRLs44RzRkKWyiFETXUwJP04YhH+HTNj940zDBNabyiRKIGB
	5hyaTq7VaEalFeWpIW359GSJHzAh0Lw0LXJ/tE4vdEpCmDJg+lXd
X-Google-Smtp-Source: AGHT+IFuelHarYbffc12CY6NeWA8NXio7SB6aNddRYPabfcsug7V494DrC8qOoHcxRuTQyT6eo9j1Q==
X-Received: by 2002:a17:902:e749:b0:1fd:6581:93c5 with SMTP id d9443c01a7336-20096ba9cafmr199479375ad.27.1723449123890;
        Mon, 12 Aug 2024 00:52:03 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c68b770c98sm608669a12.37.2024.08.12.00.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 00:52:03 -0700 (PDT)
Message-ID: <54f87fcb-74da-4b48-a12e-4c7d9fa2870e@gmail.com>
Date: Mon, 12 Aug 2024 13:21:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-GB
To: Yuntao Liu <liuyuntao12@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, arnd@arndb.de, afd@ti.com,
 rmk+kernel@armlinux.org.uk, linus.walleij@linaro.org,
 akpm@linux-foundation.org, eric.devolder@oracle.com, masahiroy@kernel.org
References: <20240808123556.681609-1-liuyuntao12@huawei.com>
From: Harith George <mail2hgg@gmail.com>
In-Reply-To: <20240808123556.681609-1-liuyuntao12@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08-08-2024 18:05, Yuntao Liu wrote:
> There is a build issue with LD segmentation fault, while
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled, as bellow.
> 
> scripts/link-vmlinux.sh: line 49:  3796 Segmentation fault
>   (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive
>   ${objs} ${wl}--no-whole-archive ${wl}--start-group
>   ${libs} ${wl}--end-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> 
> The error occurs in older versions of the GNU ld with version earlier
> than 2.36. It makes most sense to have a minimum LD version as
> a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION and eliminate
> the impact of ".reloc  .text, R_ARM_NONE, ." when
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
> 
> Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
> Reported-by: Harith George <mail2hgg@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Link: https://lore.kernel.org/all/14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com/
> ---
>   arch/arm/Kconfig             |  2 +-
>   arch/arm/kernel/entry-armv.S | 12 +++++++++---
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 54b2bb817a7f..173159e93c99 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -117,7 +117,7 @@ config ARM
>   	select HAVE_KERNEL_XZ
>   	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>   	select HAVE_KRETPROBES if HAVE_KPROBES
> -	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD)
>   	select HAVE_MOD_ARCH_SPECIFIC
>   	select HAVE_NMI
>   	select HAVE_OPTPROBES if !THUMB2_KERNEL
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index f01d23a220e6..cd443faf8645 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -29,6 +29,12 @@
>   #include "entry-header.S"
>   #include <asm/probes.h>
>   
> +#ifdef CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> +#define RELOC_TEXT_NONE (.reloc  .text, R_ARM_NONE, .)
> +#else
> +#define RELOC_TEXT_NONE
> +#endif
> +
>   /*
>    * Interrupt handling.
>    */
> @@ -1065,7 +1071,7 @@ vector_addrexcptn:
>   	.globl	vector_fiq
>   
>   	.section .vectors, "ax", %progbits
> -	.reloc  .text, R_ARM_NONE, .
> +	RELOC_TEXT_NONE
>   	W(b)	vector_rst
>   	W(b)	vector_und
>   ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_swi		)
> @@ -1079,7 +1085,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_swi		)
>   
>   #ifdef CONFIG_HARDEN_BRANCH_HISTORY
>   	.section .vectors.bhb.loop8, "ax", %progbits
> -	.reloc  .text, R_ARM_NONE, .
> +	RELOC_TEXT_NONE
>   	W(b)	vector_rst
>   	W(b)	vector_bhb_loop8_und
>   ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_loop8_swi	)
> @@ -1092,7 +1098,7 @@ THUMB(	.reloc	., R_ARM_THM_PC12, .L__vector_bhb_loop8_swi	)
>   	W(b)	vector_bhb_loop8_fiq
>   
>   	.section .vectors.bhb.bpiall, "ax", %progbits
> -	.reloc  .text, R_ARM_NONE, .
> +	RELOC_TEXT_NONE
>   	W(b)	vector_rst
>   	W(b)	vector_bhb_bpiall_und
>   ARM(	.reloc	., R_ARM_LDR_PC_G0, .L__vector_bhb_bpiall_swi	)
Build tested. Solves the earlier build issue I was seeing.
fwiw, you can add my tested by tag if needed.

Tested-by: Harith George <mail2hgg@gmail.com>

