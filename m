Return-Path: <linux-kernel+bounces-413563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCF9D1B07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3069628495D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2791E7C0B;
	Mon, 18 Nov 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHWviz50"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB8158DAC;
	Mon, 18 Nov 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968336; cv=none; b=p0pWKxdk/JKEH6fvnY28WpSii04B7pBCZw6PmFyZehWyX6z15Rl76pAnXyMkNouXBQrsedlYJ+0crZlIWwjHw8u5SETnIyanzdaaAxzNUIggp2383U+WjKjoW4BSM2SXAc1p1vZXnT1VSR3khMrCQhvB8HTd36DI27nE2WA0kyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968336; c=relaxed/simple;
	bh=94Md2Bbdg2uJ/1C8DXzJpKoyTMxBfehGgIwyiwleNFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPBrpkfMtggM/z0jt2pUgRE//THshMzYVZC8x07JlB3XAS1wekooGJWpaRPgN7NoEaSkQtVGGgz7jcYktAtys4whfxjNQW7VLpj0ZL5mggBfypyzij6We2mkisfg1JT6oYR3wWToLh0vU53/Kl3bpMvyOk07w1KY1xZGOVcQKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHWviz50; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b157c9ad12so14837285a.1;
        Mon, 18 Nov 2024 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731968334; x=1732573134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdl+PoGf0HmpGeKu+Tb56R/ClTlR2kQttntRDnLIb7I=;
        b=FHWviz50b6+C35O5eM8c5Y3YODy+O2RnSMKk1P7Uyzc6w883n5SzCXsTxsubX8I5A2
         CXdjz5YNMMtLJKJt3Ysum0kC6O8UcxnkSCCrY9f5U1AbhpipQ6TUDzpQzJjLOjvqB9xl
         iKLKuMpnxVykqdkgrQVQHQQXsKi1emETridLnFVi+w8/JsoV9BSpReLW3YADbNOTJYE5
         r1VjYL7qVIzFFz9gG7Aq7zbXMywfhR0QRYDlJT9U4lgtbMzot7JqCaLF/z2Ov07E2g89
         Q4NJ8KW1SKmK4gsin7fAJl1s0S0QZbLHz15waXUACdf7kWRQ7q2MfCybR2oDOK2c+sXS
         DfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968334; x=1732573134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdl+PoGf0HmpGeKu+Tb56R/ClTlR2kQttntRDnLIb7I=;
        b=pSLNKGrZtBklgsyg+6VciwTOmwYctGC0kk0f7Yflel5eo5y0PMqYPCbATi9fxl0Mky
         D8Nk5lR/SFwewdPHPiTXHctRaxm2Ze1HZeO0xg82DYTNicu4NF1adIggIHXvTcEmvZbj
         6rYpBo7NEnvjWBqtlTAFKKx/IkEz9LZg956oyhZ546/aQzY+1aSsCXhqbPQE89fElNG4
         ygH5tAzRQL2YadoEYD2Czq3ItnS9Ko3d7tXKcq3Rc7XR8Z2YQnNbANT9vmEvsNuJ0ARg
         pfGb0wPjuxWIGuAgysESrvvSU2Uo+DlzlxjIzMn4PDbP0GxuENF+WeCH9cCWLNtnnefg
         ONKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaNLcMRWSh3z6poq0Dv0u1SX0dgkNbrev0PImTIZYOXWc5HJKp21oqAJQoWT+oY2l0eNCSm+TSgl+eelw=@vger.kernel.org, AJvYcCWmvvmWLALOmihvK2zL32iJx0d6lLHx6VUdvuGegmqX4ZX86EhUV2EasWDBsNQ4luUL2FJxyPRQVtWcEpk/XYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwowN7L5NLQQJv8gtNrvQS1HdDx6qhlmv3Blsh4YJr0VRRJ7jV
	F3WlNwtUjJgVg+X9WdugNNKsuNuntFhLYgHMRt140W1DrwkP2/hbe9DHFg==
X-Google-Smtp-Source: AGHT+IHyG5J2Avt5/hIxZwJRsRm/OHmF8fSepmAnvcQZIldqSDkhpyqZGQjOXYBb6tg5brtBYC7+1Q==
X-Received: by 2002:a05:620a:319f:b0:7a9:b9c6:ab4d with SMTP id af79cd13be357-7b36236620dmr1773169685a.51.1731968333945;
        Mon, 18 Nov 2024 14:18:53 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392b9b2besm3635661cf.10.2024.11.18.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:18:53 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7E6461200043;
	Mon, 18 Nov 2024 17:18:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 17:18:52 -0500
X-ME-Sender: <xms:TL07ZxVnuA_8uQ9Y6os94HW2gDLKMM3WuxDNi0WrPidZDtqE16PpbQ>
    <xme:TL07ZxnecuMM9g2KW4IY6JRpc4XlNaYnUrGdQG0kHxxGphNr-iDxac6zECZ6hhI7t
    XWPsOgA36Ik99_knQ>
X-ME-Received: <xmr:TL07Z9Ze329j1BZbquhombh2SBtuWqc2YhwFCXR_2K_KgEpm6ceZX7TGdKVrAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprh
    gtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:TL07Z0URe5dmgu4wFSeiqFJ_m8Fa7_5Sa5aSRLSIsBmsdxX3NYzD3Q>
    <xmx:TL07Z7kcyg5-WDEoqkoxLiSSbPipR8HezoyUe9pQ6-Jh1Ip91gGXbA>
    <xmx:TL07ZxcNT0tMWD8D14rPoWFDinohLnD2Qp3lwdyyMiymPB8uZs2pqw>
    <xmx:TL07Z1HOPIw7bHmStErFC816kfZiq-a6OIleD0BabuJbOSYU4cxBeg>
    <xmx:TL07Z1lrndDsE4JlMDz0nhzYnZ3G13lZHzbmPR8nETnkKvkEUK7OB8jU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 17:18:51 -0500 (EST)
Date: Mon, 18 Nov 2024 14:18:51 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
Message-ID: <Zzu9SzkDoq_1YQnJ@tardis.local>
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>

On Mon, Nov 18, 2024 at 11:33:36AM -0500, Tamir Duberstein wrote:
[...]
> +
> +/// A lock guard.
> +///
> +/// The lock is unlocked when the guard goes out of scope.
> +#[must_use = "the lock unlocks immediately when the guard is unused"]
> +pub struct Guard<'a, T: ForeignOwnable> {
> +    xa: &'a XArray<T>,
> +}

`Guard` would be `Send` if `XArray<T>` is `Sync`, however, it's
incorrect since `Guard` represents an xa_lock() held, and that's a
spin_lock, so cannot be dropped on another thread/context. `Guard`
should probably be marked as `!Send`. Or am I missing something subtle
here?

Regards,
Boqun

> +
> +impl<T: ForeignOwnable> Drop for Guard<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        //
> +        // SAFETY: The caller holds the lock, so it is safe to unlock it.
> +        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
> +    }
> +}
> +
[...]
> +// SAFETY: It is safe to send `XArray<T>` to another thread when the underlying `T` is `Send`
> +// because XArray is thread-safe and all mutation operations are synchronized.
> +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> +
> +// SAFETY: It is safe to send `&XArray<T>` to another thread when the underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` is `Sync`). Additionally,
> +// `T` is `Send` because XArray is thread-safe and all mutation operations are internally locked.
> +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
> 
> -- 
> 2.47.0
> 
> 

