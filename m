Return-Path: <linux-kernel+bounces-190466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1128CFEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3738F1C217C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34613B5A4;
	Mon, 27 May 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bk3cmtNh"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE772CCD0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808563; cv=none; b=AyEZFgHkNaBUH+ySsdTEKxMVOZSS6KhGUBWRc+sat87CdGrvyQtYYS0UmldmhNMi9yDJVVIKLV/EOg/1fhm0Z0JXaQC+YKj0dZRVSqvV6UZC8oIVF08XqNd8YQpRv2JL4tLz1tTCmwmrF0t6kjkyv4OLk1A776gm9hrHEGOUBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808563; c=relaxed/simple;
	bh=Not5pCCjEau8XHdG6uS33ofoZFsQxMHw9AycAg5bheM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4J3gAWEiZ1dYxoAHG53jeoF8jt1CRWx9ItqotllnMi+ilNEL1QE5tx7dvJ5EP0WVJyueNPM3FEKq1AbBj34JYZBARcagZSj/mrqqXgfCBbAz11RlPHnwLB8vjmccNGZ3Y1eL/Mn97OGBzO+FkeKkBdxps+ckwDuLO3jnM0UyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bk3cmtNh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so3167096f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716808560; x=1717413360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMexEptPfSGDJVxMIGryhOEGijsTTv6Ro7p77t6MOQQ=;
        b=Bk3cmtNhvLwktVowtvH22imzMPD8SRv7ZUVHc52G1QbZr+mpa/Z016eBpLKm7TgKgA
         gGhgnMG1JjwEAXHy5bH4z8OkUjqquICGvwOlzY/0E4pFHgjcI5b0kqvA3oBMlTfL79RQ
         dlfEP1dM0z7nDq9ST8ZnYYkCG4m/3o5K7r4xubawRr+HHQsOcYjyArDhqRtFmoh200/r
         EtzWVlejH2jcUpkJVsylgiBadUUR1z9vu4gvTbiaXVi4BD570MVGZAxIHizbrIyWQErD
         47aX3uDHx/QYSir0GsZSpWjuCioLXLoi6nmkhY6WEY8CnEMQLUJyT7k0ZQfBL9ETyb8V
         CiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808560; x=1717413360;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMexEptPfSGDJVxMIGryhOEGijsTTv6Ro7p77t6MOQQ=;
        b=qq7IMK2t2RtCPpkxicbOJti99ZyQ08IAi8+/7LTwQxguwL78NHXqeL4TGp//GYhYVk
         ewu02rRba2hqAE22La10McmoWFcUkxsGQmcJpphZanb7JXRpEXtrFsQ1SHSRzcfOI2iz
         B7QIpgZlWQPKEyKnwDbYFLVLC8Yoc1E87Xw5y7cH/KVRDCxZro7/V4BxP0e3+jhoyeAq
         UW4FTmocojqOcO3+qnW4/OogRqbDSXTf//KT64SvG1w+nPdbmwf/cmY6v9u+gWNcZA2m
         HSmq4/c1vtGBDYQmBLoNNtLQoG1hH3Z9bwCr0lOzGPeJmhmd7P/OUA8psDi1Wm914xMR
         TmvQ==
X-Gm-Message-State: AOJu0Yyqfj+BW2XNLw3tJOSFpDyb3QaRMwPCATm1Nwc+avjpPsD69GDP
	MwhwLU/m8vAFOzFdBV0BsspY8/tUh0lVdQ+1vd7kblxnejsLQ/SjFmpEOMdOhCw=
X-Google-Smtp-Source: AGHT+IFA+HZ7ExsGyMuThHmw8iCR8SzRpKmrAB3+4Fk+tDMUdAbjEna62bP/XtsJzFOuNm6uViVNgw==
X-Received: by 2002:adf:dd89:0:b0:354:c483:a469 with SMTP id ffacd0b85a97d-35526d68f7emr5750607f8f.1.1716808559643;
        Mon, 27 May 2024 04:15:59 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7315:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090d1bsm8705866f8f.60.2024.05.27.04.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:15:59 -0700 (PDT)
Message-ID: <b77e5491-77ec-4a4f-8ea9-4842b6923bfa@suse.com>
Date: Mon, 27 May 2024 14:15:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7.05.24 г. 8:30 ч., Josh Poimboeuf wrote:
> The direct-call syscall dispatch function doesn't know that the exit()
> and exit_group() syscall handlers don't return, so the call sites aren't
> optimized accordingly.
> 
> Fix that by marking those exit syscall declarations __noreturn.
> 
> Fixes the following warnings:
> 
>    vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
>    vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> 
> Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/entry/syscall_32.c            | 10 ++++++----
>   arch/x86/entry/syscall_64.c            |  9 ++++++---
>   arch/x86/entry/syscall_x32.c           |  7 +++++--
>   arch/x86/entry/syscalls/syscall_32.tbl |  6 +++---
>   arch/x86/entry/syscalls/syscall_64.tbl |  6 +++---
>   arch/x86/um/sys_call_table_32.c        | 10 ++++++----
>   arch/x86/um/sys_call_table_64.c        | 11 +++++++----
>   scripts/syscalltbl.sh                  | 18 ++++++++++++++++--
>   tools/objtool/noreturns.h              |  4 ++++
>   9 files changed, 56 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index c2235bae17ef..8cc9950d7104 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -14,9 +14,12 @@
>   #endif
>   
>   #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> -
> +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
>   #include <asm/syscalls_32.h>
> -#undef __SYSCALL
> +#undef  __SYSCALL
> +
> +#undef  __SYSCALL_NORETURN
> +#define __SYSCALL_NORETURN __SYSCALL
>   
>   /*
>    * The sys_call_table[] is no longer used for system calls, but
> @@ -28,11 +31,10 @@
>   const sys_call_ptr_t sys_call_table[] = {
>   #include <asm/syscalls_32.h>
>   };
> -#undef __SYSCALL
> +#undef  __SYSCALL

nit: Am I blind or all the __SYSCALL lines have an extra whitespace?

<snip>

