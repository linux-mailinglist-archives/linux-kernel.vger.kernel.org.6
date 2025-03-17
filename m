Return-Path: <linux-kernel+bounces-564788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F861A65AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A317F477
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3019F424;
	Mon, 17 Mar 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ULXQOrmk"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A691598F4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232307; cv=none; b=C/VT08RjgwLBMtgqThgQrkdsmt9QIz69wOLlntilDFjM71emLBTWJis/EfpAblyU9BLK+MekVgIimpaYNr6xRCrklDjye/IiCOLrlGyxoWDQd+xh4KC6Z7gadTsmWaJWH1dZ6YZnmIKCi2vF36pxN40ZT0QxjOWuxk2uNnag+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232307; c=relaxed/simple;
	bh=E8mCUktcye+tTgMDxoS6r0Kp92cpbr+ZlAH5107SzCI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jb1V3QGEH86i19CI9bOYNb+9atmJb9OUC3TysGV4HY2S6EemkrWbd419VazP8d0tI9P0gpYCkA+oLRVzi3ftA56jobQLt4Suao8O44NZCrgXflDpvIfmPDr1bWjKJGAcTQ5LIejbwA4RrDh6Dwzs7ESrhC161qr64pt+3dl37rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ULXQOrmk; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742232302; x=1742491502;
	bh=Ije4R12tkjONQYl0x9YoR0tQN8Y1ebS9qLeyIdWqs9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ULXQOrmkEbtTh8V+Yw2LL7j1gaCax1ziTGeT8oD/2SplIWE8w7cr5JaTcL9Iyr/1f
	 dZOzpZ5UyjSUQvO+JPI1ZN+F+eq6VI9VbDsfy2HvYRbV6zUyU0CtyNBVs6QBFFPWaz
	 H5hxGXxLY1apwv44j8R4pfhWJHZHeri7pNu+wiQdsRnFVjWIOMHeSP4P0igQUDO4Mw
	 zIQDqcfAbe86AhDC5LOgFwM8N0BrBp/oIqLUd6eJCrBY8eRz4OP80/fsTd6203BUR1
	 PFckMeRfFinvEAq/49R1T3Ea6pVfUU7qWctcNTd5QSFZ+3o8x5CE/KCButUesNm60o
	 itVPFowfBjEpQ==
Date: Mon, 17 Mar 2025 17:24:55 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
Message-ID: <D8IPSWQWM6U0.1VLTOFNL99G64@proton.me>
In-Reply-To: <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me> <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com> <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me> <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 72b707384655795c8dff72d875329cbd30723c14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 10:39=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>> On Mon Mar 17, 2025 at 12:34 PM CET, Tamir Duberstein wrote:
>> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
>> >> > +    ///
>> >> > +    /// # Safety
>> >> > +    ///
>> >> > +    /// - `count` must be less than or equal to `self.len`.
>> >>
>> >> I also think that we should use saturating_sub instead and then not h=
ave
>> >> to worry about this. (It should still be documented in the function
>> >> though). That way this can also be a safe function.
>> >
>> > This doesn't seem better to me. I'd prefer to have more rather than
>> > fewer guardrails on such low-level operations.
>>
>> Your second sentence seems like an argument for making it safe? I think
>> it's a lot better as a safe function.
>
> The guardrail I was referring to is the requirement that the caller
> write a safety comment.

But saturating_sub is a better guardrail?

---
Cheers,
Benno


