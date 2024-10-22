Return-Path: <linux-kernel+bounces-376637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F359AB443
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D334A284A84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC61BC9E2;
	Tue, 22 Oct 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnlrK4I6"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B9136345;
	Tue, 22 Oct 2024 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615496; cv=none; b=cJD4O4FCXvmduDThmh1/Miinsm2pOf8VDSsQe7ckwjKKRKYO0v7K85+XHLdV4yGiUZSNhyR6sHwJzRTMjXPy3XH4K8WtqhaHzozb9qP/DYBOqYACUzNXSEKfUcKC/H3/+1kqpNy+MeFgdtJKARSOWLe0vjdUs5jh7aTaXlbAmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615496; c=relaxed/simple;
	bh=lRiiTiZaemblmSwfu+F60dKzI7ZMo6FDcsQkXludCkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrW717OEADjY4yMMqzzN6uS36PCNlBKuh5qxKGTdq1oH0XLJq9yNZTLxGeEh3gnzyIDc4GoxmsCYeqeL25OBe7G7ooS8YoizZX18jxd/lToxC4Bo7DiFtHjTy3FspVZuTZqfkC5G5X7/g4tnKAVCphN21+l3/n79NlyWuMeNyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnlrK4I6; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b14df8f821so496468185a.2;
        Tue, 22 Oct 2024 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729615493; x=1730220293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AH/PblL/DNvuGg6LwPkQM9YColVopULQEWoJ7Cvez68=;
        b=CnlrK4I6F3C49Ft78Jq0TA0S6e8jP88RGRU6vjzM+zf0lgtR2dacdfWPsWHzV87mN6
         tOcMK02P7XslPkEvdq24fbmi55t+2ZJROylwpdbcUORvI7q1TwIbKg/4JQ8an/VwYJ+A
         YqRei6zaxT/WkgIygtMIg0TrZ97IiVvUGY29NYponURDvguEV0dfh3I73NPn+ZGTxeH0
         UKhUxkeldMD0XneqDX54MmZ1N7KEdXztHcrTbP2wINjHFjIl8orQUn9bNmQ32UkHzkRb
         SV01ksgD36QAEVtvSyAAsasEIM/DgOt8UCRk3rMQy9QD0yxszrVJYmS6QlvditOoUBAq
         8e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615493; x=1730220293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH/PblL/DNvuGg6LwPkQM9YColVopULQEWoJ7Cvez68=;
        b=mfGgk0FVwh5E8HwgiP/tqzId8wACN9zeZ1VWOc54If2d3hYTFGDWT/WdBqfdQBK92Z
         AFjKCIYRf8QzzVqQrm+He66tPB+CTZ7tSkwYSoJpkV1A7e6YJnmYbGEynv7jiPpgv69L
         d2MsnPUJ0e1cMKimkoZ6KVR3SgpQg9U5dR+cDMKVoAMIqyihVdZtAo6vGyCr/wd39Odu
         e+vkvGBYkBgHqG+l1Ylwj3rqWi+vtaHvtko5dwa4D/H4nTnfW7Il1wntK43aoOHH1f1Z
         tyg/F8GxdNnAVIb8k+k1IZeHtgogDILtw9/u3g7Dcrfe3AsDQ7eUmG0RYUEhd13vQomx
         f3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzNUkP1TIEhH8rnHTy2tj2YM0YCeIVuDSHiRKeY5REi5jCv4+rEKjJMM2MZ+9Lqugn9WERZrp7PRTVKh8=@vger.kernel.org, AJvYcCWpmTSizbY9broEKax+C0iWurAXnjmAHj3lj5L+n266iuYQ8V87vt80/2dD2YT6zsP7tXS7ibA5xzFjoSLVeys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWBbKQRRAcKkU3URFxBwT6W+gVsXVUI0O+CvbafrXom4zZLZP
	oX3GGsM2hIqryl0n4nY7b0qucUhKxCcCVLN0wV6LOy3RsmT6Zk7m
X-Google-Smtp-Source: AGHT+IHVwHrS+2l2Xk6IBJ9Biq3mPsmDc0CiwDOAkvo+kaAcnJcD6F8vnEJK1A8loeWichIJYYagJQ==
X-Received: by 2002:a05:6214:588b:b0:6cb:c9e0:c299 with SMTP id 6a1803df08f44-6cde1552c27mr240212136d6.27.1729615493100;
        Tue, 22 Oct 2024 09:44:53 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009dd27fsm30126146d6.109.2024.10.22.09.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:44:52 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18E591200078;
	Tue, 22 Oct 2024 12:44:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 22 Oct 2024 12:44:52 -0400
X-ME-Sender: <xms:g9YXZzVzg1IZxspzTfs4VTrppa6xRVybu6TBFd56Zj5RimBS2to0Pw>
    <xme:g9YXZ7nHS65dHiCwKiicrQhaMkvvmgLEAPhQT3U4V16ECtI4W8inGMJv42lSRvAwY
    38QOsIUDRx-qXJ7wQ>
X-ME-Received: <xmr:g9YXZ_aXoM8cNxtaz4Crla_eR-6H5FEWlXKuoR8jnDzY2pWZKBINKEWIeTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhose
    hrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepghgrrh
    ihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohht
    ohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhoth
    honhdrmhgv
X-ME-Proxy: <xmx:hNYXZ-Ujk19a_K0YiW-ZqJmmaENOdQ0feIguRZdKSR2hm71iUDGHlA>
    <xmx:hNYXZ9nKRc3jI-72oLxviUCCr9HAJPAQlP4lBiCfMl2NbiP20YMOyA>
    <xmx:hNYXZ7fw6MljcpRNW79_SZjpaMdUI9f8nfAktRU_dp6r8pOGJDnT7Q>
    <xmx:hNYXZ3F5xE3Mw6l2lePcv6CU9H-nP4_XrQId_8CtC_DQIC0A7o0Khw>
    <xmx:hNYXZ_kHoJwqcukNrR6XL-YjrpoNxweE0acBLrcTFZ-7SiiOGQeN800w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 12:44:51 -0400 (EDT)
Date: Tue, 22 Oct 2024 09:44:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v5] rust: add global lock support
Message-ID: <ZxfWglfYr52xTIO4@Boquns-Mac-mini.local>
References: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
 <ZxZxzjEaSZ8e_6mn@boqun-archlinux>
 <CAH5fLgg=Hb5NDaQQJW4SVh+hCj51bp+BzCMQs=Pg_L+_MMiZgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg=Hb5NDaQQJW4SVh+hCj51bp+BzCMQs=Pg_L+_MMiZgA@mail.gmail.com>

On Tue, Oct 22, 2024 at 02:46:19PM +0200, Alice Ryhl wrote:
> On Mon, Oct 21, 2024 at 5:23 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 01:17:23PM +0000, Alice Ryhl wrote:
> > [...]
> > > +///
> > > +/// A global mutex used to protect all instances of a given struct.
> > > +///
> > > +/// ```
> > > +/// # mod ex {
> > > +/// # use kernel::prelude::*;
> > > +/// kernel::sync::global_lock! {
> > > +///     // SAFETY: Initialized in module initializer before first use.
> > > +///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard = MyGuard, LockedBy = LockedByMyMutex> = ();
> >
> > Thanks! This looks much better now ;-)
> >
> > But I still want to get rid of "LockedBy=", so I've tried and seems it
> > works, please see the below diff on top of your patch, I think it's
> > better because:
> >
> > * Users don't to pick up the names for the locked_by type ;-)
> > * It moves a significant amount of code out of macros.
> > * By having:
> >
> >     struct MyStruct {
> >         my_counter: GlobalLockedBy<MyGuard, u32>,
> >     }
> >
> >   , it's much clear for users to see which guard is used to protected
> >   `my_counter`.
> >
> > I prefer this way. Any concern about doing this?
> 
> I think I came up with an even better way of doing it. The macro can

Cool!

> generate a dummy token type for the global lock, and then we can have
> three types: GlobalLock<T>, GlobalGuard<T>, GlobalLockedBy<T> that are
> all generic over the token type. The token type is an empty enum with

Just to make sure I understand it, so let's say the token type's name is
`TK`, you mean we have GlobalLock<T, TK>, GlobalGuard<T, TK> and
GlobalLockedBy<S, TK>? Where T is the type protected by the static mutex
and S is the type protected by the locked_by type?

> no contents, but implements an unsafe trait saying that there's only
> one static using it.
> 
> This way we also do not need the helper module, as we no longer need
> to generate a struct with private fields.
> 

Sounds good to me. Do you plan to let the user name the token type? It's
fine to me, or do you want to name the token based on the static lock
name?

Regards,
Boqun

> Alice

