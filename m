Return-Path: <linux-kernel+bounces-231918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB191A055
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEBEB20D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E984D8CF;
	Thu, 27 Jun 2024 07:22:59 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BA4C3C3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472979; cv=none; b=p9ebNBmr/FcApJzQWVOlqI/donZ6OmDe4creNYnbgAb6Gz324Cbx1AYhkW7/SfWkCfTgbkQwzgLI55AwgaXfwdJEsOpliH9ewmtmWI5NuQlHA/gNGBQMdnmRXvvNJiOOnfGPdf2wilCuzgHOlZLIjDPtEh1X47VE5BbsmLIQeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472979; c=relaxed/simple;
	bh=9Xl0Rl3PAyn7vH900ginCE5IOyjIAOhyTagO/dBh9RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyoRSK/Rm7Y1NTRBPIVOHLahFv9hMMWtMGMFeORyEWKjh5MA4r+EOQ7vq8//7s/tFqb1FVn5y4hOamJpi2Jwt2wiouOfcnqFeyzYvY7+VLwT0Wi9Gy2kLxDmQktP1aUHildSYbWd84LcA6AT1a87Ql3BuYyVcrRsw7Vvg8i7DZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 574DD72C8CC;
	Thu, 27 Jun 2024 10:14:22 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 4DCDF7CCB3C; Thu, 27 Jun 2024 10:14:22 +0300 (IDT)
Date: Thu, 27 Jun 2024 10:14:22 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andreas Schwab <schwab@suse.de>,
	David Laight <David.Laight@ACULAB.COM>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Ivan A. Melnikov" <iv@altlinux.org>
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Message-ID: <20240627071422.GA2626@altlinux.org>
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801141607.435192-1-CoelacanthusHex@gmail.com>

Hi,

On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
> entry: Save a0 prior syscall_enter_from_user_mode()").
> 
> After analysing code, we think that regs->a0 = -ENOSYS should only be
> executed when syscall != -1. In __seccomp_filter, when seccomp rejected
> this syscall with specified errno, they will set a0 to return number as
> syscall ABI, and then return -1. This return number is finally pass as
> return number of syscall_enter_from_user_mode, and then is compared with
> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
> condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
> is always executed. It covered a0 set by seccomp, so we always get
> ENOSYS when match seccomp RET_ERRNO rule.
> 
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Tested-by: Felix Yan <felixonmars@archlinux.org>
> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
> 
> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@canonical.com>
> v3 -> v4: use long instead of ulong to reduce type cast and avoid
>           implementation-defined behavior, and make the judgment of syscall
>           invalid more explicit
> v2 -> v3: use if-statement instead of set default value,
>           clarify the type of syscall
> v1 -> v2: added explanation on why always got ENOSYS
> 
>  arch/riscv/kernel/traps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..729f79c97e2bf 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> -		ulong syscall = regs->a7;
> +		long syscall = regs->a7;
>  
>  		regs->epc += 4;
>  		regs->orig_a0 = regs->a0;
> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> -		if (syscall < NR_syscalls)
> +		if (syscall >= 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
> -		else
> +		else if (syscall != -1)
>  			regs->a0 = -ENOSYS;
>  
>  		syscall_exit_to_user_mode(regs);

Unfortunately, this change introduced a regression: it broke strace
syscall tampering on riscv.  When the tracer changes syscall number to -1,
the kernel fails to initialize a0 with -ENOSYS and subsequently fails to
return the error code of the failed syscall to userspace.

I wish you were running strace test suite before changing this part of the
kernel.  Now I'm going to apply a workaround [1] in strace, but please
note that riscv seems to be the only linux architecture where such a
workaround is currently required.

There was a similar kernel bug once on parisc, but it was fixed [2]
several years ago by commit b7dc5a071ddf.

[1] https://github.com/strace/strace/commit/c3ae2b27732952663a3600269884e363cb77a024
[2] https://git.kernel.org/torvalds/c/b7dc5a071ddf69c0350396b203cba32fe5bab510


-- 
ldv

