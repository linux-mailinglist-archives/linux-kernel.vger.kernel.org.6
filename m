Return-Path: <linux-kernel+bounces-172124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B998BEDD2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34D31C24E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153F170844;
	Tue,  7 May 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HziCKbqy"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA116EC15
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112295; cv=none; b=sKlKGPRtdUikBMeu1pug55HLZf9js/bJSdPqMUPWEmvv2EA9P4oIWJVpTMfmfubeFExDgFAjHR8jFB7RWmq1MW8aMnK0N9cwTYW22WusB9xXkMMysyJct23L1w8pWzVKqMEuJgkbL7JJ4uK+rMsgkUlonm1TNSxZFhNNXloQ874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112295; c=relaxed/simple;
	bh=4F/dUUD8ugDBz/Ko9ETODvMYO6HAT4VKckHXnoqS7HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrEyMMDN7OhKHm2wwprQT+tmhqeZJB8Orwj8M8GvNUZ3qsjblHeLT1uWC66sprM4jNH9G47dhAYagvrxEW2UOaH9v7a1HDwlLd44Q5yOufqNzS4brvQEdxGWtuJAB1vxRmPbfEbkv5zOCO79vWT7a83cFLKBneW+r8zMwagQTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HziCKbqy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b27c660174so2397845a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715112293; x=1715717093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NN4Ftt8FMvIhQtGext6ujnG89NmvsBUOCpDEGGjh9Nc=;
        b=HziCKbqyqHjr2zEiC8zM/DfNF0+TDCxVkJvl0avPeb1JaHmuoOi93Aw0KQ5EbZcn8b
         l3wIZQz/+lWXmtycKu5yaGx/b2zmYBN+NtikpS7khScWU3CfBT9T9dA93OaKnhjPXOTR
         NBZTc3/cyAuO+VZab5pFvtlhJfxWF81mor5nN26osbXeNX7pZQuA6tbQXnTj7dErQGlD
         Q7USCu/h8R1ajQ0GnQ/gSvHvbD0Z9m1jA47LvTZ+d7uhKxMYfyGbao1tFs/aN0ygxi6q
         ZKVtzHT2KoNwkXLsw4IrR6B1u1GsLTfeWZGEtdf+hJCehY3zLFmHVJv/Ze8FE3KyDfCV
         XzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112293; x=1715717093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN4Ftt8FMvIhQtGext6ujnG89NmvsBUOCpDEGGjh9Nc=;
        b=nAwjVf2x5garjCfzVft/y4CboGWt0Hqt1yyWPd0sGYZgZ4ixarfgPw87G6jnHy44Rs
         2+rp/EM6eOD2nnmEG+h01Tja8f+VICIfa+J+TYLFpBSE/mK0waPO5sIMGzFtiGxD4FMR
         MQg31Hk4/DjScqre4OEZbhKe0j/1w2/vuTnx1hGsf6WuejXuJmNpxxnKl0J6ldv+N+Bp
         t/jt5hYWbgQBXGg1AFX6kxMiHYA4VmXtIDCB7KwtQkTMgYfr/J+P6OgaN0ZBt8FsIEPA
         5bzuFwsfhXDrey0tTbtD7xFoQiXDpa/o9fMiQvQfstBd/CIhvhXVqEq278tnC2Y24dPL
         p6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXMdnwPoTosTxJspBuX/vLl/tnCatkL2MuJ5ast6EpyFDBVNAmx4gctnCEMmCQHsDqtrnxLnZRsG7bwf3Qczs1UFBjdBf/C2akL4oXP
X-Gm-Message-State: AOJu0Yxd6v+jamHejzr4JW0HZv8O/bQdk8Sz7C4oiYM5pQHbwG6uiyLr
	00O2iw2zj4gpsJuxlb2i1ZPKp6C7dMQs7Egtpz86YDaZfBu6xAJfjXocxzErBuY=
X-Google-Smtp-Source: AGHT+IEG3jn43PIu89+58dxf/d1E5pC14XMqKQCvSTc8ITHJ3vHUgTB4qVRdG1SnmOAmjamgEo2kZA==
X-Received: by 2002:a17:90a:f612:b0:2b3:a79a:7e4b with SMTP id 98e67ed59e1d1-2b6166bf6a4mr626414a91.22.1715112293010;
        Tue, 07 May 2024 13:04:53 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:9de1:32f1:3d81:10c7])
        by smtp.gmail.com with ESMTPSA id rr3-20020a17090b2b4300b002b113ad5f10sm12158656pjb.12.2024.05.07.13.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:04:52 -0700 (PDT)
Date: Tue, 7 May 2024 13:04:50 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: Support compiling the kernel with extensions
Message-ID: <ZjqJYiNYvTvtL0O4@ghost>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
 <12808AB2-0308-4013-9624-E3DEFCC584EA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12808AB2-0308-4013-9624-E3DEFCC584EA@kernel.org>

On Tue, May 07, 2024 at 08:25:09AM +0100, Conor Dooley wrote:
> Hey Charlie,
> 
> On 7 May 2024 02:40:41 IST, Charlie Jenkins <charlie@rivosinc.com> wrote:
> >The kernel currently has the restriction that it can only be compiled
> >with the extensions that are hardcoded in arch/risc/Makefile.
> >
> >Any extension that is not listed in the Makefile can still be used by
> >explicitly writing the assembly and using alternative patching.
> >
> >This series introduces Kconfig options that allow the kernel to be
> >compiled with additional extensions.
> 
> One thing I don't see in the commit messages or the cover letter is what your actual motivation is
> for making these changes.
> Are you effectively looking to evaluate the alternatives at build time, or are you looking to
> let the compiler use the extension where it sees
> fit? Or perhaps both?

Both. I forgot to mention that this uses the updated wording from your
patch "RISC-V: clarify what some RISCV_ISA* config options do".

The hope is that at some point the kernel can be compiled with something
like the RVI profiles, in the interim this allows people to compile
kernels with these extensions for some "free" performance improvements.
I haven't tested performance on real hardware, but compiling the kernel
with the Zb* extensions has a 4.9% dynamic instruction count reduction
when running a boot + simple userspace program test (tested using
Spike). 

I meant to remove "v" from the march since we have to call the kernel
begin/end functions when using vector, I'll need to update that in the
next version.

- Charlie

> 
> Thanks,
> Conor.
> 
> >
> >Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> >---
> >Charlie Jenkins (8):
> >      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig option
> >      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V Kconfig option
> >      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT Kconfig option
> >      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT Kconfig option
> >      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig option
> >      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig option
> >      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig option
> >      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig option
> >
> > arch/riscv/Kconfig                    | 135 +-----------
> > arch/riscv/Kconfig.isa                | 393 ++++++++++++++++++++++++++++++++++
> > arch/riscv/Makefile                   |  15 +-
> > arch/riscv/crypto/Kconfig             |  14 +-
> > arch/riscv/include/asm/arch_hweight.h |  33 +--
> > arch/riscv/include/asm/checksum.h     |  18 +-
> > arch/riscv/include/asm/pgtable.h      |   3 +-
> > arch/riscv/include/asm/simd.h         |   3 +
> > arch/riscv/include/asm/vector.h       |   3 +-
> > arch/riscv/kernel/cpufeature.c        |   3 +-
> > arch/riscv/kernel/head.S              |   8 +-
> > arch/riscv/kernel/probes/uprobes.c    |   2 +-
> > arch/riscv/kernel/process.c           |  14 +-
> > arch/riscv/kernel/ptrace.c            |   6 +
> > arch/riscv/lib/csum.c                 |  48 ++---
> > arch/riscv/lib/riscv_v_helpers.c      |   1 -
> > arch/riscv/lib/strcmp.S               |   4 +-
> > arch/riscv/lib/strlen.S               |   4 +-
> > arch/riscv/lib/strncmp.S              |   4 +-
> > arch/riscv/lib/uaccess_vector.S       |   2 +
> > arch/riscv/lib/xor.S                  |   2 +
> > arch/riscv/net/bpf_jit.h              |   8 +-
> > 22 files changed, 511 insertions(+), 212 deletions(-)
> >---
> >base-commit: 2f47357557b7aa98d9d9002688aae480864ca3f6
> >change-id: 20240429-compile_kernel_with_extensions-92dd2403d325

