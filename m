Return-Path: <linux-kernel+bounces-546877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E9A5002F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D6A3B8454
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4045524C06A;
	Wed,  5 Mar 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQNVeAt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99824BD1F;
	Wed,  5 Mar 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180135; cv=none; b=EHvL6V8g4WVnSJuF51cY95gc8R4WJkCw+KaOxFtqa+BNKEmJAIRfjlqFscps2ZMPEJrYYpqHaCmExIht5rE3fRtlfj74Qho6tjgM0cVllSXTLFobm8b5HYGwGtfVpP/Iy+hTOq7RvkwBDQRA+cojvGvGcyOpyE0sKuh1MGe2ZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180135; c=relaxed/simple;
	bh=at30O315cdO09r/vOafjktaYb2pfLFugnsPGQ5wHx7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMhNOU+uwQT18sZPczvJx0neMPHNjmfKjJQlBHqQ9tT/Ph5HO1u+egxx2iH3P8llOO297fHfgHcUeP1bsWIGkRbdaIqFR9QyVFckEDoTjLpB5v1jJhEwm1rGsNR/MHcXHmYc/Lrni26ZAoRWawaW4pCUfvBWNH2saZeg38fJ0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQNVeAt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C063C4CEE2;
	Wed,  5 Mar 2025 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180135;
	bh=at30O315cdO09r/vOafjktaYb2pfLFugnsPGQ5wHx7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sQNVeAt502PIunI2CheeR7AHCzwBEQ7ykhF/WSgONquI5r88kdwuyITdN1lSuWis4
	 VqiFcBNE/QHX9vu4DA1iASr8B0bc9H12Qm3BfvNEePN7pgDJ1kk+rtT3mJzdtGDusm
	 0xbp+VDxAJHIFyxZjJbMW5hgtzjZnBchSl0s4Siw6Jb75QZ8KYpzXBzByG3ByGomuq
	 MnBe9CDUuIgQSi6okz/2W/msQsVLz7aU8k/wU2GP3z1fHxzY4bRzU0xDVJwX0fiwk5
	 elxLeDyu9c/VpXp8I+m4jT+ocyScTHKF95rdbitYpbUZ9ZDCqrYBFKyKYX2p0jAtrW
	 8Wt1gRCKtQPeA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/22] rust: pin-init: internal: synchronize with
 user-space version
In-Reply-To: <20250304225245.2033120-19-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:52 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<uUbbzSNxLrRyzAIbcB3Y7P_entcp9It6A7K8Y0NfOHhYfavJxDxXRpyHY9qDWTpXYfuav9CXJaQoWl8SfsYZuQ==@protonmail.internalid>
	<20250304225245.2033120-19-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:56:20 +0100
Message-ID: <87a59zbpqj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> This commit synchronizes with the user-space version that uses the
> quote crate [1] instead of a custom `quote!` macro.
> The imports in the different version are achieved using `cfg` on the
> kernel config value. This is always set in the kernel and never set in
> the user-space version.
>
> Since the quote crate requires the proc_macro2 crate, imports also need
> to be adjusted and `.into()` calls have to be inserted.
>
> Link: https://crates.io/crates/quote [1]
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




