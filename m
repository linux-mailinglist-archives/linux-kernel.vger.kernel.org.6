Return-Path: <linux-kernel+bounces-175060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E98C19B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B9D285BD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305A12D769;
	Thu,  9 May 2024 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz0Mn4KH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13001129E62
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295796; cv=none; b=UFi8r7p+dLO6FpCI1gYd9DSiCz5+itTEQq4mM9gagqJ/RUUcHdOmphQ2ipTBgkmtBefT+YDc0s2QUppcJF2MbT2M5xxvgnErFoWQbfpmeE434LMoqJngFGNZA/MeAKF7QM/qcLvWLOf36ef0bu61N77b2tUfHH8s7uVbo1dQtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295796; c=relaxed/simple;
	bh=ougFZIosBTctHM8zWtMpj8Ny38PANKNU6OYVXuPbtLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9H3cGZtDFRih2iqc0zcyQqvZLp+6W45Sa5+SjrKxrV+vmbhvRsETluwGVzIBoJITn1555oQDm4So3cKquKIfHsP/MyqMYIPNAKfPgjQylUWlRPPoMU2x09iSdJh+zqd2LuHQbpQFo6gb4cELJaTCl0plYNoEPowyHWHzvaYRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz0Mn4KH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so5528525e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 16:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715295792; x=1715900592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPbSvLzfel2aidHv4944fpA4agv4jm4lmrU+rS2yRC4=;
        b=Bz0Mn4KH+LsXaKm37WnHMPcyUH5RBOUurbFAU5WiZgP/4AT1fIYuImcdSB9Bph118N
         hnC8b8OR41TqTAhdp9eYcLDmKGi+ro2WUJg/17kXJrBK8GJX1eklQjxWeDeHdYkDBlA9
         V4ozYePVfHQ9MMSLulAG89Ur2izUJafkvZcSb8WMfJUb0wX2fToKIRARbVymNT4W/cS0
         CM4HDL/COWzaziG5tBN+DifTKYjuG9zlEmxApxh3itH5Qf8ADKcswMfLTbUv/GrAXshm
         UPTwU60rRgjMuHqZg9XlYnbr3eKhZ27mKZfQ29Ukkc6C6XM47Cqzi0A0NS3vVvwjE/8X
         7SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295792; x=1715900592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPbSvLzfel2aidHv4944fpA4agv4jm4lmrU+rS2yRC4=;
        b=oplkbbZFRsvvKqxgWJOdcVZQOuAFefgF/WbBcqfVsSkSR/0edVFihPILnArjn+6MyH
         /dak5jOdl6qUUyoPU8Vwwi59Mf0SG5s/S1NpLgcvv8REx/h+E2SCQNysmKvvMi12Ylpc
         hWfQz9bKnf/8yFbUTzbXP0aVg3YQ88fzhMrhiSL17Yz90Y0PtKW1iIv9KigFMpJBdn7y
         6lMB0j8wNFlDIYbzIZ4GEhGAF79Khg9Bu+R/6yoxMBCVQ1Boepath+0Qw1ym+eYoUlKi
         x6Y206XJzAFhQtRjrO+FqV9K58FdlB/R0fdaG5jf/QKWgziFxVo9rj/Cb3Ld5Na9Jfij
         nJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXghy4rCCjKnfZMBvqk6WhHr5SlDDnC++e1+AVHta1Ycy9t1uVpUKl5Lhiwl+hgQ2MXReuNRNaW7T1kmqOLaKZTYaMXvrGeS5F6NRd9
X-Gm-Message-State: AOJu0YxbIdP1E0rASeEGXEhu8n/BzVyE4Gq/K2TTUa0MLnMrxdyiRxXT
	eW+78034nQZ+H7ocCfFg0+NYSigzXLKV7stz4E1QwA/s6/SJoGIWOl1HjNgXrdGuYdY8UyCLMWi
	n/QVWT4LbaKlHQ6wnMdg/E1D5OaMhyvdeYjSc
X-Google-Smtp-Source: AGHT+IFhmWSmgHAekjGKzRtk8e+YHHuEDjTnB0xuUIijeYWCpcIdqwfIqifcfRX9laqU/XyPu9INnEX+SjRuGN5KTmg=
X-Received: by 2002:a05:6000:e43:b0:34e:21cd:dbf3 with SMTP id
 ffacd0b85a97d-3504a73ec96mr677219f8f.36.1715295792241; Thu, 09 May 2024
 16:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509203907.504891-1-axelrasmussen@google.com>
 <20240509203907.504891-2-axelrasmussen@google.com> <Zj06qh2U0wTwAZLK@x1n>
In-Reply-To: <Zj06qh2U0wTwAZLK@x1n>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 9 May 2024 16:02:33 -0700
Message-ID: <CAJHvVcj1+GQoweAU0X=0Q-jx2ZC1yUsm1GsCQLsFRQ8fCzNWNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/fault: don't print logs for simulated poison errors
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, John Hubbard <jhubbard@nvidia.com>, 
	Liu Shixin <liushixin2@huawei.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:05=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, May 09, 2024 at 01:39:07PM -0700, Axel Rasmussen wrote:
> > For real MCEs, various architectures print log messages when poisoned
> > memory is accessed (which results in a SIGBUS). These messages can be
> > important for users to understand the issue.
> >
> > On the other hand, we have the userfaultfd UFFDIO_POISON operation,
> > which can "simulate" memory poisoning. That particular process will get
>
> It also coveres swapin errors as we talked before, so not always SIM.
>
> I was thinking we should also do that report for swapin errors, however
> then I noticed it wasn't reported before the replacement of pte markers,
> in commit 15520a3f04, since 2022:
>
> @@ -3727,8 +3731,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                         put_page(vmf->page);
>                 } else if (is_hwpoison_entry(entry)) {
>                         ret =3D VM_FAULT_HWPOISON;
> -               } else if (is_swapin_error_entry(entry)) {
> -                       ret =3D VM_FAULT_SIGBUS;
>                 } else if (is_pte_marker_entry(entry)) {
>                         ret =3D handle_pte_marker(vmf);
>                 } else {
>
> So I am guessing it could be fine to just turn this report off to syslog.
> There will be a back-and-forth on this behavior, but hopefully this is ev=
en
> rarer than hwpoison so nobody will notice.
>
> With that, the idea looks valid to me, but perhaps a rename is needed.
> Maybe _QUIESCE or _SILENT?

Ah, I had forgotten about the swapin error case.

I think it still makes sense to silence the log in that case; if we
consider a scenario like disk error, it could seem weird to get an MCE
message for that, since the physical memory is fine and it wouldn't
show up in mcelog or similar.

I like _SILENT, I'll do the rename and update my comments to better
explain in v2.

>
> > SIGBUS on access to the memory, but this effect is tied to an MM, rathe=
r
> > than being global like a real poison event. So, we don't want to log
> > about this case to the global kernel log; instead, let the process
> > itself log or whatever else it wants to do. This avoids spamming the
> > kernel log, and avoids e.g. drowning out real events with simulated
> > ones.
> >
> > To identify this situation, add a new VM_FAULT_HWPOISON_SIM flag. This
> > is expected to be set *in addition to* one of the existing
> > VM_FAULT_HWPOISON or VM_FAULT_HWPOISON_LARGE flags (which are mutually
> > exclusive).
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  arch/parisc/mm/fault.c   | 7 +++++--
> >  arch/powerpc/mm/fault.c  | 6 ++++--
> >  arch/x86/mm/fault.c      | 6 ++++--
> >  include/linux/mm_types.h | 5 +++++
> >  mm/hugetlb.c             | 3 ++-
> >  mm/memory.c              | 2 +-
> >  6 files changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> > index c39de84e98b0..e5370bcadf27 100644
> > --- a/arch/parisc/mm/fault.c
> > +++ b/arch/parisc/mm/fault.c
> > @@ -400,9 +400,12 @@ void do_page_fault(struct pt_regs *regs, unsigned =
long code,
> >  #ifdef CONFIG_MEMORY_FAILURE
> >               if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) =
{
> >                       unsigned int lsb =3D 0;
> > -                     printk(KERN_ERR
> > +
> > +                     if (!(fault & VM_FAULT_HWPOISON_SIM)) {
> > +                             pr_err(
> >       "MCE: Killing %s:%d due to hardware memory corruption fault at %0=
8lx\n",
> > -                     tsk->comm, tsk->pid, address);
> > +                             tsk->comm, tsk->pid, address);
> > +                     }
> >                       /*
> >                        * Either small page or large page may be poisone=
d.
> >                        * In other words, VM_FAULT_HWPOISON_LARGE and
> > diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> > index 53335ae21a40..ac5e8a3c7fba 100644
> > --- a/arch/powerpc/mm/fault.c
> > +++ b/arch/powerpc/mm/fault.c
> > @@ -140,8 +140,10 @@ static int do_sigbus(struct pt_regs *regs, unsigne=
d long address,
> >       if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> >               unsigned int lsb =3D 0; /* shutup gcc */
> >
> > -             pr_err("MCE: Killing %s:%d due to hardware memory corrupt=
ion fault at %lx\n",
> > -                     current->comm, current->pid, address);
> > +             if (!(fault & VM_FAULT_HWPOISON_SIM)) {
> > +                     pr_err("MCE: Killing %s:%d due to hardware memory=
 corruption fault at %lx\n",
> > +                             current->comm, current->pid, address);
> > +             }
> >
> >               if (fault & VM_FAULT_HWPOISON_LARGE)
> >                       lsb =3D hstate_index_to_shift(VM_FAULT_GET_HINDEX=
(fault));
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index e4f3c7721f45..16d077a3ad14 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -928,9 +928,11 @@ do_sigbus(struct pt_regs *regs, unsigned long erro=
r_code, unsigned long address,
> >               struct task_struct *tsk =3D current;
> >               unsigned lsb =3D 0;
> >
> > -             pr_err_ratelimited(
> > +             if (!(fault & VM_FAULT_HWPOISON_SIM)) {
> > +                     pr_err_ratelimited(
> >       "MCE: Killing %s:%d due to hardware memory corruption fault at %l=
x\n",
> > -                     tsk->comm, tsk->pid, address);
> > +                             tsk->comm, tsk->pid, address);
> > +             }
> >               if (fault & VM_FAULT_HWPOISON_LARGE)
> >                       lsb =3D hstate_index_to_shift(VM_FAULT_GET_HINDEX=
(fault));
> >               if (fault & VM_FAULT_HWPOISON)
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5240bd7bca33..7f8fc3efc5b2 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -1226,6 +1226,9 @@ typedef __bitwise unsigned int vm_fault_t;
> >   * @VM_FAULT_HWPOISON_LARGE: Hit poisoned large page. Index encoded
> >   *                           in upper bits
> >   * @VM_FAULT_SIGSEGV:                segmentation fault
> > + * @VM_FAULT_HWPOISON_SIM    Hit poisoned, PTE marker; this indicates =
a
> > + *                           simulated poison (e.g. via usefaultfd's
> > + *                              UFFDIO_POISON), not a "real" hwerror.
> >   * @VM_FAULT_NOPAGE:         ->fault installed the pte, not return pag=
e
> >   * @VM_FAULT_LOCKED:         ->fault locked the returned page
> >   * @VM_FAULT_RETRY:          ->fault blocked, must retry
> > @@ -1245,6 +1248,7 @@ enum vm_fault_reason {
> >       VM_FAULT_HWPOISON       =3D (__force vm_fault_t)0x000010,
> >       VM_FAULT_HWPOISON_LARGE =3D (__force vm_fault_t)0x000020,
> >       VM_FAULT_SIGSEGV        =3D (__force vm_fault_t)0x000040,
> > +     VM_FAULT_HWPOISON_SIM   =3D (__force vm_fault_t)0x000080,
> >       VM_FAULT_NOPAGE         =3D (__force vm_fault_t)0x000100,
> >       VM_FAULT_LOCKED         =3D (__force vm_fault_t)0x000200,
> >       VM_FAULT_RETRY          =3D (__force vm_fault_t)0x000400,
> > @@ -1270,6 +1274,7 @@ enum vm_fault_reason {
> >       { VM_FAULT_HWPOISON,            "HWPOISON" },   \
> >       { VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },     \
> >       { VM_FAULT_SIGSEGV,             "SIGSEGV" },    \
> > +     { VM_FAULT_HWPOISON_SIM,        "HWPOISON_SIM" },       \
> >       { VM_FAULT_NOPAGE,              "NOPAGE" },     \
> >       { VM_FAULT_LOCKED,              "LOCKED" },     \
> >       { VM_FAULT_RETRY,               "RETRY" },      \
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 65456230cc71..2b4e0173e806 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6485,7 +6485,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, st=
ruct vm_area_struct *vma,
> >                               pte_marker_get(pte_to_swp_entry(entry));
> >
> >                       if (marker & PTE_MARKER_POISONED) {
> > -                             ret =3D VM_FAULT_HWPOISON_LARGE |
> > +                             ret =3D VM_FAULT_HWPOISON_SIM |
> > +                                   VM_FAULT_HWPOISON_LARGE |
> >                                     VM_FAULT_SET_HINDEX(hstate_index(h)=
);
> >                               goto out_mutex;
> >                       }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d2155ced45f8..29a833b996ae 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3910,7 +3910,7 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
> >
> >       /* Higher priority than uffd-wp when data corrupted */
> >       if (marker & PTE_MARKER_POISONED)
> > -             return VM_FAULT_HWPOISON;
> > +             return VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_SIM;
> >
> >       if (pte_marker_entry_uffd_wp(entry))
> >               return pte_marker_handle_uffd_wp(vmf);
> > --
> > 2.45.0.118.g7fe29c98d7-goog
> >
>
> --
> Peter Xu
>

