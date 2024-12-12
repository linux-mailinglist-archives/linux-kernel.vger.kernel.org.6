Return-Path: <linux-kernel+bounces-443523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8C9EF356
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5C6288F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96079231A20;
	Thu, 12 Dec 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsT1ApKQ"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC522540A;
	Thu, 12 Dec 2024 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022281; cv=none; b=GuWUcV+cuProQiC/rBsntk09kkOOMnMpqwdbyAyJak0bBcfe+vp5ie/6MVE4g7cW1H7cZDI7DyS8GSNFD1t/8HZ0UBBfql6fUmKcp+Lf7KupX+fwyMmM5wT8BN6gElM42D4fjWVlKmIPaFsG/jHx93xqhptxCBE4BEdCiGnGADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022281; c=relaxed/simple;
	bh=KSS+IEFy50e0gvvz99JkymakuMoeERBgyYU4zHTc+ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfJzOIoCAlhhHeijXox8qo8zE1Whs9hB0VOxc+oK/v0aH3X7wKtZOPAKjk0PD0oN3QT63X/IQjbUJACtoYRXhY03jMPBPealdwHcXdF0Ic8SuqEbzsjre5MphKqcWR3yPFQ/grWrLhRvwQje59UlccDWjfurPKlc+mE9EnRDmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsT1ApKQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467a1d43821so2647851cf.1;
        Thu, 12 Dec 2024 08:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734022278; x=1734627078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2uH/oXT93NM1ZuZnDKURcaH8gexK7fW6xFoJ7SxlNw=;
        b=VsT1ApKQ9vYmY8CdLcz4CbpiK6xKcyMYOgKEEvxI87nebo5MlQKUzxHJdqz6q+h0iu
         Uz39/zq2a1BpYDWsF3R0QePyonz9nG8Xe9lj5OKkoUL0Xqg7LkjFxY8cLaF31AftlV42
         TOxVkVJfDUKbNCT5edBRHgFg4ieJDVvokW6W1W70nq4pe1dE4iytn0ZDuM/p9BxCwUNJ
         1NQYePhvz/Qf6neJmtvHtwcGb7h4LidEHeo8i0DCOiwA9l65rnUFXqIM8gqy2RgTt33F
         K+LY/W/KWb6DD32/Us1/o6R+gF+FMPA9Ls9gl2uz8YXKYdRB5AmNlvHtIcm56ZBISlVF
         rXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022278; x=1734627078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2uH/oXT93NM1ZuZnDKURcaH8gexK7fW6xFoJ7SxlNw=;
        b=adc5Q1NfuuAIeFqf+o0hpg8h8Omg0x8sfXH3Ar9THRBLlMmKr51YHe9ghiN7uAAuBN
         +GvuXXao0ZrmtB5mznhGjMpgKm48cfQI65IskrhCI+Nrl9unYc04+4cbuIGOpm3FW2rB
         pXo63b2uqPDm5R8ykrPxGtd4y+JQmdeqyb0ylXe6ppNx5T1jyfaCphyD3bO4OEZo9AJJ
         OivMewmbOJX4n37w6hsay99MpbxrTO3F4e8NGAmtBEqCgJ3Av+HyGTjOsx47IvO7S9XU
         mzC9582BphKrPlSmEg8RyDrH6rAxUIu8iLXCeYFIkxVavmIz+XIWhiXfL7BZe54WtYnf
         IMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUnKmytjgpjHqPwLTIUtQPWIDBCYeAX2YBstvu7FJYap6CQOrA8FhlJ0aKcbQG4VwkxkVBloAsOhgjowSk=@vger.kernel.org, AJvYcCUvRwhEPWkPSaUdrV2Lk2E/H1bgX6KXOenQkUGZ8Ix6Pv0dGUPYdEQKn9PoMaerUzIFkG4P7AkkScUqLUQkdvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCdLYVMGsbdSxPPHBuScd7b8isfTCR9BPR7UbyaxTOQPJgpr0
	bXTK0G8GBemXjOxJs/jkckWjF1W04WpmNhxdu3RWTOKnLSUPLQrp
X-Gm-Gg: ASbGncuGBGbgHTn/f77aoRcpEXL9RkG8FOCq4XZRpq1/W3dAfX4H4FaD/5mvIfulpQV
	hETP3As4AQsd9p6BWDlmnV2tsCtCsESLtucXoMFIRy6vl0bU9VmgIeqZv0Z4c7sa7qOpSbE8Ku9
	jYx7h6WeHGLP2NBtkwjkozDJcInCs3WSmYWQG+TXeU87rriYArrz+wbQbvcOp1WQn0G8zVyt22F
	0rrUNz5UyiWPzTXAFQVjvBvxeUvpxi6w91Kz696Fhna6UAQGTrYOyKB822LmCfHvA6DqQbfFmvi
	tZKgXIRWPkKE2nG3fYT4iBU6HPMyR+YC4ekdEuv/CFdTkUw=
X-Google-Smtp-Source: AGHT+IGcFkOckWjekUygegUyPeYVGJN8AAndZWjRKIw3VWnBaRLTiSOprpWFD5cSsZMN597+GMue7g==
X-Received: by 2002:a05:622a:5449:b0:467:517b:90ca with SMTP id d75a77b69052e-467a157fc08mr16734821cf.21.1734022278273;
        Thu, 12 Dec 2024 08:51:18 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46783eb0d91sm27057931cf.63.2024.12.12.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:51:17 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F113120006E;
	Thu, 12 Dec 2024 11:51:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 12 Dec 2024 11:51:17 -0500
X-ME-Sender: <xms:hBRbZy_5gnI3Mvf-i2IRA_8ZBL3Vg4vX2dVmN_QxO--Hp28WFsqQ5A>
    <xme:hBRbZytv7i40a8E1JWSGNOway50CcUy8yxW7-GGpqDhd9ugW5ZeK22WNm_oegIHu3
    jhOniKrPOuZnBsNlQ>
X-ME-Received: <xmr:hBRbZ4BPavBcnWU_Yn86qAMRWt_Ic7yi-m_S4XXAIt-j67uklCrpJbRi_uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdethedu
    udejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgr
    nhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:hRRbZ6dFlG-mfuSED6mbuoa1eIpGu-cPEOSj7QUOZXiTt-bHPRuNvg>
    <xmx:hRRbZ3N27fwevAvJc6lbiSE1_BGltGk3O2EbZkgqjUIS-X7DeACNcA>
    <xmx:hRRbZ0ldcXatNXxIIy3RG-f1ZqBhpXmWIC0Ym46IskbXl5DCR7btXQ>
    <xmx:hRRbZ5vf_QcXF3KV_J0GdT27DmwIoC77ccz_HPxLMMNiE9I6N4Uklg>
    <xmx:hRRbZ9tDkhP1YY4jjExeqKoPut0ga7qm1nnFm8HtmkMuQNJdYHJJNsuC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 11:51:16 -0500 (EST)
Date: Thu, 12 Dec 2024 08:51:10 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>, Filipe Xavier <felipe_life@live.com>
Subject: Re: [RFC 1/5] locking: MAINTAINERS: Start watching Rust locking
 primitives
Message-ID: <Z1sUfudkQzZLdLiX@boqun-archlinux>
References: <20241128054022.19586-1-boqun.feng@gmail.com>
 <20241128054022.19586-2-boqun.feng@gmail.com>
 <20241212100641.GW21636@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212100641.GW21636@noisy.programming.kicks-ass.net>

On Thu, Dec 12, 2024 at 11:06:41AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 27, 2024 at 09:40:18PM -0800, Boqun Feng wrote:
> > It makes sense to add Rust locking primitives under the watch of general
> > locking primitives maintainers. This will encourage more reviews and
> > find potential issues earlier. Hence add related Rust files into the
> > LOCKING PRIMITIVES entry in MAINTAINERS.
> > 
> > While we are at it, change the role of myself into the maintainer of
> > LOCKDEP and RUST to reflect my responsibility for the corresponding
> > code.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> This seems fine with me; thanks for taking that up Boqun. I'm assuming
> this whole series is aimed at the rust tree, in which case:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 

Thanks! Actually I'm planning to combine this series into my upcoming PR
to tip, the PR candidate is something like:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=lockdep-for-tip

(I still need a few days to catch up with other locking patches, so
probably after -rc3)

Would this (targeting tip/locking/core) work for you?

Regards,
Boqun

> > ---
> >  MAINTAINERS | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 443217066eb9..3a6a193fad99 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13351,8 +13351,8 @@ LOCKING PRIMITIVES
> >  M:	Peter Zijlstra <peterz@infradead.org>
> >  M:	Ingo Molnar <mingo@redhat.com>
> >  M:	Will Deacon <will@kernel.org>
> > +M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
> >  R:	Waiman Long <longman@redhat.com>
> > -R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> > @@ -13366,6 +13366,11 @@ F:	include/linux/seqlock.h
> >  F:	include/linux/spinlock*.h
> >  F:	kernel/locking/
> >  F:	lib/locking*.[ch]
> > +F:	rust/helpers/mutex.c
> > +F:	rust/helpers/spinlock.c
> > +F:	rust/kernel/sync/lock.rs
> > +F:	rust/kernel/sync/lock/
> > +F:	rust/kernel/sync/locked_by.rs
> >  X:	kernel/locking/locktorture.c
> >  
> >  LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)
> > -- 
> > 2.39.5 (Apple Git-154)
> > 

