Return-Path: <linux-kernel+bounces-424986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E29DBC1A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81062163D54
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3041B415C;
	Thu, 28 Nov 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSVvCaal"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2C537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732817941; cv=none; b=uK6aktckvO5w+zsxjGEMm17lb/DA4S/zNG7r5ljwPFI0eDSksRp79Hl0tOz3f9HxBdHqcW0GTt1zbM+wV9wzIp4spBjey5Z7+nMoPHeRbi6udzIrM9u4tAh8MTL8disrp5WI4nw517U+ZFIfXedW7xCG1+6FDPVT9ghbOMbS1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732817941; c=relaxed/simple;
	bh=jBQKGMceh2eim8+DXFzAVIWaviXIbhui6CqSR6Gz0ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGa5EIOFsAmk8c6nu6t56VJXahHcxl+pUHyUANAUO7o4tQVTJ365UhCMu7p7rwXh/mYUnQFSBqAI0hziJEBnSXuPDixXKtnKB60xmlXWkDDH03dcb9avbsh4WBFLHRWy8QunkSMtmjo6xI/J5XRCnYzr8Hd9Chnq4X6OlGED27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FSVvCaal; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so9026a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732817938; x=1733422738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBQKGMceh2eim8+DXFzAVIWaviXIbhui6CqSR6Gz0ns=;
        b=FSVvCaaliEwJvtYhfS7X2VRHENxMj37nyiP1i3D9ViJTZM1UZ6STBbls6KFXKzGLK1
         FKA3Gk82gDUlB/3UFRMBWiSUQGCbWrGv3pyrgniBNHf4b88X3iQaX3tVtOtDVpQliDmW
         k+4GaP67XrJ4bIU6vKhxPH2C68QtHIQ7aXVg3fKcTIbMwCVpjrT4djAOVZRxwI2qFHXc
         7O5TGN4B5WJFC0Pu3GLQ427nmkIiBGu5N2+ijiO9S2o8LzZ2rJv50Qt1gK9mXhE3r7RR
         ATYd1k54T3eMyEmPrKZqaPjlolO5VsVFdrHRT0ziUDxBAjaqqTiSmTaQIibb1Be+IL1x
         VFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732817938; x=1733422738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBQKGMceh2eim8+DXFzAVIWaviXIbhui6CqSR6Gz0ns=;
        b=D4Ib9+3JxPw0wYnb1GyLy7k8CcK8UTRLjd2fEGK1gHmAfVBJLmOwkNVoeK1vYBA0FO
         n+2UM1d07EoahRpOikbbFuy9flJRL8LDSEtmSF9rO6RMmM1pwY/w9aGuBZo/hoItj+Rz
         wLlZvmv+rUxUzqF6sA6mNFQ6VEDTZfYoqhGh3k8fimZJUTVIEU21gAu+5nknj4d4DH+c
         akOK23qNybBhCa6Smkar61m2WNhCgbv5AwzsdiGlaJtvD2uChu/SBx1iUR8c2tWsR3rK
         tVn9wdX9O1NupWlOVRbGloFTVI9sb0wawkhwHSGcvBhpeFmUeGdMQWfS86qwtmk30LWV
         tDmA==
X-Forwarded-Encrypted: i=1; AJvYcCXRjhrcfQEKi07QhRETA7W5JqK7Z4ki/5h20cg3mZqvKY5F0PlWO+dx5/M6vY1UXTVx0y8gUtx16PdVPxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMYGEsy4dtZR5kdcGGbXFVXEnBps96rDNfHOEJhPffUMrQ5wD
	V9iR27PgvqYbXhVbEWuMi632+agLe4p4wW7WeQ/AbePeX5Lo4L7sEVdfJbNPp2DJgNJl26I3p2z
	D0sGgWqZ4mtAF6x9bXTRUa0aUjKmqQBE1Jy8u
X-Gm-Gg: ASbGncuIbCU+Zci6ytSsfczbERna21gLUcVG2FnPBU4Q53Xq2HoBqbAym7R/Oz6WuMR
	YP3LfDrnXsWa1UHK+CPmtbTMJaDMZVEUuclcgtr+F7aNZ0ync/KNuD0n6eik=
X-Google-Smtp-Source: AGHT+IEDndyfEI17lLdZ9F2PAmODz4L955CZSUO/X2tz83vpI1YhVZbQrg1GudU5w1kIHL5tz118RYG5Aa1xsq8ESrE=
X-Received: by 2002:a50:ed8f:0:b0:5d0:acf3:e3a6 with SMTP id
 4fb4d7f45d1cf-5d0acf3e47amr497a12.1.1732817937353; Thu, 28 Nov 2024 10:18:57
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com> <8219cfd3-f488-492c-8d4c-26e9f0169e8e@lucifer.local>
In-Reply-To: <8219cfd3-f488-492c-8d4c-26e9f0169e8e@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Thu, 28 Nov 2024 19:18:20 +0100
Message-ID: <CAG48ez16vhr_D1o_3tMetCWq3NiGm__PAECyprdePtq40ag1gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Julian Orth <ju.orth@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 7:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Nov 28, 2024 at 06:45:46PM +0100, Jann Horn wrote:
> > On Thu, Nov 28, 2024 at 4:06=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > In commit 158978945f31 ("mm: perform the mapping_map_writable() check=
 after
> > > call_mmap()") (and preceding changes in the same series) it became po=
ssible
> > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > >
> > > This was previously unnecessarily disallowed, despite the man page
> > > documentation indicating that it would be, thereby limiting the usefu=
lness
> > > of F_SEAL_WRITE logic.
> > >
> > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WR=
ITE
> > > seal (one which disallows future writes to the memfd) to also be used=
 for
> > > F_SEAL_WRITE.
> > >
> > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for =
a
> > > read-only mapping to disallow mprotect() from overriding the seal - a=
n
> > > operation performed by seal_check_write(), invoked from shmem_mmap(),=
 the
> > > f_op->mmap() hook used by shmem mappings.
> > >
> > > By extending this to F_SEAL_WRITE and critically - checking
> > > mapping_map_writable() to determine if we may map the memfd AFTER we =
invoke
> > > shmem_mmap() - the desired logic becomes possible. This is because
> > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we wi=
ll
> > > have cleared.
> > >
> > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > behaviour") unintentionally undid this logic by moving the
> > > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > > thereby regressing this change.
> > >
> > > We reinstate this functionality by moving the check out of shmem_mmap=
() and
> > > instead performing it in do_mmap() at the point at which VMA flags ar=
e
> > > being determined, which seems in any case to be a more appropriate pl=
ace in
> > > which to make this determination.
> > >
> > > In order to achieve this we rework memfd seal logic to allow us acces=
s to
> > > this information using existing logic and eliminate the clearing of
> > > VM_MAYWRITE from seal_check_write() which we are performing in do_mma=
p()
> > > instead.
> >
> > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > do_mmap(), without holding any kind of lock or counter on the file
> > yet, then this check is clearly racy somehow, right? I think we have a
> > race where we intermittently reject shared-readonly mmap() calls?
> >
> > Like:
> >
> > process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_seale=
d()
> > process 2: adds a F_SEAL_WRITE seal
> > process 1: enters mmap_region(), is_shared_maywrite() is true,
> > mapping_map_writable() fails
>
> I don't think this matters? Firstly these would have to be threads unless=
 you
> are going out of your way to transmit the memfd incompletely set up via a=
 socket
> or something, and then you'd have to be doing it on the assumption that i=
t
> wouldn't race?

Ah, I guess that's true.

> The whole purpose of this change is to _allow read-only mapping *at all*_=
. Not
> to avoid silly races that are the product of somebody doing stupid things=
.
>
> >
> > But even if we fix that, the same scenario would result in
> > F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> > like we can actually do anything particularly sensible if these two
> > operations race. Taking a step back, read-only shared mappings of
> > F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> > someone first creates a read-only shared mapping and *then* tries to
> > apply F_SEAL_WRITE, that won't work because the existing mapping will
> > be VM_MAYWRITE.
>
> I don't think so?
>
> If they try to do that, attempting to apply the seal will fail as write w=
ill be
> disallowed. So there's no risk of overriding the seal.
>
> The idea is you establish a buffer, write into it, unmap, write-seal, and=
 now
> you can mmap() it PROT_READ.
>
> Obviously it's not sensible (or really probably sensibly feasible) to try=
 to
> find every VMA that has it opened VM_READ | VM_MAYWRITE and clear the
> VM_MAYWRITE, so instead we simply disallow that scenario.
>
> But it's totally reasonable to be able to mmap() it readonly afterwards.
>
> >
> > And the manpage is just misleading on interaction with shared mappings
> > in general, it says "Using the F_ADD_SEALS operation to set the
> > F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> > exists" when actually, it more or less fails if any shared mapping
> > exists at all.
>
> No, it's when any writable mapping exists after my changes :) but people
> might not be quite aware of the distinction between VM_MAYWRITE and
> VM_WRITE.

To clarify, do you read "writable" as "VM_MAYWRITE|VM_SHARED"?

> > @Julian Orth: Did you report this regression because this change
> > caused issues with existing userspace code?
> >
> > > Reported-by: Julian Orth <ju.orth@gmail.com>
> > > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=3DU=
7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path beh=
aviour")
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> In any case, we are not discussing my original patch in 6.6 that permitte=
d
> this behaviour, whether you agree or disagree it was sensible, we have
> regressed user-visible behaviour, this change restores it.

Hm, yeah, you're right.

