Return-Path: <linux-kernel+bounces-272401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFD945B47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6486B21D11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDF1DB43C;
	Fri,  2 Aug 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXpxuY05"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507B1DAC78
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591649; cv=none; b=BTGroA0GiyhwjevaPHRbzZ2+/YjITgCoIGgTrosW3dHVPpu9fTguwEAdFUHr4+9rjejHpJIWMYSnT+vkhiVWc0yiFUMg2VXwqX6E6yxQa+BM922qZux6T1lbrGPi3aqzBJXDsIYiipJDztE9ki27RV7SQFEpgdpmtJg6v44PhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591649; c=relaxed/simple;
	bh=u+BQdwSK8imeK2KT1z1hjqymdfIaAYLVmkvghpNXsno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ/BxdiOPNsSgcrv8FZ3i24DH8QHh4Kx5hdbItM21uRSkPKrIKy3d+PVY4gAV7ngi3qmk7kC0ckQXVgHziPQucQ8YHDBb+InHzo/QEYFAKOKRibsM0Yd6qRfP8s6B3W89eTLYDIpsH6fpUDS+7VACJswvTQVEre9EYxDk3icklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXpxuY05; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3683329f787so4274387f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591646; x=1723196446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3cnmNQwU8pb9rtU5fDhbpatDtKkxxtawqVfHyOA0XM=;
        b=qXpxuY05QFs9Hk6/DGl6fSPx7CIWscO0nYqTwpR8h/649CCKfsUq+acCfwjgl884jH
         j4r8dPhmfeqwh/jRFpDGCw1pQNPGdNJL6z8BrmLPpgJLKH5k2KrTrV3NeZUil4PbAFzE
         p6pKYRK6/Q7NustmR9FNRVNKnWqz6oQ+Dji2QyI57vN1rhU8F/gPs3rp7j4RRzRQzA46
         nqHfu/teeXw/pw5tbYILCuJmWuk0C6qiM5DTiDKvBD/Nn4orLyeIGJxkSqXMXnAL7z0S
         kk6XhZquxlK3JjtnDPCTDtAUgQHxKUQePJ8OdJ5kc1bB9rscGYZgA093109eOcvCGuxH
         Wy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591646; x=1723196446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3cnmNQwU8pb9rtU5fDhbpatDtKkxxtawqVfHyOA0XM=;
        b=AGaRcrWjKstNBei5Zhaw/pPVwaJJnuKwbMkg0ra6di+Hxhe7QuA6N1AFY3TTRY9hf5
         PYFULMfwC6NLgJBsWtBt6mTh1r+5aCfTRMHYcJtdne+3cvqcbxjqYIlnAsNmlWhDMMh1
         dUxiA7AO6aFdLWD3nNJTd8I1+wwEpGvMPsgQZzPQBJb6pGpQxjDw+dKu+mBnNZuBqf9h
         O9xGfwTetR4pu0YMNWsHzzRUh67L7UmFz3CSza0Mfi4HzZtm1zk6uRmPi0dOqUZGkr57
         JT65lBU4BKmPCBD7zdYE8sQCz54wKnHaJzeBnmHZTMa5GfNCsB0MhRLX02l3Njd2Gtck
         XqVg==
X-Forwarded-Encrypted: i=1; AJvYcCWv0u6HuGZpYo56En2Bmt2x2ltnH+sReLhyEtHUtNFpGZS9WfAX56nQ7chNxy0tSIc+o2543NkxfiIzUO4QFiM8j87Wk41sEI5NqgY4
X-Gm-Message-State: AOJu0YxoCI4hUM0Xtwoy6eQOYJ6aA+69z1cfwLEPlzDvdKq3djbN4U+G
	PmADG6Qfr3uPG3VvcgFgjoWB0vMSytB+zlhawv8r81fD/qzFMw7eAYlXnjhIVkVdkTi//sEiITl
	j8z/xGE92JAjhwsluSguVDPc5rg/SiKo8Y9CM
X-Google-Smtp-Source: AGHT+IHM0pPYtPqBjGxEPDHbGbmOT0OVxMOnrmAq18Ps5yNxY4TkpjbzkRsvr91o1g46ECl3PRnOq2ueiV5z85Rov2I=
X-Received: by 2002:a5d:664c:0:b0:368:6650:fd16 with SMTP id
 ffacd0b85a97d-36bbc1bcea9mr1780954f8f.38.1722591645457; Fri, 02 Aug 2024
 02:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-vma-v4-1-091a87058a43@google.com> <7f31fa8b-d788-4067-b296-9cdf23df65c7@proton.me>
In-Reply-To: <7f31fa8b-d788-4067-b296-9cdf23df65c7@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Aug 2024 11:40:33 +0200
Message-ID: <CAH5fLggpERviqXQDBwPOqgMieXKOvoPi7xcq4JcO9DJ2ZFqDOQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: mm: add abstractions for mm_struct and vm_area_struct
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

On Fri, Aug 2, 2024 at 11:39=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 02.08.24 09:38, Alice Ryhl wrote:
> > This is a follow-up to the page abstractions [1] that were recently
> > merged in 6.11. Rust Binder will need these abstractions to manipulate
> > the vma in its implementation of the mmap fop on the Binder file.
> >
> > This patch is based on Wedson's implementation on the old rust branch,
> > but has been changed significantly. All mistakes are Alice's.
> >
> > Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@goo=
gle.com [1]
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> I have one nit below, with that fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > new file mode 100644
> > index 000000000000..ec8cadb09626
> > --- /dev/null
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -0,0 +1,204 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Virtual memory.
> > +
> > +use crate::{
> > +    bindings,
> > +    error::{to_result, Result},
> > +    page::Page,
> > +    types::Opaque,
> > +};
> > +
> > +/// A wrapper for the kernel's `struct vm_area_struct`.
> > +///
> > +/// It represents an area of virtual memory.
> > +///
> > +/// # Invariants
> > +///
> > +/// * If the caller has shared access to this type, then they must hol=
d the mmap read lock.
> > +/// * If the caller has exclusive access to this type, then they must =
hold the mmap write lock.
> > +#[repr(transparent)]
> > +pub struct VmArea {
> > +    vma: Opaque<bindings::vm_area_struct>,
> > +}
> > +
> > +impl VmArea {
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, and that the mmap read lock
> > +    /// (or write lock) is held for at least the duration of 'a.
> > +    #[inline]
> > +    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struc=
t) -> &'a Self {
>
> I think this also should be named `from_raw`.
>
> I took a look at your conversation with Christian Brauner and I
> personally don't see the benefit of `File::from_raw_file` over
> `File::from_raw`. To me it's clear that this function takes some raw C
> structure that represents a `File` and turns it into a `File`.
> In the situation where there are multiple ways of creating something
> from different C structs, I think we should include the name. But if
> there is only one possible struct, then the name should be `from_raw`.
>
> Do you think we should re-open that discussion/start a new one on a
> naming convention for this?

Oh, I actually intended to rename it here too. I just forgot that
VmArea also had a from_raw.

Alice

