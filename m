Return-Path: <linux-kernel+bounces-433867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E29E5E25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7AE288BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578B227B96;
	Thu,  5 Dec 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgcf/czn"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244A21C199;
	Thu,  5 Dec 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422687; cv=none; b=RhBrr9AhWRaVnh0xVeMBsmUe4rIvmNQNyFWQ9uJShPwSrnLaKdEvuDzM7ZK0GDRHxbGm7R5TOuQfxQYEQz+rRfFNerwwvivy5ZY9FQc0jZmFTONfv8+WtJCPdPU2P5U8y+3EFu3ssorl8Ucct+UoRwsIW0cSZS78IwrmqwFmvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422687; c=relaxed/simple;
	bh=MussKX6TjRfUIUqwbQSX4y+bVSB5JUi+OiikjV5r8K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/mVtawsY5UmfcmxuGhQzRx7GlhPL6phL/r+WgcJEaAhuEKlAClwI51BxOV57SJV7m/O4xZugXCpUB+HESMGbp5Cyt9X/oFyn9cQ0PxN7GFnk2tQ/uMKmL8QIXTNNiAwJqHikKft8PFx/AtZm7urwPDJL5HHgSZxchWqofgDCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgcf/czn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4668283eaf7so12817261cf.1;
        Thu, 05 Dec 2024 10:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733422685; x=1734027485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aszqRzE3WfWMHRpWrpIt1nsLcE/DEwQUoQnHOZ+omng=;
        b=Wgcf/cznN53z7qCFT3Vg2NxfpUXn2X1BsM3swwOCemnIEu1AV8sQ7IXbLK5iRmuXKo
         YzjJmxKGjMwbhcJyxhTl4+++X7obq408r1gBVNG+88gzyEqcM6kjlI0IOI33nu8XFTj7
         IQal24HweQDFYlsOzGHec4BuU0keJmaPT0IwfrM3K48/u1j/inENjuyOWjNCLZZIh6bE
         nGDpuWuf5aB9cM4vFWfn7gCpLywJJhU87MvvqhBDQGWpZ1uZX5/ZH2VgKysl9lRMA8uv
         vyeqwvuGnAUvbNVALO1grykDClSk+HqNoTKV55xwyrihPi60XUf4782RxFsNEksJoI63
         pgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733422685; x=1734027485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aszqRzE3WfWMHRpWrpIt1nsLcE/DEwQUoQnHOZ+omng=;
        b=ZGq2AlIN5E14fcdbMjxholdlfVGs9wDos0n7cXBSiMWi7PP8yYlYbfCvC3A5pWzTHf
         M0B/DTtacJrODqkAIpuu2/tSTTvQbdr9wjBk0+4w8x5qyAtjYYeByh1LyJ6y0PXxi793
         O6t6BdhZ662A1Lm8sRe+iI46A6DtoSKjUgWpPYZ6NnBBww9Yhrh+92NTku01QlS78uN9
         TGw2wciCtiIdQ6BxlT4EBpn+xhBvjeoiv3FtaTOFX5FRl45/tvrX9al9Oxs2fE/kU4T+
         ZyE0qABlh1SBYL/y//zfDgpuuWbXBkKgWRAt2dimR1iOOQwBrfZrtOuUflTlMD2dGvKG
         Akvw==
X-Forwarded-Encrypted: i=1; AJvYcCXECEQjGIGDaiSuSkxz0TBeIoLR+q0Ywfd1VzGbFblxEfPVcXjiGRMvzKp8qTWiKN0jnipabcEVxTwnF4pG5zY=@vger.kernel.org, AJvYcCXrcXkrMsEcig0Jxhe4aRswWFonmQCVPc/TdVFZCr4uLmSVX8Ufugi5GfKhtJMhsgCl/UUEGEvBmtbrRRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMT2XslCGlVN4X66p97/2ALKhPVn/4SiSmt/GuoaWKxv79GxjM
	qMjsOwQ3OcPnVDZ3qnAgxvoBfsFqBlGttcwjXnEYU/NbAlQheJEc
X-Gm-Gg: ASbGncvGfymOCI/ZBBLxPTiBdF1yRszu3uXpZbLCqc8Y3wGi/j8ZbSyLA8rM1cnNYek
	Pl9g4fXL4IF53P+Eo2gw5VE4/Ax8GBxWLq5UKIzBYQYDbjRDt90ZCiaoCcTOzU3T9dGyA5dGEOr
	bsTVXJqdeBz7m8xVp+oYS7Z0Ti13+Pn5PwKbtPgPWx5zviOe1hP1UO8XyasAaB4HD2gyDS9FZOu
	9aTgK7wnoGvnHPD43Yg1h2MHcRvi0Vnl1nNgiJgdIqm0AurAWCStBRklqyy0AZjhxAhHDKDExCm
	7MXfK5tEpfKDRmYfp4m+raSdK6gaG9wf0/q7gxYN
X-Google-Smtp-Source: AGHT+IGQJW5yDNtX4FUMQiuU4aig9HhY0rGSD9d+Fbwrmt0wfxl+SKt5VYMLPoF55nadL2byWuY2OQ==
X-Received: by 2002:ac8:5a0e:0:b0:461:20b2:ba00 with SMTP id d75a77b69052e-46734979fa7mr4840621cf.18.1733422684906;
        Thu, 05 Dec 2024 10:18:04 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4672969dcbesm10426761cf.11.2024.12.05.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:18:04 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB09F1200072;
	Thu,  5 Dec 2024 13:18:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 13:18:03 -0500
X-ME-Sender: <xms:W-5RZyBeyCIn1qO8mWm_4PD_DlNPoYarshqxQtUeB4j2CVaUQY6UUw>
    <xme:W-5RZ8jvVqHiEkFiNi6rg7mppcqdsZCmnDgTjPYAUDarTswKX97GcmQjwvR0BWjPA
    29PUhMLfxm1SYivkA>
X-ME-Received: <xmr:W-5RZ1kgMkERo7nUBlOqzu6hfyD6S6iBieFGZEfgkAyLPZ9ni2hVK5vjYdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrd
    hgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhu
    ohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:W-5RZwwoVxAGT1sw6YLdvAAQpRT3YtQZIg3fuC5kdij7PJJcebGd9g>
    <xmx:W-5RZ3SZatIhMl_z28Y8yMMmkCOkI3yBTvtHOcxWT3YGSgKrTbHf4A>
    <xmx:W-5RZ7YqGO2H45v6qQddYFlsu4SVfNgT79PhM2pjSqonVOy1XVwlbw>
    <xmx:W-5RZwRFD1DAn_WI7OvYd81jpGkQXb75cklm6vIzdemqAxEdry6tug>
    <xmx:W-5RZ5DH4u59eaz7mmev939LJ3E7Cdz_25YJd9lJPue0-1LtaLV5Mk1l>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 13:18:03 -0500 (EST)
Date: Thu, 5 Dec 2024 10:17:25 -0800
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
Message-ID: <Z1HuNaDAiKV7L9ea@boqun-archlinux>
References: <20241205-guard-stable-doc-v1-1-a3f8249cf4d4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-guard-stable-doc-v1-1-a3f8249cf4d4@google.com>

On Thu, Dec 05, 2024 at 12:35:51PM +0000, Alice Ryhl wrote:
> Most locks in the linux kernel are stable, which means that holding the
> lock is sufficient to keep the value from being freed. For example, this
> means that if you acquire a lock on a refcounted value during rcu, then
> you do not need to acquire a refcount to keep it alive past
> rcu_read_unlock().
> 
> However, the Rust `Guard` type is written in a way where it cannot be
> used with this pattern. One reason for this is the existence of the
> `do_unlocked` method that is used with `Condvar`. The method allows you
> to unlock the lock, run some code, and then reacquire the lock. This
> operation is not okay if the lock itself is what keeps the value alive,
> as it could be freed right after the unlock call.
> 

Hmm... but `Guard` holds a reference to the corresponding `Lock`. How
could this happen? Do you have an example?

Regards,
Boqun

> If we want to support stable locks, we'll need a different guard type
> that does not have a `do_unlocked` operation.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/lock.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 41dcddac69e2..7eab46d4060a 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -159,6 +159,17 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
>  /// Allows mutual exclusion primitives that implement the [`Backend`] trait to automatically unlock
>  /// when a guard goes out of scope. It also provides a safe and convenient way to access the data
>  /// protected by the lock.
> +///
> +/// This guard may be released and reacquired with [`do_unlocked`]. Note that this implies that
> +/// this `Guard` type is _not_ stable, that is, holding this lock is not sufficient to keep the
> +/// underlying [`Lock`] alive. That must be done by some other mechanism such as a refcount or
> +/// ownership.
> +///
> +/// # Invariants
> +///
> +/// This `Guard` owns the lock as defined by the [`Backend`] trait.
> +///
> +/// [`do_unlocked`]: Guard::do_unlocked
>  #[must_use = "the lock unlocks immediately when the guard is unused"]
>  pub struct Guard<'a, T: ?Sized, B: Backend> {
>      pub(crate) lock: &'a Lock<T, B>,
> 
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20241205-guard-stable-doc-efad6812d0cb
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

