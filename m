Return-Path: <linux-kernel+bounces-564783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B7A65AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53A71880215
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91B1537CB;
	Mon, 17 Mar 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UU87RXA5"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6740C03
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232148; cv=none; b=cKfSuICh5xwANPH85lcEPibmhwPN1oX5d9UCRu9SSjYm81HxUfUq6K5INhzhINo8wt5zTcCpQfm8pS7Kn8n6TqUAShm3fmvPvvJF69ob4dr68mZfvap9eughfUZfeElwXi3XQXUecSfz3zwq9dlAn9GIgzFUvsC/ch6ZuRRZzDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232148; c=relaxed/simple;
	bh=B+Up7d0Z8wa56e82ogZrDvmKDPW4RJZVDvjvFFZDNRw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsVaNo7citWdi9oT5/l8Uq/Q9tVDmw+KUfJUawYibeQ4GGTW8NQxMXMG9OTQx8kVomB448iInaRdN9wsj+YtLXLejc8UUt3rPJWgHINcOOV4m2ISCGYmtXkMaCQdSMxmmH13lYgxOIjnyvdi+iNqgKNpIa0d9rc7jjZ3hifrrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UU87RXA5; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742232143; x=1742491343;
	bh=DESxcuoCBw+aq4zHzk9noLj49928I7AbU/o2hoK4cnM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=UU87RXA5BRMvneWzmaI8Z8XZj1+ESi5u9or6emtjsj67lXFTS0hWiziPYJINU5p4H
	 T5iydj69o9KIlYCe2+itcXl5SGbJhdyaK5U31SKO5RZ5xlFrUT22wFqqxKSxKE16ok
	 f204eaw+S3Nra4ALii6BGP2cPTmics/IP6ge3dFUJ5sw5MibG8/2Xpy6j33lySOmJl
	 wqguRR5IPzU6qjR64iN3EJXRBquXF5fRMs5IG/NZQTkneEAcFe3+Sqct+xPT25bU/M
	 +2IHCEEt2sjbmxb3s9g1bscRPeoPfQIrqRhgaMrg2e5O243GOl19VbulBGl8JokbDU
	 rAq8p1k7vsHcA==
Date: Mon, 17 Mar 2025 17:22:15 +0000
To: Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <D8IPQUN25M12.2CIZR4QHJ201N@proton.me>
In-Reply-To: <Z9hXMcFVdF8MMusU@cassiopeiae>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com> <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me> <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com> <Z9hXMcFVdF8MMusU@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e266c822ec3552c9807e853f5439c912b8c7816c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 6:09 PM CET, Danilo Krummrich wrote:
> On Mon, Mar 17, 2025 at 10:39:05AM -0400, Tamir Duberstein wrote:
>> On Mon, Mar 17, 2025 at 10:34=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>> > On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
>> > > Use `spare_capacity_mut` in the implementation of `push` to reduce t=
he
>> > > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("ru=
st:
>> > > alloc: implement kernel `Vec` type").
>> > >
>> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > > ---
>> > >  rust/kernel/alloc/kvec.rs | 11 ++---------
>> > >  1 file changed, 2 insertions(+), 9 deletions(-)
>> > >
>> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
>> > > index ae9d072741ce..d2bc3d02179e 100644
>> > > --- a/rust/kernel/alloc/kvec.rs
>> > > +++ b/rust/kernel/alloc/kvec.rs
>> > > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [M=
aybeUninit<T>] {
>> > >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocE=
rror> {
>> > >          self.reserve(1, flags)?;
>> > >
>> > > -        // SAFETY:
>> > > -        // - `self.len` is smaller than `self.capacity` and hence, =
the resulting pointer is
>> > > -        //   guaranteed to be part of the same allocated object.
>> > > -        // - `self.len` can not overflow `isize`.
>> > > -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
>> > > -
>> > > -        // SAFETY:
>> > > -        // - `ptr` is properly aligned and valid for writes.
>> > > -        unsafe { core::ptr::write(ptr, v) };
>> > > +        // The call to `reserve` was successful so the spare capaci=
ty is at least 1.
>> > > +        self.spare_capacity_mut()[0].write(v);
>> >
>> > I think the code uses unsafe to avoid a bounds check, but I'm not 100%
>> > sure. Danilo might remember more info.
>
> Yes, that was the justification to use unsafe calls instead.
>
> (This may also justify keeping dec_len() unsafe, since otherwise it would
> introduce an additional boundary check for pop().)

If we use saturating_sub then we don't need a bounds check (at least on
non-debug builds), right?=20

>> We could use `slice::get_unchecked_mut` here to retain the same
>> guarantee of no bounds check. That would still be one fewer unsafe
>> blocks.
>
> Sounds reasonable.

+1


