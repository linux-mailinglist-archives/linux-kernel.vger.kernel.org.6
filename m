Return-Path: <linux-kernel+bounces-546436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B7A4FAA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE3B168437
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC7205E11;
	Wed,  5 Mar 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ0efwiL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA781FDE37;
	Wed,  5 Mar 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168387; cv=none; b=DAe6rT0nT74ZvRkyuE8PyXh2PSVM30kFnKI4vBRNZ0lLd2lCiOIl9zbp5I/1EXNgy3uKJ57fM/DWOHdVauz/HAtzvIwMRatnfKET7wjx5eVwaiVUdWLYRe73U6oemMbGzAyhl1EpRHHr6FhKttJi2yi/kERi8+EVLXwSdR5u6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168387; c=relaxed/simple;
	bh=15zWYZ5QlI73ZZKI2fE3S+9PVZRK+DccKsphepv/Jis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O8z9eBRt0ncx20ke1YLtKlnTZExxWJ/OkqAxFgU47mwGHIdoHZrk3LNEhRaOVqm7CgeQyouVNSqJBAdHUHJAJupeUhfwtThy/hikFDGK6Yqj9bJhlROLG3wHPJRaodqEDYvgkgruDgyv285fZ5uSQlQXDua8biWHYizZCk4vof8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ0efwiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768CBC4CEE8;
	Wed,  5 Mar 2025 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168387;
	bh=15zWYZ5QlI73ZZKI2fE3S+9PVZRK+DccKsphepv/Jis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FJ0efwiLvYqggQhPrEjc17Dwbe6dvnuTqWCyQ1ALsKM2g2afKhs/NwpWrFERSD5eF
	 HBcgJ2L5SLonsJoMjZ8x9Gfx4c/Wi2hlUD4yx0CKc4UE79P7a6Rh8HeKdgG6w6g9//
	 h9ShgLWZQjGdL1QtW9FBWq8uLdX1tJuqtdzZJSb+GLfu4qMZmvDpz+iFYEWQ5WzLm8
	 46dvgNtCAo9UCQZA8VFDbEPScOKToHU4khBg0y7ZP6Tov+eZbBkXW5Mrm2hZo6dXEb
	 2LPnK0qtVFRlmY6rq2fftADpBWwIGieUY3Cgj56LZHSc4/DouV9H1axill9GMCeMBg
	 2c+lcph3NvjOA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/22] rust: init: disable doctests
In-Reply-To: <20250304225245.2033120-2-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:03 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<sIa0gEFObIVkQIOds6BkLjVFyVpGcJ70lKQ6CC6zAjpKS4xGB0hcKqo170yhITiDQfjg7s2CigwRoJfJ2fFvmA==@protonmail.internalid>
	<20250304225245.2033120-2-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 09:51:20 +0100
Message-ID: <87plivg8s7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> This is the first commit in a series that splits off the pin-init crate
> from the kernel crate.

I recently learned that using imperative mode in the commit message is
preferred [1]. You might want to consider that for next spin.

>
> The build system cannot handle doctests in the kernel crate in files
> outside of `rust/kernel/`. Since subsequent commits will move files out
> of that directory, but will still compile them as part of the kernel
> crate, ignore all doctests in the to-be-moved files.
>
> The tests will be re-enabled later when the separation into its own
> crate has been completed, since then the doctests of that new crate will
> be handled as normal host doctests.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


[1] https://docs.kernel.org/process/submitting-patches.html


