Return-Path: <linux-kernel+bounces-338423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224B98579C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DEB1C23374
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587214F9F9;
	Wed, 25 Sep 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0qoZkaG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC784A5E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262386; cv=none; b=ZWxOOs3NaGGZ+iwACEUTg0XPk2RkNw8fKa49ECozSwO0X1gheZSdphoSuY46VZ5yNpTIQXD0Grywywhmg3r4o+ThZCMGYwWs5ZnsxdCjHmqWI7dn3ivC9H4WoFUMXn8zDy7DFDkWnF/6guxPohHNN5L46AJpVhyeralNlFqIZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262386; c=relaxed/simple;
	bh=v9SOENpp+GEqMEfpbzjHUOzd9Uxz8a8eI7GUtlWQs+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTni0YI/EgV8TkiAV7gwNrkNuMxV+aKh6umIebvE7CSb9jHdwskz9MLGSFxcynmcO4plInUx/hAyHJYbKzA/+NsY0lZLezpxAi/Dj6+v3JgSYazoATUjLKIuKDnoIMdZ67wS7XXm+zpPKgS1iqkspJGMEH9G5y9HV7n/4cBOJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0qoZkaG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so84087055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727262382; x=1727867182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=Y0qoZkaGAi7LcUT3oJb4NisLSJU/jQJH27zodADr2z0dvPpCGPDg5u7nQ4RIsCYMak
         le/mIhlmqZ8X6+GmN3PP2QMCKp6vbmxzotaBm1Yuw0RXmtw32VA+G7yMyWtf4xmzAhKM
         UcGaIYxfzd8JowKxx+i3zJ6nNRBJXXxEklTgZMxjg+YgF1Z3ofeLDp/41kfNnENqDcCI
         luE4FdlQEo4BAdOUU66phuSQdN3pka/+v/NSGPGVtV4o41NqrBDjLgAdZqbjZXl89pIh
         tYk0Dth2KHO+fllaG9Qs7ETkDZAIAD0pLvwMM632vU9VIipk2b6BElfMGUO2065bcTEx
         X8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262382; x=1727867182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=EI8/NBRMrTI3mw48r9n3Nc1PN0D0bc0wbUzONFCMC4ynVgNG+0WiKzX0SV3vjJDPrp
         hX5OEenTbvACgqkJEFzezewtO2wnFY1VB1MrBgPO1RlVJwTooJp3T3gfThw1nlOsXqSu
         fi/gROT0YBh0biuQDXPHJppHSTFAF9URoaf/MRK88b4A9nJo+ikNxvXcKuxZAXM3ay2w
         BZiKA3XZXUYnAuXFECjiPa/2TH8YLyI/e8UBManrxDT3X65qyPSYfm4Snew1zZ+uiMlO
         LyZeYgAMR4L2QdwZEveOQ15v56f+/swBGkluWG5T/zz089a21wQg/Dul4wmUV0ce3yBr
         J3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkGOKNf+h722q1Fl44t9iK+ikvEhdRYB35Bw6m67RuXAEejEQfwNphJXQMrUKUH9Lpi30sM4axhx/7hrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHXedDLMFDjE/HjmuZFt/DUEiku0AJeHE90i9EArn0al5+y/Rh
	UD/Mq4twdpSYBz0VXQjeYNR4jnvwW6FGB42MxC/xjW6VmuJPbWyTFpk+yI1HblQcI9K8nyMEVC5
	KEwU+ZwN7u0QGRhuuqjHnxT0lXAKtDc06RjkE
X-Google-Smtp-Source: AGHT+IGFAj+j04oaHOFqsP7FAM4DEPPjCdbCbDCCKy/XEfJz3JFRtsBnFMPeIPy5+2A+yRs/huLSjBw7dGu97fMWSko=
X-Received: by 2002:a5d:5d86:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37cc51b8ee6mr1224327f8f.38.1727262382323; Wed, 25 Sep 2024
 04:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com> <20240924194540.GA636453@mail.hallyn.com>
In-Reply-To: <20240924194540.GA636453@mail.hallyn.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 13:06:10 +0200
Message-ID: <CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote:
> > This introduces a new marker type for types that shouldn't be thread
> > safe. By adding a field of this type to a struct, it becomes non-Send
> > and non-Sync, which means that it cannot be accessed in any way from
> > threads other than the one it was created on.
> >
> > This is useful for APIs that require globals such as `current` to remai=
n
> > constant while the value exists.
> >
> > We update two existing users in the Kernel to use this helper:
> >
> >  * `Task::current()` - moving the return type of this value to a
> >    different thread would not be safe as you can no longer be guarantee=
d
> >    that the `current` pointer remains valid.
> >  * Lock guards. Mutexes and spinlocks should be unlocked on the same
> >    thread as where they were locked, so we enforce this using the Send
> >    trait.
>
> Hi,
>
> this sounds useful, however from kernel side when I think thread-safe,
> I think must not be used across a sleep.  Would something like ThreadLock=
ed
> or LockedToThread make sense?

Hmm, those names seem pretty similar to the current name to me?

Alice

