Return-Path: <linux-kernel+bounces-422810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBF9D9E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E2A282E98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16F1DF243;
	Tue, 26 Nov 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+K6b2/u"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA38831
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653844; cv=none; b=UP2sCWlW/2mBehvHT79qdVxsPgmStYfh6m8v1+D6YzfZjzUa1RA4qOGWsz8gQGCFRv1TkyxYW2By0B0N1sB1irnRVOnLE7bcgpMvDeAo6d1QuId91Uv05umXBJ+a7+ZIiCAJb8m8fvZWqfnLWrxnkMP6mngktNXagO7hCAMYdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653844; c=relaxed/simple;
	bh=eUMuQ9gASBpqqRZLzUIvbphLbyhWIfaPRCa8oZFZqbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ths6jOaGQQtnUFTD/HWqKlOUz6XEeR0DOMM4ZrErexHommjTdwOVnxPA7jnBPl3gsl2BvLL4k3aLr0MfE2XeceSJUxEola7Zt7wNbYGf3yQKmfY8+jXjdUwlfw0jtrgwRb9PVDR6ceQbGh1QQU6dEXBxH3Fd15xom580MPZVUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+K6b2/u; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so54a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732653841; x=1733258641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Knumxb+ipa3/QWPd1lEfjlfQFOTdrGiNogqlwZ9Cmps=;
        b=f+K6b2/us9NIa8jFHAYhSxzpIu1dSgGnkwhG54PAu1WQz/xim8+wB7MuWMPFednuqb
         xPFwK4SvaljWSKO46GR6RlOd4n/lrWQ4BFDrqWi9ejLGp76LbD10DnXoHQ94pualFh7q
         3fgynEZUTRzK85GnJTacGNFkNk515miDdz8ZxwuqlKHEUL3+mooOqrRTizG9rBZ490en
         xAPq5GD02jIrOOKECMUMuf/5WKC1BgdjKJ91mwRhzU3d04/cnjj06yzzGv51FUaoQji8
         RI9c4hpm5SXvXQg5GfzY+lZFVjuswu0SauFW/83aGOej3UslsTp+Ad3HUjHocjjHJxJ5
         884Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732653841; x=1733258641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Knumxb+ipa3/QWPd1lEfjlfQFOTdrGiNogqlwZ9Cmps=;
        b=CTjAbwGkYTdoF95U0HDNLPfSIBUMWNMteelQCSooeiFEVlJjhpE8g9lRgI27LdAppV
         z+BlnQZY9cuci76Wg+wRkZ6MvmZhcA3dqMJxY9sOdv+SngKx36IDs3RXvNLaTK/ydqsz
         UXzzk3z4tRZ/HgYkBN0rICNQmwse79ehmzOGIU8uZoMqe0+JMZfTD1WljyW7wUzPH5ox
         V0d2u+Zxk3Qia/T7NDCS3klytZifxjWhaB/B37MPJ3v74pY60Vp6DpZVxa7UyFgP084e
         YbtIfea+cBwVBHoNBxHx8g8v1Av09zmT5WfGzMeY5PAlVtZttkbMY+GpRSL6khW2q3fl
         TB5w==
X-Forwarded-Encrypted: i=1; AJvYcCX/NOm2G65iL5WMRPDuA2C71xqnxjHof4jsPjhYAHCDPgfVOZgiJ+VLt7Xy3Zn7dQVHhYtX4CIlidVIAXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcsVbnGZz/gkH2EhzrN7hDIY4i2mX+OqooC3DAN7S5ABQvNrI
	dvDJ1VrS4DZID+Qvk1Qu1T8P3chrBEApMhDhBtnJuV1DxKqBOKiJfL+dSZKFrbGQHy4vSsYYvPr
	14XRZ4mnapWx/wwYpxryz743xj7yXP/cb8v45
X-Gm-Gg: ASbGncvz5vLGqealoyiTdDMmxQKevmUK6Bou8zNLXiJQPrSPsNzIOMwlzFFhCMZ1jPM
	yvu9BVSq/jjZV62O3lEcUpPieRO+mUdsWLWAYJUCqxFKwywg1zHnalGegwdc=
X-Google-Smtp-Source: AGHT+IGWR89iYFiAgSPZ12ezMJJKqp8c3+6xErZv5QF6yYfwDocCF/qoTNo0Vi8c1TDce/+jAUrcLpa9cJl3TwT6E6g=
X-Received: by 2002:a05:6402:1c91:b0:5d0:3bfb:c479 with SMTP id
 4fb4d7f45d1cf-5d081abf56cmr8356a12.3.1732653840751; Tue, 26 Nov 2024 12:44:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org> <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local> <Zz4WFnyTWUDPsH4m@casper.infradead.org> <CAG48ez3YBvSQ0zHY-t8NK2RWthR-GsEv6O5pVwA44LGJaEGeSQ@mail.gmail.com>
In-Reply-To: <CAG48ez3YBvSQ0zHY-t8NK2RWthR-GsEv6O5pVwA44LGJaEGeSQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 21:43:24 +0100
Message-ID: <CAG48ez2Sn=w=e9AoNC6giMHP=ndRa0aYNn5oO3VeYBFC8Pg60A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page mappings
To: Matthew Wilcox <willy@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:31=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Wed, Nov 20, 2024 at 6:02=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> > On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
> > > On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> > > > On Wed, Nov 20, 2024 at 5:57=E2=80=AFAM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > > We don't have a fully formed destination yet, so I can't give you=
 a
> > > > > definite answer to a lot of questions.  Obviously I don't want to=
 hold
> > > > > up the Rust project in any way, but I need to know that what we'r=
e trying
> > > > > to do will be expressible in Rust.
> > > > >
> > > > > Can we avoid referring to a page's refcount?
> > > >
> > > > I don't think this patch needs the refcount at all, and the previou=
s
> > > > version did not expose it. This came out of the advice to use put_p=
age
> > > > over free_page. Does this mean that we should switch to put_page bu=
t
> > > > not use get_page?
> >
> > Did I advise using put_page() over free_page()?  I hope I didn't say
> > that.  I don't see a reason why binder needs to refcount its pages (nor
> > use a mapcount on them), but I don't fully understand binder so maybe
> > it does need a refcount.
>
> I think that was me, at
> <https://lore.kernel.org/all/CAG48ez32zWt4mcfA+y2FnzzNmFe-0ns9XQgp=3DQYeF=
pRsdiCAnw@mail.gmail.com/>.
> Looking at the C binder version, binder_install_single_page() installs
> pages into userspace page tables in a VM_MIXEDMAP mapping using
> vm_insert_page(), and when you do that with pages from the page
> allocator, userspace can grab references to them through GUP-fast (and
> I think also through GUP). (See how vm_insert_page() and
> vm_get_page_prot() don't use pte_mkspecial(), which is pretty much the
> only thing that can stop GUP-fast on most architectures.)
>
> My understanding is that the combination VM_IO|VM_MIXEDMAP would stop
> normal GUP, but currently the only way to block GUP-fast is to use
> VM_PFNMAP. (Which, as far as I understand, is also why GPU drivers use
> VM_PFNMAP so much.) Maybe we should change that, so that VM_IO and/or
> VM_MIXEDMAP blocks GUP in the region and causes installed PTEs to be
> marked with pte_mkspecial()?
>
> I am not entirely sure about this stuff, but I was recently looking at
> net/packet/af_packet.c, and I tested that vmsplice() can grab
> references to the high-order compound pages that
> alloc_one_pg_vec_page() allocates with __get_free_pages(GFP_KERNEL |
> __GFP_COMP | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY, order),
> packet_mmap() inserts with vm_insert_page(), and free_pg_vec() drops
> with free_pages(). (But that all happens to actually work fine,
> free_pages() actually handles refcounted compound pages properly.)

And also, the C binder driver wants to free pages in its shrinker
callback, but those pages might still be mapped into userspace. Binder
tries to zap such userspace mappings, but it does that by absolute
virtual address instead of going through the rmap (see
binder_alloc_free_page()), so it will miss page mappings in VMAs that
have been mremap()'d (though legitimate userspace never does that with
binder VMAs) or are concurrently being torn down by munmap(); so
currently the thing that keeps this from falling apart is that if page
mappings are left over somewhere, the page refcount ensures that this
userspace-mapped page doesn't get freed.

(I think the C binder code does its job, but is not exactly a great
model for how to write a clean driver that integrates nicely with the
rest of the kernel.)

