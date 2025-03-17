Return-Path: <linux-kernel+bounces-564385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB59A653F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B3F16416D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5124A055;
	Mon, 17 Mar 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Gs1oHG3Z"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC51243964
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222361; cv=none; b=OWHG+Kn7HaiSd1gEFwelBCw6FYk9cmAxU8ATVBTLaLgbvnxt9fxlShVa7BJ6ke9iwK1UJZF7gOCuOrympvNIRlMTdzZ3nbKp/pWKI2EEjdRqAI02W4PCHf5w1J32SZUq2qVT6+arkbfXmk+ivtcqNG485UkvqsZq3roGOj8aMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222361; c=relaxed/simple;
	bh=dV/6KfJ3nVUQ1IyjbNxpACkNcAzqxNbaMcKsz0VL41A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1HCSEn3ygPHceMUzZL+cqmFTVeiXmE92BGbXASTYjQZisuwnUV3o+Kcp9Jry7IFqnoVW4Th2sgqj8V2JMC6pHQ9eGnoIzvPdevbnHAzn35NMEf1srtLrPw1uOj1NFbnfKpdqCPkSxw5jYP69Tc0UaoRjwkG3c7WELAxLGjGfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Gs1oHG3Z; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742222358; x=1742481558;
	bh=rOVo+0+B8snlkYD4v50XyEx7TvsqYnx13mj95B5c0pY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Gs1oHG3ZH+X4/H0g+us26zzRXGMYV9nq+eoqZVTf0Kqg1lgHSfMnOHxBpaWSV/fVt
	 OEwGbq7lUil21/W1aUjU3MZHgDF4vp0sTt+hxu2nFh7v2KiMlW1zyeBOiteioKDrJ3
	 LrvswN+J3cDNNe0ip4cPUIcYuenkX2QdILxNGMN3zJWpVqkERSUz7P5p0HNFHGo5lL
	 P2bWeF74DCqVxF8/MA0dlcf5wW8G0Vnz/CS/IT0CkF5OVOKAlPE1FXKfPivg7WF6ae
	 BzozqIDpIcvoDE3S4Sx1JufLcwEzfqzI8nnA0ByLkf0LMuhipuQMFOi03rXgm2+OCf
	 v6Y5ywyGX2gug==
Date: Mon, 17 Mar 2025 14:39:12 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me>
In-Reply-To: <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me> <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8b3d3e1212f919ffe916b201b5c6cae29ae0c424
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 12:34 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
>> > Add `Vec::dec_len` that reduces the length of the receiver. This metho=
d
>> > is intended to be used from methods that remove elements from `Vec` su=
ch
>> > as `truncate`, `pop`, `remove`, and others. This method is intentional=
ly
>> > not `pub`.
>>
>> I think it should be `pub`. Otherwise we're loosing functionality
>> compared to now. If one decides to give the raw pointer to some C API
>> that takes ownership of the pointer, then I want them to be able to call
>> `dec_len` manually.
>
> This is premature. It is trivial to make this function pub when the need =
arises.

And it's trivial to do it now. If it's private now, someone will have to
change this in some random patch and it's annoying.

>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)
>> >
>> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
>> > index d43a1d609434..5d604e04b9a5 100644
>> > --- a/rust/kernel/alloc/kvec.rs
>> > +++ b/rust/kernel/alloc/kvec.rs
>> > @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usiz=
e) {
>> >          self.len +=3D additional;
>> >      }
>> >
>> > +    /// Decreases `self.len` by `count`.
>> > +    ///
>> > +    /// Returns a mutable reference to the removed elements.
>>
>> s/reference/slice/
>>
>> I would also mention here that the elements won't be dropped when the
>> user doesn't do that manually using the slice. So explain that this is a
>> low-level operation and `clear` or `truncate` should be used instead
>> where possible.
>
> Neither function exists. I've added a description of the semantics of the=
 slice.

Fair point, would still be nice to point users to these when they exist.

>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// - `count` must be less than or equal to `self.len`.
>>
>> I also think that we should use saturating_sub instead and then not have
>> to worry about this. (It should still be documented in the function
>> though). That way this can also be a safe function.
>
> This doesn't seem better to me. I'd prefer to have more rather than
> fewer guardrails on such low-level operations.

Your second sentence seems like an argument for making it safe? I think
it's a lot better as a safe function.

---
Cheers,
Benno


