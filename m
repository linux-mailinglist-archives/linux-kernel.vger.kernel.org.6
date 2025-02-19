Return-Path: <linux-kernel+bounces-522262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8E4A3C80C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024DD177FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F3215058;
	Wed, 19 Feb 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UtJG+2k"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A8214A6E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991428; cv=none; b=tIqipCTB5PBIZZGX+f2O1GI8eS/vTnimtYAj496MFkp9OVHygjV/epc9WZdKXfqNwe27T+Y/r6f/Oih1qTWYnQMRHehUHrdsiAR6JGbzeubCtdRWR2AhQp80ZjSE4FZ/8W0jF+g5mxdcBmq41JUeyhhi4i3cQTV7VAEfaOoW3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991428; c=relaxed/simple;
	bh=e32V0/qBPosgc4BVssJ6V3ZtrfWII6ObaIOdRqz3Z/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkf4H2CiG8poEmOR68domtAz1KK0AAv13nqlbM25yIQJPWDH7RO/WuvHggUaPZFuuqgaYFo1nCxzHStGsYJ/vSoCmgy6Qizw/Q0OTjtyglsV/qMZsCGjH40SlOzIRrCH+MOy6W4ekLg/aeMCZDEB76XVSugcNyVRSWRKKXIYhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UtJG+2k; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f88509dad2so592287b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991425; x=1740596225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GuxtsVdk1rl1DvDqSgKGLPEo+f+7JBKRfT86MdUT7k=;
        b=0UtJG+2ktZOCY+HLeA5ndGZSvB9hBZ+lm9YxnOWfRYnjhQSui6wbbBP2fWpeg2Yn9A
         grwQCNfsD4ss9+7lv23NxSjqXXneBsTEacsVQHgZEArYDtd2qHNr2iUvZwZEYnMu0pQA
         ARB0iNSmMManKhEQiTboGOccxB4iHmVRTue3cq8Gb3hGSMeDcCU+olk6rhzcjmMNx5pN
         sfTOd9q7gHr5WlgcVQdp+jrp2sm51Np7C8I/tO3UibQ4h0Ey1ltT8msvpuXtvIDarZ0a
         BwCl+RH6ZI31u5SkZ3sH0sFEPF7f9XC/o2JvRJXdY/KRyiIpfyj8XM+EaAMh7tTlcpW/
         B4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991425; x=1740596225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GuxtsVdk1rl1DvDqSgKGLPEo+f+7JBKRfT86MdUT7k=;
        b=iAfGv/7kNepSN92GioPP8Pu5qqoS0S6WC9gq/ysv9kpU1MTX1Z1ElebCRhAsMTh/Wt
         XwZrhXlOzZue/JmFrT4+kW0ZXcKCqX0SgT4D8Wx7znzIe1EwTL0SNolSvm/7B/SE6Ywh
         Q7i/w32RA/z1cabAJX6vIQAzKFyOOAZ/DexKfoIxZbTpuYlUXyr0EoTFF1LOzOghGnQJ
         Sfvcnx1NYbbqxDGoJCJWD+PndHLXjSInJH6KrzBhKMmSHF0P4L3WkzsxNH6WsmXE4AEz
         B9O03ucQRZsXPz6Ku5MhTrjuOCfCpmMnPUG5quzRt9ZFmhZ4TTEuYJ2HGTNWQexhOXzi
         /Ydg==
X-Forwarded-Encrypted: i=1; AJvYcCXnIvppMxGo/nCrgty1Ws58j4rmkmfvbhnTBaoMBfg73m8UZ/Pw7Yp3TecuppH/4OtD3TD0mDvhoOpeF64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ziZTRkBfQDXH0+p5ZXLlkNpRVtTmXcpbdA76dKTn13O0Es4R
	nWG+6SrqEk36UYTh7UUY7p77nY61e5YFT+uX2tkFIM3OsdZ4T/kcDMb40aKsr1/cp9PSMRYqsTm
	7XFoU34n3Z1mDAORUuY6t7/UesjZ9H6P3eUVj
X-Gm-Gg: ASbGncuPJGzKMjTqPPkJym2FA+C3fGoeOV+T+P/hv0Gq32Srmfk4257SUUHrlSQETfw
	XC5lnuUetM9cl/O+WhwtfXKNIWIUBp3Tk6JlyLi2CQ7/KKSp+dksQ5SGQofsmAd3JbD7IUyjh+9
	WLxexehawak8AXc9o5pJv8Io6S2LE=
X-Google-Smtp-Source: AGHT+IE+UHCrYSK7WMY7m6aCJE90O2ylelzH2U40LQXM9FrWWZhmGElqKfaH/OPh8D23GYDvlAMEm878LlKZzEvBFI0=
X-Received: by 2002:a05:690c:6082:b0:6fb:b1dd:a00d with SMTP id
 00721157ae682-6fbb1ddad02mr21530627b3.30.1739991425302; Wed, 19 Feb 2025
 10:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com>
 <025b409c5ca44055a5f90d2c67e76af86617e222.camel@redhat.com> <Z7UwI-9zqnhpmg30@google.com>
In-Reply-To: <Z7UwI-9zqnhpmg30@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 19 Feb 2025 10:56:29 -0800
X-Gm-Features: AWEUYZlAhlEUroDJAunYDWrYoRQUhqd6Z8RqBXAnq2Yu2s7pyrPmteG-PPHkbts
Message-ID: <CADrL8HX+NwMLCLapc_AaOHZTXiAJkW3gE14Gn0rEyid3YPjvqA@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] KVM: x86/mmu: Age sptes locklessly
To: Sean Christopherson <seanjc@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 5:13=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Feb 18, 2025, Maxim Levitsky wrote:
> > On Tue, 2025-02-04 at 00:40 +0000, James Houghton wrote:
> > > By aging sptes locklessly with the TDP MMU and the shadow MMU, neithe=
r
> > > vCPUs nor reclaim (mmu_notifier_invalidate_range*) will get stuck
> > > waiting for aging. This contention reduction improves guest performan=
ce
> > > and saves a significant amount of Google Cloud's CPU usage, and it ha=
s
> > > valuable improvements for ChromeOS, as Yu has mentioned previously[1]=
.
> > >
> > > Please see v8[8] for some performance results using
> > > access_tracking_perf_test patched to use MGLRU.
> > >
> > > Neither access_tracking_perf_test nor mmu_stress_test trigger any
> > > splats (with CONFIG_LOCKDEP=3Dy) with the TDP MMU and with the shadow=
 MMU.
> >
> >
> > Hi, I have a question about this patch series and about the
> > access_tracking_perf_test:
> >
> > Some time ago, I investigated a failure in access_tracking_perf_test wh=
ich
> > shows up in our CI.
> >
> > The root cause was that 'folio_clear_idle' doesn't clear the idle bit w=
hen
> > MGLRU is enabled, and overall I got the impression that MGLRU is not
> > compatible with idle page tracking.
> >
> > I thought that this patch series and the 'mm: multi-gen LRU: Have secon=
dary
> > MMUs participate in MM_WALK' patch series could address this but the te=
st
> > still fails.
> >
> >
> > For the reference the exact problem is:
> >
> > 1. Idle bits for guest memory under test are set via /sys/kernel/mm/pag=
e_idle/bitmap
> >
> > 2. Guest dirties memory, which leads to A/D bits being set in the secon=
dary mappings.
> >
> > 3. A NUMA autobalance code write protects the guest memory. KVM in resp=
onse
> >    evicts the SPTE mappings with A/D bit set, and while doing so tells =
mm
> >    that pages were accessed using 'folio_mark_accessed' (via kvm_set_pa=
ge_accessed (*) )
> >    but due to MLGRU the call doesn't clear the idle bit and thus all th=
e traces
> >    of the guest access disappear and the kernel thinks that the page is=
 still idle.
> >
> > I can say that the root cause of this is that folio_mark_accessed doesn=
't do
> > what it supposed to do.
> >
> > Calling 'folio_clear_idle(folio);' in MLGRU case in folio_mark_accessed=
()
> > will probably fix this but I don't have enough confidence to say if thi=
s is
> > all that is needed to fix this.  If this is the case I can send a patch=
.
>
> My understanding is that the behavior is deliberate.  Per Yu[1], page_idl=
e/bitmap
> effectively isn't supported by MGLRU.
>
> [1] https://lore.kernel.org/all/CAOUHufZeADNp_y=3DNg+acmMMgnTR=3DZGFZ7z-m=
6O47O=3DCmJauWjw@mail.gmail.com

Yu's suggestion was to look at the generation numbers themselves, and
that is exactly what my patched access_tracking_perf_test does[2]. :)

So I think to make this work with MGLRU, I'll re-post my
access_tracking_perf_test patch, but if MGLRU is enabled, always use
the MGLRU debugfs instead of using page_idle/bitmap. It needs some
cleanup first though.

[2]: https://lore.kernel.org/kvm/20241105184333.2305744-12-jthoughton@googl=
e.com/

> > Any ideas on how to fix all this mess?
>
> The easy answer is to skip the test if MGLRU is in use, or if NUMA balanc=
ing is
> enabled.  In a real-world scenario, if the guest is actually accessing th=
e pages
> that get PROT_NONE'd by NUMA balancing, they will be marked accessed when=
 they're
> faulted back in.  There's a window where page_idle/bitmap could be read b=
etween
> making the VMA PROT_NONE and re-accessing the page from the guest, but IM=
O that's
> one of the many flaws of NUMA balancing.
>
> That said, one thing is quite odd.  In the failing case, *half* of the gu=
est pages
> are still idle.  That's quite insane.
>
> Aha!  I wonder if in the failing case, the vCPU gets migrated to a pCPU o=
n a
> different node, and that causes NUMA balancing to go crazy and zap pretty=
 much
> all of guest memory.  If that's what's happening, then a better solution =
for the
> NUMA balancing issue would be to affine the vCPU to a single NUMA node (o=
r hard
> pin it to a single pCPU?).

+1 to this idea, if this is really what's going on. If NUMA balancing
is only migrating a few pages, the 90% threshold in the test should be
low enough that we tolerate the few pages that were moved.

Or we could just print a warning (instead of fail) if NUMA balancing is ena=
bled.

