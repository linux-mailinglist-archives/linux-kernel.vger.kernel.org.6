Return-Path: <linux-kernel+bounces-436900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18899E8C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA1D1886260
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C4215060;
	Mon,  9 Dec 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO04uUyK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E621481E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733729807; cv=none; b=oJezNH5eRTsc3ggvzZdcxD9C0G/iL4gsb8rVWuph95w60OD8pdU2wgDLe+CKUyHkRG0jmlXiUsjCitRVAMkpn7Rq+X826DddxNfhlJf0skDwxGwBGGTsvX5XSmnPfqu4cKAYzitBu97coHs3kbQMwDdxMbjXWS/BhZ7ToUce3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733729807; c=relaxed/simple;
	bh=Eow1A3UqYqThjdoagWgl0tu/rHAYK+9F3Z/d72DfdY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD7gu3AZHVwVp+i7vHNRX/sIybRT936VWXDTiyy6M5liKTAJ3IE9uWQjzvuWtAK9+9nlfqpUYav1bk4Fld+F8t2a3vrqC84VnEU2mhmxi4crMsuP0MR5GC1+GZ/VYbWHmj4cM4Lcd3rUKf6BqFzr+K4U7fpnOq74oSHT0a6LGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO04uUyK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862a921123so2009530f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 23:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733729804; x=1734334604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eow1A3UqYqThjdoagWgl0tu/rHAYK+9F3Z/d72DfdY0=;
        b=KO04uUyKe1vU+mgJYE9YOPiIoZrnHugv+KfTiDFatnQCpaTWQfzrOneg/jfVgdONb6
         SJ0HLEFARWFDLkc9To63cb+u4EoPC3SrzHUrrp25m/CHPo0ToL21hR74DSckK7OTcERG
         RR+/Spe8b+5YqxF5WIlQamO1q1M3YWRmRxM3kwsUNU0hemWG20tamuF5YwO3KPHrjAig
         XDi+busyOJ5z2A/ewU5DJ9vvaJg/UtS+n++JRyNl2b6Fbdi3AfaIm8mZYkfFmLvk072r
         HonmLrp4IcqBxC0RQHyczO+hF4F1GLTnykkWwSpNBOzBeXlLirVbGHI0MlWp/0gPZdUn
         ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733729804; x=1734334604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eow1A3UqYqThjdoagWgl0tu/rHAYK+9F3Z/d72DfdY0=;
        b=ZS3xmcqznA5HEx6WI/1eM3VFOdO9RYjVgQhLxwCjIbnNi6ltPbULNnyVJTnEggqQPD
         fYufnwBYY/V/zdQvEM5Q7eSxvGt9o9uQj7e3x8jmxzs38uYe8jWTpsSXEetnMun0qO/I
         H134VELUGwgmIKB0mnzDtNCwjlxE8aZaEYNWKk5N+EltB7iA7wZ0nHDGu86ivx6iimk7
         35yULg5Qe7/bp+N5ggvVNO0b4HXWl29cuFbVmK7wroyneiahlX7Qo4l45Pp3Q4GbGM97
         YtQ4wifXzZ+iEilbBPVm2FvJnQc6cLy0+h0GtOTRjZMDQ2FL5kA3mZRJg4DH7vuBm/XH
         shTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZjTOqICLncm9nl93HPVR0E8AyXb9HNuhatXwpAyhof5pxTXynj1zAwGUluclrhZYIKiQ8nydOGXCo4x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ioq1Ah24okdMxCWF1Lft2RcLTSX5Goa0O1n/CMsFhhAE3IGL
	5KaUQ+BRI5/I2aVvlYKRQwPzE/aog76pE2JW4S/NHZrZxcLy0+OuwxorKKmDF9vCKIJi3j1NeKo
	QnsuiFXTBlWoYXJ8EqNyb48xxF3Ldh+plekmf
X-Gm-Gg: ASbGncuMsg6y+C+5NwfHeVfQBQ7g3ux7W8yK6fQnehlbsj7GB3Jk4vOUTqHH9ehkuvo
	nHwtgKbHH2PuY4mSYdNxhrepkV2iWTt7H
X-Google-Smtp-Source: AGHT+IFujKfDJOcy9yYEksS7z9CXaHLBiMMHj9w2VyqSiy4+fyNmfmR44YIzzWHVls5xpOqmJdeFNNEW2Un39PkqnLI=
X-Received: by 2002:a05:6000:a14:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-3862b39b9b4mr10063061f8f.33.1733729803863; Sun, 08 Dec 2024
 23:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-guard-stable-doc-v1-1-a3f8249cf4d4@google.com>
 <Z1HuNaDAiKV7L9ea@boqun-archlinux> <CAH5fLgi8N6bdke1o_uTvYsYfwH1KhsY4wTGmFpc43Mi_U6+KWg@mail.gmail.com>
 <Z1NCQiGRopuS-Uc8@tardis.local>
In-Reply-To: <Z1NCQiGRopuS-Uc8@tardis.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 08:36:31 +0100
Message-ID: <CAH5fLgiTRkCoNKFPCVo8EQTSw8xf_JeVGWVQAgYYAWZk72_H-Q@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: document that Guard is not a stable lock guard
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 7:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Fri, Dec 06, 2024 at 10:56:23AM +0100, Alice Ryhl wrote:
> > On Thu, Dec 5, 2024 at 7:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 12:35:51PM +0000, Alice Ryhl wrote:
> > > > Most locks in the linux kernel are stable, which means that holding=
 the
> > > > lock is sufficient to keep the value from being freed. For example,=
 this
> > > > means that if you acquire a lock on a refcounted value during rcu, =
then
> > > > you do not need to acquire a refcount to keep it alive past
> > > > rcu_read_unlock().
> > > >
> > > > However, the Rust `Guard` type is written in a way where it cannot =
be
> > > > used with this pattern. One reason for this is the existence of the
> > > > `do_unlocked` method that is used with `Condvar`. The method allows=
 you
> > > > to unlock the lock, run some code, and then reacquire the lock. Thi=
s
> > > > operation is not okay if the lock itself is what keeps the value al=
ive,
> > > > as it could be freed right after the unlock call.
> > > >
> > >
> > > Hmm... but `Guard` holds a reference to the corresponding `Lock`. How
> > > could this happen? Do you have an example?
> >
> > Well it can't. The reference is yet another reason that Guard can't be
> > used for stable locking.
> >
> > This doc change arises out of me needing a stable lock for something.
> >
>
> Maybe it's better to put together this patch and the stable locking you
> are working on? It's better for reviewing in that way.

I'm not sure when that will happen.

> I can see what a "stable lock' means, but want to make sure we change
> the doc to reflect the exact requirement of a stable lock.
>
> Regards,
> Boqun
>
> > Alice

