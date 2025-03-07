Return-Path: <linux-kernel+bounces-551286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E881FA56A82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29518169BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566DC21C16B;
	Fri,  7 Mar 2025 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKhrkx1s"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68E1547C0;
	Fri,  7 Mar 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358283; cv=none; b=YCmoEQNgB4rOQNbnLF51xtKb7ffVafkzQoIqJ5BxMAtxZm0u8Fv6u39HpaRXR6j95+g3sZE49N7ey34iR2bSYuFvD737T5NH8JjdlMIPgSzeHDs3tNxmg/HjIHkc2F58ghs04uPrmopUQyZxPZtXUq4Fil6v/fL74Wb6FsLYfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358283; c=relaxed/simple;
	bh=DzkX5lKKzr5mcxaEJfumFZG4NnshlHx3d7llT4c7XYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJ8igHG6tVBGPCiEl3MgYbtthT8jfXKRFpYUzEkLFRRJeI0eaNVkafzKeigPd+wGbjx2LxseIg1ODv2Uh5ENjN86Sax7gREvF9qMX5eNU6+Dx+t4d7b6GHjuRoa1j0VECtfw6ICiD7h4qF/n/86ZRgkMIUuwJxxh4Fi1RW4f0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKhrkx1s; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bae572157so18200771fa.3;
        Fri, 07 Mar 2025 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741358280; x=1741963080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzkX5lKKzr5mcxaEJfumFZG4NnshlHx3d7llT4c7XYQ=;
        b=ZKhrkx1s82e6oH8hk/B4w4AJqRUyYmr6ubygS7kA+gQDJuq/rvEa/BJTAKM6wZ/JgB
         7gFRVhjeJakot5bEUVfZgjVnSof7jDSjyPh176ZeVjY3v5GnuVlH/wj5Jc9irr4NgMrv
         bPmG+NNUJZD1MfadoTALUnM6WsyLO2zoC9BazgGJNlJZ9zFpVa0guhd5AfMgT7qEoyMM
         tJJIkzBv01DcQzsVciX55GWv2Hx8UxqNR7p+HAg9sGMLVef63bRFOxTr3ixmouFaaaZU
         FhgWshQvwdzqWWGXE5iozpSxS9wVSHzSDSZPK6G4YfFCA0ZkmTvXTPj3J/+As9Fmz+oB
         rX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358280; x=1741963080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzkX5lKKzr5mcxaEJfumFZG4NnshlHx3d7llT4c7XYQ=;
        b=bkfRi0lhyp6l31cpfYUndC+N3AmO6cCOrQUcKm3F4Q6zSGeFenZNKGtFjGaaqKBOMG
         cLEgrQbZ1L1fiZHm24pIx+JLH9Ra8fHvSpkljiugTYbsVGCIeqag4rHcF0qQxloOVFOd
         nKZt2tQHiTC9fUeaScdkoxwzpqYrJ6ioZ942XDOcdSh9Ra6Fclot0gyeuc/AhhXs7RZp
         KhFj+E2ACcYg9YbJQYnFnD4K/kDyjPKmFHH/xUgbFrWOifs3VGFg+4+hKLwzZ43rAW2M
         JJegq2d8xVK2N/byQFa6NmV597zEXItnLJOJuh/N8QFJqZy+cDl3oyVQUTMxK5H0+5Oc
         Rbdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLXMJy0MhAcY8xgRkFRuc8BIjNIbw5eEzc353U3ngfQh518qepBRYmBuZZM+LXNko0YzPXqd6BaRtuD04=@vger.kernel.org, AJvYcCWIjDInJYJH1zeWACjjIrH7goe/7VND8vSS4yMcFW1XuOWFDrzWfHt2xzsbU3jdUP1CtM+2oZvYek9z5YbnbsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZDdL4VZjmdZtUZJK8QFa5e+eXTdbrkr6isq65yHhWTscvNrz
	o8a8jKegbpLAK5uOMa8GnTr9hWvXKzjcRyzYU5trnmwzcbqkKHfp+/v2d8nzp8tkJ20Sdh8k8YN
	rhvi1xQCR7x+CKrohYVNWZp8lmq8=
X-Gm-Gg: ASbGncsDQuBgp1f6gKkwoZZeMDZCcYGNiNCpRVaO5cE8ufDNvv1OIySPOG/Cq8YyLgv
	qY43bPX0cxL4rjhr6Xpf+AQdzMT93F5odPgNgqZiwnqSKkMaYO5hXqpQBZw2XqX9vUruV05Faig
	R20Wruc4g7za/Xnop1+XcXWuemk7DMBMeakFbJWY7qozuhctpwK+xzKNPXPeg=
X-Google-Smtp-Source: AGHT+IEvsgE9nqH4D6bUGTeQq/9PiCFcGWZ55+BZBX+yXqHaCz1Hw5rXHDjzueArBjXTto1C6ISIIm1YdPL6U72yIKA=
X-Received: by 2002:a2e:980b:0:b0:30b:f15f:1bd5 with SMTP id
 38308e7fff4ca-30bf463b5cbmr11867981fa.37.1741358279725; Fri, 07 Mar 2025
 06:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6-mv8ahCblqal1f_T1RcVPPPb6QEedsAXlhmcyCNC-lnvAj1USOInn0YNogItuEdy_KthnPdFDElN1F6A9ncwA==@protonmail.internalid>
 <20250210-rust-analyzer-macros-core-dep-v3-1-45eb4836f218@gmail.com>
 <874j055csy.fsf@kernel.org> <CAJ-ks9mofNbtGqoYBummkfxZ+zrmEHg5P6viVwwgs9-BuNGbZg@mail.gmail.com>
 <CANiq72=_LW8dBbFbQz=tuuck07OhpPdPGuiEtq-SQ1=g-PyNFw@mail.gmail.com>
In-Reply-To: <CANiq72=_LW8dBbFbQz=tuuck07OhpPdPGuiEtq-SQ1=g-PyNFw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 09:37:23 -0500
X-Gm-Features: AQ5f1JqcLPJhbshujH34C2e1qzVSZNlsXPjFRbrqofW7A0Ny02WiPE4u7fpak5Q
Message-ID: <CAJ-ks9mLBNwm2869kczSpnvRqi_LPH9x1ayzsmwELpuDdDndDA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer.py: add missing macros deps
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boris-Chengbiao Zhou <bobo1239@web.de>, Fiona Behrens <me@kloenk.dev>, 
	Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chayim Refael Friedman <chayimfr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:48=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Mar 7, 2025 at 12:06=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > It's in anticipation of this follow up patch
> >
> > https://lore.kernel.org/all/20250209-rust-analyzer-host-v1-2-a2286a2a2f=
a3@gmail.com/
> >
> > where the return value is used to identify the crate. I developed the
> > two in parallel so I added this return to reduce overall churn.
>
> For this case, it is not a big deal (and sometimes it is a good idea,
> e.g. a `return` in a public API that wouldn't make sense not to have),
> but in general, please avoid doing things to avoid churn across series
> if that can confuse others -- future patches may or may not end up
> getting merged, so it is best not to rely on the future.

Makes sense, thanks.

