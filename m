Return-Path: <linux-kernel+bounces-436112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB09E813F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CCD1884661
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D435149DF7;
	Sat,  7 Dec 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMaTT/uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36921E885;
	Sat,  7 Dec 2024 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593014; cv=none; b=UYy+wBaf5vEmmWTPvhWEeoej5k1f+Ep1R1m2veflk8jxDDNkufC0Pn8dpMuxeLhEauc6o9QqUAIULGRng3kZgJ1ouh77Nm9V2ZG7hhxcWns02pVvIyVwYiFVV+PP0g2agUv95wCdW/M4qjJiRBEaFYb4bvCnT3fULunxUwB6oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593014; c=relaxed/simple;
	bh=HXQMatuQjoBSRT4KfGjYzRE+8IcDuZDzHozZhWD1sok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQbtwjiOjAIyJpGul3sQcaA4SIsCdEuBf+hX7EXLwg/pWZnZpJavuPCNZ2///xdWfJ6bTvh7uMjGpAQ6WFemK7DvYey8y5fJKPpkqjHc9q4YV/yRYZ3HMMagmDZjddp4qBU82SNNo3FywYZX7ZM9+PD/g1tSqjpim8kYnuA2Zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMaTT/uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE333C4CECD;
	Sat,  7 Dec 2024 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733593013;
	bh=HXQMatuQjoBSRT4KfGjYzRE+8IcDuZDzHozZhWD1sok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MMaTT/uFByeC2KuJFJmoc0rCL9kpu1IMqZGTogdr9eAyu/bBo+R4/WV4aQ+vxzs+g
	 ZEpf2MXp4wuPdWkIjU80b6FaiiKCIkruuN/0frnk+bL1PK5yDIC//HaHLHzrgnMPch
	 8sdah4eumO9xuIfwKhFWtcc1X9slcZpZpobXq5RZMV2CjYPD20rTXVD/10N00r2ww4
	 1mXAl3rdUiSqv+mloiXZBL4d7k0a1Z84STuy2cocq6Ls+jUhszUrYTUtpHXImwv41/
	 R5CgZmgebn2RE9eq0HLLdbvRhdGXc1f3nc8V2QjgW00i651/JLfFzJFzPK/j4WLRGW
	 N6mcIFREXDalA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Guangbo Cui" <2407018371@qq.com>
Cc: <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,
  <anna-maria@linutronix.de>,  <benno.lossin@proton.me>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <frederic@kernel.org>,  <gary@garyguo.net>,
  <linux-kernel@vger.kernel.org>,  <lyude@redhat.com>,  <ojeda@kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <tglx@linutronix.de>,
  <tmgross@umich.edu>
Subject: Re: [PATCH v4 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <tencent_4237DDAC9DC29A9774F0F24D438C0ED31C05@qq.com> (Guangbo
	Cui's message of "Sat, 07 Dec 2024 22:35:54 +0800")
References: <20241206-hrtimer-v3-v6-12-rc2-v4-2-6cb8c3673682@kernel.org>
	<tmL-yhuAhBzpYcPmWBdsjQYKx9M0gIyF4wfwrRA36zzhI_E-w0rZiJmA_Y68oBXPVAi6YwPepy3YIqAsBang9A==@protonmail.internalid>
	<tencent_4237DDAC9DC29A9774F0F24D438C0ED31C05@qq.com>
Date: Sat, 07 Dec 2024 18:36:39 +0100
Message-ID: <87o71ne6oo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Guangbo Cui" <2407018371@qq.com> writes:

>> +#[macro_export]
>> +macro_rules! impl_has_timer {
>> +    (
>> +        impl$({$($generics:tt)*})?
>> +            HasTimer<$timer_type:ty>
>> +            for $self:ty
>> +        { self.$field:ident }
>> +        $($rest:tt)*
>> +    ) =3D> {
>> +        // SAFETY: This implementation of `raw_get_timer` only compiles=
 if the
>> +        // field has the right type.
>> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasTimer<=
$timer_type> for $self {
>> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $fiel=
d) as usize;
>> +
>> +            #[inline]
>> +            unsafe fn raw_get_timer(ptr: *const Self) ->
>> +                *const $crate::::time::hrtimer::Timer<$timer_type>
>
> Hi Andreas, an extra `::` here.

One of these days I hope to have refined my workflow to a degree that
would prevent things like this. I thought I was there, but not yet it
seems. Thanks for spotting.

I _did_ actually fix this, but the fix was hiding in a commit with test
code that did not make it in to the series =F0=9F=A4=A6 And when ran my scr=
ipt to
make sure all the commits build, this macro was no longer invoked and
the typo was hiding.

For reference, I am holding the examples back until we get either a
spinlock/condvar combo that can work in irq disabled context, or atomics
that work with LKMM.

Best regards,
Andreas Hindborg






