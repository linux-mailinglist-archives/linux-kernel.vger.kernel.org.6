Return-Path: <linux-kernel+bounces-327525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254D977722
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DEFFB23332
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C01D2F58;
	Fri, 13 Sep 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YKFYAvkO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EC1B12D9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196097; cv=none; b=IQwjWTvWYzbETCoHDr3o2ebBr9bxk10QFf+CUcg4eD7olxY9UAN+EW9EdUYkIwree+tuzOnUjrp+ETNwREnkxnXqkYJztLLKe95l7mgl5lt2FYw6IIsZvgxKKQijufh7kD9eDN8FfAXMs36uRclhCNbZ9cQiBXqdGUv9yCo2YS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196097; c=relaxed/simple;
	bh=obmpJpf4Hkwquc4hjPsAopXUJzBPLaNA6m8OVZNIr/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGMFPY8zd+6IoWSEDy83i+odceOzB2tzOI2N+5FXuCFdLu47DmdHKL+1ichq+OotCuysvRu2NWZnV8cRWxJIgh0RX4CdnYxHjGZ5NqIFiQJV0Pan77cHaVgXDHx0ZtNB9oZT5yA/AcZw85K42nA+Z1fWzNZm0rgMn650NWGOpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YKFYAvkO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206e614953aso18152335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726196093; x=1726800893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/P8PUdJnvCleQHGflHWKJwQSU5jI0eeDWaSn23VHlk=;
        b=YKFYAvkOkDowceDDdOurunqztviKWmvMkGQ8uhcU4ISRDduVaKsGIRhN9qAuQQ53mV
         CK+Z5XiTiPsUR5JXoMJKiiZ9HayJcPM+0FtgvIO6Iom/BebMUmeUyE/w9KDDBQNMkl6t
         hJWKKoG9aiQbZWN+So1xrpKAnCWHRuLM46vGHBvMCGaEJFl+J/VquWY6dMzf/0DJZulc
         nUzAESAHvxaxlSqY1Su8wCf66HamLiTTo4oxDyrF9mVZtxh2+fg1iNTyey7tdgIzLpQm
         2CtL0/L3S/S8OOXP27qSeTf4Yy7Zn2bmFhGsn1JJA989kd7gaiwbwsq0SS+xSO6xDkqh
         f7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726196093; x=1726800893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/P8PUdJnvCleQHGflHWKJwQSU5jI0eeDWaSn23VHlk=;
        b=guRnmFXzDAR26R6gE5bxA1BpWElQLT+BUwTZS6qKcKKPLOacmYhG94wmj6x4xeMPIU
         06uJ3IQST0VIyCNZ/Jos6+2NR0HlnT+Rvb7w0n0gXT8Mo75NjA5mfcxmaBOxDBnYMpPW
         6dzKpXIuPX1bEB4IxkOBHoyeDfo7924bvl78f5+3xfkq9NS3c87IITanPtLUNe1niuiZ
         tl0d4n3SqLqml5pnHGaSmNhLQ6N96BDd/u+gV6eWFsd4JnmTZ5wXi+lln19qvDx3BmcP
         sv7LEF/vnOIGyaZOg1OvUdKz0InUkLUDw8RyredGgj+M9pn7/Od//HwHQPpHUB56OhA9
         T0pg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGVZbXVXUFXqJ5g5Z/IQh6mCoG5RpXldCoMaChIr6+xwMThRZUpy+eM6GvIQMEMFKeqW0ce12+04vxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5ondvc1J6vbGMXPwnfDz0Gn9MT0zme50PlAP/6wmlJ9pwHgP
	aMthVogdBjYQIClA8WZ/5gDF8KwalquStX6dGwVsD1moD1EDs9KNOi9PqygC1Ko=
X-Google-Smtp-Source: AGHT+IEBFt1rQLh+y+QAZIklzaCIhPnDP4xTdJ7YpOtZC9XQCR02JK6exakLY4qQcqeoMCking/YYA==
X-Received: by 2002:a17:903:185:b0:205:8425:e9c6 with SMTP id d9443c01a7336-2076e43fe94mr56673625ad.52.1726196092428;
        Thu, 12 Sep 2024 19:54:52 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a329sm20082975ad.290.2024.09.12.19.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 19:54:51 -0700 (PDT)
Date: Thu, 12 Sep 2024 19:54:49 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 07/10] selftests: riscv: Add a pointer masking test
Message-ID: <ZuOpeSDO173y8Ut7@ghost>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-8-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010151.2813377-8-samuel.holland@sifive.com>

On Wed, Aug 28, 2024 at 06:01:29PM -0700, Samuel Holland wrote:
> This test covers the behavior of the PR_SET_TAGGED_ADDR_CTRL and
> PR_GET_TAGGED_ADDR_CTRL prctl() operations, their effects on the
> userspace ABI, and their effects on the system call ABI.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - Rename "tags" directory to "pm" to avoid .gitignore rules
>  - Add .gitignore file to ignore the compiled selftest binary
>  - Write to a pipe to force dereferencing the user pointer
>  - Handle SIGSEGV in the child process to reduce dmesg noise
> 
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  tools/testing/selftests/riscv/pm/.gitignore   |   1 +
>  tools/testing/selftests/riscv/pm/Makefile     |  10 +
>  .../selftests/riscv/pm/pointer_masking.c      | 330 ++++++++++++++++++
>  4 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/riscv/pm/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/pm/Makefile
>  create mode 100644 tools/testing/selftests/riscv/pm/pointer_masking.c
> 
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 7ce03d832b64..2ee1d1548c5f 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
> +RISCV_SUBTARGETS ?= hwprobe mm pm sigreturn vector
>  else
>  RISCV_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/riscv/pm/.gitignore b/tools/testing/selftests/riscv/pm/.gitignore
> new file mode 100644
> index 000000000000..b38358f91c4d
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/pm/.gitignore
> @@ -0,0 +1 @@
> +pointer_masking
> diff --git a/tools/testing/selftests/riscv/pm/Makefile b/tools/testing/selftests/riscv/pm/Makefile
> new file mode 100644
> index 000000000000..ed82ff9c664e
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/pm/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := pointer_masking
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/pointer_masking: pointer_masking.c
> +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/pm/pointer_masking.c b/tools/testing/selftests/riscv/pm/pointer_masking.c
> new file mode 100644
> index 000000000000..0fe80f963ace
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/pm/pointer_masking.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <setjmp.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "../../kselftest.h"
> +
> +#ifndef PR_PMLEN_SHIFT
> +#define PR_PMLEN_SHIFT			24
> +#endif
> +#ifndef PR_PMLEN_MASK
> +#define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
> +#endif
> +
> +static int dev_zero;
> +
> +static int pipefd[2];
> +
> +static sigjmp_buf jmpbuf;
> +
> +static void sigsegv_handler(int sig)
> +{
> +	siglongjmp(jmpbuf, 1);
> +}
> +
> +static int min_pmlen;
> +static int max_pmlen;
> +
> +static inline bool valid_pmlen(int pmlen)
> +{
> +	return pmlen == 0 || pmlen == 7 || pmlen == 16;
> +}
> +
> +static void test_pmlen(void)
> +{
> +	ksft_print_msg("Testing available PMLEN values\n");
> +
> +	for (int request = 0; request <= 16; request++) {
> +		int pmlen, ret;
> +
> +		ret = prctl(PR_SET_TAGGED_ADDR_CTRL, request << PR_PMLEN_SHIFT, 0, 0, 0);
> +		if (ret)
> +			goto pr_set_error;
> +
> +		ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
> +		ksft_test_result(ret >= 0, "PMLEN=%d PR_GET_TAGGED_ADDR_CTRL\n", request);
> +		if (ret < 0)
> +			goto pr_get_error;
> +
> +		pmlen = (ret & PR_PMLEN_MASK) >> PR_PMLEN_SHIFT;
> +		ksft_test_result(pmlen >= request, "PMLEN=%d constraint\n", request);
> +		ksft_test_result(valid_pmlen(pmlen), "PMLEN=%d validity\n", request);
> +
> +		if (min_pmlen == 0)
> +			min_pmlen = pmlen;
> +		if (max_pmlen < pmlen)
> +			max_pmlen = pmlen;
> +
> +		continue;
> +
> +pr_set_error:
> +		ksft_test_result_skip("PMLEN=%d PR_GET_TAGGED_ADDR_CTRL\n", request);
> +pr_get_error:
> +		ksft_test_result_skip("PMLEN=%d constraint\n", request);
> +		ksft_test_result_skip("PMLEN=%d validity\n", request);
> +	}
> +
> +	if (max_pmlen == 0)
> +		ksft_exit_fail_msg("Failed to enable pointer masking\n");
> +}
> +
> +static int set_tagged_addr_ctrl(int pmlen, bool tagged_addr_abi)
> +{
> +	int arg, ret;
> +
> +	arg = pmlen << PR_PMLEN_SHIFT | tagged_addr_abi;
> +	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, arg, 0, 0, 0);
> +	if (!ret) {
> +		ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
> +		if (ret == arg)
> +			return 0;
> +	}
> +
> +	return ret < 0 ? -errno : -ENODATA;
> +}
> +
> +static void test_dereference_pmlen(int pmlen)
> +{
> +	static volatile int i;
> +	volatile int *p;
> +	int ret;
> +
> +	ret = set_tagged_addr_ctrl(pmlen, false);
> +	if (ret)
> +		return ksft_test_result_error("PMLEN=%d setup (%d)\n", pmlen, ret);
> +
> +	i = pmlen;
> +
> +	if (pmlen) {
> +		p = (volatile int *)((uintptr_t)&i | 1UL << __riscv_xlen - pmlen);
> +
> +		/* These dereferences should succeed. */
> +		if (sigsetjmp(jmpbuf, 1))
> +			return ksft_test_result_fail("PMLEN=%d valid tag\n", pmlen);
> +		if (*p != pmlen)
> +			return ksft_test_result_fail("PMLEN=%d bad value\n", pmlen);
> +		*p++;
> +	}
> +
> +	p = (volatile int *)((uintptr_t)&i | 1UL << __riscv_xlen - pmlen - 1);
> +
> +	/* These dereferences should raise SIGSEGV. */
> +	if (sigsetjmp(jmpbuf, 1))
> +		return ksft_test_result_pass("PMLEN=%d dereference\n", pmlen);
> +	*p++;
> +	ksft_test_result_fail("PMLEN=%d invalid tag\n", pmlen);
> +}
> +
> +static void test_dereference(void)
> +{
> +	ksft_print_msg("Testing userspace pointer dereference\n");
> +
> +	signal(SIGSEGV, sigsegv_handler);
> +
> +	test_dereference_pmlen(0);
> +	test_dereference_pmlen(min_pmlen);
> +	test_dereference_pmlen(max_pmlen);
> +
> +	signal(SIGSEGV, SIG_DFL);
> +}
> +
> +static void execve_child_sigsegv_handler(int sig)
> +{
> +	exit(42);
> +}
> +
> +static int execve_child(void)
> +{
> +	static volatile int i;
> +	volatile int *p = (volatile int *)((uintptr_t)&i | 1UL << __riscv_xlen - 7);
> +
> +	signal(SIGSEGV, execve_child_sigsegv_handler);
> +
> +	/* This dereference should raise SIGSEGV. */
> +	return *p;
> +}
> +
> +static void test_fork_exec(void)
> +{
> +	int ret, status;
> +
> +	ksft_print_msg("Testing fork/exec behavior\n");
> +
> +	ret = set_tagged_addr_ctrl(min_pmlen, false);
> +	if (ret)
> +		return ksft_test_result_error("setup (%d)\n", ret);
> +
> +	if (fork()) {
> +		wait(&status);
> +		ksft_test_result(WIFEXITED(status) && WEXITSTATUS(status) == 42,
> +				 "dereference after fork\n");
> +	} else {
> +		static volatile int i = 42;
> +		volatile int *p = (volatile int *)((uintptr_t)&i | 1UL << __riscv_xlen - min_pmlen);
> +
> +		/* This dereference should succeed. */
> +		exit(*p);
> +	}
> +
> +	if (fork()) {
> +		wait(&status);
> +		ksft_test_result(WIFEXITED(status) && WEXITSTATUS(status) == 42,
> +				 "dereference after fork+exec\n");
> +	} else {
> +		/* Will call execve_child(). */
> +		execve("/proc/self/exe", (char *const []) { "", NULL }, NULL);
> +	}
> +}
> +
> +static void test_tagged_addr_abi_sysctl(void)
> +{
> +	char value;
> +	int fd;
> +
> +	ksft_print_msg("Testing tagged address ABI sysctl\n");
> +
> +	fd = open("/proc/sys/abi/tagged_addr_disabled", O_WRONLY);
> +	if (fd < 0) {
> +		ksft_test_result_skip("failed to open sysctl file\n");
> +		ksft_test_result_skip("failed to open sysctl file\n");
> +		return;
> +	}
> +
> +	value = '1';
> +	pwrite(fd, &value, 1, 0);
> +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
> +			 "sysctl disabled\n");
> +
> +	value = '0';
> +	pwrite(fd, &value, 1, 0);
> +	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
> +			 "sysctl enabled\n");
> +
> +	set_tagged_addr_ctrl(0, false);
> +
> +	close(fd);
> +}
> +
> +static void test_tagged_addr_abi_pmlen(int pmlen)
> +{
> +	int i, *p, ret;
> +
> +	i = ~pmlen;
> +
> +	if (pmlen) {
> +		p = (int *)((uintptr_t)&i | 1UL << __riscv_xlen - pmlen);

I am trying to put something together with
https://lore.kernel.org/linux-mm/20240905-patches-below_hint_mmap-v3-2-3cd5564efbbb@rivosinc.com/T/
to ensure that the upper addresses aren't allocated. This is only
relevant on sv57 and PMLEN=16 hardware where addresses could overlap.

> +
> +		ret = set_tagged_addr_ctrl(pmlen, false);
> +		if (ret)
> +			return ksft_test_result_error("PMLEN=%d ABI disabled setup (%d)\n",
> +						      pmlen, ret);
> +
> +		ret = write(pipefd[1], p, sizeof(*p));
> +		if (ret >= 0 || errno != EFAULT)
> +			return ksft_test_result_fail("PMLEN=%d ABI disabled write\n", pmlen);
> +
> +		ret = read(dev_zero, p, sizeof(*p));
> +		if (ret >= 0 || errno != EFAULT)
> +			return ksft_test_result_fail("PMLEN=%d ABI disabled read\n", pmlen);
> +
> +		if (i != ~pmlen)
> +			return ksft_test_result_fail("PMLEN=%d ABI disabled value\n", pmlen);
> +
> +		ret = set_tagged_addr_ctrl(pmlen, true);
> +		if (ret)
> +			return ksft_test_result_error("PMLEN=%d ABI enabled setup (%d)\n",
> +						      pmlen, ret);
> +
> +		ret = write(pipefd[1], p, sizeof(*p));
> +		if (ret != sizeof(*p))
> +			return ksft_test_result_fail("PMLEN=%d ABI enabled write\n", pmlen);
> +
> +		ret = read(dev_zero, p, sizeof(*p));
> +		if (ret != sizeof(*p))
> +			return ksft_test_result_fail("PMLEN=%d ABI enabled read\n", pmlen);
> +
> +		if (i)
> +			return ksft_test_result_fail("PMLEN=%d ABI enabled value\n", pmlen);
> +
> +		i = ~pmlen;
> +	} else {
> +		/* The tagged address ABI cannot be enabled when PMLEN == 0. */
> +		ret = set_tagged_addr_ctrl(pmlen, true);
> +		if (ret != -EINVAL)
> +			return ksft_test_result_error("PMLEN=%d ABI setup (%d)\n",
> +						      pmlen, ret);
> +	}
> +
> +	p = (int *)((uintptr_t)&i | 1UL << __riscv_xlen - pmlen - 1);
> +
> +	ret = write(pipefd[1], p, sizeof(*p));
> +	if (ret >= 0 || errno != EFAULT)
> +		return ksft_test_result_fail("PMLEN=%d invalid tag write (%d)\n", pmlen, errno);
> +
> +	ret = read(dev_zero, p, sizeof(*p));
> +	if (ret >= 0 || errno != EFAULT)
> +		return ksft_test_result_fail("PMLEN=%d invalid tag read\n", pmlen);
> +
> +	if (i != ~pmlen)
> +		return ksft_test_result_fail("PMLEN=%d invalid tag value\n", pmlen);
> +
> +	ksft_test_result_pass("PMLEN=%d tagged address ABI\n", pmlen);
> +}
> +
> +static void test_tagged_addr_abi(void)
> +{
> +	ksft_print_msg("Testing tagged address ABI\n");
> +
> +	test_tagged_addr_abi_pmlen(0);
> +	test_tagged_addr_abi_pmlen(min_pmlen);
> +	test_tagged_addr_abi_pmlen(max_pmlen);
> +}
> +
> +static struct test_info {
> +	unsigned int nr_tests;
> +	void (*test_fn)(void);
> +} tests[] = {
> +	{ .nr_tests = 17 * 3, test_pmlen },
> +	{ .nr_tests = 3, test_dereference },
> +	{ .nr_tests = 2, test_fork_exec },
> +	{ .nr_tests = 2, test_tagged_addr_abi_sysctl },
> +	{ .nr_tests = 3, test_tagged_addr_abi },
> +};
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int plan = 0;
> +	int ret;
> +
> +	/* Check if this is the child process after execve(). */
> +	if (!argv[0][0])
> +		return execve_child();
> +
> +	dev_zero = open("/dev/zero", O_RDWR);
> +	if (dev_zero < 0)
> +		return 1;
> +
> +	/* Write to a pipe so the kernel must dereference the buffer pointer. */
> +	ret = pipe(pipefd);
> +	if (ret)
> +		return 1;
> +
> +	ksft_print_header();
> +
> +	for (int i = 0; i < ARRAY_SIZE(tests); ++i)
> +		plan += tests[i].nr_tests;
> +
> +	ksft_set_plan(plan);
> +
> +	for (int i = 0; i < ARRAY_SIZE(tests); ++i)
> +		tests[i].test_fn();
> +
> +	ksft_finished();
> +}
> -- 
> 2.45.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

