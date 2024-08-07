Return-Path: <linux-kernel+bounces-278284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513194AE3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CB2B232C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C9136664;
	Wed,  7 Aug 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmgTOUC1"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCA32209B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048619; cv=none; b=SMKwUCyPiphIJ7KtTaMsSiML7nCvCKf+rZUKq3IXZ2atfQ6asr4lLcnhj95eLZ7WWcOhUjUv6+YXRuP7+I1U+L7mZCL7b+0gfzZnCehEqHvnFD68wFzEriLrTk9QOYD+fnHuLW6I3Y32sjmRbZOeo6LkXUxeje/zqU1KwgWZySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048619; c=relaxed/simple;
	bh=L3zxrGp9pzinSpMN0okqzlxh8UOlc3docHoGdrr0uoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gdBo+Iytjb98ne2vEgUdfOuZiEqjPl/THFM7W23XOBuVoXHFsA6D0cmb3yYPOZC4BqCQqYCQ3RQM+UFuTSNzZuUrnPyMQvoojzmIRajuCBCTI7GoAcyAVJ20nKL8r1eZm7RmI2xLWIYy/mZ3DRg9y3/BuWBcUo/5Owo/7dLa/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmgTOUC1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso195a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723048615; x=1723653415; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riQD75FfkBgpWAyyMoow6+qKy3h+tMgO/92cdmCWWQI=;
        b=hmgTOUC1ChQVmWnO+MytxO+WO4sHv8Db7EJo9Qcfi8KbZ0WQ/RryOkipLk5ioAcvpJ
         m/Y4MY7yPYuz/nAF+AKZgmJ/9fwiELE7etiI/gUX6Y2+S1A5hxrdTa9j3n2z/UQkPcU+
         rd5SxCtlF/8ZWYanPZaKu/NxwHzeWgT/GsqW4zJoRCZ+OdhtHAHgE1cTaSfSXpD8F8c7
         52wCSHXWLz7zQDjgaFXIHFrtPe9tFgkSDDR/Ba5C1kZDtmCYcS46dCRzgfjPfeEhhm+n
         6o9ttynvxVxMTFpfAwR7JcfN9+4nQtfjeV0Y92ca40LW4SjbEkZZrJfWJVHSF641uDIs
         J+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723048615; x=1723653415;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riQD75FfkBgpWAyyMoow6+qKy3h+tMgO/92cdmCWWQI=;
        b=mWJesd/p3fbUPumobGIH9SOsUiUCGuH0J864BASNUAi6tp8eKmw3YkgYhFt5A2QKEi
         8vlo91qKw6ugfgG0cGa6Js/hp3028aC/hOM8ejzFmBgqgYjgFAfwtOWxkWkhICQTpEFO
         JAZucL3iwNKuVM9hvgrFvUPHztUM4fMIVwE05dpfPo10NqpKzYHkVdITdgM8wn8zKctW
         UXcSsX1xARxkGY+ZZjXI3I1vTG6nsre8wlZASHPEJ685cffHfWwfjBZB3tJ8aqw3m0mg
         Bknvd4lxu0M9EjYFhp2ufuSA9TovhnwPsonu34tn+4+ENtah9zPLzjp8fzXdXU3g2HEY
         rGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVEKEXrl03JX3a2rp9Mi8+4YFbHuj4eY0Pu9KtjscQ8usTXpk185eNLqUcMUfmaq3jQQLTAtxg7Oq14w1r5z0Cysd0+k3LihM+Z7rte
X-Gm-Message-State: AOJu0YxrtuqMsB2jxqvwrvJi3fqRLFJKObIcsesCMqMRc/j0SkvdeIRn
	m+ic/lp5jA/Z+KPhpIPkcikO8QRgU/9xYoIeuV6KLdSlGLwTELQ0c1gBOmRFzOVkJNirO2Wgvib
	Exe8dwWspkBPE6Sx1NhLOwLdfdA5sKhauBXrb
X-Google-Smtp-Source: AGHT+IEMT0D00wZxgbaS7ZlbUaOKZqS0NKAbIqfEmp+OaUjtXLa3vZXToggQQb/YiJn08GHRZeA2XEFihcr0CJ0C2WY=
X-Received: by 2002:a05:6402:27c7:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bba25bee88mr279090a12.0.1723048614852; Wed, 07 Aug 2024
 09:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807124103.85644-1-mpe@ellerman.id.au> <20240807124103.85644-2-mpe@ellerman.id.au>
 <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com> <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
In-Reply-To: <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 09:36:15 -0700
Message-ID: <CALmYWFvqoxyBf4iP7WPTU_Oxq_zpRzvaBOWoHc4n4EwQTYhyBA@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:56=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240807 11:44]:
> > On Wed, Aug 7, 2024 at 5:41=E2=80=AFAM Michael Ellerman <mpe@ellerman.i=
d.au> wrote:
> > >
> > > Add a close() callback to the VDSO special mapping to handle unmappin=
g
> > > of the VDSO. That will make it possible to remove the arch_unmap() ho=
ok
> > > entirely in a subsequent patch.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > ---
> > >  arch/powerpc/include/asm/mmu_context.h |  4 ----
> > >  arch/powerpc/kernel/vdso.c             | 17 +++++++++++++++++
> > >  2 files changed, 17 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/in=
clude/asm/mmu_context.h
> > > index 37bffa0f7918..9b8c1555744e 100644
> > > --- a/arch/powerpc/include/asm/mmu_context.h
> > > +++ b/arch/powerpc/include/asm/mmu_context.h
> > > @@ -263,10 +263,6 @@ extern void arch_exit_mmap(struct mm_struct *mm)=
;
> > >  static inline void arch_unmap(struct mm_struct *mm,
> > >                               unsigned long start, unsigned long end)
> > >  {
> > > -       unsigned long vdso_base =3D (unsigned long)mm->context.vdso;
> > > -
> > > -       if (start <=3D vdso_base && vdso_base < end)
> > > -               mm->context.vdso =3D NULL;
> > >  }
> > >
> > >  #ifdef CONFIG_PPC_MEM_KEYS
> > > diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> > > index 7a2ff9010f17..220a76cae7c1 100644
> > > --- a/arch/powerpc/kernel/vdso.c
> > > +++ b/arch/powerpc/kernel/vdso.c
> > > @@ -81,6 +81,21 @@ static int vdso64_mremap(const struct vm_special_m=
apping *sm, struct vm_area_str
> > >         return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
> > >  }
> > >
> > > +static void vdso_close(const struct vm_special_mapping *sm, struct v=
m_area_struct *vma)
> > > +{
> > > +       struct mm_struct *mm =3D vma->vm_mm;
> > > +
> > > +       /*
> > > +        * close() is called for munmap() but also for mremap(). In t=
he mremap()
> > > +        * case the vdso pointer has already been updated by the mrem=
ap() hook
> > > +        * above, so it must not be set to NULL here.
> > > +        */
> > > +       if (vma->vm_start !=3D (unsigned long)mm->context.vdso)
> > > +               return;
> > > +
> > > +       mm->context.vdso =3D NULL;
> > > +}
> > > +
> > >  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
> > >                              struct vm_area_struct *vma, struct vm_fa=
ult *vmf);
> > >
> > > @@ -92,11 +107,13 @@ static struct vm_special_mapping vvar_spec __ro_=
after_init =3D {
> > >  static struct vm_special_mapping vdso32_spec __ro_after_init =3D {
> > >         .name =3D "[vdso]",
> > >         .mremap =3D vdso32_mremap,
> > > +       .close =3D vdso_close,
> > IIUC, only CHECKPOINT_RESTORE requires this, and
> > CHECKPOINT_RESTORE is in init/Kconfig, with default N
> >
> > Can we add #ifdef CONFIG_CHECKPOINT_RESTORE here ?
> >
>
> No, these can be unmapped and it needs to be cleaned up.  Valgrind is
> one application that is known to unmap the vdso and runs into issues on
> platforms that do not handle the removal correctly.
>
Maybe Valgrind needs that exactly for checkpoint restore ? [1]

"CRIU fails to restore applications that have unmapped the vDSO
segment. One such
application is Valgrind."

Usually when the kernel accepts new functionality, the patch needs to
state the user case.
The only user case I found for .mremap and .close so far is the CRIU case.

[1] https://github.com/checkpoint-restore/criu/issues/488

Thanks
-Jeff

> Thanks,
> Liam

