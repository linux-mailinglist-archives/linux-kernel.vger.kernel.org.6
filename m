Return-Path: <linux-kernel+bounces-376265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D589AA26A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF91F22606
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1119DF98;
	Tue, 22 Oct 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tSu5DL4S"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697619DF48
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601196; cv=none; b=paYFSBf7DrRaGAIKF2P7AJAd92Im+8fpca61Gccp/a5sdGbjTOGmCdLdT/vvfC24SOXMBDJsRnptWwHvg5aHFhylVb8AXKj6CQxunyopZTmo1eJCwE3le5xyaZ3LZjdhC6x9iDaZlVWtfXmzgC5YwxH3KixnWu26CdJwJ2Vkbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601196; c=relaxed/simple;
	bh=Vx2h3v1y9ITGYk/4YqnyyI5UsVK+4L4HjGCwI5LwPHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLmmw0cIi481cb9yokUTNwRzJ1lXvJdSDRJZussQN+VywXJROEI0JyjgWBQsdTbN0JWcoEtnxqXLu4N0qzOg70Lg/UeFIAPmHJ0zJU/DSf5zWBNIHT/ob9TwnC+CtBcDDaEHUaNkwi9BY3E6Wq4JBxiR8Xgr5XT4yqwONQX9TCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tSu5DL4S; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so5042561f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729601193; x=1730205993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWt1QgZ+k4yosJJFZ2Lxkp6vi2dnYByQlfBoj3HTnos=;
        b=tSu5DL4Sgi1wuZnTAchlavyWjcSuIdk4FcneJ/j7h4kOGNpCsEV+5rttVTtHR6stH6
         2ZMYvZ4KKnTjAVxCeooBJZqFjUTb/ffO9PDMI+vfEMF91RQCh0tSRqY2917s0OHyIT3q
         f//i28yJEGMyBlUh1ShQFPHVJYzUnp0TBmnmyTsSfSDzDwFW1qJwneJCagllbpkNr0xl
         ZeCqpDKrXn7g5PvRCkBDRZr2xxsjxeWom063Ym8EbllT7UthVtb2JrK0qTPuRIMTbE/q
         w+ecVxMs418SQZ6gQdZsmI4bq3edRKxnaC+7kVs96dnfplgG6R0QIL9EQanMkOzXyH1u
         Ekdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601193; x=1730205993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWt1QgZ+k4yosJJFZ2Lxkp6vi2dnYByQlfBoj3HTnos=;
        b=o1TR8Kdvd2ko29enXYTZbADB7eg4hGsodD5xmXVUfNfDyJX4rmRKIzZ5JVeiTUTkrx
         +zPHUNiR6iIs3DjP2nBj+ujszH8edOtShvnkFT8rdkFt4lcN8MWUzk03xbOtT0BEUhXS
         tf01+aT2uTJfsPHoSCdokjbwKbM0fPzv+DLo1PXyqz2OblD3UB9YKbOLe67ZkW6Tn3vy
         ChIKnaXJ6IaWPTbGktcBMqI8ez08uB6sfeoYDZVFfkDJCXVF96+insBGdbwuRHu/Z7pc
         naKGJ7Qvls5cleljJN6bvh3csnsBAWkxW6D3YFGEwcXSHqoUj/TGrEO5HzLFf4Mj+TCQ
         X19w==
X-Forwarded-Encrypted: i=1; AJvYcCXmLPeSsV5GyKHgSeDeVTaPa5vU7H/caiHdp+2Pp3vmvi6woniHlaqdA3k6KxAUMbuA0gN3YHaiuZcpkK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxcJEVvlp35AY02AzRadpiJipGpt0U76YybAsxVMUx9LvVvzeC
	ORDEi9sTJSBrdr5hWQpyfpO9M1MyOQ4Fc3hdNCKiDqkTUXqA31Irt3E9L13fjspyyTsGrNfPSBA
	Py+bootLQkhczGoJDaTNPNkEMsLMTHOuTASTI
X-Google-Smtp-Source: AGHT+IHHrb1ZvDYKv4j0/c2a3JEmXpHadHXvk776QJ9rlhtlmkBkz9Vi+wH6TGQLWMsWaJaZ1alAT7TfAiJDX888U4w=
X-Received: by 2002:adf:f9d0:0:b0:37c:cfa4:d998 with SMTP id
 ffacd0b85a97d-37eb4768898mr12672840f8f.49.1729601193295; Tue, 22 Oct 2024
 05:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com> <ZxZxzjEaSZ8e_6mn@boqun-archlinux>
In-Reply-To: <ZxZxzjEaSZ8e_6mn@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Oct 2024 14:46:19 +0200
Message-ID: <CAH5fLgg=Hb5NDaQQJW4SVh+hCj51bp+BzCMQs=Pg_L+_MMiZgA@mail.gmail.com>
Subject: Re: [PATCH v5] rust: add global lock support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:23=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Oct 21, 2024 at 01:17:23PM +0000, Alice Ryhl wrote:
> [...]
> > +///
> > +/// A global mutex used to protect all instances of a given struct.
> > +///
> > +/// ```
> > +/// # mod ex {
> > +/// # use kernel::prelude::*;
> > +/// kernel::sync::global_lock! {
> > +///     // SAFETY: Initialized in module initializer before first use.
> > +///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard =3D MyGuard, L=
ockedBy =3D LockedByMyMutex> =3D ();
>
> Thanks! This looks much better now ;-)
>
> But I still want to get rid of "LockedBy=3D", so I've tried and seems it
> works, please see the below diff on top of your patch, I think it's
> better because:
>
> * Users don't to pick up the names for the locked_by type ;-)
> * It moves a significant amount of code out of macros.
> * By having:
>
>     struct MyStruct {
>         my_counter: GlobalLockedBy<MyGuard, u32>,
>     }
>
>   , it's much clear for users to see which guard is used to protected
>   `my_counter`.
>
> I prefer this way. Any concern about doing this?

I think I came up with an even better way of doing it. The macro can
generate a dummy token type for the global lock, and then we can have
three types: GlobalLock<T>, GlobalGuard<T>, GlobalLockedBy<T> that are
all generic over the token type. The token type is an empty enum with
no contents, but implements an unsafe trait saying that there's only
one static using it.

This way we also do not need the helper module, as we no longer need
to generate a struct with private fields.

Alice

