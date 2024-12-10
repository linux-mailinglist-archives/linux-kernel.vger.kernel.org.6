Return-Path: <linux-kernel+bounces-438603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E29EA35D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C686E282A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D022566;
	Tue, 10 Dec 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnSvDcoH"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423410E5;
	Tue, 10 Dec 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789375; cv=none; b=LKNJxnMir/ImvOrASYq8vgKzJudsGm7SfZKPpdrQd3paw566U8S8SforsgZTVrYoGF8DSGl+Pbj4Z81hznkbEtIUm4GQRla/pNBc7WspzcD1thZAdwvWvCF77e/N3zTe1CpQrc5q5/HFGz0v9143ZA5DwTl7mHjojwGnkVlloqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789375; c=relaxed/simple;
	bh=RCOVJWgFhXT6DmylXTsI1S6NIDyGF9sD4+HqK8vNzXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBQIecx2On42vrwj+oZI5KQVPNw5C1bwS6cVLuP/N939UboZFKaFH2B1L4fxTw7kX7gbeuZp8J15RAhiKGLpB81jg2sq0CeVZV2crq5Ffc4rRolbLESPQAfYU5ptSsaZ0FZ/jkIS8JiHMWa5Vk2bRVXh3ErrARB1GWkeGQ6GVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnSvDcoH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso869764a91.3;
        Mon, 09 Dec 2024 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789370; x=1734394170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqf9Pw5ygFqNWLQdG8eH/zSqStheh4qMrd/FdN0cEGA=;
        b=AnSvDcoHo6Zqc4tPIJLzPyFHDLH9R/n8npwXiWjpM/lK2ujYEvYMuXVrUSva6kG3tl
         tClhpbjJz6ugBysxMAzvJ3KlL8GpUYCM3GINbHD1hBMDLP+M3pI5nD+uXKMd0vCtjFcO
         eK+KEs0XuAm/BTRDJ34DSYoVaGz0gI8+0tZRxlcKvUZvpGtn0DRT+KMhDgmUkAVQXm1z
         8q78+3B4O/9qw88RKTb4th29YPGPvSbHIy+t7Vbfn4B3/MWxRO1zx6zO46/qAAzgQqd9
         RMoU0gboOe3Ze8kEvJyBdebDBLqvrEHZOZmtvPNxffNdtse9zRpW84LK7uYHPx9+pBVN
         Zy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789370; x=1734394170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqf9Pw5ygFqNWLQdG8eH/zSqStheh4qMrd/FdN0cEGA=;
        b=UFoXeg04YhbM/X6aR6nz7O1tn+CTgv7AD3woi9XQK3/HxxajeFLV+O+kLo6kIUkGEl
         J9GTYHm5x0e9gym+zl4JVSo/KAUL2nUo6PYbHkYxKCb8CUQznaNn3PczRGQrCgkl8j3n
         xRN7WQ05iJ9lLN11XvLrBwKVWRXR19BCqRqlTiL9zvgbnawHymAG7Z1cVJw7nArQst+v
         6uNv0csNyUmN//IsHZ8SiTzYE9Hpcs7nZi0XO10fhFyUAD4vHIllQr2lzweFIbmfsXXQ
         ZnT8qpqvujxDgQS/FrkKqNiRitX6HnpNHtDTG5WHUuC7+lV8opiI8OqsNFM/Reaxhh2f
         p3ng==
X-Forwarded-Encrypted: i=1; AJvYcCVlqo5djkdg2JhvrM/NofWHs0Wy4ykJxAJcAu5DmSabPZk5eIEL3nS2jEUU2JLrdd2klkXOXjmsWmB9in7QNv0=@vger.kernel.org, AJvYcCVvk5faDX8lNGxZbXWhCWQWiaoUbTAJg4XbKQhxSnMhezjavZ4rmwdiDwS1GILkMRvUpcedToKeOk3WrF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg15pt0/rq62lBAZByAPAaDT7eNrAaEQ2UgY5c0c5nmjSxUqkR
	nMh6gmDJVQzRazlTrFR9tTaeZGaYx9AcudN0uCqZsdHh8zHd4zztbn+LY4YJDXhqRKkea1pHvGT
	cpLXlZKgjgvqvgi024ZlUCYcauuFBQJDnKDg=
X-Gm-Gg: ASbGnctVCGPaP+CZT9Q2jSEObRwoE/V2YyUF50rwwBYa4+np1ueaDHpL1q+/JQ+uvma
	pBADmPTkKLHiLlwBy/pMRzcA37NAzdHJ4E/o=
X-Google-Smtp-Source: AGHT+IH0533Z0lG1cmsFMSYTQgHR047SqSc1dGT+SjioNScy/dOIbt6nmvrmg4TjnlVulh/A/8MXVpm+7Nk8kFeG7Q8=
X-Received: by 2002:a17:90b:1b42:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2efd454dfb2mr887964a91.0.1733789369748; Mon, 09 Dec 2024
 16:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org>
In-Reply-To: <20241123180323.255997-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 01:09:17 +0100
Message-ID: <CANiq72kTX5o2rs=A51keKQiV=6fT0sN+FjWygL4=ddytnNM8Cg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 7:03=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Each `bindgen` release may upgrade the list of Rust targets. For instance=
,
> currently, in their master branch [1], the latest ones are:
>
>     Nightly =3D> {
>         vectorcall_abi: #124485,
>         ptr_metadata: #81513,
>         layout_for_ptr: #69835,
>     },
>     Stable_1_77(77) =3D> { offset_of: #106655 },
>     Stable_1_73(73) =3D> { thiscall_abi: #42202 },
>     Stable_1_71(71) =3D> { c_unwind_abi: #106075 },
>     Stable_1_68(68) =3D> { abi_efiapi: #105795 },
>
> By default, the highest stable release in their list is used, and users
> are expected to set one if they need to support older Rust versions
> (e.g. see [2]).
>
> Thus, over time, new Rust features are used by default, and at some
> point, it is likely that `bindgen` will emit Rust code that requires a
> Rust version higher than our minimum (or perhaps enabling an unstable
> feature). Currently, there is no problem because the maximum they have,
> as seen above, is Rust 1.77.0, and our current minimum is Rust 1.78.0.
>
> Therefore, set a Rust target explicitly now to prevent going forward in
> time too much and thus getting potential build failures at some point.
>
> Since we also support a minimum `bindgen` version, and since `bindgen`
> does not support passing unknown Rust target versions, we need to use
> the list of our minimum `bindgen` version, rather than the latest. So,
> since `bindgen` 0.65.1 had this list [3], we need to use Rust 1.68.0:
>
>     /// Rust stable 1.64
>     ///  * `core_ffi_c` ([Tracking issue](https://github.com/rust-lang/ru=
st/issues/94501))
>     =3D> Stable_1_64 =3D> 1.64;
>     /// Rust stable 1.68
>     ///  * `abi_efiapi` calling convention ([Tracking issue](https://gith=
ub.com/rust-lang/rust/issues/65815))
>     =3D> Stable_1_68 =3D> 1.68;
>     /// Nightly rust
>     ///  * `thiscall` calling convention ([Tracking issue](https://github=
.com/rust-lang/rust/issues/42202))
>     ///  * `vectorcall` calling convention (no tracking issue)
>     ///  * `c_unwind` calling convention ([Tracking issue](https://github=
.com/rust-lang/rust/issues/74990))
>     =3D> Nightly =3D> nightly;
>
>     ...
>
>     /// Latest stable release of Rust
>     pub const LATEST_STABLE_RUST: RustTarget =3D RustTarget::Stable_1_68;
>
> Thus add the `--rust-target 1.68` parameter. Add a comment as well
> explaining this.
>
> An alternative would be to use the currently running (i.e. actual) `rustc=
`
> and `bindgen` versions to pick a "better" Rust target version. However,
> that would introduce more moving parts depending on the user setup and
> is also more complex to implement.
>
> Cc: Christian Poveda <git@pvdrz.com>
> Cc: Emilio Cobos =C3=81lvarez <emilio@crisal.io>
> Link: https://github.com/rust-lang/rust-bindgen/blob/21c60f473f4e824d4aa9=
b2b508056320d474b110/bindgen/features.rs#L97-L105 [1]
> Link: https://github.com/rust-lang/rust-bindgen/issues/2960 [2]
> Link: https://github.com/rust-lang/rust-bindgen/blob/7d243056d335fdc4537f=
7bca73c06d01aae24ddc/bindgen/features.rs#L131-L150 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

I added the following note to the commit message and added a small
sentence to the comment too:

    Starting with `bindgen` 0.71.0 [4], we will be able to set any future
    Rust version instead, i.e. we will be able to set here our minimum
    supported Rust version. Christian implemented it [5] after seeing this
    patch. Thanks!

I also queued it for stable:

    Cc: stable@vger.kernel.org # needed for 6.12.y; unneeded for
6.6.y; do not apply to 6.1.y
    Fixes: c844fa64a2d4 ("rust: start supporting several `bindgen` versions=
")

Cheers,
Miguel

