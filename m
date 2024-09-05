Return-Path: <linux-kernel+bounces-316596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8196D1BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEAB11F2ABA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E9194A48;
	Thu,  5 Sep 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbVg/wVN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D8192D79
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524039; cv=none; b=pbUey5oTgieGiJHq5NJ2kG+BOBVv0QGFgISWN/v64vZIkBRRk+g0LcLxG/SNL0fRjVBXmFVVLEaz9ws2KJwTtbE75OTV5f1hXnXb5cm/1G33yv9hMQguJugI92mMDwOm93ea/T8agZTLOzvEECrcdDGn4rUG7877HMbEo2pjpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524039; c=relaxed/simple;
	bh=8nMbj5vMNPnZb//DYqlw97WZvVsPp1BtGEEzYeBSTYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCK3pQe3MsbYLnVN+0UuB8OcgpworxQGajK6dng/mOT6tx18FcX6WqICNW7SKJ1t/a26pILpbPQASYn672RoGWj5tsj1lqDclC2wBDPFYz5yjQ4M3A4iCqpioDUlC9qqVZ+YuJ9J4h7TnjK1GU9hnlBca1cbgJsBTdzIsgzGeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbVg/wVN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c3400367so324519f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725524036; x=1726128836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmQpWs+ZpL8+nQ+M/UHkIAp2vU2mSouieb8DnlV52jg=;
        b=dbVg/wVN6+ve+H7OG3h//U3hQUwm1qAPbbE6fsuVfkpLFzkxYMqN6XjHzywHZ1SW93
         elGvMZIrj4KcqoWoMG1sMVCY4Kh4q4FHW71s0YSEPi5D/AnX7ujcxOjWmcv/9NdbVcDP
         iMKpXMjbc7CRaGGG3R4JeADyzblYuPvQwg30GKP5eGdhduYr6sEughgDzrmHkk+UVXJx
         sA3/NcPiiQZ++oWSmHKFQT/BBNeCBA7fgqq6+NmrKaGfziEpVC3WT0pevnwPGTc2k6l8
         eribJqQzA73r3++5sf0c0ciRR3iqGcctY+7HBQB0X87zl7RVBhz91ziTO0nQiadROPTC
         NtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524036; x=1726128836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmQpWs+ZpL8+nQ+M/UHkIAp2vU2mSouieb8DnlV52jg=;
        b=mHlu7AV3PbstnQF1tXHCYNIeHF2q/4Sb3PQ8amIv0pqlrUq7o4R7qPHKOX1YXI0dZQ
         ntRsoqtMsGd85iMpl56Kv36DBBbGBS7kq2A7MS5eoH8/GL06wJTwMlmVjolDxiYPk2QB
         rXt3RfmdP0WhU4aRaB/yvjJNrTTyOgw6KlHchhDVuQBX1YatXRon3E3jvb5Ty6Kz1U4a
         L1MQhY+fpoNfFP6zan0pLg3vr8EBh+wund9qVT+i8GKhW1bcs47eJRGa1UhrLtrfHyLk
         OIsW4pkdcXeTL6hKKRnCMSFZ/TCfUOC35JUQ08ivr21h/Srd9QcZh3L9B4+jum0qCwoS
         j/pg==
X-Forwarded-Encrypted: i=1; AJvYcCXNOceX9RAq5vxhah/CEh8njH/Z9JtnwuDAdFtO2xH8t0ywyBCYkhln9VhHcRk/Ar6S8VJaNKc5mbnACws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWspN22Qmm/upMSAJIttJRQL0kXxB5XBmXhaG0cErPajYl8NK
	c7Kn6A7eQCN7EVK5NHggO7KP1lgRxi7DzTnPYH2awRA4CoA9A7e9Nv0cF4ZICPx2tbCertEoxX4
	UiUGLdnr9KRS/Xay2pmuwK0FrEWXBQ9w7SE8nP63GHuJZMzFQAkeAOeo=
X-Google-Smtp-Source: AGHT+IF6K/OC4L3DDXFevk4nj4cdDYMB+5p9rOI5uQ5GbPzkuLbAWPEkG0lkHomDQmHZLq35i0GcrEcClCnb4a9Zdyk=
X-Received: by 2002:a5d:4fc4:0:b0:374:cafe:c55f with SMTP id
 ffacd0b85a97d-374cafec737mr8641982f8f.20.1725524035618; Thu, 05 Sep 2024
 01:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-15-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-15-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:13:43 +0200
Message-ID: <CAH5fLgiger4Vg4fUFfwTwmWCN8TAP9qncP8AQpyH=p-qf0u-eg@mail.gmail.com>
Subject: Re: [PATCH 14/19] rust: provide proper code documentation titles
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust 1.82.0's Clippy is introducing [1][2] a new warn-by-default lint,
> `too_long_first_doc_paragraph` [3], which is intended to catch titles
> of code documentation items that are too long (likely because no title
> was provided and the item documentation starts with a paragraph).
>
> This lint does not currently trigger anywhere, but it does detect a coupl=
e
> cases we had in private cases if checking for private items gets enabled
> (which we will do in the next commit):
>
>     error: first doc comment paragraph is too long
>       --> rust/kernel/init/__internal.rs:18:1
>        |
>     18 | / /// This is the module-internal type implementing `PinInit` an=
d `Init`. It is unsafe to create this
>     19 | | /// type, since the closure needs to fulfill the same safety r=
equirement as the
>     20 | | /// `__pinned_init`/`__init` functions.
>        | |_
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#too_long_first_doc_paragraph
>        =3D note: `-D clippy::too-long-first-doc-paragraph` implied by `-D=
 warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::too_long_=
first_doc_paragraph)]`
>
>     error: first doc comment paragraph is too long
>      --> rust/kernel/sync/arc/std_vendor.rs:3:1
>       |
>     3 | / //! The contents of this file come from the Rust standard libra=
ry, hosted in
>     4 | | //! the <https://github.com/rust-lang/rust> repository, license=
d under
>     5 | | //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyrig=
ht details,
>     6 | | //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGH=
T>.
>       | |_
>       |
>       =3D help: for further information visit https://rust-lang.github.io=
/rust-clippy/master/index.html#too_long_first_doc_paragraph
>
> Thus clean the two instances we hit and enable the lint.
>
> In addition, since we have a second `std_vendor.rs` file with a similar
> header, do the same there too (even if that one does not trigger the lint=
,
> because it is `doc(hidden)`).
>
> Link: https://github.com/rust-lang/rust/pull/129531 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/12993 [2]
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/too_long=
_first_doc_paragraph [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

