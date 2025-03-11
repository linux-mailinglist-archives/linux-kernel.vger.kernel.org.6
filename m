Return-Path: <linux-kernel+bounces-557046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCAA5D2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50F17A7B63
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAF22371C;
	Tue, 11 Mar 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQXs6a45"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E051F4CB2;
	Tue, 11 Mar 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734433; cv=none; b=N4LSRIozlud7wWWr5YZK6wCBBi5kIz9AYUq1Rtul6CEJ4ta2dLzvZPU443BRBNfMAowcEmDu/6jlolnL1oFmvm/mMQ38c7cDLZ0sTFCvTsQYtthf+dU7cYNAncf5iYCF/Cqnpq6frZV8VgWW/5E3ZGvkRZV7P+9E1IexL+baDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734433; c=relaxed/simple;
	bh=TaLU7VunbM0T7hfqnDM9Ixx8BakgDhk+Dr2Vd9u3hDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOm2rm6hVGVyBbO2MazaoG3+LcJF6I1EkNPTnzjLI0Glsn5LZiTVqeZSOmDemd43D8LVmpasjSEL1z8n/uqiiirS1mjmZxtqtkFeTapqAkAHt93BxH1f0bc6Ps554No/dUAAXfCLAElvSF+neWZoa0M7UvpWWSKUjzsaguepfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQXs6a45; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307bc125e2eso66964491fa.3;
        Tue, 11 Mar 2025 16:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741734429; x=1742339229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaLU7VunbM0T7hfqnDM9Ixx8BakgDhk+Dr2Vd9u3hDw=;
        b=gQXs6a45mS8IqYc4j9j+EulnIVXs2TQHJXZwI3h+/mR9r2Hsej1BO1ktB1nHYdD67L
         y3KsWogIFPYoRocyItuyCINFs6WsGn4TG+rxOYK/AH8DQ9Q3AcWPY8ulF1iNJlkqKcpp
         dVuAUK7uQozaeKrwU3WIkzXFby4B/ecY2ZOPzBioDDvQntK3/tLVQUSDo4aSFl0fZYod
         4rvP5F8J6VyzJ4uXO8vc9HQY3dY7ucQj5orwE25d7IO8roZgxHOh5HUUGiI8br0yUBvX
         w5M3fc/FuhfHXYzjVQqXvcRRM4PtFimDHQhot9kRnEIL35e2kjSIgWhR3yHJrJhERuih
         WKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734429; x=1742339229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaLU7VunbM0T7hfqnDM9Ixx8BakgDhk+Dr2Vd9u3hDw=;
        b=bWG9Mg6pPgGlCLT9hXq3e+uwnFYW2F3Vru7jhjundizy2Wqq7uKtVoRn94ekd2dfmD
         w8AshdAnq7Bb8TShyl3XmIBpIYWeDHaA8BR7ItGv5MG9QGcMIaDc5xQp3jPBiHIdX5Cm
         5jkSXjn3sWGdQgx1ICSBaEs9OLrnnI2IKHX1cU5784WKVvrQdkBEKPGUUGoRqEslJDWJ
         kY0aFn9/VuYxWYyrpBv6XU6Ah0tnMngI5dvOltZUDFUC8s6pE4GQcEF84qq+lWDa6kYz
         LWCU42uHtAQstATM7c7nav2gVzmMHQnzMnTTg9t4x2aWaUyOIXiwbmkTglDZm4eWC8IC
         nwww==
X-Forwarded-Encrypted: i=1; AJvYcCWYEHnfCbzJPllId6NwYEKxY9Y/KIKPxjZsVLmLUO1ukrDvKQusX6YHfbf67sdV6fvjrVn8X4l59JfJnph1lxI=@vger.kernel.org, AJvYcCX1IHlopGHIjMHBjc93QFCwX+R9RmIvBRqUN0FLjYrPXfekKsNIghHlf0Gr6/DoMSGykOLdOQV/n/aSi40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHCP4esJ7c1B2N/8JAgYgKQUXf+BRuoZO242B4wIKpPfI2wzd
	6nWh9zM204NyYeIVSzIdZMwEMuFa2lcbtINZ2lhso1RWfadgdOLYJZ5rZcnhzjwclMVaErmGplS
	Rcz5wBpmH1WTMek0jlZeRf3XMIfkiI8RtdN9lwg==
X-Gm-Gg: ASbGncsccBA3NvmbTU8cqyD9M0juxZgAho67Iee1SZzoRnZsqKjIlHUpIVj0Ozn1Wrp
	WUK7BGTlj0eHdCtQDjUc9+BnX1mwMF/GxKgvoq9iqjey9569FrTuh/gD40wg5SFsKxH+mriZMFl
	e8OfttjoBuPPqRHsmz5aGoPRoMuDfCfSwlxxgz3LxBCjbKO9qSDqbqKzeq04v3
X-Google-Smtp-Source: AGHT+IE/596ZnBtO/vJ5JCAQ6W7pprEg7mXntGEGUntLtvzQbOABGGS6gFYPGWlmPNc6+9zVq98awb55xqQ2LvjIys4=
X-Received: by 2002:a2e:bc23:0:b0:30c:1002:faa8 with SMTP id
 38308e7fff4ca-30c1002ff06mr39086541fa.7.1741734429113; Tue, 11 Mar 2025
 16:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
 <20250210-rust-analyzer-bindings-include-v2-1-23dff845edc3@gmail.com>
 <CANiq72=YhXGKLuEfvK5XnAsc0sbuf4FBRt_GnzmrZoW_L-S-ow@mail.gmail.com>
 <CAJ-ks9mSqxzV8F=SwGeHpXbRZ1814Cxk+AiyMnyjS5h94JqxFw@mail.gmail.com> <CANiq72=s8mtLQwWuKj+VER_rR2PzHv5JHEW5o026qvvidj6ZzA@mail.gmail.com>
In-Reply-To: <CANiq72=s8mtLQwWuKj+VER_rR2PzHv5JHEW5o026qvvidj6ZzA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 19:06:32 -0400
X-Gm-Features: AQ5f1JrExKNHqpFU2Dwz8YHy3ZNTlkUufHn3P1nhfrybqr2M1xrr33U3hp_afsw
Message-ID: <CAJ-ks9mEb=u6X04ozhmKs_ky5Cv_zE=mmqmWPCKV4Nk_3JVkpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts: generate_rust_analyzer.py: add missing include_dirs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

\On Tue, Mar 11, 2025 at 7:01=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 11, 2025 at 11:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > I don't follow this; there's a bindings crate at 8c4555ccc55c
> > ("scripts: add `generate_rust_analyzer.py`") - at least as far as RA
> > is concerned.
>
> By "before being in mainline" I mean before Rust was in Linus' tree,
> i.e. a long time ago in the old `rust` branch.
>
> Back then, there was a period of time when there was no `bindings`
> crate. At some point it was split from the `kernel` crate, which did
> have the `include_dirs` for that reason, and at that moment the
> `include_dirs` should have been moved too, but it wasn't.
>
> So we ended up with `include_dirs` in the `kernel` crate for no reason
> (because AFAICS it was not needed until we got
> `generated_arch_static_branch_asm.rs`, but I haven't actually tested
> that in RA) and missing it in the `bindings` one where it was actually
> needed.
>
> (I was trying to understand how we ended up here just to double-check
> why we had things split like that)

Ack, thanks for explaining.

> > Yes, without it `generated_arch_static_branch_asm.rs` is not found by R=
A.
>
> Thanks for confirming!

You're welcome!

