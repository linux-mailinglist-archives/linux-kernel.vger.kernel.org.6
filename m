Return-Path: <linux-kernel+bounces-566034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB4A67256
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B447AC7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FB20A5D7;
	Tue, 18 Mar 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d67jbRuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAE1AA782;
	Tue, 18 Mar 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296497; cv=none; b=ZSY4jOidKC9/iyL0f864LIS58naHNn6egT78pdQwuXWHW4qGCtKAnkYQPZCp0vDmpFQkwxBsWWqd10xbXaEzQFr7SagAC4Ehzbqewoxoomo+HLPXeDozHJILJlLupAkQsdTdI8heM+hqfLqUH4nkDTDXUEdGuhCRgXr1PDgLK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296497; c=relaxed/simple;
	bh=+MiiFhVlLVukSIit4S7AngH5+5niKoWoQChrZCrVrJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdXQ6xqjRAbUMbWeqXbfKW8d93ts3xgNnTiLFjwC0xW5vFUxqCGG3tMUvk0uy+hPMAvIWeNJu/Y50qGCetURItkN5slj0+YdGYu8hbLNFzQhJoiIooS64G4hYnwdx9rT08agGky6krrw0kbmLrxBScXNEuz6GXn91i3H2zDwXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d67jbRuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA5C4CEEF;
	Tue, 18 Mar 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742296496;
	bh=+MiiFhVlLVukSIit4S7AngH5+5niKoWoQChrZCrVrJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d67jbRuwYF2kpaS3Ajz3E5MA2uiiVL4TSwSIY7d5g4ZHsxZw9bWjWy9HwFbHWwe8p
	 VK/vBex0ux3WXnsU/T/iEI6ammT9DCmyV5BiO/68et5151kV4dT8v5NBd2K2jURbK5
	 5jYND//2PhftROAmsGkFwb/sgJTsojfZQrkyaIF3b1Zb9pWVZJ1uqjQrZcFdkbsR3f
	 j0kYb61L/QQQkv2w3n7RIRLrbUuszr8ABwh97DKqLf+yk+mUpGnhsyurVbbGI5GZWs
	 bvUkhBDk6NfcA/w46T48IXOdMi7RJAMWhjs8seEYdSCTRe6XH+pyIPP9dzighXp5Kp
	 SeVTXVr3T2+zA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Joel Becker" <jlbec@evilplan.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>,
	"Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <benno.lossin@proton.me>,
	"Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Ingo Molnar" <mingo@redhat.com>,  "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,  "Fiona Behrens" <me@kloenk.dev>,
	"Charalampos Mitrodimas" <charmitro@posteo.net>,
	"Daniel Almeida" <daniel.almeida@collabora.com>,
	<rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] rust: configfs abstractions
In-Reply-To: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org> (Andreas
	Hindborg's message of "Thu, 27 Feb 2025 13:35:09 +0100")
References: <41ZevHqZJoE8_8iyJejt99BGZVDfljWV3ycSSRkSxqBOEz-876GX03-R0Ca2z0SsGNhE4mIIV-6EegJL3ETAVw==@protonmail.internalid>
	<20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:14:36 +0100
Message-ID: <87tt7qlher.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Joel,

"Andreas Hindborg" <a.hindborg@kernel.org> writes:

> Add a safe Rust API that allows Rust modules to interface the `configfs`
> machinery.
>
> Add an example for the samples folder to demonstrate usage of the API.
>
> Add a maintainer entry for the Rust configfs abstractions in the last patch, to
> make it absolutely clear that I will commit to maintain these abstractions, if
> required.
>
> The series is a dependency of `rnull`, the Rust null block driver.
> Please see [1] for initial `configfs` support in `rnull`.
>
> [1] https://github.com/metaspace/linux/tree/9ac53130f5fb05b9b3074fa261b445b8fde547dd/drivers/block/rnull
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Since you are not responding to my emails, I must assume that either you
did not see them, you are too busy to respond, or you are ignoring them.

Please note that if the lack of response is due to you being busy, my
offer to help out with C configfs still stands [1].

If I do not hear anything back from you, I will have to ask for these
patches to be routed through the rust subsystem tree instead of the
configfs tree.


Best regards,
Andreas Hindborg



[1] https://lore.kernel.org/all/87cyf3p6sj.fsf@kernel.org/


