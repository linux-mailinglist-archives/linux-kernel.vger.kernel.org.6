Return-Path: <linux-kernel+bounces-546604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834FDA4FCBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7263B1DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897691F8BC6;
	Wed,  5 Mar 2025 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DtKM394V"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48421ADA9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171647; cv=none; b=RRarMNov5WHx2v6IEXLq8GfBBK0zWhace6JtmI8WFcujL2212hgQEflPT5q0NDgZZs4YEcdbtDatv/MmI3dgjnZyMLJocAA9jgCxNqjJ63rpTrXKoMUSfeVByEs7py+ULlY4hPSXRqXiY2xJ7O9tsoxAX0ZQV5kfzob3AsH4R5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171647; c=relaxed/simple;
	bh=RE4HuLtJI4dpis8wSZOIEqNjFD2NNuZOalfgkbWId6E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RA9yhfRbN5nUqYBoD/59+l9V+QBWNLhfBE1FTzxVpnU68sK7xxYMDeyQepzaVcp8zq37p45qy059+HAouxujU7qL0dla7JCeTqrKqRU2+E20YhqHI4k2pWs/pfaPPi5fJo2VqFTXm3/oECUoB89BeSlvD4G30xzR49GgeVDHySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DtKM394V; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741171643; x=1741430843;
	bh=pzYCh+bDp0DzC947Qol5k13XrD/z2IzBet+D9+guhT0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DtKM394VHgLaJiv0ciab4wG7ErtvZTD/jIKlWFA1aiAUlJleeecN8T6uXJ7mVUKec
	 5irNs7jnPXezyjnSZ+Txr8qyE6f6BBkUG+KQYm9dtQRlUvg4HKczFOtnlFTD5mfXc1
	 N62visHO7U9l9zCavOMHGNoKMAua1O7fIkIFjscMT8aQN2ZccnuvFLV/nKAI8LH4et
	 rISYfOfsjT/gP261hknrGY3HXUiZ86xYo3T3Jv74lnreBJmbBS7jggXC00S5HDqjdq
	 aFKR7+F/4H0FvfUafL3YhPWk4Zy18f9aGQo6aJTvbZ7DmXN6f1z5VTAq/obzYHkXT3
	 SIITYn+LjAXyg==
Date: Wed, 05 Mar 2025 10:47:19 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/22] rust: pin-init: move the default error behavior of `try_[pin_]init`
Message-ID: <D889TYXZRPX1.5WNAFLTJSKKW@proton.me>
In-Reply-To: <87r03bepo1.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <1iRthWaE9p56aGqyNzaY-vh27mX2Tp1thOYCi8oBj6Qn6m6TxlSh-5-Ic4noCVTjVSXzw6GcviNXRtXbg6aw6A==@protonmail.internalid> <20250304225245.2033120-8-benno.lossin@proton.me> <87r03bepo1.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ec7f3853d1d8b6b6efb391fd7bf07ffb44e2a37d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 11:29 AM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> Move the ability to just write `try_pin_init!(Foo { a <- a_init })`
>> (note the missing `? Error` at the end) into the kernel crate.
>> Remove this notation from the pin-init crate, since the default when no
>> error is specified is the kernel-internal `Error` type. Instead add two
>> macros in the kernel crate that serve this default and are used instead
>> of the ones from `pin-init`.
>>
>> This is done, because the `Error` type that is used as the default is
>> from the kernel crate and it thus prevents making the pin-init crate
>> standalone.
>>
>> In order to not cause a build error due to a name overlap, the macros in
>> the pin-init crate are renamed, but this change is reverted in a future
>> commit when it is a standalone crate.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>
> [...]
>
>> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
>> index dde2e0649790..4123d478c351 100644
>> --- a/rust/kernel/prelude.rs
>> +++ b/rust/kernel/prelude.rs
>> @@ -28,7 +28,8 @@
>>  pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_i=
nfo, dev_notice, dev_warn};
>>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info,=
 pr_notice, pr_warn};
>>
>> -pub use super::{init, pin_init, try_init, try_pin_init};
>> +pub use super::{init, pin_init};
>> +pub use super::{try_init, try_pin_init};
>
> Are you trying out a new scheme here - a balance between normalized and
> line-by-line use declarations? =F0=9F=98=86

Uh no, not intentionally at least. This is an artifact of moving the
changes between the different patches, the "rust: make pin-init its own
crate" commit removes the line with `init` and `pin_init`, but keeps the
one with the `try_` versions. That is because those two will continue to
live in the `kernel` crate.

---
Cheers,
Benno


