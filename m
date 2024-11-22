Return-Path: <linux-kernel+bounces-418717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EDD9D64AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A7283270
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1111DF98A;
	Fri, 22 Nov 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NT4TE7J"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170212FC23
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304629; cv=none; b=ppgOLePDWTYfM3KK7M/IqjUHqHG9slPv2QLd5167XC7LKlveGYL4PYB4DPzKGFRRfSnaZ48vSBYBGk9SjyW3quRioc0uyLaIaDXr3aDQUhhWy2Csy3mZni1UNFaQvQAOeRmy6Wxh0TuyG94iO1nRoiCH8uU7Y+x9u1Aee76W3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304629; c=relaxed/simple;
	bh=XHfNscge3k/axjUfbGmFdeorWEeOnxZKspuz6EOu8Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhFgK/AeOfclKHItn3Vzi9rN2VQsrENn3MCbe12by4heVqTvIT5NYxkDVJY9VMYV2vkJk/ZwcHcQ3CD8Gd9/Yyzmt9W873t08nYUCBLmEJC2BHwhD4PXYfzAAdgHR2lQRo1fj6QYKMxwB+x6DSb5SvUhigDxdbE5Ahcw3BkxJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NT4TE7J; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431481433bdso21753615e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732304626; x=1732909426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJlCZBCEC+QLdkXA+z5QeYevcAS/xMMVoy6tah+3/N4=;
        b=0NT4TE7J7eEzQG6X9qMIW4M6bbBpNpxKvZ42pqOMWF9EiqezHCfcri3Aeql8Xm1maJ
         P3sgSh4rmOj6H1hVvrc6ws6Ju6FC1zLsSoMlziQqcO5VA6ZQRsU1VJ0cxSH6tlgSc5ak
         zLqhCqX0v/cGxS5iFarBort16q0psRNcVxER8R/E4Plg0GPFZ56VxN2pLkfWBtU6fd5E
         Qf8PoxK38xlKixdAeInBb+Ix1pAH43gcD/PJ/VEIBw9/9WS3Xv2xlv+BcJnjtVCzBqIl
         ky0VyU7vX3Rx+UoPszM8t+8IcZvEqofDKzH4I44f18HZ1gbPexO3K17tqhnYOo9FjzEc
         1GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732304626; x=1732909426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJlCZBCEC+QLdkXA+z5QeYevcAS/xMMVoy6tah+3/N4=;
        b=WZryHxoE0uOSJqZg8aZXqWcoFvf6sRY6z4vhXpd2I6ZZSSoSk9CGvHwuwljqRl/OIv
         MmCZ43rZGvNXkVf5d44KOFA5VGYjt/wNqDjNBX+16KXhP2MnC25GuXWKEV7a0eMJFk8L
         wAEeLjjVukQb8yd7Pnjd9G0fm46SpaFMztSgqRY8xXlAQyZ6jfSkQvU1mXY6zWyTN916
         +SWWCx0JIyAXljZLOHEizUTRzfqN0fTLOXXPA09X3+OJQ7n2H8NG+iMwFlQ7krQpqERt
         lGDaIDAf8AhToz6OmHODhZV3jDigHTeRAE/rKs/XMKHsbNP9maik2k5R1YjkRCuZVFzK
         PopQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRaHdKqXXkMfDUyffymuxwbTb8QYfPvokLP+AmtjU65cVwOmjMN/Z1b4XB46PjeR0leY7n/xiEXYRumq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQATb4HSKq1r3bvJIJ1bEunQQGHjFZNKnMAmrwc8U9UpuPIvWO
	pdtbAm8JKDruwnM4o1nAdLyMRuqR/5c6x20xMwGANZflVqmGu+9Rl62p9k///NdHPEdPen/HSEe
	0sni+C2Rj/ySNu3n1PwdJMv6CIMUtU3DNvNs/
X-Gm-Gg: ASbGncsEiubMwqNrdBGDgzDqjO7mF/Gc9gHTXaa1he/ZRt7BtdclDqB/fPVJMEYMnDQ
	5KawuEt7/B+ruloGE77RTAgYdebH6Pw7R
X-Google-Smtp-Source: AGHT+IGagOmPkvb5KjYF7uq1VeAC+quJqGk5moXsINYc3vtftlp85Q8+CUP4uSVZpeXzo40AoaSlbIJRvQ7WZ+Sc3Vc=
X-Received: by 2002:a05:6000:705:b0:37c:d4f8:3f2e with SMTP id
 ffacd0b85a97d-38260be6941mr3824128f8f.55.1732304626382; Fri, 22 Nov 2024
 11:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <6740c786.050a0220.31315a.5363@mx.google.com> <CAH5fLgiiCgcPRkdeGX7LJcaGN5Y5E=zWOXuwqo+GU-tTt63PzA@mail.gmail.com>
 <6740d8be.050a0220.30b282.4f2e@mx.google.com> <Z0Dbvbj39c87EQTq@casper.infradead.org>
In-Reply-To: <Z0Dbvbj39c87EQTq@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 22 Nov 2024 20:43:33 +0100
Message-ID: <CAH5fLgippKab6Qarc7go8pz8XPrvEOoi_FvzMNAJXzr8v3qqjA@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Matthew Wilcox <willy@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 8:30=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Nov 22, 2024 at 11:17:15AM -0800, Boqun Feng wrote:
> > > I don't think this is a problem? As long as a thread exists somewhere
> > > with `current` being equal to the task, we should be fine?
> > >
> >
> > I think I had a misunderstanding on what you meant by "operations
> > that are only valid on the current task", you mean these operations can
> > be run by other threads, but it has to be *on* a task_struct that's
> > "currently running", right? BTW, you probably want to reword a bit,
> > because the "current" task may be blocked, so technically it's not
> > "running".
> >
> > Basically, the operations that `CurrentTask` have are the methods that
> > are safe to call (even on a different thread) for the "current" task, a=
s
> > long as it exists (not dead or exited). In that definition, not being
> > `Sync` is fine.
> >
> > But I have to admit I'm a bit worried that people may be confused, and
> > add new methods that can be only run by the current thread in the
> > future.
>
> I agree, I think CurrentTask should refer to "current".  Or we'll
> confuse everyone.  Would ActiveTask be a good name for this CurrentTask?

I mean, it does refer to current. Any time you have a `&CurrentTask`,
then you know that you got the pointer by reading the value of
`current`, and that the task you got it from hasn't returned to
userspace (or otherwise exited) yet.

But the name ActiveTask also makes sense I guess.

Alice

