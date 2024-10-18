Return-Path: <linux-kernel+bounces-371690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9559A3EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9811C2217E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1E23D2;
	Fri, 18 Oct 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChfuYdmc"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB643AB0;
	Fri, 18 Oct 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255394; cv=none; b=co4SRu/WBOUIklGtKe6CsRKI464RFAYJwKCYJ9cjlnDtV9fuAuxbGjK7Mmcp9AhhZxLU+hyCIjPZQdk+qfen64tpIrjLda6kwLh03ryuSoMizxF6pGOQuQO7N0l24nsf0vB1KuPiM5+Zx7erB038cHJRJkGOVKE5USLUrjp2Ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255394; c=relaxed/simple;
	bh=W6aTz4cGz9Saz2HNN1Ua7PMZKL40MD6P6uYvA+/emXU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hCfGZCNKqrWdC3Tv3TaluibdciXFxtMidd4oS2xn8lGaOFZVCwVy1JtGAM5BikZKczytlBcDmgYw30c6qIYC5p45iVoBPWMY/ybk3wI1HfJfK5eusR1gpCKWYK7Wkq+zOgHxryPdBmX4mwssLyGHthwjvTLq8VO65+VUmAVUQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChfuYdmc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609e784352so10454251cf.0;
        Fri, 18 Oct 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729255392; x=1729860192; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh2EgVq/ab+83N+VnqDVhG21ITGgivyxSW1wsr6Ri5w=;
        b=ChfuYdmcbVpN168/oszXv/C6m00G4wSwV00tmvtfd2f89JQGaMhYC1YPz87PJy8fHU
         pgVfWuHg2pPXwe6QOXfx/wQpSN6CMcYFRbJ/vw868juezdg84x6d21Tdax3vC9/A7DLb
         glKtgiGXDCBYhjvc0YrXBKBpt89BlT16HZwdMOeGhjsxdZlCqGwxnF24DkrK+J8W4CaU
         mjzGEmdciFl88HRE79Qu8vuISV58e8/UxJ+YmZp3l7ukJUrQ0WV22dMQqjSmqkbHvUbA
         LGbGIeSU/QXt41pu4lPPjOMfFYchOwoUUtVVjHu1Bv47FqwytZLy21QZTrQG3xPGKzk4
         BiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255392; x=1729860192;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mh2EgVq/ab+83N+VnqDVhG21ITGgivyxSW1wsr6Ri5w=;
        b=QP47M650IlezbjZhwLHm3Oo39kxTscB0jE7zWq4JixzrIt5pGFG0GDRpEyRWsFxbkK
         D7SGqTiWkc062Bt/8ZklrPyY26UbYSb+Btk6mtKknG4J03S7jB4mOmPvviNJoU3CC/93
         2HbE73qNy01yI9l/jnhPcJeETWQgBKxb5o1jSP39lugWY51tdsaHRENDsuZOL5KSj2W4
         tjpGH3FnzSy4z4DAxXkS+LJhN89c69daUI1k+X8dSa/l12M6A83pg6QlPxzLEsNl49JU
         CbUZMi7xT2Ovv/2D3iOZTwP7LsDAdUvDdA3RREqsPeEZFZVr1SAxlhQ69ZEFSccaZhnK
         R9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW59XmM6b3pPfop9Hie9tdLPoBCF62UmegpWPx4q0LVXeg0IbShBfvzqByH1BjMyGYPYUmMcib9MG6ju6GrQZQ=@vger.kernel.org, AJvYcCXq2efxetx0OqxeYR6LdpTCPiVL9dwaSEUC/YobLIchkOQ6P9c0ru4uyJ3rOXCyo25019LjczQmvfWIGaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxquenX6ozUaBEmdP9/50ydEClrBpk5GCEh9Y6llmt6hDyj5tao
	PzzEOb+3YmfZ3Lz6BbCzYZeRx19tfuACU5oXQczpzV2ztsWSyl/W
X-Google-Smtp-Source: AGHT+IHmXR2EVjHHpW2uJKQnPTIRPYVUYUk/3cUSpgBxcUfOHyFNqClHkVo/90fxsA2zdQkJnNmuWA==
X-Received: by 2002:ac8:5f4d:0:b0:45d:8bd6:a598 with SMTP id d75a77b69052e-460aede56ebmr20878781cf.51.1729255392166;
        Fri, 18 Oct 2024 05:43:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae947996sm6892611cf.16.2024.10.18.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:43:11 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id CCDF8120006E;
	Fri, 18 Oct 2024 08:43:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 08:43:10 -0400
X-ME-Sender: <xms:3lcSZ2z8OhgWCvxagi26UyEZGbagpX5Ziqf10nGWOHKZEe1QCaeQNA>
    <xme:3lcSZySebPOHKRS_BLGikO4xUWQDIhqlFZf4BS_Z7_kN0Pn41zGvtn5rSLzBzqG8-
    V-6wx6jHWyFPJGLWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfuehoqhhunhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepieelueeiffefffeigfelheeggfeuuedt
    vdejvdejteevudffteeffffgkedtuedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvg
    htpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopeifvggush
    honhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:3lcSZ4UF5DNHGOB3BZ331KerkXVnnePvxETdZY9-0_3DBX8MO6286w>
    <xmx:3lcSZ8hDi6YhgooeFhneR3BbSc-RE0-PGY9G98xE5NyjvU0Hb0ngSA>
    <xmx:3lcSZ4BQ1TDSnP9rZ_nrPu5x2RlXygt7k8dpuwkb_FdvMoYpGUWA_Q>
    <xmx:3lcSZ9LiDCjKOVP6sgiZ_loaEt4Q2nXMcOE04Ipj0bW0kHPWGO7nSA>
    <xmx:3lcSZ_DQeknH0Aqz1qvAUkVGrJC8p_E59gW-3UtIHGwA1Iv8LlL6kBz_>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A253BB00068; Fri, 18 Oct 2024 08:43:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 05:42:50 -0700
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "Dirk Behme" <dirk.behme@gmail.com>, "Lyude Paul" <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, "Danilo Krummrich" <dakr@redhat.com>,
 airlied@redhat.com, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
Message-Id: <3f1baf35-bf0c-47a7-840f-c81974334785@app.fastmail.com>
In-Reply-To: <87v7xpr9rk.fsf@kernel.org>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com> <87v7xpr9rk.fsf@kernel.org>
Subject: Re: [POC 0/6] Allow SpinLockIrq to use a normal Guard interface
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Oct 18, 2024, at 3:22 AM, Andreas Hindborg wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
>
>> Hi Thomas,
>>
>> So this series is what I proposed, previously, because the nested
>> interrupt API in C is local_irq_save() and local_irq_restore(), the
>> following Rust code has the problem of enabling interrupt earlier:
>>
>> 	// l1 and l2 are interrupt disabling locks, their guards (i.e.
>> 	// return of lock()) can be used to track interrupt state.
>>
>> 	// interrupts are enabled in the beginning.
>> =09
>> 	let g1 =3D l1.lock(); // previous interrupt state is enabled.
>> 	let g2 =3D l2.lock(); // previous interrupt state is disabled.
>>
>> 	drop(g1); // release l1, if we use g1's state, interrupt will be
>> 		  // enabled. But this is obviously wrong. Because g2
>> 		  // can only exist with interrupt disabled.
>>
>> With the new interrupt disable and enable API, instead of a "unsigned
>> long", a percpu variable is used to track the outermost interrupt sta=
te
>> and the nested level, so that "drop(g1);" above won't enable interrup=
ts.
>>
>> Although this requires extra cost, but I think it might be worth payi=
ng,
>> because this could make Rust's SpinLockIrq simply use a guard interfa=
ce
>> as SpinLock.
>>
>> Of course, looking for any comments and suggestions.
>
> I am curious what kind of performance impact we would have for this
> counter in hot paths? If it is significant, and if we can design an API
> based on scopes and closures that perform better, we should probably do
> that.
>

We sort of still have that: for example, in your timer example,  because=
 we know
the interrupt is disabled in a timer callback (when it=E2=80=99s execute=
d in hardirq context),
we can do:

    let irq =3D unsafe { InterruptDisabled::assume_interrupt_disabled() =
};

    let guard =3D this.flag.lock_with(irq);

This will save us one unnecessary interrupt disable.

Thanks for trying this out!

Regards,
Boqun

> Best regards,
> Andreas

