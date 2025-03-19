Return-Path: <linux-kernel+bounces-568593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED7A69819
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB957A8B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09420AF7D;
	Wed, 19 Mar 2025 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t30rZG1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287361DE3A9;
	Wed, 19 Mar 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409222; cv=none; b=HCNdS+7wtKPMax8P/NYWNQfLUq6c3ZDBF0KGQ6L4OxPFZIFcDH7fVjIkhExdZh95piMBPHVY5ozWJMGmYionR7t82/okQ6N44F1vAwQI9WXzgX474bDn5GgdhvgM2jB7OcEy9BPq3rXo5nYA8rtFGH9YTiR4jZT0W5V0J5CTlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409222; c=relaxed/simple;
	bh=fUjnk7qSpvBXsOqYPTue9kasd+ABaq4l0Ad7TBcDqGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPaCrwge5RIZN5aChQEHCmfaFL0jC+fKLUNMln3NyJ27y/s9uf1ttAJICtD6k/kVJch03cVbOJzX55fZHpmTt24FF5cVUp3150U/mRD/ZkxdX92ZQZklcbPy+1SPfrjIPowAvijrs5ZPr/bRRy+lHo0ZFyzhSICC4tPDGs7sqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t30rZG1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19647C4CEE4;
	Wed, 19 Mar 2025 18:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742409221;
	bh=fUjnk7qSpvBXsOqYPTue9kasd+ABaq4l0Ad7TBcDqGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t30rZG1l0fo2QfQszDNXXI6BfAL6z3il1ZWfZjjWQgLEE4fEiNHT3BRtqv41mPiee
	 QbKjhOOJBirLqJ7TngBh4/Hc2JBgQ2d9O0FL5EqWNI2AMP/61x69hkpmMgFTq5PbeQ
	 ANbR42vozOrduqeGD4yTa3/cucfXT9Tko8szANyv6a2s84o5sE4cH8OTDAIL/Z8gAh
	 qlFyajS3jYLt+dSzVtJLApnNpkR99PyyEJyHP9yRYIKkSzMiINTsNx+MAmzctAN4zm
	 QRzaEtJpaVLw0ZBY8vDANEpvc+9IuHSkGCv72l4pSY5zvVs18nezPdyN1p6bfaH/Z4
	 Bu0cCnATVYzgg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
In-Reply-To: <20250311-iov-iter-v1-1-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:12 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<v6RopSmSHmV8uiLBqkIh2II4bCry2OIo_7opQKqq2H4DftxIuRvY2YaLdhLUKw-Ndyv8MpHCgBbBEQntdLU9DQ==@protonmail.internalid>
	<20250311-iov-iter-v1-1-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 19:33:24 +0100
Message-ID: <877c4khnuz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Alice,

"Alice Ryhl" <aliceryhl@google.com> writes:

> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_SOURCE. This will make Rust implementations of
> fops->write_iter possible.
>
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
>
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables, and that you can make a copy of it to
> get two IO vectors into the same buffers.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

This does not build for me:


    error[E0405]: cannot find trait `Allocator` in this scope
      --> /home/aeh/src/linux-rust/linux/rust/kernel/iov.rs:133:34
        |
    133 |     pub fn copy_from_iter_vec<A: Allocator>(
        |                                  ^^^^^^^^^ not found in this scope
        |
    help: consider importing one of these items
        |
    10  + use core::alloc::Allocator;
        |
    10  + use crate::alloc::Allocator;
        |

    error[E0412]: cannot find type `Flags` in this scope
      --> /home/aeh/src/linux-rust/linux/rust/kernel/iov.rs:136:16
        |
    136 |         flags: Flags,
        |                ^^^^^ not found in this scope
        |
    help: consider importing this struct
        |
    10  + use crate::alloc::Flags;
        |

      RUSTC L rust/kernel.o
    error: aborting due to 2 previous errors


Best regards,
Andreas Hindborg



