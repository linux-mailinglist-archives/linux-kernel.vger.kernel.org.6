Return-Path: <linux-kernel+bounces-521197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF669A3B7FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2D53BB61D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DFD1DDA36;
	Wed, 19 Feb 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSKIp+Fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA91BE23E;
	Wed, 19 Feb 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956123; cv=none; b=sGMDiEZAGmtt0uPfZQ9nZwo1AMR2O2q+sqn1sJv3kTzYQvEyDSCzQswmYnK9sYVKeQxbt60Cd4J/8NOxxC2KSbDYAAm5Papfcmds37gtHRQiBOdLyZT1GGlsSc6qvtRN0/l4jDimWWXVhnRxEcoVCz7f0X5xxAs1kPF4OoshP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956123; c=relaxed/simple;
	bh=mRHu5GKeGdi/fBRDCPUsJtMi24AJ5fwDCKwrvkiX1kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJlM9fTvSrfvF5+X11fsuJdRve5DaSApa4DdL6mH4XFYASXt6IuC8NbSFk/49OXxUGD0nKaqv0DVfle+0dnQQCe/GQWNmxi5rbmMPtkppXQiLB9dluHs53QuNAGnbBCLF/9DNEeR9w7M53g15nqZ3LwCCgTXjbd+eB/1Ai1HJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSKIp+Fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D4AC4CED1;
	Wed, 19 Feb 2025 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956123;
	bh=mRHu5GKeGdi/fBRDCPUsJtMi24AJ5fwDCKwrvkiX1kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oSKIp+FpJXbsJcx68oDcZRbtB4YhjSS4nr9aoP5Usn3nXhyC6x1MkfGoMxBjW0jzG
	 r5zheFplSjLMjS0aFb2+SBz8Hsg2AvE9WVd+jyr+TvHtfzijyCPJKdPKQR4resuGnt
	 vIXtFisE1iy3PiDYlxHj7q+a3e2hUD/YtJkNki/UJRNvFmE8ml1E7KwbgskWFAqIJR
	 6f/ekYyNhmPo3PRjd/9t5tMJYjt93o/Hoe3uSeTBotXzwkxupCrvQW26R7chZjB+8M
	 5hz7NI5IgZFeY00j2qQULenJEobHUSUIFahGRtmQMRlgkVXmcahLplHSDtTHHVOVgS
	 eK2IMURUn4ZGA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 4/6] rust: addr: Add a module to declare core address types
In-Reply-To: <20250202-rust-page-v1-4-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:46 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<l4KeDw9ZS0w6xnq162W2P2cuQdAj0aygpypVFAszbtGYELayg3qn9jPT3BL0fAKnalViClAoMBFdPC-lrCDNpQ==@protonmail.internalid>
	<20250202-rust-page-v1-4-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 09:51:11 +0100
Message-ID: <87zfiico74.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Asahi Lina" <lina@asahilina.net> writes:

> Encapsulates the core physical/DMA address types, so they can be used by
> Rust abstractions.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/addr.rs | 15 +++++++++++++++
>  rust/kernel/lib.rs  |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/rust/kernel/addr.rs b/rust/kernel/addr.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..06aff10a0332355597060c5518d7fd6e114cf630
> --- /dev/null
> +++ b/rust/kernel/addr.rs
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel core address types.

How about just "Kernel address tyeps"? What does "core" mean here?

> +
> +use bindings;
> +use core::ffi;
> +
> +/// A physical memory address (which may be wider than the CPU pointer size)

Missing period at end of sentence.

> +pub type PhysicalAddr = bindings::phys_addr_t;
> +/// A DMA memory address (which may be narrower than `PhysicalAddr` on some systems)

Same.

> +pub type DmaAddr = bindings::dma_addr_t;
> +/// A physical resource size, typically the same width as `PhysicalAddr`

Same.


Best regards,
Andreas Hindborg



