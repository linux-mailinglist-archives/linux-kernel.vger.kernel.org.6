Return-Path: <linux-kernel+bounces-416760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AD9D49C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE841F22675
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7F1CB304;
	Thu, 21 Nov 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ab6846RP"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB814EC55
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180759; cv=none; b=t0CBfV/DUKx8xJDggWWQJwHd7FFQqSgp0oDvE2mkZzUZdhI2TvXDsl4EPSWWC+/1zsaUdnv9WUJaVxQVpbRVCdDGjO6ThX17Fkv2E17aR3/OhBt4XR7ePjoSqT/iWpabCoUOdjWMFVVUeNPv3/HRw3nUVKx8g/nZnNE88Z8ZRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180759; c=relaxed/simple;
	bh=i7xmK3YVlKL/O5yIbMRtZZ8LGVkx9HsSeFqjmyzHI0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmMJenjHd9S8LHWqn6tI6edcPhk6p4N4u6QG1C8e/v9UlY2a4Fj+mjqhjYFFZO2EvlbfhSnPqRwYhrqIprVOgxp2J0zHiaenv8GtNsTEtBxYjbLa23EiseEtn8Xp4fpn4MXuaTktT6I7fSvIWK+xdzNWywhullAJa37Ix5Qwnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ab6846RP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382325b0508so468928f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732180756; x=1732785556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWnOXVmJjdtAdRRd+DO279ItwAu/YGVGHFICEKvN/5c=;
        b=ab6846RPA1Ik76vX1IkeJB48ruJOivNt1y8ej3LlDj4TID2+i7QO1I3EAtgBk4Pjmc
         kDjeGykvxX1/MIxC/BsmjHwLH9K/UjhvFlI3Y3Sue+lyK4b/2ls4fI7Cv553Gbib+8ef
         qM4eIaQlTAOwYqnHmO1Hbn2lItkXKgDeNI3/rv+PyVEVf7nJ8rET2i3s4K+aMZsdQclQ
         KsDUOeqM9M21/c4CTb40PTgoiqqvtHU+Wk4S70q6v8ay1XZzwYYAq7MYeKB6PLSW9yR0
         42l5pFqXGEYaUIMko2Y/wDrsZ+N6ttU93jN0ESl/I/882BBMY3FT3rOvc+fiam9KuY02
         hiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180756; x=1732785556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWnOXVmJjdtAdRRd+DO279ItwAu/YGVGHFICEKvN/5c=;
        b=h/kGA8XRDxgtJLByHmkyz81SGfvGKLyPqKJJWlqtOmi8mXyJW6J/0gSR26UFTGvI5G
         olggx+6vQe9Ev5HgFkJSzuc01YcwY2sA458jnKEi6s4/9cch1ebyprj3FdNmosZsuXZy
         QxWLBcQP8z4KZE8rPmP0c1Hz67uxAfDbeLIWlBlCy2yNST1CDiD73CXVAQ7YensIKo4y
         dZvQvzt7+MQFapSJJUm/EzWVyjCPTnECmcXQ6O1sbQSgCKjI7qOQ3Fnom5D75WfqQCzd
         UJXBL3RrjdQdGam7A+84+H7wzqzPO4FS9XE/pJDK67bWKVxbjuuiVYXl++/pxMwIJhbd
         yaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX/T66yJLMRSk4O3ytciiEp4N33lfqx6b/faTkNV5w2L8siQkz6O3Y2F9S0xOqUvjNLcP9j+KtZuQb1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSX/Xf0luMkMZ3yWgK2bU8T1tqa+/aFkeY91dq00PJS2GElvG
	td4gbYbazPmC61/OLO/yrDLmDg6Z/aJHGSDHLmDczWQ/m/037Wi0Jfc1wjfbISpd9OIqKIQW55P
	CJkQan+gPkdk7cpNL+QhQpPqDaEJJsyDG2Mvi
X-Google-Smtp-Source: AGHT+IGzd0rr0615sN3eclq4wC/2Zg2K1p0YgkP6NPZCIYdaXry1agGbeX7Pz8cePL2TH0N3TNUhjrZNX0mcB4nCfWA=
X-Received: by 2002:a05:6000:2105:b0:381:f08b:71a4 with SMTP id
 ffacd0b85a97d-38254b162f8mr3581284f8f.45.1732180756342; Thu, 21 Nov 2024
 01:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org> <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local> <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local> <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
In-Reply-To: <Zz59qgqKruqnouTl@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 10:19:04 +0100
Message-ID: <CAH5fLgiyeU9KUFqqjFDG_aouMLdRwW+hh3v6kxGoMm09B=nTTQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page mappings
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 1:24=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Nov 21, 2024 at 12:56:38AM +0200, Abdiel Janulgue wrote:
> > On 20/11/2024 19:25, Boqun Feng wrote:
> > > On Wed, Nov 20, 2024 at 05:02:14PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
> > > > > On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> > > > > > On Wed, Nov 20, 2024 at 5:57=E2=80=AFAM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wro=
te:
> > > > > > > > This series aims to add support for pages that are not cons=
tructed by an
> > > > > > > > instance of the rust Page abstraction, for example those re=
turned by
> > > > > > > > vmalloc_to_page() or virt_to_page().
> > > > > > > >
> > > > > > > > Changes sinve v3:
> > > > > > > > - Use the struct page's reference count to decide when to f=
ree the
> > > > > > > >    allocation (Alice Ryhl, Boqun Feng).
> > > > > > >
> > > > > > > Bleh, this is going to be "exciting".  We're in the middle of=
 a multi-year
> > > > > > > project to remove refcounts from struct page.  The lifetime o=
f a page
> > > > > > > will be controlled by the memdesc that it belongs to.  Some o=
f those
> > > > > > > memdescs will have refcounts, but others will not.
> > > > > > >
> > > > >
> > > > > One question: will the page that doesn't have refcounts has an ex=
clusive
> > > > > owner? I.e. there is one owner that's responsible to free the pag=
e and
> > > > > make sure other references to the page get properly invalidated (=
maybe
> > > > > via RCU?)
> > > >
> > > > It's up to the owner of the page how they want to manage freeing it=
.
> > > > They can use a refcount (folios will still have a refcount, for exa=
mple),
> > > > or they can know when there are no more users of the page (eg slab =
knows
> > > > when all objects in a slab are freed).  RCU is a possibility, but w=
ould
> > > > be quite unusual I would think.  The model I'm looking for here is =
that
> > > > 'page' is too low-level an object to have its own lifecycle; it's a=
lways
> > > > defined by a higher level object.
> > > >
> > >
> > > Ok, that makes sense. That's actually aligned with the direction we a=
re
> > > heading in this patch: make `struct Page` itself independent on how t=
he
> > > lifetime is maintained. Conceptually, say we can define folio in pure
> > > Rust, it could be:
> > >
> > >      struct Folio {
> > >          head: Page, /* or a union of page */
> > >     ...
> > >      }
> > >
> > > and we can `impl AlwaysRefcounted for Folio`, which implies there is =
a
> > > refcount inside. And we can also have a `Foo` being:
> > >
> > >      struct Foo {
> > >          inner: Page,
> > >      }
> > >
> > > which doesn't implement `AlwaysRefcounted`, and that suggests a
> > > different way the page lifetime will be maintained.
> > >
> > > > > > > We don't have a fully formed destination yet, so I can't give=
 you a
> > > > > > > definite answer to a lot of questions.  Obviously I don't wan=
t to hold
> > > > > > > up the Rust project in any way, but I need to know that what =
we're trying
> > > > > > > to do will be expressible in Rust.
> > > > > > >
> > > > > > > Can we avoid referring to a page's refcount?
> > > > > >
> > > > > > I don't think this patch needs the refcount at all, and the pre=
vious
> > > > > > version did not expose it. This came out of the advice to use p=
ut_page
> > > > > > over free_page. Does this mean that we should switch to put_pag=
e but
> > > > > > not use get_page?
> > > >
> > > > Did I advise using put_page() over free_page()?  I hope I didn't sa=
y
> > >
> > > We have some off-list discussion about free_page() doesn't always fre=
e
> > > the page if you could remember.
> > >
> > > > that.  I don't see a reason why binder needs to refcount its pages =
(nor
> > > > use a mapcount on them), but I don't fully understand binder so may=
be
> > > > it does need a refcount.
> > >
> > > I don't think binder needs it either, but I think Abdiel here has a
> > > different usage than binder.
> > >
> > > >
> > > > > I think the point is finding the exact lifetime model for pages, =
if it's
> > > > > not a simple refcounting, then what it is? Besides, we can still
> > > > > represent refcounting pages with `struct Page` and other pages wi=
th a
> > > > > different type name. So as far as I can see, this patch is OK for=
 now.
> > > >
> > > > I don't want Page to have a refcount.  If you need something with a
> > > > refcount, it needs to be called something else.
> > >
> > > So if I understand correctly, what Abdiel needs here is a way to conv=
ert
> > > a virtual address to the corresponding page, would it make sense to j=
ust
> > > use folio in this case? Abdiel, what's the operation you are going to
> > > call on the page you get?
> >
> > Yes that's basically it. The goal here is represent those existing stru=
ct
> > page within this rust Page abstraction but at the same time to avoid ta=
king
> > over its ownership.
> >
> > Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
> >
>
> Could you use folio in your case? If so, we can provide a simple binding
> for folio which should be `AlwaysRefcounted`, and re-investigate how
> page should be wrapped.

Well, regardless of that, I do think it sounds like Owned / Ownable is
the right way forward for Page.

Alice

