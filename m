Return-Path: <linux-kernel+bounces-419026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C5A9D68AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7D71613B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050218C028;
	Sat, 23 Nov 2024 10:48:25 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8186118C012;
	Sat, 23 Nov 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732358905; cv=none; b=R7Nf8+UNHuQwCmKD0xRZDOqOLfm+Ao565hgOxo5dW5nERMrqasq02E3f59PmkBgRI7G1Eej4GznLeEZd8bJw1r/6fLQb8JXQHSJLRVD6lzjkpjKAJt+rtC9nL2NnRKf2urym4ixBRKifbLEVH/zp2jQMQQeqVE+woKJe+YRdSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732358905; c=relaxed/simple;
	bh=r7jkTWRRImviysAqQEkRsWICaxX544sMoYOb7mkNNrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWTFJqmPCzCuO0GjxgzrIjVwzQUBiw8Zu0qjg0yO310pAH3l5qkeqEOJW9rVOxLPKViMNa1s9LggLhfAtHX54wMqZIgqdKbRTEbFrfLIDGuEz8AJXVxn90eLHBE0gyk3KdcU2G012kEIlb3Q6NbqgjmYQ539vEBKH/iVFsPH7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa52edbcb63so116377466b.1;
        Sat, 23 Nov 2024 02:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732358900; x=1732963700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ptIQUIn7cNzyoLk0+AEkw/OY7tiye7SBbhAPQKbQ7k=;
        b=eMaezBoB44UKYudaYYdqbYcneeWBkPd4GTz9Yh8My11a8NfI7u0GtZcAoMc3dOmAmF
         l/xvewU5W1t5nVLnf72JkDIpI60jMIgdb5lE/0gEbjhrsZXqMhegKq1mpNJ5SoUc3x2I
         DSv3KLiK5LMx+MFnJ9EE3qBhQskub5boOTHfSkWUjkh2V91q1zbiwm/n/MwtQSDwvXZ8
         SN/g42O6HE+BYasw/PaqDIQ1yUGOVpwzhhHACtq40P+qFDkaucNyVDFE27d7M8mrkcec
         Vg8ukyaMPJx6mk7MJgA1+54ESj9c3wgh1OthZiABFlXiv6SPhO8Lo7wK8g7ch5Pw4N+C
         frEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2dLYmml+V7j/3eH158Xo0YcJfUqNnQhWryv/Fzo4cun3H9YJ31htZxjx94d2q/he2msroTVnwpRQ6k+M=@vger.kernel.org, AJvYcCXGbA4hWYGAXOO+1W6D5Dch6QYZ+JQ3b0Ih+oqs276luAQNI1YC3LxBmM0ZZB8gZWEijsmjcoh5x/CdNLfQA5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQmhftNXbyD08jLgXAksPlbne518ghAHBCXGS1bNMDBcYUG2W
	HIeaeQiG8A7uZDggt0FET4ffURKjLXhLZBh30ATR80NNUPtSoDoLfrqqvhDA
X-Gm-Gg: ASbGncsZmfOJ6erNPSyHUorxdxtV/0PgNTNK3mFTbYdPVBg2VI1m2E+w+wJPEM+Hhu9
	wf6LWgXFrzE662eN8lymXu3PzJ3a+/IwqWjGzC51yzdb9VavIW9Rbf7nxb8a01JayjlMeNj0Boe
	eNspaahdYi5d4xPCTFZvTIzvPARaDLknQ9+SEPWdOlvKFiWrIL5BnKxVV5FRqpLxQRoGk1OhsUx
	HJxFF2khk41BAfFoH7jcyZA6dIsNA6arQM55bOP3KhOwn/DVoQUBGFteU1gfjkzwbCiHX6XBJ3J
	kDnF
X-Google-Smtp-Source: AGHT+IHNi4riTR1Snl60HVi/dd2Je9kUn/+hXSA7HSlXq2ZPr4zcn88QPbSOIAzxfCkVoMe0huJ2yg==
X-Received: by 2002:a17:906:32d4:b0:aa5:ac9:ce5f with SMTP id a640c23a62f3a-aa50ac9d235mr732411166b.0.1732358900201;
        Sat, 23 Nov 2024 02:48:20 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f6b3sm212426766b.23.2024.11.23.02.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 02:48:19 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa4d257eb68so561280966b.0;
        Sat, 23 Nov 2024 02:48:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU3bqqoMe0YoIg63YfcF/rGp+LLHUh7PGw/NOy7bez+tEkQsi1oMFfwfsJIwO/TOY2M+ZdlAxh+WYpJbJyVlM=@vger.kernel.org, AJvYcCWPxqAWOnbER4dEygEvhPxWEqFlOTvFsCi4ILLtgmrCUtRAJAenDcSiFzQrTJNUnYTLebXpTPRoqCgRsnA=@vger.kernel.org
X-Received: by 2002:a17:906:314f:b0:a9e:85f8:2a3a with SMTP id
 a640c23a62f3a-aa509984a5dmr672670766b.2.1732358898807; Sat, 23 Nov 2024
 02:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
In-Reply-To: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 23 Nov 2024 05:47:42 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-rfJkPsR71W-ppcxZg+JJ_qZerx6rjOwMKXBUdKC7V5Q@mail.gmail.com>
Message-ID: <CAEg-Je-rfJkPsR71W-ppcxZg+JJ_qZerx6rjOwMKXBUdKC7V5Q@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
To: Asahi Lina <lina@asahilina.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Janne Grunau <j@jannau.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 5:30=E2=80=AFAM Asahi Lina <lina@asahilina.net> wro=
te:
>
> We were accidentally allocating a layout for the *square* of the object
> size due to a variable shadowing mishap.
>
> Fixes memory bloat and page allocation failures in drm/asahi.
>
> Reported-by: Janne Grunau <j@jannau.net>
> Fixes: 9e7bbfa18276 ("rust: alloc: introduce `ArrayLayout`")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/alloc/layout.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
> index 7e0c2f46157b772248450a77ff445091e17fdfd7..4b3cd7fdc816c158e63ac7401=
4cbfc0794547e81 100644
> --- a/rust/kernel/alloc/layout.rs
> +++ b/rust/kernel/alloc/layout.rs
> @@ -45,7 +45,7 @@ pub const fn empty() -> Self {
>      /// When `len * size_of::<T>()` overflows or when `len * size_of::<T=
>() > isize::MAX`.
>      pub const fn new(len: usize) -> Result<Self, LayoutError> {
>          match len.checked_mul(core::mem::size_of::<T>()) {
> -            Some(len) if len <=3D ISIZE_MAX =3D> {
> +            Some(size) if size <=3D ISIZE_MAX =3D> {
>                  // INVARIANT: We checked above that `len * size_of::<T>(=
) <=3D isize::MAX`.
>                  Ok(Self {
>                      len,
>
> ---
> base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
> change-id: 20241123-rust-fix-arraylayout-0b1009d89fb7
>
> Cheers,
> ~~ Lina
>
>

The joy of logic bugs. :(

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

