Return-Path: <linux-kernel+bounces-424990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007609DBC25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C06CB210DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6751BD9D2;
	Thu, 28 Nov 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBZAlmdu"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070D537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818435; cv=none; b=eyjdp48G8JhRz48beDHvrGgumLeiDtV4OkMv+E5qTE6OBld2bAQdj6cdgsJJmwXgvOg1DEosF3TzJZ7R/eqMtyEV9SnweA4JdCHR6Nr8nUo3wDGJAgPbSehPVX5W+KOTU14Wcffsjw0DuqVZXXERVzfGUa7umYOfELOjQvP6M9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818435; c=relaxed/simple;
	bh=Xr2wcVj7SaU2JW4+8FivLZoOgTtjpwjka3vtiBZxC6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xck4WabxNncJr+jRY78r7QzuwRRMXywFNH9cIifSNaM13niZ95tB/SMIzPe/dyQ8d4ylMUfltyIo6/d9EF5XlkutDXEEH932OQXxK//upOAum9SNwnLXQzHXGt1Vq4n+B1WNBkTlqXijQGcxeP1hJHzAorQlGoJsSry/pnLOuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBZAlmdu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ee8e894deeso14455097b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732818433; x=1733423233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr2wcVj7SaU2JW4+8FivLZoOgTtjpwjka3vtiBZxC6g=;
        b=YBZAlmduZtiZdZk+h0abE53wwWlmlpqC84jjaER7vogeS6ZnomGykG17DPozZbfo1D
         hrqfnO4ZgFZPX/ghUEIdN7C3f99fe02n9pEFWFMkez8Ek9DvCYTOwzDktJ0tyMOjZ2Hv
         MvH4B1AMQwogYicmd2X/aFmB+BxHCfZXNn6GC4finVd49Oez8vmMYN85wKA91jEqDvpE
         vKrSFjZ+yAxBEQVhXJe6oU4Mzi229qNNVBiPyEmanZzQ2CUd3b4WL7lS6gKnxykhFqhA
         e3N0LHRlK+GTSZT/3pP+lAyCOqsC/NqSQnFDl3GkchC6VPAiiTMZwlGqgcfnjG6/tpok
         Q7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732818433; x=1733423233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr2wcVj7SaU2JW4+8FivLZoOgTtjpwjka3vtiBZxC6g=;
        b=gQQZOpeK4ig+vYLDFzGX0Efo0g2a/GjhhFeTEjLFkx5WUAG/B14ohLJPepHvSzXYoK
         iF0UUzsCEIlv8PIbOS2FvaEBX2s3NtB9uLYpmgOu+gLpzMoPGuf9jGegS4o8kY5C0GLq
         C8nEux6xXlHMh8ykD0BSpHGYd+h961T3gqY88iA5LUn8kGJw68xixlgJyvORA1cow9sy
         f4iv/U46jvVk1hbZ46iqimgkF8E8YmrExIX8XnkxsRVJYs0Pm9J9yNbSR3lRMpMu4B1c
         XYSYDyGSw+fOLVw3vIIkF3nAr08+zvu7TEStRfMVEBhScxp6ilEc7ae1xY9S+KwNtZF+
         ivDw==
X-Forwarded-Encrypted: i=1; AJvYcCV2MhBfrOl/Qd015ot7JYL+XsX3bUsSSmB/wXXxicrZDv1gNSmm+AXxLZF0x3avR93wAiet7zTNuQYoILk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLU33fXRfNrpzl8dBVnhsnwrahxCOOA9kPBAVnATbUlGKpgzu9
	akkaO43t7A3HLlKkjBDgI0sS8ZMgaMfCp6wOUCGUyNWoL8aWtaOnaqayXmugUT9DHVX900AbVZ8
	IWkeKsKKc5W00Xpu41BBieNLGIzg=
X-Gm-Gg: ASbGncsCuhJBQu4JIUAJVeHzdbBLnkjb9+m61PlN/+DsPP7uaLf1WtI5BRudjwTmvN6
	XflS7iDsb7dpbJA/mO6ZuMw5Ed58txf1HNti3+yd7
X-Google-Smtp-Source: AGHT+IH5navH/hx/UmIJ7Jn9h1O9wNGtyaLnCSk0q13jWCma7ZDVYjqdUYNzrcTvbe1Nct2UWvwIS4TGMzJAYblSi84=
X-Received: by 2002:a05:690c:2506:b0:6ee:baf5:a4e8 with SMTP id
 00721157ae682-6ef3729d86bmr92951457b3.39.1732818432814; Thu, 28 Nov 2024
 10:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
 <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com> <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
In-Reply-To: <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 28 Nov 2024 19:27:02 +0100
Message-ID: <CAHijbEXwuteLLwyPhkDBZgWq3YuGw8bU72BxdhnkX7HK=AqfUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 7:20=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Nov 28, 2024 at 06:58:21PM +0100, Julian Orth wrote:
> > (Re-sending the message below since I forgot to reply-all)
> >
> > On Thu, Nov 28, 2024 at 6:46=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On Thu, Nov 28, 2024 at 4:06=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > In commit 158978945f31 ("mm: perform the mapping_map_writable() che=
ck after
> > > > call_mmap()") (and preceding changes in the same series) it became =
possible
> > > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > > >
> > > > This was previously unnecessarily disallowed, despite the man page
> > > > documentation indicating that it would be, thereby limiting the use=
fulness
> > > > of F_SEAL_WRITE logic.
> > > >
> > > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_=
WRITE
> > > > seal (one which disallows future writes to the memfd) to also be us=
ed for
> > > > F_SEAL_WRITE.
> > > >
> > > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE fo=
r a
> > > > read-only mapping to disallow mprotect() from overriding the seal -=
 an
> > > > operation performed by seal_check_write(), invoked from shmem_mmap(=
), the
> > > > f_op->mmap() hook used by shmem mappings.
> > > >
> > > > By extending this to F_SEAL_WRITE and critically - checking
> > > > mapping_map_writable() to determine if we may map the memfd AFTER w=
e invoke
> > > > shmem_mmap() - the desired logic becomes possible. This is because
> > > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we =
will
> > > > have cleared.
> > > >
> > > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > > behaviour") unintentionally undid this logic by moving the
> > > > mapping_map_writable() check before the shmem_mmap() hook is invoke=
d,
> > > > thereby regressing this change.
> > > >
> > > > We reinstate this functionality by moving the check out of shmem_mm=
ap() and
> > > > instead performing it in do_mmap() at the point at which VMA flags =
are
> > > > being determined, which seems in any case to be a more appropriate =
place in
> > > > which to make this determination.
> > > >
> > > > In order to achieve this we rework memfd seal logic to allow us acc=
ess to
> > > > this information using existing logic and eliminate the clearing of
> > > > VM_MAYWRITE from seal_check_write() which we are performing in do_m=
map()
> > > > instead.
> > >
> > > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > > do_mmap(), without holding any kind of lock or counter on the file
> > > yet, then this check is clearly racy somehow, right? I think we have =
a
> > > race where we intermittently reject shared-readonly mmap() calls?
> >
> > Apropos race, some time ago I reported a way to get a mutable mapping
> > for a write-sealed memfd via a race:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219106
>
> Kind of hard to read rust code, but it looks like you're intentionally
> trying to race sealing on the assumption it's atomic when it's not? That
> doesn't seem like a bug?
>
> The intent of sealing memfds is you establish the memfd buffer, then seal
> it and _only then_ expose it elsewhere.
>
> I may be missing something here, however.

systemd allows the client to send journal logs via a file descriptor.
If this file descriptor is a write-sealed, truncate-sealed memfd,
systemd uses an optimized code path that relies on the contents of the
file being immutable.

I could not find any actual way to exploit this nor could I find any
other open-source code that relies on write-seals being accurate. But
maybe there is some code out there that could be exploited this way.
E.g. if it used the contents of the file as an array index, then you
could easily get a TOC/TOU exploit with this.

>
> >
> > >
> > > Like:
> > >
> > > process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sea=
led()
> > > process 2: adds a F_SEAL_WRITE seal
> > > process 1: enters mmap_region(), is_shared_maywrite() is true,
> > > mapping_map_writable() fails
> > >
> > > But even if we fix that, the same scenario would result in
> > > F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> > > like we can actually do anything particularly sensible if these two
> > > operations race. Taking a step back, read-only shared mappings of
> > > F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> > > someone first creates a read-only shared mapping and *then* tries to
> > > apply F_SEAL_WRITE, that won't work because the existing mapping will
> > > be VM_MAYWRITE.
> > >
> > > And the manpage is just misleading on interaction with shared mapping=
s
> > > in general, it says "Using the F_ADD_SEALS operation to set the
> > > F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> > > exists" when actually, it more or less fails if any shared mapping
> > > exists at all.
> > >
> > > @Julian Orth: Did you report this regression because this change
> > > caused issues with existing userspace code?
> >
> > I noticed this because it broke one of my testcases. It would also
> > affect production code but making that code work on pre-6.6 kernels is
> > probably a good idea anyway.
>
> Thanks for having that test case! I have added a test here to ensure we d=
o
> not regress this again.
>
> This was a new feature introduced in 6.6, there is no reason to backport =
it
> to any earlier kernels if this is what you mean :)
>
> It's more a convenience thing like 'hm I can read() this but I can
> mmap-read this even though the man page says I can'.
>
> >
> > >
> > > > Reported-by: Julian Orth <ju.orth@gmail.com>
> > > > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=
=3DU7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > > > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path b=
ehaviour")
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

