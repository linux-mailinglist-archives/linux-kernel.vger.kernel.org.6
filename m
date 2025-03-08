Return-Path: <linux-kernel+bounces-552192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A236A576A4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC67A3EFA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD5BE571;
	Sat,  8 Mar 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2aYbHSq"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990FC133;
	Sat,  8 Mar 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392766; cv=none; b=m+B1tD+pCYhwcQ6zDjLvDFHbDHRtGwzQNG9WGDYTJaLtW0phYTvhP7OFTLoHkigV47eXXuid2Q8sbbjDS8aXwEchNDGfJKkCQQonrh/vMe7iHzQnTqLDqCejTgV3dmBS/FNkhiUlWXusRO9INXmUKlyz557ap8ybgRwxT+fqspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392766; c=relaxed/simple;
	bh=bwUZFDWkPUr9LJL7xEE9wDJt0hAENHDRVEM+WO9xRbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2rK9zPnBhCPP6yRlfAIYK9XbwCSBr/cq26QUw9lsx0zO/4jXIIjCk0IBpjTvQhJPWFSjx94dVexFMfZjKuYmZWOWCvmfmYLr8sBVs4gJarOKYEo3bXjzXWp7dPhgUFe1hcdMwg/6aPhyQXWM+RnwgJwp0SfE8lO/EGhBVao18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2aYbHSq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47509b2bb7dso33521401cf.2;
        Fri, 07 Mar 2025 16:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741392764; x=1741997564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD8WUMTrYiNgWWn1aNpWQ5eXX8X9eZ6kF+IC0tF2Jvg=;
        b=N2aYbHSqNdE8be49UNiNQg/4HGaVpA3Y29+J2P8M10/0JbuJ/BFLSoitD4WZKRORA7
         lL8ys1HE2vr3NC/crGx6dIpYKm8AbeX+37Qdn6TY3KUkXyczl98V/2HUD2buQcr44kXQ
         6b4z8aGL7aF8fDWDr6lCIr82ZoXlkySPDI+cF1ecniFIcwhF3pbuo6pLf31q9XiIKwnU
         oLyjC5VBpTTeJJCQRUB4YoE6nVkp1r9b9it6SoU4Wy3EtLF5BXn8uHd+ZlJ0GA9FDYTN
         U4AlvErZJYb+U1VpCsKw3+moMtEcNE7jszFgE8HNLQybZ43CksSt1Nmu8Zge88z/StWV
         SxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392764; x=1741997564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD8WUMTrYiNgWWn1aNpWQ5eXX8X9eZ6kF+IC0tF2Jvg=;
        b=axd99pBInsyGYOn47qFeOUOSi+QWZuVdt/diakuabb2hHNEfX+yVItVfNl9BwLQebF
         gLN85oMMg/anDGwd5G2JN9hDYBrwEctlPdz5G1V3bnTuIYTci7Yv5Fjg6WoGqIAxO7y0
         nPPmm1colRDRMp8QZNnB9U83asIkmT6djCXyiwsmd8xQOnufoR+50hIGkqvzWczS1OSB
         CjrxRUpoJqF99d1oKzd1gqoaxVlhrJ10rIZ/BFvs7zH6QtK6oC+KiCLUS/NtIrIHK+le
         uDaR7ldR7uMf7KUjhw8lOAqxa/QW+t6g8Q60cQt70Og2G9nWQ+TTwUfiaKv4pdBoPX5g
         PfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV400bTLC2L5pCaYKBJ9ni3JGTgDaQnSbLzcMif6fsAuEngfyZ8Tgavb2btxevmJ+1tlocHhC78/b7g5V0V7yQ=@vger.kernel.org, AJvYcCW9kyjpHN2MKPPXAdbO1iffn8IAw+HVDYJEkc34CyYssFnHacFql5/C1tGx+f+9T5ZDV+RNhiyi8TA8/jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhV9WT9oj5ngm1ThO6AeYbnNg61NUbGIY5TnZTApLEhg9/eq3K
	SkHQxfKhrxat3U0GfxXgsKpWRrxajtaiivEkRHjut8rIL0vly5Yv
X-Gm-Gg: ASbGncvlM9QIwLB2Zn2NwSrirLkd+MVF5p8J6ofDLfLMRcI7l2GW5neeot7Gv6cYKon
	qu/6i6EeEXZjOjmQA7qGXllpxsvor6lpZ8WuQboeZ8vnRjqdUtzYnP8/ZT0hUL8cgEEeB4ma31x
	ArcA/fa9aozJUAQn9bx32OPbrOnR40vPtvrXHuSHYLTr3Mdhf012zFcefbT8zp4zkxSeIrPoAkP
	YCvFbcqHPvL1LXBGczw3aVQvyTWdVHqzWGSHDj5CLZH6TKq8T3XVC//ELAdDxaHmBqXzBBRha+e
	rpHgVpNoKSTdXFTVvYFhenjrthUz/h96dIN+MJ9jk8Msh5dxwx9BZwIEcqGRa+FMy6vbdDFC2Gn
	BFAoS1cbF5xhKpsujtPK7VZJUfrqKMzLQomY=
X-Google-Smtp-Source: AGHT+IEBUY9PXGFFDuAdSTl6qKtos4Shqp5dUII/An9F0nFYs6NWtqm9d8Wh5nGzQp40Q8vpVThLkQ==
X-Received: by 2002:ac8:5fd4:0:b0:474:f9eb:272c with SMTP id d75a77b69052e-47618af9c8emr82741581cf.50.1741392763765;
        Fri, 07 Mar 2025 16:12:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96b568sm26072361cf.25.2025.03.07.16.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 16:12:43 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC1361200074;
	Fri,  7 Mar 2025 19:12:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Mar 2025 19:12:42 -0500
X-ME-Sender: <xms:eovLZ8iERJGjNg_PDtYYRU5PVuglSE93zUwkLKuAqCl_fgMpT2j9AQ>
    <xme:eovLZ1BVzomo6Gwf3jzFh86H-anpnqVvi7neYCx1F-wlHpOmz_d3TNpiMphfw9dlg
    c2ROEUyve81lUXqLg>
X-ME-Received: <xmr:eovLZ0GLoAoD9iLf7uG9DA-A17z3hLJezFuUcuV2s1kbqgDnqeyYroXoYBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    peifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    rghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprh
    hothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:eovLZ9QcR8YxO21jWl9wgpDM0xOGn_NIpe-bCl6VKLphzb_7xke9Gg>
    <xmx:eovLZ5yC4ff338I8uHSzLBCpZ8w94i-JV8TyQh6gNOUbT-Pvbf_Zag>
    <xmx:eovLZ75gE1cCeSmvgE40f1v9sWn2aXtdkai_2zFaGvy__AB8aDaCNQ>
    <xmx:eovLZ2x28OFNJrf4DRouf3wkF34rB49SxYsqnMjcMZyugkRaCEfCCA>
    <xmx:eovLZ9hACBq4uqU7ICM1_z5xTHSxt4ppvO8GKCA88RRm99sAGS0lQ8uz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 19:12:42 -0500 (EST)
Date: Fri, 7 Mar 2025 16:11:30 -0800
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
Message-ID: <Z8uLMtcrWNMPqFrc@boqun-archlinux>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
 <Z8uI6aOd79xe32CS@gmail.com>
 <Z8uJoFsfvdeOmAiH@boqun-archlinux>
 <Z8uLOFLbq-EqAUfJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8uLOFLbq-EqAUfJ@gmail.com>

On Sat, Mar 08, 2025 at 01:11:36AM +0100, Ingo Molnar wrote:
[...]
> > > I've applied these 3 patches to the tip:locking/urgent tree:
> > > 
> > >   locking/semaphore: Use wake_q to wake up processes outside lock critical section
> > >   locking/rtmutex: Use the 'struct' keyword in kernel-doc comment
> > >   rust: lockdep: Remove support for dynamically allocated LockClassKeys
> > > 
> > > As a general rule, if a patch is marked Cc: stable, it must also be 
> > > applied to current upstream.
> > > 
> > 
> > Do you prefer a separate pull request for the future? I can send one for
> > urgent and one for locking/core.
> 
> One tree is fine - maybe indicate which ones are urgent material and 
> keep them at the head of the tree?
> 

Sounds good to me, will do.

Regards,
Boqun

> Thanks,
> 
> 	Ingo

