Return-Path: <linux-kernel+bounces-330860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC397A54F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D92A28941B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AC159209;
	Mon, 16 Sep 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dqtLX7p6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFC158D92
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500498; cv=none; b=hvigvRCu9NitZcPHCXMkm6qrKNFctoHO4aV+sAXTj2oXw9ZVhi0PRaRs6sRftHnAwyraJlPLiguRwL7WKXpadnQgCi4tqtWAMhVbGEoq9EZ8Wa/jbZxg60BTo0Xvt/X3rNw89xfspjCapnkxpAFctXjDk43/IknkZs4KOw8XSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500498; c=relaxed/simple;
	bh=WlODueikdE8iNg+YcFfV4D9fBjO+4Cw1pzynCIM+K+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRx2JIPciKJt68YUSSiu8qMzqWBPdpWhWJOUrFVDpROY52NYGOxKh0U8mBHQfDTOQqccVAdAuqMiDlDyYPCy02WIGQKAh/HCmqqw0DEehYAKhs/LISIb9R6/oSaSRtO/ij8kkmwChlvtiWDG96PhRRVg2nB8JMIChE483PSGtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dqtLX7p6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3787f30d892so2264050f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726500495; x=1727105295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m4daR3wtHlZl9dcuxcFnv3RNISgqsCBz2X/zdmjlr4=;
        b=dqtLX7p65/y7sBWF6zXxus+TD1RMiLVoqiWv/2oloaZUaAARl4liz+ESOOgouOpiWN
         aHEa9rIXBvPhhaaojmpJebhlcmKw/Wj+1cK7afP8xurOYyrb6dh4k+AVIRLZBs0wXgc3
         GmpqJTelWqyvUKv35J/NaRAAHtViTliLWkKho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726500495; x=1727105295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m4daR3wtHlZl9dcuxcFnv3RNISgqsCBz2X/zdmjlr4=;
        b=MlLEbJxoPT9sUHK2BSRzFV0aq/+MHcdK39gWmbmuEbaWJ3HDBImHsWZsLuSJ2xuj0F
         NMpz+AR8iPhnSGPAHMqR8z4A9h9VjZHcVa/tRrHaVlkUW0feeGeRxK6Pygzt2f5LOve5
         dXXEJXaLVpiwmA2sufr1Wp4pjUOAqiCUQjBfo4LmDh39p7md2nKIPOqlKZMGjjV8Se+7
         qGH36A/DX7XZwK0wQ8WsE92SK0YVHgxO3llgN60pWdc0R+76JQbzZaYkhVkhX56U0s+p
         1tgYBRV9ze786aOBGgeKZzzpIJGnL153yaqzZEY711/NCOo1z5xODsmRTvTkOagPynOi
         y4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxa5R0T69yDvH81n0GyEQj7sM9KNFfpt2+7qlDKIoKHbMtwzO45TW/BauNntJpgPMWEXXi+rhAkkh8mkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV8E1I0HaTRfsNbEvqOnDmdbJJogfWA/H3aIqgEhLQfr/0h5RQ
	/66chKkxGAuRAEYANHl9n/10YNm6nUN9YT1s0bvRUeRVfv3S/81qkrWS8r4nAx0=
X-Google-Smtp-Source: AGHT+IGWvzNIRGqBC8AGUY8qiZPWMwcVmKXq3jZ8qz07XXarJ1ziKNdbe2x93+v1ko+aFpHXY3tsYw==
X-Received: by 2002:a05:6000:120d:b0:371:82ec:206f with SMTP id ffacd0b85a97d-378d61e2871mr6466145f8f.16.1726500494626;
        Mon, 16 Sep 2024 08:28:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78052efsm7470228f8f.97.2024.09.16.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:28:14 -0700 (PDT)
Date: Mon, 16 Sep 2024 17:28:11 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <ZuhOi1xFBNtfGxn5@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
 <ZuSIPIHn4gDLm4si@phenom.ffwll.local>
 <ZuUtFQ9zs6jJkasD@boqun-archlinux>
 <20240915144853.7f85568a.gary@garyguo.net>
 <CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Sun, Sep 15, 2024 at 04:11:57PM +0200, Alice Ryhl wrote:
> On Sun, Sep 15, 2024 at 3:49 PM Gary Guo <gary@garyguo.net> wrote:
> >
> > On Fri, 13 Sep 2024 23:28:37 -0700
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > > Hmm.. I think it makes more sense to make `access()` requires `where T:
> > > Sync` instead of the current fix? I.e. I propose we do:
> > >
> > >       impl<T, U> LockedBy<T, U> {
> > >           pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
> > >           where T: Sync {
> > >               ...
> > >           }
> > >       }
> > >
> > > The current fix in this patch disallows the case where a user has a
> > > `Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in different
> > > threads (they would use `access_mut()` to gain unique accesses), which
> > > seems to me is a valid use case.
> > >
> > > The where-clause fix disallows the case where a user has a `Foo: !Sync`,
> > > a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
> > > `access()`, this doesn't seems to be a common usage, but maybe I'm
> > > missing something?
> >
> > +1 on this. Our `LockedBy` type only works with `Lock` -- which
> > provides mutual exclusion rather than `RwLock`-like semantics, so I
> > think it should be perfectly valid for people to want to use `LockedBy`
> > for `Send + !Sync` types and only use `access_mut`. So placing `Sync`
> > bound on `access` sounds better.
> 
> I will add the `where` bound to `access`.

Yeah I considered but it felt a bit icky to put constraints on the
functions. But I didn't come up with a real use-case that would be
prevented, so I think it's fine.

Even the use-case below where a shared references only gives you the
guarantee something is valid you likely have additional locks to protected
the data if it's mutable.

> > There's even a way to not requiring `Sync` bound at all, which is to
> > ensure that the owner itself is a `!Sync` type:
> >
> >         impl<T, U> LockedBy<T, U> {
> >             pub fn access<'a, B: Backend>(&'a self, owner: &'a Guard<U, B>) -> &'a T {
> >                 ...
> >             }
> >         }
> >
> > Because there's no way for `Guard<U, B>` to be sent across threads, we
> > can also deduce that all caller of `access` must be from a single
> > thread and thus the `Sync` bound is unnecessary.
> 
> Isn't Guard Sync? Either way, it's inconvenient to make Guard part of
> the interface. That prevents you from using it from within
> `&self`/`&mut self` methods on the owner.

I think there's also plenty of patterns where just having reference is
enoug to guarantee access and exclusive ownership gives exclusive access.
E.g. in drm we have some objects that are generally attached to a File,
but get independently destroyed. But some of the fields/values are only
valid as long as the corresponding File is still around. Lockedby as-is
can perfectly encode these kind of rules.

So I don't think tying LockedBy to Guard, or even a specific Lock type is
a good idea.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

