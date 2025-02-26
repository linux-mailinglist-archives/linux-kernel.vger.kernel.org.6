Return-Path: <linux-kernel+bounces-533332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD0A4588A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A73C1725A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BD1E1DF9;
	Wed, 26 Feb 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlANETbM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A801A9B34
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559149; cv=none; b=b/995hhv5z6Pp7EnNDLJevKDTYNqdF6G1nF/to1UvU7Pf9PUA853B6K3I8kUZi0um7baB1XPI51auKkfSTRyfjUIJaUXT9LTfWsSBNvnKQeQB8vWWFFXqvJHz2gz9lfEyvS++ldwm/Qp7VQCDfXgRRjkOvMnD2KUU5MTxIWJRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559149; c=relaxed/simple;
	bh=R7o25Gmhow4Z8lEDeZaJUPCmJA/D+pLPP+WdRXbdRN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Ev2HGZTWPlaNVgvvXVgwX7q1zb6Nw7xecWYcub15qk73+A0Rf1APfN5XpKwwRNItTNP4JDe+hqBgV0GJ2mt2w8qzrVw8EID/W67wUxcDQ0iMmzoA2NC3ZVFegkUEDcLqq+bYdNeldKQUYLKuV/Z2I8WumkHh7JfC6vHOeafYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlANETbM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so3711882f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740559146; x=1741163946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v1HmoRqjrqqsg5xrU75YJMSiVDiFQ/P7qFYUH2blA8=;
        b=VlANETbMkSaDtEM3N95AgVM9uHXm/o0F69qs3J9SVEEFd62/r8U4QfEjtmyYOM/LwG
         MIPYc+9467z6t1Trim5VYAcLNp5ZgZXKnuCa5ACfzOg6nf8LGy7SDVo6L6ayp6+Nr8Pl
         QB7PhLf+sP8A/Yc4XZ+Cz2pUfY8JwgZLTl1TEskCYQOOp91VIfdBcEcgJnLJ+6wrb/sf
         j1RzEazWapnSXKEkcokcyXAOzwMz73hGUEYcLoeYblwR36z5K/lqkGSR860cIf+kxbyM
         ckK0AvQwf6Bsbo5lDrYqGbGg2308KfEfp+1SXK3B7QleLV/lZmf1YlulTMxhKzxHqyvz
         cuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740559146; x=1741163946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v1HmoRqjrqqsg5xrU75YJMSiVDiFQ/P7qFYUH2blA8=;
        b=To9QSkTuQmFHOHbMm/6p/clRc79iaMwUwu1P8sycU2GXAvJkt9qLeOqsK1qQzdKdSU
         IahnpvzhMY9bRG2DVIX/ILeIXtgOY0ntkY7RJf4d30dHK9FsWDQMzTf14tWtgC5gTBcS
         u6jcT+c+PFAgkoIrtbqty3BlaDggLDnKthW/fjmeVOT3HcodinRXB23BPZbESapb0fRX
         OmIbT2U0Q6vsDAwZHFpCy7ZtXLZqgwTh9wSHACULNlG9jEzA02Ux6XEEOyTemWT5JvUY
         ZENYH/wqV/kdhrC511beHlp30Am3U6RkCEUS0iEx0OvxNvVaNOAf+krh3/JBzmWsTse1
         /u9g==
X-Forwarded-Encrypted: i=1; AJvYcCVIeUSvwiI1JMRNMiQ6arvmrxTE54hLbJFeg97hDcA+nSUOr08iWAWoPCxopEV+KjBYt7EfIbS1a0907EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08HTS1XKC9NKCrmdOMrlxJEp0g2gvPy4Aww3FbwcFRcu+KBgs
	OTnYvfer28vfJSjV1u6vgPKDJjNzd9qSyReRhtDeSkoaBgi6ioqVCjFPiGfzDqzS+E8uaKXwbTY
	Un8fmi5eY36/7S91kEA52lshwddN2EWSwkEqI
X-Gm-Gg: ASbGncsgF85C/PDSU2AiYInqjWB9Uapvc/9BLADZCwTsYfMoTVtBSc3sJ+JuksC7byG
	SiTTFlbY9iR72lAbL/RZSOe8c20njn8vvlrt88ErEGsPGBNCSfqm4dbxhT1/nSTf4OKDFVaIzYe
	2vygNsUtPLIt/U55i5ZYGw9svKpzwZREE6R6G82g==
X-Google-Smtp-Source: AGHT+IFWtgwikgZyNRQh/bt3EkyBmLyTlQQvW2Pbzy/KXQM5t1igagm8AQOFPeLD62G1j7aoeerCLVV1JYNFoG7dFBM=
X-Received: by 2002:a05:6000:18a6:b0:38f:2678:d790 with SMTP id
 ffacd0b85a97d-390d4f43039mr1702221f8f.33.1740559144919; Wed, 26 Feb 2025
 00:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213112.872264-1-lyude@redhat.com> <20250225213112.872264-3-lyude@redhat.com>
In-Reply-To: <20250225213112.872264-3-lyude@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 26 Feb 2025 09:38:51 +0100
X-Gm-Features: AQ5f1JpVJkDPdU7KsO2IK1L8WWCkkhoNT3HcxpZZ2FpHX-G-e_JTJoIZFjJ49fg
Message-ID: <CAH5fLghwkK4S12eMUm3bgMXvYMNf_1Gi9ws9q-53OZPdB+QHQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to Registration::new()
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:31=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> A little late in the review of the faux device interface, we added the
> ability to specify a parent device when creating new faux devices - but
> this never got ported over to the rust bindings. So, let's add the missin=
g
> argument now so we don't have to convert other users later down the line.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  rust/kernel/faux.rs              | 10 ++++++++--
>  samples/rust/rust_driver_faux.rs |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 41751403cd868..ae99ea3d114ef 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs
> @@ -23,11 +23,17 @@
>
>  impl Registration {
>      /// Create and register a new faux device with the given name.
> -    pub fn new(name: &CStr) -> Result<Self> {
> +    pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<S=
elf> {
>          // SAFETY:
>          // - `name` is copied by this function into its own storage
>          // - `faux_ops` is safe to leave NULL according to the C API
> -        let dev =3D unsafe { bindings::faux_device_create(name.as_char_p=
tr(), null_mut(), null()) };
> +        let dev =3D unsafe {
> +            bindings::faux_device_create(
> +                name.as_char_ptr(),
> +                parent.map_or(null_mut(), |p| p.as_raw()),
> +                null(),

This function signature only requires that `parent` is valid for the
duration of this call to `new`, but `faux_device_create` stashes a
pointer without touching the refcount. How do you ensure that the
`parent` pointer does not become dangling?

Alice

