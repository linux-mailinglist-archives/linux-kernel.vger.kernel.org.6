Return-Path: <linux-kernel+bounces-398566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142A9BF2ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E53281FDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9E2040B7;
	Wed,  6 Nov 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdIpjHP8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B991DCB06
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909550; cv=none; b=iLbQGClk3bYjjnJNHgOrZvu3IpAb1VtsGhj0whQmT/OSJAHkoFlGAMR1DfzMdbCVwvnjdozS6B2D4aei8zfDbr2yknwabVF3OEIlpq2mQpCTxUz9Fk6p6VBaN2zWltBVf7EyqC5ncTHgstzczKY0eETeN1y/r/W5itzTry6VnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909550; c=relaxed/simple;
	bh=S+6j0e/Je7jCLayvyjzxx3aRIopaCyH2OeALP6BFQng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNfI/ehzuUKm3BmtmZp8xnUOzsu7A5D28kkXteUWH/rntVS6bzlJmBljtaBhNjNS069Cuu2PMHT3uytK2gaSnRu8uIhvEOQRWPi+siSsCB+fLfizsyQNRGFlPM9Ed28D49PjvdD2XoSUMNVkbtAKg2mPm4rwrHubNJ11ocOFx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdIpjHP8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720be27db74so904030b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730909548; x=1731514348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYaP27BPhUyEydSF0IDN+ySR2iGr3Su9AB65thly3D8=;
        b=FdIpjHP8vEv95b7aLTd9nSZqUvgi1mjSDXBNvMjLzqYp1gooqNO2yIMqZNROGrqD1w
         5bdX+9u7TSVCDpSyD4BzAD+1K1VZ9I96Gyr59Ro2Eu5SGTnbP4tkybczt/QPJ1njyzZC
         Dqg4/eb5eJcB6u5cAQTOxmG65QqEVQT/b+Z8zRNf/v/TDINvt4baDYytTfKZ8eHys/Uh
         /nCCzO8FPsmHS/92EwDYZM00+p3fTRhXTV5fUVT/lR8lc+oqxF4o3un29fGni7zvEGB6
         BTmixnTSMYyGXwkZavXlfQTihgSdM7faVmWa8L7J3081f8a2esI0fpdoqTIyiFvl45EM
         YXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909548; x=1731514348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYaP27BPhUyEydSF0IDN+ySR2iGr3Su9AB65thly3D8=;
        b=E4ku/V53tzAoujtcxx0uQKAiBWgC+S0AFo3SgaFZ2YURz76GcoHauBNo8CndxqsRlz
         WwU3cEl2EeDS70WdhE9hOb8/YhTwWYhonzPHbON4Y9jPCYszhRzqAEi63Skv3WZKJYmt
         1NLuORHEbmyBkdVrfrUuNh1P4DmWO9Jm1XDKM5kAq9PjT+bB0KkjakJcQ4OOGaKVGinJ
         r47btFjv/PCdeTbMx/r7gCS6bdqWjEqMOx/U0zKjSTSU/a8VlJ3pVc8sRQGCiGX2EQV+
         2/4hcvge+p98rdSBg0Wna192e5EqqP+bxWq76DGOkqYO2f1VOyDd8vRlvZgftDaSdD84
         cabg==
X-Forwarded-Encrypted: i=1; AJvYcCUXVuK0aRpXutASxSAX4okeTsaslFZ2FhxRVDsPGR+qtQeLUYuq1pPedUERF32wHflN1dWQ0IaivjgpvRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNuvZmNycFdSwDHpwAZ6bideuAj0ts6nZvGQvPHp72u92o8IP
	kck1/pmO3Qlk68vjNoDay2/SYtgMCq/GCAySE9fN9coe+XTGP0xP
X-Google-Smtp-Source: AGHT+IGdbktmo4RmwOx60EB12b0bGn9SSTGFLek5URc5mLfu2TZT2EM/ysKEAtJNdQVd93TyPd2lng==
X-Received: by 2002:a05:6a00:428a:b0:71e:5252:2412 with SMTP id d2e1a72fcca58-723f79863f5mr5131081b3a.2.1730909547999;
        Wed, 06 Nov 2024 08:12:27 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c47f1sm12041992b3a.107.2024.11.06.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:12:27 -0800 (PST)
Date: Wed, 6 Nov 2024 08:12:25 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: briannorris@chromium.org, kees@kernel.org, nathan@kernel.org,
	linux-kernel@vger.kernel.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [bug report] cpumask: gcc 13.x emits compilation error on PowerPC
Message-ID: <ZyuVaXw8zEpF-935@yury-ThinkPad>
References: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cbbd751-8332-4ab2-afa7-8c353834772a@linux.ibm.com>

On Wed, Nov 06, 2024 at 06:32:23PM +0530, Nilay Shroff wrote:
> Hi,
> 
> Of late, I've been encountering the following compilation error while using GCC 13.x and latest upstream code:
> 
> Compilation error:
> ==================
>   <snip>
>   CC      kernel/padata.o
> In file included from ./include/linux/string.h:390,
>                  from ./arch/powerpc/include/asm/paca.h:16,
>                  from ./arch/powerpc/include/asm/current.h:13,
>                  from ./include/linux/thread_info.h:23,
>                  from ./include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ./include/linux/preempt.h:79,
>                  from ./include/linux/spinlock.h:56,
>                  from ./include/linux/swait.h:7,
>                  from ./include/linux/completion.h:12,
>                  from kernel/padata.c:14:
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> In function ‘bitmap_copy’,
>     inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
>     inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
>   633 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
>   259 |                 memcpy(dst, src, len);
>       |                 ^~~~~~
> kernel/padata.c: In function ‘__padata_set_cpumasks’:
> kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
>   713 |                                  cpumask_var_t pcpumask,
>       |                                  ~~~~~~~~~~~~~~^~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:229: kernel/padata.o] Error 1
> make[2]: *** [scripts/Makefile.build:478: kernel] Error 2
> make[1]: *** [/root/linux/Makefile:1936: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> # gcc --version 
> gcc (GCC) 13.2.1 20231205 (Red Hat 13.2.1-6)
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> Note:
> =====
> I don't encounter above error using GCC 11.x and 12.x on PowerPC.
> Moreover, I don't encounter above error using GCC 11.x or 12.x or 13.x on x86_64.
> 
> Git bisect:
> ===========
> The git bisect points to the following commit causing the above compilation error:
> 
> commit ab6b1010dab68f6d4bf063517db4ce2d63554bc6 (HEAD)
> Author: Brian Norris <briannorris@chromium.org>
> Date:   Thu Jul 18 17:50:39 2024 -0700
> 
>     cpumask: Switch from inline to __always_inline
>     
>     On recent (v6.6+) builds with Clang (based on Clang 18.0.0) and certain
>     configurations [0], I'm finding that (lack of) inlining decisions may
>     lead to section mismatch warnings like the following:
>     
>       WARNING: modpost: vmlinux.o: section mismatch in reference:
>       cpumask_andnot (section: .text) ->
>       cpuhp_bringup_cpus_parallel.tmp_mask (section: .init.data) ERROR:
>       modpost: Section mismatches detected.
>     
>     or more confusingly:
>     
>       WARNING: modpost: vmlinux: section mismatch in reference:
>       cpumask_andnot+0x5f (section: .text) -> efi_systab_phys (section:
>       .init.data)
>     
>     The first warning makes a little sense, because
>     cpuhp_bringup_cpus_parallel() (an __init function) calls
>     cpumask_andnot() on tmp_mask (an __initdata symbol). If the compiler
>     doesn't inline cpumask_andnot(), this may appear like a mismatch.
>     
>     The second warning makes less sense, but might be because efi_systab_phys
>     and cpuhp_bringup_cpus_parallel.tmp_mask are laid out near each other,
>     and the latter isn't a proper C symbol definition.
>     
>     In any case, it seems a reasonable solution to suggest more strongly to
>     the compiler that these cpumask macros *must* be inlined, as 'inline' is
>     just a recommendation.
>     
>     This change has been previously proposed in the past as:
>       Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
>       https://lore.kernel.org/all/20221027043810.350460-2-yury.norov@gmail.com/
>     
>     But the change has been split up, to separately justify the cpumask
>     changes (which drive my work) and the bitmap/const optimizations (that
>     Yury separately proposed for other reasons). This ends up as somewhere
>     between a "rebase" and "rewrite" -- I had to rewrite most of the patch.
>     
>     According to bloat-o-meter, vmlinux decreases minimally in size (-0.00%
>     to -0.01%, depending on the version of GCC or Clang and .config in
>     question) with this series of changes:
>     
>     gcc 13.2.0, x86_64_defconfig
>     -3005 bytes, Before=21944501, After=21941496, chg -0.01%
>     
>     clang 16.0.6, x86_64_defconfig
>     -105 bytes, Before=22571692, After=22571587, chg -0.00%
>     
>     gcc 9.5.0, x86_64_defconfig
>     -1771 bytes, Before=21557598, After=21555827, chg -0.01%
>     
>     clang 18.0_pre516547 (ChromiumOS toolchain), x86_64_defconfig
>     -191 bytes, Before=22615339, After=22615148, chg -0.00%
>     
>     clang 18.0_pre516547 (ChromiumOS toolchain), based on ChromiumOS config + gcov
>     -979 bytes, Before=76294783, After=76293804, chg -0.00%
>     
>     [0] CONFIG_HOTPLUG_PARALLEL=y ('select'ed for x86 as of [1]) and
>         CONFIG_GCOV_PROFILE_ALL.
>     
>     [1] commit 0c7ffa32dbd6 ("x86/smpboot/64: Implement
>         arch_cpuhp_init_parallel_bringup() and enable it")
>     
>     Co-developed-by: Brian Norris <briannorris@chromium.org>
>     Signed-off-by: Brian Norris <briannorris@chromium.org>
>     Reviewed-by: Kees Cook <kees@kernel.org>
>     Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>     Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> So it appears that changing cpumask_copy() from inline to __always_inline causing the 
> above error using Gcc 13.x. I am not gcc expert but it seems some issue with GCC 13.x?
> 
> I tried the following patch which helps fix the above error but I'm not sure if this
> is the proper fix or do we need to fix it differently.
> 
> Patch:
> ======
> diff --git a/kernel/padata.c b/kernel/padata.c
> index d899f34558af..86aad2f71890 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -710,8 +710,8 @@ static bool padata_validate_cpumask(struct padata_instance *pinst,
>  }
>  
>  static int __padata_set_cpumasks(struct padata_instance *pinst,
> -                                cpumask_var_t pcpumask,
> -                                cpumask_var_t cbcpumask)
> +                                struct cpumask *pcpumask,
> +                                struct cpumask *cbcpumask)
>  {
>         int valid;
>         int err;
 
This only works if CONFIG_CPUMASK_OFFSTACK=y. Otherwise, cpumask_var_t
is declared as:

typedef struct cpumask cpumask_var_t[1];

and your hack wouldn't work. You can read a comment starting with "Oh, the
wicked games we play!" in include/linux/cpumask_types.h for details. :)
 
> Please let me know if you need any further information.

config usually helps. Is it defconfig? What instrumentation is
enabled? Can you try the same without *ASAN and friends?

Thanks,
Yury

