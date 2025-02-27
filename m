Return-Path: <linux-kernel+bounces-536992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C75A486C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E83164CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB11DF247;
	Thu, 27 Feb 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJqhViAQ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079931DDC29;
	Thu, 27 Feb 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677750; cv=none; b=QmEEiRTg11gp79BEf7creCmB7bFbtySAVJ8CcEm/qjVGfQLVschfnamOF/xw67QjVGCJoyiS9Cy85FTtBYSBubJu/fylNAvtygmRihVYQrvE2jueTTalqlfBVRAGg06nDlh33rOCOApEvBPHoTAF5dPaVONbuZLIhZ8xeypTWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677750; c=relaxed/simple;
	bh=mbZ4jhZ8cJLd2yXxgJbu7Eds+oK78xxQLnalQNs0jiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCXjEJx5MBFpP4egTgU0RfS8DOJ6pH/y+BBS4FKsfvIazYVkKxEZXFGUN0YmBevCLRH37CpIhWxbgQgQixRzeQcGqLvpMB7Ah4haxHDX7k3vArJUKyM4vQa/6CNZ2NhazHV7uYiCVTfxwMVKur9piVKnnudCl7JJkIuY4eO5ysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJqhViAQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fe851fa123so317945a91.0;
        Thu, 27 Feb 2025 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740677748; x=1741282548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4grSqOZMcr4AeLl2348rl+pUCApMWP0TAJcpSJmaT8=;
        b=EJqhViAQwVzWvkp/kg8/rL181kMx+ENtqGFJCXYGRv4isaaWn8hy7XVsMycBFtxTj2
         MkYofsbwFZNAdAMhUMKbmse+456xIziQFtEwFIhVoZIieHacpXKzp6c1h+JPxYhCPffP
         xdgcq8gff1ZLXFi0LQlawaDg7CfbEj5nDKfvXZwiiaVWBxGGS/lKXBNRt3xghsNtnC8U
         OYj0spmB6hrWtJlQvmfadL/sGjeq0ajImZOyoYxLHbfTUy7jwCYnX/SnV6lrVy6irSWv
         d/UQ5/13JvTxSjGhpfrAlZoSbK+d9xNI3v8mlNo27JNm+XljR66/X25pQa098zjHT37Z
         4OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677748; x=1741282548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4grSqOZMcr4AeLl2348rl+pUCApMWP0TAJcpSJmaT8=;
        b=fOnl3tQPyzWdKF3N9ae6Oq0kOyPv+5QFNUdFb28Y9OVITQKDRwFf36mxmaoxnEpMiy
         XjrHPsrVO40AgVqzfBlGRb5PKwBRUyg/x3sGuQwVegp1hEsfGI1nBtMQMi5kJ0edCsmZ
         nC3OSPM4pdhQhrGFc4jI/UaQqDpm2aRqm/p3KACdkvn2ZIAT8Z1ZldQB2VImJM69MgQR
         d9zs2Zz8ggWlBHqeVvFewvDPkfDm/PZwg4qnKWvqPB65M8+uyIpeNTmH1xO943siD1uW
         AYhWyiQdoniJYVylUyRZvq9JvjMtW45JgpskFtgOD9fYPm6MNKERy8o6QMwQ+Femz9FP
         hFRA==
X-Forwarded-Encrypted: i=1; AJvYcCU8X7bI7awDalJGxqjdof4tx2qvTRAFfkNDbmm19fAUWhiK3j1+VZZJPTuNwWnEQZCZmOqm9wZbM/1o86I16kw=@vger.kernel.org, AJvYcCWGB3bjfVZi6KofyzdAvkIhgfFxaj8RPQmX2ZcwQDl4XwEm2fFGqZay5AA1c34KzgJXr2UweZVk0FszD9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0ZVllT3jsLXvMB/2FL4VOYkXV1DrWYFPrl0JqXAEgBq+ipKa
	l3ReiIWBWvvPOWOD/g60pbQn1S792LpsqwEeHDeTGJyMYnU+RkeQLQdObdKMpyxHIInhosuVL87
	+JEju3frt74t3swN5rS/4cuNRb+Q=
X-Gm-Gg: ASbGncveATNkfoOyQ17T0o0BjOe0Bzorll4OQH+Ve+pRYpCe/ICbXW4l24itOLPBKmi
	8zsuxWX2231Nlc/vWKOE67OyYpmRH7rJ8hIklVaOpls7/jtlFXeWFGHMCJxpo90/ABZEUO3jl/5
	2OYJg/0OY=
X-Google-Smtp-Source: AGHT+IHUchORsUtdm1yxlMwOcrNlOupYjquYuSxpOcVfPm/3p9K7lrlkAXjKRpGKq51BxhjDyuBH1A9yYkp4l5vFa2w=
X-Received: by 2002:a17:90b:1c0e:b0:2fc:25b3:6a91 with SMTP id
 98e67ed59e1d1-2febac0576amr82469a91.5.1740677748229; Thu, 27 Feb 2025
 09:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227101720.1811578-1-bqe@google.com>
In-Reply-To: <20250227101720.1811578-1-bqe@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 18:35:33 +0100
X-Gm-Features: AQ5f1JqyTr9uY6Jg-KT7Yzs_ZAVSPYm_gg7wc7b6YNYL_QxobuOM0KGJHne15PU
Message-ID: <CANiq72kaUXSTMmQCFKKF-OJNXuhi13xJcbAoq5iFbSZ0wwz61A@mail.gmail.com>
Subject: Re: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:17=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> +use crate::bindings::{
> +    bitmap_copy, bitmap_free, bitmap_zalloc, clear_bit, find_last_bit, f=
ind_next_zero_bit, set_bit,
> +};

I think it may be best to avoid importing `bindings::*` things, so
that it is clear when they happen and so that they are easier to grep
for.

I guess some of these may benefit from being inline when small
constants are involved, similar to what the C docs mention -- do we
want to have equivalents to the C "generic" ones that could be inlined
well?

> +/// * `ptr` is obtained from a successful call to bitmap_zalloc and

Please use Markdown wherever possible, e.g. `bitmap_zalloc`.

> +#[cold]
> +fn not_in_bounds_lt(arg: &'static str, len: usize, val: usize) -> ! {
> +    panic!("{arg} must be less than length {len}, was {val}");
> +}

Should these be more explicit? e.g. `panic_if_not_in_bounds_lt`?

Do we want to only have infallible versions?

> +impl Bitmap {
> +    /// Constructs a new Bitmap.

Please use intra-doc links where possible (and Markdown), e.g. [`Bitmap`].

> +    /// Fails with AllocError if `nbits` is greater than or equal to 2^3=
2,
> +    /// or when the bitmap could not be allocated.

Some examples would be nice to add, which double as KUnit tests.

Thanks!

Cheers,
Miguel

