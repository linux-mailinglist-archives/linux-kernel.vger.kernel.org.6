Return-Path: <linux-kernel+bounces-551260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A2A56A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BCB189345E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDB21ABAC;
	Fri,  7 Mar 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBXMEOHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7A72185BC;
	Fri,  7 Mar 2025 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357124; cv=none; b=lASNr9k3v+9pphIdBGzDzypFB4zeosK+wrQNZFP12B6NPmn0zTQ9HA5VIf/PzbOScnu1PNOSFnAK6t5GDjFTXbYFeIvgUKB2MiqjV9aqHFLJlD20TZP/7Pi5fGOVKRalk1im7CI7Gim2vimxV/0SYfgbuvovkTdEzRDcAXMVwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357124; c=relaxed/simple;
	bh=kcwNa0GyeFaXuEFZkM3BfrpPO17vMyRMIG86Nfldgp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pyORpXV7Hcf8AdxeRLd90lbN3P99DQ46HInD1IQaRe2uXdgW0EYLYgnspj/joFguu64ND0wn19il6GYqiSqvZDh1Oqo4dGlw58fe74+bwm1PLEJf79BQ5hk72ngBJpEbD8Vbkv0CS7VqrcxmiBAWypwXl3Qvozuq903lQN1Xcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBXMEOHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527BEC4CED1;
	Fri,  7 Mar 2025 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357123;
	bh=kcwNa0GyeFaXuEFZkM3BfrpPO17vMyRMIG86Nfldgp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MBXMEOHPYip5pb5uxJX0WNxpRmhjHtSVl/vmzwqXJBpObbKV1l7s8Jajo95K4Gvs5
	 rP/uSzZ9ZQ+ruKeMjKM7P5uQ0BoipbxD72ys2w3tNApzZUC4lK+v2ZN5Vh7k06+Q4Q
	 UVez0yLlP2bDYNFowfBFIDqfU28rE9Rk6a4B9JU/TgvLU4PGUMjw4Rjn9Hxe89pgwd
	 vFgAx832ZALPD5flZkJrWDdaw/wu9f2Si2IBLr14JLxcjYMiPfgwux4Gp69sVcFftM
	 OD9q5qSixmiY9ujh7lBcoRSKc/A6PTqzb2Uh5co48j76SqVkIzLuMardLSRy/UloPO
	 UF+IajfAQAYRA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <D8A2W9JIGFX3.20YC7NQRET0XG@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:46:32 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-1-0cf7e9491da4@kernel.org>
	<BdAxp1BNMXx919FqV2Yamyjr3d4pUGCHU8GhvKZG6scY5etznAwQeuf1ISWLu2lm9XHt2qC9kJUnlSSENhODuA==@protonmail.internalid>
	<D8A1JVVYBHY5.13BB8V796A7RR@proton.me> <87y0xh3s1u.fsf@kernel.org>
	<C_H33kbu86mEcqBEwHMT_7zHFqszHSRSbbmK5V28sJQ2mVXZLFFdNsO4NKh13O2PYSqSMTRqNUgAPRD_41xqdg==@protonmail.internalid>
	<D8A2W9JIGFX3.20YC7NQRET0XG@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 15:17:23 +0100
Message-ID: <87tt852ado.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 2:10 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>> +/// Use to implement the [`HasHrTimer<T>`] trait.
>>>> +///
>>>> +/// See [`module`] documentation for an example.
>>>> +///
>>>> +/// [`module`]: crate::time::hrtimer
>>>> +#[macro_export]
>>>> +macro_rules! impl_has_hr_timer {
>>>> +    (
>>>> +        impl$({$($generics:tt)*})?
>>>> +            HasHrTimer<$timer_type:ty>
>>>> +            for $self:ty
>>>> +        { self.$field:ident }
>>>> +        $($rest:tt)*
>>>> +    ) => {
>>>> +        // SAFETY: This implementation of `raw_get_timer` only compiles if the
>>>> +        // field has the right type.
>>>> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer<$timer_type> for $self {
>>>> +
>>>> +            #[inline]
>>>> +            unsafe fn raw_get_timer(this: *const Self) ->
>>>> +                *const $crate::time::hrtimer::HrTimer<$timer_type>
>>>> +            {
>>>> +                // SAFETY: The caller promises that the pointer is not dangling.
>>>> +                unsafe {
>>>> +                    ::core::ptr::addr_of!((*this).$field)
>>>> +                }
>>>> +            }
>>>> +
>>>> +            #[inline]
>>>> +            unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>) ->
>>>> +                *mut Self
>>>
>>> This formatting looks a bit weird, (macro formatting is annoying, I
>>> know).
>>
>> How would you change it?
>
> Just use `rustfmt` (copy the macro arm, replace all `$` with `_` in
> names and remove repetitions, `rustfmt` and then revert. You're lucky,
> since you only have one repetition that doesn't cause the line to go
> over the 100 column threshold):
>
>         // SAFETY: This implementation of `raw_get_timer` only compiles if the
>         // field has the right type.
>         unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer<$timer_type> for $self {
>
>             #[inline]
>             unsafe fn raw_get_timer(
>                 this: *const Self,
>             ) -> *const $crate::time::hrtimer::HrTimer<$timer_type> {
>                 // SAFETY: The caller promises that the pointer is not dangling.
>                 unsafe { ::core::ptr::addr_of!((*this).$field) }
>             }
>
>             #[inline]
>             unsafe fn timer_container_of(
>                 ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>,
>             ) -> *mut Self {
>                 // SAFETY: As per the safety requirement of this function, `ptr`
>                 // is pointing inside a `$timer_type`.
>                 unsafe { ::kernel::container_of!(ptr, $timer_type, $field).cast_mut() }
>             }
>         }

That is better.


Best regards,
Andreas Hindborg



