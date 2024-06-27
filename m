Return-Path: <linux-kernel+bounces-232091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12D91A30E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15131C21DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48213AD1D;
	Thu, 27 Jun 2024 09:53:04 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEA17D3E3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481984; cv=none; b=hJF6HIkKhCaLILYg146AOxxCTIhegB2ouJwpcjnR0cXKkIJWszqC8i95HWMse3KS571Kvv1jNrXFOrgQIkFZGym1Z+aUjStmXDQXC6OCiquR3jwS6h4Cf+wf6r795+mnFUMKba34kemNt2RoXWa221FsOvw2XoUdhbFGzczjsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481984; c=relaxed/simple;
	bh=acqJ+RULMVuroknl7WWSNozAyFFnlatpaHFDKWBJndo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foHujgz3U6/pWO6g6K6LMpKb2cv+gHZ6H5M24mHEzzvWaJJSGTnoxyfS4PGpDTDvz8j6ebh4uf+2vgWsS/qslK9ASN7TZM8rkS4SBXlkZHGAE9IKddqxY2Ka3WlTKXyWvyPnlwFWw169oQIjckcedxdj0C95jrVjhCeEjfAhDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id B8BF172C8CC;
	Thu, 27 Jun 2024 12:52:58 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 9F34E7CCB3C; Thu, 27 Jun 2024 12:52:58 +0300 (IDT)
Date: Thu, 27 Jun 2024 12:52:58 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc: Celeste Liu <coelacanthushex@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andreas Schwab <schwab@suse.de>,
	David Laight <David.Laight@aculab.com>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Ivan A. Melnikov" <iv@altlinux.org>
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
Message-ID: <20240627095258.GA2977@altlinux.org>
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org>
 <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
 <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com>

On Thu, Jun 27, 2024 at 11:43:03AM +0200, Björn Töpel wrote:
> On Thu, Jun 27, 2024 at 9:47 AM Celeste Liu <coelacanthushex@gmail.com> wrote:
> > On 2024-06-27 15:14, Dmitry V. Levin wrote:
> >
> > > Hi,
> > >
> > > On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
> > >> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> > >> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> > >> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
> > >> entry: Save a0 prior syscall_enter_from_user_mode()").
> > >>
> > >> After analysing code, we think that regs->a0 = -ENOSYS should only be
> > >> executed when syscall != -1. In __seccomp_filter, when seccomp rejected
> > >> this syscall with specified errno, they will set a0 to return number as
> > >> syscall ABI, and then return -1. This return number is finally pass as
> > >> return number of syscall_enter_from_user_mode, and then is compared with
> > >> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
> > >> condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
> > >> is always executed. It covered a0 set by seccomp, so we always get
> > >> ENOSYS when match seccomp RET_ERRNO rule.
> > >>
> > >> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> > >> Reported-by: Felix Yan <felixonmars@archlinux.org>
> > >> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> > >> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> > >> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> > >> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> > >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> > >> Tested-by: Felix Yan <felixonmars@archlinux.org>
> > >> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > >> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > >> Reviewed-by: Guo Ren <guoren@kernel.org>
> > >> ---
> > >>
> > >> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > >> v3 -> v4: use long instead of ulong to reduce type cast and avoid
> > >>           implementation-defined behavior, and make the judgment of syscall
> > >>           invalid more explicit
> > >> v2 -> v3: use if-statement instead of set default value,
> > >>           clarify the type of syscall
> > >> v1 -> v2: added explanation on why always got ENOSYS
> > >>
> > >>  arch/riscv/kernel/traps.c | 6 +++---
> > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > >> index f910dfccbf5d2..729f79c97e2bf 100644
> > >> --- a/arch/riscv/kernel/traps.c
> > >> +++ b/arch/riscv/kernel/traps.c
> > >> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
> > >>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> > >>  {
> > >>      if (user_mode(regs)) {
> > >> -            ulong syscall = regs->a7;
> > >> +            long syscall = regs->a7;
> > >>
> > >>              regs->epc += 4;
> > >>              regs->orig_a0 = regs->a0;
> > >> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> > >>
> > >>              syscall = syscall_enter_from_user_mode(regs, syscall);
> > >>
> > >> -            if (syscall < NR_syscalls)
> > >> +            if (syscall >= 0 && syscall < NR_syscalls)
> > >>                      syscall_handler(regs, syscall);
> > >> -            else
> > >> +            else if (syscall != -1)
> > >>                      regs->a0 = -ENOSYS;
> > >>
> > >>              syscall_exit_to_user_mode(regs);
> > >
> > > Unfortunately, this change introduced a regression: it broke strace
> > > syscall tampering on riscv.  When the tracer changes syscall number to -1,
> > > the kernel fails to initialize a0 with -ENOSYS and subsequently fails to
> > > return the error code of the failed syscall to userspace.
> >
> > In the patch v2, we actually do the right thing. But as Björn Töpel's
> > suggestion and we found cast long to ulong is implementation-defined
> > behavior in C, so we change it to current form. So revert this patch and
> > apply patch v2 should fix this issue. Patch v2 uses ths same way with
> > other architectures.
> >
> > [1]: https://lore.kernel.org/all/20230718162940.226118-1-CoelacanthusHex@gmail.com/
> 
> Not reverting, but a fix to make sure that a0 is initialized to -ENOSYS, e.g.:
> 
> --8<--
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 05a16b1f0aee..51ebfd23e007 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
> 
>   regs->epc += 4;
>   regs->orig_a0 = regs->a0;
> + regs->a0 = -ENOSYS;

Given that struct user_regs_struct doesn't have orig_a0, wouldn't this
clobber a0 too early so that the tracer will get -ENOSYS in place of the
first syscall argument?


-- 
ldv

