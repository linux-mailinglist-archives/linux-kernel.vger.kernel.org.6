Return-Path: <linux-kernel+bounces-567923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3BA68BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD3188861F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3299A254B1C;
	Wed, 19 Mar 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EatzPuTZ"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167E254AE9;
	Wed, 19 Mar 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384480; cv=none; b=k0oXRT9xhLjfQtgT7Y0Zwq3+nqB/74T/lDiYSAdOUPIlkoZJWbRRzqR3q3aIjuVjb+VQTU8yZpqV+J5X6XGOgEMsFCo4GFW4YnbbO020zbD6NQarCOIea7Kt/ZSRqTXftbPsrUGcURs9ip6jhAJtHBeN1rKpRjOagVKgCahvQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384480; c=relaxed/simple;
	bh=dY0bSlkZY9eFAAkqVL0l2gfk+seUQ4xcvBKHzhUjfBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1eCjy6UtCjPlDZpiSw76lcqj63syWFSQjhG8SKQibi3F2ZzMBqKjz2GHTqiu6VxHmBNthlUkAO8EmgYqFW+mrBn+8mW4ekmslIs4uuggtcDDkf/yVzR4wjHtJEISwGa8v0HJX8cB4FC+jKGoZKCfgalzBuuHroAS6A6d63L20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EatzPuTZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so1117384a91.0;
        Wed, 19 Mar 2025 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742384478; x=1742989278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnLGOkNU1Vuog/zhOK5UigYJOUTmSUZsWcTq0dCrI58=;
        b=EatzPuTZBu1StYCZ07I+cnh0Rxf25V71cqpzHgqDwt6lzZJT6dbzMPq12ZYnbmxShH
         3uSp5k7dwxBoXuHbJMktGxaHxvV64RQ+TMMZJ768BVH3vdnNkyfqJXR12OhUX4s1kSK+
         J97coi9Gn7XM3MpKPsTdu+31HUQsCkUd6Am0RpLdHlObH0wGtWGu1EHO+j7WdhYjx4m7
         8tJ+Dp0zXyhQpzTpc12RBmqCmZLn9cHjN3qEbswjsJsPo/uPHBa2rr1vcUHF+BczofJF
         lmOh/4lae9Xy6w0JjQqO7sB8oX9MzPvGlhs4lSlXIGIfXgHFCdT0N0wSC9bgu6H3UsX3
         5KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384478; x=1742989278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnLGOkNU1Vuog/zhOK5UigYJOUTmSUZsWcTq0dCrI58=;
        b=iV31xHUgMX8eWZCo8DJKv4xeFeYxCVLzPXwVwi92nqspIHdkNO4pNlnDoChw/2PzOG
         rvHJr7o+jgw8Fyj8Wb0TVqAlxsMQJHBiSRonbpZy7aMLj9w52eqGZUDJmgUjiWt/fRTA
         k2g6RVlsdf7sJ71VLAb8i7ue0iizOgmFyeYlDQ+mg+oOebnnw1D6cGyy7eq1Ezkd3zle
         x92ycm/OkDBHwP2z2W4VHFqNgikMIqVo4xnA8kqCMgi/d8wpmmKnqCfIwyn5NV0ORu4b
         BnxhvRO198n3DmnSIaCvJORgTdbMrxCOFUcyFTpUSPMzUsR4vX24GnGUZbwx6Dr0qAIx
         YyAw==
X-Forwarded-Encrypted: i=1; AJvYcCVCLFZFPWwZC3UiGWrFr7NJPfxX8WYRYTW+qOOc9h6ojm+NAYrcDju29fBl3FICSg4MYAyHvDWya7TAZ1i4BXo=@vger.kernel.org, AJvYcCWIPTHdUhkikThtFVOUqf/DeaDbvZbgjC3/3H3pjFgVb/+Gsjrht4EcZkZjh5HcWKdn3nnDGa1VP7c4ITM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamTALh6kiN/T4iLbpTzM5BG0/y4T2xfdO+3hDFvJ/y95WCvB2
	DJC0Yxxi3PFmOoo+3XfeHeP0hRNAjFWg8Tnr/w9FBeh3WLjGpE41jreI9qepdsviHnmlXdQ2jpP
	dawCkTMZPwFOOHWu84m9XkkPXr7s=
X-Gm-Gg: ASbGnctVjAGE36xA0UxqGXXCSv1E4gvD4NnuxCvRBDEz6hNqfOTC0lovJKQm2A9tcc2
	bgmoCsYtzMlrQJQYnJCGRUSph3mo15MeQOrNzb1DNaKAb6sfkuXn4mKgFej8jB8eDzLhVq5Ks6b
	8lAJ69lXuovtPWhAqiXA3nUEHHiQ==
X-Google-Smtp-Source: AGHT+IHjYWRahwx9HfZAL+ehmyvIhjqHmadrdhM0lAFvN2DNNbSnZLKTx2Htyynm7wBNnLsG4SYcKQu8PmTMDgskuYo=
X-Received: by 2002:a17:90a:e7c3:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-301bfb3ba7emr1335096a91.0.1742384478320; Wed, 19 Mar 2025
 04:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com> <20250318175322.1627073-2-bqe@google.com>
 <Z9nUzjinU_mozCXC@thinkpad> <Z9qe_cLk4FDg_fAE@google.com>
In-Reply-To: <Z9qe_cLk4FDg_fAE@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 12:41:06 +0100
X-Gm-Features: AQ5f1JrxRWLEixkoKqM6-vElnJ9oYcRjKb1j-r0nhydYdmhv84kWX0bLC20z5SU
Message-ID: <CANiq72moSLXx7sRedN9Cjg-hWy4d8c1NfvmNyO-Uup+iupRF5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Adds Rust Bitmap API.
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Rewording `new` to `alloc` seems reasonable.
>
> As for "drop", that word is special. It's the destructor that is called
> automatically when the bitmap goes out of scope - you can't call it
> directly. It must be called "drop".

Alice obviously knows the following, but for so that Yury has the
context: `new` is the typical name in Rust for the "primary"
constructor, so that is probably Burak picked it, e.g. see:

    https://rust-lang.github.io/api-guidelines/predictability.html#construc=
tors-are-static-inherent-methods-c-ctor

Constructors in Rust are not special, and you can use any names (and
can return errors etc., unlike C++).

So people use `new` by convention since it is what others may look for
first in the documentation. It is especially nice if there is only a
single constructor, but not a big deal.

> But the confusion with "no set bits" seems like a good reason to silence
> that warning for bitmap.

Yeah, if a lint is giving trouble, please just disable it.

And if we need to disable it in quite a few places, we may just want
to disable it globally.

> We can still call the method __set_bit if you think that is best, but
> because underscore prefixes usually mean something different in Rust, I
> wonder if we should use slightly different names in Rust. Thoughts?

I would really prefer if we do our best to avoid underscores in Rust,
especially for non-private APIs.

In Linux we abuse `_+names` a bit sometimes to avoid writing a proper
name/prefix/suffix for the different variations of operations, and I
don't think it is a good idea to mimic that for non-private APIs. I
mean, for static single variations, it is OK-ish, but other cases are
not really great.

Worse, if we start doing that in Rust, we may start doing it for
things that do not even need to mimic a C API name...

Now, I know it is painful to have a different name than C, so it is a
trade-off. And sometimes coming up with names is difficult, too.

The underscore implying "possibly unused" is not too important for
`pub` APIs I think, since the compiler wouldn't warn about those
anyway, no? But for non-`pub` ones, I agree it is one more reason to
avoid it.

Cheers,
Miguel

