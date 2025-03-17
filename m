Return-Path: <linux-kernel+bounces-564808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A368BA65B20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BB13AF9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991B1B042C;
	Mon, 17 Mar 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LHNprYzx"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938D1A3BD8;
	Mon, 17 Mar 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233279; cv=none; b=PeijFRr6eGwX/ZEzxNtSyFbdxHRQS8j1P5dotBuQr1YQfEulgvjOCKevmS1OGQJY+Xu9Y6ZYuBqFfaDn61CxrfS51WfL8IC1EE0LmQiZnlDPFxEA7B3yL5no4yvb3C4LeVBAsh9ACZKpN77hqQ69XboTnORYtGyrMJOaLGDzLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233279; c=relaxed/simple;
	bh=iu44wgthYyTh1SqCwXR1ZGH0ktKtHTEd93GtQOlTVCA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu7dtLCjTi8gwsI5QMqK192lvIryYjkk2CdNTK6gwTMoiYQsUcWpq+Tima4e79ghfvpqR2r6KAixWWKa3jwudIVd599yWYL1MOudbkFbnvyxT4yeG7EtkD6xro2xP/sNt13JRknUvOBN0NxgpX6nCUpYqdyWbZTR7ohf2hCQ9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LHNprYzx; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742233273; x=1742492473;
	bh=cXyowStxyGgvi3DcGmn0KmNT13x8xO+oV/37o6r7H7c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LHNprYzx+5bvzX4MjZci6UomgZCH1qf2nvqZUNYYFGOPucM9gtgjdSyt0oToc6/Up
	 IBZqWXpWMuUUPcUIS6fi5B71pgF+Hc4fUDXqoWGIYrRmjziY/gyef4GLyT4MegkKxQ
	 ZtSXnpSS8Ib0Y5n5GsVDCuP6o18pYQCz5S+RBwC40aMQhpdVvh2d3dzf2C0YW9NIn4
	 0FoR0NjeWtOvExpuWp38eCqUyPAIsjEL0sINsFOgQxF6ttfEfGEHduRhjt3vMxq0/h
	 HlbM4qNiWcwVXW7nJL+vpjCvE+E7uNDfkAPbLUpTsyEtRGostnLYfHnsv5uWweXFe9
	 6TNr+rTh8vvHA==
Date: Mon, 17 Mar 2025 17:41:08 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Message-ID: <D8IQ5BDTLCLZ.1UBNYUXLK12X0@proton.me>
In-Reply-To: <Z9hcT4KPwgtHmiTT@cassiopeiae>
References: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com> <D8IM66U67XBD.28KWYO1XSF8ZQ@proton.me> <CAJ-ks9kq1cQ2-ZNzG9P4SBvk-AjXxT+na-89K33imB4fsCvu4A@mail.gmail.com> <Z9hXMcFVdF8MMusU@cassiopeiae> <D8IPQUN25M12.2CIZR4QHJ201N@proton.me> <Z9hcT4KPwgtHmiTT@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d6493df68ab0bb050a60f06a1d069229508356db
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 6:30 PM CET, Danilo Krummrich wrote:
> On Mon, Mar 17, 2025 at 05:22:15PM +0000, Benno Lossin wrote:
>> On Mon Mar 17, 2025 at 6:09 PM CET, Danilo Krummrich wrote:
>> > On Mon, Mar 17, 2025 at 10:39:05AM -0400, Tamir Duberstein wrote:
>> >> On Mon, Mar 17, 2025 at 10:34=E2=80=AFAM Benno Lossin <benno.lossin@p=
roton.me> wrote:
>> >> > On Mon Mar 17, 2025 at 12:42 PM CET, Tamir Duberstein wrote:
>> >> > > Use `spare_capacity_mut` in the implementation of `push` to reduc=
e the
>> >> > > use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 (=
"rust:
>> >> > > alloc: implement kernel `Vec` type").
>> >> > >
>> >> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> >> > > ---
>> >> > >  rust/kernel/alloc/kvec.rs | 11 ++---------
>> >> > >  1 file changed, 2 insertions(+), 9 deletions(-)
>> >> > >
>> >> > > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.r=
s
>> >> > > index ae9d072741ce..d2bc3d02179e 100644
>> >> > > --- a/rust/kernel/alloc/kvec.rs
>> >> > > +++ b/rust/kernel/alloc/kvec.rs
>> >> > > @@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut=
 [MaybeUninit<T>] {
>> >> > >      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), All=
ocError> {
>> >> > >          self.reserve(1, flags)?;
>> >> > >
>> >> > > -        // SAFETY:
>> >> > > -        // - `self.len` is smaller than `self.capacity` and henc=
e, the resulting pointer is
>> >> > > -        //   guaranteed to be part of the same allocated object.
>> >> > > -        // - `self.len` can not overflow `isize`.
>> >> > > -        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
>> >> > > -
>> >> > > -        // SAFETY:
>> >> > > -        // - `ptr` is properly aligned and valid for writes.
>> >> > > -        unsafe { core::ptr::write(ptr, v) };
>> >> > > +        // The call to `reserve` was successful so the spare cap=
acity is at least 1.
>> >> > > +        self.spare_capacity_mut()[0].write(v);
>> >> >
>> >> > I think the code uses unsafe to avoid a bounds check, but I'm not 1=
00%
>> >> > sure. Danilo might remember more info.
>> >
>> > Yes, that was the justification to use unsafe calls instead.
>> >
>> > (This may also justify keeping dec_len() unsafe, since otherwise it wo=
uld
>> > introduce an additional boundary check for pop().)
>>=20
>> If we use saturating_sub then we don't need a bounds check (at least on
>> non-debug builds), right?=20
>
> =09fn dec_len(&mut self, count: usize) -> &mut [T] {
> =09    self.len =3D self.len.saturating_sub(count);
>
> =09    // Potentially broken, since maybe `count > self.len`, hence need =
an
> =09    // additional check.
> =09    unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.len)=
, count) }
> =09}

Ah sorry, in my mental model the function returned `()`. Do we need the
return value?

---
Cheers,
Benno


