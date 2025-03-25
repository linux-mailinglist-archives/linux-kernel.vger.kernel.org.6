Return-Path: <linux-kernel+bounces-575142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DAEA6EE34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CC11896471
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD5253F00;
	Tue, 25 Mar 2025 10:51:30 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA7EC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899889; cv=none; b=FvHIvdrRKIxktr71KSzIUU/Y8OkZZL5I/H+o90pQhjqmAeC/M0ieSxdzzdOkVJGPzRB/m0qllSKT3T3cu5nNFx5luXfSjMSzZpymSJBGZdsveaJ7Z3sFYGZ0X3fE2mQdaIBt7mVTP5pwoKK0yiSVmCLrPmjqgIPgx9IxW9Dpy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899889; c=relaxed/simple;
	bh=IsZnZR9YAIndhp7n/FiH+sRSnxBEuTYLyqyZTGNxmA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyfPabfO1DSOf2/DD+U6Mxr/8dUoFj6isZbDMwx1GmQ+mxraD22noqtgwLib+jSiuQT1gQBr5OLrJOdITC0mhfte1yApuqdpPOPlcRAk5aKN5ZIT6duIvPN+Bg8ikyzTyYSAXeDiGbxGlN1ZOQ2HQQtWLebCssQEcb+s6mTDHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 6C16A72C8CC;
	Tue, 25 Mar 2025 13:41:22 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 60C307CCB3A; Tue, 25 Mar 2025 12:41:22 +0200 (IST)
Date: Tue, 25 Mar 2025 12:41:22 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, strace-devel@lists.strace.io,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO API
Message-ID: <20250325104122.GA19416@strace.io>
References: <20250303111910.GA24170@strace.io>
 <20250306020222.GA24365@strace.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306020222.GA24365@strace.io>

On Thu, Mar 06, 2025 at 04:02:22AM +0200, Dmitry V. Levin wrote:
> Andrew, could you take this patchset into your tree, please?
> 
> It has been under review for almost two months, the last reply was two
> weeks ago, and by now all activity seems to be over.  The ptrace maintainer
> approved the ptrace-related patches of this patchset more than a month ago.
> Admittedly, most of architecture maintainers ignored the
> architecture-specific patches from this series, but this is expected,
> so I don't think it's worth waiting for their reaction any longer.
> 
> v7: https://lore.kernel.org/all/20250303111910.GA24170@strace.io/

Andrew, could you take this patchset into your tree, please?

Nothing has changed since v7, so I have nothing new to add to the text
written above.

> [trimmed Cc list to save people from irrelevant ping messages.]
> 
> On Mon, Mar 03, 2025 at 01:19:10PM +0200, Dmitry V. Levin wrote:
> > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> > system calls the tracee is blocked in.
> > 
> > This API allows ptracers to obtain and modify system call details in a
> > straightforward and architecture-agnostic way, providing a consistent way
> > of manipulating the system call number and arguments across architectures.
> > 
> > As in case of PTRACE_GET_SYSCALL_INFO, PTRACE_SET_SYSCALL_INFO also
> > does not aim to address numerous architecture-specific system call ABI
> > peculiarities, like differences in the number of system call arguments
> > for such system calls as pread64 and preadv.
> > 
> > The current implementation supports changing only those bits of system call
> > information that are used by strace system call tampering, namely, syscall
> > number, syscall arguments, and syscall return value.
> > 
> > Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
> > such as instruction pointer and stack pointer, could be added later if
> > needed, by using struct ptrace_syscall_info.flags to specify the additional
> > details that should be set.  Currently, "flags" and "reserved" fields of
> > struct ptrace_syscall_info must be initialized with zeroes; "arch",
> > "instruction_pointer", and "stack_pointer" fields are currently ignored.
> > 
> > PTRACE_SET_SYSCALL_INFO currently supports only PTRACE_SYSCALL_INFO_ENTRY,
> > PTRACE_SYSCALL_INFO_EXIT, and PTRACE_SYSCALL_INFO_SECCOMP operations.
> > Other operations could be added later if needed.
> > 
> > Ideally, PTRACE_SET_SYSCALL_INFO should have been introduced along with
> > PTRACE_GET_SYSCALL_INFO, but it didn't happen.  The last straw that
> > convinced me to implement PTRACE_SET_SYSCALL_INFO was apparent failure
> > to provide an API of changing the first system call argument on riscv
> > architecture [1].
> > 
> > ptrace(2) man page:
> > 
> > long ptrace(enum __ptrace_request request, pid_t pid, void *addr, void *data);
> > ...
> > PTRACE_SET_SYSCALL_INFO
> >        Modify information about the system call that caused the stop.
> >        The "data" argument is a pointer to struct ptrace_syscall_info
> >        that specifies the system call information to be set.
> >        The "addr" argument should be set to sizeof(struct ptrace_syscall_info)).
> > 
> > [1] https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> > 
> > Notes:
> >     v7:
> >     * csky: Fix typo in comment
> >     * mips: syscall_set_arguments: Remove mips_syscall_is_indirect check
> >     * mips: syscall_set_nr: Reword comment
> >     * mips: Add Reviewed-by
> >     * v6: https://lore.kernel.org/all/20250217090834.GA18175@strace.io/
> > 
> >     v6:
> >     * mips: Submit mips_get_syscall_arg() o32 fix via mips tree
> >       to get it merged into v6.14-rc3
> >     * Rebase to v6.14-rc3
> >     * v5: https://lore.kernel.org/all/20250210113336.GA887@strace.io/
> > 
> >     v5:
> >     * ptrace: Extend the commit message to say that the new API does not aim
> >       to address numerous architecture-specific syscall ABI peculiarities
> >     * selftests: Add a workaround for s390 16-bit syscall numbers
> >     * parisc: Add Acked-by
> >     * v4: https://lore.kernel.org/all/20250203065849.GA14120@strace.io/
> > 
> >     v4:
> >     * Split out syscall_set_return_value() for hexagon into a separate patch
> >     * s390: Change the style of syscall_set_arguments() implementation as
> >       requested
> >     * ptrace: Add Reviewed-by
> >     * v3: https://lore.kernel.org/all/20250128091445.GA8257@strace.io/
> > 
> >     v3:
> >     * powerpc: Submit syscall_set_return_value() fix for "sc" case separately
> >     * mips: Do not introduce erroneous argument truncation on mips n32,
> >       add a detailed description to the commit message of the
> >       mips_get_syscall_arg() change
> >     * ptrace: Add explicit padding to the end of struct ptrace_syscall_info,
> >       simplify obtaining of user ptrace_syscall_info,
> >       do not introduce PTRACE_SYSCALL_INFO_SIZE_VER0
> >     * ptrace: Change the return type of ptrace_set_syscall_info_* functions
> >       from "unsigned long" to "int"
> >     * ptrace: Add -ERANGE check to ptrace_set_syscall_info_exit(),
> >       add comments to -ERANGE checks
> >     * ptrace: Update comments about supported syscall stops
> >     * selftests: Extend set_syscall_info test, fix for mips n32
> >     * riscv: Add Tested-by and Reviewed-by
> > 
> >     v2:
> >     * Add patch to fix syscall_set_return_value() on powerpc
> >     * Add patch to fix mips_get_syscall_arg() on mips
> >     * Add syscall_set_return_value() implementation on hexagon
> >     * Add syscall_set_return_value() invocation to syscall_set_nr()
> >       on arm and arm64.
> >     * Fix syscall_set_nr() and mips_set_syscall_arg() on mips
> >     * Add a comment to syscall_set_nr() on arc, powerpc, s390, sh,
> >       and sparc
> >     * Remove redundant ptrace_syscall_info.op assignments in
> >       ptrace_get_syscall_info_*
> >     * Minor style tweaks in ptrace_get_syscall_info_op()
> >     * Remove syscall_set_return_value() invocation from
> >       ptrace_set_syscall_info_entry()
> >     * Skip syscall_set_arguments() invocation in case of syscall number -1
> >       in ptrace_set_syscall_info_entry() 
> >     * Split ptrace_syscall_info.reserved into ptrace_syscall_info.reserved
> >       and ptrace_syscall_info.flags
> >     * Use __kernel_ulong_t instead of unsigned long in set_syscall_info test
> > 
> > Dmitry V. Levin (6):
> >   hexagon: add syscall_set_return_value()
> >   syscall.h: add syscall_set_arguments()
> >   syscall.h: introduce syscall_set_nr()
> >   ptrace_get_syscall_info: factor out ptrace_get_syscall_info_op
> >   ptrace: introduce PTRACE_SET_SYSCALL_INFO request
> >   selftests/ptrace: add a test case for PTRACE_SET_SYSCALL_INFO
> > 
> >  arch/arc/include/asm/syscall.h                |  25 +
> >  arch/arm/include/asm/syscall.h                |  37 ++
> >  arch/arm64/include/asm/syscall.h              |  29 +
> >  arch/csky/include/asm/syscall.h               |  13 +
> >  arch/hexagon/include/asm/syscall.h            |  21 +
> >  arch/loongarch/include/asm/syscall.h          |  15 +
> >  arch/m68k/include/asm/syscall.h               |   7 +
> >  arch/microblaze/include/asm/syscall.h         |   7 +
> >  arch/mips/include/asm/syscall.h               |  43 ++
> >  arch/nios2/include/asm/syscall.h              |  16 +
> >  arch/openrisc/include/asm/syscall.h           |  13 +
> >  arch/parisc/include/asm/syscall.h             |  19 +
> >  arch/powerpc/include/asm/syscall.h            |  20 +
> >  arch/riscv/include/asm/syscall.h              |  16 +
> >  arch/s390/include/asm/syscall.h               |  21 +
> >  arch/sh/include/asm/syscall_32.h              |  24 +
> >  arch/sparc/include/asm/syscall.h              |  22 +
> >  arch/um/include/asm/syscall-generic.h         |  19 +
> >  arch/x86/include/asm/syscall.h                |  43 ++
> >  arch/xtensa/include/asm/syscall.h             |  18 +
> >  include/asm-generic/syscall.h                 |  30 +
> >  include/uapi/linux/ptrace.h                   |   7 +-
> >  kernel/ptrace.c                               | 179 +++++-
> >  tools/testing/selftests/ptrace/Makefile       |   2 +-
> >  .../selftests/ptrace/set_syscall_info.c       | 519 ++++++++++++++++++
> >  25 files changed, 1138 insertions(+), 27 deletions(-)
> >  create mode 100644 tools/testing/selftests/ptrace/set_syscall_info.c
> > 
> > 
> > base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> 
> -- 
> ldv

-- 
ldv

