Return-Path: <linux-kernel+bounces-175050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6328C1995
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4740DB21980
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466B312D215;
	Thu,  9 May 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQ+rQdz7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493912DD94
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294890; cv=none; b=BZaWKi54/O6WzSMcdLmzW7Ci2eJmesc7V7M/k12+mOCzTJoC7WPD7C6r8FGu5O1UQULVBHOTdYgAVtkjkkU0eBiGVMIWEFRladCT04hL0q4cNB4QFw/95yHFePs85n2W/eJiNiDnHfKrKgOjQ7jCDw1KGne4U0sbb678WYMHuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294890; c=relaxed/simple;
	bh=3pQ2pM0pNtObEYnZAZ2vpgXGO/JvkW+6q5AWn6pdmPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHrxTPm30p0Bg0LtyHnSXLLWxrzP5hsU1wTNzfsohQ7+kGG2BNjWOjommraiBs/orF1eCQhDXANkV+9R0UZfjVmlCIiJgkZlXeiArD1Ye0GUAIOTBwQnHM85DslOC4DhWUca6YEFQeEmWib9z1POIAtt4KaCd9rpfCIKtM1ylsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQ+rQdz7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so13885055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715294886; x=1715899686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIWDSYU6OuwVNwMdVt3NyqDL4ZMH/MF1rCPe+F0j3bE=;
        b=AQ+rQdz7blSFCviCN7OMSRrL/kuEMFX8gKxUdd1G0Wo4RwuH2950mOhgddCaClrvKO
         2zx6dggk+zGsqZz357yd9cqtCfuk5WAZV8vdrvim5dv0TUw6u5CnLPS/R1tA5eLE5sEP
         Fj4TYbUb+nNX2ntkcLrhhjW/LHH+c+eC6vAD08ZOMUKK5wtM5K2XXAQa0dgBnqF8FInl
         L/FPHtANzfU1NvjNwGowsgby5eHPmd51Gy/kVklAci4Mws24esDQh5DtUJ3wse3/bFXw
         DhvfJ5S3pwofuEWoPKSIUdGrkruEMqGs/2hSxg6hQsLgoYlQRAWCJ8nh51Ymavg9YYEh
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715294886; x=1715899686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIWDSYU6OuwVNwMdVt3NyqDL4ZMH/MF1rCPe+F0j3bE=;
        b=bbFCyGE4R65y6/UNpN7yse8Qc9HL/Ad60ckCBuLorz81IHK/wuWdzAM+0o4n65HvlT
         qmMMcMgxabf0R7BfFfBhOjM6s2TkGg7FDiN54YhHBQtaF3OvOYpDfK7h50AH0Fb1EL/i
         dbFJNAfHeZija8t4NJ+SN8X41xDH0WrfiyjROygogBEpOaQiFfKNN1ooGn2DFzs9K/q8
         5OIg5Wy4q9Wl+movh71S0QJxyZUcWXitzr7O6UaiTa0yYenmL3XN+CiD8BiosFcCX2Ty
         a64ksZx8PoFkTVWTuytPpm6DB7G0Q6SQXdl/Mmmw/sWpXtM6Tn9gzeMhVokYwKRx03ts
         Q8/g==
X-Forwarded-Encrypted: i=1; AJvYcCW4Jr2cmUoPQIXen0yZYqIUm1Ndy8JZ2Fsfk4v6g3xvM8Op+pMT+cfsoFn5uh8k1vk+BPThhf3eR332YPl4vIJk8Ul7Fzm9FrHrY1d/
X-Gm-Message-State: AOJu0Yx2I6SgEAWZfevVaInMQAdItpMLZu1RDbWgor9lm1PgdPu7EywA
	tNgoVINeNfXgSqgDazIT6FMn/PP2D0OJ990YlviaRnZ7HZl8siWrooK4/+sLjZJZUhl/WviZs6X
	08K2fmlGj70QVsdjGJWX+jT98mAPyR999KOk5
X-Google-Smtp-Source: AGHT+IGJ/kKXUorUaZZLbLqtiS22JS9DgQC8DqDR6SQS2KcbUYgiLFSj2QMhwsrOQuNMZTIT+bZq0i18Q89RY9Bdtlc=
X-Received: by 2002:a5d:5f4e:0:b0:350:4da3:db43 with SMTP id
 ffacd0b85a97d-3504da3dde7mr436361f8f.35.1715294886227; Thu, 09 May 2024
 15:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509203907.504891-1-axelrasmussen@google.com>
 <20240509203907.504891-2-axelrasmussen@google.com> <d04a838b-848d-405d-9317-40282cd58c36@nvidia.com>
In-Reply-To: <d04a838b-848d-405d-9317-40282cd58c36@nvidia.com>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 9 May 2024 15:47:29 -0700
Message-ID: <CAJHvVciOwHNFBfhQhaQLwaby0VojNNw6Mx1kJ38dgc4cQgEksA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/fault: don't print logs for simulated poison errors
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Liu Shixin <liushixin2@huawei.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Muchun Song <muchun.song@linux.dev>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 2:30=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/9/24 1:39 PM, Axel Rasmussen wrote:
> > For real MCEs, various architectures print log messages when poisoned
> > memory is accessed (which results in a SIGBUS). These messages can be
> > important for users to understand the issue.
> >
> > On the other hand, we have the userfaultfd UFFDIO_POISON operation,
> > which can "simulate" memory poisoning. That particular process will get
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
> >   arch/parisc/mm/fault.c   | 7 +++++--
> >   arch/powerpc/mm/fault.c  | 6 ++++--
> >   arch/x86/mm/fault.c      | 6 ++++--
> >   include/linux/mm_types.h | 5 +++++
> >   mm/hugetlb.c             | 3 ++-
> >   mm/memory.c              | 2 +-
> >   6 files changed, 21 insertions(+), 8 deletions(-)
> >
>
> This completely fixes the uffd-unit-test behavior, I just did a quick
> test run to be sure as well.
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks John!

And, no problem about the other patch, they aren't functionally
dependent, I just hoped to save Andrew dealing with the small merge
conflict. :) I'll base a v2 on mm-unstable directly and that should
clear everything up.

>
> thanks,
> --
> John Hubbard
> NVIDIA
>
>
> > diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> > index c39de84e98b0..e5370bcadf27 100644
> > --- a/arch/parisc/mm/fault.c
> > +++ b/arch/parisc/mm/fault.c
> > @@ -400,9 +400,12 @@ void do_page_fault(struct pt_regs *regs, unsigned =
long code,
> >   #ifdef CONFIG_MEMORY_FAILURE
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
> >    * @VM_FAULT_HWPOISON_LARGE:        Hit poisoned large page. Index en=
coded
> >    *                          in upper bits
> >    * @VM_FAULT_SIGSEGV:               segmentation fault
> > + * @VM_FAULT_HWPOISON_SIM    Hit poisoned, PTE marker; this indicates =
a
> > + *                           simulated poison (e.g. via usefaultfd's

I'll also fix this small typo in a v2. :P

> > + *                              UFFDIO_POISON), not a "real" hwerror.
> >    * @VM_FAULT_NOPAGE:                ->fault installed the pte, not re=
turn page
> >    * @VM_FAULT_LOCKED:                ->fault locked the returned page
> >    * @VM_FAULT_RETRY:         ->fault blocked, must retry
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
>
>

