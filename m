Return-Path: <linux-kernel+bounces-526475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D701A3FF25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F5E7059F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8182A2512F6;
	Fri, 21 Feb 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnpIttme"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624671F2C56
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164313; cv=none; b=Cj3pT/neQ5hxJDXP7Rd+0xuhzemk3QVspEzGJ3aE+Kd5kfu9A+vEec3HQURnjrKFC0PqEhsk5iK/d4b1+p1rRu9C99vgaTkyoIHnLJ2OV9h9ZH4FJF2Yf7byvpi+HSt67IDJd3/lFYhA6kWNzO+wvsvgKODAVuPazgZCABt/EdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164313; c=relaxed/simple;
	bh=sqIOqBDqdjc0cRZ35+X6GOiSUw0AEtsKQKrNzmx1MXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR8NwVU0Z5neLWdGvEbAB8vnAevmfbmzLVum6nLWdthJdczhS5y2dtRUp6TPY4d+v/eiby3MFE6h9xliJa5aPOXvUG7yti5Elny2BP1MLxxFabbPRatoSuoFie7KtVQc/ZmPsoAgK7YErGlpN6fM80AyewJc8tQrjKyOh0RbjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnpIttme; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8cf98bbso55522155ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164310; x=1740769110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ibrx/kXcKjYEd4uD3k2jVdiqm5RD1iEoYpkD8k40IoU=;
        b=WnpIttmeuKMleS4prXOKqRaaRPd556tatPR+zOyucNzitRID3kIfSk97CRyke7/kcc
         GKewwv9mXYRKamUe2BnpH22FCmDi0IImAQkif+1c9LNLkQvXuv0ACEgQB6LOr10UWgn5
         A5McQ+97buevKJCvy1ZSnyGpmRimgnlUZVyOgBphdxDp+xOeOUvbZ4t4eJKxoIvG/Ip9
         f5clrM50L15h2GZLGA8aZo/F+4s7XWJWVn4nnDmQTFxvLv4sHKLJlbqcWSP8Vwjm4qm8
         oSpNmXN35qXdj8NmiyA3G2pcKoGTshze1YlnN70GB7aJYnZ8CYgLH5ebYVNPyJDj2Gsw
         bDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164310; x=1740769110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibrx/kXcKjYEd4uD3k2jVdiqm5RD1iEoYpkD8k40IoU=;
        b=nP4AySgpTlDxWrk8EZUDGrCdZvbBiBikNOEraeiHLpUqBKk2WZJh656g+ueVF4pt4u
         cj7IP+W/r/m4bwj6Rlw+J76XVnIeu28ovvbibh11xxiBW+FS59YOFmg57wEDn7D2aTqX
         Q57Xs9Qe+w/N/QkxyHgXv/nOzRZw7ZWMb8eIFVXyLGS6yfVO3osvNTL+DEHthARGxeTg
         uG6ZKKpd/zulsFwD9ld1Ed8Mrg37c8AjTsLoqG0Cz0g2KIH/PtTL40e1Jy8+w8n0oR1m
         HU4GeXJSXdxUKZkFSZtpVzzDrX/G8lSyhftzFw+x527JCPXSwG6nWQ6h1ly8XicOTtZZ
         DdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkox4L6KQkd2BIcdS1njDOnEXCp1d1wmd2rIerjY8wp+6wBIB0XPtnHimlweEsaXFKX27oxOqeDiOk8f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+++u6/KVnaS4iYLI0znbkQ7zt9sEFKVbTGNJLppJDudc6tWBo
	RKATIlRYTHcwr2Yn5rXaJ/riGRKtlJI9rTnjBwqc0WL1FGKXgv/a
X-Gm-Gg: ASbGncseJNJ4BO6eNvGDdWKVEVBXduioUmbcAdvN7QbJ/Jc+XrIwx0JndK7cF8/T/qC
	o8gSpWjOYXzYGDQGQ2L6oDgr9RO7YQX9vuwAIMKNBhT+vUTOvRZrN9p+q2RlIwUDilOgmVPi/QK
	fFyRerXSPOordNFIgHIZ1Aa9yjlo9CKhtkSa2a4n++x2J8js2NvG8D6F++0sUJYWOFnnwns0msL
	8t5msIhqNS34WFCShJcTOV+RXwCzHocwxtGcip1XsOVKVXwbfuI4Ihj5Y08oWdSiXfdSRSHl5nU
	FexcItJ3zRKzs+vV2Q7CLBPnlg==
X-Google-Smtp-Source: AGHT+IFOxdmopxTkm92O3ksiW6/Z2SWj3xlrpoKhwunMfIs3o+HmKRauh1AvvI16CFsI+IqDeKeEhQ==
X-Received: by 2002:a05:6a00:4f88:b0:72a:8bb6:2963 with SMTP id d2e1a72fcca58-73426cf11e7mr5910273b3a.13.1740164310308;
        Fri, 21 Feb 2025 10:58:30 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2dbsm16496525b3a.98.2025.02.21.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:58:29 -0800 (PST)
Date: Fri, 21 Feb 2025 13:58:27 -0500
From: Yury Norov <yury.norov@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: anshuman.khandual@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, skhan@linuxfoundation.org, mka@chromium.org,
	akpm@linux-foundation.org, Kees Cook <kees@kernel.org>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Subject: Re: [PATCH v2] uapi: Revert "bitops: avoid integer overflow in
 GENMASK(_ULL)"
Message-ID: <Z7jM02O36MJBz8S_@thinkpad>
References: <20250221074208.832153-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221074208.832153-1-richard120310@gmail.com>

On Fri, Feb 21, 2025 at 03:41:49PM +0800, I Hsin Cheng wrote:
> This patch reverts 'commit c32ee3d9abd2("bitops: avoid integer overflow in
>  GENMASK(_ULL)")'.
> 
> The code generation can be shrink by over 1k by reverting the commit.
> Orginally the commit claims that clang will emit warnings using the
> implementation at that time.
> 
> Numerous tests are done to verify the code size shrink result and
> whether the warnings are emitted.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

This is the biggest email I've ever received in the maillist. :-)

> ---
> Tests performed on ubuntu 24.04 with AMD Ryzen 7 5700X3D 8-Core
> Processor on x86_64 with kernel version v6.14.0-rc1.
> 
> Test compilation with gcc-13, gcc-12, gcc-11, gcc cross compiler,
> clang-17, clang-18 and clang-19. No warnings are emitted for W=1 and
> W=2. However, with W=0, many errors and warnings will pop out.

W=0 means that you don't pass it at all. I don't know what the scripts
will do if you pass W=0...

> For gcc-13 with W=0:
> In file included from <command-line>:
> ./include/linux/rwsem.h: In function ‘rwsem_assert_held_write_nolockdep’:
> ././include/linux/compiler_types.h:477:20: error: ‘asm’ operand 2 probably does not match constraints [-Werror]
>   477 | #define asm_inline asm __inline
> ...
> 
> For clang-19 with W=0:
> ./arch/x86/include/asm/jump_label.h:36:11: error: invalid operand for inline asm constraint 'i'
>    36 |         asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
>       |                  ^
> ./arch/x86/include/asm/jump_label.h:26:2: note: expanded from macro 'ARCH_STATIC_BRANCH_ASM'
>    26 |         "1: jmp " label " # objtool NOPs this \n\t"     \
> ...
> 
> However, these errors already exists before applying the change, I don't
> think this patch has anything to do with these errors. I'll send other
> patches to fix these errors.

So if some error pre-exists, you don't need to mention it.

> The following section shows the result of code size shrinking for
> different compilers, architectures and NR_CPUS. Additionally, I use QEMU
> to run an arm64 VM and perform some cpu-heavy workload to make sure no
> side effect or crashes will happen.
> 
> * Code size shrinking ( gcc-13 for x86_64 NR_CPUS=64 ):
> 
> x$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/2 grow/shrink: 46/510 up/down: 464/-1733 (-1269)

[...]

> Total: Before=22438085, After=22436816, chg -0.01%

Please don't include the whole bloat-o-meter output! 

> * Code size shrkinking ( gcc-12 for x86_64 NR_CPUS=64 ):
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> add/remove: 4/4 grow/shrink: 57/500 up/down: 1026/-2028 (-1002)
> Total: Before=22453915, After=22452913, chg -0.00%
> 
> * Code size shrinking ( gcc-11 for x86_64 NR_CPUS=64 ):
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new 
> add/remove: 0/2 grow/shrink: 36/518 up/down: 564/-1771 (-1207)
> Total: Before=22302033, After=22300826, chg -0.01%
> 
> * Code size shrinking ( gcc-13 for x86_64 with NR_CPUS=1024 ):
> 
> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
> add/remove: 0/0 grow/shrink: 9/132 up/down: 51/-503 (-452)
> Total: Before=22509812, After=22509487, chg -0.00%

Instead, can you summarize it in a nice looking table?

Compiler  NR_CPUS = 64   NR_CPUS = 1024   
gcc-13           -1269             -452
gcc-12           -1002              xxx
gcc-11           -1207              yyy

And so on.
 
> Every compiler, architectures combinations above can shrink the code
> size around 1k, except clang, which doesn't change anything before and
> after the change.
> 
> Analyzation of multiple functions of gcc-13 on x86_64 are performed,

s/Analyzation/Analysis

Can you run spell-checker too?

> trying to summarize what's the positive/negative effect of this change.
> 
> * free_acpi_perf_data
> >From bloat-o-meter, we can see the function has been shrink by 1 byte.
> ...
> free_acpi_perf_data                           75      74      -1
> ...
> 
> Disasembly it using
> $ objdump --disassemble=free_acpi_perf_data vmlinux_old > free_acpi_perf_data.old
> ...
> ffffffff81d632c3:	74 1a                	je     ffffffff81d632df <free_acpi_perf_data+0x3f>
> ffffffff81d632c5:	48 89 f8             	mov    %rdi,%rax
> ffffffff81d632c8:	48 d3 e0             	shl    %cl,%rax
> ffffffff81d632cb:	48 f7 d8             	neg    %rax
> ffffffff81d632ce:	48 21 d0             	and    %rdx,%rax
> ffffffff81d632d1:	74 0c                	je     ffffffff81d632df <free_acpi_perf_data+0x3f>
> ...
> 
> $ objdump --disassemble=free_acpi_perf_data vmlinux_new > free_acpi_perf_data.new
> ...
> ffffffff81d62ec5:	74 17                	je     ffffffff81d62ede <free_acpi_perf_data+0x3e>
> ffffffff81d62ec7:	48 89 fa             	mov    %rdi,%rdx
> ffffffff81d62eca:	48 d3 e2             	shl    %cl,%rdx
> ffffffff81d62ecd:	48 21 c2             	and    %rax,%rdx
> ffffffff81d62ed0:	74 0c                	je     ffffffff81d62ede <free_acpi_perf_data+0x3e>
> ...
> 
> Revert GENMASK() saves one negation here.
> 
> * tick_clock_notify
> >From bloat-o-meter, the shrink size is
> ...
> tick_clock_notify                            109     108      -1
> ...
> 
> $ objdump --disassemble=tick_clock_notify vmlinux_old > tick_clock_notify.old
> ...
> ffffffff81360694:	48 8b 05 05 fc 4d 01 	mov    0x14dfc05(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> ffffffff8136069b:	48 85 c0             	test   %rax,%rax
> ffffffff8136069e:	74 58                	je     ffffffff813606f8 <tick_clock_notify+0x68>
> ffffffff813606a0:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> ffffffff813606a5:	89 c1                	mov    %eax,%ecx
> ffffffff813606a7:	83 f8 3f             	cmp    $0x3f,%eax
> ffffffff813606aa:	77 4c                	ja     ffffffff813606f8 <tick_clock_notify+0x68>
> ffffffff813606ac:	be 01 00 00 00       	mov    $0x1,%esi
> ffffffff813606b1:	48 c7 c2 c0 0a 02 00 	mov    $0x20ac0,%rdx
> ffffffff813606b8:	48 63 c1             	movslq %ecx,%rax
> ffffffff813606bb:	48 8b 3c c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rdi
> ffffffff813606c2:	82 
> ffffffff813606c3:	48 01 d7             	add    %rdx,%rdi
> ffffffff813606c6:	f0 80 8f e0 00 00 00 	lock orb $0x1,0xe0(%rdi)
> ffffffff813606cd:	01 
> ffffffff813606ce:	83 c1 01             	add    $0x1,%ecx
> ffffffff813606d1:	48 63 c1             	movslq %ecx,%rax
> ffffffff813606d4:	48 83 f8 3f          	cmp    $0x3f,%rax
> ffffffff813606d8:	77 1e                	ja     ffffffff813606f8 <tick_clock_notify+0x68>
> ffffffff813606da:	48 89 f0             	mov    %rsi,%rax
> ffffffff813606dd:	48 d3 e0             	shl    %cl,%rax
> ffffffff813606e0:	48 f7 d8             	neg    %rax
> ffffffff813606e3:	48 23 05 b6 fb 4d 01 	and    0x14dfbb6(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> ...
> 
> $ objdump --disassemble=tick_clock_notify vmlinux_new > tick_clock_notify.new
> ...
> ffffffff81360564:	48 8b 05 35 fd 4d 01 	mov    0x14dfd35(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> ffffffff8136056b:	48 85 c0             	test   %rax,%rax
> ffffffff8136056e:	74 57                	je     ffffffff813605c7 <tick_clock_notify+0x67>
> ffffffff81360570:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> ffffffff81360575:	89 c1                	mov    %eax,%ecx
> ffffffff81360577:	83 f8 3f             	cmp    $0x3f,%eax
> ffffffff8136057a:	77 4b                	ja     ffffffff813605c7 <tick_clock_notify+0x67>
> ffffffff8136057c:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
> ffffffff81360583:	48 c7 c2 c0 0a 02 00 	mov    $0x20ac0,%rdx
> ffffffff8136058a:	48 63 c1             	movslq %ecx,%rax
> ffffffff8136058d:	48 8b 3c c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rdi
> ffffffff81360594:	82 
> ffffffff81360595:	48 01 d7             	add    %rdx,%rdi
> ffffffff81360598:	f0 80 8f e0 00 00 00 	lock orb $0x1,0xe0(%rdi)
> ffffffff8136059f:	01 
> ffffffff813605a0:	83 c1 01             	add    $0x1,%ecx
> ffffffff813605a3:	48 63 c1             	movslq %ecx,%rax
> ffffffff813605a6:	48 83 f8 3f          	cmp    $0x3f,%rax
> ffffffff813605aa:	77 1b                	ja     ffffffff813605c7 <tick_clock_notify+0x67>
> ffffffff813605ac:	48 89 f0             	mov    %rsi,%rax
> ffffffff813605af:	48 d3 e0             	shl    %cl,%rax
> ffffffff813605b2:	48 23 05 e7 fc 4d 01 	and    0x14dfce7(%rip),%rax        # ffffffff828402a0 <__cpu_possible_mask>
> ...
> 
> One negation is saved here, I also try to reproduce it on godbolt, the
> link is https://godbolt.org/z/ac4h1ov7f .
> 
> For negative impact, we pick the following function
> 
> * kstat_irqs_desc
> ...
> kstat_irqs_desc                              118     122      +4
> ...
> 
> $ objdump --disassemble=kstat_irqs_desc vmlinux_old > kstat_irqs_desc.old
> ...
> Disassembly of section .text:
> 
> ffffffff8130c320 <kstat_irqs_desc>:
> ffffffff8130c320:	f3 0f 1e fa          	endbr64
> ffffffff8130c324:	f7 47 78 00 02 02 00 	testl  $0x20200,0x78(%rdi)
> ffffffff8130c32b:	74 5b                	je     ffffffff8130c388 <kstat_irqs_desc+0x68>
> ffffffff8130c32d:	48 8b 36             	mov    (%rsi),%rsi
> ffffffff8130c330:	31 d2                	xor    %edx,%edx
> ffffffff8130c332:	48 85 f6             	test   %rsi,%rsi
> ffffffff8130c335:	74 4a                	je     ffffffff8130c381 <kstat_irqs_desc+0x61>
> ffffffff8130c337:	f3 48 0f bc c6       	tzcnt  %rsi,%rax
> ffffffff8130c33c:	89 c1                	mov    %eax,%ecx
> ffffffff8130c33e:	83 f8 3f             	cmp    $0x3f,%eax
> ffffffff8130c341:	77 3e                	ja     ffffffff8130c381 <kstat_irqs_desc+0x61>
> ffffffff8130c343:	41 b8 01 00 00 00    	mov    $0x1,%r8d
> ffffffff8130c349:	48 8b 7f 60          	mov    0x60(%rdi),%rdi
> ffffffff8130c34d:	48 63 c1             	movslq %ecx,%rax
> ffffffff8130c350:	83 c1 01             	add    $0x1,%ecx
> ffffffff8130c353:	48 8b 04 c5 a0 fb 83 	mov    -0x7d7c0460(,%rax,8),%rax
> ffffffff8130c35a:	82 
> ffffffff8130c35b:	03 14 38             	add    (%rax,%rdi,1),%edx
> ffffffff8130c35e:	48 63 c1             	movslq %ecx,%rax
> ffffffff8130c361:	48 83 f8 3f          	cmp    $0x3f,%rax
> ffffffff8130c365:	77 1a                	ja     ffffffff8130c381 <kstat_irqs_desc+0x61>
> ffffffff8130c367:	4c 89 c0             	mov    %r8,%rax
> ffffffff8130c36a:	48 d3 e0             	shl    %cl,%rax
> ffffffff8130c36d:	48 f7 d8             	neg    %rax
> ffffffff8130c370:	48 21 f0             	and    %rsi,%rax
> ffffffff8130c373:	74 0c                	je     ffffffff8130c381 <kstat_irqs_desc+0x61>
> ffffffff8130c375:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> ffffffff8130c37a:	89 c1                	mov    %eax,%ecx
> ffffffff8130c37c:	83 f8 3f             	cmp    $0x3f,%eax
> ffffffff8130c37f:	76 cc                	jbe    ffffffff8130c34d <kstat_irqs_desc+0x2d>
> ffffffff8130c381:	89 d0                	mov    %edx,%eax
> ffffffff8130c383:	e9 58 93 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> ffffffff8130c388:	f6 47 7d 20          	testb  $0x20,0x7d(%rdi)
> ffffffff8130c38c:	75 9f                	jne    ffffffff8130c32d <kstat_irqs_desc+0xd>
> ffffffff8130c38e:	8b 97 88 00 00 00    	mov    0x88(%rdi),%edx
> ffffffff8130c394:	eb eb                	jmp    ffffffff8130c381 <kstat_irqs_desc+0x61>
> ...
> 
> $ objdump --disassemble=kstat_irqs_desc vmlinux_new >
> kstat_irqs_desc.new
> ...
> Disassembly of section .text:
> 
> ffffffff8130c240 <kstat_irqs_desc>:
> ffffffff8130c240:	f3 0f 1e fa          	endbr64
> ffffffff8130c244:	f7 47 78 00 02 02 00 	testl  $0x20200,0x78(%rdi)
> ffffffff8130c24b:	74 57                	je     ffffffff8130c2a4 <kstat_irqs_desc+0x64>
> ffffffff8130c24d:	48 8b 36             	mov    (%rsi),%rsi
> ffffffff8130c250:	31 c0                	xor    %eax,%eax
> ffffffff8130c252:	48 85 f6             	test   %rsi,%rsi
> ffffffff8130c255:	74 48                	je     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> ffffffff8130c257:	f3 48 0f bc d6       	tzcnt  %rsi,%rdx
> ffffffff8130c25c:	89 d1                	mov    %edx,%ecx
> ffffffff8130c25e:	83 fa 3f             	cmp    $0x3f,%edx
> ffffffff8130c261:	77 52                	ja     ffffffff8130c2b5 <kstat_irqs_desc+0x75>
> ffffffff8130c263:	49 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%r8
> ffffffff8130c26a:	48 8b 7f 60          	mov    0x60(%rdi),%rdi
> ffffffff8130c26e:	48 63 d1             	movslq %ecx,%rdx
> ffffffff8130c271:	83 c1 01             	add    $0x1,%ecx
> ffffffff8130c274:	48 8b 14 d5 a0 fb 83 	mov    -0x7d7c0460(,%rdx,8),%rdx
> ffffffff8130c27b:	82 
> ffffffff8130c27c:	03 04 3a             	add    (%rdx,%rdi,1),%eax
> ffffffff8130c27f:	48 63 d1             	movslq %ecx,%rdx
> ffffffff8130c282:	48 83 fa 3f          	cmp    $0x3f,%rdx
> ffffffff8130c286:	77 17                	ja     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> ffffffff8130c288:	4c 89 c2             	mov    %r8,%rdx
> ffffffff8130c28b:	48 d3 e2             	shl    %cl,%rdx
> ffffffff8130c28e:	48 21 f2             	and    %rsi,%rdx
> ffffffff8130c291:	74 0c                	je     ffffffff8130c29f <kstat_irqs_desc+0x5f>
> ffffffff8130c293:	f3 48 0f bc d2       	tzcnt  %rdx,%rdx
> ffffffff8130c298:	89 d1                	mov    %edx,%ecx
> ffffffff8130c29a:	83 fa 3f             	cmp    $0x3f,%edx
> ffffffff8130c29d:	76 cf                	jbe    ffffffff8130c26e <kstat_irqs_desc+0x2e>
> ffffffff8130c29f:	e9 3c 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> ffffffff8130c2a4:	f6 47 7d 20          	testb  $0x20,0x7d(%rdi)
> ffffffff8130c2a8:	75 a3                	jne    ffffffff8130c24d <kstat_irqs_desc+0xd>
> ffffffff8130c2aa:	8b 87 88 00 00 00    	mov    0x88(%rdi),%eax
> ffffffff8130c2b0:	e9 2b 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> ffffffff8130c2b5:	e9 26 94 e8 00       	jmp    ffffffff821956e0 <__x86_return_thunk>

Alright, two identical jumps one after another. Ohh. Anyways,
GENMASK() doesn't seem to be involved, and the code generation is
overall improved.

> ...
> 
> We can find that GENMASK() indeed saves 1 negation and one "mov", but at
> thee same time it generate one more "jmp" and make another "jmp"

s/thee/the

> instruction become "e9 2b 94 e8 00" instead of "eb eb".
> 
> * nr_processes
> $ objdump --disassemble=nr_processes vmlinux_old > nr_processes.old
> ...
> ffffffff812873c3:	77 1a                	ja     ffffffff812873df <nr_processes+0x5f>
> ffffffff812873c5:	4c 89 c0             	mov    %r8,%rax
> ffffffff812873c8:	48 d3 e0             	shl    %cl,%rax
> ffffffff812873cb:	48 f7 d8             	neg    %rax
> ffffffff812873ce:	48 21 d0             	and    %rdx,%rax
> ffffffff812873d1:	74 0c                	je     ffffffff812873df <nr_processes+0x5f>
> ffffffff812873d3:	f3 48 0f bc c0       	tzcnt  %rax,%rax
> ffffffff812873d8:	89 c1                	mov    %eax,%ecx
> ffffffff812873da:	83 f8 3f             	cmp    $0x3f,%eax
> ffffffff812873dd:	76 cc                	jbe    ffffffff812873ab <nr_processes+0x2b>
> ffffffff812873df:	89 f0                	mov    %esi,%eax
> ffffffff812873e1:	e9 fa e2 f0 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> ...
> 
> $ objdump --disassemble=nr_processes vmlinux_new > nr_processes.new
> ...
> ffffffff812873c4:	77 1a                	ja     ffffffff812873e0 <nr_processes+0x60>
> ffffffff812873c6:	4c 89 c6             	mov    %r8,%rsi
> ffffffff812873c9:	48 d3 e6             	shl    %cl,%rsi
> ffffffff812873cc:	48 89 f1             	mov    %rsi,%rcx
> ffffffff812873cf:	48 21 c1             	and    %rax,%rcx
> ffffffff812873d2:	74 0c                	je     ffffffff812873e0 <nr_processes+0x60>
> ffffffff812873d4:	f3 48 0f bc f1       	tzcnt  %rcx,%rsi
> ffffffff812873d9:	89 f1                	mov    %esi,%ecx
> ffffffff812873db:	83 fe 3f             	cmp    $0x3f,%esi
> ffffffff812873de:	76 cc                	jbe    ffffffff812873ac <nr_processes+0x2c>
> ffffffff812873e0:	89 d0                	mov    %edx,%eax
> ffffffff812873e2:	e9 f9 e2 f0 00       	jmp    ffffffff821956e0 <__x86_return_thunk>
> ...
> 
> GENMASK() can save 1 negation but generate 1 more "mov" thus adds 1 more
> register to use.
> 
> In summary, GENMASK() can elimate 1 negation for almost every use cases,

I think only this summary is important. If you'd like to add a typical
example of code generation improvement, it's OK. But I generally trust
you, so don't put every function you've disassembled here.

> but some use cases may generate additional "mov" or register in use.
> The use of "~_UL(0) << (l)" may even result in use of %r* registers instead of
> using $e* which is 32 bits registers, because compiler can't make
> assumption that the higher bits are zeroes. ( I'm not super sure whether
> it's the true cause, let me know if anything needs to be corrected or
> need more tests, thanks. )

To me, it looks OK. GCC does weird things, but the code generation
looks better now. Adding Kees and Maxim as compiler experts. Guys,
if you have a minute, can you take a quick look at the code generation?
In case of red flags, please let me know.

Thanks,
Yury

> v1 -> v2:
> 	- Refer the patch explicitly as a revert of commit c32ee3d
> 	- Squash commits into 1 commit
> 	- Perform compilation for numerous compilers, architectures and
> 	  compare code size shrink for each of them
> 	- Perform cpu-heavy workload test inside x86_64 VM and ARM64 VM
> 	- Analyze the result of disassembly of several small use cases
> 
> ---
>  include/uapi/linux/bits.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 5ee30f882736..39e344a1227e 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -5,12 +5,10 @@
>  #define _UAPI_LINUX_BITS_H
>  
>  #define __GENMASK(h, l) \
> -        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
> -         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
> +(((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
>  
>  #define __GENMASK_ULL(h, l) \
> -        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
> -         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
> +(((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
>  
>  #define __GENMASK_U128(h, l) \
>  	((_BIT128((h)) << 1) - (_BIT128(l)))
> -- 
> 2.43.0

