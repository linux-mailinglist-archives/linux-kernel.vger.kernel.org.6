Return-Path: <linux-kernel+bounces-374958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27A89A727C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F7F1F257DE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CFB1FAC37;
	Mon, 21 Oct 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZqTzvrI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDB1DF754;
	Mon, 21 Oct 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535810; cv=none; b=PlEg6Szhqxl++ZEQ3WLOLplr+5XH1KVHqPseAbnWRPwfzZ+IrIm8eUgJS4ZLYDG+3noK6CgneDPCYBu9YKGHkPHe0rGO71H6gZ26/8/hvotlyiLlPwqieKvH8QdZRnsDlszqtUkI5ARnbsY6F9SeX5YQZWrkcSAzjtiL8SXNn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535810; c=relaxed/simple;
	bh=6Yx6JtRPPVVwbNLtjrz65rkkNQ8CFdx3otQprjsUb5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl+dqXWNbn3W/7eBzAz6zPLiJ2R9LVPsoDKtOVc4lO/YSTCLxoH9f+YKVkI9hJSMSoFWW8YgPp5jfsyE9Bcar1bLGOKN7sg+H5I6XVNc3NYhL9Mvsi2b7ERnXi8cXKMloB0kIqfjGdO6tnUlLnH7wdEX45/nr3sWon3MDKbkigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZqTzvrI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2af4dca5cso940900a91.3;
        Mon, 21 Oct 2024 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729535806; x=1730140606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u629DnpHZnQ545QrDK0c+tn2+avw37Jlf85duGO1lD4=;
        b=GZqTzvrIK7JpWSFpUet8YO+bqOCEeqb8sUxAtCyTy6UbYje0ZJaSAW9UJHDpDehkP6
         XQZpCasbkHDCQqJdpgpeKFUpKAaFQTsGVZHGwuZU6kLG1RhTgu30oVyjt67Q33A07FSh
         BJ06DeK2NQm1StJOgt2xpdQ3CQUYUmEoXrczEPQVe9npXmAHcpAjAYtE0RmlQ/iZa3FD
         7F/xn4rcduNYnAoOw8lcJnKhQrFYTTpjQCMt4WKhPPKw6PoINTNk7F5Vg6A9L1Ht15GX
         Qpd2MacegVS22mLid4alVSeMUNiO+h8u0STHVUmOFMM6dYo1UtTsZkcBCcQdn4ubWVkD
         fGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535806; x=1730140606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u629DnpHZnQ545QrDK0c+tn2+avw37Jlf85duGO1lD4=;
        b=BRRB9InT/dBUT1BAGmqAWhbCeW93+foTfoxFFeaU4VXHIulZphYZrA6gPyv0ecL/pu
         Snd4uu93KTs3TGObXsmb1qUJOuTGu+SvbnmaGPthSrqWporCcOxvOQ4aNjQNa4GteHTX
         9D97JT9iNj9w9LpcX5oUbv4GATGok6awZXhZ5JYC1HXV+NCQy02nV46t3jpVuJpRGQX+
         RKIgWHSJuxblaWu1iW1SZ7HlvEgstOeFP5It81iUt5VzU3GPdf9nT+jFvXIRd6/ouzzP
         RAIzqI+qRWj3f4n23wd3s+l7SS+c6JB1yKUbmN4nJIJU0YZxv6iufVsT/7xbYiUDq3wq
         dyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVHd4yIRc3Jnk+jCsAv6Sf/A7+88PeLQNWaVuULdOwxNlt6ksWet/oc4pvZjdLeZ1vUGMe7BpavP8o/Kes5rRs=@vger.kernel.org, AJvYcCXyvoEW6vNiDt1UpUUARO0a9LhXVwWFhJwfjf4SiL2lKv8KtxffzMXbSwiB3/ZQtGiQz+Px2VCMqnbqOOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjWJkzKXcM0BjHKHKUfYneRp0bXCCCVgbdgCP4pqvGSnFqAZ5
	oLwhJYlPpwqTCf0FxQpHtQdOEiQpcbw3VgmKrgWsq1SOBHNpx86hkLQdVBAilk/R+c/NWwxFN6h
	tzb2vjY/y1i5B0iQRhnLI9Ww4Xwo=
X-Google-Smtp-Source: AGHT+IE8GVN1KMvji3jh+qlyLp0VwhEOUOdqwk25I9xAINvqEnuxcMbNW1hvwGd4xmpPsPXrk1fudgtFKWpU5z+mtnU=
X-Received: by 2002:a17:90b:1254:b0:2e2:d881:5936 with SMTP id
 98e67ed59e1d1-2e561a10f40mr5976891a91.7.1729535806334; Mon, 21 Oct 2024
 11:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com> <56169ee4-321c-4546-bb89-2f9530adb01c@ryhl.io>
In-Reply-To: <56169ee4-321c-4546-bb89-2f9530adb01c@ryhl.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:36:34 +0200
Message-ID: <CANiq72kG6WL_O6rjhcHkLw-GojYEjjRH5YJPsZUHNquyDdHkbw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <alice@ryhl.io>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:29=E2=80=AFPM Alice Ryhl <alice@ryhl.io> wrote:
>
> This isn't a distinction that exists in my vocabulary, shrug.
>
> Miguel, feel free to reword when you pick this.

I just rebased -- the Rust reference uses "parentheses", so I guess it
is fair to use that.

    https://doc.rust-lang.org/reference/expressions/grouped-expr.html

Cheers,
Miguel

