Return-Path: <linux-kernel+bounces-194121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716E48D36E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED75D28A70A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A1DDD9;
	Wed, 29 May 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/8LJNwA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA079FD
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987504; cv=none; b=KfBDVX5fHIi+5faf8tVqL7x0+hMSkOuCvNAjsZ+ytp5NvxmrGAH3sndCKO+eu1M75vzYIBShMwTgOdToG9XfyQqPtOvW17wpIc4fPwyV6SFNMypR10Wby1NtfL6IYYO26kUtW4Xlpohg6NBbegPnz8xMmPVIfBEaywbx0wDUJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987504; c=relaxed/simple;
	bh=XQz+9lO5ZIikKb8f2qui5XPn38ALEFPc0NcBYdZAJss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmFIMLcPaZhu2SrgX9DpYuWwm9fFBEKgKlUde0GL5WayzScRSROsELjWuJ0W1hdHrV9zRLi5kN4QPHexT9IqWtgkOxFidnBtm/wPR6ym2JZm6xNsaNAU5oABNWemCWMPiLw/ofEU+u85CxE5MLsFl8FGWJKe8tK3UTJTJ/09Z10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/8LJNwA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35507e3a5deso567212f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716987501; x=1717592301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJE/TrInZvRacWNjkotsg4UFE7vYxZTG6U1qKQXeqbA=;
        b=E/8LJNwAov0dPpi38gEfN1fyJ24uz1/udy2vHJp16BEIVPVDEkXJkzQrJDd03OIv69
         15/umws0BBeAtjL2sKNpSR4QUxS+xMTv50e79CEg3krZdEGtj/e01g8N2J4XuOW2AvEH
         4qW+/Lj14K19dQ+GKnJ3AoGe19agNx/3pftORA4kzIuQQ+1GW/H1P825oFdLf/mYK1hH
         8CLc4Y/x/h2ayMOXgM6Nl5oEzBdiqCdJsJIQ+Yj6hFLWCd+ALrgDdgQz1vnxlHhOE/MN
         2V8z/3UJj8CzP89r18p/XoRDzPHx5RzdrpYFfHph/z3FogV2oBB/7miirFhcYowvwAkB
         OQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987501; x=1717592301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJE/TrInZvRacWNjkotsg4UFE7vYxZTG6U1qKQXeqbA=;
        b=O1S46/QjZmmfuGger8sK9/irpzItrLBYy3UYHQxQP6xPkzhTEbeCQ6nSyRyaA8l3Bl
         ytXl0dgOTuftr349g01VJ9k/y5r6TKA8bsqy9tNPWRiL05ZnXC70wsYF8hqpfRBf6xLl
         eqUEahjaDd6PBeKhzyV2tBQJCTXECkyCuYWVC31eywLVzMx89H4iKvkBfGyU/oyamiCi
         fH+44CTycvmx3C5Z5Y2Ns8DeoFXbCA8PnyuwqqTFP+khT6aeNVZySv8ameuUv87co+W4
         c2eM5Vs71U/CBlFhGhYNNqDurw3NpDt+T2kSIh/ptp/mETwL2oSKPetTg0yBjxqhzpvu
         bKAA==
X-Forwarded-Encrypted: i=1; AJvYcCW2N5tW8kDqWx2jQBbecnjCFR+CvCvl6JHkdOlfdRrzOOd26vem7HD+Grp8J+uMQKfA2gex3AGD44DHaBkGEArYpH+o3H5OzLCN3CB9
X-Gm-Message-State: AOJu0YxaKE0bsYAas3J4H5PO0WWPXhUBZFLFtMyKHUKzwHrb7dUBD+B6
	BA3aUN2yq52e5u5Vc0rX+1OLMAmRzpee2CkSp+kNih93Ot5id6GQwjzk9CXfQZAL/XooPfHQVSV
	x2UD72UgMrg0bV7hKiBdfN8WMR+/NsqQ2XHT4
X-Google-Smtp-Source: AGHT+IHLqCIA5rqLOoRvTg/y45Phs642aTjHaD58tJI987z5v8v3ParDcY+NpNGrPo5LJWYTAbY+wWYhlsu8xANJIQ0=
X-Received: by 2002:adf:fdcb:0:b0:356:af95:e31d with SMTP id
 ffacd0b85a97d-35c7968d6fdmr1727725f8f.6.1716987500678; Wed, 29 May 2024
 05:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525-dompteur-darfst-79a1b275e7f3@brauner>
 <20240527160514.3909734-1-aliceryhl@google.com> <20240529-muskatnuss-jubel-489aaf93fc0b@brauner>
In-Reply-To: <20240529-muskatnuss-jubel-489aaf93fc0b@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 29 May 2024 14:58:08 +0200
Message-ID: <CAH5fLgg0Bh7PfxFRJoXCOHL3M9wSaAOkhdAJbuTbt8=pkcvc1g@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
To: Christian Brauner <brauner@kernel.org>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:17=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> > > Is it honestly worth encoding all that complexity into rust's file
> > > implementation itself right now? It's barely understandable to
> > > non-rust experts as it is right now. :)
> > >
> > > Imho, it would seem a lot more prudent to just have something simpler
> > > for now.
> >
> > The purpose of the changes I've made are to prevent data races on the
> > file position. If we go back to what we had before, then the API does
> > not make it impossible for users of the API to cause such data races.
> >
> > That is the tradeoff.
>
> Right. Sorry, there's some back and forth here. But we're all navigating
> this new territory here and it's not always trivial to see what the
> correct approach is.

Yeah of course. You've been very helpful in that regard, and I'm
grateful for that.

> I wonder what's better for now. It seems that the binder code isn't
> really subject to the races we discussed. So maybe we should start with
> the simpler approach for now to not get bogged down in encoding all
> subtle details into rust's file wrapper just yet?

Yeah, maybe. But I think that if we can accurately represent the
requirements of the interface, then that would be preferable. Perhaps we
can tweak it to make it easier to understand, without giving up
accuracy?

One of the reasons that the current API is confusing is that the types
are called `File<NoFdgetPos>` and `File<MaybeFdgetPos>`. These names
_sound_ like their purpose is to keep track of whether or not the file
came from an `fdget_pos` call or not, but that is not the case.

Instead, let's call them something else.

We can have two files: File and LocalFile.

This name accurately conveys the main difference between them. File can
be transferred across thread boundaries. LocalFile cannot.



Now, it is still the case that `fget` will return a `LocalFile`, which
may be confusing. But we can document it like this:

1. On `fget`'s docs, we explain that to get a `File`, you need to
   convert it using the `assume_not_in_fdget_pos_scope` function. We do
   not explain why in the docs for `fget`.

2. We can put an explanation of why in the docs for the function
   `assume_not_in_fdget_pos_scope`.

I think it's possible to design an API like this where the complexities
about `fdget_pos` are only relevant in a few places. In the rest of the
implementation, we simplify the situation to "file is threadsafe" or
"file is not threadsafe", and that distinction should be easier to
understand than nuances related to `fdget_pos`.

Alice

