Return-Path: <linux-kernel+bounces-518905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4BA395E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C291898409
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6822FDEE;
	Tue, 18 Feb 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtcEA10d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540922E00E;
	Tue, 18 Feb 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868158; cv=none; b=EM0HMgOmGrBav2A91mpBmFBmy4nQMOWPTjsoCjaQPP0NzRZ/gAq04IiYU/BOtsXXE3jStTBH0bL7XJl8LAMTwz2bpNFG3BwKI/36LKsYKeDjZS4WY/CWBI9N7LqVB628YRHtTJA/NOLQlFS7ArtrOZHDlor21QkpXW40GUpgGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868158; c=relaxed/simple;
	bh=IRJMwmgzOFNxmUBfeQTrD+oa8rPnhXa3yiox7PonBmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+hP05O2U72PoQMYos6nDb0EXdwt+dlFBKjf3en2/I9QdTNmXn7GwdZZIL7J0EdKwFTXG1RpvnzCkcZcqMOFkz0n9oBWHNHE9HFk8TzzXZ9ZGWB1RSUFcl882CzPdf7UbiD40Cq+3mrRBUK06wzl4RUwShvcgyfdermCEkt2jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtcEA10d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBADC4CEE2;
	Tue, 18 Feb 2025 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739868157;
	bh=IRJMwmgzOFNxmUBfeQTrD+oa8rPnhXa3yiox7PonBmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EtcEA10dRrCBuV5qVNJANROtXj7bJjYrPr1UjmVWGdzmq5Ffpo1G5CyOap1gUUx1F
	 NBc4B8n2UUHiKhwL5Wak6z3/xi0pD/FeiJHhPMa1fw4gWrhXwIARrJDe8EqUvTSIuj
	 FRVDYkn17YjHh2KSpWGKp4eM25Q4u+sUNOjawSyv5HSEK1sBOA3PGT0r9Uv6DYzMRV
	 Zw0udL5uSuBvsUKP6IszPRUyomnjJ9Mp+h62eZqB2zKMe3XWUiRfmta5e5FBWKoCF5
	 Sz7K2AfVEdA8HoYxf0B8s5ZshjTp4sfv9lwgWPtiDRplCr+ntH9owd0ALV65g0OqIm
	 Su7z/TBa3VbGg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Joel Becker" <jlbec@evilplan.org>,
  "Christoph Hellwig" <hch@lst.de>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Fiona Behrens"
 <me@kloenk.dev>,  "Charalampos Mitrodimas" <charmitro@posteo.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
In-Reply-To: <354dbebd-b211-4e8f-a181-8fbacb0e89c8@proton.me> (Benno Lossin's
	message of "Mon, 17 Feb 2025 23:04:39 +0000")
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org>
	<20250207-configfs-v2-2-f7a60b24d38e@kernel.org>
	<S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid>
	<dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me>
 <87h64su8ux.fsf@kernel.org>
	<Kkrr23DbfvS1nChcwAfhrogDdCOO92FQ2-9JUCab-_6CREP4iBX8k1KuxaJb-yv_ErGv9TbzDWwBZHvaszFS7w==@protonmail.internalid>
	<bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me>
 <87bjv0u5j0.fsf@kernel.org>
	<tcJpvFhkOFzCzmninRJkr73k-06Rk0phzD0fSRQqeLPcGS9dR06GpRzWI-xxIhnRksFDhfNaLsrI-YfpraVcZg==@protonmail.internalid>
	<354dbebd-b211-4e8f-a181-8fbacb0e89c8@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 09:40:53 +0100
Message-ID: <87eczvhch6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 17.02.25 13:20, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 17.02.25 12:08, Andreas Hindborg wrote:
>>>>>> +
>>>>>> +/// A `configfs` subsystem.
>>>>>> +///
>>>>>> +/// This is the top level entrypoint for a `configfs` hierarchy. To=
 register
>>>>>> +/// with configfs, embed a field of this type into your kernel modu=
le struct.
>>>>>> +#[pin_data(PinnedDrop)]
>>>>>> +pub struct Subsystem<Data> {
>>>>>
>>>>> Usually, we don't have multi-character generics, any specific reason
>>>>> that you chose `Data` here over `T` or `D`?
>>>>
>>>> Yes, I find it more descriptive. The patch set went through quite a bit
>>>> of evolution, and the generics got a bit complicated in earlier
>>>> iterations, which necessitated more descriptive generic type parameter
>>>> names. It's not so bad in this version after I restricted the pointer
>>>> type to just `Arc`, but I still think that using a word rather a single
>>>> letter makes the code easier to comprehend at first pass.
>>>
>>> Makes sense. I'm not opposed to it, but I am a bit cautious, because one
>>> disadvantage with using multi-character names for generics is that one
>>> cannot easily see if a type is a generic or not. Maybe that is not as
>>> important as I think it could be, but to me it seems useful.
>>
>> If you use an editor with semantic highlighting, you can style the
>> generic identifiers. I am currently trying out Helix, and that is
>> unfortunately on of the features it is missing. Can't have it all I
>> guess.
>
> That is true, but there are a lot of places where Rust code is put that
> aren't my editor (git diffs/commit messages, mails, lore.kernel.org,
> github) and there it'll become more difficult to read (also people might
> not have their editor configured to highlight them).
>
> So I think we should at least consider it more.

There is a trade-off to be made for sure.

>
>>>>>> +                    // SAFETY: We are expanding `configfs_attrs`.
>>>>>> +                    static [< $data:upper _ $name:upper _ATTR >]:
>>>>>> +                      $crate::configfs::Attribute<$attr, $data, $da=
ta> =3D
>>>>>> +                        unsafe {
>>>>>> +                            $crate::configfs::Attribute::new(c_str!=
(::core::stringify!($name)))
>>>>>> +                        };
>>>>>> +                }
>>>>>> +            )*
>>>>>> +
>>>>>> +
>>>>>> +            const N: usize =3D $cnt + 1usize;
>>>>>
>>>>> Why do we need an additional copy? To have a zero entry at the end fo=
r C
>>>>> to know it's the end of the list? If so, a comment here would be very
>>>>> helpful.
>>>>
>>>> Yes, we need space for a null terminator. I'll add a comment.
>>>>
>>>> We actually have a static check to make sure that we not missing this.
>>>
>>> Where is this static check?
>>
>> In `Attribute::add`:
>>
>>         if I >=3D N - 1 {
>>             kernel::build_error!("Invalid attribute index");
>>         }
>
> Ahh I see, would be also nice to have a comment there explaining why the
> check is `>=3D N - 1`.

I'll add a comment =F0=9F=91=8D


Best regards,
Andreas Hindborg




