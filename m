Return-Path: <linux-kernel+bounces-278506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7A94B111
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47B5428265D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE6146587;
	Wed,  7 Aug 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HY1nSxzG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2A145A15
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061554; cv=none; b=sCPWqwjoD27Caikb39QtnVrlOTueSQn/B3BHm+o/5RkOX74G+x2aXHHvvJsPa9bs+YUKLi5RpfGUwEglp31sKkcC4UIzQ8Gyqs6JzJX8dqT54Dq1y1Ve8C3N3ILQT/Q1rNrqUBsFlJHueewml/bPvguF4zaHajJoc/jV0h46uzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061554; c=relaxed/simple;
	bh=oFFrHrQXB+La4yN4bgwAaPLh8665iZrrUH//q5zYjRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gcwUJSpiAxPdPMEPenTCfMIql0dV/KUPq1TFOu2bYZGZkz6vbvUDBUJO8H9wumRdZQ/ZwCvWcXRyHC0SJYdHSfK1vDKtrT4RfIGH7qsDXbgh4k27KaQCAq8Kq36GD5O+KEzu860+yL6TBdzOYIyHT/UOvaMymMOLlwCet7r5udQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HY1nSxzG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso5164a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723061551; x=1723666351; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvY4WNMX9mr7YEzp2nAVsZDMNnesPE1WwMojffdPXT4=;
        b=HY1nSxzGxd9jJthJAZy9WF3IBZC2CyeUYRNF+G4lxEI7fUXdqweqI1mvmOwh2IcGlr
         dVIoFmpR+jDYSf45CTHc9yyS6COkfaoVH+BIeEFgFJQeBc15hlc6zYNt/7pwnxQwG99O
         qbxZoXodl1BnIj3+4Hl46ozlNbLddaY4MfIHjDv8BfFU8Q+NpJOwy7kkjIqpaFHepKqn
         gCwKFGRrP/41Sw9f7pJb1Dyz+sho0c7zQKE2AMg5hwuNziuEqaqPYtFYng/tV9crpb4i
         BCW4gxHdgQuoU+i3sAlU9THz5pf3amILEZCyhjniMkKz18L8cezO0Z6YHtW1+1smvqbt
         gJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061551; x=1723666351;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvY4WNMX9mr7YEzp2nAVsZDMNnesPE1WwMojffdPXT4=;
        b=gAEXEaqUFi7dHm5q4udUXFaBpkS5VbEI8cTUqVZdnjGj81b45mLjt3xKhl82NLW9L2
         NsmfWVla/eas8qr4bUatmegmLpyJiBC9k0dLvoAirMOw0/fjpCzrARBdO7yZh9GIA6i7
         hm60KRngDbqyeKjei1xIVO/iEEjiyjHVR31MZOzvjHzzeTbhddUs1Wy3Wv84tETyedOD
         nGBrkDp6e58WZVq7b32DGov3P+BsodXgpOQLcME+JDCzVAsg/FU5Edsi3qR8ZK7Aut6T
         fZPdQwtP6pGLRme/TFeO+yVYjPCI1DHw7cO0Qjo46DS7ERwh1LTeXcjy/uPx2vnhxXfk
         N+lw==
X-Forwarded-Encrypted: i=1; AJvYcCWab5WgvuZwiM4CY1FaUHBO/hhf6pjsth1h1VjpxoTw5Vn1QHgVTUfgUgsKdj75i8f7wK9XNS+4ofw05CHwopGCcGjyjBq1UzO52Apl
X-Gm-Message-State: AOJu0Yy7kSbZECxfK/qUkidhKlrFq/ScpHbiqgGUMUofORl/l5rvKQjD
	qbCs8npX3AZdKyjyI/6LoPR22jRIY2Sjvs9cdhcQdgm5CnfO7aq7S9s1+9IgO1ccD01zT/FjJy5
	9Ylgw4SnHaxwHQGx5f/Q5FZiUjLiScg8y+nOP
X-Google-Smtp-Source: AGHT+IE38TOrV9hTuWKKpab+jZbRWPVtmS9t5KG98LB429cOAjV7X9Y2P7QbhgL6lm1OLWDDVlwoXeVHofbFpIlzReA=
X-Received: by 2002:a05:6402:51d2:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5bbb179b52amr112a12.7.1723061550380; Wed, 07 Aug 2024 13:12:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807124103.85644-1-mpe@ellerman.id.au> <20240807124103.85644-2-mpe@ellerman.id.au>
 <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com>
 <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
 <CALmYWFvqoxyBf4iP7WPTU_Oxq_zpRzvaBOWoHc4n4EwQTYhyBA@mail.gmail.com> <babup6k7qh5ii5avcvtz2rqo4n2mzh2wjbbgk5xeuivfypqnuc@2gydsfao3w7b>
In-Reply-To: <babup6k7qh5ii5avcvtz2rqo4n2mzh2wjbbgk5xeuivfypqnuc@2gydsfao3w7b>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 13:11:51 -0700
Message-ID: <CALmYWFsAT+Cb37-cSTykc_P7bJDHmFa7mWD5+B1pEz73thchcQ@mail.gmail.com>
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

On Wed, Aug 7, 2024 at 10:11=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240807 12:37]:
> > On Wed, Aug 7, 2024 at 8:56=E2=80=AFAM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Jeff Xu <jeffxu@google.com> [240807 11:44]:
> > > > On Wed, Aug 7, 2024 at 5:41=E2=80=AFAM Michael Ellerman <mpe@ellerm=
an.id.au> wrote:
> > > > >
> > > > > Add a close() callback to the VDSO special mapping to handle unma=
pping
> > > > > of the VDSO. That will make it possible to remove the arch_unmap(=
) hook
> > > > > entirely in a subsequent patch.
> > > > >
> > > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > > > ---
> > > > >  arch/powerpc/include/asm/mmu_context.h |  4 ----
> > > > >  arch/powerpc/kernel/vdso.c             | 17 +++++++++++++++++
> > > > >  2 files changed, 17 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerp=
c/include/asm/mmu_context.h
> > > > > index 37bffa0f7918..9b8c1555744e 100644
> > > > > --- a/arch/powerpc/include/asm/mmu_context.h
> > > > > +++ b/arch/powerpc/include/asm/mmu_context.h
> > > > > @@ -263,10 +263,6 @@ extern void arch_exit_mmap(struct mm_struct =
*mm);
> > > > >  static inline void arch_unmap(struct mm_struct *mm,
> > > > >                               unsigned long start, unsigned long =
end)
> > > > >  {
> > > > > -       unsigned long vdso_base =3D (unsigned long)mm->context.vd=
so;
> > > > > -
> > > > > -       if (start <=3D vdso_base && vdso_base < end)
> > > > > -               mm->context.vdso =3D NULL;
> > > > >  }
> > > > >
> > > > >  #ifdef CONFIG_PPC_MEM_KEYS
> > > > > diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vds=
o.c
> > > > > index 7a2ff9010f17..220a76cae7c1 100644
> > > > > --- a/arch/powerpc/kernel/vdso.c
> > > > > +++ b/arch/powerpc/kernel/vdso.c
> > > > > @@ -81,6 +81,21 @@ static int vdso64_mremap(const struct vm_speci=
al_mapping *sm, struct vm_area_str
> > > > >         return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_sta=
rt);
> > > > >  }
> > > > >
> > > > > +static void vdso_close(const struct vm_special_mapping *sm, stru=
ct vm_area_struct *vma)
> > > > > +{
> > > > > +       struct mm_struct *mm =3D vma->vm_mm;
> > > > > +
> > > > > +       /*
> > > > > +        * close() is called for munmap() but also for mremap(). =
In the mremap()
> > > > > +        * case the vdso pointer has already been updated by the =
mremap() hook
> > > > > +        * above, so it must not be set to NULL here.
> > > > > +        */
> > > > > +       if (vma->vm_start !=3D (unsigned long)mm->context.vdso)
> > > > > +               return;
> > > > > +
> > > > > +       mm->context.vdso =3D NULL;
> > > > > +}
> > > > > +
> > > > >  static vm_fault_t vvar_fault(const struct vm_special_mapping *sm=
,
> > > > >                              struct vm_area_struct *vma, struct v=
m_fault *vmf);
> > > > >
> > > > > @@ -92,11 +107,13 @@ static struct vm_special_mapping vvar_spec _=
_ro_after_init =3D {
> > > > >  static struct vm_special_mapping vdso32_spec __ro_after_init =3D=
 {
> > > > >         .name =3D "[vdso]",
> > > > >         .mremap =3D vdso32_mremap,
> > > > > +       .close =3D vdso_close,
> > > > IIUC, only CHECKPOINT_RESTORE requires this, and
> > > > CHECKPOINT_RESTORE is in init/Kconfig, with default N
> > > >
> > > > Can we add #ifdef CONFIG_CHECKPOINT_RESTORE here ?
> > > >
> > >
> > > No, these can be unmapped and it needs to be cleaned up.  Valgrind is
> > > one application that is known to unmap the vdso and runs into issues =
on
> > > platforms that do not handle the removal correctly.
> > >
> > Maybe Valgrind needs that exactly for checkpoint restore ? [1]
>
> Maybe, and maybe there are 100 other applications unmapping the vdso for
> some other reason?
>
When PPC added arch_munamp, it was for CRIU, wasn't it ? That was the origi=
nal
intention.

Maybe there are more apps that have started unmapping vdso, it might
be interesting
to know those use cases before widely opening this without kernel config.

> >
> > "CRIU fails to restore applications that have unmapped the vDSO
> > segment. One such
> > application is Valgrind."
> >
> > Usually when the kernel accepts new functionality, the patch needs to
> > state the user case.
>
> This isn't new functionality, the arch_unmap() existed before and this
> is moving the functionality.  We can't just disable it because we assume
> we know it's only used once.
>
> I had planned to do this sort of patch set in a follow up to my patch
> set [1], so I was deep into looking at this before the mseal()
> regression - which I expected to happen and have been advocating to
> avoid extra walks... This would be fixed by my patch set by reducing the
> walk count.
>
I would rather leave mseal() in-loop check discussion to the other
email thread :-)

> > The only user case I found for .mremap and .close so far is the CRIU ca=
se.
> >
>
> In fact, this is broken on other archs for valgrind since they unmap the
> vdso and then crash [2].  There has been a fix in the works for a while,
> which I stepped in during the patch set [1], which can be seen here
> [3].  In the discussion, the issue with Valgrind is raised and a generic
> solution to solve for more than just ppc is discussed.  The solution
> avoids crashing if vdso is unmapped and that seems like the sane
> direction of this work.
>
> We also have users unmapping vdsos here [4] too.
This is a strange code. If the use case about clock_gettime is legit, then
kerne can provide an option to not unload vdso during elf loading.

>
> Why would we leave a dangling pointer in the mm struct based on a
> compile flag?
>
> [1] https://lore.kernel.org/linux-mm/20240717200709.1552558-18-Liam.Howle=
tt@oracle.com/
> [2] https://lore.kernel.org/lkml/87imd5h5kb.fsf@mpe.ellerman.id.au/
> [3] https://lore.kernel.org/all/20210611180242.711399-17-dima@arista.com/
> [4] https://github.com/insanitybit/void-ship
>

