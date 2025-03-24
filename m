Return-Path: <linux-kernel+bounces-574236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A562A6E267
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3073B24E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D1F265608;
	Mon, 24 Mar 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AHBdPPyR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC0264FAE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841183; cv=none; b=IxrbmM0ASWXrI4sptPSgz8hG5s4cabm/r9l7WrePefSPxZeHA9Zy4k6aO1djrng5xPZaN03AV9Kr2IRSNBKXUVxLYu2/lUrmQyeSEhmPQj3T30IXpKJoo+h2qxfZFmrrEJCRWDws3hIHHIYUo8smXHOxT4afnA778CtGjkh4UHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841183; c=relaxed/simple;
	bh=giOVo/hMU9EM1ySCHMr8Kfg9AjH/yxV3BztyAZ+Mcc8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4R90G1QpC6AGR298mP7GerPS5cVcIQ5DUTPmnNHckuqvvrsAmxnsUG0EUn4P36nD2ROBdrslrcXVG10c3fH8M8ZFXV+6RTdvFfANwO5N0kT26tohfBkiQfGftMJ/iPq9mwXcG3teMGcRa//J4va8RbZtdtmidg7cQeBzvJDmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AHBdPPyR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742841178; x=1743100378;
	bh=3JQmVZ7nQgL0C1nvQoKUI780iq8dM/BIdl9nGsDpqHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=AHBdPPyRQ4Kj+DHt71Btr9k2vTlKtwhIqDhJEo2/YnHbu54qTIx4WlHv7AsgYXZWK
	 Nc4RAzPk1r4WLFWlQFLelVacFDNLSF4l5K5fV9eFIz1Z8S/7ahBwsUoZ73KbsTOez9
	 DLNVeZa+XEnAMmVeWb7O1Yb4hJeute3rL3SzXnlWdV3GXyVwzBZITQkZjKSUUDdLOO
	 a95WbqubEFazBc1hrv960lST4Zr3vbZX0vBbCNJhNGhAFVCOeXPeigvxbR6HrxGxG7
	 Tf++Q+SMy3pVnTQRs9pDSaTW9V1Ic26es+aN7dRSZVgZ/AJLgcZrFDQIzwTBGWwKK9
	 2hkZ3qFMRUgMA==
Date: Mon, 24 Mar 2025 18:32:53 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8OPMRYE0SO5.2JQD6ZIYXHP68@proton.me>
In-Reply-To: <Z-Ggu_YZBPM2Kf8J@cassiopeiae>
References: <20250321214826.140946-1-dakr@kernel.org> <20250321214826.140946-3-dakr@kernel.org> <2025032158-embezzle-life-8810@gregkh> <Z96MrGQvpVrFqWYJ@pollux> <Z-CG01QzSJjp46ad@pollux> <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me> <Z-GNDE68vwhk0gaV@cassiopeiae> <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me> <Z-Ggu_YZBPM2Kf8J@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 76de513fbfba2241a6334f65c143226078d51e1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 24, 2025 at 7:13 PM CET, Danilo Krummrich wrote:
> On Mon, Mar 24, 2025 at 05:36:45PM +0000, Benno Lossin wrote:
>> On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
>> > On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
>> >> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
>> >> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
>> >> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
>> >> >> > Along these lines, if you can convince me that this is something=
 that we
>> >> >> > really should be doing, in that we should always be checking eve=
ry time
>> >> >> > someone would want to call to_pci_dev(), that the return value i=
s
>> >> >> > checked, then why don't we also do this in C if it's going to be
>> >> >> > something to assure people it is going to be correct?  I don't w=
ant to
>> >> >> > see the rust and C sides get "out of sync" here for things that =
can be
>> >> >> > kept in sync, as that reduces the mental load of all of us as we=
 travers
>> >> >> > across the boundry for the next 20+ years.
>> >> >>=20
>> >> >> I think in this case it is good when the C and Rust side get a bit
>> >> >> "out of sync":
>> >> >
>> >> > A bit more clarification on this:
>> >> >
>> >> > What I want to say with this is, since we can cover a lot of the co=
mmon cases
>> >> > through abstractions and the type system, we're left with the not s=
o common
>> >> > ones, where the "upcasts" are not made in the context of common and=
 well
>> >> > established patterns, but, for instance, depend on the semantics of=
 the driver;
>> >> > those should not be unsafe IMHO.
>> >>=20
>> >> I don't think that we should use `TryFrom` for stuff that should only=
 be
>> >> used seldomly. A function that we can document properly is a much bet=
ter
>> >> fit, since we can point users to the "correct" API.
>> >
>> > Most of the cases where drivers would do this conversion should be cov=
ered by
>> > the abstraction to already provide that actual bus specific device, ra=
ther than
>> > a generic one or some priv pointer, etc.
>> >
>> > So, the point is that the APIs we design won't leave drivers with a re=
ason to
>> > make this conversion in the first place. For the cases where they have=
 to
>> > (which should be rare), it's the right thing to do. There is not an al=
ternative
>> > API to point to.
>>=20
>> Yes, but for such a case, I wouldn't want to use `TryFrom`, since that
>> trait to me is a sign of a canonical way to convert a value.
>
> Well, it is the canonical way to convert, it's just that by the design of=
 other
> abstractions drivers should very rarely get in the situation of needing i=
t in
> the first place.

I'd still prefer it though, since one can spot a

    let dev =3D CustomDevice::checked_from(dev)?

much better in review than the `try_from` conversion. It also prevents
one from giving it to a generic interface expecting the `TryFrom` trait.

---
Cheers,
Benno


