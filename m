Return-Path: <linux-kernel+bounces-547641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A2A50BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417F316783E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF979254B0F;
	Wed,  5 Mar 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uxn7ED3p"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D3254859
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204082; cv=none; b=RfhSHRa7IWaVRmI7eV2oyxUb+UtlfXjygHP4hxAM8phygIddI5JK2ReiTK+HeaJhpmRC1c2GwUQznVFGciuBlVVfRA18vtkfg22WUKKdciRiaoJnbBaFvrV+cxRYPp/L0qGQFEw26FZthtoF4d6lj4Rrclp3v97++ktcSmvgHCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204082; c=relaxed/simple;
	bh=wlepMi0fBFN9kuhlu+4/1ZrK0uzriWzxmeaztImxzpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5Zz4FgS1UknA0cJyHmPiPp/kHlEN1gW3ghVm7jIYDemnAZnq5YyGFbUnHy3TzD/g1M2bbiSyOiDqn0i+0+bFg+ZN2JrNGQ/33Jl8zinthUwjbu/nBXTMbletA08SM4/LYHi+iAmvZRU5uc/6hXxXjPPG6EHp0unr2a5haRPMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uxn7ED3p; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30761be8fa8so77849161fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741204078; x=1741808878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlepMi0fBFN9kuhlu+4/1ZrK0uzriWzxmeaztImxzpw=;
        b=Uxn7ED3pqF+Xofmqg0jf7aHvkZpHt5lRSktix/oynVmNH1K0edETtvLE4teXSOgOkW
         oEjNEHzGs2Gn+SwtcmCRyU7N78/4jLbUvEfM8wYyaHYcheMjCIrI4+/EeHlSwynGLMay
         pG27W9D1BCbKc8NEW7S9jxlKJMU8b9SWKrHZkJ15GvYI0piu1SKPCjHkufHkgbbIQ96g
         OnaZL0AegtUWfGYDaI96FQUSsF2ffGyf3y1eiIQvyAnY5cODsTZPUXQcaoD73qQPrs1L
         I+OdTlNJ395N2JaxW3Hsli7pfuxkLEd4AglciJOr0k4jPOxbwRqEthMc2AXVfJc+ONtU
         RP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204078; x=1741808878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlepMi0fBFN9kuhlu+4/1ZrK0uzriWzxmeaztImxzpw=;
        b=Xh5qLsTdozI4yEiS+rJHIV2HJF3bWxSMNPnsyu2tUpeDf4vbkZ246kqnz3TdW5qfot
         rKEHGsqsAhxf6+mw7+qVUFY/AmRMr8kg/DzDKsSPUZuNMa1M2pKNn2qruL2re/GHetS6
         8qDtsYeW3t8lbg7/JnaPLCm0UJb0GD4ylZoxuoMd5ZuK8HjNm8TG5NRCQPrlSnbGZqYV
         thL9NVSa5ST6qSb4rO2D1VnuYOiCmvCVXv7tm9v4Qkq9oMcwAn0PKTbHo343b97JV2oP
         xuxCJz/oUjPvw6JE6UYMRcgme9LjGoqb84tceGLH3YSyZst/uWw9YRMjgna8YWgO6mwT
         9FLA==
X-Forwarded-Encrypted: i=1; AJvYcCUhOAncjbBXbO/zzrJ0hfwOj6jMny74WpIyBD9V8SI11CWndZl3sEJGahBcZbE6wHKZMnnQYrie7tQiY/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHd2BmvsFdEYf/BXG8wD9Eou8s9HfI5Mjzxd31eaku5QRMdHGs
	Kfxc1ndFEkdH4iuwFioFx3v6qdJl2cZktaAzDA8aSpSgKsTD8ClHV3MPgRdE8I2dQS1A36vxbjG
	HGAaknrJjJ7nKkXFtVKSphAdt/NU=
X-Gm-Gg: ASbGncs0t9nh0HhPtCbkt3Z9XYQsc/pJ1p1Kj+Hqj11oAbm2Lp4u6YpPfp4pzNVKDuP
	BdADXCdXM27fh9maMUIrlKSNBHUEKT5H42KD6wpi0N9Y9OzUSyHG3cIVwYDiYFMYk+dWBQsi2g+
	0V0JTHkY0mIU607RIl+WF5GWv2Jg==
X-Google-Smtp-Source: AGHT+IG6BjqHCRLSFnOrK8gCjG5MvDCoVFYW0MnuK5yPuko2XNcLdfqegsE0GcPsZ0cCvB/tOYT1v8V5GlSdQwTz8eQ=
X-Received: by 2002:a05:651c:8c:b0:306:501:4772 with SMTP id
 38308e7fff4ca-30bd7b173b9mr18229251fa.37.1741204078237; Wed, 05 Mar 2025
 11:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
In-Reply-To: <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 5 Mar 2025 20:47:46 +0100
X-Gm-Features: AQ5f1Jpfcokud7RD5CJjrYA0mhEUOGeJpbnFGjeNSQqkhl59VSn7gwKgcGPr_x4
Message-ID: <CAFULd4YNvz2rJEJDjacCeWak-JZNUfMB5LuM+qAwn_DCcn-CUg@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:04=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > Even to my surprise, the patch has some noticeable effects on the
> > performance, please see the attachment in [1] for LMBench data or [2]
> > for some excerpts from the data. So, I think the patch has potential
> > to improve the performance.
>
> I suspect some of the performance difference - which looks
> unexpectedly large - is due to having run them on a CPU with the
> horrendous indirect return costs, and then inlining can make a huge
> difference.
> kvm
> Regardless, I absolutely think that using asm_inline here is the right
> thing for the locked instructions.

It is "Intel(R) Core(TM) i7-10710U"

> That said, I do want to bring up another issue: maybe it's time to
> just retire the LOCK_PREFIX thing entirely?
>
> It harkens back to Ye Olde Days when UP was the norm, and we didn't
> want to pay the cost of lock prefixes when the kernel was built for
> SMP but was run on an UP machine.
>
> And honestly, none of that makes sense any more. You can't buy a UP
> machine any more, and the only UP case would be some silly minimal
> virtual environment, and if people really care about that minimal
> case, they should just compile the kernel without SMP support.
> Becxause UP has gone from being the default to being irrelevant. At
> least for x86-64.
>
> So I think we should just get rid of LOCK_PREFIX_HERE and the
> smp_locks section entirely.

Please note that this functionality is shared with i386 target, so the
removal, proposed above, would somehow penalize 32bit targets. The
situation w.r.t. UP vs SMP is not that clear there, maybe some distro
still provides i386 SMP kernels that would then run unoptimized on UP
systems.

From the compiler POV, now that "lock; " prefix lost its semicolon,
removing LOCK_PREFIX_HERE or using asm_inline would result in exactly
the same code. The problematic 31k code size increase (1.1%) with -O2
is inevitable either way, if we want to move forward.

My proposal would be to use what a modern compiler offers. By using
asm_inline, we can keep the status quo (mostly for i386) for some more
time, and still move forward. And we get that -Os code size *decrease*
as a bonus for those that want to shave the last byte from the kernel.

Thanks,
Uros.

