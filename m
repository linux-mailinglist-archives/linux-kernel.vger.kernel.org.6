Return-Path: <linux-kernel+bounces-574675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25193A6E85A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5F816B2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611E150997;
	Tue, 25 Mar 2025 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eWSi9FQP"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD45228
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870144; cv=none; b=h9Alv4NWCKbE4sR5pTf9rDd/cH1NiEfaceN0OXcLoFpJPx2y/3dpwNgq4fN13VFP6laGgcNcXgF64soJlKALBv1ZJ2ackKcIslHp7PtLKncF9PlXxnndIZzVbb/bIOZaAc//UFZbyiGPfWG6ZP9je8/tkbXmjOT0dF/+KDDaNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870144; c=relaxed/simple;
	bh=/pEL1Gzm/0En/2R+zvdxNYWy0J0fwc5+YesXUqqiIks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J62fuMokjrqogded38fDaMVLi76B6ubaLgK/8VJz8s11Kxzxgl78eCAo26YTlrBSONXuxoP6mioBET60pKuttmRst2V/vxY8iBA/MkT+fYpf+dnbyyBvPePCoOTw3zZci46t3pUEnuEly5ktgOo+WAo/mfKtOSp682ylmiGOKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eWSi9FQP; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3ce87d31480so27295895ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742870141; x=1743474941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GP1g4WGEQjeKx9pF4VwRKEHZWt/9BpkRBedLjRMdTF8=;
        b=eWSi9FQPOZjAjHg9iLpnogIgkBfEzJYa4aD0gLnYSjREHYVlHPVrBbSCU19T977icv
         0cjrgbvYTBTJs7QVDqaMUTn1pigfvWDfOrxRf1pseLSBcszyqjuANxg9GgC6NIUozgVb
         L8zdJZY14H8Vs/bywzycIdwHU46FjoQ6d93XO4HAc4LFouSS/hoYpbdo01moh8SJ/xw2
         5Rj39g7W+uM6Z8ExIm8TlpGk34jMfJk1R+9tf6YyC2dJKSnoT71/EvC3JJCFCUj6jrLR
         5ipPInpQ9NJ9S/lU0bs0OIDA8lKC7/1UTaerips7dGKqMVdR7cMW9dPQJyekiOQ8uL+C
         3zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742870141; x=1743474941;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GP1g4WGEQjeKx9pF4VwRKEHZWt/9BpkRBedLjRMdTF8=;
        b=ifApoM81Ynq/2DJcnCm1OCifeiW8Iga9llq6GWvb/+Cb9Tvv56+mPqupaELWcrNQp0
         N7nxs1T4qcYoZU5dcMIW7nHuatrg3FAOCVdC2nMHVgCXOySs5GKmRX3h+s9qyrRgSWz5
         5uKa2+z5RpNuKW0X83z0OnvnL1ZO1GTefmY4ddfWRXD/aoWCKhqP3IajKw8KsoUsCKLw
         yw5eSOj2mo8zgJcU/9WVc/Apyj+u06MReFLC08HRfAAy0ruVdNMWi6WAno3jLBGbgeNq
         +YHFg/XL3XuS+3p/KmymDAerGjSNZO63Ha2VxsF6134R4UkbsbbOkxpm8+nIB/Yrz6sm
         RiSg==
X-Forwarded-Encrypted: i=1; AJvYcCWdY39niuVwjA9/fzKDApdxUOgu+V/uzewbjF8wOkBhPP7FboAU8Jku+6pqkx46aTliXIVGY9JAcNfEN9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8lNUMbmMNlFyRxz+BMz3XS24IeWFAOvBjp6mhZArvWb+Xjk9
	2huZ8vn7Vg40rlA51N3/0jY+ZjXGFzBCZ2Dm2I6YyX2Dm2bKvMP7VEdUsi2SJ1Y=
X-Gm-Gg: ASbGncuxvHE9XyUIMzvh4bq7ZHK/QJK5yR3puito228xYTt5wVOg6ZWZiyQCH/+AJyd
	1/0UD0kQWSwsU1FAwUZwr0huLllmkCxn2eHPVhbjPuTd/nK86MhDMEYyvEXE/WyNU9CGA4MEC5S
	kDgYgQONRPUnRsjkgQuuvtEC4B6UV9irPlSnGN4f1iUG0ebp+sSWT5GKMrqwByhmwU6HQoZffT0
	rVHJYneORG9l4K6w/nCdk+kvfm7Qilkqa4aG1n2rVH7dnb46aJ5LB22LH6x3y97Ae78DulaY5ke
	JMddtbc2VbPkfAPB+Gm/pkuKMnMfujwVpmqDpruyJX38d2q/Y/aRXAROfo/YSQ==
X-Google-Smtp-Source: AGHT+IHoO2mUdNStDkAJ0PN4Y8/X7eJhlSrEmAcUGr5BpBZXvMsEO/6OaiDFtNns3KvOVx0B86Rmtg==
X-Received: by 2002:a05:6e02:1fe2:b0:3d3:faad:7c6f with SMTP id e9e14a558f8ab-3d5960cd064mr125511535ab.5.1742870141386;
        Mon, 24 Mar 2025 19:35:41 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdeac0esm2106900173.70.2025.03.24.19.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 19:35:40 -0700 (PDT)
Message-ID: <4b4187c1-77e5-44b7-885f-d6826723dd9a@sifive.com>
Date: Mon, 24 Mar 2025 21:35:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: KGDB: Do not inline arch_kgdb_breakpoint()
To: WangYuli <wangyuli@uniontech.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: chenhuacai@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, vincent.chen@sifive.com,
 palmerdabbelt@google.com, zhanjun@uniontech.com, niecheng1@uniontech.com,
 guanwentao@uniontech.com, Huacai Chen <chenhuacai@loongson.cn>
References: <CEF1937DAC500D66+20250322062836.362600-1-wangyuli@uniontech.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CEF1937DAC500D66+20250322062836.362600-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-22 1:28 AM, WangYuli wrote:
> The arch_kgdb_breakpoint() function defines the kgdb_compiled_break
> symbol using inline assembly.
> 
> There's a potential issue where the compiler might inline
> arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
> symbol multiple times, leading to fail to link vmlinux.o.
> 
> This isn't merely a potential compilation problem. The intent here
> is to determine the global symbol address of kgdb_compiled_break,
> and if this function is inlined multiple times, it would logically
> be a grave error.
> 
> Fixes: fe89bd2be866 ("riscv: Add KGDB support")
> Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/riscv/include/asm/kgdb.h | 13 +------------
>  arch/riscv/kernel/kgdb.c      |  8 ++++++++
>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
> index 46677daf708b..566ab1bc66fa 100644
> --- a/arch/riscv/include/asm/kgdb.h
> +++ b/arch/riscv/include/asm/kgdb.h
> @@ -17,20 +17,9 @@
>  #define BREAK_INSTR_SIZE	4
>  #endif
>  
> -#ifndef	__ASSEMBLY__
> -
> +extern void arch_kgdb_breakpoint(void);
>  extern unsigned long kgdb_compiled_break;
>  
> -static inline void arch_kgdb_breakpoint(void)
> -{
> -	asm(".global kgdb_compiled_break\n"
> -	    ".option norvc\n"
> -	    "kgdb_compiled_break: ebreak\n"
> -	    ".option rvc\n");
> -}
> -
> -#endif /* !__ASSEMBLY__ */

Why remove the __ASSEMBLY__ check? This allows the header to be included from
assembly source files by excluding the C constructs. It is still needed after
moving arch_kgdb_breakpoint()

> -
>  #define DBG_REG_ZERO "zero"
>  #define DBG_REG_RA "ra"
>  #define DBG_REG_SP "sp"
> diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
> index 2e0266ae6bd7..5d1ce8dacaf5 100644
> --- a/arch/riscv/kernel/kgdb.c
> +++ b/arch/riscv/kernel/kgdb.c
> @@ -254,6 +254,14 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>  	regs->epc = pc;
>  }
>  
> +noinline void arch_kgdb_breakpoint(void)
> +{
> +	asm(".global kgdb_compiled_break\n"
> +	    ".option norvc\n"
> +	    "kgdb_compiled_break: ebreak\n"
> +	    ".option rvc\n");

This is a separate issue, but using ".option rvc" here is a bug. It will
unconditionally enable the C extension for the rest of the file, even if the
kernel is being built with CONFIG_RISCV_ISA_C=n. This function needs to use
.option push/.option pop.

Regards,
Samuel

> +}
> +
>  void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
>  				char *remcom_out_buffer)
>  {


