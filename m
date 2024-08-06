Return-Path: <linux-kernel+bounces-275920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE9948BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4001C224BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474751BD50A;
	Tue,  6 Aug 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8N3Ux5V"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46FC146A6F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935107; cv=none; b=KDn15w7aBt21UGA1FcXJe/KtlngAU23Q8ro7KgiLjQAX78qjeLXL662SyDtCthYv6W7gPRPMPpnLsi0peZyPDdE0xkWRiBSsyAyYuW2kiAUHruIVEEk44Wx8eBAI0otT69VXfDkie7arjMPDwovkTnw+MMWqX7ap8gs4RKAXGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935107; c=relaxed/simple;
	bh=UCVqS60sn9LNaCSs75cAxVmBRpP/G+2QNbsQ4OV3MQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fygmu9u8pkJPE2Md6K5L9DGKjBkfgBlZKDPL02KOzQgY++cmQtDbP3S0Ep0wwpNcqTD7dsD2WwRri0h+LH2eWsDcrT45f6OFEdl5Nk9xD2mqpTghX8RDAcgjGJdgbjQRZJDREOfhEWTIrjCqVZ1XJEAGg+RBM70Z0YMpdeJYc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8N3Ux5V; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-369c609d0c7so289470f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722935104; x=1723539904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DETMGaPs2PGmqMwvCjnPO//c4goVZtDilP9QX2nQBO8=;
        b=N8N3Ux5VsnntlHSullOcM/fbBWCQAtS8fhQyTEb/ONb8yooOVnHGJMYdSeo89aEkS0
         OU5buJQE3H76Opihs3GphlLlGA6IAanBA+GE7vPiqt4EP+9/jMyOJCmOR5P5oBJNgxAt
         SVqSZO5VK5GZbPXQgR7eO0xWm1IKjbNE6YkJ35zMvVvFgr1cXd713anBCko6J/rH6MMt
         deAkl9foelfwp2nLYa9sp1VhphGktcvzUEGyMEvciySoGdJs7/hE8MOaBuGRqsS+HiXL
         k28A1h/RNJOIPw2ruJZ2RRaFVPnVajUhL27Rt+liLDl1iJaA/4+AaAwnWxMjdQHjscMX
         0K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722935104; x=1723539904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DETMGaPs2PGmqMwvCjnPO//c4goVZtDilP9QX2nQBO8=;
        b=TrRl3JAi7ePz1Azaad9ZnipMODHX8I+3jH2Y6G5ZQ6YQZo4IHTL2gF+WAtbzu2Anih
         sL1Pnpe/Jzvi8xD2qhtZAvo625OyD7NpxWFZFoH5Db6G7RaxKMWC3sggADvrR+uMxuuB
         TbikmgGQAEh3qZeAtdY6dvxiQxTLmCcs7WLUJpaVW8BI85bNz5Hj8ocFd66HPCozEq/C
         QieOBljAr2iWys+yX44oUAfPv6qTyxrrrvrFAhenMi5QkJIvDJgT6znc5C8g2csKCD9N
         iHesuDr+2G44P2d9hAaR3q098IrPun4BRHucRQi8XTRcWLjgqsdpsWFiO4+oAGc+L9+8
         QcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8rLy7qvR+wFAYHPjNWZhcYZhvEsl+u2bwr7V/gfkT62Qdy+Qq8lU6m+RICnH6AQp3yxJR1y2U5/lVWN6KgMe9UPe/t9ML6mr2TWPj
X-Gm-Message-State: AOJu0Yz+roihWQyhC3WJB8DDSJqME3g9a+2xOeJE1JFfRJNwZ0bLGb1A
	upAB3p9O7kr+Eo0GAT9MbcsbHvjY7PtnboJa5uuUnM794QVy9OgpEzdiXfLKpEIFIxYnhgeLofw
	S73d+ODQGvUbyoikUMwrojMG87xw0vN1ypLiW
X-Google-Smtp-Source: AGHT+IFINWCUgofLtvN+dIZ/17A15VOEXod/e5YskrS11F18PP1AwtyfWa99txQejYOa/nGkarLFvzgk0CyEHspmfQI=
X-Received: by 2002:a05:6000:402b:b0:368:6633:e23f with SMTP id
 ffacd0b85a97d-36bbc1a6749mr14909337f8f.38.1722935103850; Tue, 06 Aug 2024
 02:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
 <20240727-b4-rbtree-v8-5-951600ada434@google.com> <309d3d27-62d0-42b0-b50a-40692a019b40@proton.me>
 <CAH5fLgh30z2Cfixn1aC-LPp-ua46eJ+jREWDTfhMK3aqXzbt-A@mail.gmail.com> <4ef9616f-a35a-4aa2-993c-9b67f50a46ee@proton.me>
In-Reply-To: <4ef9616f-a35a-4aa2-993c-9b67f50a46ee@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 11:04:52 +0200
Message-ID: <CAH5fLgjiqOcu0JVgLze76LQDUD3KTQv9WrBy-GkMbCgVWn0xzA@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] rust: rbtree: add `RBTreeCursor`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 06.08.24 10:24, Alice Ryhl wrote:
> > On Mon, Aug 5, 2024 at 9:35=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
> >> On 27.07.24 22:30, Matt Gilbride wrote:
> >>> +        // SAFETY: `best` is a non-null node so it is valid by the t=
ype invariants.
> >>> +        let links =3D unsafe { addr_of_mut!((*best.as_ptr()).links) =
};
> >>> +
> >>> +        NonNull::new(links).map(|current| {
> >>
> >> Why would `links` be a null pointer? AFAIK it just came from `best`
> >> which is non-null. (I don't know if we want to use `new_unchecked`
> >> instead, but wanted to mention it)
> >
> > It's never a null pointer in this branch. Do you prefer an extra
> > unsafe block to call new_unchecked?
>
> No need, doesn't seem like this part is hot and this is something that
> field projections could solve.
>
> >>> +            // INVARIANT:
> >>> +            // - `current` is a valid node in the [`RBTree`] pointed=
 to by `self`.
> >>> +            // - Due to the type signature of this function, the ret=
urned [`RBTreeCursor`]
> >>> +            //   borrows mutably from `self`.
> >>> +            RBTreeCursor {
> >>> +                current,
> >>> +                tree: self,
> >>> +            }
> >>> +        })
> >>> +    }
> >>
> >> [...]
> >>
> >>> +/// // Calling `remove_next` removes and returns the last element.
> >>> +/// assert_eq!(cursor.remove_next().unwrap().to_key_value(), (30, 30=
0));
> >>> +///
> >>> +/// # Ok::<(), Error>(())
> >>> +/// ```
> >>
> >> I would put a newline here.
> >
> > Ok.
> >
> >>> +/// # Invariants
> >>> +/// - `current` points to a node that is in the same [`RBTree`] as `=
tree`.
> >>> +pub struct RBTreeCursor<'a, K, V> {
> >>
> >> I think we can name it just `Cursor`, since one can refer to it as
> >> `rbtree::Cursor` and then it also follows the naming scheme for `Iter`
> >> etc.
> >
> > You are welcome to submit that as a follow-up change.
> >
> >>> +    tree: &'a mut RBTree<K, V>,
> >>> +    current: NonNull<bindings::rb_node>,
> >>> +}
> >>> +
> >>> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K =
and mutable references to V,
> >>> +// so it has the same thread safety requirements as mutable referenc=
es.
> >>> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
> >>
> >> Again, do we want to use `K: Sync` here instead?
> >
> > In this case, `K: Send` and `K: Sync` are both sufficient conditions,
> > but `K: Send` will generally be less restrictive for the user.
>
> What if `K =3D struct(RefCell<i32>, i32)` where only the second i32 is
> used in `(Partial)Ord`? Then you can send `RBTreeCursor` to another
> thread and call `borrow` there, even though `K: !Sync` (and the value
> still lives on another thread).

In that scenario, all immutable references to the key would be on the
same thread as the cursor. The cursor borrows the tree mutably, so
there can only be one cursor.

When using `K: Send`, it's basically like having `RBTreeCursor` store
mutable references to the key, but with an API that downgrades to
immutable reference when giving out access to the key.

Alice

