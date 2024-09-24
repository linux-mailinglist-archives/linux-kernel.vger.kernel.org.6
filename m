Return-Path: <linux-kernel+bounces-337319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53373984899
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E030FB2239D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E817579;
	Tue, 24 Sep 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MPqDqZCZ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C99171CD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191587; cv=none; b=fdaVmPphYM2TOYErg2D6S67gmaAY5EEj23PiuHAkG56zw9nypsyt7sxilb7nYEVeQmk//YpunZJeGOECuL83UGbPVl1/7dJdi9jXGxWJSaFXLRxlBK/DFEj4Ye6n5IFZijfDSrtGQBEddu0jhh9eKXr+yEUYWMvQOZi41QrHPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191587; c=relaxed/simple;
	bh=jrm29iJlYeMvwpjcXbD+68qbylDtLg6NniieObaX9jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB8tELXEkLQq9UE9zQz22aftgmU5k4F4JzrlZHm/SW8eKQFfeht7H0y7+kMVG0BcaZmw98TNkYADITzuaxzoQNDvSXaENINoud+btWBNiUgRZ61r+/phxJ+I1j0L14Gig5BOanyXh3hcpHLSAp9jH0Xw4gZyw9FibDc2S/rt4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MPqDqZCZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa086b077so737504966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727191584; x=1727796384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncpPQi0GfsQJ/MBJNfkrlPviJLNDUK8EobuIbw3pbzs=;
        b=MPqDqZCZwroeNCrD5lmjUDouV67WnXj9aqO7vvhKmQpK9QSMadaSyUXOs0lF8Jm8UU
         nI6YXxNC9kietIBSTaMdFuIcmc3dKATQodqTAT6ws74ky4hcTtUZYIPZHIB1E+pmy4Wk
         1B9DhLA0yISBkFO8GWQNMObSpg61RTFWBTD5HW81Sv9WqvQ0T8uQ1db0Ej5Pc2MlYAa2
         NOZRhCiz3/e6rksnVClE+FTCQKe07KTCmcO/mbKlLey1KrAh3acTfAFIWLWsB/qqa3Nu
         +CiIheUgLjL4l/AP85yZ7XwAwUxgcqe9kLCC9GQasGI9QOkCeIm71bg7XHm8Ng3cerjI
         I3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191584; x=1727796384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncpPQi0GfsQJ/MBJNfkrlPviJLNDUK8EobuIbw3pbzs=;
        b=ic0egSnC3YwyHdYQicG9L0HI3A6AiiTkun4XViEcc/58mPG6+T0BP5cxZnCeBvf0id
         udN+p/7yg21E3ZBWonwVp7zZBIA38lRXvSKkdZYGlptYH99G7PCd6Rs4oczpNq46NizD
         e8ghSLj9krxr8tVbOoyQyPIdkbJceRWTpdfQ6RwvETL0cWLKZQ3oBzVjNzQWX2Ej+ZsM
         aPK18Wp9rWD8K9ogsgR42NyFfy8aSzUE8XDosZL0XFkh63F+jf46PeeXE2ixQaBTfBQV
         /HKrzxN+HZilNPcB+7bDdGUzQcPaKiZUlgYvBCRug8oDBYLEezxCaMfmVsnYGMlZz7w8
         kzEg==
X-Forwarded-Encrypted: i=1; AJvYcCWCY05hbU72GItCCIOH4OrA7uMRm9ZNRN4ReQ5seGX44rvcx5AO6rJ56tb4FQPq/ukjHcPbF9W8JpXXd8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHeWJ9iDFqzdfgO3E9431E+vvcu7EadrngD20HR+5Xmho0DBM
	wqXg+4uE9AdN6p9xyhdSZoSIAY6GcDUmUTz70VTiLXexF3oFs6hfFsyVvj+5dd4=
X-Google-Smtp-Source: AGHT+IF1xyHbX88bwTSe6sWCS7atLN8y4aZbve6DCWxrcqs48Q0A0D6t/d/gJw3jgD0Ngjf9HsPanQ==
X-Received: by 2002:a17:906:bc12:b0:a8f:f799:e7d1 with SMTP id a640c23a62f3a-a90d503430cmr1421808566b.38.1727191583676;
        Tue, 24 Sep 2024 08:26:23 -0700 (PDT)
Received: from ghost ([185.30.83.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f0ba1sm97280966b.143.2024.09.24.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:26:22 -0700 (PDT)
Date: Tue, 24 Sep 2024 17:26:19 +0200
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Howard Chu <howardchu95@gmail.com>,
	David Abdurachmanov <davidlt@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf syscalltbl: Add syscalltbl__id_at_idx() with no
 syscall table support
Message-ID: <ZvLaGy7jRa9Q/5fQ@ghost>
References: <20240830-perf_syscalltbl_fix-v1-1-e2ff61ee5e8e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-perf_syscalltbl_fix-v1-1-e2ff61ee5e8e@rivosinc.com>

On Fri, Aug 30, 2024 at 09:30:50PM -0700, Charlie Jenkins wrote:
> When HAVE_SYSCALL_TABLE_SUPPORT is not defined, neither is
> syscalltbl__id_at_idx(). However, this function is expected to be
> defined when HAVE_BPF_SKEL is defined.
> 
> Return -1 from syscalltbl__id_at_idx() to match the other functions when
> HAVE_SYSCALL_TABLE_SUPPORT is not defined.
> 
> Without this, compiling perf on riscv when libtraceevents, libelf, and
> clang are available will cause the functions trying to call
> syscalltbl__id_at_idx() to be compiled. This results in the following
> error:
> 
> /usr/bin/ld: perf-in.o: in function `.L0 ':
> builtin-trace.c:(.text+0x60b14): undefined reference to `syscalltbl__id_at_idx'
> /usr/bin/ld: builtin-trace.c:(.text+0x60c6c): undefined reference to `syscalltbl__id_at_idx'
> /usr/bin/ld: perf-in.o: in function `.L2564':
> builtin-trace.c:(.text+0x60cb6): undefined reference to `syscalltbl__id_at_idx'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile.perf:793: perf] Error 1
> make[1]: *** [Makefile.perf:290: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/src/linux-6.11-rc5/tools/perf'
> 
> This patch resolves this issue for all architectures which do not define
> HAVE_SYSCALL_TABLE_SUPPORT.
> 
> $ ./perf trace -e syscalls:sys_enter_mmap --max-events=1 ls
> 0.000 ls/287 syscalls:sys_enter_mmap(__syscall_nr: 222, len: 9939, prot: READ, flags: PRIVATE, fd: 3)
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reported-by: David Abdurachmanov <davidlt@rivosinc.com>
> Suggested-by: David Abdurachmanov <davidlt@rivosinc.com>
> Fixes: 7a2fb5619cc1 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
> ---
>  tools/perf/util/syscalltbl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 0dd26b991b3f..12654460428f 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -188,4 +188,9 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
>  {
>  	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
>  }
> +
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl __always_unused, int idx __always_unused)
> +{
> +	return -1;
> +}
>  #endif /* HAVE_SYSCALL_TABLE_SUPPORT */
> 
> ---
> base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
> change-id: 20240830-perf_syscalltbl_fix-4f586221795e
> -- 
> - Charlie
> 

Can this please be picked up? Compilation on riscv (along with any of
the other architectures that don't have syscall table support) is
broken. The long term solution is to add support for the syscall table
on riscv. I will send out a patch for that, but in the meantime it would
be great to have this in the tree.

- Charlie


