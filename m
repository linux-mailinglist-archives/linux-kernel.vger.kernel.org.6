Return-Path: <linux-kernel+bounces-566074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F859A672CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DC7A56EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844720B7FA;
	Tue, 18 Mar 2025 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inQS7grk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020241FCF47;
	Tue, 18 Mar 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297748; cv=none; b=F08phduQZSgMZKcZNf4MmtoO7ybvk5v8RbNMXFNslVI9ZFlJ1s9gvmJKYKuUahkLymbZUL6WLJab7VlCUZaZrQi6PxMNdkSqC5rvTcITo+k45KFLGRu/D6FULnqOBTds18xJIgrBhXHsnQTat08XIbvacK9sFVJ6mEoAqSgKDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297748; c=relaxed/simple;
	bh=iw3jCWCcMdJZhdOGjGwbHxEiAk95dHjTkfWnrR11dQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFb1KMMbLlpVOcrzY+a08uPRsAavAPAIKWv52XnZZzimrYI6+V9El14hTizFCIWki+lfhmgiFWH8VEanr1hOfuXO0EcZeZWZYlwEWl27PaRN5su8cGDItlnfTYOVNWyVnkp5T9ubuni4lbpkM4LOurNDi+HtEWhhDMJoXRBKZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inQS7grk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149EEC4CEDD;
	Tue, 18 Mar 2025 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297747;
	bh=iw3jCWCcMdJZhdOGjGwbHxEiAk95dHjTkfWnrR11dQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=inQS7grkMP3cm+Wccv9dxvZ3YZqBcwQnvGFjLjL0NQBsGQ1/19gLnzEgzDI6bBdct
	 ptv4TMxRKYEcRQLXgdzsRveyVdT/ca86e8ivVMudLkZR8b+vv1p4MMiYRavWzdGVoe
	 WAj4eQT6C9b8CbbXrfMrBtlC+YLDyHk1BzhgFP6q2+xJA2n1ZzuXENv41EDgsCH0BO
	 kOz04LoXiZuV3FxH+7db1u63LLFzNXQtUukrwBYaieouWx/Obrm4Cl/GqCbPD1NFgw
	 9p4R3ixCl0mhaVOquTojSjzloD3668usc0vrY+VnLMu2p4dyFHWjKW2fQQvw/tgftx
	 1w3/gvNJXnjVA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Fiona
 Behrens" <me@kloenk.dev>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 03/22] rust: add extensions to the pin-init crate and
 move relevant documentation there
In-Reply-To: <20250308110339.2997091-4-benno.lossin@proton.me> (Benno Lossin's
	message of "Sat, 08 Mar 2025 11:04:07 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<qQRFZWWsNSk6rGVvN8yVoRMZWVArzhh_fUogbXEQ_bWoNi250Q5AqK4zvESU0QJbUXudXDvfeUCLyCS7hteT3Q==@protonmail.internalid>
	<20250308110339.2997091-4-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:32:29 +0100
Message-ID: <87o6xylgky.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> In preparation of splitting off the pin-init crate from the kernel
> crate, move all kernel-specific documentation from pin-init back into
> the kernel crate.
>
> Also include an example from the user-space version [1] adapted to the
> kernel.
>
> The new `init.rs` file will also be populated by kernel-specific
> extensions to the pin-init crate by the next commits.
>
> Link: https://github.com/Rust-for-Linux/pin-init/blob/c1417c64c71229f0fd444d75e88f33e3c547c829/src/lib.rs#L161 [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



