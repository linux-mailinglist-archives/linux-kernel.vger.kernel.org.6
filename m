Return-Path: <linux-kernel+bounces-531273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A9EA43E72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6523B07E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C44267F59;
	Tue, 25 Feb 2025 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGcZCtM5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BBA267B1A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484436; cv=none; b=CG18fucVPRNrVReBqkLUPivLjF2At2ffTGjdcrtzqxuc7XRf8m/WnhQ+IkxNfsrubBDoyQ3jNcZtVd+Qhyev3MZ72uBnILwFGY/kZqYHlgwi2ezxjrnq1MxVPuTThY19X7AkDsNxS+DKueIDm1twtuX6uF6W+TxwmD6hf41Xahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484436; c=relaxed/simple;
	bh=a9fb9/Po8fkbGsNdxEzFM4ny3tzW4+avELTv+pAGvKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7mnoo4K+EzbD09i8+7nAo7BNFGHBbmF9FupDXP/IR/AXJRE41PfBKcE5mqHOtfk+h1ETvrtPU52ocRp5GThvXs2j1pg0xWJgIrWYPCm7qDY8twp507xg8Ysxu45O+TbfJGRnInaX/AjhGij+W/i32Rk9RFVeX3tGu9ehGtl6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGcZCtM5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439a331d981so47713365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740484432; x=1741089232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KKh9bgDpR6Lw5wYeyXdJoUFBHhy20zpW+hZJGoTw/I=;
        b=pGcZCtM5kpkIoddGsPoMKiwlf/bOR+Rmy3xhb8OQ0rBQa9vQGGwO5S4DVcZmBx7s/c
         f1xvjTIcc9JUxaVP2fIbrqhf1qPTAnjcMPHOVDG2aH03mpYUmlogOrQYv6YcCoLnIscv
         c7VYEJe1CVsAZk7eFGriEVMwVLX34IlyE43isLW7DJkbY9Lb1xisYkWWUNDEsGsir3ly
         EMR54WsGiDnyf1oTdS45ItkyGo+c3Tvui4Heecdn+kxboq3Ou07WtP/pmqVaMc5pRQjo
         gj7No3xjaX6L68aKcYSiT0k04j3T4Z2ByswSlx1vfm6QQtB60djgG9dJPOXuGzbCpqe7
         pDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484432; x=1741089232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KKh9bgDpR6Lw5wYeyXdJoUFBHhy20zpW+hZJGoTw/I=;
        b=mGg6mrpZOd0umNmrxqmYSo1Igo+0AtSRzYQOA/RCHFrHXw76FwOFtawP5m2Gl0ATuY
         A2/KQWtk+FPtMyEqylTqJj3o5AOUX1bTI1JWPonD28PBy45/d1EG+R82IiBhYkZfBX85
         B1wfMADPETVufS3wGOrgKoGQiTapdlEZ8d7BjzBxYYuSQMijQB9qLkQNL8O14csQWBz3
         tj4S+du+/4bmXCGdGmtctE6m5JIorqef6E7uM1ANooSW/KtVb22vsapRszdFSt7HinSe
         eNmhmr0Aoc7T1O+YxPHi7qBib0hYCG8bUIAV1IXNgsqDjF20nBu6NeJrYVmdc1TpLKF5
         2JCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1X98beU0PtrHr488P6VrbubRG9PkYz8iDYleyBiKbBWdbJ/XIk21krS08iuN5K9Zu2fYW/I7/X0Oh1dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFtornxyRtUpGM/KuJHLrU3WJZS8ry/lWJdE9MBfe4pGti14e
	xU+hjhv9znclsmLzrdkOPoevbNXFkCoLwcyPkmeBVQaE51dp747BCTlK/fA7RkhWGjwN19w0up6
	GwOvbttZ1Xt5zeGBbxzu48DhNsD9XbjqOIuQQ
X-Gm-Gg: ASbGncsB0K4h/5Gp8e2vj2Ip8bc0AyuZ2ruYRRL9l1PjIV9M0ra40jQiVfCQBMdUr8c
	Fn+KYWHEwfp3uGM2zYQHjt08BP80Qwn2XwWTOZtrz0268HEzig0O8MJeZ9KlFJ5vfvGPSYlGt4I
	8kOx5r59lJA0u1XcDd1cu9n4iT3HmpSqguV/Jbsg==
X-Google-Smtp-Source: AGHT+IHqY/a0ChgzNsrPhlIq4n2vGB9QqapOJaINrWTcYZxBCWa17WZrPYgX7RCd5da6qGdapIXwpxNB4adzRUzEdrE=
X-Received: by 2002:a05:6000:1a86:b0:38f:39e5:6b5d with SMTP id
 ffacd0b85a97d-38f6f09f959mr15938375f8f.44.1740484432531; Tue, 25 Feb 2025
 03:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740475625.git.viresh.kumar@linaro.org> <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com> <20250225114830.64p56bndn4hkkkgq@vireshk-i7>
In-Reply-To: <20250225114830.64p56bndn4hkkkgq@vireshk-i7>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 12:53:40 +0100
X-Gm-Features: AQ5f1Jo457oNbGYfpXGn9Th4VDyFePvYBY05vhtLSFU8gDXlKbKgNgPnMpCHaRA
Message-ID: <CAH5fLghUDz8tpkTuvWZgwT2_VKgxuS+iZKnoT4prKwS9tbp8wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 12:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 25-02-25, 10:55, Alice Ryhl wrote:
> > On Tue, Feb 25, 2025 at 10:47=E2=80=AFAM Viresh Kumar <viresh.kumar@lin=
aro.org> wrote:
> > > +    /// Creates cpumask.
> > > +    #[cfg(not(CONFIG_CPUMASK_OFFSTACK))]
> > > +    fn new_inner(empty: bool) -> Result<Self> {
> > > +        let ptr =3D KBox::into_raw(KBox::new([bindings::cpumask::def=
ault(); 1], GFP_KERNEL)?);
> >
> > I don't really understand this CPUMASK_OFFSTACK logic. You seem to
> > always allocate memory, but if OFFSTACK=3Dn, then shouldn't it be on th=
e
> > stack ...?
>
> IIUC, the idea of the config option is to prevent stack overflow on
> systems with high number of CPUs (> 256), in which case the memory for
> the masks is allocated dynamically. Otherwise a local variable, in a
> function or a struct (which may itself get allocated dynamically) is
> fine.
>
> In the CONFIG_CPUMASK_OFFSTACK=3Dy case, the cpumask C core does the
> allocation and the Rust code doesn't need to take care of the same.
>
> In the CONFIG_CPUMASK_OFFSTACK=3Dn case, the allocation must be done by
> the caller (on stack or heap) and the cpumask C core will only clear
> the mask.
>
> I tried with an on-stack variable earlier but ran into problems as the
> memory is shared with the C FFI and Rust moves it unless it is pinned.

Is it a problem if a value of type struct cpumask is moved? It looks
like it is just an array of longs?

Alice

