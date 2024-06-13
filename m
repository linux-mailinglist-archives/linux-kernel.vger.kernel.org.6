Return-Path: <linux-kernel+bounces-212965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089CE906904
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC61C24054
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931B13E888;
	Thu, 13 Jun 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krNY+YJ+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40013E05B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271405; cv=none; b=Ech0AIpS0wdvafIwNmS0rrpRLeheQ6Jt5m8aI5aLBFSS+BeqfoWXg/5kSwcwaWtJLC9xuo2vTiN7VIe9AJ1bHK6W9/ForVtSk9dKELu4VOzmzgFWVQ6n5Vt3u6OhV89jyhzlVEYYGlAz+MbYKXuytCsCnTay8F7n2+0T92/lIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271405; c=relaxed/simple;
	bh=Mbt2MJaUYw327XHSsAVEuO4JEm/68rZ+VPjFztZeWMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyx0NHJmKI4t4XPIOC0lsc5mc63SfewFeAZrVNiqbMUVDSorauB53OVyOj2ze5gqbTpaotN/YdXobPn2VzMOx7UmYRpt2Xbsiff4L5gz4xjKUCyfhreW7Y3OEEFYvjT4GmkzUlr0qIT9znbIrlsq1C7SX5Z69LpW4nk+ECGFTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krNY+YJ+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso687220a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718271402; x=1718876202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O/LeU4pBiUv7PYYak4VEhNYanrT2MDN3opyXgU57NQ=;
        b=krNY+YJ+SrQm11DfZhEnUgrhW4nNyJyY35JNrNvX6Gi1M6TyRYohfiRfbiNWbNNQdZ
         q60nSmYs7G1BBq9Csbt/k7uPHRZMQH1yQMPThhLqhqo4Fn7IGRzb03dAD/3Xp7PV7LxT
         J0VLJEQ6NfdloMF0YdndLq0GCtdfSJkbSWdCKsXffyS1P9d5uT88A732UAQLAR87Fyi1
         ExQwCDcjagHKlE+2YeqK6hHZdJpnPSPyPFMXweG+88O688UWItmuqdilQ9WDH507j6Bn
         7ujMWO+YLF5ucxTvPB7/YvXzW1IwXgXrnymD0w+Hi71dGr7U0hwsR1qquDQBa4eHzygM
         R0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271402; x=1718876202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O/LeU4pBiUv7PYYak4VEhNYanrT2MDN3opyXgU57NQ=;
        b=Ra2qexW5SjL7XKNW9ckNABYx0isd1vMEl8TGgD/pod9c6KpP0cy8/ENfLIlUE/mcgA
         sb4r84ldlbGnyZRG6Ho81bS6zPKJd2n3tJZJEmyUjE/+/95JXIV30i7aG2mlLPjVrZcR
         bDMQiw8lGkADotAK3d4uRfnljkaNnpxdnKTyW5kigQVXAgfdUDdmnUxFYmRaYSyy/bBK
         ptqz3/Y8mO2MD+7t69Lv2Dd3jhDL6ZAZFzYlKW0HPIHnKHGR4nWzuXjYVCxVzYPkFukn
         THB3/TCO8oCxIzbnzzv9aWWiHbXOzwsxLJoROi+Baa50CR9GdT1VDRfohdHLGS1tc4uV
         eBbw==
X-Forwarded-Encrypted: i=1; AJvYcCUkWOKsAlcH2mFJ866MiV8HDHTyJvF7DSypizNEjsD+eKqZMNxGbQlfXdRqxLS7yny2Sf2qA5f7x0FhqLBXycqorivVRREzt5epGLAP
X-Gm-Message-State: AOJu0Yx0rr3K3FqMtCdEJ8zHgP2U2lNjciGI/O21WLdKVUSTc0DV/dQ/
	z5REKW+Hk0lP/MPHqIFgsDstoUbsC276Fp7aw/5FOM9zrxyM4GEN8K1jh9zP
X-Google-Smtp-Source: AGHT+IFVSidNdPqnYB3Bd3lzx1qoB1uqPpb395axC4//1R/X40d54Z/b09+pj29ITflN+cI1dYTwQA==
X-Received: by 2002:a50:954a:0:b0:57c:8262:6409 with SMTP id 4fb4d7f45d1cf-57ca9754f25mr2734513a12.14.1718271401448;
        Thu, 13 Jun 2024 02:36:41 -0700 (PDT)
Received: from gmail.com (1F2EF7F9.nat.pool.telekom.hu. [31.46.247.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9943sm685022a12.51.2024.06.13.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:36:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 13 Jun 2024 11:36:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 10/9] x86/fpu: Fix 'struct fpu' misalignment on 32-bit kernels
Message-ID: <Zmq9ppuIZJ9IMZDr@gmail.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
 <ZmlZiHVF8w09mExw@gmail.com>
 <20240612184148.GB23973@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612184148.GB23973@redhat.com>


* Oleg Nesterov <oleg@redhat.com> wrote:

> The patch below seems to fix the problem.
> 
> Again, the changes in fpu__init_system_early_generic() are not
> strictly needed to fix it, but I believe make sense anyway.
> 
> Oleg.
> 
> 
> diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
> index 4e8d37b5a90b..848ea79886ba 100644
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -71,16 +71,14 @@ static bool __init fpu__probe_without_cpuid(void)
>  	return fsw == 0 && (fcw & 0x103f) == 0x003f;
>  }
>  
> -static struct fpu x86_init_fpu __read_mostly;
> +static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
>  
>  static void __init fpu__init_system_early_generic(void)
>  {
> -	int this_cpu = smp_processor_id();
> -
>  	fpstate_reset(&x86_init_fpu);
>  	current->thread.fpu = &x86_init_fpu;
> -	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> -	x86_init_fpu.last_cpu = this_cpu;
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
> +	x86_init_fpu.last_cpu = -1;
>  
>  	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
>  	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 215a7380e41c..ec22b9bf27f5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1562,7 +1562,7 @@ struct task_struct {
>  	 * they are included in the randomized portion of task_struct.
>  	 */
>  	randomized_struct_fields_end
> -};
> +} __attribute__ ((aligned (64)));

Oh ... indeed, FPU context save area must be 64 bytes aligned!

On 64-bit kernels this was a given, accidentally, but on 32-bit kernels 
init_task was only 32-byte aligned:

  c22f04e0 D init_task

... which misaligned the struct fpu as well, I think. With your fix:

  c22f0500 D init_task

What happened is that due to my series 'struct task_struct' lost its 
64-byte alignment attribute, which broke the fpu struct allocation code on 
32-bit kernels and made the 64-bit one probably unrobust as well.

To add insult to injury, I was aware of the alignment requirement, and 
tried to cover it with an assert, but doubly mis-coded it:

+       BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);

Which is buggy:

 - As on 32-bit kernels CONFIG_X86_L1_CACHE_SHIFT=5, ie. 32 bytes ...

 - Nor does it really check the alignment of the FPU context save area 
   within struct fpu as it's allocated after task_struct ...

The interim patch below against the full WIP.x86/fpu series is what fixes 
Nathan's 32-bit testcase.

Further improvements:

 - The extra alignment attribute in <linux/sched.h> will affect other 
   architecture as well, although in practice the alignment of init_task is 
   not critical, and is very likely at least 32 bytes, probably more. 
   Still, it's a bit ugly in its current form.

 - Also, because this was pretty hard to debug, we should probably add an 
   alignment check to fpu__init_task_struct_size() where we allocate the 
   fpu context structure, and fix the buggy size-assert.

Thanks a lot for your help Oleg! I've added this tag of yours:

  Fixed-by: Oleg Nesterov <oleg@redhat.com>

... and would appreciate your Acked-by or Reviewed-by for the eventual 
final version of the series, but I don't insist. ;-)

	Ingo

=================>
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 53580e59e5db..16b6611634c3 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -71,15 +71,13 @@ static bool __init fpu__probe_without_cpuid(void)
 	return fsw == 0 && (fcw & 0x103f) == 0x003f;
 }
 
-static struct fpu x86_init_fpu __read_mostly;
+static struct fpu x86_init_fpu __attribute__ ((aligned (64))) __read_mostly;
 
 static void __init fpu__init_system_early_generic(void)
 {
-	int this_cpu = smp_processor_id();
-
 	fpstate_reset(&x86_init_fpu);
-	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
-	x86_init_fpu.last_cpu = this_cpu;
+	set_thread_flag(TIF_NEED_FPU_LOAD);
+	x86_init_fpu.last_cpu = -1;
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 215a7380e41c..ec22b9bf27f5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1562,7 +1562,7 @@ struct task_struct {
 	 * they are included in the randomized portion of task_struct.
 	 */
 	randomized_struct_fields_end
-};
+} __attribute__ ((aligned (64)));
 
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)

