Return-Path: <linux-kernel+bounces-432776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C69E5030
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031A11882542
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B21D5146;
	Thu,  5 Dec 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk1/fQHO"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC791D4618
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388439; cv=none; b=ax5sSpz2Amndj0FQ4jKjFTeBbezhGlc5d6su4Knn50hFYvTD8RzHxOfFStq5566BzSbNPeFIy92FQZtCPGBuMiO2s9dB9gT7khcpc23BWt//+usH5yUXOYm6q/EBJrLcOOxz3YBaC1vKToQGvYcNTVOUpRN4eEVHtVfIag/xldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388439; c=relaxed/simple;
	bh=hnsawiAPmNyTaOqVa4N7z88n0Q+3dFHhfhhfTqZFluI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hawb4961stkok2NkGnyWNJHCBP0x9ZGJ8IiySTjQFSfpoPyVtYa+rJQa5QTm0cyEGK9ZIaSPw3K7oMhTf2vC0hTeHrcB3dXAezK1ysEgaTYmmZ0g0kcug4PUk/krIu9z2m8H0wt0XlcU3FokRTRR8A55KYmFuAN4U5k5bu/WuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk1/fQHO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385dbf79881so1085868f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733388436; x=1733993236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnsawiAPmNyTaOqVa4N7z88n0Q+3dFHhfhhfTqZFluI=;
        b=bk1/fQHO81uCf2qg67ZAsKLqkDTud3O/Q4tu06veALpsdxHgka4hu2pTMPxbFs+Ith
         +vRvJoYzVkT7BSLwuXCq2SZlCW7a2V/aCPOiXiD0SLd/TIUJX/27OSpTA7MAtCJxdEhu
         YB9Y/5C5DiDVMPDyC66wJBHqCVFdxzU2xTyyH1c724NDqxOoBcRK4FWxaIJfFdoDmNAc
         mtwtH3ihJgdL+wIZRgiufOQYSjZyPDr2QFRlT6fPmxKYakOaIlb2bB6YuV3pl93Y/afM
         dsCAntmMwb6rF3F+BC2SM7vUkLJkRnCbivqgltDcsf9Zbdm8/DYDeYvJv1pg83pnuh11
         i9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388436; x=1733993236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnsawiAPmNyTaOqVa4N7z88n0Q+3dFHhfhhfTqZFluI=;
        b=T2lZ/vPoDEHJNV95r2A7SGm7Q0nWGe7Oz87+zE4pKdMHND4q3BcX2fVReuz8oUr6kA
         ezWTLeK6lUoDow5v+RJTIYkX6Zde/MSbPkeYZff9KHxOEvlH88TT/TJme0i0j4pCGs+M
         JtCdEYn+Gsgv6HTdn2tAmPL/ypK73ERRF+VhTeAhWGb07weoZR0PXtnk7Jr5icfBI3GW
         OwcTa2QzalHFeY2FX4Yl3pm7QiO4Py44uWX05G6vjtiPsU7RR1ZUdS0PnIDkj5QXwfuH
         ojJZ7TTfo3k87R5X7TtJOtUAXZLSmQXkF0Y0N/gVyyiCOqSK+6SUg+wvnn8w+xFlbkRa
         rQGw==
X-Forwarded-Encrypted: i=1; AJvYcCXICGDYmfThM7MDrUdWd8JPL10/aq+E/+UDISC4AjpK1ZQOIZbG0A39MmKPuQqUV191ki/53vkxyVP/pGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ilacz0ql7NPuqhG52CsWvI15owzOtXEqxxwsOipGZQz/AYIk
	w2FRiIQLsFokx1WzQ9Orsmm/9u6HlSpcmIaYhqKJj/GMlocsoaij3tVE7acFfdWLZDQmCntSmJH
	ATlwFCgUdaL23Nc7hIhlFtfJHgCtJaPpbYsQu
X-Gm-Gg: ASbGncuEAPK02835cQIpoE0v3EcT+cg/1fsoyGEx8jzdOnAgdNNFmVYxfwzHbiouBuF
	WrLgqIBFnky2KbMekaFe0fcGZ5gDzN1CVrZa97qVZElhQ09HAXnG0ZcE7ZhUBKw==
X-Google-Smtp-Source: AGHT+IGnhellO6UJ4z4u30dAkBaqbxEvnFWZdjtopqXpVvl6L1W8rz2P6jjJGe9/awoSRPYnuNZOTWKmtI+ml0eBTxo=
X-Received: by 2002:a05:6000:1885:b0:385:fdff:d457 with SMTP id
 ffacd0b85a97d-3861bb7c21amr1569820f8f.13.1733388436297; Thu, 05 Dec 2024
 00:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io> <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com>
 <OCjFF0---F-9@tuta.io> <CAH5fLgj2qHjYj=heYi55qWz7=LxyHeUPyhbgVe0QLjzH0S34bw@mail.gmail.com>
 <ODK_F29--F-9@tuta.io>
In-Reply-To: <ODK_F29--F-9@tuta.io>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Dec 2024 09:47:03 +0100
Message-ID: <CAH5fLgiwQzrKG2a3Doj+LYGAna7yJcBO5eTtyMYiBfVZmZSLVw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Rust For Linux <rust-for-linux@vger.kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:49=E2=80=AFAM <jens.korinth@tuta.io> wrote:
>
> I'm afraid you lost me. You wrote:
>
> > Using a Once type for this seems like a good idea to me.
>
> and
>
> > One advantage of using a Once type is that we can use core::sync::atomi=
c
> > until we have working LKMM atomics and then we just swap out the Once
> > type without having to modify the warn_once abstractions.
>
> That made sense to me, so I started in this direction. `std::sync::Once`
> has `is_completed` [1], which made particular sense to implement in my
> mind to increase the utility of `OnceLite`.
>
> [1]: https://doc.rust-lang.org/std/sync/struct.Once.html#method.is_comple=
ted

The stdlib Once type guarantees that when call_once has returned, then
the closure has finished running *even* if you are not the caller who
is running the closure. It achieves this by having other callers go to
sleep until the main caller completes. If we actually want to mirror
Once, then we should have that logic too, and I really don't think we
want such complicated logic in our pr_warn_once macro.

> > The purpose is to use this for printing once, and printing doesn't need
> > `is_completed`. We can have another helper for other purposes.
>
> Why have `OnceLite` then at all, instead of the hidden Rust macro that wa=
s
> proposed initially?

Well, one advantage is that when Boqun manages to add support for LKMM
atomics, we can switch them out without having to modify macro code.
Moving logic out of macro code is usually a good idea. It's also
possible that there are other user-cases of an OnceLite that doesn't
have is_completed.

Alice

