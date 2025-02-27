Return-Path: <linux-kernel+bounces-535827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A5A477CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AC03A2EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D022541B;
	Thu, 27 Feb 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkCcNxAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22EA59;
	Thu, 27 Feb 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644903; cv=none; b=YVd3kHxRNzc7yMiw5Ie6bK9llLQ+IL8cT2Znz6XiL3skWz6R8H4hXbEAGZ1jDCI4WH2Q5fqpI8oQ4M9YmNTOMo2lnDt+sxVkScyKeYKq3CEUeZMg/1XQxeWcvESIVWO9SVMPLn9v/G6s51sCC8XVp6FHhkhkLrl6IkXryArFTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644903; c=relaxed/simple;
	bh=mL+ScEVoosTCLqReMvWvb0hKdFm7SzXMaD7EnmZ5gQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=beFmba2znEwpsZA5p8TdKpNLuad2VpUIRp0304iC9YM+OZYqWFnmJv6mEk1emnc9EKZgiS/UDQfDZI6BhnCoEm2FWFo3YqRSzEGrwkn0HP7rOFRIeYETb1ptdFiCRA0X4ZZ7YpuwmY8eB1oc79UOvWWqC/rpXLXFo2ymRbiSPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkCcNxAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7C8C4CEDD;
	Thu, 27 Feb 2025 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740644902;
	bh=mL+ScEVoosTCLqReMvWvb0hKdFm7SzXMaD7EnmZ5gQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UkCcNxAHNlb8KdOpVGBTAsjYUG5oG1EXqGPyEiclsxzBC4p+LOLBcG4nlsZ/bWo+k
	 W+AZVnrXuaRNp4mDR5r14XtUQsblr0rPT8GQGXSvmHHye9M6QtKrggxgtlCWPBRshH
	 VXHHQftNfX5UHocw4EVWQUQmUDQz4GzjrsIKq68nK/GgPYUU36Ou13zR4DA+XXyBwE
	 VnpTHUvNXXG1VQHUqqmr5E8R4xbVpPoN8BgaUYrbR3al/9qF/BSs/eqYzBZCgu+gBm
	 aUlhq9JEmKjqnqTOuaNi+lue7T7tGaier67NxH/nVOHEYQbBo2Sn4rUSxSu7KWkMMY
	 sFWAD4mVSBNWA==
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
In-Reply-To: <20250227.155417.1610168537890385926.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Thu, 27 Feb 2025 15:54:17 +0900")
References: <yy_ESUuchCjlaGIJHzCPAcP_d9ucSD0CGXaoZNNkY7BmN5Ch1J8avsA9QpKO5LkTjlGpu99jl8NrFl5NFSQXuw==@protonmail.internalid>
	<20250213135759.190006-1-fujita.tomonori@gmail.com>
	<8734g0v6ke.fsf@kernel.org>
	<aPT3Afc47I_dmAxy1DPVKUobcIJLV0rRUOXJX-ab6IFWqflSxdlOVQdJT0rxYQHjDBeWHDFjWsdXfiCOZ5hPWg==@protonmail.internalid>
	<20250227.155417.1610168537890385926.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 09:28:11 +0100
Message-ID: <87frjzu6zo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Wed, 26 Feb 2025 20:39:45 +0100
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> How does this series compare/overlap with [1] ?
>>
>> [1] https://lore.kernel.org/all/20241126-pr_once_macros-v4-0-410b8ca9643=
e@tuta.io/
>
> No overlap. Each solves a different problem. Both are necessary.
>
> This patchset enables Rust code to call C's BUG/WARN properly.
>
> Currently, Rust's BUG() is a simple wrapper for C's BUG()
> (rust/helpers/bug.c). I added BUG() to rnull's init() and got the
> following:
>
> # insmod /root/rnull_mod.ko
> rnull_mod: Rust null_blk loaded
> ------------[ cut here ]------------
> kernel BUG at rust/helpers/bug.c:7!
> Oops: invalid opcode: 0000 [#1] SMP
> CPU: 0 UID: 0 PID: 31 Comm: insmod Not tainted 6.14.0-rc1+ #103
> RIP: 0010:rust_helper_BUG+0x8/0x10
> (snip)
>
> This is NOT debug information that we expect. The problem is that
> BUG/WARN feature (lib/bug.c) can only be used from assembly.
>
> This patchset includes only warn() but with bug() implementation on
> top of this patchset, I got:
>
> # insmod /root/rnull_mod.ko
> rnull_mod: Rust null_blk loaded
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 31 at /home/fujita/git/linux-rust/drivers/block/rnul=
l.rs:46 _RNvXCsafUg3oOYix8_5rnullNtB2_13NullBlkModu]
> Modules linked in: rnull_mod(+)
> CPU: 0 UID: 0 PID: 31 Comm: insmod Not tainted 6.14.0-rc1+ #104
> RIP: 0010:_RNvXCsafUg3oOYix8_5rnullNtB2_13NullBlkModuleNtCsaYBeKL739Xz_6k=
ernel13InPlaceModule4init+0x71/0x4f0 [rnull_mod]
>
>
> The [1] patchset adds an abstraciton for include/linux/once_lite.h,
> 'call a function once' feature, with pr_*_once() implementation.
>
> pr_*_once() just calls printk() once. Unlike BUG/WARN, no debug
> information (call place, registers, stack trace, etc).
>
>
> The only connection between two patchset is that WARN_ONCE() can be
> built on top of both like the C side.

Awesome, thanks for explaining =F0=9F=91=8D


Best regards,
Andreas Hindborg



