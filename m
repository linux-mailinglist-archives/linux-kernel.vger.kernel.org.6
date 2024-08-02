Return-Path: <linux-kernel+bounces-272230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AD9458E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27071C22468
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFD45020;
	Fri,  2 Aug 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGwkuvQU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3B41760
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583971; cv=none; b=jIzm5AsakGflmMpmm75XtDcyofw0evtnpodQHGvh4GwGHUD6sAGrdVxpvhaEi5nya9Bj/0BjKhYBzdttq6p1MwSdpFXavWmAqLD3IyRuSKqr3ZuY/2q3TNYyNv3U89YtKOWppc+mPVDCdDXtRQxXtpAh/TbS6iQd7wBHXZquP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583971; c=relaxed/simple;
	bh=qY001KW9vXR2I1GkO67ihOY90Z/kRWVhfwWlQJQ7Woo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz18I2qlMtGP0CykgtZ4/BsPde4Bs4ytkPwitWiNh9OUWLGzgEee2SawZXrc9a23WA9E4SbKdrSyUekt+uYQ4kg7pU94hfpUY+6vT2IGkIjLtL6K8eMBhkPvO/KhzacXxRD+7iP6QrvTmYjaqPwZVsfQckwgyCRW5LVwpnkESkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGwkuvQU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-368584f9e36so3851133f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722583968; x=1723188768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQnIf0ueFkYF1XhpqiJ9sQBTc6MnrP0aayXu2YYdYWs=;
        b=jGwkuvQUIzYuc1QuFgCkxjQ9WZn8stY3OmFYo2fnzG1rYZcXDW5l6WgGqCMpRuwSqf
         n2kDoBbGBZ2qoTV4IR2r5KgaO1D6tvG45Q+hDGoUTOSrpxhyWWg6dkvgNw9Tvqok9L7o
         ETTmb38lOuB4MD2s9zeB8HCA4jQ+9fXRZsy9fjgV2xC4xoW6KZfJhpljLeo7GRQ8hSvs
         eCpWZr+08/Tl4NGgEvEQ+bAaFsMMdEAqy7Z3LipgAy3cHcWFr/cx5IGHhWBOU9HmuXOb
         V9lHMVvNIsljrBoo0fg96EhFplt+blQazXy6oRc0VWf81YqiauTiERoWwQgctyGgmn11
         TvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583968; x=1723188768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQnIf0ueFkYF1XhpqiJ9sQBTc6MnrP0aayXu2YYdYWs=;
        b=XWhiIzwesw3BwNkYZxsHCC9ArPiqhab/G7DK0vs1N08hBvO/0+tBUIJEnsG1ckhB0U
         Yx7Dibu5qxFZ393U1ghGbu8QjCq8jMwrLCJ7jR8RYjG3mBIk3Kcdd4068EqteWLa299r
         X5Ve9hrXT0qjNl4Z57lHNSYQKjL0CfyTc/a1Z2TvF+6sHXOgPwqywHAdVBLvLJlOt/c1
         E/L+5fJ+2DG6uaaQg+K60jDbuS7DUPIotAPCpm0aS8BRt5NIYI7pzfMa6n20fYtWCmXE
         S1eEYlONDHvkdLhy7a/su1ABfCsBqPkS7aV2Ylp0DSiqGScbYQAqHnXQ6LBdnLHXR1aG
         wACg==
X-Forwarded-Encrypted: i=1; AJvYcCXirky6KaaCIVu7cGFwn0cDv1ajFveJDA9r0Rt+PZsW43zIcZQPBzpySjg2rEWnalEZtBMWbo4qAkuI4rNHRi1qqfqZrtHrcmTiR44m
X-Gm-Message-State: AOJu0YxAVtQDfxsDCQFWSgys0hcbwrpPCHMZGOl8JKxO7bFl1whC2DV2
	DxqRDaCj5JRlW8c4BwyArgSHJtRGGEz2goIZkXk0IIJchVTD6FEjqVi8ropGCwEkft3mpelZSgK
	rFaqbrIghDezWMkkUzVSKk6KHA50RZvw6IoOG
X-Google-Smtp-Source: AGHT+IE+7pgvDLTDQLIF46tLw/dZy4324VcvctZdCzjB81g57GdEwK+6Bpx7ukgJy1JFDgrhal60MeO6nhwqSsFQ42Y=
X-Received: by 2002:adf:f283:0:b0:368:584f:9e08 with SMTP id
 ffacd0b85a97d-36bbc0cc53cmr1654013f8f.22.1722583968125; Fri, 02 Aug 2024
 00:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-vma-v3-1-db6c1c0afda9@google.com> <82e4816c-cada-46f3-bebf-882ae8ded118@proton.me>
In-Reply-To: <82e4816c-cada-46f3-bebf-882ae8ded118@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Aug 2024 09:32:35 +0200
Message-ID: <CAH5fLgjrxPCY0txu7OvP4tp2qNBoOd2HX3By_txkF3_4ChYggw@mail.gmail.com>
Subject: Re: [PATCH v3] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 01.08.24 14:58, Alice Ryhl wrote:
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > new file mode 100644
> > index 000000000000..ed2db893fb79
> > --- /dev/null
> > +++ b/rust/kernel/mm.rs
> > @@ -0,0 +1,337 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Memory management.
> > +//!
> > +//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
> > +
> > +use crate::{
> > +    bindings,
> > +    types::{ARef, AlwaysRefCounted, Opaque},
> > +};
> > +
> > +use core::{
> > +    ops::Deref,
> > +    ptr::{self, NonNull},
> > +};
> > +
> > +pub mod virt;
> > +
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// Since `mm_users` may be zero, the associated address space may not=
 exist anymore. You must use
>
> Can it also be the case that the space never existed to begin with? Then
> I would write "the associated address space may not exist."
>
> Also I think it makes more sense to use "You can use [`mmget_not_zero`]
> to be able to access the address space." instead of the second sentence.

I took the "may not exist anymore" wording from the C side, so I'm
going to keep it.

Alice

