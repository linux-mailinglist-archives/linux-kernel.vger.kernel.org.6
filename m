Return-Path: <linux-kernel+bounces-292795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F757957477
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AF81F237D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9BC1DC462;
	Mon, 19 Aug 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EBcgKPMa"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EF132124
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095796; cv=none; b=KsQauwigCrf9SIp046/8jRJjpjcExXgD8dZWNA4WkkRi0YT6UuCRT6iQB+okixNmw44lh6AAJVWuGz6T36ENZpkF/Wslf5yRj1r86Wxp46bECvwGM9juK0Y3TCkBmNgh1uuWRHudveJYHC29/RA/8V0tk77uV0Ar4Ka2RRuDWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095796; c=relaxed/simple;
	bh=Js6mVgpyfgoOTRUVZV+KA5wfQ+Tt9HYAUFyYGWmPTQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIVh7Srg6sb30l+30HnPAUM+U2BKZgRgpDvcRc1WJ1RGnwY5ya9h8dqZq+GJbQEUZzV5/JCDIOidxJXxADhfviz36duF3o1WUL8fxf9vQNe7ksbyYylqT56QNpveNa1k7Dl+6bINGDXfoDHtmxmbwA1TY5dDPt0GCe8BUGz3pVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EBcgKPMa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a864574429aso16100366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724095792; x=1724700592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ie0bvC9ROJLnfutVE8C94bre2OY3y4q//fAPg+wLI0=;
        b=EBcgKPMaKNQE23yEDaxSeZWTJg8iQRt0fqOB6kevi4rJJrgIWIA76UTf8jYYecFHZA
         Q80FKuJzyt05Izh7BA+itfDAcPyJRa5odq91SVCPw5Zkl4ZS11HuZNXO+gkSmrw4tO2A
         aOYFjgWbAKdLB2VfbqMWMEDIMSMsIb0e+um5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095792; x=1724700592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ie0bvC9ROJLnfutVE8C94bre2OY3y4q//fAPg+wLI0=;
        b=ka86zdiBgn517NyVyxfexLm0+zTOq+xCoCRwmcMNIedJEGiFsZvMa9PGb9To/fPXcv
         180yKSoWBsRjAi+7Wtgaet+DM+3s1FUrDya5wIwRZPqlhNEPIGhin3gl/GHAeN4W1KkP
         222BKlihkXoyfH7mDBxMxnRft6l19JkoXo41pGW9MF0LX/QyMkgOKdhfyMD/LL0p3+TO
         tHbYwqj21JomIwzThdnuo3XTpIkjCoiHiQSquJD0bEEsum65tVx1ChC5EihRzc0xj7Fa
         qsO4EAvEXwaVFz0cbEfeHIgnBjCx6s42v78BAmQfBPqVgbNcVswJEz6zod09QzbSRD3Q
         eZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhzR3zQNZ7REOBc/9VFtqqVQ4iRePIiqXu6zrqaBfickhfqAVxGl19fXYPergtQwPAx/yv+I8mCEYFb0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkvR5h/+JmfHltF+KNxBDf6WsBXUhc3hLCMkGWJRm8auwWIaP
	8dZHrxlFx4dnS4bJABUqt6S5sL/AKkhSLKhuNABAOXPyo7luKCZ+OlzzzDt6tCfV+DeD3thC28R
	WvbQVRw==
X-Google-Smtp-Source: AGHT+IHuwA8WzbfusunGHvre1AIPpNOP3UtkGgsUDWRz6fPCNiugQjFjbBPE2aETbfpx7qW3K5BPcg==
X-Received: by 2002:a17:907:2d0f:b0:a7d:23e8:94e9 with SMTP id a640c23a62f3a-a839293ef04mr878145766b.34.1724095792025;
        Mon, 19 Aug 2024 12:29:52 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c70afsm673130166b.15.2024.08.19.12.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 12:29:51 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so1221349a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJ/ysFEvrSCZzlQ30uSZlXcWnQ3sz/PzyGZSwCnj91Tx00dfAlbDjcASdLd7hNUO7JaGc5zugbDI28Xjw=@vger.kernel.org
X-Received: by 2002:a05:6402:42d5:b0:5a2:68a2:ae52 with SMTP id
 4fb4d7f45d1cf-5beca26d2f5mr9265659a12.0.1724095790870; Mon, 19 Aug 2024
 12:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
In-Reply-To: <20240819185253.GA2333884@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 12:29:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
Message-ID: <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 11:53, Nathan Chancellor <nathan@kernel.org> wrote:
>
>
> Modules linked in:
> Pid: 24, comm: mount Not tainted 6.11.0-rc4-next-20240819
> RIP: 0033:0x68006f6c
> RSP: 000000006c8bfc68  EFLAGS: 00010206
> RAX: 0000000068006f6c RBX: 0000000068a0aa18 RCX: 00000000600d8b09
> RDX: 0000000000000000 RSI: 0000000068a0aa18 RDI: 0000000068805120
> RBP: 000000006c8bfc70 R08: 0000000000000001 R09: 0000000068ae0308
> R10: 000000000000000e R11: ffffffffffffffff R12: 0000000000000001
> R13: 0000000068a0aa18 R14: 0000000000000015 R15: 0000000068944a88
> Kernel panic - not syncing: Segfault with no mm
> CPU: 0 UID: 0 PID: 24 Comm: mount Not tainted 6.11.0-rc4-next-20240819 #1
> Stack:
>  600caeff 6c8bfc90 600d8b2a 68944a80
>  00000047 6c8bfda0 600cbfd9 6c8bfd50
>  68944ad0 68944a88 7f7ffff000 7f7fffffff
> Call Trace:
>  [<600caeff>] ? special_mapping_close+0x16/0x19

Hmm. No "Code:" line? Did you just edit that out, or maybe UML doesn't
print one out?

Anyway, for me that special_mapping_close() disassembles to


 <+0>:  mov    %rdi,%rsi
 <+3>:  mov    0x78(%rdi),%rdi
 <+7>:  mov    0x20(%rdi),%rax
 <+11>: test   %rax,%rax
 <+14>: je     0x600caa11 <special_mapping_close+24>
 <+16>: push   %rbp
 <+17>: mov    %rsp,%rbp
 <+20>: call   *%rax
 <+22>: pop    %rbp
 <+23>: ret
 <+24>: ret

which may just match yours, because special_mapping_close+0x16 is
obviously that +22, and it's the return point for that call.

And your %rax value does match that invalid %rip value of 0x68006f6c.

So it does look like it's jumping off to la-la-land, and the problem is the code

        const struct vm_special_mapping *sm = vma->vm_private_data;

        if (sm->close)
                sm->close(sm, vma);

where presumably 'vm_private_data' isn't a "struct vm_special_mapping *" at all.

And I think I see the problem.

When we have that 'legacy_special_mapping_vmops', then the
vm_private_data field actually points to 'pages'.

So the 'legacy_special_mapping_vmops' can *only* contain the '.fault'
handler, not the other handlers.

IOW, does something like this fix it?

  --- a/mm/mmap.c
  +++ b/mm/mmap.c
  @@ -2095,7 +2095,6 @@ static const struct vm_operations_struct
special_mapping_vmops = {
   };

   static const struct vm_operations_struct legacy_special_mapping_vmops = {
  -       .close = special_mapping_close,
          .fault = special_mapping_fault,
   };

and honestly, we should have different 'fault' functions instead of
having the same fault function and then making the function
dynamically see which vm_operations_struct it was. But that's a
separate issue.

And oh Christ, the difference between "_install_special_mapping()"
(which installs the modern style special mapping) and
"install_special_mapping()" (which installs the legacy special
mapping) is truly horrendously disgusting.

And yes, UML uses that legacy crap, which explains why it happens on
UML but not on sane architectures.

As does csky, hexagon, and nios2.

We should get rid of the legacy case entirely, and remove that insane
difference between _install_special_mapping() and
install_special_mapping().

But in the meantime, the one-liner fix *should* fix it. The four
architectures that uses the legacy crud don't care about the close
function anyway.

What a horrid thing.

                Linus

