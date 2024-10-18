Return-Path: <linux-kernel+bounces-371462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585249A3B63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0240E1F215E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFB2022C7;
	Fri, 18 Oct 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtUXfY9s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C2201105;
	Fri, 18 Oct 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246940; cv=none; b=baVNHkbC3xcpik6Cu5vvjiLlnF4fVkjpmzYXkVwYsUstBgKPSC5MhVnibAMHfmIb0UCAf/ueplPUlvpaV+n1A4fRm2/l+Hv8dSM3VqaPx5KMmtl8VKrh9X7ZAymzNcqxUxCfUntzBuZ3HB0gI7RBQgqHpMRkQ1IFq0B3Kij+Ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246940; c=relaxed/simple;
	bh=JYZFDYYwlzU5T4CwsY7Tajc2AFTl7fnURljZcT4/QBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E2GCkmgIUymWWSUpskxcrQ58/rdtIX5CMJqbYBjVFngU+pvpYhzGnHhXU+ieiT+3B4uMExBYj14d3INYZYXYOIafxt6WHdk78gG7TWEb06JeSxWDCIf6pzjXNrLG1ddaPpta9xeFY3elEiiS9YfOiOGIxLqUGfQW+bFUSJ3ZL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtUXfY9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD32C4CEC3;
	Fri, 18 Oct 2024 10:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729246940;
	bh=JYZFDYYwlzU5T4CwsY7Tajc2AFTl7fnURljZcT4/QBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PtUXfY9s2ubD9LXbcKlcyvl4QBLySdGkNM18gpge6lV6HY7Yw8ZrP2MYfjRiJccgt
	 uxwjJ/tfz8SCHaCnBRqrg5FKkliWhWkait3WSWN9OQdvozX5DHs6I0kzJUfPvufT4r
	 CL93ehFI0UpIvpQqRbPKeorYhaW6fnEJOPf1ZEhegxGNC5OF41Ba2kDuiD5UJbEAgE
	 bOeTUxsul31ZKAQ2iAQ9huZJJ0/0gm62wUpmxsR+zqZA96u2mx+vsvgeFKw3mgI0fs
	 6x3BC8AOme0y5NC84iKYCVb0XLrvaIRnerP+TILK0y5CJPkJY4IODnC0/0IyTfiT3o
	 t/Aayrnu4VStg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,  Dirk Behme
 <dirk.behme@gmail.com>,  Lyude Paul <lyude@redhat.com>,
  rust-for-linux@vger.kernel.org,  Danilo Krummrich <dakr@redhat.com>,
  airlied@redhat.com,  Ingo Molnar <mingo@redhat.com>,  will@kernel.org,
  Waiman Long <longman@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  linux-kernel@vger.kernel.org,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  wedsonaf@gmail.com,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Andreas Hindborg
 <a.hindborg@samsung.com>,  aliceryhl@google.com,  Trevor Gross
 <tmgross@umich.edu>
Subject: Re: [POC 0/6] Allow SpinLockIrq to use a normal Guard interface
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com> (Boqun Feng's
	message of "Thu, 17 Oct 2024 22:51:19 -0700")
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
	<20241018055125.2784186-1-boqun.feng@gmail.com>
Date: Fri, 18 Oct 2024 12:22:07 +0200
Message-ID: <87v7xpr9rk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> Hi Thomas,
>
> So this series is what I proposed, previously, because the nested
> interrupt API in C is local_irq_save() and local_irq_restore(), the
> following Rust code has the problem of enabling interrupt earlier:
>
> 	// l1 and l2 are interrupt disabling locks, their guards (i.e.
> 	// return of lock()) can be used to track interrupt state.
>
> 	// interrupts are enabled in the beginning.
> 	
> 	let g1 = l1.lock(); // previous interrupt state is enabled.
> 	let g2 = l2.lock(); // previous interrupt state is disabled.
>
> 	drop(g1); // release l1, if we use g1's state, interrupt will be
> 		  // enabled. But this is obviously wrong. Because g2
> 		  // can only exist with interrupt disabled.
>
> With the new interrupt disable and enable API, instead of a "unsigned
> long", a percpu variable is used to track the outermost interrupt state
> and the nested level, so that "drop(g1);" above won't enable interrupts.
>
> Although this requires extra cost, but I think it might be worth paying,
> because this could make Rust's SpinLockIrq simply use a guard interface
> as SpinLock.
>
> Of course, looking for any comments and suggestions.

I am curious what kind of performance impact we would have for this
counter in hot paths? If it is significant, and if we can design an API
based on scopes and closures that perform better, we should probably do
that.

Best regards,
Andreas


