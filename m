Return-Path: <linux-kernel+bounces-546743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7EAA4FE3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20EA3AC4B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC2242921;
	Wed,  5 Mar 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Q9OU43aQ"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD81FDA73;
	Wed,  5 Mar 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176421; cv=none; b=FXVUYwwtqMJKeucWHim5a/d0Lqu7OIFJOqyjxI0AffRjJl2CxEcc+VoVG0KIYJrcK1+KwRZysJNvAb6Ok9IINIAw6CCRM7I8U51sg4s+l4y+GBXmAi9dB0ojr+rfk5dqqqtOl4pEltUW87YWk/gKp7O5ZILcz5vlojdKg4pH2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176421; c=relaxed/simple;
	bh=bSSVXwluCJzguHo/ODK8V5qH3HyhdDDfiyzxgjtisfs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQDd3SIedYuRI7yVyTZUsLgx0ZDvUuxLem3gRgHBajYNfOnzh9qgAx5jbFLfzV64lg3UIq5IVm4IDMLFioUTuVDEK4b7xaCmB47H3nl8WnZ3VEN9F9rmNAImjdeDsfgZQxGfYb98jNV/LqPVfGyX9vGAwaHWN4zTS1I2yJ76rCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Q9OU43aQ; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741176417; x=1741435617;
	bh=B6e2JFsls5JpJUoGWT/EGmKlFKjBtGKPMSMZZtwVs/I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Q9OU43aQfn9Sha8In3cltjmrlWGb9CI/IELU+VX/1U0b7CNxg+QJoVBSeXclcYJ4M
	 bmJ/A2lCl6+4YnHQtfDPkQv8XtyYzNAgEeV+2cCqhPS1pUAlGS8GNsqTaxzczMFozn
	 iOvlA9C5Mb4pwYNYB1rO2jHJ7OryyzLiUEstgurZQyX/Sx+mCrY81NLy/xBloN1ZCZ
	 s22Sunnuvc0/21GusgkBzJosA8ppqEFyXCcJ+CkwKRl4WmxU0J71JTFPnT3oIz+mmL
	 wOAb8keHkEpIhEE0Bn4xCCPubmU9qghojIe1uvSo4j7zqlwnnJyCNK4T7YjQjOyC4l
	 w+/YcaEDAYuaQ==
Date: Wed, 05 Mar 2025 12:06:52 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/22] rust: pin-init: move `InPlaceInit` and impls of `InPlaceWrite` into the kernel crate
Message-ID: <D88BIUUNXQK5.3BFLFUBWAS0H2@proton.me>
In-Reply-To: <87frjrene8.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <iamkKusKoPQ37SKTEy2SbZjH0szdD4f3Zss6AcRF5jAkltpuR9blYqQ3Qc0Vd_gJBwPbefblnClu4okTA-TLLg==@protonmail.internalid> <20250304225245.2033120-9-benno.lossin@proton.me> <87frjrene8.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3ae8d68ada7eefc83a34344572586b955187c88e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 12:18 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> In order to make pin-init a standalone crate, move kernel-specific code
>> directly into the kernel crate. This includes the `InPlaceInit<T>`
>> trait, its implementations and the implementations of `InPlaceWrite` for
>> `Arc` and `UniqueArc`. All of these use the kernel's error type which
>> will become unavailable in pin-init.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>  rust/kernel/alloc/kbox.rs |   3 +-
>>  rust/kernel/init.rs       |  55 +++++++++++++++++
>>  rust/kernel/prelude.rs    |   3 +-
>>  rust/kernel/sync/arc.rs   |  65 +++++++++++++++++++-
>>  rust/pin-init/src/lib.rs  | 125 ++------------------------------------
>>  5 files changed, 127 insertions(+), 124 deletions(-)
>>
>
> [...]
>
>> --- a/rust/pin-init/src/lib.rs
>> +++ b/rust/pin-init/src/lib.rs
>> @@ -10,7 +10,7 @@
>>  //! To initialize a `struct` with an in-place constructor you will need=
 two things:
>>  //! - an in-place constructor,
>>  //! - a memory location that can hold your `struct` (this can be the [s=
tack], an [`Arc<T>`],
>> -//!   [`UniqueArc<T>`], [`KBox<T>`] or any other smart pointer that imp=
lements [`InPlaceInit`]).
>> +//!   [`KBox<T>`] or any other smart pointer that supports this library=
).
>
> Would you not want to remove references to `KBox` here as well? Even
> though you don't have to move the impl, I don't imagine `KBox` exist in
> user space?

Yes, this is done in "rust: pin-init: fix documentation links".

---
Cheers,
Benno


