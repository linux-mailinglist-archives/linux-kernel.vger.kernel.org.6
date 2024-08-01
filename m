Return-Path: <linux-kernel+bounces-271111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE59449AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05491C20D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411F184546;
	Thu,  1 Aug 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PXjIONh8"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCA61FD7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509416; cv=none; b=dWYIJG78qRfDkTq2Dn3rtjcaMqBD2yhwTtwcCIMC49WHHFJRylyBRGk3cXCLeqXfpKLj+OzfjoL27X19XghCSIcwh1M9g8VdUpy/goSgyioKNErVl++IXOQUb3uj8eNBft1z9ZhOUyfAU5SAlBh3zkho9mt79HbbcBy3DCthf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509416; c=relaxed/simple;
	bh=FzX9Oi8w1rb7TAtfeMJIxj7qYb3gZnjoJj39P4abMxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNqmGKFNm5wjAvGiBGiMrSQBWldg26E0cLll860aV5SnrgsyHJYBoQaLweY6qWprGqYSEotlg/NMYqW9/Zr4KJmgvfelJe92wDGiA1mClld6Tmv4rLrqvs8ZpJbKEpQ/akOls4yH0wAzlmSAu5tlmX1IAYDQMBaQY3kus5fgN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PXjIONh8; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722509412; x=1722768612;
	bh=gMdZocEy01zU7HSY4Jv0StclRtNQ2rOH9J2qCOvUQpg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PXjIONh8Kto9reGwq1qKvJxpdLNXG6+YJGSTPM0hkI8x6hnAGkal6M3w+pOY08trk
	 a7tJETI3Z7ADOP9extEIdOR4i7/g9Wqf4snplZ3zD+rO7tSRk1nSYIk1jQBC/WgYQw
	 P8oLR60X/Sdb8onIbnW5t9FUTWfSrsHUw4vdaKl1mlBv9I7L6+cJoNb5LsuV98BtRm
	 pL1XyZOgDu4/+309UsZ0mdJJ2IX8nFEVNv4SDDY75gMAsX8Pjin38/RNQIdLmEAB06
	 yQyB3qAlaI/dNbg9osTkrdEIWj+QXhFcQvVAImYseAojVe8b7k9PBc7Y2PGRVPe0E2
	 zhyh/ishbRSBA==
Date: Thu, 01 Aug 2024 10:50:06 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/10] rust: list: support heterogeneous lists
Message-ID: <4af5a8fa-c27c-4ee5-9d2f-67a46bd34635@proton.me>
In-Reply-To: <CAH5fLghkPgj560a2b_1oRnvuurEugT4TNj+o-fYhGsuSGpywPg@mail.gmail.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-9-89db92c7dbf4@google.com> <2b548226-e323-466d-9f6d-762f6cbb5474@proton.me> <CAH5fLghkPgj560a2b_1oRnvuurEugT4TNj+o-fYhGsuSGpywPg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e0c106a5abae8caf3adbab48a7e800a6c0333dfe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 11:38, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 11:24=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 23.07.24 10:22, Alice Ryhl wrote:
>>> @@ -181,6 +185,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) ->=
 *mut Self {
>>>      }
>>>  }
>>>
>>> +/// Similar to [`ListLinks`], but also contains a pointer to the full =
value.
>>> +///
>>> +/// This type can be used instead of [`ListLinks`] to support lists wi=
th trait objects.
>>> +#[repr(C)]
>>> +pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 =3D 0> {
>>> +    /// The `ListLinks` field inside this value.
>>> +    ///
>>> +    /// This is public so that it can be used with `impl_has_list_link=
s!`.
>>> +    pub inner: ListLinks<ID>,
>>> +    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
>>
>> Why do you need `MaybeUninit`?
>=20
> Right now the constructor initializes it to MaybeUninit::zeroed().
> What would you initialize it to without MaybeUninit? Remember that the
> vtable pointer in a fat pointer has strict validity requirements.

Oh... I forgot about that, can you add a comment about that? Also why
not use `Opaque` in that case then?

>>> +}
>>> +
>>> +// SAFETY: The fields of a ListLinksSelfPtr can be moved across thread=
 boundaries.
>>> +unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr=
<T, ID> {}
>>> +// SAFETY: The type is opaque so immutable references to a ListLinksSe=
lfPtr are useless. Therefore,
>>> +// it's okay to have immutable access to a ListLinks from several thre=
ads at once.
>>> +//
>>> +// Note that `inner` being a public field does not prevent this type f=
rom being opaque, since
>>> +// `inner` is a opaque type.
>>> +unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr=
<T, ID> {}
>>
>> [...]
>>
>>> @@ -135,5 +178,91 @@ unsafe fn post_remove(me: *mut $crate::list::ListL=
inks<$num>) -> *const Self {
>>>              }
>>>          }
>>>      };
>>> +
>>> +    (
>>> +        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
>>> +            using ListLinksSelfPtr;
>>> +        } $($rest:tt)*
>>> +    ) =3D> {
>>> +        // SAFETY: See GUARANTEES comment on each method.
>>> +        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> fo=
r $t {
>>> +            // GUARANTEES:
>>> +            // This implementation of `ListItem` will not give out exc=
lusive access to the same
>>> +            // `ListLinks` several times because calls to `prepare_to_=
insert` and `post_remove`
>>> +            // must alternate and exclusive access is given up when `p=
ost_remove` is called.
>>> +            //
>>> +            // Other invocations of `impl_list_item!` also cannot give=
 out exclusive access to the
>>> +            // same `ListLinks` because you can only implement `ListIt=
em` once for each value of
>>> +            // `ID`, and the `ListLinks` fields only work with the spe=
cified `ID`.
>>> +            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crat=
e::list::ListLinks<$num> {
>>> +                // SAFETY: The caller promises that `me` points at a v=
alid value of type `Self`.
>>> +                let links_field =3D unsafe { <Self as $crate::list::Li=
stItem<$num>>::view_links(me) };
>>> +
>>> +                let spoff =3D $crate::list::ListLinksSelfPtr::<Self, $=
num>::LIST_LINKS_SELF_PTR_OFFSET;
>>> +                // SAFETY: The constant is equal to `offset_of!(ListLi=
nksSelfPtr, self_ptr)`, so
>>> +                // the pointer stays in bounds of the allocation.
>>> +                let self_ptr =3D unsafe { (links_field as *const u8).a=
dd(spoff) }
>>> +                    as *const ::core::cell::UnsafeCell<*const Self>;
>>
>> A bit confused why you need to do it this way, can't you just do this?:
>>
>>     let links_self_field =3D links_field.cast::<$crate::list::ListLinksS=
elfPtr>();
>>     // SAFETY: ...
>>     let self_ptr =3D unsafe { ::core::ptr::addr_of_mut!((*links_self_fie=
ld).self_ptr) };
>=20
> If nothing else, the field is not public. I can't remember if there
> was another reason.

Oh yeah that's true, then you have to go via the offset.

---
Cheers,
Benno


