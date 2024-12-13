Return-Path: <linux-kernel+bounces-444848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158959F0D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6341169322
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AFB1E049C;
	Fri, 13 Dec 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmmdk4ka"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B201E00AC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097255; cv=none; b=amOVDqT0Ezp5MqE70QjmmSnI7mXxbl1WRklkDPm3Tc9NWQ1HExddlTk4YZZyt2u7AjM/OPm9H3t0rgXlFLPgVItvMIiNwxY9WdACF2Qt9Sigxri5jz5l0wF7V6GDf+qqcm+2VKga6qhunqJcr5M+2wj0M/Re7Loa9JZXOUngE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097255; c=relaxed/simple;
	bh=6BOuUIc5npUiQopcZE5cuoM0QROOgdxco8qfJx9ocYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7d+Tg63wLFI1eBWcSQs8RUohbo37g8U0nJTYvpfWQun8DkD+6aebyMDURqKDHfQ0yq2DEwPEB8RIl20hl1GOXscO5ZP2S2F+PuqMQ+5be1EuHBEil7VT9iiI+gQ7bTd+aqkCtGWa7BpBwd7nE8TPU5Lg1hK90OhiG8U7IrtYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmmdk4ka; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434f80457a4so17619515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734097251; x=1734702051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnJdGj8IRCH6wN+1P7eGmBTzbr2q1/CwaJHQOUXIuXA=;
        b=pmmdk4ka+e4nXjCqO8SbRIe1BwFWdDNe+xEQ85WEazISXkdMv8cEFm1hE1sSqmhHfx
         dvk1V0wRyihrCU3p2pH4q7Z3ZcgmypsNtfYUsBNc9569yQOrN03+GUld8IjcM1/Zjexe
         JcHqrhVPKT+4bkbSOynlnujCxFokOLRW6RzJ9lZOl8bpx9ZjrWsfiIWnCYuG0TK8fmZC
         Ga9puJjzUpvr/YDSa6NU7tMLuP1UabEsQ4m2PJPt3pwxsIWtyybMawT7ISEc8Q1cnaF+
         aN3DimpkrdLOysA+KsTPQiTePfU9unESszhJNkU5esXzMGIPi7A53g4vM64FvZpMZqgw
         kBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734097251; x=1734702051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnJdGj8IRCH6wN+1P7eGmBTzbr2q1/CwaJHQOUXIuXA=;
        b=PXEpUZ46BchudOb2OvaOXElUnWO9YsPFGf8m1Clvfd0M+ea0QxFsJF103BIfs9Ruh3
         42JVdI6FNEx26Abcwsg44oAPnduCssx38OC828AA15qbtRd9G5qhvp3M2AxGhHXqn5Ic
         nd3VbbZjpHBgVC/Ry5BZLuKrCMyCvZg7U2ta94bxFaybZi86bkxYewNmACaetFW4z4Gc
         jNfRIRi07SjUTXIwYqzvRmWCMP0OhNhq+xSM32CuKBXxR8iGrClWaxDcHlz20EAU8yxK
         AS9rAbzOQebqQcIiSNk4yS+Q2933ynHWkj5PyS0Vo14pB87I53Hn67iBKApmyNGvo0DG
         l/tw==
X-Forwarded-Encrypted: i=1; AJvYcCWXWifLEhhACAvmPySKelYDAlD9jUEIszsjQS7wez5QzvwcgATzrvhd9MHseqU/WLJJQYGX0vp7bALMRiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpRV59NRUc1ly01ZIWnqNgAT+WIHhZ0jrYO4EQV9nKQOBTEUE
	zLeeO9WaOW4E0jJP96GvCnxfK2RjlFVLFHcj4eQjnU+GB0/8KV6UO5avumEE+YDlssDvrvm/ipF
	LlfDicRvZT4/bNsZ4AFWrepELaMjHubwZAIZ4
X-Gm-Gg: ASbGnctA13wwOE8Iki2qrfzeLhR0GTR+j3PAVyKahdBSJZyncQ0ZQHr0EtMDHDn2qZz
	nZNVVHFO9kqstMEobglJjdZFqlkHnQg1n44ErHMk=
X-Google-Smtp-Source: AGHT+IFpwXyaMsDUR1OnzTsQN9vE6i77r98xrJD0Rz0VjFRoXav5Ec9rNnu/HRcQPgMHzFvhoDZVZBy4mlujW19ixCA=
X-Received: by 2002:a05:6000:1543:b0:386:2e8c:e26d with SMTP id
 ffacd0b85a97d-3878840808emr6014625f8f.0.1734097251425; Fri, 13 Dec 2024
 05:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com> <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
In-Reply-To: <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 14:40:39 +0100
Message-ID: <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> `XArray` is an efficient sparse array of pointers. Add a Rust
> abstraction for this type.
>
> This implementation bounds the element type on `ForeignOwnable` and
> requires explicit locking for all operations. Future work may leverage
> RCU to enable lockless operation.
>
> Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Inspired-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

This code looks okay to me, though I have one comment below:

> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        iter::once(unsafe {
> +            bindings::xa_find(self.xa.get(), &mut index, MAX, bindings::=
XA_PRESENT)
> +        })
> +        .chain(iter::from_fn(move || {
> +            // SAFETY: `self.xa` is always valid by the type invariant.
> +            Some(unsafe {
> +                bindings::xa_find_after(self.xa.get(), &mut index, MAX, =
bindings::XA_PRESENT)
> +            })
> +        }))
> +        .map_while(|ptr| NonNull::new(ptr.cast()))

> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        (unsafe { bindings::xa_trylock(self.xa.get()) } !=3D 0).then(|| =
Guard {
> +            xa: self,
> +            _not_send: NotThreadSafe,
> +        })

This coding style is pretty far in the functional programming camp
compared to the rest of Rust code in the kernel. I tend to stick with
a more imperative style to be more familiar to C folks.

Alice

