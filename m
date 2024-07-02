Return-Path: <linux-kernel+bounces-237272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1D91EE64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708F11F22AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302035477A;
	Tue,  2 Jul 2024 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2y3U4cXc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA853EA9A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898656; cv=none; b=WffVcX8Qc9I3PKR+cKqIJcLq74xuBuMVn5jVUGUqVxJ5BnmOvFn6UQFADRuCAt8yF+F3DqN4InysjEjzBkbxulbRCdm6YYQh1vibyksz62bmDZ9UuKw1N9esqaId/m0Sbw17iH1tk3uib7g10sMGOsSNgujx9pYRjqGt6dfX+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898656; c=relaxed/simple;
	bh=VVbh0fQ7/Q2au2kwoY1UK0e85qra4bt9HY3Ly61I5K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFZypMiJYc6vB2SYp+OrgD4X2MyPL2A/m5rfAyNCzczRz4MMPKHHcadCt7SgEQAaU6gW6QsAj5kFVi9YecHHdyADcL36P9gfiaiRJbthm1LJawisKISlmOmOKl3yYhHp0+HiRMsCyxxo/c1G8rOCLU6tV4UMzdTge5P3O7NnBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2y3U4cXc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa9f540f45so21116715ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719898653; x=1720503453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QylUuXEtNL3Eo0vKPHJFlDtSdhA+F4KnUDy2bHeIjjY=;
        b=2y3U4cXcNcx5T2KOxAFsBFR6Vayr//5HhAnuY1M26FAqDH9qdyP2kGo83qayKSB6lG
         LGIf+a5SPuNncRhoniY2+XGLJvRB0mEMuZz28IbHJm+icyf8/k88IxEVV2e7UphHWvpm
         jve4YAHOZlpdR80fL/op9YR8tM5B6pao7lfNVRdqA2+Qt8mx07DQcMADu0mFMxwvegOR
         OGzSSuqbJ5l3VSLwECJCkqL+wPGA8QmoxyT3xQUhNpNU13yJdwTCDOfyIb8H+p/JJ2dr
         0KJVcIxLgkszJehD/YuoPHcIiCJE/UAnj9ahQdwAa3egGDBjWno+rSjf7tXqreZOlJkq
         +IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719898653; x=1720503453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QylUuXEtNL3Eo0vKPHJFlDtSdhA+F4KnUDy2bHeIjjY=;
        b=Ns+a9KOwzg2ggMqw6jYCri/dYTKawACanwc6bmXo5DI0YsJ0gSPr9fc/2Zsh6cgggi
         ZiLjSpI/QH7ALd4zzVbViYtgyren6BZ8ETMfRIAvNaZ6ZKpwcmLokDU/sx2QkE9S8Dh8
         Fiiio2MmuGS3oFAfQn3kfjV9n7UKbz8WBLfKYzEYE7dZQide102/MV6oPeYJv99IdXsQ
         a2FxmnH4OMWQ2h2RL55oCBcR1xGl5G2/8HpuRGG8EiABdI6rA4aQl1BBWqJdDtekQqsN
         UYgTh/vA8JdhgOPGwiWxxLshJ83MSL9OypkbLkFRMaTtowWarEih6UIjhCfr3w95+jEG
         2RaA==
X-Forwarded-Encrypted: i=1; AJvYcCWTNj1BcnI2/8Nra2Uju973o/Z4jw8jMTO5DEZKRzrN/vcY3avdLtC2LznJJdQCs4FoZaiFCFaagTR4agTJNTuD2lV6PduFNeu0cZ70
X-Gm-Message-State: AOJu0Yze3tOT/QJOGnss/jkMpr9KUsznShURhQNwAWqBvPmqxC7vJm0i
	uPi29+BTX1PWujoszrT3mFnwMLsgUuP+rYNoWRj1AqEPU7l+x4QhyokT83Bf7m0=
X-Google-Smtp-Source: AGHT+IHD/AlEviT8SXJiTbsVNwnXf2yMzxVXULAD/ULUcJEhqMDI0cnZbgXoTsLn/2TmyvmqZXXKYw==
X-Received: by 2002:a17:902:e5cb:b0:1f6:6ef0:dae4 with SMTP id d9443c01a7336-1fadbca5bc3mr43646675ad.32.1719898653462;
        Mon, 01 Jul 2024 22:37:33 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:a569:328b:99ad:ce17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d15a9sm74873685ad.37.2024.07.01.22.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 22:37:32 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:37:30 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: zhouquan@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, oleg@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	andy.chiu@sifive.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Message-ID: <ZoOSGt9jbKn1f37d@ghost>
References: <cover.1719408040.git.zhouquan@iscas.ac.cn>
 <1e9cbab1b0badc05592fce46717418930076a6ae.1719408040.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e9cbab1b0badc05592fce46717418930076a6ae.1719408040.git.zhouquan@iscas.ac.cn>

On Thu, Jun 27, 2024 at 11:02:54AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> This test checks that orig_a0 allows a syscall argument to be modified,
> and that changing a0 does not change the syscall argument.
> 
> Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  tools/testing/selftests/riscv/Makefile       |   2 +-
>  tools/testing/selftests/riscv/abi/.gitignore |   1 +
>  tools/testing/selftests/riscv/abi/Makefile   |  12 ++
>  tools/testing/selftests/riscv/abi/ptrace.c   | 124 +++++++++++++++++++
>  4 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/abi/Makefile
>  create mode 100644 tools/testing/selftests/riscv/abi/ptrace.c
> 
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 7ce03d832b64..98541dc2f164 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
> +RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn abi
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
> new file mode 100644
> index 000000000000..d61c51358965
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/.gitignore
> @@ -0,0 +1 @@
> +ptrace
> diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
> new file mode 100644
> index 000000000000..808d48a91ad7
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := ptrace
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/ptrace: ptrace.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
> new file mode 100644
> index 000000000000..f85f927cd685
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <signal.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/ptrace.h>
> +#include <sys/stat.h>
> +#include <sys/user.h>
> +#include <sys/wait.h>
> +#include <sys/uio.h>
> +#include <linux/elf.h>
> +#include <linux/unistd.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +#define ORIG_A0_MODIFY      0x01
> +#define A0_MODIFY           0x02
> +#define A0_OLD              0x03
> +#define A0_NEW              0x04
> +
> +#define perr_and_exit(fmt, ...)					\
> +	({								\
> +	 	char buf[256];						\

Apologies, I missed this in the last review. In the above line there is
a space in the middle of the tabs before `char buf[256];`.

> +		snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
> +			__func__, __LINE__, ##__VA_ARGS__);		\
> +		perror(buf);						\
> +		exit(-1);						\
> +	})
> +
> +static inline void resume_and_wait_tracee(pid_t pid, int flag)
> +{
> +	int status;
> +
> +	if (ptrace(flag, pid, 0, 0))
> +		perr_and_exit("failed to resume the tracee %d\n", pid);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +}
> +
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
> +	if (pid < 0)
> +		exit(1);
> +
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee %d\n", pid);
> +
> +	/* Stop at the entry point of the syscall */
> +	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
> +
> +	/* Check tracee orig_a0 before the syscall */
> +	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to get tracee registers\n");
> +	if (regs.orig_a0 != A0_OLD)
> +		perr_and_exit("unexpected orig_a0: 0x%lx\n", regs.orig_a0);
> +
> +	/* Modify a0/orig_a0 for the syscall */
> +	switch (opt) {
> +	case A0_MODIFY:
> +		regs.a0 = A0_NEW;
> +		break;
> +	case ORIG_A0_MODIFY:
> +		regs.orig_a0 = A0_NEW;
> +		break;
> +	}
> +
> +	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
> +		perr_and_exit("failed to set tracee registers\n");
> +
> +	/* Resume the tracee */
> +	ptrace(PTRACE_CONT, pid, 0, 0);
> +	if (waitpid(pid, &status, 0) != pid)
> +		perr_and_exit("failed to wait for the tracee\n");
> +
> +	*result = WEXITSTATUS(status);
> +}
> +
> +TEST(ptrace_modify_a0)
> +{
> +	int result;
> +
> +	ptrace_test(A0_MODIFY, &result);
> +
> +	/* The modification of a0 cannot affect the first argument of the syscall */
> +	EXPECT_EQ(A0_OLD, result);
> +}
> +
> +TEST(ptrace_modify_orig_a0)
> +{
> +	int result;
> +
> +	ptrace_test(ORIG_A0_MODIFY, &result);
> +
> +	/* Only modify orig_a0 to change the first argument of the syscall */
> +	EXPECT_EQ(A0_NEW, result);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


