Return-Path: <linux-kernel+bounces-300563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6695E521
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6023E28243D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFFA16F0C1;
	Sun, 25 Aug 2024 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI3lIKDl"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A91803A;
	Sun, 25 Aug 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617521; cv=none; b=Tf94d92bJ0vQd+pWZLV3ke+DBBBf+5ZPbosVZDoLKhfWWW7ZbKiG0fXC/O4W/SG6FbLX2SD25DI7XxwQ8jNb86WUcToe6KSBl2fwi6lpskhn0nXUWSqfq3kAD2nLdNNGm6wolB5B4Q+TT+3e6fIHg+J8TnRKxf8efGV+CDkuLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617521; c=relaxed/simple;
	bh=PLF+XAa7kibaNCJLJ2jSiiFd5un4L9bAbuBTPmptxYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qaX6zlPmSXgAkL/u5nS+LNJbOjMOi0Y0bOaeRJWOqQXCQAAVc6WR4EB1jFRODwFigkyJ4kb7vQozpZ73Mm+C9Q4o+noB07XWScT9WrebIiyOp5WH4c+K2fb58OvaxzLa3BWlHyGM8rC9F/qW9mjyYKTAi6jrNaQo4r/5RCMh7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI3lIKDl; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5b850d969so2648476eaf.0;
        Sun, 25 Aug 2024 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724617519; x=1725222319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50RI/a1NZmhiwt7nlsK+guAvWBNFkemQkKhjN0j6aOU=;
        b=jI3lIKDlsdhL9yA26nS9hYIgpjc+JPESW/j6eVooIl/ZrshOctmlqV8NwLrUZQacdx
         UsIJZP6ZFbV4TIu2V2kEdVr7rZXuoT/MC2M3SfIYFK92uNp7EID825IwMT4b409xQ6VQ
         AIHI2xC1ER2sHKAI3qamH66Q2B6P5R6NBCtpzv6atV8SAfhVf00LKdqUwzywb8xDh9gF
         540jTqKv3AbbH3+ldPsAXmf43Z/VuNFY31tRBYbBt0TOC0T+UXFft7xwHZZoShZld33X
         kILkOujI8eAXIsuJmR3jYKFtYBui9F4qb+NjpRRj+bYRkVIaTPY0x79LMzvzcMuSaoAS
         w+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724617519; x=1725222319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50RI/a1NZmhiwt7nlsK+guAvWBNFkemQkKhjN0j6aOU=;
        b=fE9NcWmCxgQHXTwbJc+pTLbl19tAaGpnbrLvT9huqlUqZkfT81uCOzNOxfQIyz9BVS
         AnkkyZsTt6xeAlORm7m7gouMWvzPlOSfYupjXrfK+T2eBQc5CVzoBJn6hAwXkTMBusyn
         G8UVCp/bODOypz7fgkUGwV635uWlCs0B9dTBoE68zHMIUk1lCftff39xb7MQ7SJRjqAV
         kCtNl7fQ6Y3eqwMD99iCJxmeXP4cnL0CH/EUZpzrLuH6FLWD/vqode34W6CoB0WF0jrd
         N8wzpzLBOuBhqOJV+qge1z5xshpgW/bwE8/QDtU/qPmwgik0LEchbzLbP6Wwsnz6gOI/
         WB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuSkhCaqL/cPEgFOtkaeN/WSDou7kygvvzNL5eU7YrAFafnf/FQG5fE5MZ9oQGOe6hGs0fn9+LGm4=@vger.kernel.org, AJvYcCVzTUvp1pg40A3JG4FbGgtdwQffp934khQ5K3y8be+T21VtFa0aU0iRykmeWqUCiaYj5Y5p+yKhmNi3lhrL@vger.kernel.org, AJvYcCWwNj4QCzq31E5LdJmjZJJ9UwZX+u7NB5amigI38P8X5ky5dsASaDWNoVVuCc2MwVQEwdC6Weazqcht6Ihlm1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpoMFiUhJcxdDlO/yeQnU8oERdtqdnhOixHNaikU7rrD3Um0m
	SU1+uPgjHKnrIl7wXUJ4YXf6tW3o0X09RRNRzshjyVF1PMvN8ChI5ezHPM4eKkuSW/7j1fp08FX
	Vhem2Ri7BQ2PloQqe67Vn966KYfI=
X-Google-Smtp-Source: AGHT+IFGU5O5gyc3TgWpgfRqxbYR3vkdTRqKzvhpIj7OVx9PfV9d+nAJJKaOipWlJDXJhWRbgsLMkB5n9Ws97Tw/rZg=
X-Received: by 2002:a05:6820:174a:b0:5c6:9320:2df6 with SMTP id
 006d021491bc7-5dcc6282916mr7857893eaf.7.1724617519570; Sun, 25 Aug 2024
 13:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818141249.387166-1-ojeda@kernel.org> <CANiq72=amLCxV3QRVqK0gVKnGZe_YeqB79LkydEjZ_hJ6_K4QA@mail.gmail.com>
In-Reply-To: <CANiq72=amLCxV3QRVqK0gVKnGZe_YeqB79LkydEjZ_hJ6_K4QA@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Sun, 25 Aug 2024 22:25:08 +0200
Message-ID: <CAAOQCfSi9sMqgBzh+v42XGOh2fopytBSjxfPp6kd5DUcGtq20w@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: enable rustdoc's `--generate-link-to-definition`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Don't hesitate if you encounter any bug to tell me so I can fix them.

Any feedback is also very appreciated!


Le dim. 25 ao=C3=BBt 2024 =C3=A0 22:22, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Sun, Aug 18, 2024 at 4:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > In Rust 1.56.0 [1], rustdoc introduced the "jump to definition"
> > feature [2], i.e. the unstable flag `--generate-link-to-definition`.
> > It adds links to the source view of the documentation.
> >
> > For instance, in the source view of `rust/kernel/sync.rs`, for this cod=
e:
> >
> >     impl Default for LockClassKey {
> >         fn default() -> Self {
> >             Self::new()
> >         }
> >     }
> >
> > It will add three hyperlinks:
> >
> >   - `Default` points to the rendered "Trait `core::default::Default`"
> >     page (not the source view, since it goes to another crate, though
> >     this may change).
> >
> >   - `LockClassKey` points to the `pub struct LockClassKey(...);` line
> >     in the same page, highlighting the line number.
> >
> >   - `Self::new()` points to the `pub const fn new() -> Self { ... }`
> >     associated function, highlighting its line numbers (i.e. for the
> >     full function).
> >
> > This makes the source view more useful and a bit closer to the experien=
ce
> > in e.g. the Elixir Cross Referencer [3].
> >
> > I have provisionally enabled it for rust.docs.kernel.org [4] -- one can
> > take a look at the source view there for an example of how it looks lik=
e.
> >
> > Thus enable it.
> >
> > Cc: Guillaume Gomez <guillaume1.gomez@gmail.com>
> > Link: https://github.com/rust-lang/rust/pull/84176 [1]
> > Link: https://github.com/rust-lang/rust/issues/89095 [2]
> > Link: https://elixir.bootlin.com [3]
> > Link: https://rust.docs.kernel.org [4]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Applied to `rust-next` -- thanks!
>
> Let's enable this since it has already been useful for people. If it
> happens to break, we can always disable it. And it may help getting it
> stabilized.
>
> Cheers,
> Miguel

