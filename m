Return-Path: <linux-kernel+bounces-307654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E429650D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96897282376
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FB1BA891;
	Thu, 29 Aug 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="P7gVKQax"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811DEAD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964086; cv=none; b=bvuMR594CpyflQ778A4XTZXsD9Ep75SVQ8DxH+0aGixUP6ccnsbjgqwAlIdprF2OUYVD9vKRhzO+4cfya4EvqIzmDPFfxj0RZiR2Plwt3XLLsIF7pIsu5q95ul454aIm7IqvtWtpzaGnrFh42aG/E+yx35nV1lQeF+GEhn1V988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964086; c=relaxed/simple;
	bh=lkw3CL5ttT0gqHzz5o9doV2aknAvPQcr1nH6EsFs+kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeRFlGWptmruBJwMvM6IupIcGSp5wbnKESintDbijv7kmqq9QzyNYmW1tc/ZvXGM3uifv2+C+qIcGYE/LSqYlNQ6GsyyDZNCE9/74sZdmNE2koDWHEGLqVwy+T0Zt37hTOGCcnzV6CfAmfsrigtCaQlMKdA/PtTENtyPNTV45LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=P7gVKQax; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b747f2e2b7so11030477b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724964083; x=1725568883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkw3CL5ttT0gqHzz5o9doV2aknAvPQcr1nH6EsFs+kk=;
        b=P7gVKQax6x78Tcf+QQbBjqGZRW75B74a0+zbWN/rTxwxJQIw2sHqmmdQKmPKhi2g1I
         nc3ulnOlQ5epE+J5drxty08ZcIdAAhX/d0BXUAe6HGxfK8D2Og6E61FvShsIhi6iulwV
         pMLUdfcS2H7l7BlIDO2Ly+pCfxbeKA1OHVPhlSkjyMWmvA+mLtzvS+g/b0hMdflAUJPp
         NTD9QGKnieNBYshKrmG/j29e1SvgsVUcas2akJFw7pVFhj94OHvORBeXkliM/Wf0KfI8
         6Uk77hA+0Z6bK6mJOiB99+XcaUYT0GCgig9895EiB+EpiJawQOETWekVPnCrf4sMjBhP
         4pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724964083; x=1725568883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkw3CL5ttT0gqHzz5o9doV2aknAvPQcr1nH6EsFs+kk=;
        b=YBKN0eSbv5iEw79rmp/nO8J7kT8LcjzCCWfkn/1/ZN/2rZYhhbBtKtLj2TZ9DIp+Sb
         pa8iG9iY5uMbQVYKW5PT98sxVzsRx5zY5gSQNJXoT8eH4lraxNG50XaXXIN7VuZvZOHU
         aXecnYY+ouqqHwVcXZnDRQAcQs+hXtpkYR+u7vzfiqSo80OLnm/dO3q7PCKlSe09Ah+/
         kbw8DOsqHHodRwHzM9cm2gfTHjIwTPO0OZ8I7W0aotbsl7OZr4Mpcj91K4z3y3kMCJwK
         RVZZqpjbGNL8+QGnIPJUWueJ9bEU0RWewGk6vYEpi9AlZ3S3SZ1lRbs6Q81Ei8Pq1kYT
         m2ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8x8jdbaV5xRSbWiq4Biv3MMBb2oeuh/d2yX1i9UreOCBcNCEOY1A8tsbTomvShsNa1oyXbvJF+8F8VM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypThtGIA1+6upjPwfO84dmBmPWj2LvFn82Le+Uj/VgAR0L/KET
	9hHXrFPStfuZGZGgp1VpOFge8A6D/VaSSFDUTFou0g3KrA0c7yUGU5SQJTeddNVuzFSYu50sJMi
	4m+lQ0UNMgqHAeNAbsg79ehfr8HPof4IDWHBxOQ==
X-Google-Smtp-Source: AGHT+IG5bnrqP5A8V1VwPz3WChxlTbtJRKlO+thLHCUI1KIwj2sEbBZHPkOzVeqpltZtskErlXnGa2h2LL9kt1/6Yjo=
X-Received: by 2002:a05:690c:39c:b0:6c8:e45d:ebd8 with SMTP id
 00721157ae682-6d2759683d1mr48049297b3.9.1724964083388; Thu, 29 Aug 2024
 13:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828180129.4046355-1-boqun.feng@gmail.com>
In-Reply-To: <20240828180129.4046355-1-boqun.feng@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 29 Aug 2024 15:41:12 -0500
Message-ID: <CALNs47uOhuNCj+LjD66AE5DSJ0DdEv4keJcgbmPaEAEFScWUMw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: Provide correct provenance when constructing THIS_MODULE
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 1:02=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to contruct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writting, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
>
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks for the fix!

