Return-Path: <linux-kernel+bounces-518457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8DA38F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775793AE4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C31AB52D;
	Mon, 17 Feb 2025 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SH2GWsf5"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C58514F9E2;
	Mon, 17 Feb 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739833495; cv=none; b=hqMXph8shdMiMOprZr28X6o4GqqG51VBm6tGTNKiY170kaSDCPxCN2mv3aTnC0dYnS8mQ/isHYC3Wdn3NqFcALtKcJtXICiZSVQBtvJ1qDOyeH9XtlpsROQ6GgTdpUBWJdp+IlwlaEiB6/WZ0ofYkXca+cE7OKnZTQWao5M3sU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739833495; c=relaxed/simple;
	bh=ua8MTgg/pMbzItmaHaOKpFahHqsd/AEYJLBn84nW3jA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6gN4o54E1SEeUa/x9GaDiuOssARrtkYwy8loTl8zDGp3dqntrFKXtmIZu/35c2H1ry4m2QQwAVBJ333gYF2gL6SexvEdymPqZNvYE7J1hAZJdKsUe3nr7sZ+XuQLCCWnr/SNw3N/VBWHc2IlSctKcmmSzZqmcRGpEkiPuHU23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SH2GWsf5; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jblptpwxyvcidg2pzm7itkg7wu.protonmail; t=1739833485; x=1740092685;
	bh=jHdV3S2lh3pdGuk6Jd9tHkSnXo+OlTKdByZUos42qWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=SH2GWsf5nTbSthP5aXTCrQoD0RYV0a1A5Nc2OI2T6S7756MU0q16Bxvt9Oxa71VFr
	 8B8X3Rg4wTc5BkcLiTbCM6dt03lq7gfitfTltQkX4m5o62Lj9ZNvVosJTZIIPHSiwu
	 9Vu47+ki+AntG/n0WY5b0gH4POvYaY657sEWFAmqyW6YCNS2rEd+5zjYkfB2w6YFDV
	 E4Y2lmuJ7lc85IkphPI/Bs8/brv0FWaX5Z/BMjfjRd5+59I85RTKkQvVpoDQHZ5pV0
	 ctT7QUpy8NHZg7EXj6FBEtsCOPHOT/6gnkIYCAEcnU6jlYXUF45ysqipHxUOFpMmwX
	 glNFe3MI6B78Q==
Date: Mon, 17 Feb 2025 23:04:39 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, Charalampos Mitrodimas <charmitro@posteo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
Message-ID: <354dbebd-b211-4e8f-a181-8fbacb0e89c8@proton.me>
In-Reply-To: <87bjv0u5j0.fsf@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-2-f7a60b24d38e@kernel.org> <S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid> <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me> <87h64su8ux.fsf@kernel.org> <Kkrr23DbfvS1nChcwAfhrogDdCOO92FQ2-9JUCab-_6CREP4iBX8k1KuxaJb-yv_ErGv9TbzDWwBZHvaszFS7w==@protonmail.internalid> <bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me> <87bjv0u5j0.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7147e4b8455818361fecc7bff27a85c176ad257d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.02.25 13:20, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 17.02.25 12:08, Andreas Hindborg wrote:
>>>>> +
>>>>> +/// A `configfs` subsystem.
>>>>> +///
>>>>> +/// This is the top level entrypoint for a `configfs` hierarchy. To =
register
>>>>> +/// with configfs, embed a field of this type into your kernel modul=
e struct.
>>>>> +#[pin_data(PinnedDrop)]
>>>>> +pub struct Subsystem<Data> {
>>>>
>>>> Usually, we don't have multi-character generics, any specific reason
>>>> that you chose `Data` here over `T` or `D`?
>>>
>>> Yes, I find it more descriptive. The patch set went through quite a bit
>>> of evolution, and the generics got a bit complicated in earlier
>>> iterations, which necessitated more descriptive generic type parameter
>>> names. It's not so bad in this version after I restricted the pointer
>>> type to just `Arc`, but I still think that using a word rather a single
>>> letter makes the code easier to comprehend at first pass.
>>
>> Makes sense. I'm not opposed to it, but I am a bit cautious, because one
>> disadvantage with using multi-character names for generics is that one
>> cannot easily see if a type is a generic or not. Maybe that is not as
>> important as I think it could be, but to me it seems useful.
>=20
> If you use an editor with semantic highlighting, you can style the
> generic identifiers. I am currently trying out Helix, and that is
> unfortunately on of the features it is missing. Can't have it all I
> guess.

That is true, but there are a lot of places where Rust code is put that
aren't my editor (git diffs/commit messages, mails, lore.kernel.org,
github) and there it'll become more difficult to read (also people might
not have their editor configured to highlight them).

So I think we should at least consider it more.

>>>>> +                    // SAFETY: We are expanding `configfs_attrs`.
>>>>> +                    static [< $data:upper _ $name:upper _ATTR >]:
>>>>> +                      $crate::configfs::Attribute<$attr, $data, $dat=
a> =3D
>>>>> +                        unsafe {
>>>>> +                            $crate::configfs::Attribute::new(c_str!(=
::core::stringify!($name)))
>>>>> +                        };
>>>>> +                }
>>>>> +            )*
>>>>> +
>>>>> +
>>>>> +            const N: usize =3D $cnt + 1usize;
>>>>
>>>> Why do we need an additional copy? To have a zero entry at the end for=
 C
>>>> to know it's the end of the list? If so, a comment here would be very
>>>> helpful.
>>>
>>> Yes, we need space for a null terminator. I'll add a comment.
>>>
>>> We actually have a static check to make sure that we not missing this.
>>
>> Where is this static check?
>=20
> In `Attribute::add`:
>=20
>         if I >=3D N - 1 {
>             kernel::build_error!("Invalid attribute index");
>         }

Ahh I see, would be also nice to have a comment there explaining why the
check is `>=3D N - 1`.

---
Cheers,
Benno


