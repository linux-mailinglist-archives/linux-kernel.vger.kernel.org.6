Return-Path: <linux-kernel+bounces-364139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A899CB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B471C2178D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE041A4F20;
	Mon, 14 Oct 2024 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwkdnois"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E54A3E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912340; cv=none; b=RIVa+JPA/ihqFVuRCAJBtAQR7eueK3tVVGf1MZS+pkpyU7q7UPKfoIv2yE7SWGVQXfWTKnYW4J70PwOq6zMS9ljHSe3NpA8ECQ8SJGurtp4dm29b71wLKj2ljJS540T08XL/3PzYjXH4cJZhU5KbPbGyD9X9iUdGS3Ydvz/30Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912340; c=relaxed/simple;
	bh=D9ULmpwo07CAG1hQ8yl0FcU2WXv6pGnxGIrk1yXQUBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDYqLsgL0VXj1PILer0y6JNBY2bp2IFLX6TzSA0ONdqbLf/KABtZ24aeOAjz+ePQP8Nkt19HiCSb4kAz2muWndoRtJ7hMPj38T/7wts4JWOxRGt21Ca7RUoKHg0KGhvEhs+MamZ6bSeqKxsLi1pfUTmUPJxluyP6X4tGwkHtFDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwkdnois; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4612da0fso3078561f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728912337; x=1729517137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcw6vFzAeM6V1uYExGMaM9DjMaXwb3dLyeYvVAn2Ehw=;
        b=qwkdnoisiZ8HyWGLX2ltPO04PWpqxbe52Ns1KcVKy9Om+k7y8CpUSHqDTZcDQwJu+H
         XLUhuBfqR0URS6iWS7xkqcH/BvH9bM45RqftYo5sZP6llVffshpRo8zpp5S4Kk7JXEsS
         AvarNxHQY8KSchz146CD9VgEZgEG3DXZXLTxW7cpuHwGe7iqKqBYKg53CgQMzjvXLEBg
         9j+oty1eM6PGw5wFXlpPANWPJ+h4ZWf6nC5bmri7q0+BzKH8Oy83o/UcqcI+u04xDlYv
         zCYX4LdajnOEfUssrEcPFBFFNcp668bu5Yx25iVEhYtYVFRAn7s4I7T6/WVadRidYghZ
         WS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912337; x=1729517137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcw6vFzAeM6V1uYExGMaM9DjMaXwb3dLyeYvVAn2Ehw=;
        b=HwgzcjF/2Dht88im8hXl6w0zWcYW1eHva15FF/MzTIXDlOSpHedhc2F4QZ+RfSKSDm
         VTzJrZhvf/QaXOuc1pKksWssLopAMCEFgSr0bPXOJHUQoztSoKM8XBFVNaHuJvJ/UN5G
         WH1Tc2hkhun2ImhUQHm+fIew7HmjpWkSQv9JgN/cTC8EuyCR8vOcDIIa0TRkSmY/7hF6
         DnfpjWya4DMPK1jZOt+VtRItggzblGe4rQT+urd8/+jWFpIcrZICeUWfxED501RIBCIl
         n411i2hxJA0qibjp6r+uxOqcqMY/tj+qaOBM59rJzl9K2EbUCMbfJEYULeI7TqXF1PGj
         9Ghw==
X-Forwarded-Encrypted: i=1; AJvYcCVlfYsHLmeu5GO6vsr0wA0VtQwQTfTXWu0KY7oTHHjMtikbMKKCMkdqcUR/ygTcUub0RFBCrU7PYylGJyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qXsd0bjnTYfAXw1P+z1XfwgdfXu0rQSyOF/VWalrZTy5VpNz
	6yS54iSeRc6udRnYQgB8EMBwdCCB/fiB/1jJj8T609mYCrNFn/oEL6q7jIpnRYkNAmQbNwrL0bC
	x/jUUqheaQYrOQQw3Hf5LQ7OAX2SUAFs0r3dR
X-Google-Smtp-Source: AGHT+IGh9g25AxERQtC7Q/z3tZszAdR6jVdmK0ErRScTUABwGozUjqMJMTLChIuJXgSGz4cvgAjijGBqFoiI0/5liCU=
X-Received: by 2002:a5d:53cd:0:b0:37c:ca20:52a with SMTP id
 ffacd0b85a97d-37d551d4f7cmr7789713f8f.8.1728912336980; Mon, 14 Oct 2024
 06:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-shrinker-v1-1-18b7f1253553@google.com> <20240914140745.7b0e5d5c.gary@garyguo.net>
In-Reply-To: <20240914140745.7b0e5d5c.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 15:25:24 +0200
Message-ID: <CAH5fLgjqksLOOzEyPBDN6Ym9DKpuifdxte2a+NJ-GNQoyUe35g@mail.gmail.com>
Subject: Re: [PATCH] rust: shrinker: add shrinker abstraction
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 3:07=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu, 12 Sep 2024 09:54:01 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> > +/// This struct is used to pass information from page reclaim to the s=
hrinkers.
> > +pub struct ShrinkControl<'a> {
> > +    ptr: NonNull<bindings::shrink_control>,
> > +    _phantom: PhantomData<&'a bindings::shrink_control>,
> > +}
>
> I feel like this can just be a wrapper of `Opaque<ShrinkControl>` and
> we hand out `&'a ShrinkControl`?

We need mutable access, but using a pinned mutable reference is too
inconvenient. I prefer this.

Alice

