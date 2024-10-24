Return-Path: <linux-kernel+bounces-380449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B938F9AEEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE39B20D80
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD71FF02F;
	Thu, 24 Oct 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LUMSJ4s2"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD911F76A3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792438; cv=none; b=nDsCivzIpE5FuWcyhxC99o7Yv+UGROu8eMUtKzATpi66PXdRAy041BvA9w1gBs0gp6pprQB27ONWwMrk8sA92GYp0d3HruGNbaRKj28x+R1+WOpSag+xq6jKc6nhy2PW5uqz3y+u6HG02RX3UtK23se2B9LmGDH0Qx3D6hr8OrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792438; c=relaxed/simple;
	bh=J5UxzA7PmdNaayncefRqCj4vn5VHCYLbt6413Spj1+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXrc29DQ0TSynP2N3LbXELBYQMhTnb9ZB93QMfFgxg6zhMyxr5umodPYkUA9YmimcG4FdXKCrJUG/ELu1tawNijAmeVvd5ScSE3pD5qjN3ud+AUdSGd6x5RkcjclIRZOvkixduF4PV1/ZFwOz6XfzpQhXf3U6R4JdM+rktI4fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LUMSJ4s2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso16639981fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729792434; x=1730397234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGTLic2GTJcWTpmlkARaMs2mShZ4/TuHGxtCngkihdM=;
        b=LUMSJ4s2NZVVeqV4hJxp7kxRtKwgnlaXE409VU378V8IGTn/jLc8mIisKStxVum/F1
         82IeHK7Hf59xBjtB9qd9wWIFvoxnAfJfPUQHOUwqcH9MU2DLBSEAg4zAdMbbS87t+R3F
         02Ls3nwHvXSJVPsCHmDXy7UdJLpRx6ipmER/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792434; x=1730397234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGTLic2GTJcWTpmlkARaMs2mShZ4/TuHGxtCngkihdM=;
        b=CGrw0+M0HACEDj+hQUE51Wlimeloq6Kigjyp9jlPH1JhAFiQM78VbRRC0jo7ePvjar
         nqSTJIFi88pwMzIiccBldibDA9EJQEfxM1ySoD0ZcvLvKZpKgmqKT4ILM+Qg4Ku+A2sV
         1hnvxnQMi6Ax6h6abl85ldK92VAVbm1cQ//NPwI7m43ny30tZRbtTMDB3+pS6TEmz1HY
         k4mnzk8wDcuSWXtVKa+KAGXC3FdpOJt6ASbpeCYLHU6X/emHP5e2P+DikAw94yz0RhKj
         MvXCFMMabWXMSpl4/LsmY0JG8C6T/P26hFhaQIe81YpuGMk2/JYGD7dIuDSWCK9GIoed
         A44A==
X-Gm-Message-State: AOJu0YxSGAEyJktMpAW/jfKaSmyrXRg03ajJawYUiKQuKdIP8wV/ZxTT
	MT4gIYLcxQ9ApiOaP/kOnxjJHqvayGx1qQ9aLnLd+e77Hlk6sTf7HmC4xYP+f/YQ231uZmAsADP
	oFIK8WA==
X-Google-Smtp-Source: AGHT+IFqfBYtQRmx3eBn7elWFRzETSxvMy98vgdIt4ja78ZQWA4Wd8EhegKPkhgJNDjoOf7I6mc2cg==
X-Received: by 2002:a05:651c:1545:b0:2fb:3960:9667 with SMTP id 38308e7fff4ca-2fc9d31b55bmr62821751fa.14.1729792434045;
        Thu, 24 Oct 2024 10:53:54 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad7665csm14787361fa.57.2024.10.24.10.53.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:53:53 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f58c68c5so2234969e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:53:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3a95:b0:539:959e:f0d0 with SMTP id
 2adb3069b0e04-53b1a33d0a2mr6037448e87.21.1729792432440; Thu, 24 Oct 2024
 10:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024013214.129639-1-torvalds@linux-foundation.org> <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
In-Reply-To: <20241024110822.GBZxoqppmxp0xxG7ew@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Oct 2024 10:53:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
Message-ID: <CAHk-=wgynHGhG9dzwRdySJSHZTOCp9jBHChomEF-mERJmsUeQg@mail.gmail.com>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation issue
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 04:08, Borislav Petkov <bp@alien8.de> wrote:
>
> Can we make this more readable pls?
>
> Something like this:
>
> static inline void __user *mask_user_address(const void __user *ptr)
> {
>         void __user *ret;
>
>         asm("cmp %[ptr],%[ret]\n\t"
>             "sbb %[ret],%[ret]\n\t"
>             "or  %[ptr],%[ret]"
>                 : [ret] "=r" (ret)
>                 : [ptr] "r" (ptr),
>                   "0" (runtime_const_ptr(USER_PTR_MAX)));

Will do at least for the newlines.

I actually find the '%[ret]' kind of verbosity *less* readable than
using the numbers that are needed anyway to disambiguate the
input/output thing.

Yes, named arguments are good when there's enough of them to be a big
deal, but in this case the variable naming ends up just becoming line
noise and overwhelming the actual code in question.

> This way the compiler-generated asm is more readable too due to the newlines
> and tabs.

Ack. I don't find the compiler-generated asm very readable due to all
the magic section tricks, but certainly that can be avoided for the
cmp/sbb/or sequence.

> In any case, it looks good, I single-stepped strnlen_user() and I got:

Thanks, looks good.

> Looking at Documentation/arch/x86/x86_64/mm.rst, 5 level page tables define
> USR_PTR_MAX as 0x00ffffffffffffff, i.e., bits [55:0].
>
> So I guess that USER_PTR_MAX needs to look at X86_FEATURE_LA57, no?

The *page tables* only cover bits [55:0] of user space, yes.

But the user *pointers* are bigger. That's the point of LAM. The upper
bits are masked off by hardware.

So a valid user pointer with LAM57 looks like:

 [63: MBZ] [62-57: masked off] [56: MBZ] [55-0: used for TLB lookup]

LAM48 is the same, except obviously [62-48] are masked off, and bit 47
is the one that must-be-zero.

So as far as the kernel is concerned, any address with the top bit
clear is a user address.

So with LAM, you basically end up with the sign bit test again (except
that we still don't allow the last page of user space to be mapped).

We could also take the whole "bit 56 must be zero too" thing into
account and further tighten it, but it really doesn't change the
situation in any material ways, since we have that page-sized hole at
the end of the user address space anyway even without it (and with
LAM, the upper bit masking just means that special guard page is
repeated in the linear address space).

                   Linus

