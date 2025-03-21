Return-Path: <linux-kernel+bounces-571542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B249BA6BE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57FA3B854A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86D1F1511;
	Fri, 21 Mar 2025 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg1f+lO9"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720C1E571B;
	Fri, 21 Mar 2025 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572068; cv=none; b=p2psAbEYos3+a0i5Z0go/stqJhDI2ltkX3FHYPJIuNANyDTa27pbA5uTGRSUSM8CryCKHvWap0RZUq0fViyxhWACCGGEO9mcA8OGWJYJMMeX1RQYWzXb0fAJbG9b1E3+g/p8m1CcRA7vAVNnNNIt86WWrfpgyUxizb9s95uCRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572068; c=relaxed/simple;
	bh=atEPVjr7daeEQp2Xt3XW7y4mzFJL7kChqqXC6O6fZtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5xxvKvmj3yHF5nln2atcjL54lSlDIfdtd/iNhO1OmPFNqw9W+Rkbn5KY0tlEHcZoaXPbHtqYuyngfG1Q1pc3wl7snMbM0FDbLOV4i/+QQEH2PpZZ4gyGVH0erNBn9gEVNIkGO8VIN0w7caAONfiHnbJ5dGYQYK8yLcIFgDsEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg1f+lO9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fa8so22158351fa.2;
        Fri, 21 Mar 2025 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742572063; x=1743176863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI1O1RvgUqTEgM/cOz6gpXU53w7kyKs1V4Uu+k+QeY0=;
        b=gg1f+lO9wG0kFADjekuls6sm0GxJvJI1NG3o7nclrKl1rYLixBaEbAZjOcWyqgBAKB
         ar3IKqQW7EnX4urxJyjKGgq4H/AgsbS/K+3TY26N3ORZXUyg85ahRt99oD3Yd+cvE/WZ
         XYLgXgtETu+Xc77n6dYpgqLmjJ8mHVTk3g5abJVXPvzw6iwCuIwiW76lC0r+HYaBRT0v
         3NOivt5lDnLbtTdZ3kM0aXYHdxvsDkwjl9dncci6YBcQKdi3ZmbzPHvgoFQPzz+0bn7p
         LpRcHzL1SrfPl9sIe68v1DVsOkVkBelLoFncqNAdhQcUKv9hOwmmZ7PLa/znwYPwVBUr
         DVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572063; x=1743176863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI1O1RvgUqTEgM/cOz6gpXU53w7kyKs1V4Uu+k+QeY0=;
        b=kFuukGYvR+iCpDfIke8Lcfb4/S4AID5le9B/zKdAoyqal8+9psrmErZrNzGoKzMQiJ
         T9jIZGyret8VgmUuk6ar20kDLHHZ0e36WevWxvVHPjexVdZ8SxnP82Db18/9/pknhJa5
         /crdvvDR9ZjoaKpD7YgNbsEOgS8oTaRW1jNkuq9WyhvGQykVTvIxVqgJFbefZ9VcFtRo
         2nLZ4gE5ihx7kA76wIkz58wwMyT57dTwG5rXqVv2JyBIrnMbZ9Fok5qxLSuCjBItuQWl
         /aRm1pediMyW0WGvThSxrPTj8aAdtb4/9npzpGrhaLhxWCkx/6TF3C9YO8dlRPdFF0PM
         TuAA==
X-Forwarded-Encrypted: i=1; AJvYcCWh2yztN1kIb7fbKa/wvbTXmc8v+QrRA8J44VQhY2QQZUJnV/a0vogGJdPIPSpR5eFuuIzsb7MX/PcjdSc1Hk4=@vger.kernel.org, AJvYcCXugZLdvnAuWVNfTfXw4zvaPfICIddBevJ8tNoANPM2TMqSdDHl8Kxj0So60Kyc0EqfP539HC//uAHD+a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhOoRcLj2NkZ5U6cFlDFJo5GAQ8cfTsZ5r3ix9OZ0YniMGxK6p
	eZF6qHhMc3RrZFlWWE0nmLB2kxA3xczysa8Zdj1x9EZeh6dhpBXOKAg/aaK9Xci3qEtddkMkwyl
	/VVDHGHQDrLA0OxL+uuwKIfl0X90=
X-Gm-Gg: ASbGnctErKI07qAsQjlcZlJYsfs7+VJ8vQ+0OUciB9GLCmHCSZ4Sy0fK0qMFwiCUtls
	etokfbm2Q/1ffukk5sFZINhwVzWxyadDE1mNkO5A1JhuwWNLPcUcGxLZJfoYssbsHKMqbWA1HSI
	+NwURC2EA2eL9K6iR9WJ3Vo84X8ZiRlBnkBGyCeQJL1VIL+z84Si0D
X-Google-Smtp-Source: AGHT+IGjgqAUQuUxAQol6yWac/IbEOq7lPOeoWX+btKHU5g256W8ec3xKb1Dxl6YWOMiHfQxen7ebIKBRWLxAWwdups=
X-Received: by 2002:a05:651c:231d:b0:309:1fee:378d with SMTP id
 38308e7fff4ca-30d7e2398admr12606941fa.19.1742572063068; Fri, 21 Mar 2025
 08:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 11:47:07 -0400
X-Gm-Features: AQ5f1JpwgPj3ooHY_cy-n-Zupcz3hhp5-3c3R6A-Iv8v0KstNOG_5RgEY19xlQY
Message-ID: <CAJ-ks9=RXZDsrqNDEyy4U_FL=ou=VJLXorqFoftepmZe98Xb0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Additional methods for Vec
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:10=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This adds various Vec methods. Some of them are needed by Rust Binder,
> and others are needed in other places. Each commit explains where it is
> needed.
>
> I'm not sure what we concluded on the set_len / dec_len changes, so I
> don't depend on that series for now.
>
> This series is based on top of Vec::truncate from
> https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjbal=
lance@gmail.com/
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Add two more methods that I needed.
> - Introduce some uses of set_len.
> - Add example to retain.
> - Simplify pop.
> - Adjust 11 to 10 in push_within_capacity example.
> - Link to v1: https://lore.kernel.org/r/20250320-vec-methods-v1-0-7dff5cf=
25fe8@google.com
>
> ---
> Alice Ryhl (7):
>       rust: alloc: add Vec::clear
>       rust: alloc: add Vec::pop
>       rust: alloc: add Vec::push_within_capacity
>       rust: alloc: add Vec::drain_all
>       rust: alloc: add Vec::retain
>       rust: alloc: add Vec::remove
>       rust: alloc: add Vec::insert_within_capacity
>
>  rust/kernel/alloc/kvec.rs | 202 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 202 insertions(+)
> ---
> base-commit: a337a03281efc4553191b432d757d4c04884bf4c
> change-id: 20250320-vec-methods-adfa41e55311

I think this doesn't specify the dependencies properly. The
base-commit looks to be
https://lore.kernel.org/all/20250316111644.154602-3-andrewjballance@gmail.c=
om/
locally applied. This prevents `b4 shazam` from working with this
series.

