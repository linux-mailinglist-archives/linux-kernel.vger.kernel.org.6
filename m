Return-Path: <linux-kernel+bounces-538868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C6A49E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5131895B71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2526FA5C;
	Fri, 28 Feb 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfHjsT/R"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBF1EF366;
	Fri, 28 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757901; cv=none; b=ESIiBaw4/Oi+EXuctTQ6p5WZdTTlTh3SR1Jn849T4OB9ZYUA3sVWKMsD4hA4XJcGzxTH/4cl04MlviITA34yVT+3OgDgMzDUYO9py1GwKG5ZyBOl1f5Z8wwPtNMJcHlyPDbCD4+3HFh65M6FHNGyQgkxsdztvLf9pOiuTfHQLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757901; c=relaxed/simple;
	bh=GDE5lRNIEVnG9s48rh5Ph8gdJNwsLWWybgZuFpuFoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBYEXXKu9Q0v20fruzQPZIf6vilAvV8LHp7cgAeMdJspr+AGRPsNp9Lw2KT783Sse13dTgKd2yqIQ9vVctNQC/NoLO1/im3Hb0DXeVNW0k0AVaF5dCMuv3+q1ZQ7fs9Kyok7PIVx728D9xb2difJo98ga9bNuEzlhY7QJp0gaWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfHjsT/R; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a59so25305921fa.0;
        Fri, 28 Feb 2025 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740757897; x=1741362697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDE5lRNIEVnG9s48rh5Ph8gdJNwsLWWybgZuFpuFoqM=;
        b=JfHjsT/R8/KVy9K5pUVTUxCFzoIl8OzJFrmLle2UIL/XKXovFD7KXq/4HAz5/PSEZ6
         /biwiVhKnR6Br3J0K7ej1xakGsNygFrezTES9GdRrpFsB6b3FZgPKvw0XbiUi8ZWckKw
         LhoXXOYMxcIWc1VdcXrlPNC3iFaV0Jkct7nmjMvB+jjxRC6FpTmAvW9V5iLguN7RvRXg
         Yaa7zM83RZvymWUlLsfQK6JzX5qHOJnQPIaHiKddVltBYLTcHQLc9Nfwv97XOtww9Xjn
         rCEUWDcK5F0zqs4IxlpARkVbDLcNh5A5oK/rEyrT0Cr2JnKJyVyKE6NziPQmkltbjahg
         KxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740757897; x=1741362697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDE5lRNIEVnG9s48rh5Ph8gdJNwsLWWybgZuFpuFoqM=;
        b=GKXsRN1KlqSilXEzBC3kgdsF1UEEx9MJnbnfWCNKTEl84h2hXINJvWDFBrDbC5fj6G
         Y6XRx4bTgz8U71I8ysdNhZ9OY1W/bhAnw1Xop8vgTAwnCYWTMsDnu7HVp9CUyAQcphuw
         POSfibYW8XxUU495OFeHJ2eaV9TK+zjOqw7mg7eyw6nRVXqai/X7qx2jcpy1TrxfisVh
         f/0jDvc2QMHDRYA461F3EmVSc7F+cMLa4GuULgcncKlausa80Lzsn/Ue98ewUDAqBk+e
         5EVzwJoclah+/liXoQkJ5B+7ccnpwJ1hVmshj7d9RF4v/WiOiwNtcCGA0QhbnlpKLMhG
         i1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVeM3zjn2KXIhHYWxEFxbZGeHoXDqIrwdZrgXCgEfBtcdHKXUbIE1O3vke6PVhLU/RFx9asYU/cRfUaMF6i2nc=@vger.kernel.org, AJvYcCW1os3tFXnnieMckuyrMFVd2XBQlKFPt7ULI60Ogiy78OOJrmL6siy1MoYsIPr4+mHQhwXkMHXJOEwvkEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbGbn6YFOG290Vlw5I3tfJNT7ORvBZdSnbL/9A1Ei/WdBBlnx
	6OVZ/314tGG03D2TQowhBf0xwy6Sn0zcST3DnHyE+2m5pu8T3xJbHS+rU1pzLIyh/uxsPV4Y9SA
	8BhIS6DE26F4JwiBx3lz9/JGD6Ps=
X-Gm-Gg: ASbGnct9Nh5dqR5E/pzKuXMCEOjdZLJONXsgi6/k88fkrXZVk8Zyys1DGLH2C/K4FJ6
	KOOsQB1zHQ2/lKvb1OYt5PElq3WIsY0qLVZHC53zLyOradn7qPt46GSUhQoa00BJsfkM5c/t1t3
	t63Lx2migNrSsvoBjbxaLKU7TLXWz8r/gR0Z1nXnSu
X-Google-Smtp-Source: AGHT+IE4MbrzRN3Jjm3xDjdLOZWYo8YGI7MexJ7wty7pA3puikvTmSwpKcPsIWgFD3PmvLZKz/wRIf12W7J7nWZ7J0E=
X-Received: by 2002:a05:651c:198a:b0:30b:a185:47d8 with SMTP id
 38308e7fff4ca-30ba18547femr1762441fa.4.1740757897170; Fri, 28 Feb 2025
 07:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
 <20250228-export-macro-v2-3-569cc7e8926c@google.com> <CAJ-ks9ng6AqmDynFebR+2_ZEpmvxkUNWdTed2vr0kede0dxcxw@mail.gmail.com>
 <CANiq72=UrPX4orjgFKo8LZj0PVsmXkLvQRxrgSwJrY_AfuTfEA@mail.gmail.com>
In-Reply-To: <CANiq72=UrPX4orjgFKo8LZj0PVsmXkLvQRxrgSwJrY_AfuTfEA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 28 Feb 2025 10:51:00 -0500
X-Gm-Features: AQ5f1JqCHNM2Ls7DXNSXpvAuhyRMc_ktjj0-Cd7tV3SQcTtiaAvIhWYES9_RhAo
Message-ID: <CAJ-ks9mmDeqaj+G__OkvCcerNvh3WkVDTWfJepNSdrwU7dyRsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: add #[export] macro
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:49=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 28, 2025 at 4:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > This needs an update given Miguel's comments on the cover letter. I
> > wonder if the code should also justify the choice (over cbindgen).
>
> `cbindgen` is a longer term thing and more complex, assuming we use it
> in the end, so I think it is fine going with this for the time being
> -- it is straightforward and a net improvement.
>
> Later on, if needed, we can just make `export` a no-op, right?
>
> It may also be useful to have the exports "explicitly tagged" this way.

Sounds reasonable. I was suggesting that we document the rationale -
not that we change the decision.

