Return-Path: <linux-kernel+bounces-219620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965090D59E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136521F23091
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9A018E749;
	Tue, 18 Jun 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLWw/EMn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4B16B395
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720693; cv=none; b=tohciAg2YFPJOs8JQbbWok/Iroi+0KbbKmH5sftmAzVLLiyXm9sXrm11M97ccwr2cK5FCdMa3EezAHhlQzDX0rRzKLj3fqVkz2jPlPoAxqXz1qOY4nPTtGnBC43f0eQYHUJ4J9BHq9eRYQiQa93JgUKGB7/N474/sD3z8pdp2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720693; c=relaxed/simple;
	bh=Qe9HrNwwuxUd4tggdrON7M6DcUwaSSBpvWLFq+kvi0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSB14hrQ3ySuKOZSD4xn44o9UHDLPAzUCQ8kopV6xqqxWeeu1AH6rQiAt5vJ2dOiw75thOdVKEBE8ulCWIGVOkD7nwrJi+YokCKkCyCH6gF/IDgw4Q4mQDFW/ILLTGUIqUTY3xv8v0gr86ajHLEb+YMEpvS9AmKjRjGhDoPXlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLWw/EMn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d032a07a9so115135237b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718720691; x=1719325491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzSqCA3tMwUTmQtJKAVbh37FZMaDGohCEsVYc68S+UM=;
        b=vLWw/EMnWjvH9BSz1K4vzlYbh4vfBsUJWHiIW+kxgDzpysxiqhUEwHjrdUV9UkBNRM
         61r2D6o+vcWOMiyjiKt2YE/qXfmJ5E75wrDi3gET7tcc/S8IRPIyuQNjPBNgYk5rmLTo
         1IYKXU0NvXGetfNeM/MGol411eS8vFLPKtYbO/iVYkDvsUkVrfeScZk5KVtmYH2NbSs2
         QMS4P4VVpRCyK+jp7Gh79AW1mpv/t1kz/JElJATmn8crNJTriDlMZpE09eHszwbYXiqb
         8liCfT3zD4dMfIV4mePBs6uadoj1eJ5LRfkh3qnW1p2LK0QVBkX/PQ1lYp3cukng5TLe
         zAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720691; x=1719325491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzSqCA3tMwUTmQtJKAVbh37FZMaDGohCEsVYc68S+UM=;
        b=mr3ud0FXyVqeYOroijH+GMTz7LokCHmqVkAxgal6ZF6TiPR0VQGvanjLk7bFRjDjEg
         IccOmVeRi0S1/RvIhxHyJT3Y84Vop0fjjPFEI8Snk1jZIrsZvaGU0jee+3O200hBUOlF
         6o485Ez1K/3LL9PRvlMh1WGCeaRv0HekYZa55wo4c7QpwlnpxGpM0N2Ik82l7ie/BDdY
         xq1MyYsZPKKU6ZQhfkDe+uPBGlGHGrvnbsqwRpV/vfmvAgUPEKsIOEVILrbAxRebZ6Rs
         Tn9ALoMcMfuRRkJqRHgcxWpnmmCRPt3Omf3YqJmNzD2OFIKR9eD5JYqIz2WMrhDQ9wrm
         bU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUufNufGMbqrXexs6BnlL2bWzQJZYTwsPU89WbI4JGIuZl13goXpTMPnBKoWir0jZNI4GlKA6l2Vlagt1QIG6pRLAA5nA3P3PSTKbZA
X-Gm-Message-State: AOJu0YzxXzfBq5B5XdZrvSi0hcMHzAEttdjkrq1L6qlwGDMR9hw6eIn7
	pR3mkm+hh1zMBltSPduQlqfgdxMgK7L8FM8c9kj2HifVoV2KHn1jyM/kiy7ZYC+j/AzDSvOTFp9
	+FQ==
X-Google-Smtp-Source: AGHT+IGh7BKNV2fEETd8oRvVCeizF3GCJMhDwgMepnQy/LpS9SU28FXAV6MAuY5yJ3eBkzKaOl7h3OBeluU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4b03:b0:61b:ebab:ce9b with SMTP id
 00721157ae682-63222562162mr50792027b3.3.1718720691026; Tue, 18 Jun 2024
 07:24:51 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:24:49 -0700
In-Reply-To: <20240618104234.GF31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202406141648.jO9qNGLa-lkp@intel.com> <20240614152228.GAZmxgNPmozj7UzRdV@fat_crate.local>
 <20240618104234.GF31592@noisy.programming.kicks-ass.net>
Message-ID: <ZnGYsdiOYjLJBX1n@google.com>
Subject: Re: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning:
 objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 18, 2024, Peter Zijlstra wrote:
> On Fri, Jun 14, 2024 at 05:22:28PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 14, 2024 at 04:15:14PM +0800, kernel test robot wrote:
> You sure? Afaict the thing is:
> 
> $ OBJTOOL_ARGS="--verbose" make O=tmp-build/ arch/x86/kvm/
> ...
> arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup
> arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
> arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=== (sym)
> 0000 0000000000028220 <em_loop.part.0>:
> 0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
> 0004    28224:  3c e2                   cmp    $0xe2,%al
> 0006    28226:  74 2c                   je     28254 <em_loop.part.0+0x34>
> 0008    28228:  48 8b 57 10             mov    0x10(%rdi),%rdx
> 000c    2822c:  83 f0 05                xor    $0x5,%eax
> 000f    2822f:  48 c1 e0 04             shl    $0x4,%rax
> 0013    28233:  25 f0 00 00 00          and    $0xf0,%eax
> 0018    28238:  81 e2 d5 08 00 00       and    $0x8d5,%edx
> 001e    2823e:  80 ce 02                or     $0x2,%dh
> 0021    28241:  48 05 00 00 00 00       add    $0x0,%rax        28243: R_X86_64_32S     em_setcc
> 0027    28247:  52                      push   %rdx
> 0028    28248:  9d                      popf
> 0029    28249:  ff d0                   call   *%rax
> 002b    2824b:  90                      nop
> 002c    2824c:  90                      nop
> 002d    2824d:  90                      nop
> 002e    2824e:  31 d2                   xor    %edx,%edx
> 0030    28250:  84 c0                   test   %al,%al
> 0032    28252:  74 1d                   je     28271 <em_loop.part.0+0x51>
> 0034    28254:  55                      push   %rbp
> 0035    28255:  48 63 b7 d0 00 00 00    movslq 0xd0(%rdi),%rsi
> 003c    2825c:  48 03 b7 90 00 00 00    add    0x90(%rdi),%rsi
> 0043    28263:  48 89 e5                mov    %rsp,%rbp
> 0046    28266:  e8 05 fe ff ff          call   28070 <assign_eip>
> 004b    2826b:  5d                      pop    %rbp
> 004c    2826c:  e9 00 00 00 00          jmp    28271 <em_loop.part.0+0x51>      2826d: R_X86_64_PLT32   __x86_return_thunk-0x4
> 0051    28271:  89 d0                   mov    %edx,%eax
> 0053    28273:  e9 00 00 00 00          jmp    28278 <em_loop.part.0+0x58>      28274: R_X86_64_PLT32   __x86_return_thunk-0x4
> 0058    28278:  0f 1f 84 00 00 00 00 00         nopl   0x0(%rax,%rax,1)
> 
> Which is in fact test_cc() from em_loop().
> 
> Now, that .config is a FRAME_POINTER build, and the fast-call thing
> don't do frames, so it is right to complain. Big question is why it
> didn't complain previously I suppose.
> 
> Also, notably, this patch:
> 
>   https://lkml.kernel.org/r/20231204093732.323101886@infradead.org
> 
> cures things.

Speaking of that series, do you need/want any help pushing it along?  I ran into
build issues[*] and didn't have the cycles to fully figure things out at the time.
 
  This fails for some of my builds that end up with CONFIG_OBJTOOl=n.  Adding a
  stub for ASM_ANNOTATE() gets me past that:
  
  @@ -156,6 +171,7 @@
   #define STACK_FRAME_NON_STANDARD(func)
   #define STACK_FRAME_NON_STANDARD_FP(func)
   #define ANNOTATE_NOENDBR
  +#define ASM_ANNOTATE(x)
   #define ASM_REACHABLE
   #else
   #define ANNOTATE_INTRA_FUNCTION_CALL
  
  but then I run into other issues:
  
  arch/x86/kernel/relocate_kernel_32.S: Assembler messages:
  arch/x86/kernel/relocate_kernel_32.S:96: Error: Parameter named `type' does not exist for macro `annotate'
  arch/x86/kernel/relocate_kernel_32.S:166: Error: Parameter named `type' does not exist for macro `annotate'
  arch/x86/kernel/relocate_kernel_32.S:174: Error: Parameter named `type' does not exist for macro `annotate'
  arch/x86/kernel/relocate_kernel_32.S:200: Error: Parameter named `type' does not exist for macro `annotate'
  arch/x86/kernel/relocate_kernel_32.S:220: Error: Parameter named `type' does not exist for macro `annotate'
  arch/x86/kernel/relocate_kernel_32.S:285: Error: Parameter named `type' does not exist for macro `annotate'

[*] https://lore.kernel.org/all/ZXEEbrI7K6XGr2dN@google.com

