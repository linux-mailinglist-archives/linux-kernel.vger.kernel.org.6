Return-Path: <linux-kernel+bounces-301213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481E95EDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494CE1C21608
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5043146593;
	Mon, 26 Aug 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJM5gOA0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DC1465B3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666236; cv=none; b=DNSVuWt82YKNJ1sk1AuBzxAfjcaeVTjpjJGxdiXiZeNWTJ6wxEoW4V83MO+jd7T0+bXKb7VVSNluT+1KMsNLzypQV0BVgnJ6eXgVcS5uhFAAx9JhGJ+/14jDGLKqIUjuHdy6ZIFjFWzIE3yLKdR2Td1S0mdId5bRKRmBK5Kz52Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666236; c=relaxed/simple;
	bh=xPxiG6gE68RslYvroTUn5MUrsD9qoD1pybo/gcbHKns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+9X1CijZz5esS6utvQDQxOUTdEdw7y/ansNkDO9Yo4EKEK6cUqUsQXkl0IG/p+iVcU9X+kl3O7Diz77A5elPl8nlsuk9NfPbYgJxUt/i2WlOV/i3zz7OBC5+r5MV/FVSYmxj/Lp8gsnykEB3LGm6qEMluy3anbfqOA0IDNEi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJM5gOA0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428101fa30aso36150335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724666232; x=1725271032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pGOuOLnr9NazAPpmc2hXzxUd/HacmE0Vm1sk+YUuvw=;
        b=hJM5gOA09iUNDBy/sNpqzrglHB6YQ3ryZXXCHm9NYu6mvmHoiAS5kJaaocYwyoBbew
         3RJuNL0FOsTo3GoyFAIAWTxUA4zmccL3npJXoBXOdvPwCGKYtrPFtO9gYK74pz8sUBlW
         /RGLkrUcAhveDUfvT98xlJjHoLX01m59IdK9WlAXeZBuTndGOVFVqa72FGnsx4YnkQXF
         bZd3LBvyQ7Ejf6EOwCPsFK7kCt7tAMMIFX3GFdf4B/uzoIL2DAhYWI8OYeqErpKR/DA1
         qUpH2ufowydF2DWI1ewMqHRQNbeJZHoXH33WBvO8MWqNcmY9pM5dEwms/62kr/XMS0hQ
         qdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724666232; x=1725271032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pGOuOLnr9NazAPpmc2hXzxUd/HacmE0Vm1sk+YUuvw=;
        b=SKlfYi8VKtcnuSLTUZgGeO+hO44wtgI2gon/MAB+/yAwhwo84aVMjLq4+W0EAqwda3
         1tkX0ovdU93usIRd+JBxS/dTPvS+KjwQ9ukHp1atmZhOGRF5uYjng1/jbRFeAdguCIJP
         hsOZRz4qiNoZSA0z3UHIn2mdLYjZy+b9PwExBOakjj5aYYqnZmOe9R+zgL1faCtclsYf
         D2wy3JBq9yGn9YUc3bDgtzGE1+GpoKDA/itGiRbpiEBJZqId/LOoEs3SSFMyfDjXOXSu
         A1aBNj1wDeVLVHoW/yErHgDGEWnDvaesLGYZqvZqEI9kM59EtIi0wrIsaGMRetY3gj3H
         gaaA==
X-Forwarded-Encrypted: i=1; AJvYcCXfWxcJQ2F0pYLQlXFT1YrkVW1/Tal/NFdNGCftKDidvyyiSJte3/zcSdQyq29n9JPEKJ4PWhJXhxk6n0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yMw57lBoFACY7WePdV2FxsSgdtp9qiJAoVccohtrm5rlZ3XF
	tc4UXBxCLFgiPOysjXgQRAFLDK7/6ez0OejW6QxTFLqgbvK1Feron+DgMITbBo45bCtNt8REtWd
	/BAcSp7NxNBExcvf9HtBQF/4PLfR+xiy3Paut
X-Google-Smtp-Source: AGHT+IHXrNqjKPfD4VdHHN6OrQjCBUXEWyPl8EaL5I5AW1+tNYmhjS4nIo8jltv6QxAn8ZeHqsM3XX/6h4KuuX3yNzs=
X-Received: by 2002:adf:ec12:0:b0:368:2f01:3053 with SMTP id
 ffacd0b85a97d-373118eeea2mr6439142f8f.55.1724666232254; Mon, 26 Aug 2024
 02:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com> <5a7e828e-b003-4062-9469-53f090defc03@app.fastmail.com>
In-Reply-To: <5a7e828e-b003-4062-9469-53f090defc03@app.fastmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Aug 2024 11:56:59 +0200
Message-ID: <CAH5fLgjXDOGbmtkhfiytAGVtT7njuiHQsqVcf0hMQtbyeUY-fg@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Red-black tree abstraction needed by Rust Binder
To: David Rheinsberg <david@readahead.eu>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:15=E2=80=AFAM David Rheinsberg <david@readahead.=
eu> wrote:
>
> Hi
>
> On Thu, Aug 22, 2024, at 6:37 PM, Matt Gilbride wrote:
> > This patchset contains the red-black tree abstractions needed by the Ru=
st
> > implementation of the Binder driver.
> >
> > Binder driver benefits from O(log n) search/insertion/deletion of
> > key/value mappings in various places, including `process.rs` and
> > `range_alloc.rs`.  In `range_alloc.rs`, the ability to store and
> > search by a generic key type is also useful.
> >
> > Please see the Rust Binder RFC for usage examples [1]. Note that
> > the `container_of` macro is currently used only by `rbtree` itself.
> >
> > Users of "rust: rbtree: add red-black tree implementation backed by the
> > C version"
> >     [PATCH RFC 03/20] rust_binder: add threading support
> >     [PATCH RFC 05/20] rust_binder: add nodes and context managers
> >     [PATCH RFC 06/20] rust_binder: add oneway transactions
> >
> > Users of "rust: rbtree: add iterator"
> >     [PATCH RFC 17/20] rust_binder: add oneway spam detection
> >
> > Users of "rust: rbtree: add mutable iterator"
> >     [PATCH RFC 06/20] rust_binder: add oneway transactions
> >
> > Users of "rust: rbtree: add `RBTreeCursor`"
> >     [PATCH RFC 06/20] rust_binder: add oneway transactions
> >
> > Users of "rust: rbtree: add RBTree::entry"
> >     Not used in the original RFC, but introduced after further
> >     code review.  See: https://r.android.com/2849906
> >
> > The Rust Binder RFC addresses the upstream deprecation of red-black
> > tree. Quoted here for convenience:
> >
> > "This RFC uses the kernel's red-black tree for key/value mappings, but =
we
> > are aware that the red-black tree is deprecated. We did this to make th=
e
> > performance comparison more fair, since C binder also uses rbtree for
> > this. We intend to replace these with XArrays instead. That said, we
> > don't think that XArray is a good fit for the range allocator, and we
> > propose to continue using the red-black tree for the range allocator."
>
> (I might have missed this in previous versions of the patchset, so let me=
 know if this has been answered before.)
>
> 1) Have you had any chance to compare this (performance wise) to the intr=
usive version used by the C Binder implementation? I assume the allocations=
 are negligible, but tree-traversal should be significantly faster with int=
rusive trees when keys are next to the rb-node (e.g., binder range allocato=
r, or ref/node lookup based on u64). With the allocating style, you likely =
double the number of cache-lines you load during a traversal, don't you?
> We have been trying hard to keep the intrusive style, but never really me=
asured the performance. So in case you do have numbers / experience, I woul=
d love to hear about it.

The performance numbers are okay, see the linked RFC for numbers. But
it's a known area of improvement.

For Rust Binder I have an implementation using a fast-path/slow-path
idea where the range allocator is stored in a flat array instead. It
falls back to rb-tree if the number of allocations gets too large.
However the RFC predates this optimization.

> 2) Similar to 1), what is the reason to avoid the intrusive style? Is thi=
s just to simplify the API and keep it close to what rust-std does? Is the =
intention of this RFC to move towards an allocating style, or is work on th=
e intrusive abstraction still welcome? I guess for compatibility to C-code,=
 we still need the intrusive helpers, and likely for a long time.

Ultimately, the reason is that the red/black tree is one of the very
first abstractions that were written in the Rust for Linux project. We
had not yet figured out how to correctly do intrusive structures at
the time, and I have not taken the time to rewrite it with intrusive
support. That said, we do know how to do it now: see the workqueue [1]
and the linked list [2] for examples of how to do intrusive data
structures.

> 3) I know that Matthew has spent significant time converting users to xar=
ray, yet I have not seen any real deprecation of rbtrees. Especially when k=
eys are user controlled or sparse, I do not see how xarray is a suitable re=
placement. Did I miss some discussions there? Or are you just referring to =
the general recommendation to consider xarray?

Ah yes, the xarray doesn't work for every case. But I believe we can
replace the red/black tree with a hash table instead in those cases.
There are cases where xarray is a good fit, e.g. when the key is a
thread id. Also for the u32 ids of remote nodes, as their values are
controlled by the kernel. But for locally owned nodes, we would want a
hash table instead.

There's only really one case where I don't see any replacement to the
red/black tree, and that is the range allocator. In C Binder, it uses
a complex data structure where the nodes are intertwined between two
rb trees and a linked list. Rust Binder also uses red/black trees
here.

[1]: https://lore.kernel.org/rust-for-linux/20230828104807.1581592-1-alicer=
yhl@google.com/
[2]: https://lore.kernel.org/all/20240814-linked-list-v5-0-f5f5e8075da0@goo=
gle.com/

