Return-Path: <linux-kernel+bounces-260127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA3793A37A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4C1C2263A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A0156F2E;
	Tue, 23 Jul 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqsWfoOE"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A715445E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747095; cv=none; b=atX/nJuzxcIcU6Y6R30oRpfYhs9Gul2dGqkCxTIjhJuHza3D1P2So63zs9m579mkFl+VpngUgkjuM5oEZVO9x98NRchyq/ILTL/gWCOWsMkX7xJBfNK3PVZNRWgeLLdgKy9rVj6x6MJQ9+8lMf11EjUVI5GfsU7xI818px4/Nc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747095; c=relaxed/simple;
	bh=7Cj4qXUfM9HQm673/EiEPlj1QfOpiWHROUnSLYs7imM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qo24jcF9d3jAlpjW6sO/z+KJn4RJ3O8exYpS7FGo/u8JjKnDXcJPkF+pDHGJRdrVcD+223+GXl5pFKH1omJCs3zb4G/VYDJjCZNQK2NS/Jkw4yWAIjt4Ee+SCeOVWitRNqBxX81noDvcb4gvetYNTttZv0adUyDkY3Q05EmC3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqsWfoOE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684bea9728so3293549f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721747092; x=1722351892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fDLpLWhI3bhX/1zNYsaTcZaVvzDKWENTn8dwHnt5k0=;
        b=KqsWfoOEHwpoZBhWVT1d+47NOtNSOP6h2kpQHXqC3QDeBswrNohcwXhVx5KClyYLvs
         KDuPVbzou8srlfo/8dwFkCjsnUqrDoaN9dQXRWBohuHURf9lpEBnKNWVw+i2qXL6BCbe
         9dpALiuQzHn51fE1TWdw4LCeJNVq+tiIWUlwwoV3f4WTa51f7gc9c8Ci0dlnHzrhdFot
         UidicTbFhelfAGz/NV8bEyo4POceMwRYkMyKoSLdFUWQplIN3KipbGepKeYZzDB0W4dL
         2eBZrvZhpHTeN8zXoJDh3EDiPJhJMhlZY/bCI5m9pZ/GsCC1H3M/sviG0OmMqTBNEPKe
         vigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721747092; x=1722351892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fDLpLWhI3bhX/1zNYsaTcZaVvzDKWENTn8dwHnt5k0=;
        b=HmW+7i7Ainz8ltR2vJHyjpLYos1FeBlwKR5atBM+9ec6ES/0soxsT1x7fb1db8EFes
         S4XoHGB4HN08ksLqp/TxNF/VzLCVHIMWrhwSI5gSTzCtbSW+3kR3JAzt7dY90qEZBeiY
         QB5vBWF/yMGxi+SeBErITm+5rMh2aNUljlKt2wRDSMDGs0j4+fFp7r4HSIcNtkFnIBXu
         BYYBnIvcmMkK7+aydywYcFY6JAkSIaI0rENpLcy7O1lsrdtXK195SfZwGJ4c1MBrylQY
         FJjQQse+saoZPk/t1UWGXdXM1yOLNQZEtKvUcq0xzuwvX30pVkd2D2w6rgJ/W/JXPKS4
         6XmA==
X-Forwarded-Encrypted: i=1; AJvYcCX+KWdqouYv9CJxK88vs8ElATAJxdYg+E6DAdaHKnhEG5pWdWz5ABLkAxlYgDYDTYm8kCsCXVf8WWsNc0UW3NBTYtTm3HSwfpzs9xbh
X-Gm-Message-State: AOJu0YxqNXnFQGffNAMOZQb23KyawZAJhoJQ3MAUvaUelahSfiNPUHyY
	/0JjI9GaNrJZRY0sEvwlQY/holXKuEf/2alNuhQxIwJSGM+8APF1ZG84yUejn+iT193elkpJV5b
	RBk2EXUXZCvEiwD7Mo54u+xEqbkthHj5i7K/M
X-Google-Smtp-Source: AGHT+IGn/ROYNIhhGAwOKtA+EoK9/nAVYByn5CJh4yLPZB8FbZQynsJDHToZMNdq2XASnksxlFoxaKAWjK8MwqE3xRg=
X-Received: by 2002:adf:fc0c:0:b0:368:714e:5a5e with SMTP id
 ffacd0b85a97d-369debf8bbbmr2714091f8f.2.1721747092088; Tue, 23 Jul 2024
 08:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-vma-v1-1-32ad5a0118ee@google.com> <Zp_DIEOj0PtNywmA@casper.infradead.org>
In-Reply-To: <Zp_DIEOj0PtNywmA@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 23 Jul 2024 17:04:40 +0200
Message-ID: <CAH5fLghzRWH3MSb2bwbk8EEA--iaaL8GXBU9UHZGq0th_CCA9w@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Matthew Wilcox <willy@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:50=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jul 23, 2024 at 02:32:03PM +0000, Alice Ryhl wrote:
> > +// SAFETY: It is safe to call `mmdrop` on another thread than where `m=
mgrab` was called.
>
> If I were reading the documentation, I might want to know if it's safe
> to call in interrupt context (either soft or hard).  ie can mmdrop
> sleep (if it turns out to be the last owner of the mm).

I'll add some information on that.

> > +/// A wrapper for the kernel's `struct vm_area_struct`.
> > +///
> > +/// It represents an area of virtual memory.
> > +#[repr(transparent)]
> > +pub struct Area {
> > +    vma: Opaque<bindings::vm_area_struct>,
> > +}
>
> That seems like a very generic name!  MMArea?  VMA?  Certainly when I'm
> talking to people, I say VMA.  struct vm_area_struct is a terrible name
> and I'd be happy to change it if we could stomach that churn.  If I were
> naming it today, I'd want to call it struct mm_area.

Yeah, you're right. I should change it. Renaming the C struct seems
like it would be a lot of work. For now, I'll rename it to VmArea to
match C.

Alice

