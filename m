Return-Path: <linux-kernel+bounces-368381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7449A0F38
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4122863D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299D3FBA5;
	Wed, 16 Oct 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rmdaho1r"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B054F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094442; cv=none; b=Cs2mmAsikEnCnZakykx/SE03xhoJgqiHLEd6h/NX9OfxLSLg/CE5iiUYWqFzyX0dCP17Bz+zVdm42MMCrj/GlmPrKB4E7LculC1gzcooNvYoAjtqiJXcOJXLOStuQNP4YbRflvnluH/Bjs2fvOGyeBnkOM60ZxVJQVvypprH4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094442; c=relaxed/simple;
	bh=7PTo7ATdJKBztulMVqdU/OaPxvIkBpBkKwX871nJqVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gNGC9+dFe3AtSKf3UfbJ6JnPrerM2yGdep8O7I1jNAL6R4k3FuO4u2MRz+7atqVeEr5wQEwgchywqmTacXYPzNubbt4ZzN+CtH3X1vs+Kxuq8ZcdLtTfnc641V+7MmR2h91cgAevgOmCIsmAfF1HWIHmXfrSAyf+qWzp4ZHe/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rmdaho1r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso17842a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729094439; x=1729699239; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa8NFpxmV2KKMPMWE09yZK0j+QN5oO3iXzDey8XQmBI=;
        b=Rmdaho1r/0W8OzDBGy5ZJ10BFwJsyvwGylvoqBrw6u1RRuaNgnX8Mp/gRMb8/jsi6o
         oOd1B8c5hIJHBznWie+gM6tVcPpzFGsR4aaKYNVSCtBzFXvMUs74qM5815UdXh0m8vaO
         /C1HCPXEmFy21+qIglu6kZTRPZxAOVBFWFtQT+dcTLl2FAThRrDVuXVg7CIORzaR7x4t
         aAAcmHcfdME0Xy6DgVw7IE+z6s98HOBL4YjpDSB0p9f7jDHsmnO0qsgvdhsH6ehLKgrg
         SA76VBpW1peqD05SgKd0FYYt85KboG1TY4iwEhaca4yN/36nZUOgkc7vH7FgA1bdJROd
         ToXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094439; x=1729699239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa8NFpxmV2KKMPMWE09yZK0j+QN5oO3iXzDey8XQmBI=;
        b=bNPJGm9VxZ0nr/T8sccnAZsu1DoqWKR1muvGK0zskqydxVZnLZqfL/x2mtW9J0f+5X
         S83BA41X+92SMlu4m9kzr+r4fJMlyAotJ+fxwaCM2Sq0UmzqbCb45lsqao5/T3LTBwui
         udp1brdHQl31E9Fmgam2liFYr2ckte+PjPXPlzvyNZqIDRC6+QXn01I6l81MEYeIS25v
         E2okY+SjHNRVthNdxqc9kUZ+0sm/Da+foo2sXgF+raODWWLSWQeKQ/a2oQVr/10reDVK
         i/izyD/PpFoB9cPDKZvJHQ/KJCnf4dBXR2vM8PAVHLvM1VJ3y5lDgiaLY4CbiW3GbAdW
         oitQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURAjDcT4ILeS8zrrEDVylPGi8AlYeHe8f1Q2xeXWhLs+GVXFj/wa7b9thj3cx4G3Cxm3TV+9GnN2Mz0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8c8FLFVa99KqARnndhdM3ZJkiJfMvueOYtxBWYeKklID2oNHt
	rVV2biXhCyru/VY1+oC76VV9Vupb9WUDvb+VlbvMmLMW7F+XkNuEolBSS8wrrUxEezyn8iRzPGt
	KV3pNwztYyT2zA6VCi//rcdjqyNPJwtvdYs4U
X-Google-Smtp-Source: AGHT+IGTFrv2alUePOetWLW0RF+CqiSAQBuYFWA0NuJoz5ABIgUEJXZEmQ0VzCf+TPqF152AaBDGNyuugEy4WKrUbyQ=
X-Received: by 2002:a05:6402:2681:b0:5c2:5641:af79 with SMTP id
 4fb4d7f45d1cf-5c997539f25mr556341a12.0.1729094437912; Wed, 16 Oct 2024
 09:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com> <3lixuwepwvc6zqy57k2zcw4dntd7cc5cwlx7xxoieuo3pvaajy@e2p5zf5mdzon>
In-Reply-To: <3lixuwepwvc6zqy57k2zcw4dntd7cc5cwlx7xxoieuo3pvaajy@e2p5zf5mdzon>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Oct 2024 17:59:59 +0200
Message-ID: <CAG48ez02xVZzOwfx869pEh+UhRvbpq5Z4RVz_Y-S-i6Hm21Jdw@mail.gmail.com>
Subject: Re: [PATCH fix 6.12] mm: mark mas allocation in vms_abort_munmap_vmas
 as __GFP_NOFAIL
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:40=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Jann Horn <jannh@google.com> [241016 11:08]:
> > vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
> > have already been torn down halfway (in a way we can't undo) but are
> > still present in the maple tree.
> >
> > At this point, we *must* remove the VMAs from the VMA tree, otherwise
> > we get UAF.
>
> Wait, the vma should be re-attached without PTEs and files closed in
> this case.  I don't see how we are hitting the UAF in your example - we
> shouldn't unless there is something with the driver itself and the file
> close?
>
> My concern is that I am missing an error scenario.

Where are the files supposed to be closed? vms_clean_up_area() unlinks
the VMA from the file and calls ->close() but doesn't unlink the file,
right?

FWIW, I tested on commit eca631b8fe80 (current mainline head), I
didn't check whether anything in the MM tree already addresses this.
(I probably should have...)

> But since this is under a lock that allows sleeping, shouldn't the
> shrinker kick in?

Yeah, I think without error injection, you'd basically only fail this
allocation if the OOM killer has already decided to kill your task and
the system is entirely out of memory.

OOM kills IIRC have two effects on the page allocator:

1. they allow allocating with no watermarks (ALLOC_OOM) (based on the
theory that you might need to allocate some memory in order to be able
to exit and free more memory)
2. they allow giving up on GFP_KERNEL allocations (see the "/* Avoid
allocations with no watermarks from looping endlessly */" part of
__alloc_pages_slowpath())

> Should we just use __GFP_NOFAIL for the first store
> instead of the error path?

Which first store? Do you mean get rid of vms_abort_munmap_vmas()
entirely somehow?

> > Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the =
gap on failure")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > This can be tested with the following reproducer (on a kernel built wit=
h
> > CONFIG_KASAN=3Dy, CONFIG_FAILSLAB=3Dy, CONFIG_FAULT_INJECTION_DEBUG_FS=
=3Dy,
> > with the reproducer running as root):
> >
> > ```
> >
> >   typeof(x) __res =3D (x);      \
> >   if (__res =3D=3D (typeof(x))-1) \
> >     err(1, "SYSCHK(" #x ")"); \
> >   __res;                      \
> > })
> >
> > static void write_file(char *name, char *buf) {
> >   int fd =3D open(name, O_WRONLY);
> >   if (fd =3D=3D -1)
> >     err(1, "unable to open for writing: %s", name);
> >   if (SYSCHK(write(fd, buf, strlen(buf))) !=3D strlen(buf))
> >     errx(1, "write %s", name);
> >   SYSCHK(close(fd));
> > }
> >
> > int main(void) {
> >   // make a large area with a bunch of VMAs
> >   char *area =3D SYSCHK(mmap(NULL, AREA_SIZE, PROT_NONE, MAP_PRIVATE|MA=
P_ANONYMOUS, -1, 0));
> >   for (int off=3D0; off<AREA_SIZE; off +=3D 0x2000)
> >     SYSCHK(mmap(area+off, 0x1000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MAP_=
ANONYMOUS, -1, 0));
> >
> >   // open a file whose mappings use usbdev_vm_ops, and map it in part o=
f this area
> >   int map_fd =3D SYSCHK(open("/dev/bus/usb/001/001", O_RDONLY));
> >   void *map =3D SYSCHK(mmap(area, 0x1000, PROT_READ, MAP_SHARED|MAP_FIX=
ED, map_fd, 0));
> >   close(map_fd);
> >
> >   // make RWX mapping request fail late
> >   SYSCHK(prctl(65/*PR_SET_MDWE*/, 1/*PR_MDWE_REFUSE_EXEC_GAIN*/, 0, 0, =
0));
> >
> >   // some random other file
> >   int fd =3D SYSCHK(open("/etc/passwd", O_RDONLY));
> >
> >   /* disarm for now */
> >   write_file("/sys/kernel/debug/failslab/probability", "0");
> >
> >   /* fail allocations of maple_node... */
> >   write_file("/sys/kernel/debug/failslab/cache-filter", "Y");
> >   write_file("/sys/kernel/slab/maple_node/failslab", "1");
> >   /* ... even though it's a sleepable allocation... */
> >   write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
> >   /* ... in this task... */
> >   write_file("/sys/kernel/debug/failslab/task-filter", "Y");
> >   write_file("/proc/self/make-it-fail", "1");
> >   /* ... every time... */
> >   write_file("/sys/kernel/debug/failslab/times", "-1");
> >   /* ... after 8 successful allocations (value chosen experimentally)..=
. */
> >   write_file("/sys/kernel/debug/failslab/space", "2048"); // one object=
 is 256
> >   /* ... and print where the allocations actually failed... */
> >   write_file("/sys/kernel/debug/failslab/verbose", "2");
> >   /* ... and that's it, arm it */
> >   write_file("/sys/kernel/debug/failslab/probability", "100");
> >
> >   // This mmap request will fail late due to MDWE.
> >   // The error recovery path will attempt to clear out the VMA pointers=
 with a
> >   // spanning_store (which will be blocked by error injection).
> >   mmap(area, AREA_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP=
_FIXED, fd, 0);
> >
> >   /* disarm */
> >   write_file("/sys/kernel/debug/failslab/probability", "0");
> >
> >   SYSCHK(munmap(map, 0x1000)); // UAF expected here
> >   system("cat /proc/$PPID/maps");
> > }
> > ```
> >
> > Result:
> > ```
> > FAULT_INJECTION: forcing a failure.
> > name failslab, interval 1, probability 100, space 256, times -1
> > CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-ge=
ca631b8fe80 #518
> > [...]
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x80/0xa0
> >  should_fail_ex+0x4d3/0x5c0
> > [...]
> >  should_failslab+0xc7/0x130
> >  kmem_cache_alloc_noprof+0x73/0x3a0
> > [...]
> >  mas_alloc_nodes+0x3a3/0x690
> >  mas_nomem+0xaa/0x1d0
> >  mas_store_gfp+0x515/0xa80
> > [...]
> >  mmap_region+0xa96/0x2590
> > [...]
> >  do_mmap+0x71e/0xfe0
> > [...]
> >  vm_mmap_pgoff+0x17a/0x2f0
> > [...]
> >  ksys_mmap_pgoff+0x2ee/0x460
> >  do_syscall_64+0x68/0x140
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [...]
> >  </TASK>
> > mmap: unmap-fail: (607) Unable to abort munmap() operation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in dec_usb_memory_use_count+0x365/0x430
> > Read of size 8 at addr ffff88810e9ba8b8 by task unmap-fail/607
>
> What was this pointer?

Should be the "struct usb_memory *usbm".

> >
> > CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-ge=
ca631b8fe80 #518
> > [...]
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x66/0xa0
> >  print_report+0xce/0x670
> > [...]
> >  kasan_report+0xf7/0x130
> > [...]
> >  dec_usb_memory_use_count+0x365/0x430
> >  remove_vma+0x76/0x120
> >  vms_complete_munmap_vmas+0x447/0x750
> >  do_vmi_align_munmap+0x4b9/0x700
> > [...]
> >  do_vmi_munmap+0x164/0x2e0
> >  __vm_munmap+0x128/0x2a0
> > [...]
> >  __x64_sys_munmap+0x59/0x80
> >  do_syscall_64+0x68/0x140
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [...]
> >  </TASK>
> >
> > Allocated by task 607:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x14/0x30
> >  __kasan_kmalloc+0xaa/0xb0
> >  usbdev_mmap+0x1a0/0xaf0
> >  mmap_region+0xf6e/0x2590
> >  do_mmap+0x71e/0xfe0
> >  vm_mmap_pgoff+0x17a/0x2f0
> >  ksys_mmap_pgoff+0x2ee/0x460
> >  do_syscall_64+0x68/0x140
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Freed by task 607:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x14/0x30
> >  kasan_save_free_info+0x3b/0x60
> >  __kasan_slab_free+0x4f/0x70
> >  kfree+0x148/0x450
> >  vms_clean_up_area+0x188/0x220
>
> What line is this?

Should be the vma->vm_ops->close(vma) call. (That would call
dec_usb_memory_use_count(), which tail-calls kfree(), so the
dec_usb_memory_use_count() wouldn't show up in a stack trace.)

I don't have this kernel build anymore though, sorry. If you want I'll
rebuild and get a properly symbolized trace.

