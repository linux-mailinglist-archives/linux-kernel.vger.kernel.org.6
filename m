Return-Path: <linux-kernel+bounces-345034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953F98B14E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4546F282CA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E3F63D;
	Tue,  1 Oct 2024 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XmLQFkMj"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA04A06
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727741467; cv=none; b=VEEjlyxMNncFGZALhg4sD7r4IhHFwzatt/dkh2N/hlLRSdMgOZ6WnpBHKjRgVHR567lBaZFjXGe8CX7ztCzXlUcxWAOr3XT0IPqpjFxm2R9Wt20x05mDEd50Z1JGcqTPC0xIfk+aOBr2jfg6uruAdNv9+V08Z6+BNZCMGeckEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727741467; c=relaxed/simple;
	bh=VPBRk92HDYW10Wejmj93MDvgygR226kHsSR/g2AsYZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8MRUX/FxJNHywupqQ76ltN/CGuxLFq2TMDsNzZBKXHCCl5UZCycsfpY85LU11oxSE48FIcOh2IcdTZXejhMsRfJ0Ymk075ctQZC1PYhC7wynv6J9sqYLhYu0s+SarTeUk4U1MR/1tOVi3Xgx+66lOi65dLNg5xUeU2QINIlZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XmLQFkMj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710e6ea4782so242978a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727741464; x=1728346264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYIhQuQyrgIb71lFMbyvqR0+xGcABu5yqY0eNiGeS9I=;
        b=XmLQFkMjR0eyWs2kMy39OJ5ZIFHyk8Re4HJNPhmEmYnrHcy/DTc+Bgs79BlsCQDgCV
         7WmzCcwZ59powP2SeiTJ84PRv9+rYBiYqPeMhBOae7IztFWcLHSZ+8qZ5FirumZKJEQp
         +MM1wwlwVtbD32TXcbtlvdRNGMsy717e0jx/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727741464; x=1728346264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYIhQuQyrgIb71lFMbyvqR0+xGcABu5yqY0eNiGeS9I=;
        b=KSslKyNFQ+woMyQj4KF0YAoT4esN0DduiPFoyUAC7rT3WHO3Dd4eY+sCWLnEO64OFZ
         Y9xiZ04O2YA+2KywbIPpwChcIa04IHmAZGTFfSMpP1toGR9mT3KccOs5FFTXlsRh7lGS
         4LOW+fdKhGo8igKE/qJcxAdkECLAbLuvUrUmohFFhQZ4uXehD8djqnNDfcAAotMhhEA7
         yr764x1H9ZxSD774ZCuOZ+f+0acJE7oZQAKsYaevioxIYqCGyEpSw0NrwKgcYdrYJrFU
         hTqOmxhoI5OuxW/Qw3U19bfYmN6CRUn5QfMFpLDGNgTDAdi8Xl0shB3WRQmxo8189n3u
         nMNw==
X-Forwarded-Encrypted: i=1; AJvYcCUBjM1KNxNXu7xRBuUoXEdy+/h3wQga0FG9FS2abeLLYOMvM+0PgtmmOflOXJU+fq+oTwk4YDXZwL3BplM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0L/Rnmby3x7RrVHsBdx62sPOVt421rUJeS9KB0EKYWEUDl8N
	Zj9kmpbEaF8H9PHADdr01gm4vHxQyCZKjy7rau4Xx7oXzC5sA4Xmozc2IOsgMufLQlt4of6SXAr
	RBVThHbiQzgGnVRipd8uZYvccmqN/aaOX/tmM
X-Google-Smtp-Source: AGHT+IHkTC67kdtitJmTweBhFIvxD1KyNztOpZA9ELwxb4wHBh1nfykCot+x+dbjbIDOdkC/k4Y48MpuCCd5YOMD+vU=
X-Received: by 2002:a05:6871:610:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-2872aa4c7f3mr1565240fac.6.1727741463534; Mon, 30 Sep 2024
 17:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <b7864e63-bb74-4ab2-a7ae-48662b27e234@infradead.org>
In-Reply-To: <b7864e63-bb74-4ab2-a7ae-48662b27e234@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 30 Sep 2024 17:10:50 -0700
Message-ID: <CABi2SkUrvCcfydP9ejbeCxNms4BcgbhjOHgmvQyPBa_kgdUMPw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Sat, Sep 28, 2024 at 11:28=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 9/27/24 11:52 AM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update doc after in-loop change: mprotect/madvise can have
> > partially updated and munmap is atomic.
> >
> > Fix indentation and clarify some sections to improve readability.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
> >  1 file changed, 136 insertions(+), 154 deletions(-)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 4132eec995a3..68986084e191 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -23,177 +23,159 @@ applications can additionally seal security criti=
cal data at runtime.
> >  A similar feature already exists in the XNU kernel with the
> >  VM_FLAGS_PERMANENT flag [1] and on OpenBSD with the mimmutable syscall=
 [2].
> >
> > -User API
> > -=3D=3D=3D=3D=3D=3D=3D=3D
> > -mseal()
> > ------------
> > -The mseal() syscall has the following signature:
> > -
> > -``int mseal(void addr, size_t len, unsigned long flags)``
> > -
> > -**addr/len**: virtual memory address range.
> > -
> > -The address range set by ``addr``/``len`` must meet:
> > -   - The start address must be in an allocated VMA.
> > -   - The start address must be page aligned.
> > -   - The end address (``addr`` + ``len``) must be in an allocated VMA.
> > -   - no gap (unallocated memory) between start and end address.
> > -
> > -The ``len`` will be paged aligned implicitly by the kernel.
> > -
> > -**flags**: reserved for future use.
> > -
> > -**return values**:
> > -
> > -- ``0``: Success.
> > -
> > -- ``-EINVAL``:
> > -    - Invalid input ``flags``.
> > -    - The start address (``addr``) is not page aligned.
> > -    - Address range (``addr`` + ``len``) overflow.
> > -
> > -- ``-ENOMEM``:
> > -    - The start address (``addr``) is not allocated.
> > -    - The end address (``addr`` + ``len``) is not allocated.
> > -    - A gap (unallocated memory) between start and end address.
> > -
> > -- ``-EPERM``:
> > -    - sealing is supported only on 64-bit CPUs, 32-bit is not supporte=
d.
> > -
> > -- For above error cases, users can expect the given memory range is
> > -  unmodified, i.e. no partial update.
> > -
> > -- There might be other internal errors/cases not listed here, e.g.
> > -  error during merging/splitting VMAs, or the process reaching the max
> > -  number of supported VMAs. In those cases, partial updates to the giv=
en
> > -  memory range could happen. However, those cases should be rare.
> > -
> > -**Blocked operations after sealing**:
> > -    Unmapping, moving to another location, and shrinking the size,
> > -    via munmap() and mremap(), can leave an empty space, therefore
> > -    can be replaced with a VMA with a new set of attributes.
> > -
> > -    Moving or expanding a different VMA into the current location,
> > -    via mremap().
> > -
> > -    Modifying a VMA via mmap(MAP_FIXED).
> > -
> > -    Size expansion, via mremap(), does not appear to pose any
> > -    specific risks to sealed VMAs. It is included anyway because
> > -    the use case is unclear. In any case, users can rely on
> > -    merging to expand a sealed VMA.
> > -
> > -    mprotect() and pkey_mprotect().
> > -
> > -    Some destructive madvice() behaviors (e.g. MADV_DONTNEED)
> > -    for anonymous memory, when users don't have write permission to th=
e
> > -    memory. Those behaviors can alter region contents by discarding pa=
ges,
> > -    effectively a memset(0) for anonymous memory.
> > -
> > -    Kernel will return -EPERM for blocked operations.
> > -
> > -    For blocked operations, one can expect the given address is unmodi=
fied,
> > -    i.e. no partial update. Note, this is different from existing mm
> > -    system call behaviors, where partial updates are made till an erro=
r is
> > -    found and returned to userspace. To give an example:
> > -
> > -    Assume following code sequence:
> > -
> > -    - ptr =3D mmap(null, 8192, PROT_NONE);
> > -    - munmap(ptr + 4096, 4096);
> > -    - ret1 =3D mprotect(ptr, 8192, PROT_READ);
> > -    - mseal(ptr, 4096);
> > -    - ret2 =3D mprotect(ptr, 8192, PROT_NONE);
> > -
> > -    ret1 will be -ENOMEM, the page from ptr is updated to PROT_READ.
> > -
> > -    ret2 will be -EPERM, the page remains to be PROT_READ.
> > -
> > -**Note**:
> > -
> > -- mseal() only works on 64-bit CPUs, not 32-bit CPU.
> > -
> > -- users can call mseal() multiple times, mseal() on an already sealed =
memory
> > -  is a no-action (not error).
> > -
> > -- munseal() is not supported.
> > +SYSCALL
> > +=3D=3D=3D=3D=3D=3D=3D
> > +mseal syscall signature
> > +-----------------------
> > +   **int** mseal(**void \*** addr, **size_t** len, **unsigned long** f=
lags)
>
> ugh. totally unreadable for people who just look at .rst files.
>
Right!
The ** (bold) in rst collides with a pointer in c. it does make it
unreadable. I will  remove them.

> Does other documentation go to this extreme?
>
> > +
> > +   **addr**/**len**: virtual memory address range.
> > +      The address range set by **addr**/**len** must meet:
> > +         - The start address must be in an allocated VMA.
> > +         - The start address must be page aligned.
> > +         - The end address (**addr** + **len**) must be in an allocate=
d VMA.
> > +         - no gap (unallocated memory) between start and end address.
> > +
> > +      The ``len`` will be paged aligned implicitly by the kernel.
> > +
> > +   **flags**: reserved for future use.
> > +
> > +   **Return values**:
> > +      - **0**: Success.
> > +      - **-EINVAL**:
> > +         * Invalid input ``flags``.
> > +         * The start address (``addr``) is not page aligned.
> > +         * Address range (``addr`` + ``len``) overflow.
> > +      - **-ENOMEM**:
> > +         * The start address (``addr``) is not allocated.
> > +         * The end address (``addr`` + ``len``) is not allocated.
> > +         * A gap (unallocated memory) between start and end address.
> > +      - **-EPERM**:
> > +         * sealing is supported only on 64-bit CPUs, 32-bit is not sup=
ported.
> > +
> > +   **Note about error return**:
> > +      - For above error cases, users can expect the given memory range=
 is
> > +        unmodified, i.e. no partial update.
> > +      - There might be other internal errors/cases not listed here, e.=
g.
> > +        error during merging/splitting VMAs, or the process reaching t=
he max
> > +        number of supported VMAs. In those cases, partial updates to t=
he given
> > +        memory range could happen. However, those cases should be rare=
.
> > +
> > +   **Architecture support**:
> > +      mseal only works on 64-bit CPUs, not 32-bit CPU.
>
>                                                      CPUs.
>
Done, thanks.

> > +
> > +   **Idempotent**:
> > +      users can call mseal multiple times, mseal on an already sealed =
memory
>
>                                        times. mseal
>
Done, thanks.

> > +      is a no-action (not error).
> > +
> > +   **no munseal**
> > +      Once mapping is sealed, it can't be unsealed. kernel should neve=
r
> > +      have munseal, this is consistent with other sealing feature, e.g=
.
> > +      F_SEAL_SEAL for file.
> > +
> > +Blocked mm syscall for sealed mapping
> > +-------------------------------------
> > +   It might be imporant to note: **once the mapping is sealed, it will
>
>                   important
>
Done, thanks.

> > +   stay in the process's memory till the process terminates**.
> > +
> > +   Example::
> > +
> > +         *ptr =3D mmap(0, 4096, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE=
, 0, 0);
> > +         rc =3D mseal(ptr, 4096, 0);
> > +         /* munmap will fail */
> > +         rc =3D munmap(ptr, 4096);
> > +         assert(rc < 0);
> > +
> > +   Blocked mm syscall:
> > +      - munmap
> > +      - mmap
> > +      - mremap
> > +      - mprotect and pkey_mprotect
> > +      - some destructive madvise behaviors: MADV_DONTNEED, MADV_FREE,
> > +        MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFOR=
K
> > +
> > +   The first set of syscall to block is munmap, mremap, mmap. They can
> > +   either leave an empty space in the address space, therefore allow
> > +   replacement with a new mapping with new set of attributes, or can
> > +   overwrite the existing mapping with another mapping.
> > +
> > +   mprotect and pkey_mprotect are blocked because they changes the
> > +   protection bits (rwx) of the mapping.
>
> preferably            (RWX)
>
Done.

> > +
> > +   Some destructive madvice behaviors (MADV_DONTNEED, MADV_FREE,
>
>                        madvise
>
Done.

> > +   MADV_DONTNEED_LOCKED, MADV_FREE, MADV_DONTFORK, MADV_WIPEONFORK)
> > +   for anonymous memory, when users don't have write permission to the
> > +   memory. Those behaviors can alter region contents by discarding pag=
es,
> > +   effectively a memset(0) for anonymous memory.
> > +
> > +   Kernel will return -EPERM for blocked syscalls.
> > +
> > +   When blocked syscall return -EPERM due to sealing, the memory regio=
ns may or may not be changed, depends on the syscall being blocked:
> > +      - munmap: munmap is atomic. If one of VMAs in the given range is
> > +        sealed, none of VMAs are updated.
> > +      - mprotect, pkey_mprotect, madvise: partial update might happen,=
 e.g.
> > +        when mprotect over multiple VMAs, mprotect might update the be=
ginning
> > +        VMAs before reaching the sealed VMA and return -EPERM.
> > +      - mmap and mremap: undefined behavior.
> >
> >  Use cases:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  - glibc:
> >    The dynamic linker, during loading ELF executables, can apply sealin=
g to
> > -  non-writable memory segments.
> > +  mapping segments.
> >
> >  - Chrome browser: protect some security sensitive data-structures.
>
>                                                      data structures.
>
Done. Thanks.

> >
> > -Notes on which memory to seal:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > -
> > -It might be important to note that sealing changes the lifetime of a m=
apping,
> > -i.e. the sealed mapping won=E2=80=99t be unmapped till the process ter=
minates or the
> > -exec system call is invoked. Applications can apply sealing to any vir=
tual
> > -memory region from userspace, but it is crucial to thoroughly analyze =
the
> > -mapping's lifetime prior to apply the sealing.
> > +Don't use mseal on:
>
> Drop the ':'. Headings should not uses trailing colons.
> (throughout this file)
>
Done everywhere. Thanks.

> Maybe change the heading to "When not to use mseal".
>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Applications can apply sealing to any virtual memory region from users=
pace,
> > +but it is *crucial to thoroughly analyze the mapping's lifetime* prior=
 to
> > +apply the sealing. This is because the sealed mapping *won=E2=80=99t b=
e unmapped*
> > +till the process terminates or the exec system call is invoked.
>
> s/till/until/ preferably.
>
ok.

> >
> >  For example:
> > +   - aio/shm
> > +     aio/shm can call mmap and  munmap on behalf of userspace, e.g.
> > +     ksys_shmdt() in shm.c. The lifetime of those mapping are not tied=
 to
> > +     the lifetime of the process. If those memories are sealed from us=
erspace,
> > +     then munmap will fail, causing leaks in VMA address space during =
the
> > +     lifetime of the process.
> > +
> > +   - ptr allocated by malloc (heap)
> > +     Don't use mseal on the memory ptr return from malloc().
> > +     malloc() is implemented by allocator, e.g. by glibc. Heap manager=
 might
> > +     allocate a ptr from brk or mapping created by mmap.
> > +     If app calls mseal on ptr returned from malloc(), this can affect=
 the heap
>
>         If an app calls mseal on a ptr
>
Done. thanks

>
> > +     manager's ability to manage the mappings, the outcome is non-dete=
rministic.
>
>                                         mappings; the outcome
>
Done, thanks.

> > +     Example::
> > +
> > +        ptr =3D malloc(size);
> > +        /* don't call mseal on ptr return from malloc. */
> > +        mseal(ptr, size);
> > +        /* free will success, allocator can't shrink heap lower than p=
tr */
> > +        free(ptr);
> > +
> > +mseal doesn't block:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +In a nutshell, mseal blocks certain mm syscall from modifying some of =
VMA's
> > +attributes, such as protection bits (rwx). Sealed mappings doesn't mea=
n the
>
> preferably                             (RWX).
>
Done, thanks.

> > +memory is immutable.
> >
> > -- aio/shm
> > -
> > -  aio/shm can call mmap()/munmap() on behalf of userspace, e.g. ksys_s=
hmdt() in
> > -  shm.c. The lifetime of those mapping are not tied to the lifetime of=
 the
>
>                 lifetimes
OK.
> ?
>
> > -  process. If those memories are sealed from userspace, then munmap() =
will fail,
> > -  causing leaks in VMA address space during the lifetime of the proces=
s.
> > -
> > -- Brk (heap)
> > -
> > -  Currently, userspace applications can seal parts of the heap by call=
ing
> > -  malloc() and mseal().
> > -  let's assume following calls from user space:
> > -
> > -  - ptr =3D malloc(size);
> > -  - mprotect(ptr, size, RO);
> > -  - mseal(ptr, size);
> > -  - free(ptr);
> > -
> > -  Technically, before mseal() is added, the user can change the protec=
tion of
> > -  the heap by calling mprotect(RO). As long as the user changes the pr=
otection
> > -  back to RW before free(), the memory range can be reused.
> > -
> > -  Adding mseal() into the picture, however, the heap is then sealed pa=
rtially,
> > -  the user can still free it, but the memory remains to be RO. If the =
address
> > -  is re-used by the heap manager for another malloc, the process might=
 crash
> > -  soon after. Therefore, it is important not to apply sealing to any m=
emory
> > -  that might get recycled.
> > -
> > -  Furthermore, even if the application never calls the free() for the =
ptr,
> > -  the heap manager may invoke the brk system call to shrink the size o=
f the
> > -  heap. In the kernel, the brk-shrink will call munmap(). Consequently=
,
> > -  depending on the location of the ptr, the outcome of brk-shrink is
> > -  nondeterministic.
> > -
> > -
> > -Additional notes:
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  As Jann Horn pointed out in [3], there are still a few ways to write
> > -to RO memory, which is, in a way, by design. Those cases are not cover=
ed
> > -by mseal(). If applications want to block such cases, sandbox tools (s=
uch as
> > -seccomp, LSM, etc) might be considered.
> > +to RO memory, which is, in a way, by design. And those could be blocke=
d
> > +by different security measures.
> >
> >  Those cases are:
> > -
> > -- Write to read-only memory through /proc/self/mem interface.
> > -- Write to read-only memory through ptrace (such as PTRACE_POKETEXT).
> > -- userfaultfd.
> > +   - Write to read-only memory through /proc/self/mem interface (FOLL_=
FORCE).
> > +   - Write to read-only memory through ptrace (such as PTRACE_POKETEXT=
).
> > +   - userfaultfd.
> >
> >  The idea that inspired this patch comes from Stephen R=C3=B6ttger=E2=
=80=99s work in V8
> >  CFI [4]. Chrome browser in ChromeOS will be the first user of this API=
.
> >
> >  Reference:
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -[1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37a=
ff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> > -
> > -[2] https://man.openbsd.org/mimmutable.2
> > -
> > -[3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ=
426FkcgnfUGLvA@mail.gmail.com
> > -
> > -[4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmw=
dvxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
> > +- [1] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e3=
7aff177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> > +- [2] https://man.openbsd.org/mimmutable.2
> > +- [3] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2h=
zQ426FkcgnfUGLvA@mail.gmail.com
> > +- [4] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfb=
mwdvxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc

I will update and send v2.

Appreciate the review comments.
-Jeff

