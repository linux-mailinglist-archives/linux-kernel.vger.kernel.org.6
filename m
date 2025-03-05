Return-Path: <linux-kernel+bounces-546718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE0A4FDFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B8A7A270B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB741241693;
	Wed,  5 Mar 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aDawgHa6"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BAB23372A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175358; cv=none; b=W7jX5hhDDMMWux8/fGBFqUomfMxaQmSCm+jZ46eQzM+EuknUNRFLx1PubKKaOJLj80wnwc/y7Hc5EXLUXb6/qDfflaLDMX1KRG8naRaQbrMeV8UHR6F/4xpTP7I5zFXaE7UwEi0duFrCxkNiE3AE/saVTx8HQZwGhhhRWataFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175358; c=relaxed/simple;
	bh=mhj8Z2ha2cKG6o/32m4SY524AF6OiflHFozoqQeW8lc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIZL8akQ5+O0JoTa6b/KbBTQh4Wys21qYM4LnlNBfXqdNOW+EgGTANxC7cGfT7kfh+YK+ZQxpu9cHPhokY7GOjQvh28xZg1sdkgRa/Hk6YWMy7IemwbfhXtRku3FSj6YEKMjVvitW/umORLVjvDa4nnjxnwyp27w80U1WsYEcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aDawgHa6; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741175353; x=1741434553;
	bh=wo3McCt822WJDFOtfBkdir2juCuCd/bcXFtTS2mK67c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aDawgHa6npFcy6uy7jy9rOQ6VmsYQFBGm6lAoW/9QA59kT7efjM2L7d5p4mz83YRH
	 Giy/5dzvuWncskS8U7QtrG7g/u9kwK48VzsBhXEBZUshzIkmMhTwFEkBI6iF10MLUn
	 1xDxcWd71Qap3JMTdE6cvks5iyo097NxbzeKkz/iCCYNVGfOFYgGph6MYAhcHwOJn5
	 UsXDptOSol9n2cZJ9746c5wtlZmNwxDON1R7ZimqfVzO/KSGuOAGXJTNfa4Z5TPTu1
	 6zbcHSX/pz68uTYkYgdDUT2MiYcU43CWT0hU54KEsirZLFdgjDjHOsQq2EWM+qJJsO
	 JNISH/MCt7LAQ==
Date: Wed, 05 Mar 2025 11:49:07 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/22] rust: pin-init: fix documentation links
Message-ID: <D88B5A6UFZRN.21G1VKE4ZXMDA@proton.me>
In-Reply-To: <87y0xjd7y1.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <ya83goUtzcHjLy0IcSqvzACQD0E8Vn3F-w29yUE8jareggYjn0MS8ppl7uT1una8iXgpyTMDiG48RlSzZLTr-w==@protonmail.internalid> <20250304225245.2033120-12-benno.lossin@proton.me> <87y0xjd7y1.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b2c20968cd7f4c2bbe50f205d3a1d1616d4cada9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 12:37 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> Before switching to compile the `pin-init` crate directly, change
>> any links that would be invalid to links that are valid both before and
>> after the switch.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>  rust/kernel/sync/condvar.rs     |  2 +-
>>  rust/pin-init/src/__internal.rs |  4 ++--
>>  rust/pin-init/src/lib.rs        | 19 +++++++++++--------
>>  3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
>> index 7df565038d7d..5aa7fa7c7002 100644
>> --- a/rust/kernel/sync/condvar.rs
>> +++ b/rust/kernel/sync/condvar.rs
>
> [...]
>
>> @@ -204,7 +204,8 @@
>>  //! [structurally pinned fields]:
>>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structu=
ral-for-field
>>  //! [stack]: crate::stack_pin_init
>> -//! [`Arc<T>`]: crate::sync::Arc
>> +//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
>> +//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>>  //! [`impl PinInit<Foo>`]: PinInit
>>  //! [`impl PinInit<T, E>`]: PinInit
>>  //! [`impl Init<T, E>`]: Init
>
> Won't this diff from the user space implementation?

It's only an intermediate state, it will be changed again in "rust:
pin-init: add `std` and `alloc` support from the user-space version".

---
Cheers,
Benno


