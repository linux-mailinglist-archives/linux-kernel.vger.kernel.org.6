Return-Path: <linux-kernel+bounces-402313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C79C2637
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A2228336B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E71F26FE;
	Fri,  8 Nov 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwfAZUQz"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B020DD40
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096367; cv=none; b=DNj0tIXzNI0CLcBVhN4JS6+GG2i6vwADAA0LBdQBADCAkS5lU94o6bP1DsGN6kL2oxY0OevcjCiaURSikqMwhLeT5mvySl6OAEneF3GTuBjtyYN4CgCwafyHnXh4oi7uOTSHMe3Xyvv4CPL7dO4dqpzLbsLiRQ2Pi0eJk9XaHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096367; c=relaxed/simple;
	bh=ywmyj2+mwTU628wLUF2xRspDilFf9o3W6NRYN3/t0Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjjvfLvbgjwi5t7k5SNjRuujbrKK5RJrDIyk0HX1mjSyqPd0YgmE8tVVW6foD9CzyBxnaWjNGds3vPjY/O8YDpCoFqsWFnx0RzHuAR6wNlLDBOsqaOSm6y1rbzqCIODQ5sIu1eNPIclKV/Wrt2xAeyAS9ju4yL5MHwgu/ssOAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwfAZUQz; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e66ba398so2633e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731096364; x=1731701164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywmyj2+mwTU628wLUF2xRspDilFf9o3W6NRYN3/t0Co=;
        b=fwfAZUQz0fvk7PCOIOzGg42vgzPQxYhmbEbHSgcYCt4yAsP7Liq9z9TgppYCuhi80o
         eUS29yeWjWecnlzjrR9v6i2RDNKDta2OoiGxiipKAuWxz0gHPdwLNH0Ji69+OuVUBQ3b
         FM5ecf0NI0qm5f61YifSTS5yLwgaSj6wzZ4v9c6RLpq5+qVvFlh6/AV3gcOjkCm2H2QT
         mzvJ7SIpIpYnzo5Qdy04stul9qNhAlKstdLrvNAE1n3uVO8XbL4atUrJ19rbU6epU3Y+
         K93IEIc4jKloVbhg8GAo/56gFs1/713Ky0hjUNt+Ia1uiEESFqFl+15PJUAo9ycwipCb
         ZRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096364; x=1731701164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywmyj2+mwTU628wLUF2xRspDilFf9o3W6NRYN3/t0Co=;
        b=WOZ/7SHCMgZLqE29wzIg4ODeQ3gBO5Aogd7K7a2r8Vf4hNfMfvhdXy6/0bq96JjHft
         dtgUSz2Q+/6UkXpV9rv42RWG7R75+wfgZkgr6Ibhy+Opx7fxkTRaoeKDBVcpD3MlUJjR
         kxaXBqeEv5vUhSoh/urSmGQWmWzSUX++nj47QPv5ARVj+vn2un7EGT9kNR/PZ1ezCPfi
         VEiZw4NEpazOHpKWIbWzCEb1KzPrw345HzNjjluDDkj3oAXZ83XH/zMhqmTVwI1hv1Kd
         6FPA4ZGHlopz8BKUZtJOCZ9msiDNxREX1xqHEursEcf6sMhoZCWjaMjMNJA+FAicJBkD
         475A==
X-Forwarded-Encrypted: i=1; AJvYcCVJZjJkpVUyUIhRG3BeOOf6D7Atpgtoo0xdfYfCUSMQKI4E+Ej9PgZgUti14dBbe5YTKZNmFEqLIf2FGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWWIUGsFK9rsecSbkZ2iOwyIIJK0/LxN1Z0kvCRT7vocxmKiH
	nbjbrUtac1q/qEL4gccqzx2EmdO0LCOCjPEDDAdbYW3GSqmCUM/0qqFuKR2C6f4r6OsADoLQRCz
	mJFzxVixF1XHjlfpdSE7TBdWVBfqDvwAq3+Dq
X-Gm-Gg: ASbGncvpU7fNQUbT3nh7KwL+rml3UP+UMyituOGeRsdJKRg0L91WxGeD4Q8Di+IPjuh
	JPHhyfrPoZy1jFDmYV71mFI2OTZBPb7+d6shrjj2E9PueluMiYxDGblNezYg=
X-Google-Smtp-Source: AGHT+IH3kL4lLs0Uipupi9GWt32/5/tNTyCIa5bVmyx6fwQw8gtGwZzBdd1MsiyDybp0ou2acgQ0QsuHTDGC9DKGes0=
X-Received: by 2002:ac2:44cf:0:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53d8bd9a3e5mr66025e87.2.1731096363220; Fri, 08 Nov 2024
 12:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
In-Reply-To: <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Nov 2024 21:05:27 +0100
Message-ID: <CAG48ez20pcWiHXCKWv74cw-CDjeMrO+kcbZtmsgRo=7+Yxzspg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
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

On Fri, Nov 8, 2024 at 8:01=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > These abstractions allow you to manipulate vmas. Rust Binder will uses
> > these in a few different ways.
> >
> > In the mmap implementation, a VmAreaNew will be provided to the mmap
> > call which allows it to modify the vma in ways that are only okay durin=
g
> > initial setup. This is the case where the most methods are available.
> >
> > However, Rust Binder needs to insert and remove pages from the vma as
> > time passes. When incoming messages arrive, pages may need to be
> > inserted if space is missing, and in this case that is done by using a
> > stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
> > followed by vma_lookup followed by vm_insert_page. In this case, since
> > mmap_write_lock is used, the VmAreaMut type will be in use.
>
> FYI, the way the C binder implementation uses vma_lookup() and
> vm_insert_page() is not very idiomatic. The standard way of
> implementing binder_alloc_free_page() would be to use something like
> unmap_mapping_range() instead of using
> vma_lookup()+zap_page_range_single(); though to set that up, you'd
> have to create one inode per binder file, maybe with something like
> the DRM subsystem's drm_fs_inode_new(). And instead of having
> binder_install_single_page(), the standard way would be to let
> binder_vm_fault() install PTEs lazily on fault. That way you'd never
> have to take mmap locks or grab MM references yourself.

Let me know if you think it would be helpful to see a prototype of
that in C - I think I can cobble that together, but doing it nicely
will require some work to convert at least some of the binder_alloc
locking to mutexes, and some more work to switch the ->f_mapping of
the binder file or something like that. (I guess modeling that in Rust
might be a bit of a pain though...)

