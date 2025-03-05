Return-Path: <linux-kernel+bounces-546723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7129A4FE07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A75116D5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C41241C8B;
	Wed,  5 Mar 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU2wo6CN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19824113C;
	Wed,  5 Mar 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175585; cv=none; b=dFWNSEu28yx6BLrppXHCs9Aw3RsZYQKEuDuP+n3HQvwMmuDzTdjEBuYM4pqOpu7X/VrCGoWGlmPSUFzsJE3K/D+z4K7S3SNmJC4QePZJbJIAvOrWj7nfqgbRC1vDgPulDaQTryKZnHv1YjO7dOpFJt8NDyB0krTlZUQEW4wVfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175585; c=relaxed/simple;
	bh=2GoCmIcV993cxIjEsl1N3trg01ol0+mfVmDuWOICbp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ipa/mKpWzzjPPbWKJmpcI+tO8zW2PpAoxyXU7SGW3qJ8ol/12u1LiiX6OKHQOn+LdUeCYyof7lYl/P5XoATfndiypzKI8vFsO60dyo3smMMlzVMBI1FvEzlWRYSb3iry4QCFO9/Z7D/k5qLglQ967/bgE3X68HvqqQegKPPEnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU2wo6CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3730C4CEE2;
	Wed,  5 Mar 2025 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175584;
	bh=2GoCmIcV993cxIjEsl1N3trg01ol0+mfVmDuWOICbp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SU2wo6CNBiPkasjedW91gzGU8lmZESjAJRhpjn6P+QYvXkbqWjBgk2WQKRInKp5K9
	 91D9XEK4wbKwIZqW/ipoxB6E0IrEyuFq3ro8yJ5ZVkJ2Vx+b5GpWqQsyTz5EzF0txL
	 MImBh7P2uOV+f4V8ija4OlsYC1fhtUGbKOIkJDIgYX8jvDNypLx0EG1ukYbRmnHFLY
	 90ObgdjHhrRX9fZE5vR1c9wX2cJGb72b+MORVdhLgPoEJ9yfJaJ3py/T39Dg3Z+yr9
	 vAyh79UG3dRVkQKgDAfy70XdCCfZhhdpR1y7IvliCV9yJxgLzrhmHCAOY8RdywJ19R
	 81tabYygrsBYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/22] rust: pin-init: change the way the `paste!` macro
 is called
In-Reply-To: <20250304225245.2033120-14-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:00 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<gnfOo6-8PDd-rRWT6TyvxLWydmpuSbxaEsw5Dyg6BjjEuJXL1mG9q9vKqAshVJo72Kc7xHDV8A1eKGP17ZUXAw==@protonmail.internalid>
	<20250304225245.2033120-14-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 12:52:55 +0100
Message-ID: <87msdzd78o.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Change the paste macro path from `::kernel::macros::paste!` to use
> `$crate::init::macros::paste!` instead, which links to
> `::macros::paste!`. This is because the pin-init crate will be a
> dependency of the kernel, so it itself cannot have the kernel as a
> dependency.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



