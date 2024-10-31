Return-Path: <linux-kernel+bounces-390479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809F9B7A71
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EFC1C21E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A819CC2E;
	Thu, 31 Oct 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KORCNQa/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5832019C57E;
	Thu, 31 Oct 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377431; cv=none; b=LwGBUGH2fUf9axjE9YR21ZWf4WpGrlr+G0kaO5oHwz5mkYlvW/4NcIIBmo5Nnf/z9Kd5oaxXX9pqjh7vjpUCSQYu5DM2kuB3nILVpRg56ZhGZJ0CchIVvUErBSdjWr1tM0GS0AsYU8y5eNDYvsVCJ+P7nG4N9lHhqQPCiE4W4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377431; c=relaxed/simple;
	bh=cHnElZx40WtHGGv5vY7xCfA4p0WfTqZ/eNHcwm2Spy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEem6/QLutsk0ZhIVhxu/1JZXHDXMWJ2iPTQKp13kbesKWgyv0GaDNVoumcf7urr8ly7BRZ5gpr1swGG1prcBBy5MJw/LojAmCsEtvLJkFUIc9oZhfzTR1XC6pBG+VgQw1m2YET593NCqxXjq0XtblU7DAJIKlMq0ucnm87pwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KORCNQa/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so7195531fa.0;
        Thu, 31 Oct 2024 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377427; x=1730982227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHnElZx40WtHGGv5vY7xCfA4p0WfTqZ/eNHcwm2Spy8=;
        b=KORCNQa/pf6Tvm6Uw/gDAite/1KPmW2zbKeGzjxxgoD7QquxLrrszI8pG1ZSFfboXi
         nNUCuPoxNgnRECX6Yru/qnp6Jir0ArGNHtjFrBdrT23+UReruAC2hK1IJ5F4YJrCS7Ud
         1qjmgcvjb3jx6yznunq8B8bwUpMlMG+IeERXqkkidlzkcgvGyg/YACbiUGqgf0mwe2o3
         V7Kj6wcKkAovFtoi2+lNiRSMvR5o/mrRzf1hI7+xMxo5uKb49PEuQS0qyIASxXmIO2AS
         m+9bOOqf/ez/HYLATP5WX2Zl4ZiT4W9ZY0sUpOAEnV0CIAaem3oMykElr8CKLYqEun0Q
         gUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377427; x=1730982227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHnElZx40WtHGGv5vY7xCfA4p0WfTqZ/eNHcwm2Spy8=;
        b=T7b1ZGojCfFH5Uo8ODZQbqcj6gzYFwsn661BzjEdTr0Ra9jzmRiBno1V8VtcHTZaE0
         3kO3HRxc0VcV0MrD6hmfrnsqk6+IGIe/vqfmDxL1HF/Hr669R307sTozqIIj4pSMx44k
         2+d+TDHAgLCs8JJIMuIM3mEbEBK4jFFACCrO6CEVaD+reHyWRbGIZo0a00uV+MT6+81g
         bOv8LQ5bpXa49o+JhlFXnYt9oVPhbssxotQBuSvRwjkpnHcIdlKi/Aa8DOrE9FD6jXO9
         00g3pQP3vAPLAlRhETyND0d+bT+Z69bW39uNdY8IHfkXZgp0A32cNp7Sq4tknjWig+uo
         yxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdnPLrzqRXkXBDK7e/OoCpJbnIpdKko6mjRXeYyZhMXI+lfEoSS+a3NY+zn4uB3utyROkv9HFrkiZQXPE=@vger.kernel.org, AJvYcCWuXW2y7aN87BygKPJUH2LuQ1S1dc+3tYoRQ01XmUg/FIo0Ow1+JwCbRPyO32bLd+Df5JEq67Ixeg4Sgq4S4+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZFVDWcEQ05fIvCu+trakoj8d+7dyKRXHGkqLDMmpxBfMVrk3P
	5WyZuaAhng97QaN/yKHOaFmhKfFo2RxpGRKypDPtpSn+Vorp/tHrDvS1wiONtQeGIYHG7pe4arS
	h3omhfulCvioXBPD0Um5gSlfGP9RouNgx
X-Google-Smtp-Source: AGHT+IFZUYEA254Qk6D+v3WHD21L3+ILquiDWwnqdm2cnVHLdtKDJadjOimhdoQmnze34t7AwR6F7hUPD/zki1ClaPI=
X-Received: by 2002:a05:651c:1a0c:b0:2fa:d67a:ada7 with SMTP id
 38308e7fff4ca-2fcc940c781mr67851511fa.23.1730377427035; Thu, 31 Oct 2024
 05:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
 <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com> <CAH5fLggeAm1qobKzUkjw-+oNQRnCaDH2f2TTiRvmrRMg417LCA@mail.gmail.com>
In-Reply-To: <CAH5fLggeAm1qobKzUkjw-+oNQRnCaDH2f2TTiRvmrRMg417LCA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 31 Oct 2024 08:23:11 -0400
Message-ID: <CAJ-ks9mHp=uZUq0BN6D33+s-eEO1vN+1a4_mZahuqLD9-A1UeQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: add improved version of `ForeignOwnable::borrow_mut`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Oct 30, 2024 at 9:46=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > From: Alice Ryhl <aliceryhl@google.com>
> >
> > Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> > that was intended to provide mutable access to the inner value. However=
,
> > the method accidentally made it possible to change the address of the
> > object being modified, which usually isn't what we want. (And when we
> > want that, it can be done by calling `from_foreign` and `into_foreign`,
> > like how the old `borrow_mut` was implemented.)
> >
> > In this patch, we introduce an alternate definition of `borrow_mut` tha=
t
> > solves the previous problem. Conceptually, given a pointer type `P` tha=
t
> > implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> > kind of access as an `&mut P` would, except that it does not let you
> > change the pointer `P` itself.
> >
> > This is analogous to how the existing `borrow` method provides the same
> > kind of access to the inner value as an `&P`.
> >
> > Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> > immutable access to the inner `T`. This is because mutable references
> > assume exclusive access, but there might be other handles to the same
> > reference counted value, so the access isn't exclusive. The `Arc` type
> > implements this by making `borrow_mut` return the same type as `borrow`=
.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>
> You must add your own SoB at the end when resending other's patches.
>
> Alice

Thanks, I'll add it in v2. Does the order matter?

