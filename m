Return-Path: <linux-kernel+bounces-205934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB490025F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EF0288118
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A6A18F2CD;
	Fri,  7 Jun 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWiZghsI"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DD18733D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760312; cv=none; b=fTJBr5AtgMOOL0NHbDrsIyPMtv8SVRYijrebxhltPhvmq3SZjNriyc9EtYLFk3v/LC1aI6u+ai/jXgLmojfCitOAQFNpo+TngP1VBxwOTOLWLOe27FdZNflq5L/SazX7gzPrUnNyj8NHv7MVIXij1K0te8DWrrrbkantKa2FBec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760312; c=relaxed/simple;
	bh=3hTKFMPSmGLjj9u6jzdgVpZDmoz1qONT5rdoiGd6O/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjg6VqLv3YBu90xrEiZ5fJpFzGaum7A7ZWP+JGpxElwHsq2PQPEZGy6+Bu+DRF7FUgQWap2Lh5hkSci8AAiRE3uGY3j073Z6WSTE4tqrbqJNDpcsnpyZt2ur9n15yXQhhfnQ17cGshqsS8bdJDScXC1Q44y7VkBGMGv5VRFlt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWiZghsI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35e5c6600f0so1625055f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717760309; x=1718365109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LpJsMUWr2U7Wpg2FjmxpI2q+B2egTwJaHeHULXYY/M=;
        b=XWiZghsIHw4WIYPSPOUUxHd82JIT3pALjqQFSI88bAX9rosoddRbQtyrcBsIm/QbRm
         tYphky6Q/lKYl8WzPS3wvH8+r5kuRoocqxJyMuhpPBO42qyBgKwTaieE9Ys9nUIJu+O1
         uckkvXeMMTaSbMG8xmSDVKYtjPdx6sYELPPZmRZwDVfvbj6BEBBfpYURpLZShms2Ju/o
         01bTqOx9zdQVt5BNewu5Rx863kI84biZufCv6xZmbg2RROZGliGSqAOyv+aTxw0CgExv
         0NTTBfndRc5sijzXnbG4f+GwdQmMbyrm5tvgo8lJU+bHO+jpp61qaaNoK9VRg6O3fNKA
         mO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760309; x=1718365109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LpJsMUWr2U7Wpg2FjmxpI2q+B2egTwJaHeHULXYY/M=;
        b=uOXhjYQVu95xs6FNEQ4iOS2fLbvEFF/OP9MDqjUo708n8ywvcTLY6fwQuudAtZxQVt
         DFyP1JymTPTMFqmAo/jRvy+C0wf0WszgR8CUcwcNrhrIxU2gt0MBxPX9WKSwYDVmnyku
         5brZdQhwcuvdrsx6qq/EqGspDaAtfRMWgDHRFpJ4YeVhnjeIUfYPWhou5OA0YvDtytQ6
         8Wmyl0NTCkbT9eNBFI/UHAlMg/Z3uxSBKZbiXJbb19zwe9r4Pw/BQQSsa7JreLO3crcc
         DdFcb5LYoEG4uQvbeQbU/GjLr6g1k+JWovqkeDDHL8EKpEukTXV/QMd99JPKoOiX1yUa
         zwxg==
X-Gm-Message-State: AOJu0YyY7myfcFngAI2Sb2Mhf1PpMRuHEBQSA2l31bdukyIDMqShiSli
	eTsoDcF27PnusyeWnAVcEeE9cnAPbQvBeZ32pk/xMxwpoLItvtcM
X-Google-Smtp-Source: AGHT+IGHwu+1dKN6+si/QubGBSPFSh4ECNE6gtZL3XVuz/4vy8JqdVJCbFWWVL8EkKfQ2/wo+GKw/w==
X-Received: by 2002:a5d:4588:0:b0:35f:636:f2f6 with SMTP id ffacd0b85a97d-35f0636f344mr1029842f8f.29.1717760308253;
        Fri, 07 Jun 2024 04:38:28 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e989c9sm3823958f8f.73.2024.06.07.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:38:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 7 Jun 2024 13:38:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method
Message-ID: <ZmLxMaXd-qtLBoK2@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <CAMzpN2hms-cpsaief4j_1LhXXznreE+it8nnsH2-8yoQ2Bn0Rw@mail.gmail.com>
 <ZmF8AH0TX_lgkxS5@gmail.com>
 <CAMzpN2gL04UbRUP5HDkz9hxdyxXVkFcXBrDc+hGmvR0rxt2Onw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2gL04UbRUP5HDkz9hxdyxXVkFcXBrDc+hGmvR0rxt2Onw@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Thu, Jun 6, 2024 at 5:06 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > >  17 files changed, 104 insertions(+), 107 deletions(-)
> > >
> > > This series would be better if you added the x86_task_fpu() helper in
> > > an initial patch without any other changes.  That would make the
> > > actual changes more visible with less code churn.
> >
> > Makes sense - I've split out the patch below and adjusted the rest of the
> > series. Is this what you had in mind?
> >
> > Note that I also robustified the macro a bit:
> >
> >  -# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
> >  +# define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(task))))
> >
> > Thanks,
> >
> >         Ingo
> >
> > ========================>
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Thu, 6 Jun 2024 11:01:14 +0200
> > Subject: [PATCH] x86/fpu: Introduce the x86_task_fpu() helper method
> >
> > The per-task FPU context/save area is allocated right
> > next to task_struct() - introduce the x86_task_fpu()
> > helper that calculates this explicitly from the
> > task pointer.
> >
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  arch/x86/include/asm/processor.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> > index 920b0beebd11..fb6f030f0692 100644
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -507,6 +507,8 @@ struct thread_struct {
> >         struct fpu              *fpu;
> >  };
> >
> > +#define x86_task_fpu(task) ((struct fpu *)((void *)(task) + sizeof(*(task))))
> > +
> >  /*
> >   * X86 doesn't need any embedded-FPU-struct quirks:
> >   */
> 
> Since this should be the first patch in the series, It would be:
> 
> #define #define x86_task_fpu(task) (&(task)->thread.fpu)
> 
> along with converting the existing accesses to task->thread.fpu in one
> patch with no other functional changes. Then you could change how the
> fpu struct is allocated without touching every access site again.

Yeah, you are right of course - I've restructured the series accordingly, 
it's now indeed a lot easier to review internally now, but has the same end 
result. Will post it later today.

Thanks,

	Ingo

