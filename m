Return-Path: <linux-kernel+bounces-552178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFDA57688
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88053B7953
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C392CAB;
	Sat,  8 Mar 2025 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clAP1skM"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770E634;
	Sat,  8 Mar 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392364; cv=none; b=jS8ZcWOKO4Pu3PzRnM1vtOijquxhp01cPjpIMDhWnvFZURMSv+NWSGXmifrkMzHVsXXKIrJ1dzBuZOgVZ1uRdmCFknGNi/VUhrNmpmG+XZDLSYaLIFeuk7TXJWRU0+Qek7w62genQqN7cca9hthSP0wPLwK+Cfe7/OJPkNQzLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392364; c=relaxed/simple;
	bh=r3jjFV/AZ7XqqV+3+IOaPesUybG2SVDT4HRVgfsoRvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMC7NCCUY0QjeJjXAQt5dAS13bNkFE1Jzyzm/jYjTy7TsHfw8o+gh+eOqieylgu4K30Rv7PvznVUEKbvmhaS02owsH2mtxxVdrRczBo0Mdl5VDBuF2NBzbX/ogq+0F/9aK31TRHyZe77OhWFTfZ7DhyOI14O7cYUiClh6MAkRvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clAP1skM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c3c91060d0so295976585a.0;
        Fri, 07 Mar 2025 16:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741392362; x=1741997162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXUaeFC0kFlr1WtV09XDJXH9tjeBYWhqIZr8bd6RMWA=;
        b=clAP1skMemcG8uMx/0j+I9csGqj0tfCKZMu30/qZSDKlwXeNOZwvjtjdNHuTAfQZ2H
         1D8wogMTIvVbX91pSYXYvp11rqqOMRRjes+GWNiC+zkfcjw44bndelKr/ntaTFEx2w1+
         OJbukic6N7SSTa1oGiHheUMx9kPX6UmboSj9ttWIoZtZwSiYQvj9c0XbgS8y467Btqbp
         FcS7POdRzf2+EN31PNoqnBmcq4ukThFovITNr96aqVYz/ITLL/JLp9pfRy3DPekrxrkr
         sB+8NX1Pd0tV2Ddr77zygrpSyI6XCd8PWAx7VjO+5zR+8RZrZ7ycIXtd9R2cNtpCHjxx
         qWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392362; x=1741997162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXUaeFC0kFlr1WtV09XDJXH9tjeBYWhqIZr8bd6RMWA=;
        b=NAQUTicMOVDjMtFdU1BZ7r4pliRK+lmgu7TCcoQKc3VS6aQPTYgxjKBKRTpmNYD/cO
         uNgajGuxxHQiZSPE3cszk/c7Uieiozf04Jdt/9DDkYXsYd/piThs4b9tenJR5Yh/nqK+
         /bQmKUZbojFPZNiOGZaBMqk/6rNGLR8e9t+UdQMoyXtsbRMfuZoU9e+0JR4R21BX3OeQ
         nr2Gl9l2CgGDRhwlQ1yvFdZBtd8q+dmkf8l2h62uzPZM6glnSInxbywfvKUbbDKd74/V
         joxQlCkAWK8bmouQLJ9HxOR+7YJ9/oZTsOeoFuFgCu08nXy4PXogkNaH4qWkNbB9rSNv
         h54w==
X-Forwarded-Encrypted: i=1; AJvYcCWkztQb1GsT0lyuUCrZK+qGlEe273mNfZEEHHsakCkVil8UnfPI8WtClqWCa91ZRtAbXhn3l13QQ8Ia8GAduk4=@vger.kernel.org, AJvYcCXYFM1z1TbhLogxo7cufZJQUeCr5YyVw0wucXmzmje3cJ2cWtqH8n9r0BvrWGiqGAcL2ReEDMWBSel6wB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIw9SstgyPWKJRYItwvu+Qr/2SRGNAwziKP3UWL9RNMzuSdKA
	OW5//7xq2UAUQWXuTnNsZZN7I5HZ7p/0HTngfdxkq4LhhsErD21o
X-Gm-Gg: ASbGncuL7SmNRAy9KOAUfvdoSdUtG52jJpbhQwbCMEiDgQ8gOJdbMIMg7qeonMwC77p
	bbAXxSLCzwAqg9L6l9JlGVIf2RnR2XnpLG2qlImyfEywtQ1MHrElJXnO3EtePkkLQkqMp4Me2Xc
	kpVee8HN267zINzIYrmJVR03cc6XRjVd+XFGiT0YWajAQLvvjaH/GDxPBI5qkbt1anAAMIzgADI
	JKvdDyGQWKcdi9oUSO0VAYjklq9GnIK7isDSCYT1TIj5KGPK7SCHefJRPLCeJBFUU9THfHUaogV
	+8vI//8HDM+tCgOAEeo5FKfwXrcNxr150b8e86c/laTKH0ir+WigPzAmMMmswnQ3qr61bqT5Pxk
	+cI0IDji6kOktyx412Dv9MDj5/I2nNxrPJ+w=
X-Google-Smtp-Source: AGHT+IHVoJ+vrNgu8pi/bvLuZoR2DxULUew+b8dR5StmQWxJERwTI/PBuBok1vvS167tSQyqIrLFmg==
X-Received: by 2002:a05:620a:6503:b0:7c3:bd8b:46a4 with SMTP id af79cd13be357-7c4e6112216mr728101685a.28.1741392361766;
        Fri, 07 Mar 2025 16:06:01 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e553e418sm305735185a.117.2025.03.07.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:06:01 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C82311200043;
	Fri,  7 Mar 2025 19:06:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Mar 2025 19:06:00 -0500
X-ME-Sender: <xms:6InLZ43SwZKxdnuJelqS9WbyrLPd37ZNGjFYOBYuVmjpnQsXcDlNww>
    <xme:6InLZzFwo0eL37w1i4J35aBHZ9WsWWdcWO__92vhK1zThEkMDt1ub617VDsmwYrLX
    1ihfaEnCYz23Bmv8w>
X-ME-Received: <xmr:6InLZw4j7zk7XE0NjgWcdq_QDlFJxSxB7m0IqN1CJdT8r0hIuY7JGw6omWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6InLZx3tGz4zd7zrxUUEaAvEiANMKjIP3gwYccS4YPjWdQ6CCtvZ1A>
    <xmx:6InLZ7HH64EkL7m3pMbz_82N3Gou8bRTW-s9noH3tHyAlFEX_IpXgw>
    <xmx:6InLZ6-o3zw_b7X3-l5JGQ2irHsRUCr5X27CaqhagJtoVc0DtrAVUw>
    <xmx:6InLZwmeuZJf8oH2UXmKxy629TwWVnIvdwA8-wAgJCf6q1giMCH2ZA>
    <xmx:6InLZ7EsAcQV5CJGya9KlrgwwG9OkdXPp7iOYeHgD6uo148WyyAcTyWt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 19:06:00 -0500 (EST)
Date: Fri, 7 Mar 2025 16:04:48 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"open list:RUST:Keyword:b(?i:rust)b" <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH locking 00/11] LOCKDEP and Rust locking changes for v6.15
Message-ID: <Z8uJoFsfvdeOmAiH@boqun-archlinux>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
 <Z8uI6aOd79xe32CS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8uI6aOd79xe32CS@gmail.com>

On Sat, Mar 08, 2025 at 01:01:45AM +0100, Ingo Molnar wrote:
> 
> * Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > Hi Ingo & Peter,
> > 
> > As discussed, I'm resending the pull request for lockdep and Rust
> > locking for v6.15 in the format of email patches. I dropped one patch
> > and will postpone it for v6.16 because of a bug [1], and I think the fix
> > [2] needs more reviews.
> > 
> > [1]: https://lore.kernel.org/lkml/20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local/
> > [2]: https://lore.kernel.org/lkml/Z8t8imzJVhWyDvhC@boqun-archlinux/
> > 
> > Regards,
> > Boqun
> > 
> > Alice Ryhl (2):
> >   rust: sync: Add accessor for the lock behind a given guard
> >   rust: sync: condvar: Add wait_interruptible_freezable()
> > 
> > Boqun Feng (1):
> >   rust: sync: lock: Add an example for Guard::lock_ref()
> > 
> > Mitchell Levy (2):
> >   rust: lockdep: Remove support for dynamically allocated LockClassKeys
> >   rust: lockdep: Use Pin for all LockClassKey usages
> > 
> > Randy Dunlap (1):
> >   locking/rtmutex: Use struct keyword in kernel-doc comment
> > 
> > Waiman Long (5):
> >   locking/semaphore: Use wake_q to wake up processes outside lock
> >     critical section
> >   locking/lock_events: Add locking events for rtmutex slow paths
> >   locking/lock_events: Add locking events for lockdep
> >   locking/lockdep: Disable KASAN instrumentation of lockdep.c
> >   locking/lockdep: Add kasan_check_byte() check in lock_acquire()
> 
> Thanks Boqun!
> 

Thanks.

> I've applied these 3 patches to the tip:locking/urgent tree:
> 
>   locking/semaphore: Use wake_q to wake up processes outside lock critical section
>   locking/rtmutex: Use the 'struct' keyword in kernel-doc comment
>   rust: lockdep: Remove support for dynamically allocated LockClassKeys
> 
> As a general rule, if a patch is marked Cc: stable, it must also be 
> applied to current upstream.
> 

Do you prefer a separate pull request for the future? I can send one for
urgent and one for locking/core.

> I have applied the others to tip:locking/core:
> 
>   locking/lock_events: Add locking events for rtmutex slow pathsa94d32446ab5 locking/lock_events: Add locking events for lockdep
>   locking/lockdep: Disable KASAN instrumentation of lockdep.c
>   locking/lockdep: Add kasan_check_byte() check in lock_acquire()
>   rust: sync: Add accessor for the lock behind a given guard
>   rust: sync: lock: Add an example for Guard:: Lock_ref()
>   rust: sync: condvar: Add wait_interruptible_freezable()
>   rust: lockdep: Use Pin for all LockClassKey usages
> 
> I cleaned up changelogs where necessary - for example we generally 
> don't include printk timestamps in changelogs, unless it's relevant, 

Got it, I will avoid them in the future.

> plus there were a number of typos and grammar mistakes left in some of 
> the changelogs.
> 

Will take a look at your updates and keep working on improve them,
thanks!

Regards,
Boqun

> Thanks,
> 
> 	Ingo

