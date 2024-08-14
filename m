Return-Path: <linux-kernel+bounces-286053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F539515DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DBF1C2113C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4EE13C9C4;
	Wed, 14 Aug 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N635iou6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FC8488
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621911; cv=none; b=KSw5qJIaaDGw+yLtDPDeFxWHeNhShaLTGI0GvUgSQcKGa5OCC11gjQlPGu/xsj/erA0ull89JthqCPKNLzva5jgY1HjRRaqLPBrA3MdsO55nGCICJp625tmJWASJhdiGjGeEhevRTZieFUtfMTZNVSgxlBy3gW8tFqjYWofiHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621911; c=relaxed/simple;
	bh=WDW6rQ/apBzDjXQSNnDaeNH9u9GWWkZywdFllnX/IOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQqN1lZXzKl69RnrCEgiwLrWZThH17reqqwRBtBdrq+in19u2NkJJ70eI1wtEYpjjGcp9T7ZnXhMgWSeoBAsUrVWQ4x7kL/DMu6jpdSbP42VJT1D9DZmwh3P2pXQv+gluUDySsSfh4Bh5+dUXdwvBvjdk50+yIAK3NPZaNXWgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N635iou6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42803bbf842so62365925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723621908; x=1724226708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT+zi+/D9eO+wh878fg/U/GNgg7iPwjsl30b4TPDHZA=;
        b=N635iou6uTv9OX7tD+53GwPt2gr6bcHjSFYt+5thA30IGCUAeJLIYcltUlUo2u71KE
         idYyuZ7JhC/llSV9f0AYr5vQjXn6Ez552117dKI9qOMR2xzDaiklEuKJTFW9737GvhLe
         hIaMZou51wPFGiRCe5rlSKbgCIj/sCsDPHbs0rL7kC9lFXEeRVU7iQcEXD+5c3YYjreP
         JFl3ZP5EdfGToZwMz/jQ/Ab1jRIq+wkY5phiHTEhFt4hAxjrP/NutR+XJOCdtWK2wzga
         oT+U3zQ8koOysoMcrc/ZgI4xsAyZaTjmdYcff4/szq31QJUyIzia/J8vS+NEXCstxJND
         VVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621908; x=1724226708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT+zi+/D9eO+wh878fg/U/GNgg7iPwjsl30b4TPDHZA=;
        b=NYokMrho8NCdJ/S8Iob2373B4jKtu8GHSaP7HmGJhs0U6pJA7SmYitWLCtalsaPF7+
         DUi8gU12p0+cRb0NCfYO2Cxpv4T9z1QSyeVnL2E3uhaaTHNVGXUAX4gN1j5Dp4lppLf0
         vyL8dr+LPx6dkAHUECal2pEjX/ri5kF4WTCThhJUwfNUlu7qXEXjXjeeXUAVoO+fYQ4i
         3phIZXsUC3bQUgpGTdmIpKUHJUhrfWN6JaRBT0SmC7aifLX0sYLXdzHLMGi/uHTXZj8/
         byYPZikD93ZeGtLFmb/PkvEK495/lxeOnSJdWpbnubRJBd0jH3TdNX8hdZOuQX/Fm/kA
         W26g==
X-Forwarded-Encrypted: i=1; AJvYcCVCODYz3S0j71R8eHo5EgUnrMKzsS3yACl0E3M06n/+D6zhP4N4I23u16tZs7p9+GbuTsZzHb/JWOmY3AnxtV0syzuASmnGBJaybWiO
X-Gm-Message-State: AOJu0YxEPnVv5IsAOsqQP9hhKMhYGILoUqDiBpJbqD2T0cyj37VbTnEc
	89eNEOq86cEilnscfOqgnz+IGMJxQk6+GK79jOVNaE4ENmM74awM78ndKG6ndV1k4Y9lD4xbqnD
	RXsZOGQTBn7Dw/m5ZOdeH8SbAe1OchRwTLjHZ
X-Google-Smtp-Source: AGHT+IHNC/TFNKG7R4ZRJeXKfO788rQbS5/gH98Hg+wPjB1fBpqR9ujBShpY4AhPDFKtH2Hl4xoiX6/Le5LMbGM4xCI=
X-Received: by 2002:adf:e703:0:b0:367:4dce:1ff4 with SMTP id
 ffacd0b85a97d-3717775ae03mr1628464f8f.14.1723621907725; Wed, 14 Aug 2024
 00:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
In-Reply-To: <20240812182355.11641-5-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 09:51:34 +0200
Message-ID: <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com>
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:24=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> typically used for objects smaller than page size.
>
> All memory allocations made with `Kmalloc` end up in `krealloc()`.
>
> It serves as allocator for the subsequently introduced types `KBox` and
> `KVec`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers.c                 |  3 +-
>  rust/kernel/alloc.rs           |  2 +-
>  rust/kernel/alloc/allocator.rs | 63 +++++++++++++++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 4 deletions(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 92d3c03ae1bd..9f7275493365 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_struc=
t *work, work_func_t func,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>
> -void * __must_check __realloc_size(2)
> -rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> +void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flag=
s)
>  {
>         return krealloc(objp, new_size, flags);
>  }

Why are the various annotations on this helper being removed? This
deserves an explanation in the commit message.

Alice

