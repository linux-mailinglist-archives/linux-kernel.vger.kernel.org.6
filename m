Return-Path: <linux-kernel+bounces-417903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF59D5A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361241F233FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9131187855;
	Fri, 22 Nov 2024 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5qUZw8I"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6C176237
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262159; cv=none; b=pCc9yqhvWZtoH9cvbEt1CQufRMgNK9j3DSDDJpaHE/VbFpuBk6UNibUWs3/nlu5cABOE2z0VEw98oxRVNpnJRuOlLnHPxKuMpl/nKd7XD7hoSDM1BLJZBWDvkXjGn0PtKKqy9dDR+m9sQLjZyBZpP0iwzv+bi7BCluYufxOiJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262159; c=relaxed/simple;
	bh=xVGcxLcjSynzoAVzrOsFTd0jLpmncSnphm899Xcd02g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXDAVtxuyViWXHc+KI6y/oSkpsFvd8LoVMwceVcZjHKgJBR3wfkADuVPlnW2Ra4WIt5IWJqtwBHRSOyr+Kf55MvS8EXS3cE2R2SXmLO46cVsn3fySz57VXRKojnCrc+79KaCAh9SgXC6dRL8JBOWdiuFAdlYagKab54ccTogstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5qUZw8I; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so15564885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732262156; x=1732866956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4vKBieIfUnfP5rb/GIVJx7pJ7hMdseAArRaDJN1LAw=;
        b=W5qUZw8ICXhpwUfKMNnezDi4hu9nbiy8SzLIwe1dtsS9KasBDWWj0fIC/f2DEmKxkl
         BTgZJXCZgaMvQRrgw6YuliCsv2utUiXuWzkJhtLDi3Iuol6vzABgrcxaPR72btnjz6MN
         mpxusd7nLaPGKaNUM/zV2E5XFiQ9yKwR0fvCLscUmU2qqUXDuXLWmDyE7G9SgdsjBwoi
         wIOzqYxeQ5mVNg9VsbfImVSkF/sdhdSKz+29jB9YZ+zWpUWZy+92xJeUUgrtCbdj2n89
         ZZSyy5P7iU674IXen7YPPAxJfcah+oMAACjMRmgc16dl877CtMwrXsVIDRMIcBsUdSSI
         eIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262156; x=1732866956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4vKBieIfUnfP5rb/GIVJx7pJ7hMdseAArRaDJN1LAw=;
        b=GJSYqCIn1d11VOx+Z66VJ/hoqvMJktWdC2CXN7NffzUxKmwM4jGLn5ZJWv7CkaEG20
         7Ev8B85HtYzvV3j5SDCKZyqHIpR5cyq0mYLvn0hl1tmqyJ11FFH3gLDkA8be/4PUmmxf
         m0DxuF1SnGa4p9fiMcJBU25mFCsxinlYn7kcTNtaWQ4BQomJ4lxVlz0QFg4ZOEYNtEH1
         VoaiYhRb0krHu/seDKPnDD1RW4WbEOjpMfDypClN7L+qx/DbzZNBYySIwbi4dC56F+CK
         lfMd/rMdOMxvhr9KzhCM6fyoEc57/Ty/RZCP7AC5Gf0ZJjg2OZ05GA7qSk7hV3UhABAR
         uBww==
X-Forwarded-Encrypted: i=1; AJvYcCW21I0MpCI5UhRNCCEdIIlmRcX/gi7Lu9/wmNMPio8qLbtxqNEiAShbaUm9nsH7FYIWARaUW9R3Hh7lGfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/YYeCaGUM4wYU2FdqRlwsWcPO8fjgylLw9Wk/JwTH2VOagBr
	RiAFE9w3nV5fn6tuUMsIzXLNxG4rT2kJWGPcSM0znXaL/5AkXuruR18HCehbbeXU86Pg7fLME+X
	lMvYFw/HkrDk7/5Mcnmw/F9lAxbScTtLvk642
X-Gm-Gg: ASbGnctU/dkTqQEcWb+vLnl86H/B23KI8ImWt6r+8Qmh6SaDRsATixEjCPI3qGuxi4j
	FUXOuC3jiHJar/1UqD++iTMY6TJaf1qA/
X-Google-Smtp-Source: AGHT+IFkzG3/qxSMU//RMD7jHCtgcpHQJ+DTwGvLNDlSxbRcCSQe+8OMIoK+cYjmebrEz5l80i1lbp8WkF/Cant0Mek=
X-Received: by 2002:adf:e18c:0:b0:382:3894:346c with SMTP id
 ffacd0b85a97d-38260b76c31mr1646813f8f.27.1732262155734; Thu, 21 Nov 2024
 23:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-3-abdiel.janulgue@gmail.com> <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
 <43a07c04-2985-4999-b6d6-732794906a36@gmail.com> <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
In-Reply-To: <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 08:55:42 +0100
Message-ID: <CAH5fLghUb8dEV9GVtJj497cJ5sp4Gg7=qeijfnV_w4BNd70qxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page mappings
To: Jann Horn <jannh@google.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:18=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Nov 20, 2024 at 11:56=E2=80=AFPM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
> > On 19/11/2024 19:07, Jann Horn wrote:
> > >> +    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a S=
elf>
> > >
> > > Sorry, can you explain to me what the semantics of this are? Does thi=
s
> > > create a Page reference that is not lifetime-bound to the PageSlice?
> >
> > This creates a Page reference that is tied to the lifetime of the `C
> > struct page` behind the PageSlice buffer. Basically, it's just a cast
> > from the struct page pointer and does not own that resource.
>
> How is the Page reference tied to the lifetime of the C "struct page"?
>
> I asked some Rust experts to explain to me what this method signature
> expands to, and they added the following to the Rust docs:
>
> https://github.com/rust-lang/reference/blob/master/src/lifetime-elision.m=
d
> ```
> fn other_args1<'a>(arg: &str) -> &'a str;             // elided
> fn other_args2<'a, 'b>(arg: &'b str) -> &'a str;      // expanded
> ```
>
> Basically, my understanding is that since you are explicitly
> specifying that the result should have lifetime 'a, but you are not
> specifying the lifetime of the parameter, the parameter is given a
> separate, unrelated lifetime by the compiler? Am I misunderstanding
> how this works, or is that a typo in the method signature?

No, you are correct. The signature is wrong and lets the caller pick
any lifetime they want, with no relation to the lifetime of the
underlying `struct page`.

From a C perspective, what are the lifetime requirements of vmalloc_to_page=
?

> > >> +fn to_vec_with_allocator<A: Allocator>(val: &[u8]) -> Result<Vec<Pa=
geSlice, A>, AllocError> {
> > > Do I understand correctly that this can be used to create a kmalloc
> > > allocation whose pages can then basically be passed to
> > > page_slice_to_page()?
> > >
> > > FYI, the page refcount does not protect against UAF of slab
> > > allocations through new slab allocations of the same size. In other
> > > words: The slab allocator can internally recycle memory without going
> > > through the page allocator, and the slab allocator itself does not
> > > care about page refcounts.
> > >
> > > If the Page returned from calling page_slice_to_page() on the slab
> > > memory pages returned from to_vec_with_allocator() is purely usable a=
s
> > > a borrow and there is no way to later grab a refcounted reference to
> > > it or pass it into a C function that assumes it can grab a reference
> > > to the page, I guess that works.
> >
> > Yes, I think that is the intent. I appreciate your help in pointing out
> > the issues with using refcounts in slab memory pages. As you can see,
> > page_slice_to_page() only returns a Page reference (not a refcounted
> > Page). Hopefully that addresses your concern?
>
> Does Rust also prevent safe code from invoking inc_ref() on the
> returned Page reference? Normally, the AlwaysRefCounted trait means
> that safe code can create an owned reference from a shared reference,
> right?

In principle, no, you could invoke inc_ref() directly. But the correct
way to do it would be to use ARef::from(my_ref) to obtain an actual
refcounted reference.

Alice

