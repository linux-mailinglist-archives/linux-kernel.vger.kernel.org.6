Return-Path: <linux-kernel+bounces-519917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586EAA3A38A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1557F188DF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55AD26FA5D;
	Tue, 18 Feb 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpw62KuX"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FB26AABB;
	Tue, 18 Feb 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898362; cv=none; b=Iz5I6uwA6glaqL7DwZoADsslx0QzLNjm9o8qzP8zVT8Vcs1a6L8BVXUoMtbKkh/RxPlikKaaf1O61ICZ24xJfj0D5U60Q9bR/CwXmlZSICMFbp03eqE8/Lz85lNlYkcn/XG/faJlEXy+xuTt8b7utvoKBwYMkpvcdaaPOrRBRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898362; c=relaxed/simple;
	bh=cUlvvmrwF4H0ym9aoy5nnIcqVPpPja/npHfGfHeGIl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IVV+tURyy6k5seEA8tweYqnYojLZWSvWUpjKo7TefybC4vQVLZQ2Y9v9cDXB45eOEmpr3acdpmK7lJ4gLoYRSMpYY7bE7lC3/DlPE90D8hgQ+T2MUVYTk7mm9/fIhJgNRQPD5mF7We3i3BhPCHv3GmJVoRCITkeoGYvED05TKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpw62KuX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622e97753so2123522e87.0;
        Tue, 18 Feb 2025 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898358; x=1740503158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaBOmQ+02lo2m6NXiSCLJsCyMfO8viI6QPD01HQRtOo=;
        b=Jpw62KuXFnp1k8lvG5ONIqQd1goeDaKaEiApg1O9z7V1B05HzA2icuQZKtRq/84xy8
         7gfSxKtAlliac6g/OuZZYeSIsf9KozJP1KMqmok05VJI4QKxYqzsShYGJSn2HelK62lI
         e29eupp2QmRTfLmiWo2BGk+EBYjSQSwiyLQj2wNHggv+6ncl9WB06UA9iDCsRZFmN6dJ
         +ak/fyQFfMTicgFQRyv/yUqKbP1YJHE2y0xy/8uAPkBmsoX6QE9DE75VNVO3/EjatYck
         736ofUTGQIoB55Pvzzqv9iSRPZN03LE+/+5ypbi1IhPBxSQWer10MUvHmBcMcWYAkWE/
         tp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898358; x=1740503158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaBOmQ+02lo2m6NXiSCLJsCyMfO8viI6QPD01HQRtOo=;
        b=Em5awbYzwzZVhKYpAKuZr1f7IWPqaO167YjGT0R1+WrbwchPdr1QhQwJk/NfH5GXGQ
         BpRJ9ITb9uFnMexxg0r2PH2rWSt7HifysEqpBTmtCgrNLDSJe2MSQnDQ0+WWwbTGAjsf
         VytRlwXXjIy1gNQniyu9AkBQc+2zBuIkfRJyIFVDpg8I1lp284myrBRVBIj40CXLkhcI
         A295Q19ygoAzUHr1jDCVQQDSiV6XhbjVq0k8Wg85WOpE+EI14oF3vzKMc5FaTOGMN4NN
         9C6pYYxv4CEodc/oziGvfiDQUDRr38jF1jwV65nyJdd/kwChbFzuq7klYpSS83DhATNB
         cdwA==
X-Forwarded-Encrypted: i=1; AJvYcCWgjQXqx8cFN2mVdu92KZNaodz0iOk7GB4jrEWh++zWSNWflwDKCidjzZy4z7GEk52BylrIntpfy7Op3GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPVNiKq7Ni8GO8bioq0ifWt4+CMdU7fflm07ep6jfCcyfuoEc
	ZeO2gF74LAwLg/9a6XvLo/SwsJmIk+Gl1HHBXIbLunW3nN16wCZ3Yf1vZMc46Cg4uR2iVuM50Ux
	AHtfCwIGzynnSb0vil5G3Js1ELeU=
X-Gm-Gg: ASbGncs0I5tnuVushT5qxJLWCc1uo1RbzPRHvY9rL/fdzDMgna0ISdnX5iJS3hBEjZa
	KPzW4cNpEsuW8mCd1Fio3nQNlv3epJaX/NiW5QzFjfPutZgQHTIqMhUR9xcQJrhJMrfVGGpe0Gk
	/jrs5K3D+PEWHeKTAAXgI1O4M2wxhlAyM=
X-Google-Smtp-Source: AGHT+IEZPA1oIQxJl/U/+BIVFLfErOpTGAUFlDJp13DnXmUF0no6z9hjkTjq56G3zm5UWqup3oO5fEhDL3YRX8ZvYys=
X-Received: by 2002:a05:6512:31c9:b0:545:2bc5:e27f with SMTP id
 2adb3069b0e04-5462eaaf2b6mr227916e87.12.1739898357589; Tue, 18 Feb 2025
 09:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
In-Reply-To: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Feb 2025 12:05:21 -0500
X-Gm-Features: AWEUYZkbo8k9BWS_OJgSCDZ3Qr2Ld0QrNfzFP6kLMjMwCnlJ3hn6Bq9r2ROdeG4
Message-ID: <CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping. Trevor, Alice, Benno: you all participated in the last
round of review - I'd appreciate it if you could take a look at this
series.

Cheers.
Tamir

On Mon, Feb 3, 2025 at 6:50=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
>
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vador=
ovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Changes in v8:
> - Move `{from,as}_char_ptr` back to `CStrExt`. This reduces the diff
>   some.
> - Restore `from_bytes_with_nul_unchecked_mut`, `to_cstring`.
> - Link to v7: https://lore.kernel.org/r/20250202-cstr-core-v7-0-da1802520=
438@gmail.com
>
> Changes in v7:
> - Rebased on mainline.
> - Restore functionality added in commit a321f3ad0a5d ("rust: str: add
>   {make,to}_{upper,lower}case() to CString").
> - Used `diff.algorithm patience` to improve diff readability.
> - Link to v6: https://lore.kernel.org/r/20250202-cstr-core-v6-0-8469cd6d2=
9fd@gmail.com
>
> Changes in v6:
> - Split the work into several commits for ease of review.
> - Restore `{from,as}_char_ptr` to allow building on ARM (see commit
>   message).
> - Add `CStrExt` to `kernel::prelude`. (Alice Ryhl)
> - Remove `CStrExt::from_bytes_with_nul_unchecked_mut` and restore
>   `DerefMut for CString`. (Alice Ryhl)
> - Rename and hide `kernel::c_str!` to encourage use of C-String
>   literals.
> - Drop implementation and invocation changes in kunit.rs. (Trevor Gross)
> - Drop docs on `Display` impl. (Trevor Gross)
> - Rewrite docs in the style of the standard library.
> - Restore the `test_cstr_debug` unit tests to demonstrate that the
>   implementation has changed.
>
> Changes in v5:
> - Keep the `test_cstr_display*` unit tests.
>
> Changes in v4:
> - Provide the `CStrExt` trait with `display()` method, which returns a
>    `CStrDisplay` wrapper with `Display` implementation. This addresses
>    the lack of `Display` implementation for `core::ffi::CStr`.
> - Provide `from_bytes_with_nul_unchecked_mut()` method in `CStrExt`,
>    which might be useful and is going to prevent manual, unsafe casts.
> - Fix a typo (s/preffered/prefered/).
>
> Changes in v3:
> - Fix the commit message.
> - Remove redundant braces in `use`, when only one item is imported.
>
> Changes in v2:
> - Do not remove `c_str` macro. While it's preferred to use C-string
>    literals, there are two cases where `c_str` is helpful:
>    - When working with macros, which already return a Rust string literal
>      (e.g. `stringify!`).
>    - When building macros, where we want to take a Rust string literal as=
 an
>      argument (for caller's convenience), but still use it as a C-string
>      internally.
> - Use Rust literals as arguments in macros (`new_mutex`, `new_condvar`,
>    `new_mutex`). Use the `c_str` macro to convert these literals to C-str=
ing
>    literals.
> - Use `c_str` in kunit.rs for converting the output of `stringify!` to a
>    `CStr`.
> - Remove `DerefMut` implementation for `CString`.
>
> ---
> Tamir Duberstein (4):
>       rust: move BStr,CStr Display impls behind method
>       rust: replace `CStr` with `core::ffi::CStr`
>       rust: replace `kernel::c_str!` with C-Strings
>       rust: remove core::ffi::CStr reexport
>
>  drivers/net/phy/ax88796b_rust.rs     |   7 +-
>  drivers/net/phy/qt2025.rs            |   5 +-
>  rust/kernel/device.rs                |   7 +-
>  rust/kernel/devres.rs                |   2 +-
>  rust/kernel/driver.rs                |   4 +-
>  rust/kernel/error.rs                 |  10 +-
>  rust/kernel/firmware.rs              |   7 +-
>  rust/kernel/kunit.rs                 |  18 +-
>  rust/kernel/lib.rs                   |   2 +-
>  rust/kernel/miscdevice.rs            |   5 +-
>  rust/kernel/net/phy.rs               |   8 +-
>  rust/kernel/of.rs                    |   5 +-
>  rust/kernel/pci.rs                   |   3 +-
>  rust/kernel/platform.rs              |   7 +-
>  rust/kernel/prelude.rs               |   2 +-
>  rust/kernel/seq_file.rs              |   4 +-
>  rust/kernel/str.rs                   | 542 +++++++++++++----------------=
------
>  rust/kernel/sync.rs                  |   4 +-
>  rust/kernel/sync/condvar.rs          |   3 +-
>  rust/kernel/sync/lock.rs             |   4 +-
>  rust/kernel/sync/lock/global.rs      |   6 +-
>  rust/kernel/sync/poll.rs             |   1 +
>  rust/kernel/workqueue.rs             |   1 +
>  rust/macros/module.rs                |   2 +-
>  samples/rust/rust_driver_pci.rs      |   4 +-
>  samples/rust/rust_driver_platform.rs |   4 +-
>  samples/rust/rust_misc_device.rs     |   3 +-
>  27 files changed, 268 insertions(+), 402 deletions(-)
> ---
> base-commit: 8b3f2116ea4a9521f852b7f9d1d6dd4d7ad86810
> change-id: 20250201-cstr-core-d4b9b69120cf
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

