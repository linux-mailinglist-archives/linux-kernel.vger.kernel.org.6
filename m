Return-Path: <linux-kernel+bounces-271027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3994489D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6FD1C2434D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D654170A02;
	Thu,  1 Aug 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DM2yAlNF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1F140E5C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505146; cv=none; b=RGgFVw10w+IA70zF1LUdYytlqUHAXfhErddV84v0Yv+XBrwwP9Tm160/wUPR/YvWiwY9neXx8EnS7VLc+NtF9FPfbUIMYZNq/iojw5TG8ZzTkLvUtISSw28mqtW5qvIPsaasxsQcvgqNCPDCXHdWdVS8NXfHHil46BsRXgzkec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505146; c=relaxed/simple;
	bh=oApA0qznxaHEE4A8R8hgJNhN2ArNXKYa4oVQONhFyNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUHy0QPzWpB/mvXymTCp9XTbhLdWYhWZWDlOJ/xD8jt+yti05g8evfeDvEYo4hxpxcaReIVEM8gckSjLN3lb3mbvl6uOZdPradmtKJ7/ap4G4rNkHFLognZU/bYzcTXXTTA2iY/t4QPbOLKSpSUYVhJrYXGnpnK6WA2Zy5/NyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DM2yAlNF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42809d6e719so45105215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722505143; x=1723109943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQdGA7GJE2VgdG2QsBIACC0GGavEy5/6TiWZnrghIfE=;
        b=DM2yAlNFOH3v32S8roDbhB1p2pIU7YJOAem6WmYFZWHbT/trYdRbAAlieV8FKu4ayH
         qK/5kHmhGQRs48PGh2WIjyU5w8ml8AkTzrtmuhgnk+QHpU28SYAzQU56aWyzCjrKz2d1
         QpeaPH51g8CWhYC8CnvU3WCdRnsTDNd3Q+ASuNBEnE+fBXqURUau4RO/bGd4g1YvHdvw
         3OXjdmQh9+JrG5Cz3K1swActaHjA2TV3m4F9RdpsaEwGbpeelIfsPsZ0gIEmG/Oh81qM
         hERu4eJNO4hc/odsmUv8c5+n1HEc2V05+AZE1ZOM2aiL0MClqLyhrVjh3J4h0zTaYVh/
         nMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505143; x=1723109943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQdGA7GJE2VgdG2QsBIACC0GGavEy5/6TiWZnrghIfE=;
        b=lh0aArgGiPJ4mDITGVkNLeS+r8YpaM9QQMtR+c8m9QuB2gr+iPbJDsVS22+7FLKakx
         qQSxuTBGse6Y0x6Zgups3m1mYwOAdL1zmFV69yABNRywpn+42Ann1Grs9/RHbw8SR2fu
         eWuzqmZh+QuXaXEwTmRFOD0Jb4KsWjSBIHCFH8DbTe/bOAYQ4J+BHrexYASFUp0ohZR0
         kS0VY6T/qcGk6Hr99GT83tKxPpziTW+39xhVKDjsPtQ6JTukPpWgbBnIS4HwndVldYrA
         Vac1Cddhd3jJW098w5RiEFp/7PFIMq0xnwLYvAX33VHoS5z34yKr3PKHsCRPfIq1g6rz
         Na7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj78RmD0yPOibjaA/+o7wt1UAqwydHa4S0h89eXMOUh0iTy7MhH4c+p/hqfwv7PeQMp7/UFlBMEzv/8kLJltL5Bt3FHsUqxqXlMP9h
X-Gm-Message-State: AOJu0YzsBly4fRAHBSffxEWHUPpbuN+bHtq1+FTrpluAMrXwj5xeMk0l
	EHZAAYwac7tgZJ6kjsBrnCQtl0EpUF4fEHqisaXenjyGEr2+ZqNPEZrH1fILniUK8yAXIz724RA
	4/wSCzCUJmFkK1Qe5b7qF3bUQ8CsgTNvbw724
X-Google-Smtp-Source: AGHT+IHNeIRKHEDLTaSlMEckCTl/havP+o8WgKH8eXCZheQ+hbQIUOGOrwY0qf/8SqbtvZCCyhr7GP8Uz0b/v6290so=
X-Received: by 2002:a05:6000:910:b0:368:48b1:803 with SMTP id
 ffacd0b85a97d-36baacbda56mr1204853f8f.12.1722505142506; Thu, 01 Aug 2024
 02:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-9-89db92c7dbf4@google.com> <2b548226-e323-466d-9f6d-762f6cbb5474@proton.me>
In-Reply-To: <2b548226-e323-466d-9f6d-762f6cbb5474@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:38:50 +0200
Message-ID: <CAH5fLghkPgj560a2b_1oRnvuurEugT4TNj+o-fYhGsuSGpywPg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] rust: list: support heterogeneous lists
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:24=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 23.07.24 10:22, Alice Ryhl wrote:
> > @@ -181,6 +185,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) ->=
 *mut Self {
> >      }
> >  }
> >
> > +/// Similar to [`ListLinks`], but also contains a pointer to the full =
value.
> > +///
> > +/// This type can be used instead of [`ListLinks`] to support lists wi=
th trait objects.
> > +#[repr(C)]
> > +pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 =3D 0> {
> > +    /// The `ListLinks` field inside this value.
> > +    ///
> > +    /// This is public so that it can be used with `impl_has_list_link=
s!`.
> > +    pub inner: ListLinks<ID>,
> > +    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
>
> Why do you need `MaybeUninit`?

Right now the constructor initializes it to MaybeUninit::zeroed().
What would you initialize it to without MaybeUninit? Remember that the
vtable pointer in a fat pointer has strict validity requirements.

> > +}
> > +
> > +// SAFETY: The fields of a ListLinksSelfPtr can be moved across thread=
 boundaries.
> > +unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr=
<T, ID> {}
> > +// SAFETY: The type is opaque so immutable references to a ListLinksSe=
lfPtr are useless. Therefore,
> > +// it's okay to have immutable access to a ListLinks from several thre=
ads at once.
> > +//
> > +// Note that `inner` being a public field does not prevent this type f=
rom being opaque, since
> > +// `inner` is a opaque type.
> > +unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr=
<T, ID> {}
>
> [...]
>
> > @@ -135,5 +178,91 @@ unsafe fn post_remove(me: *mut $crate::list::ListL=
inks<$num>) -> *const Self {
> >              }
> >          }
> >      };
> > +
> > +    (
> > +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
> > +            using ListLinksSelfPtr;
> > +        } $($rest:tt)*
> > +    ) =3D> {
> > +        // SAFETY: See GUARANTEES comment on each method.
> > +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> fo=
r $t {
> > +            // GUARANTEES:
> > +            // This implementation of `ListItem` will not give out exc=
lusive access to the same
> > +            // `ListLinks` several times because calls to `prepare_to_=
insert` and `post_remove`
> > +            // must alternate and exclusive access is given up when `p=
ost_remove` is called.
> > +            //
> > +            // Other invocations of `impl_list_item!` also cannot give=
 out exclusive access to the
> > +            // same `ListLinks` because you can only implement `ListIt=
em` once for each value of
> > +            // `ID`, and the `ListLinks` fields only work with the spe=
cified `ID`.
> > +            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crat=
e::list::ListLinks<$num> {
> > +                // SAFETY: The caller promises that `me` points at a v=
alid value of type `Self`.
> > +                let links_field =3D unsafe { <Self as $crate::list::Li=
stItem<$num>>::view_links(me) };
> > +
> > +                let spoff =3D $crate::list::ListLinksSelfPtr::<Self, $=
num>::LIST_LINKS_SELF_PTR_OFFSET;
> > +                // SAFETY: The constant is equal to `offset_of!(ListLi=
nksSelfPtr, self_ptr)`, so
> > +                // the pointer stays in bounds of the allocation.
> > +                let self_ptr =3D unsafe { (links_field as *const u8).a=
dd(spoff) }
> > +                    as *const ::core::cell::UnsafeCell<*const Self>;
>
> A bit confused why you need to do it this way, can't you just do this?:
>
>     let links_self_field =3D links_field.cast::<$crate::list::ListLinksSe=
lfPtr>();
>     // SAFETY: ...
>     let self_ptr =3D unsafe { ::core::ptr::addr_of_mut!((*links_self_fiel=
d).self_ptr) };

If nothing else, the field is not public. I can't remember if there
was another reason.

Alice

