Return-Path: <linux-kernel+bounces-429432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E275F9E1C29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E95B32E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB701E6DD5;
	Tue,  3 Dec 2024 12:19:53 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA61E631D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228393; cv=none; b=QDv93gt4P/pMMUvedLjnS3I2px3DeVMriTEN3bA5AS0D4/eV1O+V0niOEvxS5S83WLpzidAPBwg9GC32wsw1R7mzF1ikXlWSR6t0KPKpx8GcU/iYnxXga7xS5Y4B5aadX8pixsSZcHYOYdQvK2wN3xdkpzXIbkWr2+ZFOqbS3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228393; c=relaxed/simple;
	bh=HoHA9DNnzHKo8CYmBE2UkUFCkTlh+CXjWHVhf68naT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azV9DJ53Wu7bkc1u5ZCXSCj9A8xnmdjGmr14jBZsaaRvdFztPSUMerybTTo958t9CEXu8zTMhOzALfD56PKnw3mVP04xZ5sMOrrtvVnJuAaglESStHrqz0xLq6P/sS6hRfnYvmqj3CZUAbCm0gdJ5wqJmrHHxs4BrcBR0R9mpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id F264772C97D;
	Tue,  3 Dec 2024 15:19:48 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id E68127CCB3A; Tue,  3 Dec 2024 14:19:48 +0200 (IST)
Date: Tue, 3 Dec 2024 14:19:48 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrea Bolognani <abologna@redhat.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
	Felix Yan <felixonmars@archlinux.org>,
	Ruizhe Pan <c141028@gmail.com>,
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
	Quan Zhou <zhouquan@iscas.ac.cn>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
Message-ID: <20241203121948.GA18179@strace.io>
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
 <Z06ZAP-_4J4-6aK_@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z06ZAP-_4J4-6aK_@ghost>

On Mon, Dec 02, 2024 at 09:37:04PM -0800, Charlie Jenkins wrote:
[...]
> +static void ptrace_test(int opt, int *result)
> +{
> +	int status;
> +	pid_t pid;
> +	struct user_regs_struct regs;
> +	struct iovec iov = {
> +		.iov_base = &regs,
> +		.iov_len = sizeof(regs),
> +	};
> +
> +	unsigned long orig_a0;
> +	struct iovec a0_iov = {
> +		.iov_base = &orig_a0,
> +		.iov_len = sizeof(orig_a0),
> +	};
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		/* Mark oneself being traced */
> +		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
> +		if (val)
> +			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
> +
> +		kill(getpid(), SIGSTOP);
> +
> +		/* Perform exit syscall that will be intercepted */
> +		exit(A0_OLD);
> +	}
> +
> +	if (pid < 0)
> +		exit(1);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee regs before the syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (orig_a0 != A0_OLD)
> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
> +
> +	/* Modify a0/orig_a0 for the syscall */
> +	switch (opt) {
> +	case A0_MODIFY:
> +		regs.a0 = A0_NEW;
> +		break;

Did you mean applying the modified user_regs_struct using PTRACE_SETREGSET?
If yes, then there should be an appropriate PTRACE_SETREGSET NT_PRSTATUS call.
If no, then regs is ignored, so why would you change it in the first place?

> +	case ORIG_A0_MODIFY:
> +		orig_a0 = A0_NEW;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +	*result = WEXITSTATUS(status);
> +}

-- 
ldv

