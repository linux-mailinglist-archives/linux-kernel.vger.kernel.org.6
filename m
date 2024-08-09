Return-Path: <linux-kernel+bounces-281377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D094D633
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BE81F22B29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C214D29B;
	Fri,  9 Aug 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EPSk/22E"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1E80054
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227451; cv=none; b=Jxq0N2ybfUFAAF1Dr6+QrZQZ9adhNQ/0v1MkC7YR+f4GbVfO45wjGi/hhpkq6GHe9JOMKMOjOOfEk8vbeR0kjjGDuxWmcr5TD/ZbPEmZgZL9VooK5H5Zr2IG0OaqE16CozOzs9k7DRmNCm+nlJCQJYE0emh01cvuZ7YSueRfJcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227451; c=relaxed/simple;
	bh=Ae9zniD7iONbZlq6XzJ1p4LJ1h65DBc4GFYYEfAzPvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTSuoYxVQyZyyZnDM+hIrzZnFTzGvVulHYHynhaNWkznUmEourRbv/KQjPkzKqp4uv1V/5mNkYw0mF49P/ZhY3hEOB/koQH6FEg84rRtOjCrWV9gIr4bJn4Nk/TEhFWFKfc9zcxxRq9ECcJfYWGF27M0SS5G+p/xg4S+IJuwzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EPSk/22E; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso206975866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723227447; x=1723832247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkooFEwAZFGdWSwOH/mXH/dcJXSQ/enp5UFXKFxjc2A=;
        b=EPSk/22Ec8cxvCQMaaYcsD36DfjJMYYvzIpG44yhDfDL5CrJh5AAqBMMp+KNJf8qiF
         YabmFT7EhfJHWF8Yy4np+Dd6sypqWO7RsULEpa0KyACFfOHEE4E/j6e+fl7MpK5KJBjH
         lwkOydwMfCGg68uhcC3F0TgGuRjrZDCxj9+ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227447; x=1723832247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkooFEwAZFGdWSwOH/mXH/dcJXSQ/enp5UFXKFxjc2A=;
        b=E9Y88gv3VV2pwNf509aDhJhnoWy1Xg18NOB0kyOCaE5HqBs2GBFEFXhvoaIoBFXB6g
         KSi688lXAf9ARr+5LTG23mOAH05i3lU4u273daOHS3+xg8O5svp0AdH6xxL5j7er6Y7F
         fDELjszwyc87n3Vt4ujbZZXQNgleXZat60eHF68O5ZLTmXXIJUrykETunCdGdJ4Nu0Up
         presnTOAMVmvueA1j2YYSxNeLXBMghS6NGdODyGvN+eFHAPcO77JGA+Sr6/6fmKSnsCc
         AoDy+k0/686Liru+9APpKQElO3QQ3bcAcshGxcLdug67GtrJuk5Ul8EJ4Gwe2VIvov3v
         Gy4g==
X-Forwarded-Encrypted: i=1; AJvYcCWzBEZXZqdzfz1/TD5A9njxSwXtsJ+d62Lt9HkLbIL4Shs1RczK6nL3ebuLW8YbrBUNX3nYdo1DThtpOV8QgOhM9E8c8y1gDCCiPud4
X-Gm-Message-State: AOJu0YzVSFZI4TR6soZUAsr0FfeYNZTderUktMQX9snQ1lJnTpXc/R7m
	EZ0NpmxTfsugua55ADKm0kDczv4sqneVdqKJSaRIOaSh1FBddvQXKBcFBeE7gLLwQfJeAGehleu
	AnV0nQw==
X-Google-Smtp-Source: AGHT+IESc1js/fYQOMzlEOOlEUSKQJgt6iga2XKRACp771/f1NQl3G6UaioEgFNSPPHgnSYlAMJzUA==
X-Received: by 2002:a17:907:d865:b0:a7a:aa35:408e with SMTP id a640c23a62f3a-a80aa5a7105mr180641666b.27.1723227447275;
        Fri, 09 Aug 2024 11:17:27 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e12b5sm113066b.76.2024.08.09.11.17.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:17:25 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so318258166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:17:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKeRZN6aouXhMvDuKIx5BP8Oa9FhjqPPUM+hg+n2bNHQFXkd0BBHo4l7GuP8ir1v9J5EJiF4q+AgnI1C8qeJIMvOmiPkXPykWlHDOM
X-Received: by 2002:a17:907:60ce:b0:a7a:a46e:dc3c with SMTP id
 a640c23a62f3a-a80aa59494cmr167837166b.15.1723227444608; Fri, 09 Aug 2024
 11:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809145320.77100-1-spasswolf@web.de>
In-Reply-To: <20240809145320.77100-1-spasswolf@web.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Aug 2024 11:17:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=M1MT8TT8oMsXcUTyNi+zgV56b6wNmhYZ5c=vaXiCOQ@mail.gmail.com>
Message-ID: <CAHk-=wi=M1MT8TT8oMsXcUTyNi+zgV56b6wNmhYZ5c=vaXiCOQ@mail.gmail.com>
Subject: Re: commit 81106b7e0b13 can break asm_int80_emulation on x86_64
To: Bert Karwatzki <spasswolf@web.de>
Cc: mingo@kernel.org, akpm@linux-foundation.org, 
	Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Fenghua Yu <fenghua.yu@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 07:53, Bert Karwatzki <spasswolf@web.de> wrote:
>
> So the problem seems to be that the kmem_cache object *s has usersize 0. This
> should be impossible in theory as kmem_cache_create_usercopy() should print
> a warning in case of (!usersize && useroffset).

Following along from your original report:

  usercopy: Kernel memory overwrite attempt detected to SLUB object
'task_struct' (offset 3072, size 160)!

IOW, the user copy code is unhappy about copying data from user mode
into the task_struct allocation.

Anyway, on x86-64 with that commit we now just do

  arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
   {
        *offset = 0;
        *size = 0;
  }

and that seems to be the bug.

It's still allocated together with that 'struct task_struct', even if
it's no longer inside the 'struct thread_struct'.

Ingo? I think it needs to be something like

        *offset = sizeof(struct task_struct)
                - offsetof(struct task_struct, thread)
                + offsetof(struct fpu, __fpstate.regs);
        *size = fpu_kernel_cfg.default_size;

and the commit message of

    The fpu_thread_struct_whitelist() quirk to hardened usercopy can be removed,
    now that the FPU structure is not embedded in the task struct anymore, which
    reduces text footprint a bit.

is clearly not true. No, it's not embedded in 'struct task_struct',
but it *is* still allocated together with it in the same slab if I
read the code correctly (ie this part

  static void __init fpu__init_task_struct_size(void)
  {
        int task_size = sizeof(struct task_struct);

        task_size += sizeof(struct fpu);
        ..
        arch_task_struct_size = task_size;


is because it's still all one single slab allocation.

               Linus

