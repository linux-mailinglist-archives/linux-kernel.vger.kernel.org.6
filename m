Return-Path: <linux-kernel+bounces-435462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188BA9E7814
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76B62826F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305B20456A;
	Fri,  6 Dec 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUE9/SUb"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14C1FFC47;
	Fri,  6 Dec 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509703; cv=none; b=XAG/g5FRqp8hWWsanr1PuqbyfJloEHqcWOQZ9N2No+4SVsf0R6y7Ec5QEf9p2oOdjUqcA0K/8892uPOv1o8FrzqeSjw3+JMEnK/2P/Sm6eoPCkou51eey+A2+9Y5b3Tf5aClTtzL2PazwOVXjpzK41TKhC7s/+RAZN7P41fWnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509703; c=relaxed/simple;
	bh=pqnPZanCxADqBj4U/3XRE8kBols/Rcr0klUmFI9P75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP5hNxuFl45Nl5md/d0YUjV1dN84oVi8AcdTk03l7nwsqJa+gIivSOLJESjLM43W20NAPDfQxxVwlxf9Y036jvAiwrRiGsjCwppIncL7b1QeTh/WFL8lZSuJEmEPKsbCJoLUlXoTewv4i3ZxCB+qewEfyOcXppFZ5ZMqY/oG83U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUE9/SUb; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so20244086d6.2;
        Fri, 06 Dec 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509701; x=1734114501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kU2nJWSRAtU+NCFbzbxa9m7Ys/Qa02pFjHOzHEkXOS8=;
        b=dUE9/SUbRYaTdm4qa21kaQvKnVVKFOuQOerdBeTmuzm55GARbXER4QCRyOUg3qHB4H
         XsF7p582slIxKbpCEDnurk49K6DS6TOFDLFtPiyqDyVYVak77zAr3RvaCtTYaAID6RYi
         U69704D+kxx53YHux+8ytEftVnJwCXCQ9c34aXOEgWb3GbACHZHWdDVnf7jYO9KdF+Du
         y31OcjqEtCgK+5PlAWImMmWp8O11Sq89r5xqXWa0XV701gZdN7XxT82VX0SRa8fhiWXy
         23eTiKELcnRInkTsYQe2IfFhgkdERkmIGIXxuPwZ9O8cUrmOf9k9N9EV8KFuyJ+nDO++
         Xaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509701; x=1734114501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU2nJWSRAtU+NCFbzbxa9m7Ys/Qa02pFjHOzHEkXOS8=;
        b=sWnCWL4buhyjAKs+koJMbJOtWcip+6sYLh/ClQMOOPUQ0AbX1PlXX8cE7gNMqP75J7
         KnK3WmUeFCQSy3bjLnM82Es+x5ABugFsboWN9cH+YlRQeZVPY6GODpFY8qbUFKH1TD+D
         f2XG8SkUEysM+sGxNxtRDPBmPQOE5OFyJmmYI6PrmNv+cvClyGGiJtdSYSWgpwUDlj3H
         PjJaFpGS8nNiqKMEfkcCbhs5ZwuaqdTPdpnzqn+bhiuCRbNLIVMsuAQPRhaqajF+q2S/
         eFb9t3J45F5lAOJN8EO7viNGGeF++JDXvjK47+fJ8cxp02/TEfU3uX2mh0CrcfltqI6v
         vn4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVubz5GqB5Xw+w41Ezq+WhSc0UNQ+9itf/N8RpFSBk1VjLXC/iRETlOO9Dj//7k19MhTQGVjDL0IF46B7pLJo=@vger.kernel.org, AJvYcCWOzBkfuc7E57rEiiOiCxlY+lFwtUWibZPOkfjIY1GLUiK+4Uxskeuh1oK7vyAAp2XnZ6RQ8RB/j3ASoP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwaDihQvFeZnlxbprY6LesGffGkyJXk2ro3riz7grAeI0YYhw
	jxao3w9fW+XCg+9TbuOpY8J7J+xFODz41KuMrmSqMv9Lv3kGXmdx
X-Gm-Gg: ASbGnctAKix0755EXRkQajcm08QnggX21pRxkPI1No4PsGBKxJ+DlTJoY9jE1ItZp3i
	YtS6XxIYUSWMe08sjdm2FOOEBdxyqm/Vn53oy1qM1g52ADDkowgeMuojrl7Qt9ZDvCfBFc8idN0
	GNeXbH7S90b55OxIguQ73H3R8rxNiiiP/Jt9tNWB1q+UWJRixbrnaCIx3RYxyGi0vmsk/rVIuDw
	JQD16Pji4oiuEOR8nfWBUkMtXzPeoHhKkN0sLXiuPUZAjtTD+JztMpmAE8CUOqWXQGnKj5sviMm
	VUaH5dxTHRw/aBB1drNIspzfxiTBzD00YMYF7ZP8
X-Google-Smtp-Source: AGHT+IGthX1187hscJtoCNHYfyTHliHBIZzQz2wKkwmBduG6RySHwR8AwxBCA3rwk0kmJHUOiu8bbQ==
X-Received: by 2002:a05:6214:1c49:b0:6d8:accb:5a3d with SMTP id 6a1803df08f44-6d8e71e5cc1mr51785476d6.34.1733509700961;
        Fri, 06 Dec 2024 10:28:20 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a83eb3sm198233885a.85.2024.12.06.10.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:28:20 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E9D6A1200068;
	Fri,  6 Dec 2024 13:28:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 13:28:19 -0500
X-ME-Sender: <xms:Q0JTZ9YyIHQPXBHq4rFZoj_ahBgCYBn5myZ_NPT-2uDsJTv6zQLVnA>
    <xme:Q0JTZ0YFoBh8j1Qcjq8TmDO-NphDfD70ioNw0XflClrgEiF5vny7dm5hEv4a4B982
    Eh1HCziigK7hwv67w>
X-ME-Received: <xmr:Q0JTZ_96x8i5Yni8i2AjBwQno9Xy_BRjsVx9DK4t3KoAUoVtp5pjCo0Ejwol>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:Q0JTZ7rkZ3-3IqdJF7gwlehihJImIv4p7ZjCZgmoGpdLNBvSN3jlxw>
    <xmx:Q0JTZ4pDd_o1n_nBk7nE5cpheabvJRK3XS_18UKWIcIPxpuNLHEmRg>
    <xmx:Q0JTZxRalDuun-PCvK-WUSexJYh04jq2rah-jAxa5-a-88vQkXtU1A>
    <xmx:Q0JTZwrkJXx49KbYKNF4Zw5-IPhmfLrCGqurxVVBFfJlv0iYy6aDrA>
    <xmx:Q0JTZx7h69Qbv2qBkI3x6LT2fnRe9w96S0qhJ-JDBKuHsGUlLMxWjZsn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 13:28:19 -0500 (EST)
Date: Fri, 6 Dec 2024 10:28:18 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: sync: document that Guard is not a stable lock
 guard
Message-ID: <Z1NCQiGRopuS-Uc8@tardis.local>
References: <20241205-guard-stable-doc-v1-1-a3f8249cf4d4@google.com>
 <Z1HuNaDAiKV7L9ea@boqun-archlinux>
 <CAH5fLgi8N6bdke1o_uTvYsYfwH1KhsY4wTGmFpc43Mi_U6+KWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi8N6bdke1o_uTvYsYfwH1KhsY4wTGmFpc43Mi_U6+KWg@mail.gmail.com>

On Fri, Dec 06, 2024 at 10:56:23AM +0100, Alice Ryhl wrote:
> On Thu, Dec 5, 2024 at 7:18 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Thu, Dec 05, 2024 at 12:35:51PM +0000, Alice Ryhl wrote:
> > > Most locks in the linux kernel are stable, which means that holding the
> > > lock is sufficient to keep the value from being freed. For example, this
> > > means that if you acquire a lock on a refcounted value during rcu, then
> > > you do not need to acquire a refcount to keep it alive past
> > > rcu_read_unlock().
> > >
> > > However, the Rust `Guard` type is written in a way where it cannot be
> > > used with this pattern. One reason for this is the existence of the
> > > `do_unlocked` method that is used with `Condvar`. The method allows you
> > > to unlock the lock, run some code, and then reacquire the lock. This
> > > operation is not okay if the lock itself is what keeps the value alive,
> > > as it could be freed right after the unlock call.
> > >
> >
> > Hmm... but `Guard` holds a reference to the corresponding `Lock`. How
> > could this happen? Do you have an example?
> 
> Well it can't. The reference is yet another reason that Guard can't be
> used for stable locking.
> 
> This doc change arises out of me needing a stable lock for something.
> 

Maybe it's better to put together this patch and the stable locking you
are working on? It's better for reviewing in that way.

I can see what a "stable lock' means, but want to make sure we change
the doc to reflect the exact requirement of a stable lock.

Regards,
Boqun

> Alice

