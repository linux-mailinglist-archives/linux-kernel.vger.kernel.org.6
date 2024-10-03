Return-Path: <linux-kernel+bounces-349455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B698F672
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902BB1C227BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A71AB536;
	Thu,  3 Oct 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXmJiHxY"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67D148823;
	Thu,  3 Oct 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981154; cv=none; b=bMsRKqgJ0Y0N/PJNpWyanlBRZWVg0ZlmHzBnqw8cYrZcmbcxnaCXpfIJiEYdtXyMjDnleJMp50lV2tYu72929OscWG0jsOOn6zTb7Lu3yS+YyPiuhU7UTA6YBjqIQgd4QvHVx3BzN61Kl01+3c0mX2wX0y3fpiJF9/OK+bh1Dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981154; c=relaxed/simple;
	bh=yTJYhyck+ZqmATQBYEo/WB6UMVDQB58RT56agf8BaDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLnR4KDs7fDO5U22jfrqoNMPbHM0U71Mvd0lDtm/nQOuu80PJlwSPSj3g+WY60R8Ts7CMmcY9tWZSUR6utkKveqyC1v3F1huhrCE71zppVzYVXpPCZD9yGn9Dcr+rWCX7MtDYil7QJJpBPItZyZxvJf2HH6Gnr8vRTE6qg6gcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXmJiHxY; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0a4eebdcfso215402a91.0;
        Thu, 03 Oct 2024 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727981152; x=1728585952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+tNDiM/tR2N3VNA68e0sjoSOqWi1IeukamjpIQY72o=;
        b=hXmJiHxYJPShYOSgbHpMogPvuZoRuBK8s6sFfndSKgCKux53Yjg7x8o4gqBDH58KA3
         SP0ZcYDW/0iIjAmFWIaGy8vfbhGHJjnGmZKwr1abSAZVZfbNgpEErh+6+HMynjxIWOqE
         xqJNPjzvbi9MOXd1UH6pZ+qo3/hgzVvTLUEWyX8UXcVmeGRks/gZlqnCowasTD3ip5RU
         Syj1ax+haZ/qNDfuQDYv29aBvI7v7KpLervEqqbAQEHpPuwLCvJhMA+u74w4UUOSw4ph
         jh6jvzXqduQJCJkc4QM31ZCdS9JRgvBDb8eTfZDoaVYdgQ3/XKa1awKi7HuzLJrdGQwV
         WsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727981152; x=1728585952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+tNDiM/tR2N3VNA68e0sjoSOqWi1IeukamjpIQY72o=;
        b=oVO63+tWXCreIdZTYZQe7kfKhWWd1P2tF9qyT7DvoLEGNhvPsiRIOe7Cc7T2y9JW9o
         1EPI4x2RFJUnfSGFhSXyxFh09rUOj7BJa4VONQzZSVUCKuD4HaWILJ+4M2UTHvCZoCaJ
         5hFXqkydYWgL9cJQisH7ZmnpsKOD/TyjG1TY3/TX1cZ1AbMl2LpO5+5QMWmSkBeIR8UJ
         hR65KBJ/VhIYKLfewcFxv2vbKAqQURXNxCR7lbahjZp//eL4e8gHtRj2K5U+dBajli3e
         Oq/LN/Nsh0bY4qa0wQgNJiTTL53N8k5mskm+//yGmmG1/n8pK3CeMTcsojKIS0JtuN4M
         1POg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8WS8jMo2NNk/Xxj7iVhoOSobPr5YSTw8jb/4aAmrXlIsM5wz9G4gv/Xckjffn4JKStXPzIuqoK1krArL8jM=@vger.kernel.org, AJvYcCUqSnCP2ofMUbfP8YtzoJZOnIPGGcSXatsag2B0wUqh8bUnI/ayGgEv4MgWP/7Tc0lXSJCulwUB4E+SxIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT6hpLYfvtiaaWwNpG944+b8wuaodNWLH0Yt0FQSTfUg754Ij
	w/wrNQ1ooMGlm5JSLfFC1J/lerTDkGOyva85h5Igf9URhSsVwcGFXoFe9ImFIVSJpNUZdYzIAN6
	VeFd4oEluELEHmN509Pzm493Q4XM=
X-Google-Smtp-Source: AGHT+IEEv/6WuqK54zCCgRs6EtPTdocGJ4pyvu8SL4QxLG8ZHmHC1sXwOFyFr07WrLa2YH/LxaCuf704oAXWFA5GGgQ=
X-Received: by 2002:a05:6a21:6d9b:b0:1cf:39db:2516 with SMTP id
 adf61e73a8af0-1d6dfa36987mr187025637.5.1727981152275; Thu, 03 Oct 2024
 11:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-5-ojeda@kernel.org>
 <CALNs47udN4_Gr2KHDapwWAmY=ixoJN+-9apAShVT7qFcKdK23Q@mail.gmail.com>
In-Reply-To: <CALNs47udN4_Gr2KHDapwWAmY=ixoJN+-9apAShVT7qFcKdK23Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 20:45:40 +0200
Message-ID: <CANiq72kEMtB8SBeTJKtRhw5stwieq6ULk6N_X4dyDcCz_2mDag@mail.gmail.com>
Subject: Re: [PATCH 04/19] rust: enable `clippy::undocumented_unsafe_blocks` lint
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 6:33=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> There are a couple places where the attributes move like this - did
> this come from an older clippy version? clippy used to warn about this
> but accepts it by default since [1]. (Still works of course, I just
> think it looks nicer to have the attributes next to their statements).

I started this series about a long time ago, but I don't think old
Clippy is the reason -- I took a look again at this a couple months
ago and created this issue about it due to these lines of code,
including some examples and test cases:

    https://github.com/rust-lang/rust-clippy/issues/13189

For instance:

    // SAFETY: ...
    #[allow(clippy::unnecessary_cast)]
    return Err(unsafe { Error::from_errno_unchecked(err as core::ffi::c_int=
) });

This will not work, i.e. it does not see the `// SAFETY:`. However,
putting the `#[allow]` on top to let the comment be closer will work
(like in the patch). This will also work:

    return Err(
        // SAFETY: ...
        #[allow(clippy::unnecessary_cast)]
        unsafe { Error::from_errno_unchecked(err as core::ffi::c_int) }
    );

There has been no reply in the issue so far, but if you have any
comments/insights on whether those cases should or should not work,
that would be great.

Cheers,
Miguel

