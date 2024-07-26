Return-Path: <linux-kernel+bounces-262980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7C93CF62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F052281452
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3BE176ABD;
	Fri, 26 Jul 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOnkRQJK"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F717625D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981708; cv=none; b=QPchlm0TBX73XXkBvLfPhB2ULlDP+pEt44XDcb74P970Ov4Ov17nLEQwqbIbH4nqxhK74xaEJyPirD8kVfQWZXvg5Gc4hDrTyh2dTpHJHttsPiFP5PxGj6Av2KpUCu9BWN3Q0Cgh7lRXT2gTq2cKfcLeY9Xs1ASKyBmFgB9sKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981708; c=relaxed/simple;
	bh=WUXF4cHSMIZbofUj+HCSNs3kDoKeQX31JhVld0gXxE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9+qQ174qBeECjCq/yf5a/DP6njoss6GMSogQpdBR1CE7JbIKXEq+JmRoYx0tlRmX8kogLSTnXRA9J/AvU61g7vd07r/NrFwkE9VgRwiR8gCyDEJo6kiEslK7mcwLh/peWNEa32COKF2NMPSF6k5DsYa7omtB4BbbNVuMVzXM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOnkRQJK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-368313809a4so1732294f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721981705; x=1722586505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjvUXRHyafAOxO1P1TeDnrj5lpR4MgApipaUexR3DIY=;
        b=GOnkRQJKBcgbaIOl3jqvPvrDKOPwmyCcrLbUHgbKDvIIhmP9Pir5B5Gr5iFlz0yrAQ
         cUjA3n7iLpEsS9Tm6SPjiGs521b/bq8zSMQ5EIg6ReIHknV1ahN7G1OWcpVGBdG/xkfQ
         VIYDtPfh9NIVs9JcvGRpKnptu5OcQTYu7YSgeh/zzfErvH0tzj1WRFP287pH4rJ7HldG
         wtOTNTif5OjAgwvmo7mUsIBLFkcpOU57jUmmMKij+b9VAthlw58mJLN+FB6/eaY5+2d8
         UjP7y8wk1W5F/JBNEbl1EgJKhJR6XpXPmFN+Y9THYOdbez/97JtNvr3tpFiMQk+F6g7h
         4i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981705; x=1722586505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjvUXRHyafAOxO1P1TeDnrj5lpR4MgApipaUexR3DIY=;
        b=dnBOZxc3IPjq+dEbDZ5JhZ5f9xPtv4qedu59ZIbkOWUkpCjCMVEgYOL5Le9eeTqAIo
         Qaz7BNKM51qQIKiWaszvGM0n6mAhpdcjGORQLy8ebr9u9e/Tp2+xJeDDnNVLMQwIHgfR
         7a0rt98xHgFo3ntUOZ+vqyJeSaKbthQcp0vAUO4xXebRPdmuXIKA8nJTWMfGa3RHsu8s
         +WEiOEkarzg6vQ6PbTDV7p1gdhxnlBWpk8/tGWRF1EHsubXCnEtg4xEc1x7yB8CbJpOe
         pJX5r/t4QxyzSX5UlAzoHuTZnUz+yZdp0cJ+mVljqQTeANrWmeG3z+BobMPJR/P0WQIs
         /Puw==
X-Forwarded-Encrypted: i=1; AJvYcCWf8IZ3l9GhwLITUNrh6FXrsTkVmK6kbao18UKhHYaksFl5reU82iN99i+PFn63EroZgcP3RW6Ks8Db5X2gua7NRgduI6niIeMHxg2N
X-Gm-Message-State: AOJu0Yz2xBfBXSuon4wQXS0dvvPpKDUVwpWTVeiNOAx6VMfnTv1EV06o
	pH6r4cIdIbio32bdUXanR71AMZuBP9P15lsSP5l1zHX+vNyr4hXlcBxhQTpt2zs1j6/Jpi9a9XN
	RSf88pMFfMCIE86tNByaODbk6WZqEzPmtNc+w
X-Google-Smtp-Source: AGHT+IGAYV5/wJgMUc0BHUbBo9+VPtYNIQeV16LrOeWH8imtbYdIWcBEFjfmQ0Zs3iiLis1elqPhIgNXqTCkczodUcs=
X-Received: by 2002:a5d:6b09:0:b0:366:f455:e7c1 with SMTP id
 ffacd0b85a97d-36b31b9b227mr3300733f8f.27.1721981704862; Fri, 26 Jul 2024
 01:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-vma-v1-1-32ad5a0118ee@google.com> <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
In-Reply-To: <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Jul 2024 10:14:53 +0200
Message-ID: <CAH5fLggDDXmD8Nj-r0_bbEfquuKfOeH7bJkcA4GA=kKk8=gi7w@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 23.07.24 16:32, Alice Ryhl wrote:
> > +pub struct MmGet {
> > +    mm: NonNull<bindings::mm_struct>,
> > +}
> > +
> > +impl MmGet {
> > +    /// Lock the mmap read lock.
> > +    #[inline]
> > +    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
> > +        // SAFETY: The pointer is valid since we hold a refcount.
> > +        unsafe { bindings::mmap_write_lock(self.mm.as_ptr()) };
> > +
> > +        // INVARIANT: We just acquired the write lock, so we can trans=
fer to this guard.
> > +        //
> > +        // The signature of this function ensures that the `MmapWriteL=
ock` will not outlive this
> > +        // `mmget` refcount.
> > +        MmapWriteLock {
> > +            mm: self.mm,
> > +            _lifetime: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// When dropping this refcount, use `mmput_async` instead of `mmp=
ut`.
>
> I don't get this comment.

The C side provides two ways to decrement the mmget refcount. One is
mmput and the other is mmput_async. The difference is that when the
refcount hits zero, mmput_async cleans up the mm_struct on the
workqueue, whereas mmput cleans it up immediately. This means that
mmput_async is safe in atomic context, but mmput is not.

Alice

