Return-Path: <linux-kernel+bounces-417424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893B9D53DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E712842C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBC1DC05D;
	Thu, 21 Nov 2024 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xvRLxUax"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AD11D9A40
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220288; cv=none; b=Sqefm4XsinaqMTDJYo57uJb31Jlvt3sXwDm+djCIxyYavvUurPlj8w5PducnVbEQDKQ365pDPKzDZrHyZKOXjCX4BctX5X9FM9Sm6fkLVfon5wEqM9jca0C0Sl55jwXfF8c3nrRghSsszQ4IYdPznwkY0+w5t0iPjF0VYOId/Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220288; c=relaxed/simple;
	bh=98cSwaFxCRGFRUwjUPD3e4lx7JgzTQnwUJ6h05gwh4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxV4IzidtJoVFhYIZWMmu0IjuBNSR/hU+EqpF+mCjNE3LfCKE2vLgFgqLN/ISqc2jBXuDg3gERIILW+cBn02A/XfzVD1J+N2K0iRc6y23QMru9wX1zfjlx2VE+uXAFm9QyIOYeFf/TUtyHdbqtVlhDeu41wVycWnSO5F8nZ94sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xvRLxUax; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d00ecd97beso1903a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732220284; x=1732825084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsRAQ6t08WPFqqtrK9Y/yi/Kj5TOA65Z3KS9Ukbgptk=;
        b=xvRLxUaxk+JxLRSC9i3a8sESZK4SaCTtKc9guTb2u9Rd3ZMoSJC+AkGoTnG4ZoxJwz
         8ZdMIiZ0PzccwPopxdw+i4IkpUyZlzd/o933LHrNod9kXXQGF9aM82VCDVG7OCqoq4ZJ
         5SmJKXT9s4xyQyegwicahiAc8zVE0Vl9MuajGkW6hwqSGCb3qt+yTounm8C+EY/bCHge
         vNimrBZxA2sQcXT0zbr4JdUJUioQG9pmHouCWSzu8l1rWvVR7lYkfte6mAsT2aooToqC
         aMT55cFpyd+aLxajvwynheARA0AsBAsIhb5U2cQ4R45oKpFEk7uRuMdsuNb2fHGuN9AR
         N6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220284; x=1732825084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsRAQ6t08WPFqqtrK9Y/yi/Kj5TOA65Z3KS9Ukbgptk=;
        b=C+S0O9JPHTz33H8V/M7GwuG128aVih4SfKGNbtgqi+09pb5kNrZFkdwpl7/met043t
         nn5GrSS41WKw8QQjl+KAlBsWBtkGRcngHFdOIXrfoAPR3UGmGTD4BoJy3+gmrMvG+yEm
         V+VhdRCtbRCt2Z+3siPey2u+k/5wyKP61lDiDlwa19P7pznQ3F3QZbfZQyzo/d6XhDIb
         Idqy7tzlAq5gUxdMUE8cI0d6SkeFWZ6bqJrAtv1SBbwvrc2BQAG0z/TB2eqKsuuFMITb
         Nmz0lBQ/HzKIj99KyLBnc8v6HdYhfN+5qk4SFJMw4QB5yiVX1NLiqm4Jmcrt9/FaY3Gc
         sjyw==
X-Forwarded-Encrypted: i=1; AJvYcCWALaujWX8XiTS64tvdP+Rz5sI0qLZxO73YN1xpXth7vdsEcuDcb/9KJBa7Sj4jdYCklv9H3+mC04e/BrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ivZgOJGXjNOMSdUUxF/fAACBPcRzGB2iwg7tKIkdndmNHPWG
	zar0D5obOLTD38fCVRXGp7tapLULAm0zo24tfCy/4OwAG7HU8c8Kn1LQikXPr6+XmSHd4gfl6u1
	Mc1k/gGaZgI+Y2ArQkYpR50OWVRKpKSHLQ1m8
X-Gm-Gg: ASbGnct8LqxE1rpUeeHCmgccza61NPcr4aeAEJ1DSlaGhundEsZwCDWZDjRBeuTx+aP
	/mUc3Z15bAxMhGj9V/p9FytqNBxxuOWNacECHX03HjS1nnvym0g9cBKAEKMU=
X-Google-Smtp-Source: AGHT+IFvnfJzTTJ/+eR3Vxjo7zD5SinHcpQMhmMje2i6LAznZGVS+bpiK7Ig3Hi4h3GcgmluFEyuti7p0HNlUHLa6I0=
X-Received: by 2002:a05:6402:5158:b0:5d0:a5a:6ffc with SMTP id
 4fb4d7f45d1cf-5d01e4fe710mr7807a12.6.1732220284214; Thu, 21 Nov 2024 12:18:04
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-3-abdiel.janulgue@gmail.com> <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
 <43a07c04-2985-4999-b6d6-732794906a36@gmail.com>
In-Reply-To: <43a07c04-2985-4999-b6d6-732794906a36@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 21 Nov 2024 21:17:28 +0100
Message-ID: <CAG48ez1uzoEcsFG7Tsfj2WCXor9-mhffoWO8VFoit3j_mUC7-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page mappings
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:56=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
> On 19/11/2024 19:07, Jann Horn wrote:
> >> +    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Sel=
f>
> >
> > Sorry, can you explain to me what the semantics of this are? Does this
> > create a Page reference that is not lifetime-bound to the PageSlice?
>
> This creates a Page reference that is tied to the lifetime of the `C
> struct page` behind the PageSlice buffer. Basically, it's just a cast
> from the struct page pointer and does not own that resource.

How is the Page reference tied to the lifetime of the C "struct page"?

I asked some Rust experts to explain to me what this method signature
expands to, and they added the following to the Rust docs:

https://github.com/rust-lang/reference/blob/master/src/lifetime-elision.md
```
fn other_args1<'a>(arg: &str) -> &'a str;             // elided
fn other_args2<'a, 'b>(arg: &'b str) -> &'a str;      // expanded
```

Basically, my understanding is that since you are explicitly
specifying that the result should have lifetime 'a, but you are not
specifying the lifetime of the parameter, the parameter is given a
separate, unrelated lifetime by the compiler? Am I misunderstanding
how this works, or is that a typo in the method signature?

> >> +fn to_vec_with_allocator<A: Allocator>(val: &[u8]) -> Result<Vec<Page=
Slice, A>, AllocError> {
> > Do I understand correctly that this can be used to create a kmalloc
> > allocation whose pages can then basically be passed to
> > page_slice_to_page()?
> >
> > FYI, the page refcount does not protect against UAF of slab
> > allocations through new slab allocations of the same size. In other
> > words: The slab allocator can internally recycle memory without going
> > through the page allocator, and the slab allocator itself does not
> > care about page refcounts.
> >
> > If the Page returned from calling page_slice_to_page() on the slab
> > memory pages returned from to_vec_with_allocator() is purely usable as
> > a borrow and there is no way to later grab a refcounted reference to
> > it or pass it into a C function that assumes it can grab a reference
> > to the page, I guess that works.
>
> Yes, I think that is the intent. I appreciate your help in pointing out
> the issues with using refcounts in slab memory pages. As you can see,
> page_slice_to_page() only returns a Page reference (not a refcounted
> Page). Hopefully that addresses your concern?

Does Rust also prevent safe code from invoking inc_ref() on the
returned Page reference? Normally, the AlwaysRefCounted trait means
that safe code can create an owned reference from a shared reference,
right?

