Return-Path: <linux-kernel+bounces-308391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F4965C57
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836BE1C234B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE916F0DD;
	Fri, 30 Aug 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZNvYFAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24076133987
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008884; cv=none; b=PWMBOtPiqCMrtInOQxHi0tAaaF8hJ33zFc3bO8oQF02Jx3RglqEkeeIxx6lXElecqIj7ovtlUbobz6WZ4i/B+miZElIKgJ/tT2JWSe2dYPo8REdASGlvF9BUF60hSp1IxYRTvCKhR1Au/2F+17lSsUSfXK/jKv4rNtvT6WNH+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008884; c=relaxed/simple;
	bh=h50K6TeSeprHN0PDkR4ic7CFAd5852n42vxVErwdtSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty7hvrGT0afFByGkjYF5jSWQMnuOBm6A3OpD0GIE8+tS5mr3MKgq+PKlVmr3R4KlvFIbsyMsjBXLNsrCE+7CDNBv+57+LktlhiDjBfAOL/wtmojmel6LJqtx9TeUDjDu0Z7RgHVjv7t6mwKHtmf6t/SId7Q883hNbGkiEuwgYAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZNvYFAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DBC4CEC6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725008882;
	bh=h50K6TeSeprHN0PDkR4ic7CFAd5852n42vxVErwdtSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sZNvYFAfrQX1eEJuDn4kvB4AnZVdshVDUo+d7A5PiX81YQYMRSxZWT10/EK4lOsc/
	 0D28gHajNCP+kinbQZzvx2zY4Is6cWb8DrXtTijSE8WqYSJnHhGz6AR/MB0M4mm6Up
	 X+ODnYSGbwZwoq5RbFGsgJkCZ45890ErDig8gZrktLUVIbLW3hGgAPMxfaHC2tu6Bv
	 vcHRaOA4ByEx/wJ5i8uf+QwnjzfLgZIamf7PBQV6y2wWTlHq8CkaYeeqgJKg16F0aR
	 IAUUwb0jaCZkbp314FLCX7QrIUCUyvPtq6jjcYot6mq6FjUi0NST1hzm0YmbJjbz59
	 k7DrpN+uKrP9A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533488ffaebso1875222e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:08:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YwBnoqTM8Sg2/NlzgPYqlyZL0q5AuzwUaxsw4zi8pQBEf+2ZS1Y
	fJpvOaOi+CRpHe+F2PaXAWpUFDOD8gyF625PJOjGZDdy+bEDaywCvB+Nd81OvL4K3wiv2GtUKAW
	HAmuy6vXwiGEnRBtgbOxHzZh52pc=
X-Google-Smtp-Source: AGHT+IHp5gtaLdHACYlFtN+7lUiJb3vMySK3Rw5H3lOfZZuKDeKJehe+NojIDxzdpMDoJzUbU/HV74T/3asMiL+sy9s=
X-Received: by 2002:a05:6512:3c8c:b0:52c:e5ac:ecd2 with SMTP id
 2adb3069b0e04-53546bb5a9fmr957758e87.51.1725008881050; Fri, 30 Aug 2024
 02:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822043328.4180-1-ddiss@suse.de> <20240830012535.6b6f6de1.ddiss@suse.de>
In-Reply-To: <20240830012535.6b6f6de1.ddiss@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Aug 2024 11:07:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH8cORPizJ_C7pd=eV7E3tr+HzcRyKz6ZuNA-Mo+yoR8Q@mail.gmail.com>
Message-ID: <CAMj1kXH8cORPizJ_C7pd=eV7E3tr+HzcRyKz6ZuNA-Mo+yoR8Q@mail.gmail.com>
Subject: Re: [PATCH] sched: remove unused __HAVE_THREAD_FUNCTIONS hook support
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-kernel-library@freelists.org, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Mel Gorman <mgorman@suse.de>, Hajime Tazaki <thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 03:26, David Disseldorp <ddiss@suse.de> wrote:
>
> [cc'ing Ard as ia64 remover]
>
> Ping - any thoughts on this patch?
>
> On Thu, 22 Aug 2024 04:33:28 +0000, David Disseldorp wrote:
>
> > __HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
> > provide their own task_thread_info(), task_stack_page(),
> > setup_thread_stack() and end_of_stack() hooks.
> >
> > Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> > removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
> > the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
> > conditionals to only check for the former case.
> >
> > Signed-off-by: David Disseldorp <ddiss@suse.de>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> > ---
> >  include/linux/sched.h            | 2 +-
> >  include/linux/sched/task_stack.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index f8d150343d42..9dbcdfe173cf 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1874,7 +1874,7 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
> >
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> >  # define task_thread_info(task)      (&(task)->thread_info)
> > -#elif !defined(__HAVE_THREAD_FUNCTIONS)
> > +#else
> >  # define task_thread_info(task)      ((struct thread_info *)(task)->stack)
> >  #endif
> >
> > diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> > index ccd72b978e1f..55042ff01a6d 100644
> > --- a/include/linux/sched/task_stack.h
> > +++ b/include/linux/sched/task_stack.h
> > @@ -33,7 +33,7 @@ static __always_inline unsigned long *end_of_stack(const struct task_struct *tas
> >  #endif
> >  }
> >
> > -#elif !defined(__HAVE_THREAD_FUNCTIONS)
> > +#else
> >
> >  #define task_stack_page(task)        ((void *)(task)->stack)
> >
>

