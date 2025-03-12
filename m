Return-Path: <linux-kernel+bounces-557583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D863FA5DB14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA863B8684
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BE23E35D;
	Wed, 12 Mar 2025 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JapfQB+8"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5090B23A9B7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777797; cv=none; b=NSZJ4dJJK5e0zB5/f+TTyi5urKgQVz2oWkgVO+elvqFuFNofTn7a+sn4uucsWKYjAXBntROOwWif1uLPXaDBsTA6wU4oj1ap+Cls84YdSBVgFZQR+JrzRvlEgrFgIEzIVpX5glOuGFSX5uwChPwYdLjOffVt+fhg5Eb7mBFRTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777797; c=relaxed/simple;
	bh=avHSsu0dTxyxGfD4w6A9gBso6NQOQgotxKLGKrBr0+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvs/dQ/rJE1tuCNrtmyIP7rGUQhpVA1j7ZxoCtDq4kfUdk3SLmPj1l+g3EoPvNGE+bnS11MDIRyePdHwwLRSobl/dngC3z2lyxa3+Cz0O25awMgePocd8BPxQ8nN0pcTtInh76yxXdPo0MSRGUpgbB8O6iOZjH7XY+AhMNz08XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JapfQB+8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a6bso70090281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741777792; x=1742382592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jk+YaftNqssF7ZIVjayr/313NS1f8s7aGP9u3vwaLw=;
        b=JapfQB+8QvE3FDBZCXlX2yK8LgG0LrLv23P4PEgrXJyJPHjCNHtjFVpCZ7SWoXJvsT
         pX1ty9GV/LVOhH2x+1W73/URQv6YJ6J3EwRmHI1ALkV4/flykAcXDEjoXHuzthMXNrpp
         N6gzCeHz7x2wdqn+r5UeN+6FHH9ett1+MFedyryeP11rZRF41OZIQH2+zmRfTmT4/01N
         4Qt8ZppXcJn1zd9tZkZIrhRS642ZAMkkGvtR/PYmDGhY4Tz/ILK6WA8t+fifb1+lcwxC
         O2wEvehGB+Z/QtIqNM6Lsmaqe6Ke2MkJ52Bw499iBuk3IlNmO217BStyfF34wZ4ruEl+
         ioiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741777792; x=1742382592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Jk+YaftNqssF7ZIVjayr/313NS1f8s7aGP9u3vwaLw=;
        b=D3mA5heqxGQ4wRo0Z2cl0rjfrilTzD2pKl6wONDlmlYnUbP4chk0a6TvOC010V5M8n
         qrqkhHBjzUULFd7LsZ5G9qbzSajg5ssmyyDmUhzTPPlV9z1wbOrhM0bkujOKn83SWvtc
         NL7P+P0wq7ybKYPV2ic/lXhi/eUPs00SQFpaLfcJ4KG66pOsozNoDZ1OZMDP6ZqGfjn7
         PhHI38ZXbOgTaQ113XxTGgtzs28RvT0Q0VUFQr0VZKIFlKjDE+hzpmzuRCYr8Q6pZEZY
         FfAiwFe5j+8vmdTw5mw1VuHp0giHnwST5jBpYlGQ8dWswXMGWceL7Ghrs2vmjGhaDHE2
         WGMw==
X-Gm-Message-State: AOJu0YzPmnanabG3VodhaCF/THDEK8waLLY8Ek6EWGbl3EFl2f4EpL4I
	nz2rWho1oNuY6a5iTmyX2SpVcQ18y0NhYwGRnx7ZuHv0WRbGSlhE+Md5yOMaD4DXCKG4dyWbkup
	aCKLDwNdmtcMZI5WJNgMqR+KSHNQJ
X-Gm-Gg: ASbGncsm79FMdue8nLFHW6LRDymd9bAgENDJKWv3+XHCoTtXiXOtWVTgldCUCumcIM1
	R4zura1Mh9rMEgGx0BdqN5vdn9ro/CsbHQziDn+47NSGyU5GLHIOi7kcoX3Zt/TAxJWNRoNKTd7
	9PVqlqeJV1zMjnn0POSmoQCmYC0KcgLedo0NDgSB4KlKj/fC8Jh7A=
X-Google-Smtp-Source: AGHT+IHSK/CJqbIVxJoJuzcbjfrLMsCa5m5XscqpP70OCU4FnT5T9Wjz4ZFbZ2HCsj1p45eWUsAYDSpB06pDC0/n3Ug=
X-Received: by 2002:a05:6512:3d0b:b0:549:8963:eb05 with SMTP id
 2adb3069b0e04-54990ea9476mr7501602e87.37.1741777791985; Wed, 12 Mar 2025
 04:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312102740.602870-2-ardb+git@google.com>
In-Reply-To: <20250312102740.602870-2-ardb+git@google.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 12 Mar 2025 07:09:40 -0400
X-Gm-Features: AQ5f1Jq8vYUarSIDLdLKNlf4grfNNYgdX79_ZMRTSc7YyZDa6Ctwx-tT7jIm814
Message-ID: <CAMzpN2ig2wKf89Gx51MK=K96p4nHYPrqKQbpthB7d9bzNi_UDQ@mail.gmail.com>
Subject: Re: [PATCH] x86/head/64: Avoid Clang < 17 stack protector in startup code
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 6:27=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Clang versions before 17 will not honour -fdirect-access-external-data
> for the load of the stack cookie emitted into each function's prologue
> and epilogue, and will emit a GOT based reference instead, e.g.,
>
>   4c 8b 2d 00 00 00 00    mov    0x0(%rip),%r13
>           18a: R_X86_64_REX_GOTPCRELX     __ref_stack_chk_guard-0x4
>   65 49 8b 45 00          mov    %gs:0x0(%r13),%rax
>
> This is inefficient, but at least, the linker will usually follow the
> rules of the x86 psABI, and relax the GOT load into a RIP-relative LEA
> instruction.  This is still suboptimal, as the per-CPU load could use a
> RIP-relative reference directly, but at least it gets rid of the first
> load from memory.
>
> However, Boris reports that in some cases, when using distro builds of
> Clang/LLD 15, the first load gets relaxed into
>
>   49 c7 c6 20 c0 55 86  mov    $0xffffffff8655c020,%r14
>   ffffffff8373bf0f: R_X86_64_32S        __ref_stack_chk_guard
>   65 49 8b 06           mov    %gs:(%r14),%rax
>
> instead, which is fine in principle, as MOV may be cheaper than LEA on
> some micro-architectures. However, such absolute references assume that
> the variable in question can be accessed via the kernel virtual mapping,
> and this is not guaranteed for the startup code residing in .head.text.
>
> This is therefore a true positive, that was caught using the recently
> introduced relocs check for absolute references in the startup code:
>
>   Absolute reference to symbol '__ref_stack_chk_guard' not permitted in .=
head.text
>
> Work around the issue by disabling the stack protector in the startup
> code for Clang versions older than 17.
>
> Fixes: 80d47defddc0 ("x86/stackprotector/64: Convert to normal per-CPU va=
riable")
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/init.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
> index 0e82ebc5d1e1..8b1b1abcef15 100644
> --- a/arch/x86/include/asm/init.h
> +++ b/arch/x86/include/asm/init.h
> @@ -2,7 +2,11 @@
>  #ifndef _ASM_X86_INIT_H
>  #define _ASM_X86_INIT_H
>
> +#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
> +#define __head __section(".head.text") __no_sanitize_undefined __no_stac=
k_protector
> +#else
>  #define __head __section(".head.text") __no_sanitize_undefined
> +#endif

Just disable it for all __head code.  This runs long before userspace
can mount a stack smashing attack.


Brian Gerst

