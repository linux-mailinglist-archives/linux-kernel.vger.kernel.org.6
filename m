Return-Path: <linux-kernel+bounces-363818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF60299C76E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BBB1C22FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1EE1990D2;
	Mon, 14 Oct 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1IyH/pi"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFB195811;
	Mon, 14 Oct 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902818; cv=none; b=s/UUsdahaiGRrFH/MEyW+NEz2jBo7cDc9E1gbLTKKl2x7urXZWwmQayelcj96R/SBl9sXD31aB+YiKJ6dKbaN/9cB37kCE8NhxOFUSsoGnZy609hL+l7qPur03Rq7o+LCsJHte8FpVmhDePitP9slhe49dUPwULE5JQLQL7l7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902818; c=relaxed/simple;
	bh=Q/oqmeVmOM3oomHbH8ADDkalQUS4i1GdXNDrEo0uVHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiktqyGxxlxxJU87wpczMOWwb5Kx6BMyWt4B5VY2jZP0HJEQMfI2zKhajYyI3xdECppqXqBVn08Z9XWQV90PQhwgqsWao6RSFqg7yXc38GPyAELgGsGZxcQjJcEc4OKrThQ75zh++KhDft8Og7ka60KgvgliQDkHISczL8HgMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1IyH/pi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2c2a17aa4so849075a91.0;
        Mon, 14 Oct 2024 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728902816; x=1729507616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46HkK5QbXKink9cFKdDs28XgpJ3tA0weU6y+j41fq5Q=;
        b=D1IyH/piGOtzcc3KOcWzaj9M3T4rRgsJIMAD/Ipwa/ugmUWLra28sA5feUgrUPDzKA
         3BJswqC+o9Y6wkVM7lgwbfc0j9y5bVmEmsiCXvM30OFSFKjVr5claHvpEEvwOOlCLPP+
         pAudTTVfPFvebf0wjHIhezUezZI0Z7s5xdB1gSlWhg+OzLn2NEI16qgHVtuNNL5zOFZ4
         9DcWe7r/BQ5HeNqON/pzZeCRiIaviO7iWIY7QM/WLnhdNQlLkOoCA7HwwEyWvyUjR1cm
         9fnP/o7rzs3H3m9Yd00qtgvvbaxqRII3ynPxanmbs9UXFbfmVB5Fp4OHt8lXAw3wAujc
         UhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728902816; x=1729507616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46HkK5QbXKink9cFKdDs28XgpJ3tA0weU6y+j41fq5Q=;
        b=rj5dA3T1nm4r8AYCn/Z45XPGGPn8vqM6erh3dIR5Mcvac+CAfX9KogaGMlzrRN/v8g
         b/a9n9GWjP83P6IHItCSr+ofPkePY6/GwLmXCOZfc88qdHPMl3S97EM6u6COJ9yhLm1R
         Nk/rpb8cWU/UkPE4lQdGAtr7A5gY6tQLyTcrM7QRc9tOtJcgjSApL2hRLPYrZwl4HMMe
         gPVeD3vEEeV/yqZSSFW3vQr8G4X3/YpXWmAxwGOru7syVBfs2pijIQk4dIC708Z3h8vd
         5RbgUYrHtF+y9PxsCPz9Gs7y6IgHlKlqdNA/oGNInU5S/F+Bim6RSa9UYNLIeLYEKPA+
         SclA==
X-Forwarded-Encrypted: i=1; AJvYcCUtavs1XI3PBGFbpPd2xq5sBEgu4r2ER/PfVqXm8Sk4K8xV0N+XMfpB1fLj0aNoH5Ky8hN86dOZ6t+uSyuzP2I=@vger.kernel.org, AJvYcCWKBeP6+mhmeT0ibVZ39WhAJcTAwZINxiXrMI8r/lg9I1i2WD4UOL8g5C05dKaC69qKoMgvyvl9A3lanV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7eIzGXfBg5oZ5KPAw05/pNfxTzJFYl5m3AyJ25IRfay3qin8
	vAqT3N1LmRwwD4sgJJ5qbbOC3gg2SQy8cJTUFE/KvabulbUZyyeekFLRdXu5FTQgmjeZQ8SLatT
	F24AImZbFMXkG1CRwZlcwYvbzW9s=
X-Google-Smtp-Source: AGHT+IEB/3sBumZ4RFHSZgvSjlHuw3kP78qj5138y8lCPsRQdrBstDKHwCAH9lqgwnJ0Wj1xRlNTTtwIe2wau3XXdyk=
X-Received: by 2002:a17:90a:db41:b0:2e2:d881:5936 with SMTP id
 98e67ed59e1d1-2e2f0d96389mr5719048a91.7.1728902816424; Mon, 14 Oct 2024
 03:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-vma-v7-0-01e32f861195@google.com> <20241014-vma-v7-1-01e32f861195@google.com>
In-Reply-To: <20241014-vma-v7-1-01e32f861195@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Oct 2024 12:46:44 +0200
Message-ID: <CANiq72n8oKnAWVj71uus8FuYEqqi+Bvy2zJ4SP=DX9Cgd39UKg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> +/// #[repr(transparent)]

Line in docs.

> +/// #[repr(transparent)]
> +#[repr(transparent)]

Ditto here, but in this case also outside the docs.

Some trivial nits I noticed below since I am here.

> +    /// during the lifetime 'a.

Backticks (some other instances on lifetimes too).

> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.

I would add `bindings::` since otherwise it may be confusing to say
the C name without qualifying, since this function is also called the
same way.

> +        // SAFETY: The pointer is valid since self is a reference.

`self`.

> +// Make all VmAreaRef methods available on VmAreaMut.
> +// Make all VmAreaMut methods available on VmAreaNew.

Backticks.

> +    /// Can contain "struct page" and pure PFN pages.
> +    /// MADV_HUGEPAGE marked this vma.

These are copied from C, so it is fine, but we may want to take the
chance to format them.

Cheers,
Miguel

