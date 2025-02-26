Return-Path: <linux-kernel+bounces-534796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51232A46B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A73B02DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7642512D2;
	Wed, 26 Feb 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXp5HnXI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BE24634F;
	Wed, 26 Feb 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598811; cv=none; b=VwA35YsC2SgfKbPXib6K3f9Ix/KC1MGNG0GjTko1E2/mZWdl65y3S4eJ0NTMCVVjZTIhF94Q0+0t2ZCKvz0IGir6vIzpiHZleJqvspbWlQ4te0LToGkMcvY7DAJH9OtIv1e4rwU+lJUYad+6+l/NSJhreFK7ZqzrRQqJz3PxOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598811; c=relaxed/simple;
	bh=iqsdq2p5uze2ya4zhfPOi6HCsOmbEwMOmKjx129lr6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lGrrgI3hiwqetymkLvnOJxWVXGKnrkY0xrB8o+IaP60mTMIXCCQRo5lCOj0uNkiaL+Dyo1MYHWx4ulYOAcGQrG8XdiuWoleu0VE7vhimWyg6aCaxg3Y/vhvJlnjh4ImxhTawro43QVJAVpwqeCeVmf1zOHP2B5dj35oHGp/4otE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXp5HnXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDDDC4CEE7;
	Wed, 26 Feb 2025 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740598809;
	bh=iqsdq2p5uze2ya4zhfPOi6HCsOmbEwMOmKjx129lr6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LXp5HnXIU93C2GpA3Ioh6xBPLKGb8n8eIb+n3KK6ZSi1RAFO4i4taQT9DLrlTqon+
	 WiV6Z1KTeHYfDqm3YFqRhVwZdM39aV1c8V2vWUwOZmWw/UQ+4hX7LAAJjhIZrjBDAv
	 WvpJjLhC/ghljgU+UxQHaGGXqcRSgSD3PrDhH9Q0XU2yBMPyBoqd1MkxjstC8XAKyi
	 yOvauVBlwqVQn3ww+Kp0pNKv87DrfUVn9T64QJB7VRRE7GhW2Wmo1KN5VWOAkIT5DU
	 7sKHC4gsUm+W3gBQMw5f+tktMBaapO5D9ALsazdXLDfeLGnK+g7WnYCQUAzsLu2FPi
	 CVds/UXAMdeQw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <x86@kernel.org>,  <linux-riscv@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <loongarch@lists.linux.dev>,
  <tglx@linutronix.de>,  <mingo@redhat.com>,  <bp@alien8.de>,
  <dave.hansen@linux.intel.com>,  <peterz@infradead.org>,  <hpa@zytor.com>,
  <paul.walmsley@sifive.com>,  <palmer@dabbelt.com>,
  <aou@eecs.berkeley.edu>,  <catalin.marinas@arm.com>,  <will@kernel.org>,
  <chenhuacai@kernel.org>,  <kernel@xen0n.name>,
  <tangyouling@loongson.cn>,  <hejinyang@loongson.cn>,
  <yangtiezhu@loongson.cn>,  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,
  <boqun.feng@gmail.com>,  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <aliceryhl@google.com>,  <tmgross@umich.edu>
Subject: Re: [PATCH v3 0/5] rust: Add bug/warn abstractions
In-Reply-To: <20250213135759.190006-1-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Thu, 13 Feb 2025 22:57:54 +0900")
References: <yy_ESUuchCjlaGIJHzCPAcP_d9ucSD0CGXaoZNNkY7BmN5Ch1J8avsA9QpKO5LkTjlGpu99jl8NrFl5NFSQXuw==@protonmail.internalid>
	<20250213135759.190006-1-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 20:39:45 +0100
Message-ID: <8734g0v6ke.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Fujita,

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> This patchset adds warn_on and warn_on_once macros with the bug/warn
> abstraction.
>
> Wrapping C's BUG/WARN macros does not work well for x86, RISC-V,
> ARM64, and LoongArch. Rust code needs to directly execute the same
> assembly code used on the C side. To avoid duplicating the assembly
> code, this approach mirrors what the static branch code does: it
> generates the assembly code for Rust using the C preprocessor at
> compile time.
>
> The 1st to 4th patches export the BUG/WARN assembly code for Rust on
> each architecture, with no functional changes on the C side. The
> changes for x86 and RISC-V are straightforward. However, the ARM64 and
> LoongArch assembly code are designed differently; they are used by
> both C inline assembly and assembly code. As a result, sharing this
> code with Rust is complicated.
>
> The last patch adds the bug abstraction with warn_on and warn_on_once
> implementations.
>
> This has been tested on x86, ARM64, and RISC-V (QEMU), with only a
> compile test performed for LoongArch.
>
> The assembly code can be used for both BUG and WARN, but currently
> only supports warn_on and warn_on_once. I will work on the remaining
> functionality after this abstraction is merged.
>

How does this series compare/overlap with [1] ?


Best regards,
Andreas Hindborg



[1] https://lore.kernel.org/all/20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io/


