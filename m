Return-Path: <linux-kernel+bounces-417080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C109D4EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BF41F2185B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC81D9350;
	Thu, 21 Nov 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvkzSvL1"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157A1D4144
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732199761; cv=none; b=BTK6jsoHgI+eS3lvwe50dMHOEa9oIKXNconjxFB1S2tfWbpr4m+rNc23n72dyBIg/2K3OkaayLCGShQiEIBCT0iiQki16GXetkUsNKGuUHGP9w6LS8lARrlaLItTWYAiXKNHmdraitRgVzaxFSYieKC7s/Lo1aHC/5dwWGvngEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732199761; c=relaxed/simple;
	bh=4HmDa/fZXe+n4G4QHZj1HexfrYZ1rPKO6UZrkY1Amgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a39/s+coW9Bogy6QbIifWxrz8GMkLCReobd/W/lOmeKr4+Jcbn5yHxhdVYKQ8mmBk2AUJEI8jQdQfjx8cQ4b3QMxEsvIR143yuFagmL4xVswau3YkgRd1kdwtR43wiIfHhycqqkka5+pUdqkm0gNeI2Fay8gA/h/v94gHAX9sqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvkzSvL1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382433611d0so795017f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732199758; x=1732804558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsVy0uy+Xfrlo3kE7Fo9CxxMEZ/R7tSBkr5imkd6cwo=;
        b=mvkzSvL1pQfsx1Ss2SYgOU6hjVkcXSaQe3am1GyFTk/hvRnh+g8J13kY6JNHFHMXHS
         d0buxqC8cN0otGBjx2d5tY64mCsETYIR0JiPs2j67CdRpPhIcgaEiBjnzU89Z1+BEj6r
         hxX5p6gUsV0o8wV4VlZRNA6i5IXZbX2hqJIwPQ33D3mLjsdBvnYyCXxnpAkWelO/3o4t
         Wpn0LlgKGQ/6ln7sA0KdKAtr4hyOnGmTWLxkjnGINeWckhMyRyPPTRch6TdP692qXwby
         FLJPjGcy7JsuhvMZhCtPyEiIjJMrSzuqO7Bb6fz6jmCT1I/PEzFxkp7BjObGLkp318Vs
         SIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199758; x=1732804558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsVy0uy+Xfrlo3kE7Fo9CxxMEZ/R7tSBkr5imkd6cwo=;
        b=JcFTORPec/yD9b/ZeLpO3Y0Pow6+zggVL4M7sSc2FK5izCRkdk0YY1hP7DqvLXkB/S
         Vux5Y3x7vUnBU+CssJBU8e4mIMd1RO3cT7zDpQc3ewfGcJNqbnQoTCo6gtGNdpyZddB4
         025HCqpTu1ZZfBW3/CKrOyJfMrnzgV+xgRvkmz8GDwKx/O8uHdYBFcTdbBzsus5oDcmH
         MWgelQU5rbndmj46rdOgXDoQsyO24G8rimIl1HHLLw/Avbke+UFYjRG6DdAL24eycWWQ
         sPbfEiP8VBVR+cbw/bywV+D3NDK6CodnEcccnNtcCdkGrJSVtCgJQrOyW9507hz476qf
         2i6A==
X-Forwarded-Encrypted: i=1; AJvYcCXy4nFWC2mfMyymj25ZIeuK++a71A4L0QZwTaHD0npvWtIMV5fOGG8V+43QdyI17VS8agMGFgttYmuJsS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXR8cZp8HYIP3ghuWnNgUF9P8bM3UnwZC8ZYUQNKpGNzFTGdwt
	PAGDVMm6f/ymz3gQ8EXD8y54j7sWEmjAHhUw0eSKQEFxOWUvawDTSw62YTsbZGcuVhicgqlT0j0
	ohX1uhTPzNQDr66fwMtwr98+ANqrIPohMWdgh
X-Gm-Gg: ASbGncsNPXj7ALBgd4UXQosU7oMkVAWGza14LGkPN0/0OG7gO1F68tvZmeZGgIS6fXR
	VzUbj9rSmyNBTlkKYSVFBHgfLop8MvBHCuSKBEviyBN7lwmKme6K+bQENU4t+gg==
X-Google-Smtp-Source: AGHT+IHJLA9duB6XIUDG0QrZybh6MZxkzXN8hB3iai9ICokuoepRojYUjEIhCq5VjfNQLrg3URF3G8FMaA2ucsNyiZE=
X-Received: by 2002:a5d:6487:0:b0:382:46a2:3788 with SMTP id
 ffacd0b85a97d-38254af9fd3mr5469204f8f.25.1732199757644; Thu, 21 Nov 2024
 06:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-1-eb31425da66b@google.com>
 <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local> <CAH5fLgi5xbL=L-Mz_u64sA1QGLtxOgEvG_y4aJV2_mfy4iCxyg@mail.gmail.com>
 <5a06280b-955d-41e1-8ab5-0b766ec7d7ac@lucifer.local>
In-Reply-To: <5a06280b-955d-41e1-8ab5-0b766ec7d7ac@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 15:35:45 +0100
Message-ID: <CAH5fLghNpbwteZMo7Lb81rg3yoxFs9ZbykSwgnnJZnpBuddCNA@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 1:37=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> I'm generally fine with this patch (other than rust specifics which I lea=
ve
> to the rust experts), however I'm a little concerned about us taking
> reference counts when we don't need to so this is something I'd like to s=
ee
> addressed for v9 or, at least to be confident we're not doing this in the
> binder code unnecessarily.
>
> Thanks!

The refcount increment is *not* unnecessary in Binder. For the C
equivalent, see the implementation of `binder_alloc_init`. It's used
because Binder will access the mm of the recipient from the sender's
scope, so it must hold on to an mm_struct reference.

> > > > +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> > > > +#[repr(transparent)]
> > > > +pub struct Mm {
> > > > +    mm: Opaque<bindings::mm_struct>,
> > > > +}
> > >
> > > Does this tie this type to the C struct mm_struct type?
> > >
> > > Does 'Opaque' mean it is a pointer to a type which is 'opaque' in the=
 sense
> > > that rust can't see into its internals?
> >
> > This declaration defines a Rust type called Mm which has the same
> > size, alignment, and contents as `struct mm_struct`. The purpose of
> > Opaque is to tell Rust that it can't assume anything about the
> > contents at all; we do that to leave it up to C.
> >
> > For example, normally if you have an immutable reference &i32, then
> > Rust is going to assume that the contents behind the reference are in
> > fact immutable. Opaque turns that off, meaning that an `&Opaque<i32>`
> > is allowed to reference an integer as it gets modified. It makes all
> > access to the contents unsafe, though.
> >
> > Note that Opaque is *not* a pointer type. We're going to be dealing
> > with types like &Mm or ARef<Mm> where &_ and ARef<_> are two different
> > kinds of pointers.
>
> OK so when you reference Mm.mm that is in effect referencing the struct
> mm_struct object rather than a pointer to a struct mm_struct? and

Yes.

> > > > +// SAFETY: By the type invariants, this type is always refcounted.
> > > > +unsafe impl AlwaysRefCounted for Mm {
> > > > +    #[inline]
> > > > +    fn inc_ref(&self) {
> > > > +        // SAFETY: The pointer is valid since self is a reference.
> > > > +        unsafe { bindings::mmgrab(self.as_raw()) };
> > > > +    }
> > > > +
> > > > +    #[inline]
> > > > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > > > +        // SAFETY: The caller is giving up their refcount.
> > > > +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> > > > +    }
> > > > +}
> > >
> > > Under what circumstances would these be taken? Same question for MmWt=
hUser.
> >
> > This makes `Mm` compatible with the pointer type called ARef<_>. This
> > pointer type is used to represent ownership of a refcount. So whenever
> > a variable of type ARef<_> goes out of scope, the refcount is
> > decremented, and whenever an ARef<_> is cloned, the refcount is
> > incremented.
> >
> > The way this works is that ARef<_> is implemented to use the
> > AlwaysRefCounted trait to understand how to manipulate the count. Only
> > types that implement the trait with an impl block like above can be
> > used with ARef<_>.
>
> OK so when you first instantiate an ARef<_> you don't increment the
> reference count, only if it is cloned from there on in?

Well it depends on which ARef constructor you are using. But the uses
of ARef::from_raw do not increment the count.

> > > > +// These methods are safe to call even if `mm_users` is zero.
> > > > +impl Mm {
> > > > +    /// Call `mmgrab` on `current.mm`.
> > > > +    #[inline]
> > > > +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> > > > +        // SAFETY: It's safe to get the `mm` field from current.
> > > > +        let mm =3D unsafe {
> > > > +            let current =3D bindings::get_current();
> > > > +            (*current).mm
> > > > +        };
> > >
> > > I don't see an equivalent means of obtaining mm from current for
> > > MmWithUser, is that intentional, would there be another means of obta=
ining
> > > an mm? (perhaps via vma->vm_mm I guess?)
> > >
> > > An aside -->
> > >
> > > If we're grabbing from current, and this is non-NULL (i.e. not a kern=
el
> > > thread), this is kinda MmWithUser to _start out_ with, but I guess if
> > > you're grabbing the current one you might not expect it.
> > >
> > > I guess one thing I want to point out (maybe here is wrong place) is =
that
> > > the usual way of interacting with current->mm is that we do _not_ inc=
rement
> > > mm->mm_count, mm->mm_users or any refernce count, as while we are in =
the
> > > kernel portion of the task, we are guaranteed the mm and the backing
> > > virtual address space will stick around.
> > >
> > > With reference to MmWithUser, in fact, if you look up users of
> > > mmget()/mmput() it is pretty rare to do that.
> > >
> > > So ideally we'd avoid doing this if we could (though having the seman=
tics
> > > of grabbing a reference if we were to copy the object somehow again o=
r hold
> > > its state or something would be nice).
> > >
> > > I guess this might actually be tricky in rust, because we'd probably =
need
> > > to somehow express the current task's lifetime and tie this to that
> > > and... yeah.
> > >
> > > <-- aside
> >
> > Ah, yeah, I guess this API is incomplete. We could have an API that
> > lets you obtain an &MmWithUser instead. Then, if the user wants to
> > increment the refcount, they can manually convert that into an
> > ARef<Mm> or ARef<MmWithUser>.
> >
> > It's true that it's slightly tricky to express in Rust, but it's
> > possible. We already have a way to get a &Task pointing at current.
>
> Yeah, but I think we should do this incrementally as I want this initial
> series to merge first, after which we can tweak things.

Rest assured that the API can be written to not automatically
increment the refcount when accessing current. That's just binder's
case.

> > > > +        unsafe { &*ptr.cast() }
> > > > +    }
> > > > +
> > > > +    /// Calls `mmget_not_zero` and returns a handle if it succeeds=
.
> > > > +    #[inline]
> > > > +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
> > >
> > > I actually kinda love that this takes an mm and guarantees that you g=
et an
> > > MmWithUser out of it which is implied by the fact this succeeds.
> > >
> > > However as to the point above, I'm concerned that this might be seen =
as
> > > 'the way' to access an mm, i.e. mm.mmgrab_current().mmget_not_zero() =
or
> > > something.
> > >
> > > Whereas, the usual way of referencing current->mm is to not increment=
 any
> > > reference counts at all (assuming what you are doing resides in the s=
ame
> > > lifetime as the task).
> > >
> > > Obviously if you step outside of that lifetime, then you _do_ have to=
 pin
> > > the mm (nearly always you want to grab rather than get though in that
> > > circumstance).
> >
> > I can add a way to obtain an &MmWithUser from current without
> > incrementing the refcount.
>
> Yeah, I feel like we definitely need this.
>
> However we'd need to _not_ drop the refcount when it goes out of scope to=
o
> in this case.
>
> I'm not sure how you'd express that, however.

The way you express that is by giving the user a &Mm or &MmWithUser
instead of giving the user an ARef<Mm> or ARef<MmWithUser>. Using a
normal reference implies that you don't have ownership over the
refcount, and the reference has no destructor when it goes out of
scope. The only slightly tricky piece is tying the lifetime of that
reference to the scope of the current task, but this is a problem with
a known solution.

For more on this, see the discussion on the various versions of
Christian's PidNamespace series:
https://lore.kernel.org/rust-for-linux/20241002-brauner-rust-pid_namespace-=
v5-1-a90e70d44fde@kernel.org/

Alice

