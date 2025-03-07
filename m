Return-Path: <linux-kernel+bounces-551197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B256AA5694B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2267618983F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255D21ADA4;
	Fri,  7 Mar 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l/9GMcG7"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07F20DD79
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355203; cv=none; b=uqLkO+FzhiFx7V51WluGc+M3Rg+K38NNkUX2lLYKC129f38epFCNfPfw3fG6rbGclolYS1oDzrDsInwINE+zhVv06RubvNowkD6H8p/rvubtd7ptt49ZYTw0SzQ2haXJdy8h7heHGHQO2PvhpzFtLfiNLa6KHWuB9Zg7yCeWhcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355203; c=relaxed/simple;
	bh=He23/8mZZeZEGBeQVNebcLJi23Qj3PgN+QnWnUERjPc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsYGUYGb3LHG3t3jgnUi7HKyub0RPZ/fVnhQZwwR4pGX7cPCPmLu0tR0xL7azMgHimWYgsjiT/9/IA+FN6RBlHoL0LDQ8j+U55oM0WLHbzSxMvmHtJGjRpwjeNv9d+SkRD5Pw5HQ8De+wF0vnpwJs5b6rEiRuAdFeOkCSQcAXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l/9GMcG7; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=nyswv2o3x5g4lhoo7wghgi26uy.protonmail; t=1741355195; x=1741614395;
	bh=jQOVrGU7Or9HJAB8PZjksGhwjMOslJNvzzwPKN5EXj4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l/9GMcG7xVztXmqp2bjBwegVt4l82BHiyt1UxiJ8uC/SHt8y9qBKFLhBDdoX+CxjB
	 UWWlRbbR7vxQmsPQvZ3WHHInFP4udAH5z2a82dv2JKN7vxnxmbZT+Nc2V5Ehbh8Cl2
	 drOiK8K9rhBg9K3lNtFVUdqLdKEAEEuxmgNYjeiKb9/k6yuNCCrGkMDa3SkV3joeVq
	 6S5ElN4dy4eq1j7ZlLd/QqrcnmPcil4gTdzBdUbDM1svALAP/cG3uVv4NxsMBt/NbH
	 j9L8ox94HWi2RN3ugufMcIAh1Y16aAC9Uligt4006HMtoV1s8r2FzQt5iRGJMmnBwd
	 2cwOOMieIJEqg==
Date: Fri, 07 Mar 2025 13:46:32 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/13] rust: hrtimer: introduce hrtimer support
Message-ID: <D8A2W9JIGFX3.20YC7NQRET0XG@proton.me>
In-Reply-To: <87y0xh3s1u.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-1-0cf7e9491da4@kernel.org> <BdAxp1BNMXx919FqV2Yamyjr3d4pUGCHU8GhvKZG6scY5etznAwQeuf1ISWLu2lm9XHt2qC9kJUnlSSENhODuA==@protonmail.internalid> <D8A1JVVYBHY5.13BB8V796A7RR@proton.me> <87y0xh3s1u.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 91620299353540043126fb36575ac411fd18f213
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 2:10 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>> +/// Use to implement the [`HasHrTimer<T>`] trait.
>>> +///
>>> +/// See [`module`] documentation for an example.
>>> +///
>>> +/// [`module`]: crate::time::hrtimer
>>> +#[macro_export]
>>> +macro_rules! impl_has_hr_timer {
>>> +    (
>>> +        impl$({$($generics:tt)*})?
>>> +            HasHrTimer<$timer_type:ty>
>>> +            for $self:ty
>>> +        { self.$field:ident }
>>> +        $($rest:tt)*
>>> +    ) =3D> {
>>> +        // SAFETY: This implementation of `raw_get_timer` only compile=
s if the
>>> +        // field has the right type.
>>> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTim=
er<$timer_type> for $self {
>>> +
>>> +            #[inline]
>>> +            unsafe fn raw_get_timer(this: *const Self) ->
>>> +                *const $crate::time::hrtimer::HrTimer<$timer_type>
>>> +            {
>>> +                // SAFETY: The caller promises that the pointer is not=
 dangling.
>>> +                unsafe {
>>> +                    ::core::ptr::addr_of!((*this).$field)
>>> +                }
>>> +            }
>>> +
>>> +            #[inline]
>>> +            unsafe fn timer_container_of(ptr: *mut $crate::time::hrtim=
er::HrTimer<$timer_type>) ->
>>> +                *mut Self
>>
>> This formatting looks a bit weird, (macro formatting is annoying, I
>> know).
>
> How would you change it?

Just use `rustfmt` (copy the macro arm, replace all `$` with `_` in
names and remove repetitions, `rustfmt` and then revert. You're lucky,
since you only have one repetition that doesn't cause the line to go
over the 100 column threshold):

        // SAFETY: This implementation of `raw_get_timer` only compiles if =
the
        // field has the right type.
        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer<$t=
imer_type> for $self {

            #[inline]
            unsafe fn raw_get_timer(
                this: *const Self,
            ) -> *const $crate::time::hrtimer::HrTimer<$timer_type> {
                // SAFETY: The caller promises that the pointer is not dang=
ling.
                unsafe { ::core::ptr::addr_of!((*this).$field) }
            }

            #[inline]
            unsafe fn timer_container_of(
                ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>,
            ) -> *mut Self {
                // SAFETY: As per the safety requirement of this function, =
`ptr`
                // is pointing inside a `$timer_type`.
                unsafe { ::kernel::container_of!(ptr, $timer_type, $field).=
cast_mut() }
            }
        }

---
Cheers,
Benno


