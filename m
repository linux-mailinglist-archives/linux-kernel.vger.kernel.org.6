Return-Path: <linux-kernel+bounces-339958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D400986CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FC61F26F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC6188A32;
	Thu, 26 Sep 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnVWkm9g"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0918BC11
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332674; cv=none; b=gUVhCOcRq2u1AwLcA3mRdij48iLtoK6b8Ph7j0RBFTiJZl6qFr+iD5mgf3OtmqMp3tSkfhU/Y7a6VgExM6KYU6jM/7BYuHAyo/FJAJsaISNt+H+StGf1/+QzxUkNF4lVknhL0qPmvD6Zu6ePZs2LsR1qkjmnZJHnAjcEz+8S8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332674; c=relaxed/simple;
	bh=5AWPtxi4oC9sOj/zpk0Fq5XzwWirT/NTtETMLQOzXKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o53OWxGq/5+8Dem/7IlZsym80wBmYZIpFVkvEEX6lqzDcPnELuP0QWy5qnZXEl7T7AFjBiu/GwVGRmnW4yfkctNnotS/+hXBVBJuZ7qx5W/K5UWcTqtXfDMHKGDGZ1H9cDehuNWR2eRZs3ZWAQ15XQ8erIYogJISsTmZONRaJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnVWkm9g; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f762de00fbso7033721fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727332669; x=1727937469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RalEU07RSraN17vIQfT7Cy8CVyW/tem5p4MQ3xQOm68=;
        b=hnVWkm9gDNdL9VPD9kOpj29qKwoP7mkFYJukUGURU2UkZ+Tam1ty1l9qpdC1R4chtC
         s5YEveV9i6R621y7ROBddjYW8chk8bFDSHt0osFFGcsUlh84ALUlYV1OLlYRuyRDywWN
         R8wsfmhVPSHLsX40aRONNq6zP5biMBrqt/67tgeli6RQDND+j8Bs+KyZ7ex/zQOuUuHy
         y0dN/OncnKEh/YDPeDS/BmOdegUGhQxD9jxXvI+IwjxHZ21uvicQ7bllGD2j2kRwTORh
         27i4IOcMWh1DWWF9hjXFrHEhdzHVabC+0DzJN52V4aBu9eG63gyRVRleTy5dEn2C4y10
         nt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727332669; x=1727937469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RalEU07RSraN17vIQfT7Cy8CVyW/tem5p4MQ3xQOm68=;
        b=le1F+GHxg9UijpWm6ANCbfZVVKrNgmW0TXrTbTz/espAZ1zMIw+uj8N4xE989gJ6YO
         OZws4lOG+Cq9rtLHzsGFl+6Le696N+NstncjxNJ/wfe5Exl6gMKS2tBQGorsIS7YkLiu
         rYk2jQ6qyJnj7v/oeNeAV2+XG4UllbE7KjrcmdBfO647GcL410ZFMyF/R6pekWrV8Vbk
         xMNTlX/KwGsIIl0ibL05RcabxcE8eTh9kS4T17xMK+hiC9STEJ4TVLuqsSRKlmMqYaJk
         y31GLhCq2RXhVytO1huZfFymx4YLxarpiDrRZY43T7BN9IQ3HuTrR3vNyG0gDxguzaAR
         HYyg==
X-Forwarded-Encrypted: i=1; AJvYcCUYb8Iqct2dBxSwYy+GzqdX+4hHPGQ2k39XxhG1FbnFdzw13Pg11KRbYobj/4iSYE76ovVaLc2qZo9+fis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEd69cWt4VO5mAlR6cvt0XH8kqUH/lH8wF3PihAf7Bw1SMVOK
	1hTLkltd7gkCfNUFXP1iskPcC1JxZPloCGfaUECGcjKZEgA2Ps4foHFenEo5hC5hYyy06SQdZef
	fri9zLuriaHreNFnB5Z3SndwANk3ndkxrvfxs
X-Google-Smtp-Source: AGHT+IFNZF61dDQVzi7bPFm2cnTkoxSVNrWP+Qk9y+RV2+Ftn5RvoKANwp/vvmBWL1P8MHxHjsWYbKfvzgrmgorEIfo=
X-Received: by 2002:a05:651c:1543:b0:2f7:4e8c:9c11 with SMTP id
 38308e7fff4ca-2f914cacd98mr30565231fa.1.1727332668509; Wed, 25 Sep 2024
 23:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409242144.863b2b22-oliver.sang@intel.com>
In-Reply-To: <202409242144.863b2b22-oliver.sang@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Sep 2024 08:37:32 +0200
Message-ID: <CACT4Y+aLMmCvChrrqO34neheMT3Ntd-n0xw1cDY5_0WWvzJvDw@mail.gmail.com>
Subject: Re: [linus:master] [kcov] 6cd0dd934b: BUG:TASK_stack_guard_page_was_hit_at#(stack_is#..#)
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 15:45, kernel test robot <oliver.sang@intel.com> wrote:
>
> Hello,
>
> kernel test robot noticed "BUG:TASK_stack_guard_page_was_hit_at#(stack_is#..#)" on:
>
> commit: 6cd0dd934b03d4ee4094ac474108723e2f2ed7d6 ("kcov: Add interrupt handling self test")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      de5cb0dcb74c294ec527eddfe5094acfdb21ff21]
> [test failed on linux-next/master ef545bc03a65438cabe87beb1b9a15b0ffcb6ace]
>
> in testcase: trinity
> version: trinity-static-x86_64-x86_64-1c734c75-1_2020-01-06
> with following parameters:
>
>         runtime: 300s
>         group: group-02
>         nr_groups: 5
>
>
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-------------------------------------------------------+------------+------------+
> |                                                       | 477d81a1c4 | 6cd0dd934b |
> +-------------------------------------------------------+------------+------------+
> | BUG:TASK_stack_guard_page_was_hit_at#(stack_is#..#)   | 0          | 18         |
> | Oops:stack_guard_page:#[##]PREEMPT_KASAN              | 0          | 18         |
> | RIP:error_entry                                       | 0          | 18         |
> +-------------------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409242144.863b2b22-oliver.sang@intel.com
>
>
> [   16.984454][    C0] BUG: TASK stack guard page was hit at ffffc90000017ff8 (stack is ffffc90000018000..ffffc90000020000)
> [   16.984489][    C0] Oops: stack guard page: 0000 [#1] PREEMPT KASAN
> [   16.984510][    C0] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.11.0-rc2-00002-g6cd0dd934b03 #1 4a678012cbfb14407d2e0b76817d9700747886d7
> [   16.984535][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 16.984547][ C0] RIP: 0010:error_entry (arch/x86/entry/entry_64.S:1007)
> [ 16.984604][ C0] Code: 0f 01 f8 e9 c2 fe ff ff 0f 1f 40 00 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <41> 57 56 31 f6 31 d2 31 c9 45 31 c0 45 31 c9 45 31 d2 45 31 db 31
> All code
> ========
>    0:   0f 01 f8                swapgs
>    3:   e9 c2 fe ff ff          jmpq   0xfffffffffffffeca
>    8:   0f 1f 40 00             nopl   0x0(%rax)
>    c:   56                      push   %rsi
>    d:   48 8b 74 24 08          mov    0x8(%rsp),%rsi
>   12:   48 89 7c 24 08          mov    %rdi,0x8(%rsp)
>   17:   52                      push   %rdx
>   18:   51                      push   %rcx
>   19:   50                      push   %rax
>   1a:   41 50                   push   %r8
>   1c:   41 51                   push   %r9
>   1e:   41 52                   push   %r10
>   20:   41 53                   push   %r11
>   22:   53                      push   %rbx
>   23:   55                      push   %rbp
>   24:   41 54                   push   %r12
>   26:   41 55                   push   %r13
>   28:   41 56                   push   %r14
>   2a:*  41 57                   push   %r15             <-- trapping instruction
>   2c:   56                      push   %rsi
>   2d:   31 f6                   xor    %esi,%esi
>   2f:   31 d2                   xor    %edx,%edx
>   31:   31 c9                   xor    %ecx,%ecx
>   33:   45 31 c0                xor    %r8d,%r8d
>   36:   45 31 c9                xor    %r9d,%r9d
>   39:   45 31 d2                xor    %r10d,%r10d
>   3c:   45 31 db                xor    %r11d,%r11d
>   3f:   31                      .byte 0x31
>
> Code starting with the faulting instruction
> ===========================================
>    0:   41 57                   push   %r15
>    2:   56                      push   %rsi
>    3:   31 f6                   xor    %esi,%esi
>    5:   31 d2                   xor    %edx,%edx
>    7:   31 c9                   xor    %ecx,%ecx
>    9:   45 31 c0                xor    %r8d,%r8d
>    c:   45 31 c9                xor    %r9d,%r9d
>    f:   45 31 d2                xor    %r10d,%r10d
>   12:   45 31 db                xor    %r11d,%r11d
>   15:   31                      .byte 0x31
> [   16.984624][    C0] RSP: 0000:ffffc90000018000 EFLAGS: 00010046
> [   16.984642][    C0] RAX: 0000000000000002 RBX: ffffc900000180d8 RCX: 0000000000000000
> [   16.984657][    C0] RDX: 0000000000000000 RSI: ffffffff86400af9 RDI: 0000000000000000
> [   16.984671][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   16.984683][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   16.984697][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   16.984710][    C0] FS:  0000000000000000(0000) GS:ffffffff88355000(0000) knlGS:0000000000000000
> [   16.984733][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   16.984749][    C0] CR2: ffffc90000017ff8 CR3: 0000000008307000 CR4: 00000000000406b0
> [   16.984765][    C0] Call Trace:
> [   16.984775][    C0]  <#DF>
> [ 16.984785][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479)
> [ 16.984815][ C0] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
> [ 16.984843][ C0] ? handle_stack_overflow (arch/x86/kernel/traps.c:329)
> [ 16.984865][ C0] ? get_stack_info_noinstr (arch/x86/kernel/dumpstack_64.c:173)
> [ 16.984899][ C0] ? exc_double_fault (arch/x86/kernel/traps.c:380)
> [ 16.984931][ C0] ? asm_exc_double_fault (arch/x86/include/asm/idtentry.h:668)
> [ 16.984955][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.984974][ C0] ? error_entry (arch/x86/entry/entry_64.S:1007)
> [   16.984993][    C0]  </#DF>
> [   16.984999][    C0]  <TASK>
> [ 16.985009][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985040][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985066][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985093][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985136][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985154][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985177][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985196][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985218][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985244][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985264][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985290][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985311][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985336][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985363][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985384][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985409][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985430][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985455][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985484][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985505][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985532][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985555][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985579][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985607][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985628][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985655][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985676][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985701][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985725][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985747][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985772][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985794][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985818][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985847][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985869][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985896][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.985919][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.985944][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.985972][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.985992][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986017][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986038][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986063][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986093][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986116][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986143][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986165][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986188][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986217][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986239][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986265][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986286][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986310][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986338][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986359][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986385][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986408][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986434][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986464][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986486][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986511][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986532][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986557][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986585][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986606][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986631][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986652][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986676][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986704][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986725][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986751][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986772][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986796][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986824][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986846][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986872][ C0] ? __sanitizer_cov_trace_pc (kernel/kcov.c:213)
> [ 16.986893][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
> [ 16.986918][ C0] ? exc_page_fault (arch/x86/mm/fault.c:51 arch/x86/mm/fault.c:1474 arch/x86/mm/fault.c:1539)
> [ 16.986948][ C0] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
> [ 16.986968][ C0] ? is_kmmio_active (include/linux/mmiotrace.h:58)
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240924/202409242144.863b2b22-oliver.sang@intel.com

FTR this is being debugged in:
https://lore.kernel.org/all/66eb52dc.050a0220.92ef1.0006.GAE@google.com/

