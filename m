Return-Path: <linux-kernel+bounces-353481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1B992E6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CBE1F220BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2A1D7E52;
	Mon,  7 Oct 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3M1+eG1D"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B51D5CDD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310145; cv=none; b=Jfu5zrX6w6l9yQjVqBSIuDSFm4++PS6mjc9UMkn818vpLNa/tnKUR6K5Xfon5RI2R0f2IsQS4fE2M45tzOuQnnILTV3g/6d4LVNSl25GpQLwJ1APtD0U8UE23WGgviwMoyhy8pSbwEmF2xhJ7cncB09/WN1RidWkA6StzjFUTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310145; c=relaxed/simple;
	bh=ivFBOmv6ledmK5xGubGTRk1bSWqSMt6FdYU0h0kX9pQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNVIjfesDLs/108r4iWBk7J2tCESFIt/IqNyvbIrRCS2Fr8aP57jX+89gsa39W7oHZEj6VNu8RyIbGfgNC8FJo7+kEfYkHGTDJEKhn+JCIzu6Vo8AXjMeru4TWg/y0YvkWk38tq60fOoP3yqyjehVNfm8SKwHkByvXxBR6mDL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3M1+eG1D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5399675e14cso5053137e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728310142; x=1728914942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKZvIK45MDR9TD/1XroJvoyFAFi7DQfKK13CSD5BTzY=;
        b=3M1+eG1D4TyrOavhNcz6nmkr0W278/ovBoPe5T09mRDlSExFKYnKoCU/6nB7WNyFWY
         TX6p2Dg5EfUXhL1NFX4DHPdkN6/yaAY3GeodnZCQGnuNoIM8NXToP/ZJIgzAZNDzKNcI
         VKVnPI2DutdOQAGHh+KpRvMlQIiVGpL35zS7H3o7CK427jrvbJGgJqVHpGmgEGG0ynL6
         Gq4p1CgnbB1xz/T/wizs0IgovexygPtoGQu0BgTaRezh2bhiCQOTe6ayPn3M1xkTJYkk
         MTfefzmzQdymou3+XuIPR5+2NBoN6pJEaD9/f52QccAiEsQk4nQwfTh1+aAHJjrF0x0j
         LgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310142; x=1728914942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKZvIK45MDR9TD/1XroJvoyFAFi7DQfKK13CSD5BTzY=;
        b=gBOXNTafCovoOfwJDKCt2tL5goV6RRtdcAbgDv4GFTftqH+5yfOumlZeIS+e4z3OC3
         UQjLNz27wY5bU4ph0Fq7sSdYlZiFmIMysYcHaszgWqbi6+qALISwIKJM6E70Zc2hb3N9
         PTmDLPq8UqRZCwaPNT7WGLFRG2wYIxLpkht2tFcx1lObBvUfwU5rHgoFg/EOrAX9giOf
         m3sJHF0N95ayvKkT45NHrvtJOlkPEmIfzQfhlcqFSkMdXSFAcZZuzZwmq+gej6FvjjrM
         +YULdUkTGpWOyFVYbQ4tc8hPtR/dQJP3gpjpTPS64rlNQ2Qp+p/eHfJJriPJDqDWpGfx
         +4HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLnrzvqT2i5Kbc5bl2vKabWewItNp7GK+lWf8idKA+4k34tdIHL2angToUbZGMxMMs/Z/c91T3CXMg1Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkvOfc5M3Y7j4xm+V+LCIQ5/oos4y8KtOkQFkkCkfcOLsPCfi
	ULKMfiJVFk2nrCQDTJRAjvf7kwateAGYgk+UFJ+JFuD3wwx03AKuTVQXCX13umf7nJg1uQTtuwW
	n1hjuQl+BxBt4F3jLetm7uiEjAwQTcORBT1Rz
X-Google-Smtp-Source: AGHT+IFwTrVIqhDUFyPdVl34T+oKrSGlMdjLolmnCNjPhVYLj4MboC4l1jWOzAigrl97+qSrM8ogZYoRsH321EcL9EY=
X-Received: by 2002:a05:6512:e93:b0:52c:daa4:2f5c with SMTP id
 2adb3069b0e04-539ab9d0331mr5921302e87.42.1728310141515; Mon, 07 Oct 2024
 07:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com> <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
 <ZwG8H7u3ddYH6gRx@boqun-archlinux> <e17c0b80-7518-4487-8278-f0d96fce9d8c@lunn.ch>
 <ZwPT7HZvG1aYONkQ@boqun-archlinux> <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
In-Reply-To: <0555e97b-86aa-44e0-b75b-0a976f73adc0@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 16:08:48 +0200
Message-ID: <CAH5fLgjL9DA7+NFetJGDdi_yW=8YZCYYa_5Ps_bkhBTYwNCgMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
To: Andrew Lunn <andrew@lunn.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:48=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Oct 07, 2024 at 05:28:28AM -0700, Boqun Feng wrote:
> > On Sun, Oct 06, 2024 at 04:45:21PM +0200, Andrew Lunn wrote:
> > However, this is actually a special case: currently we want to use klin=
t
> > [1] to detect all context mis-matches at compile time. So the above rul=
e
> > extends for kernel: any type-checked *and klint-checked* code that only
> > calls safe Rust functions cannot be unsafe. I.e. we add additional
> > compile time checking for unsafe code. So if might_sleep() has the
> > proper klint annotation, and we actually enable klint for kernel code,
> > then we can make it safe (along with preemption disable functions being
> > safe).
> >
> > > where you use a sleeping function in atomic context. Depending on why
> > > you are in atomic context, it might appear to work, until it does not
> > > actually work, and bad things happen. So it is not might_sleep() whic=
h
> > > is unsafe, it is the Rust code calling it.
> >
> > The whole point of unsafe functions is that calling it may result into
> > unsafe code, so that's why all extern "C" functions are unsafe, so are
> > might_sleep() (without klint in the picture).
>
> There is a psychological part to this. might_sleep() is a good debug
> tool, which costs very little in normal builds, but finds logic bugs
> when enabled in debug builds. What we don't want is Rust developers
> not scattering it though their code because it adds unsafe code, and
> the aim is not to have any unsafe code.

We can add a safe wrapper for it:

pub fn might_sleep() {
    // SAFETY: Always safe to call.
    unsafe { bindings::might_sleep() };
}

Alice

