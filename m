Return-Path: <linux-kernel+bounces-245555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CE92B44E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7433A1C2090F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B33A14D705;
	Tue,  9 Jul 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5TI4TJJ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5184F154BE2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518410; cv=none; b=KJwYz0TjmcXh1RmvmfKtlxIn0DfPDHwZ2V4OrzkjAZS2r40nUSHVkIIyDtV8xArAbtLZA74GInFKLzykOaoQG+DKYDj0Fx+9YtWy7H/4OgTJ1k8pEdd6LSUcLIxZRTEnV7TMUFQAqS/v4Lp3tHL1N8qUHtcogre9DrqWT1s/hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518410; c=relaxed/simple;
	bh=eCQQDFY8hVymXwxKp1QUQeYKDxSsetFoWDv41bgZWKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEpXCqIOPIgYx18M2yMwVQSJIhMwCUdUx/pWZPx/hOyxny3QXOExEyWCaTkE4/V+K7kli/okg3JSflD5vqIAjuZfu+855HbkdKR3/jrANLnwOzHWeEdUtbNm0/5SXv6gMFfmFfCVRYJelQ6Rpw9IHvSG/xl4JQCQrPaPgzjVPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5TI4TJJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so3209708f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720518407; x=1721123207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAl22PofvTioHWfNt+bF1Jl2BsmrDxNKveilF7T4GJg=;
        b=Q5TI4TJJPfT9bqIXr+lPrwz7V5Za4GRxc4NhyGxzc5g9TwPpb+ne9WJn6PHu8U3tZL
         H1obsd85mEaSLKu3Wsjgzjbf6WjTRdx4s71PjMfPWo0KFMy3a1sNbVt9ibuRkqWYaTE+
         JBDFeb9CG2x5AUyS9jnPUBS9Kuq7KV+zHOXXhiGfJxLsxz6S1PhXYEQlgXE7q5I1mfOm
         zp0U/HZai/8Xju4cV6cZSkqMYHzTaLPKnLjtDoSwx9EqX2AYqAj1Mnfc2OP3yPhakDfd
         5obGbXT4uXXYFxUp3e3/P5eFkqL0Uv7e/95M1ksbNJI3YZljAUEJEB/Y7HfFTZeWKuqd
         TOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518407; x=1721123207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAl22PofvTioHWfNt+bF1Jl2BsmrDxNKveilF7T4GJg=;
        b=RLnQ+PTuW3plGralCDMc+9ec3nm2RsewyEACsf1qvHTmz6u/eZ+P99npHYVIIbootb
         ENmsx3qDVhbaE5JmFCeJcHgUaaUFHr/WUEdiqxtQUFWXTtiBKb0sCVXDHGMCsWqNaBlD
         C8tKJkdRhii3bkd3DUw2ZnnTq+L0s4WxGytYS1QMc5+jjbM+OKvTxgyU7oAieRyIK21/
         ECPpxloACHcvfZ/oYSfDOOw1fOUhZQY1tK0IB/HC2ggO5i5SoJWE9x3Qg52/1kCGD1lI
         C4pY6U5SXi8b56rESOqH2HmygB4apcHVFa/xBVgXHumiAZrSHzekQGcg+g3a/ksDWZss
         5mQg==
X-Forwarded-Encrypted: i=1; AJvYcCWaCoEBkrIIexZXtFOZJm1HVokvPcP5roXRLJdRzuLBeSdGkgHaaiVXUXpYVFv3+se+9Zjq0lpXWuhGh3mHYdH+AxFS1J8YI/Ml8NFt
X-Gm-Message-State: AOJu0Yw4PLpkirtE2rr2tLCGSEThNkebqYCCCLVppM17jYNpqbH3QeTI
	DYM3/Unt1GHBMAE4LEe8JEpxHuzaUGvN+4Sd+nFrgHRs9Cn5jNm5+/QJEyEnFhmgKb7C1RDcvZA
	WXe5Zyt3NIIUhsDFlwsoSpBL5A0smerbhOXQx
X-Google-Smtp-Source: AGHT+IFlHTSp/MVSEbMZitGmqh6j910gE+cVPG5i5gaBlx/eMJDN2xZthp+2hnjGAc7uIFJk4Z+rinA4ANAty8nqf8s=
X-Received: by 2002:adf:fe4d:0:b0:360:7812:6abc with SMTP id
 ffacd0b85a97d-367ceadb1edmr1187247f8f.60.1720518407332; Tue, 09 Jul 2024
 02:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com> <CANiq72ka=tMDHq3S2N0dkzj0DBje+kdz0nFtaQZ9RHC0rbii0g@mail.gmail.com>
In-Reply-To: <CANiq72ka=tMDHq3S2N0dkzj0DBje+kdz0nFtaQZ9RHC0rbii0g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Jul 2024 11:46:35 +0200
Message-ID: <CAH5fLggUcj=qne9uO8O=OGZgcwbhKMAJKpPe_s6Nd2Bbd+45JQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Memory management patches needed by Rust Binder
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:02=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, May 28, 2024 at 4:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This patchset contains some abstractions needed by the Rust
> > implementation of the Binder driver for passing data between userspace,
> > kernelspace, and directly into other processes.
> >
> > These abstractions do not exactly match what was included in the Rust
> > Binder RFC - I have made various improvements and simplifications since
> > then. Nonetheless, please see the Rust Binder RFC [1] to get an
> > understanding for how this will be used:
> >
> > Users of "rust: add userspace pointers"
> >      and "rust: add typed accessors for userspace pointers":
> >         rust_binder: add binderfs support to Rust binder
> >         rust_binder: add threading support
> >         rust_binder: add nodes and context managers
> >         rust_binder: add oneway transactions
> >         rust_binder: add death notifications
> >         rust_binder: send nodes in transactions
> >         rust_binder: add BINDER_TYPE_PTR support
> >         rust_binder: add BINDER_TYPE_FDA support
> >         rust_binder: add process freezing
> >
> > Users of "rust: add abstraction for `struct page`":
> >         rust_binder: add oneway transactions
> >         rust_binder: add vma shrinker
> >
> > Links: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0=
-08ba9197f637@google.com/ [1]
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Applied to `rust-next` -- thanks everyone!
>
> [ Wrapped docs to 100 and added a few intra-doc links. - Miguel ]
> [ Fixed typos and added a few intra-doc links. - Miguel ]

Thanks, LGTM.

