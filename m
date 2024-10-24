Return-Path: <linux-kernel+bounces-380491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF889AEF76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7741F21D41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974A200105;
	Thu, 24 Oct 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kc+xie/j"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391F1FF7B7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793638; cv=none; b=cbI3+KzdmLCx5WTWEB1y9kKZDJPpms5cXSatx+Z5bvYikB4izdYU8xYlXI1wAzRhpWgqDtvm49h6pxi+2VRdiqg0RPcHH4J7/9oG4nX3G85G6f3xI9kBLUufpbjIY3gkODg2NltbEeCXYXNBIeeFj7J5hJ140gKSuGnZrVV1TX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793638; c=relaxed/simple;
	bh=BpejwGN5VDXOYy7zfQT+/E1eqgcN84fFNF2NDn0BsrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN2o9umLvGv3M9fIJ1aEaKqEhAw3qtJ+ZnOwlCrVgFuveJk9ciiIV/y9xtBQMO105lbGTXbc7lzFc1fobnOBQxYTyeCm1dkyp6zxcx8/cBBP8YuxLiNgCiSSEfj38HzZ3ULX4rVlKscJyOtr9UfrNfCMrXpucNbDSYV77ErYCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kc+xie/j; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so18969381fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729793634; x=1730398434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DW+8x8NHe5NzA/ffifTMltnL9SvM451tK6ilFS4i/A=;
        b=Kc+xie/ji4WoYfxX5pqcy6rE+E6sf8WiSEK3SdMc3ALO1N5IX6MEI8NPMwYwuXXAvs
         G+dzUs3dgjaAijdUSLU8ltPEMSOj1YJjoC3Updf9EzYqh9oRftvTQUfxV3nnLYqVgGi3
         x+nT5pmed+LUbOXdOjeECuyl2yhY5ma1QUaaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793634; x=1730398434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DW+8x8NHe5NzA/ffifTMltnL9SvM451tK6ilFS4i/A=;
        b=oMn5It8toufr0AFNhOIto9/NN0hppqRCq4atqMidNMCYtFRkVkLtP7hX5sQIm51MTQ
         vO5cHjbH6TSIOt+jh3jLNnrrw8FDzvT6ayW13d7SHm45tLP1Y1QJWpyWylzBtwNwAjAJ
         PSCiKo0T3X8Yjk0KLMrIe1OqWEMGrDRnzgwsOD7oxomZiTLcNhQ7MS0ZU33Uws6oGSTU
         YiFgC4bBa1xH6PIZLPOhFesprcaWPT3HjYX6nrIUNVaQ5ZVneadnvK15uNWShYJdmSRl
         O2Su54xUJa98Uw4W0Fk8m1WuMohETt39TGz2aYA/D7houSu6qxY0zML6f+yy/BQT5+fS
         YwUw==
X-Gm-Message-State: AOJu0YwhjdrqJMKXMAetwSyN1q9nIGev+wsUd4JIc/k5Dn541slNg6uC
	nVaJlXjyB0atxCk9CHm2Bi5AVUWcMWpHhXgButhBbgd3y/vMvsZpVa4wiwQBnZpFFMNkbriRYxi
	nR5C5ew==
X-Google-Smtp-Source: AGHT+IHrPoX5V+iJk01KHEJUE/cCGy3dY3z2qCLPyyYes9iSGCMyBZc2vL17ddkisT2BVQRM3gRKpw==
X-Received: by 2002:a2e:bc1d:0:b0:2fa:d84a:bda5 with SMTP id 38308e7fff4ca-2fc9d2e529dmr64751651fa.7.1729793633864;
        Thu, 24 Oct 2024 11:13:53 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9adf7bc2sm14704661fa.99.2024.10.24.11.13.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:13:52 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso19706231fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:13:52 -0700 (PDT)
X-Received: by 2002:a2e:be85:0:b0:2fa:d4ef:f234 with SMTP id
 38308e7fff4ca-2fc9d2e4e0cmr60775501fa.1.1729793632223; Thu, 24 Oct 2024
 11:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
 <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local> <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
In-Reply-To: <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 11:13:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>
Message-ID: <CAHk-=wjBkvHNTy3orkjw=2GH25S4MSFWesSjni2zZNW2+gjomg@mail.gmail.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation issue
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 10:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> >
> >         asm("cmp %[ptr],%[ret]\n\t"
> >             "sbb %[ret],%[ret]\n\t"
> >             "or  %[ptr],%[ret]"
> >                 : [ret] "=r" (ret)
> >                 : [ptr] "r" (ptr),
> >                   "0" (runtime_const_ptr(USER_PTR_MAX)));
>
> Will do at least for the newlines.

Actually, I should also just remove the "or" and move that into C
code. It will allow the compiler to decide which way it wants to do
the bitwise 'or', which means that the compiler can pick whichever
output register is a better choice.

Probably never matters in practice, but leaving decisions like that to
the compiler and avoiding one more fixed asm instruction is a good
thing.

It does result in a few more casts on the C side, since you can't just
do bitwise 'or' on a pointer, but I think it's still the right thing
to do. So that thing becomes

  static inline void __user *mask_user_address(const void __user *ptr)
  {
        unsigned long mask;
        asm("cmp %1,%0\n\t"
            "sbb %0,%0"
                :"=r" (mask)
                :"r" (ptr),
                 "0" (runtime_const_ptr(USER_PTR_MAX)));
        return (__force void __user *)(mask | (__force unsigned long)ptr);
  }

which I'm certainly not claiming is a thing of beauty, but the
generated code looks ok if you just ignore the #APP/#NOAPP noise:

  # ./arch/x86/include/asm/uaccess_64.h:71:                "0"
(runtime_const_ptr(USER_PTR_MAX)));
  #APP
  # 71 "./arch/x86/include/asm/uaccess_64.h" 1
        mov $81985529216486895,%rax     #, __ret
  1:
  .pushsection runtime_ptr_USER_PTR_MAX,"a"
        .long 1b - 8 - .        #
        .popsection
  # 0 "" 2
  # lib/strncpy_from_user.c:114: {
  #NO_APP
        pushq   %rbx    #
        movq    %rdi, %r9       # tmp149, dst
        movq    %rdx, %r11      # tmp151, count
  # ./arch/x86/include/asm/uaccess_64.h:67:       asm("cmp %1,%0\n\t"
  #APP
  # 67 "./arch/x86/include/asm/uaccess_64.h" 1
        cmp %rsi,%rax   # src, mask
        sbb %rax,%rax   # mask
  # 0 "" 2
  # ./arch/x86/include/asm/uaccess_64.h:72:       return (__force void
__user *)(mask | (__force unsigned long)ptr);
  #NO_APP
        orq     %rax, %rsi      # mask, _44

so you actually see gcc filling in variable names etc (well "variable
names" may be a bit generous: "_44" is a pseudo for the new value of
src, but that's just how compilers are with SSA - assignments create a
whole new temporary).

So legibility is very much in the eye of the beholder. You have to be
pretty damn used to looking at the generated asm to find any of this
even remotely legible.

                Linus

