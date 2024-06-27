Return-Path: <linux-kernel+bounces-231952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06E91A0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5971F21A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7E6D1B9;
	Thu, 27 Jun 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtYwAV4w"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3859164
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474480; cv=none; b=MJjMj7UZPJLHPVjc0+1Cauukui/glpYJS9H2q32hIKd2GYhUvLKPZgrHIQGV0IRVlG9K1COCxxoysDV7ri+xmZbQbEIvuDQv2QRAZsEzwTzkYkls9F67YFfNgnkrtJWwiUlx9XKIramWJG8m7uen0rXVtWKWQ+zhnD64aPzmb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474480; c=relaxed/simple;
	bh=sJSW65hxf170gFopGtuxc1EzaMM0gmFvA7ZMada+bkM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pUDqGo+HcjvXwPiD5sFCJbaS++i5KqTVvxl8QHp9ySFcOV46z8aBYeFvaGIH1DZ2kOwkkJ+MtZORiN+tnPoa9KI7gQ1G1/p1bOFTgb5Qy+YriPcFA/FE2GrYoy61N1jFEOAe7LQt/HJzYguy3sSWQX9YOt+tuAfWu12W8uCWq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtYwAV4w; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2c7dd4586afso5947331a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719474478; x=1720079278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1VniVF/Cma/D69twcQIBZj8lIAajcHSZqsODsZ7jwnI=;
        b=DtYwAV4wUKouqFscOJgOYuXW78VUHH3RzDg7PkhzqGEV94HnS14uv5SBZFAOLRK0ec
         BTyDoiF+jBQb56QUrBbe/HyLqhiYPS5lkqFSBvE0LTdPY7/b3kKQn5FYK2thYJxy/M1k
         Kgk53fOFcFzkf4EKTmBRZVPKfbxA2kbRTPfUMp1NbHVvSinHXVwDv1RGeqGLbRoKuCjO
         ZuYC2AhAW8Ii8UmiCbu7bIfmlXL9gsFcmKKNc+/ul9N1SWFW4gmsRoyD3obN88Zp9a+P
         rGdzpdNWB6qdyHOGj/VbVWcqg9a0Bq9OJEtdbW5+vKn0Wv0aXsxyfOwS7DBOZa9dY1Xb
         PQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474478; x=1720079278;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VniVF/Cma/D69twcQIBZj8lIAajcHSZqsODsZ7jwnI=;
        b=caUvJ93F/tf1LJI8N0wNhVZvD3w0daZzWPToirww/EBqpVA4mWejzrfDkTrPZRCMLk
         osSyKbAD2jZh6mGVRsp1GPxhDhL+SpqeE0CSuKpte6tNUZB9SnjMP6qy33sJmsMK2jAL
         orJKrXKS4/TCGobkE3qlW6MUL2b3ItxnujkVSqI2ISaUAJ4d0xhl7nemh5ctUXNaKO7C
         Ic5wIgScxhsl0ebhVire3VwS+xqVPr241mVAvV92JwO/BIvshs9+q1Y+0t55dCILntJb
         CwcUsLFXWELNAV6snh9eHB3+M5qIXZAgPjCN2sWSEwjZ3hWI1KheVqQG1QsE1VsSlLwM
         rU4A==
X-Forwarded-Encrypted: i=1; AJvYcCVkFK8+pN4kV0qXiE7rVPaugrGbdXnJ56Tw0Kmt5D/pDS+kQtTxFovZltpXzBga7Szl3tQ8nN5+QeHu6AKpDV//WR5jD6zf3kwwhccc
X-Gm-Message-State: AOJu0YwfQkg44UJvUfT/TdZWDLR50ZFN4xGYrnI2baSPx2YNT8V/xSrk
	vcIS+MPvOS6olk5MthSumsBVIrRWKTqU+8+ihIXXRgc5wJErSgE0
X-Google-Smtp-Source: AGHT+IEL1xLC2GJqJfnIsftcppBDozb/ub7R/JIjyrWfp+cD3gnjoeGw9JF3AhLkTejjcdKjubEaoA==
X-Received: by 2002:a17:90b:2382:b0:2c8:e1f6:7d84 with SMTP id 98e67ed59e1d1-2c8e1f67da9mr2696347a91.25.1719474478000;
        Thu, 27 Jun 2024 00:47:58 -0700 (PDT)
Received: from [127.0.0.1] ([45.62.172.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d81d2ae1sm2929963a91.50.2024.06.27.00.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:47:57 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
Date: Thu, 27 Jun 2024 15:47:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andreas Schwab <schwab@suse.de>, David Laight <David.Laight@ACULAB.COM>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 "Ivan A. Melnikov" <iv@altlinux.org>
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org>
Content-Language: en-GB-large
In-Reply-To: <20240627071422.GA2626@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-06-27 15:14, Dmitry V. Levin wrote:

> Hi,
> 
> On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
>> entry: Save a0 prior syscall_enter_from_user_mode()").
>>
>> After analysing code, we think that regs->a0 = -ENOSYS should only be
>> executed when syscall != -1. In __seccomp_filter, when seccomp rejected
>> this syscall with specified errno, they will set a0 to return number as
>> syscall ABI, and then return -1. This return number is finally pass as
>> return number of syscall_enter_from_user_mode, and then is compared with
>> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
>> condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
>> is always executed. It covered a0 set by seccomp, so we always get
>> ENOSYS when match seccomp RET_ERRNO rule.
>>
>> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
>> Reported-by: Felix Yan <felixonmars@archlinux.org>
>> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
>> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
>> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> Tested-by: Felix Yan <felixonmars@archlinux.org>
>> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> ---
>>
>> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> v3 -> v4: use long instead of ulong to reduce type cast and avoid
>>           implementation-defined behavior, and make the judgment of syscall
>>           invalid more explicit
>> v2 -> v3: use if-statement instead of set default value,
>>           clarify the type of syscall
>> v1 -> v2: added explanation on why always got ENOSYS
>>
>>  arch/riscv/kernel/traps.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d2..729f79c97e2bf 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>  {
>>  	if (user_mode(regs)) {
>> -		ulong syscall = regs->a7;
>> +		long syscall = regs->a7;
>>  
>>  		regs->epc += 4;
>>  		regs->orig_a0 = regs->a0;
>> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>  
>>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>>  
>> -		if (syscall < NR_syscalls)
>> +		if (syscall >= 0 && syscall < NR_syscalls)
>>  			syscall_handler(regs, syscall);
>> -		else
>> +		else if (syscall != -1)
>>  			regs->a0 = -ENOSYS;
>>  
>>  		syscall_exit_to_user_mode(regs);
> 
> Unfortunately, this change introduced a regression: it broke strace
> syscall tampering on riscv.  When the tracer changes syscall number to -1,
> the kernel fails to initialize a0 with -ENOSYS and subsequently fails to
> return the error code of the failed syscall to userspace.

In the patch v2, we actually do the right thing. But as Björn Töpel's
suggestion and we found cast long to ulong is implementation-defined
behavior in C, so we change it to current form. So revert this patch and
apply patch v2 should fix this issue. Patch v2 uses ths same way with
other architectures.

[1]: https://lore.kernel.org/all/20230718162940.226118-1-CoelacanthusHex@gmail.com/

> 
> I wish you were running strace test suite before changing this part of the
> kernel.  Now I'm going to apply a workaround [1] in strace, but please
> note that riscv seems to be the only linux architecture where such a
> workaround is currently required.
> 
> There was a similar kernel bug once on parisc, but it was fixed [2]
> several years ago by commit b7dc5a071ddf.
> 
> [1] https://github.com/strace/strace/commit/c3ae2b27732952663a3600269884e363cb77a024
> [2] https://git.kernel.org/torvalds/c/b7dc5a071ddf69c0350396b203cba32fe5bab510
> 
> 


