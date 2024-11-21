Return-Path: <linux-kernel+bounces-416895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6A9D4C23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9DA1F226DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA391D12E0;
	Thu, 21 Nov 2024 11:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYzmFeM4"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CFF3C47B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189192; cv=none; b=IvTVE2Fwc3OEbFFcMa02DkYK7wntewvtxN+LnVZ7oifHWfQh5bhp/mxPnDXlF/TagRb3G5Xc0ET2u8JR1E44FYwuuHQ23sCdcgcxf5twvJKVQxCIArzFIVea6u6qavaoREPIGoOVxTHsMTYSsuOnFBNpMbw0lnN1wDn0fzKvCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189192; c=relaxed/simple;
	bh=U9v+K6sJOOG6x+RFfN+V0Si4bcR0z6pz+6B8md76rd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOEx0OE9cgzzpnpKca2URci9Pu1q1CDWgFGQvTN8d5yvGXMSAosIfv7q5J0DdcF4oRpy/X9nmlBfsD8/5881FM9q8Qn0jZXyqj5DnTmfqIShDgJzWmZ/qOzkh5pDMEjtFclP42FgCQ75ukhxLvZoGUe6ZSoFGF5YXzbCFUe57gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYzmFeM4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3823e45339bso625784f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732189189; x=1732793989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IZyw4FOcZ6R/V4mnMHgpIhe+XP7mjUrhnLeyIz/iRg=;
        b=BYzmFeM468ryeUt8P7KEyeA1lUTodlyL0qC5KvLydrMZm020b8jJhu6MO3C9FtXkKi
         zLU5JG5RWXvXb2wHC6s1ZWQhgPNlz6OpOkIFOoQpaZ+czaz5r0wZEMmCx7YV9zpknheC
         PZw1ZA0S5x/xX3Sd/VWQNss8SiHQTfQJ69Ojtn+e+tkBYpiI24L/fXTdGUSB9TOiB/yj
         ehV92xYuUx0a+Uyp4uncsyJRz3imYbMMxLfBCUTElx8M1UuQ+0hHZhM70vDEMsaoyAR2
         +p6KOCbe9TGxdg540BE/Tdy4iZ2BEH2E5cJNlVcRVyqT4QyySuZq6dacRW72Qg2W/50w
         Ol5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189189; x=1732793989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IZyw4FOcZ6R/V4mnMHgpIhe+XP7mjUrhnLeyIz/iRg=;
        b=f6l97+euPuRt+zs152Ybj/TiUETzlBFUoWF3kdhhwqc4KrCL/jV8XRSu+sYqEZky8w
         ZQ3uin2fMqe1sxyvfRxgTJ9BbKAdemVVERrYGBwG1pPS9aU4h0xjo2jPXJkdeqL9M3U1
         ievT1IjIlUjrA77oWdDBfjvEd1W4aHEP0ADUHYvhWoCCUkVx3Ve+NH7qzXEsP6QBybQ2
         ADUayIcrOi0j5NFFAlRj0HYrxf9K2L/1E1uM8rc8ZvgxZ0pnp7RBtkFuFCmv6CXngkF1
         XhXUZ1WgbTq4B4MYT4d0IbIZvoywzgIHAxAqnRnd5YWFq7CuSOnX13u7nWx05jd+k3ey
         bbXg==
X-Forwarded-Encrypted: i=1; AJvYcCVM/7ebnnNSygdhVrun5mg1AlgAWwaCere70rcwGHs5nL4xzQnq1Qz9B9rJMdAvdpClpaYkNqoVIpMNZ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3pea9YsC/sJVSt8vSgAvGRCyXGtttINurndAMjx9LhJEiE2n
	VslXUetaSBOdSNqMoFW7kygUXTOYGWMjyu+yGZCR4Ss8NSnoi4SUeLGrxMfgZMl81zktbtZFLl/
	ZO2wmBY1/32qchnNHNiKxqPPGADSwoLBrleII
X-Gm-Gg: ASbGncvcza9W0yst6E1dmhcxFe2W01avEnKwLh7siDMJ5AUNIwoOHdoFhtiW82Pn5gY
	Vx6LZK+7aYNwWnisvU6VdNvyV8hPRb/RFUAEOsPKnO5ec5xRCueUuicUTVRdqkQ==
X-Google-Smtp-Source: AGHT+IHOUT5TK9qW8nVjhNy0VpEtuheP882P7CKZcuAtr3r08tu4OVDN35SCuTs2d/vi/YNbZK0QGKu6hwSa17GxWlo=
X-Received: by 2002:a5d:47af:0:b0:382:44e0:c5e9 with SMTP id
 ffacd0b85a97d-38254af9c4fmr4724755f8f.25.1732189189300; Thu, 21 Nov 2024
 03:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-5-eb31425da66b@google.com>
 <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
In-Reply-To: <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 12:39:37 +0100
Message-ID: <CAH5fLgjDfSL+7XB28sYmq4e40yxBv97h7jQPs=9Qe4+_3f1FRw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] mm: rust: add mmput_async support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:47=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:49:59PM +0000, Alice Ryhl wrote:
> > Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> > otherwise identical to MmWithUser. This has to be done using a separate
> > type because the thing we are changing is the destructor.
> >
> > Rust Binder needs this to avoid a certain deadlock. See commit
> > 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> > details. It's also needed in the shrinker to avoid cleaning up the mm i=
n
> > the shrinker's context.
>
> Oh Lord, I didn't even know this existed... I see it was (re-)added in co=
mmit
> a1b2289cef92 ("android: binder: drop lru lock in isolate callback") back =
in 2017
> so quite a history of being necessary for binder.
>
> I see mmdrop_async(), I guess that's not needed for anything binder-ish? =
A quick
> look in the code suggests this is invoked in free_signal_struct() and is =
there
> due to some softirq stuff on x86... so yeah I guess not :)

I didn't know it was so binder-specific. I assumed it would be a
relatively common use-case.

> >  // These methods are safe to call even if `mm_users` is zero.
> >  impl Mm {
> >      /// Call `mmgrab` on `current.mm`.
> > @@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::m=
m_struct) -> &'a MmWithUser {
> >          unsafe { &*ptr.cast() }
> >      }
> >
> > +    /// Use `mmput_async` when dropping this refcount.
> > +    #[inline]
> > +    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsy=
nc> {
>
> Again, nitty, but I wonder if this should be as_xxx()?
>
> But I guess this makes sense too.

In this case, the as_ prefix is incorrect because this is an owned ->
owned conversion. See the API guidelines:
https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conversions-f=
ollow-as_-to_-into_-conventions-c-conv

If we wish to use a prefix, the correct prefix is into_.

Alice

