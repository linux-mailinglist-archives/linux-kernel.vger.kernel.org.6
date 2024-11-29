Return-Path: <linux-kernel+bounces-422843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564E9D9EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0272B164C26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9625D1DF99F;
	Tue, 26 Nov 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3euBkT/9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E71DF274
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657009; cv=none; b=WPRZqbgLtBbuXlUORU2GnK8CbrUwYozm+VYxoewrcTDvZrg5cNOK3e65E6Udk8d2KVwiAiotVjHSHO7799taNau3hUeJJwlCZhpAxRr3oJOvaW3h0xye96etxYywZozmiNsOVzb8IZbhzfrYrLFZaRBONulaltU+lOBTf7TyQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657009; c=relaxed/simple;
	bh=v/GairsYwJ78tOGQPrHiE3P7/qShDg8uD4VwxNeY0XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3+nC3c9GqNxlGa7dVmDg86PUuMFcuszpU+3/875r0YLvDT1aVxP7fN/Aj6fPKLtiKX4na8Fh/EazzaIa+VMSxFSHVXlC/NmMct8Zm6qndMgI3euQOTaz+1s56gI8SJw1586CYlrM6XaWWiHLkiiO/JiK+iFyRUj+RYrDb5hxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3euBkT/9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fd6a0a9cso44542945ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732657007; x=1733261807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHRhjsfKN6Al5TNnmTyBOiKcGX/jb5roHjFGenSaZE0=;
        b=3euBkT/9yDCBQ4M6YgNbBkE/21YhGBRGwUwhyRU3mneFx4Df7yKDBv9M/Tv9WZUm8D
         9Bq0qaMfjyiwpgDjgLJMUMXQrc92r0y7lLlc34DpPY2BG88EaOcDMIxukR0VPuBvhtdW
         NbCsRDtXXTz8f7w7KBeG7L8a/kYIWoIBcB3mLl0bvybTO7GKXY0XudcxEH6oe2sTM2KK
         rCkMvcBAzsUdUonZ8EH/vXsu6Uqup8lO+7Fwqlw0Bf+iClzcusdThv5mMXac6PsJuoAu
         8m5GKCRyt68q45u4Rxl3VkhTO8U+Lg+JIPW6JMfzaBYLfsP94m/7ymOs8u85dafm/KLr
         1lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657007; x=1733261807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHRhjsfKN6Al5TNnmTyBOiKcGX/jb5roHjFGenSaZE0=;
        b=oO1BteEIsEWt9cA7ORP0QWdd1dWxtnpvmcyosGQMdtP2xt/6nBVwsue9Mt40h8Pq46
         USK2a7S+1bTHvTgnSeaBpLHjh3zXMQu0CXheKxbr65CoMFHc1e6KKlkvAH+SiMQbAnhH
         5tGKbydM5fR1fc/qAn9kQ/5EFwug0pD5sPxor585ublFMNDg+m97E/1D2j6tseQVYegG
         e7sV80/udKuBHZ7KPCsmYVaqTJ3/NPO9I6zHzi6jo9QPh7DSBD1dG/UjAhs8KOOWC9pO
         momZcFKRbygHIpa6i+Ywm1YIJt5xcY4/n0ikSc352y6VRIsk1e1bMEgnubF7xzUip+v1
         76FA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ox37Ft0Ncuee5ttuJM16C+EHo1VMXQ4mky3Nd7ZIgPvrvZ3jTQVvjxtMORYjZScMQgKQ7nOZmeP7gPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi28LD4wkHyCgB0s4Sq+uIfke0pD4dDGB8qIMsPYUCCa01ecW
	C7jOWg2XoEuHbDkkR3UTcAS3K6KjI9Cn6q0HKBCAHJl+amC8rPzzYXY3rJkOKIM=
X-Gm-Gg: ASbGnctnsbjsKxfUc/OsEGWCSfakXbmvQfZciecGh6lp+lMTg0lqAWI6Z278ltlSKkq
	1IHf2+zlT4uLDv0z94PtNQ2KhXN51ROI5S0XOcFzrLyCbwM0mvUWf4dtgPEm2B409W4CRMGoBP5
	MqTBLyGzszZ80qpUApZ8tAicfmYw5XEiloHQpy60ts4k2NgBA632LaVkqsOUJzPTdoEh98z5/5p
	PBvct/TZ8mYKcJt+TXVgHtRw1LzYmq+88JtL0voygzS
X-Google-Smtp-Source: AGHT+IE6PiHzCBpFxf6nqtggtGSAKLH3Svgn7LxrahHubJPvHJeZhuEaDwLks+UyVbr6RS0/jAAVqw==
X-Received: by 2002:a17:903:2441:b0:212:67a5:ab24 with SMTP id d9443c01a7336-21501e5c1ffmr6937425ad.41.1732657007184;
        Tue, 26 Nov 2024 13:36:47 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:15f:6df4:c303:cfc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc207bbsm89082475ad.228.2024.11.26.13.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:36:46 -0800 (PST)
Date: Tue, 26 Nov 2024 13:36:44 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools] tools riscv: Include fence.h from the
 same directory barrier.h lives
Message-ID: <Z0Y_bC42dufBNE4L@ghost>
References: <Z0Y8XQMBXT5JdOAG@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0Y8XQMBXT5JdOAG@x1>

On Tue, Nov 26, 2024 at 06:23:41PM -0300, Arnaldo Carvalho de Melo wrote:
> When cross building perf to riscv I noticed that it isn't finding the
> asm/fence.h file included from tools/arch/riscv/include/asm/barrier.h,
> since both live in the same directory, load it from there instead of
> from asm/fence.h, fixing the libbpf build in such environment:
> 
>   perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
>      1     4.32 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
>                        from mmap.c:7:
>       /git/perf-6.12.0-rc6/tools/include/asm/../../arch/riscv/include/asm/barrier.h:13:10: fatal error: asm/fence.h: No such file or directory
>          13 | #include <asm/fence.h>
>             |          ^~~~~~~~~~~~~
>       compilation terminated.
>   <SNIP other similar errors>
> 
> This probably should work in other systems where the right asm/fence.h
> is available, but in the above scenario, it fails. Probably we should
> fix the perf build system to find it in tools/arch/riscv/include/asm/,
> but this one-liner should be a stop gap solution till we get there.
> 
> Testing it:
> 
>   perfbuilder@number:~$ time dm ubuntu:22.04-x-riscv64
>      1    21.65 ubuntu:22.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0  flex 2.6.4
>   BUILD_TARBALL_HEAD=800d169e2d39e4e81ade326d73ae7c4343c12b45
>   $ git log --oneline -1 800d169e2d39e4e81ade326d73ae7c4343c12b45
>   800d169e2d39e4e8 tools riscv: Include fence.h from the same directory barrier.h lives
>   toolsbuilder@number:~/perf-6.12.0-rc6$ ls -la /tmp/build/perf/perf
>   -rwxr-xr-x. 1 toolsbuilder toolsbuilder 3278728 Nov 26 21:12 /tmp/build/perf/perf
>   toolsbuilder@number:~/perf-6.12.0-rc6$ file /tmp/build/perf/perf
>   /tmp/build/perf/perf: ELF 64-bit LSB pie executable, UCB RISC-V, RVC, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64-lp64d.so.1, BuildID[sha1]=9b77bbf51da74cee24c6d5fc5814343cc7e9a652, for GNU/Linux 4.15.0, with debug_info, not stripped
>   toolsbuilder@number:~/perf-6.12.0-rc6$
>   toolsbuilder@number:~/perf-6.12.0-rc6$ readelf -d /tmp/build/perf/perf | head
>   Dynamic section at offset 0x242db0 contains 33 entries:
>     Tag        Type                         Name/Value
>    0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]
>    0x0000000000000001 (NEEDED)             Shared library: [libz.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libelf.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libdw.so.1]
>    0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>    0x0000000000000001 (NEEDED)             Shared library: [ld-linux-riscv64-lp64d.so.1]
>    0x0000000000000020 (PREINIT_ARRAY)      0x238740
>   toolsbuilder@number:~/perf-6.12.0-rc6$
> 
> Fixes: 6d74d178fe6eaf61 ("tools: Add riscv barrier implementation")
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/arch/riscv/include/asm/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
> index 6997f197086ddf61..e78241632e2f1301 100644
> --- a/tools/arch/riscv/include/asm/barrier.h
> +++ b/tools/arch/riscv/include/asm/barrier.h
> @@ -10,7 +10,7 @@
>  #ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
>  #define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
>  
> -#include <asm/fence.h>
> +#include "fence.h"
>  #include <linux/compiler.h>
>  
>  /* These barriers need to enforce ordering on both devices and memory. */
> -- 
> 2.47.0
> 

We have been trying to get this resolved with a different patch [1], but
getting it picked up was painfully slow and it wasn't picked up into
6.12 for some reason... It is on master now, but it hasn't been
backported yet, I don't know why not. There was another fix here [2]
that is similar to what you have, but [1] was selected instead of it.

[1] https://lore.kernel.org/linux-riscv/172835823300.66789.3704854116445399222.git-patchwork-notify@kernel.org/
[2] https://lore.kernel.org/linux-riscv/mvm5xq44bqh.fsf@suse.de/

- Charlie


