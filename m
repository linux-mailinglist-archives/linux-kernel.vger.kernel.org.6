Return-Path: <linux-kernel+bounces-351290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6D991066
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD89B3033C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76641F4711;
	Fri,  4 Oct 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6dqzA50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F01B4F21;
	Fri,  4 Oct 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067893; cv=none; b=IGoRrxUODs9gaUmfeYQ9jFY4BLpJzR1+pAXEPDgVLxmU3ozVriGzr48tvPKpaGCo4X62ZOQDn5uPF9OhJXuuOPk1HSCw1FhYpTgBQ+uzL5FMKzkgSmhHJQPq/O+oGrfGRDdfwfT3g3M57rrH+a6oKh1gXEFht/O5xyeqa9/VVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067893; c=relaxed/simple;
	bh=UuZy6A6LuFUhlQOeTvkyHBMAN4IBW/fb9Y4T/BE/DQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RL5APu6GqPafDNcJh3/mHJwaaVhbJYe4wDC1HKKAKcgFQ3f7WsUfCNFj+uSiTMRrb1U9HdtNIw/6wAyP0FI/rHqpak1VGvHrwKjJoR0W4s9IebZLMRCzhtZ4MwcTo/az12JBgveEnU0Wxw0Q1l5Mq+tCnaUc4JS43kcmjtCgMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6dqzA50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8470EC4CEC6;
	Fri,  4 Oct 2024 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728067892;
	bh=UuZy6A6LuFUhlQOeTvkyHBMAN4IBW/fb9Y4T/BE/DQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=S6dqzA50OWy5mLDaFh/bCL7R2eDXUfEVbi89sYlvycWNhKa4alDc90XskYHLLrsjR
	 o9OAgjxtKkznQ7tcA3QwaQhRbZMEsaoZJTOc6E0wPaJK90THQBZNhQScdeatioEKCR
	 /7Hv72VXsOsIIA7oFNnZCgr/r9tky/0AUVjmHs+PPUffqGzHmEJ5HdNkNMUOqdGhKx
	 6S0h9OFdhX1psPM5C9TNqFOIDwGP8qB0Fysj/rZcTKQxyIRb2/1pIGbphJGLSLeLE5
	 L8GqFhoiUTFw1J74t/z6p2xvtQn09iReAqfd5D9/cGcTgq+NNI9tCIc9eY+xR80PdG
	 izA2YfJHe4udQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Martin Rodriguez Reboredo"
 <yakoyoku@gmail.com>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Dirk
 Behme" <dirk.behme@de.bosch.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
In-Reply-To: <20241004155247.2210469-2-gary@garyguo.net> (Gary Guo's message
	of "Fri, 04 Oct 2024 16:52:22 +0100")
References: <20241004155247.2210469-1-gary@garyguo.net>
	<pKZ-hxxNoouLWnfXzFGWvcgGgfjpEixPzJ--cZeEufWI9_MoG_mpToSPflheyUhYmZ4qTKLVypVLRuvX7rfyxg==@protonmail.internalid>
	<20241004155247.2210469-2-gary@garyguo.net>
Date: Fri, 04 Oct 2024 20:51:22 +0200
Message-ID: <87cykfpuqd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Gary,

"Gary Guo" <gary@garyguo.net> writes:

[...]

> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index f47afc148ec3..39649443426b 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>  	return (refcount_t)REFCOUNT_INIT(n);
>  }
>
> +unsigned int rust_helper_refcount_read(refcount_t *r)
> +{
> +	return refcount_read(r);
> +}

+EXPORT_SYMBOL_GPL(rust_helper_refcount_read);

> +
> +void rust_helper_refcount_set(refcount_t *r, int n)
> +{
> +	refcount_set(r, n);
> +}

+EXPORT_SYMBOL_GPL(rust_helper_refcount_set);

BR Andreas


