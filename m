Return-Path: <linux-kernel+bounces-295911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1D95A2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DE11F251C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9251531DE;
	Wed, 21 Aug 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OW3wgN1h"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448E15218A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258001; cv=none; b=b3oY3uBL/Sx7xw5HCfxMKhpkhOa9sEK7pjJznmW/vCcA1YSCJHjOPzueAdrikFVb8KA3gPbJDQyg07+8meVEjlzB7uw2nyYn9qHUme6hCDAXNGe+Zr/ZBK/qFB+CV3mIWNNZ36LmQICmawTl+q+LC8DuEI1QukB6mXKJJGGtlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258001; c=relaxed/simple;
	bh=PLmAjOtPNnF65gIt5IDR12izeP/9X+oy+mHyGt2LTRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEP70sG62J3Zh7pMqJZxFL6PW2w64DUUtI1lPH0itPL0PhKuDVLlfqYl2vSv1w96MHr+F7Y+1HhqVQhP4YABfQ/KiURTJ2jxvH+hUT+nQET2N4+Ard9IAH/73XDdRR+Zge0u+bE3bcm2yf9mjEctQrE5K/eFckIaGp4sQZbrUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OW3wgN1h; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2702920904bso135116fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724257998; x=1724862798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btFwl/YBlJLOoac7syXq/zvfozN6hWtuf8J1II+3jGw=;
        b=OW3wgN1hpECLldIAFSSNBqMwhpLIPypXgxzvXMMzS/3U8uon2P7knZKggBeJFNTFmQ
         A2wPwERfU6kuNF+A9HgEWniSJPHy/Kj1As1e/iSGE5U1F+1A/aNmbylHCMRdcbX48JTc
         YRe82ycymAIY5LaUjX79uvcBOfLacYoOxXURw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257998; x=1724862798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btFwl/YBlJLOoac7syXq/zvfozN6hWtuf8J1II+3jGw=;
        b=w27ym2AB852XxAbxNTll9YIYlniFXnSUxb6aavGltPjSNBShGVMSkbbcAS0ZzBoF0S
         Q09szp94t7kBCtZ5ZLZ+9rsmWd/yjBvZxM3PXZSweySxZwx3mmF7bqvgwUjq+KUNy9Na
         YP0GKj+ycKnG6gFvWLRS1vVTX6gKnCAKDhgp+uFDtS9HGYsqccMfG27RU2glVUIWJfv1
         SVKWIWZxCJRKXYnI6jcXl/9Sm4xmmvwffASQF7BuA1l+X7r7u2ACQuR3NzIkYOn8BsXF
         OXnJpjIhT73fBzcZwoOXMX+nrg8eK5bzKvfT8XsOkLWHxz8U+sabOdn8ZS1EsnOps4yy
         a71A==
X-Forwarded-Encrypted: i=1; AJvYcCUUcI7BbQPIUmuy9AHpimiQ79+r3rOxcXJxE1FIM572c7zjo7DTOKnJuFBwwx9ZeIBDnvIFCnpsDKB7yX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEGibHIpBPd3cOOLm49vLPSWQHLSvUg00Be7v9Pk+TM6LS7L9
	5Oexqb63/JyQDZvVGD4PV/B45j9UBZS80hT7bvpzTWgX2rLpgBuxvbVvMULm/+4WXmr4MvbpIhg
	Bs8aaM38QAh2RRPwnW+fhPug8rgPLGUWohZwl
X-Google-Smtp-Source: AGHT+IFVyWJzyxVOM2uIsew0fQaxaT0UUl9jGhWhC9s1rR4wF0WG1EQ8cgDA0SZ1YiRUdYc6Dx8TjbX69jb91BGeF2E=
X-Received: by 2002:a05:6870:d8c7:b0:260:ccfd:b26f with SMTP id
 586e51a60fabf-2738be39fe5mr1743941fac.6.1724257998413; Wed, 21 Aug 2024
 09:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com> <CABi2SkUBH+utreVMTd1qEBSvXTPM7Qc1GiwNKjVa9+EeZK8WWA@mail.gmail.com>
 <CAKbZUD1d5hXWUPVpUzPo=M33_eo9_sdMq6nVg-jd=-O-CpFjsg@mail.gmail.com>
In-Reply-To: <CAKbZUD1d5hXWUPVpUzPo=M33_eo9_sdMq6nVg-jd=-O-CpFjsg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 21 Aug 2024 09:33:06 -0700
Message-ID: <CABi2SkUZ-OQFCNZcc0OMN_4YV8NoqrRu2HGEeFms+Ty6Bnofdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with can_modify_vma
To: Pedro Falcato <pedro.falcato@gmail.com>, rientjes@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:24=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Wed, Aug 21, 2024 at 5:16=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> > >
> > > We were doing an extra mmap tree traversal just to check if the entir=
e
> > > range is modifiable. This can be done when we iterate through the VMA=
s
> > > instead.
> > >
> > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > ---
> > >  mm/mmap.c | 11 +----------
> > >  mm/vma.c  | 19 ++++++++++++-------
> > >  2 files changed, 13 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 3af256bacef3..30ae4cb5cec9 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> > >                 unsigned long start, unsigned long end, struct list_h=
ead *uf,
> > >                 bool unlock)
> > >  {
> > > -       struct mm_struct *mm =3D vma->vm_mm;
> > > -
> > > -       /*
> > > -        * Check if memory is sealed, prevent unmapping a sealed VMA.
> > > -        * can_modify_mm assumes we have acquired the lock on MM.
> > > -        */
> > > -       if (unlikely(!can_modify_mm(mm, start, end)))
> > > -               return -EPERM;
> > Another approach to improve perf  is to clone the vmi (since it
> > already point to the first vma), and pass the cloned vmi/vma into
> > can_modify_mm check, that will remove the cost of re-finding the first
> > VMA.
> >
> > The can_modify_mm then continues from cloned VMI/vma till the end of
> > address range, there will be some perf cost there.  However,  most
> > address ranges in the real world are within a single VMA,  in
> > practice, the perf cost is the same as checking the single VMA, 99.9%
> > case.
> >
> > This will help preserve the nice sealing feature (if one of the vma is
> > sealed, the entire address range is not modified)
>
> Please drop it. No one wants to preserve this. Everyone is in sync
> when it comes to the solution except you.

Still, this is another option that will very likely address the perf issue.

-Jeff

>
> --
> Pedro

