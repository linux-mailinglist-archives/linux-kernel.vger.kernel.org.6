Return-Path: <linux-kernel+bounces-553373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C610EA5883E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E093F16B190
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4824621A45A;
	Sun,  9 Mar 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cylriMDo"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76218C011;
	Sun,  9 Mar 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553269; cv=none; b=mIIfZ7o8tUB6r7l1A0Sw+q2c/Y8hR6uss3scijrTbRKIqgnruCAMm0n6hA88eFhCt4Fgb/JB5Nq1zHs+hLjp3MD7I8Aa09+jNEStEbC2sq/wf908GBCOrpX2TEOnvy5wj1hCoybTJ6L8XstqlFf9r24N8w//QvfEu/yksrCSK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553269; c=relaxed/simple;
	bh=IIdeN1kpFUETW+hkKD26O5zuLSVodU5nvIQlOtSKnJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RttEumjKWjOgC+29E+fOrWFlO+/6jatfDxICSwE9By1I439ti+QzgarmzL/U/TtAtOA/SeNYcNILq1nDb+IpBvEeCbPuLpbwuYgJH6fiXFgLDD3pt21eNgKIBjDwu7U4jw0ZrDES9M4RP2fp6EpbuAkP3e4HWSr9SaczfiWyrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cylriMDo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff7cf59a8fso757308a91.3;
        Sun, 09 Mar 2025 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741553267; x=1742158067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K44Z7DuR2sJPBt/x+nc+HSqeieqPDVCAVsmBItqywyE=;
        b=cylriMDo4X2BI4ndZmdZ+1xjK/bdwxDo71O/BKCLkbbbZC++nakGSR7IP+UyL4OYif
         mWMg2Ta0Pg38xUiRTfPPoV/6Bamxq9HIek4LPpDcQNhl3Ao0nrgYLg0sUrUZ0RhmEwGX
         sbl6X+ese3QMBgKgjZYPGZGLje664f22ItXNV6Z/KUcMlFrbnHW7U6v2XV/XKjsHXDPe
         7GDe1jiBmdnbFMMZ7aRte1UQbVBelsUVy3pNnz+QDwtxLo/x8E59gXvh7sIc+uoFqoHU
         v1nSs2v2M2mSbOJ8EJnOaU1SbKZAD404cdMDIFILUMnb/n2NzrUJWWRZrNjKaamc66Rz
         +oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741553267; x=1742158067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K44Z7DuR2sJPBt/x+nc+HSqeieqPDVCAVsmBItqywyE=;
        b=fXpicDkMD50zoctY1jBtlnREqvDz2sjh7eNEpeupy6gN6MXAnp/1+MU/NefWCt6kRL
         JbpiuUy4/+SsPNjfmhfCn+ZGQLOLSbjl554vCTb3dEwAo4V6GB6shgReMus81+NNmaef
         fyUUEK1hFRBVXHsea12FBoywnako+JnhURmGdQ7AFOKYgxWBrELAwWB5P9c3EfsS8F2R
         ss3Cq0jtgR1jgjuOPWdKWCfiN8BLbNPidUYaQzEiIlEihklUkQgwczQSqQ7fPmTki6fc
         Clx/axgli/rOs4E9fdJRpGVbY52P5+dyYSseA6DaWd3KikaiGeIL9FuzrTBje7BTM1m+
         GokA==
X-Forwarded-Encrypted: i=1; AJvYcCURmS7pr3RND8sZKSxLB3fKk42ZgR30Tp4KMNGGZO7z63XNvIUH7DHZIyEyDcgUZmAfBJPNH7ix7fo2eWY=@vger.kernel.org, AJvYcCWjfcEBFLi59PwYCyQjRC/1ZTQw/wDzmO5GAdASxvm5aAspUlN1hgCHIk/WXxo/SRnpcj+PHBEX98eMBQUmv2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkiqKTls3h2mQz+YuUXuMAbIC4jrl3aRgDiXCFyfiYNh6SVW3
	fBS3POEQqJuxX7ZsHSBi1COM13O+c6/2s5qAIIG2vFKiLDgMyCurZSXMPw+96E2ja19HojnYyzc
	MdpeQrjIApTEppY+AN+fDORHOFIM=
X-Gm-Gg: ASbGnct1ecKa5UtG1MG9Sm1UYt976T5/lIe6Decdg96Gc+jbpPkSoEP/C8hUYIgExSS
	wYuWB5AstU6VPOydYjDG5r9qEQw1ZSh/2LTEEbX9Om4CC74V0LgHsGAHe78b1lmYA32JaLgkHGB
	A1XoSVqrRQ/ggTW9UklgEUxE3d7g==
X-Google-Smtp-Source: AGHT+IE9m6d05Vs3kBPf9WYfP6L9f9fGtqqjKeiTF3mJO+jV/KfWSyEpQ19ctMp3X/RZ+Dum29WiMpFS6K4cpfS2gjk=
X-Received: by 2002:a17:90b:4c42:b0:2ff:78dd:2875 with SMTP id
 98e67ed59e1d1-300a57877a8mr3929049a91.5.1741553267456; Sun, 09 Mar 2025
 13:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 21:47:35 +0100
X-Gm-Features: AQ5f1Jr2HZqZdaFpyMuYK5NFXHysFVDHD5Dul0EsJZjAk3dtFTlU_uTpx7nkwUI
Message-ID: <CANiq72kY+h9jsFbVBq2_Z4YDUyPCSWuFX0Q5hUyfxsraNV-C4Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Check Rust signatures at compile time
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@gmail.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Rust has two different tools for generating function declarations to
> call across the FFI boundary:
>
> * bindgen. Generates Rust declarations from a C header.
> * cbindgen. Generates C headers from Rust declarations.
>
> However, we only use bindgen in the kernel. This means that when C code
> calls a Rust function by name, its signature must be duplicated in both
> Rust code and a C header, and the signature needs to be kept in sync
> manually.
>
> Introducing cbindgen as a mandatory dependency to build the kernel would
> be a rather complex and large change, so we do not consider that at this
> time. Instead, to eliminate this manual checking, introduce a new macro
> that verifies at compile time that the two function declarations use the
> same signature. The idea is to run the C declaration through bindgen,
> and then have rustc verify that the function pointers have the same
> type.
>
> The signature must still be written twice, but at least you can no
> longer get it wrong. If the signatures don't match, you will get errors
> that look like this:
>
> error[E0308]: `if` and `else` have incompatible types
>   --> <linux>/rust/kernel/print.rs:22:22
>    |
> 21 | #[export]
>    | --------- expected because of this
> 22 | unsafe extern "C" fn rust_fmt_argument(
>    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>    |
>    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mu=
t c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *cons=
t c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> It is unfortunate that the error message starts out by saying "`if` and
> `else` have incompatible types", but I believe the rest of the error
> message is reasonably clear and not too confusing.
>
> The main commit of this series is "rust: add #[export] macro".
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Removed period as requested by Andy. - Miguel ]

    [ Fixed `rustfmt`. Moved on top the unsafe requirement comment to follo=
w
      the usual style, and slightly reworded it for clarity. Formatted
      bindings helper comment. - Miguel ]

Cheers,
Miguel

