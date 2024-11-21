Return-Path: <linux-kernel+bounces-417082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53D9D4EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF4281CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65411DBB31;
	Thu, 21 Nov 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqpPkR3v"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA71CD1EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200001; cv=none; b=FVLQclQdFVfkcz55STImCxqIjrGsPzK4WcOwfCjiXVNGGmoEiX3Hzl57M945/i4sEKqRPNxsG/PBc+OuKDkrQymUdG7YTSBvFOcShqmvaLNq75AFAkAzDvVDyK5Uy5hOkcCiv3ITAK9D5w9JPCyZa+AzLy4q2XrWDElRoc967EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200001; c=relaxed/simple;
	bh=nO+3nDyIudH0dDMPwsn4/5w94K4SpantV8zCiRa35TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR3oC0nzcV16Y6h2nqyx6aETadd6EsP5ZgnBUxYCHO4XV9//H1WaxAljnoE2lT4N7Slr3Z0bW8Dv3xILzgM/ozB3yJcs+Ic5J+KycR2PptsTCuPkRGSWLoAgHFJ9LJBU3j0J7ePZH2KuM7kWpG8Jhw8GqOIqCTNJWHfKMq0xVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqpPkR3v; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43158625112so8280515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732199997; x=1732804797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRJx2WZ5u5Th7dWmrrUrE1cesu1hkjYpX0gzcJWX5Y4=;
        b=pqpPkR3vK3iG2zgt0Fev4luKmvZQNjp1VTaM9JSOzyFKq/Lp4HdYuP5eTDfyFt8UKQ
         Y6AoMgb8/bo7OPWbOoEt2x0YnELwdlPBDvEHGHeG/UjLCwc1p+qSJUkQV7dQ1okoTeII
         5sHDImxa4D+L6OPO218ZqY2j4A5EEK3NII2eGx1rxG7eDibgmZvjnmjmeeUikzGF8dri
         +qaQ/o11HT8gWzsi9rcR73hjB8WKV8aUNrrl1jpPnQBFE96p6LVuc9tTThDiJzdDKjqF
         8PLsO8g49WFiGUfOibzPNWX27C8hHhss3NT8HcnePU+4roPMYTbKmtiAc5jfk4riYnIB
         UhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732199997; x=1732804797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRJx2WZ5u5Th7dWmrrUrE1cesu1hkjYpX0gzcJWX5Y4=;
        b=AIA4x2I9g1eNaFlwVzwXey/qJ8UWmKfgc8zJUXjjwdMDH+ZqsEoah9tJI4h9Irr//f
         ILfcLFpmqtd021WXi4AobDvG0os9nKviCD6Je/BQDo+TzYD1eZCSzuWl8RMNvuJJvlST
         wS56NFXajPBwW+wn2wtBI1xiP1VB6slG785yycS1LJ40ndHlnECrcUXm36Cxq5m6k3gQ
         H6KsTuD2SBWaIER6SKteNrWn5xphD9DTkv55JvQ/1UMPuJUL3Pj+b1G3WmgObZJKvSQ3
         mt91teaV90hxHo7n6uat/XxGJma2a3WgyGmBKpM60yXUqfUGpVJKMtg/5CJY15zKCg06
         HD+w==
X-Forwarded-Encrypted: i=1; AJvYcCVtYEIJjnk4E9H6T3UElc1gIAn6atQ7IMhy8uc4kNBk+SAQbm7l16SAiJOBsAoktMY2+cDoI2mZSd5Cclk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKdkWmCtVUDm1VPm86Os34jD0KJQNA94RAKkn09VDFabVwAjE
	Ujac+si4isy1vI5/bYYXQvUxYsKt+JaJqn0A8/vhcSwAD/12ZqjYdHLRsO1nQY/ZCbFtVS6zWP+
	WP40TFJ3PqxqF+ZOw5BdOprWwzHo2/l9QDdkN
X-Gm-Gg: ASbGnctg8BME4RgY+GV31XS+EdULm9Sru7H309sIMoFN6nDVS46FRQ53noydgsfinmk
	SZJRWHccd+g22IZuQJkRyDNyyIhKCaKKrjmAC5cDOF3NgDglgtP9bDOZ/sGQGog==
X-Google-Smtp-Source: AGHT+IEovcTS4X7zk9GHA36taO4imLGGYuJ2IpetSRs95zNJpNYqDqE1eWMgvsHvtxUKoS5Hl2pXCf075S4vMEjTkXU=
X-Received: by 2002:a05:6000:4410:b0:37c:d244:bdb1 with SMTP id
 ffacd0b85a97d-38254afcb4emr3878408f8f.26.1732199997420; Thu, 21 Nov 2024
 06:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-2-eb31425da66b@google.com>
 <c26a63a3-0f1e-467d-b24f-3963e5e4e13d@lucifer.local> <CAH5fLghdeBvbtC+aPq0mSr1io+DUt-J54zYagys63cK-4tictQ@mail.gmail.com>
 <d2d1f25c-780d-4103-aeb1-461adc4940c3@lucifer.local>
In-Reply-To: <d2d1f25c-780d-4103-aeb1-461adc4940c3@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 15:39:45 +0100
Message-ID: <CAH5fLgijS7JOO==JQegexPEgx3hs8hFDcQqFa4L50F1LdfZJJQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] mm: rust: add vm_area_struct methods that require
 read access
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 1:50=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Nov 21, 2024 at 11:23:39AM +0100, Alice Ryhl wrote:
> > On Wed, Nov 20, 2024 at 8:07=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Nov 20, 2024 at 02:49:56PM +0000, Alice Ryhl wrote:
> > > > +    #[inline]
> > > > +    pub fn end(&self) -> usize {
> > > > +        // SAFETY: By the type invariants, the caller holds at lea=
st the mmap read lock, so this
> > > > +        // access is not a data race.
> > > > +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_=
1.vm_end as _ }
> > > > +    }
> > > > +
> > > > +    /// Unmap pages in the given page range.
> > >
> > > This needs some more description, as 'unmapping' pages is unfortunate=
ly an
> > > overloaded term in the kernel and this very much might confuse people=
 as
> > > opposed to e.g. munmap()'ing a range.
> > >
> > > I'd say something like 'clear page table mappings for the range at th=
e leaf
> > > level, leaving all other page tables intact, freeing any memory refer=
enced
> > > by the VMA in this range (anonymous memory is completely freed, file-=
backed
> > > memory has its reference count on page cache folio's dropped, any dir=
ty
> > > data will still be written back to disk as usual)'.
> >
> > Sure, will add that to the docs.
>
> Thanks, I assume you mean this comment, which will form part of the docs?=
 As
> here we should at least replace the 'unmap' with 'zap' to avoid confusion
> vs. munmap().

Yes. Comments with three slashes are rendered in the html documentation.

> > > > +    #[inline]
> > > > +    pub fn zap_page_range_single(&self, address: usize, size: usiz=
e) {
> > > > +        // SAFETY: By the type invariants, the caller has read acc=
ess to this VMA, which is
> > > > +        // sufficient for this method call. This method has no req=
uirements on the vma flags. Any
> > > > +        // value of `address` and `size` is allowed.
> > > > +        unsafe {
> > > > +            bindings::zap_page_range_single(
> > >
> > > Hm weirdly I see this in rust/bindings/bindings_generated.rs but not =
in
> > > rust/helpers/mm.c is this intended?
> > >
> > > Is this meant to be generated _from_ somewhere? Is something missing =
for
> > > that?
> >
> > The bindings_generated.rs file is generated at built-time from C
> > headers. The zap_page_range_single is a real function, not a fake
> > static inline header-only function, so bindgen is able to generate it
> > without anything in rust/helpers.
> >
> > > > +                self.as_ptr(),
> > > > +                address as _,
> > > > +                size as _,
> > > > +                core::ptr::null_mut(),
> > > > +            )
> > > > +        };
> > > > +    }
> > > > +}
> > > > +
> > > > +/// The integer type used for vma flags.
> > > > +#[doc(inline)]
> > > > +pub use bindings::vm_flags_t;
> > >
> > > Where do you declare this type?
> >
> > It's declared in include/linux/mm_types.h
>
> I meant from a rust perspective, but I guess bindgen handles this?

Yes, anything in `bindings::` is output from bindgen based on C headers.

Alice

