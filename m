Return-Path: <linux-kernel+bounces-572985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108AA6D11D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 21:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40DA189575C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777B19C569;
	Sun, 23 Mar 2025 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOw9fyb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F14C8F;
	Sun, 23 Mar 2025 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742762836; cv=none; b=DOLlzaiw0xZ7hIYbXF5JjkdPKXl/1tnRnmehPO0moX2gAZsPjI/uj6iXvRFX1lcjEkHbjv+L5kp0eO3nB3Kk3jV0zEDxcU0eqmIUjpGR5w73UL7FkOGjtuLKTuSN+KLpiPZWQWlY26QEKYlyUUe2O3m/Mg3Xv1eJU1wLWo+Abe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742762836; c=relaxed/simple;
	bh=roK0RQYsyVbN97cREq5L8qoivVijAhsR5NYcKzYdlHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxW0Mu44XE3QtqN3G8Uxa7TYILBnMHguhFTxGrFa8mFiYmvoYgCGRT4UgBnspfitHVuCKA+aV17LvDfCPkOTqxAKFzPiMb7UHUCw7FZXkxf45U8KYF8RDAyGt/HuNZ5eNwzobqVjvZnmFhcHMFaLz6D/GBZ6n5jV8SOwm37iJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOw9fyb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E664BC4CEE2;
	Sun, 23 Mar 2025 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742762835;
	bh=roK0RQYsyVbN97cREq5L8qoivVijAhsR5NYcKzYdlHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fOw9fyb2UKg1gsRQ5BkUyNHB/SVAe6RlIFBKKYj1mLzBGaPU/YvOBkGp2r7qCuaAl
	 f5mzQXBUPdRruOYMMBpvFF7OAnXo7COg64JCotfEJ2k2NKFtm6Osd9r5weZlrjjffL
	 iGJ9AWK1IxpJaC0jOaIsTWFLL8RJSaQAyeoC4DSqHobw6v6ZuYUE+vYsF24U1HLkXP
	 LWMUFUa9HgkGZWmQ+kaearJfk/NZgsjHFScXT/nx1g0/z7ZrB/Vy8DHIwVhFcNbFEE
	 3ZvO+QC61QF8r/HgxF3tOigDs9iUNxZ83YU8VxEWFS5Kw3efq0INwohSkgxQp2XBaz
	 GLydJAXNsv7aA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Asahi Lina" <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <20250313-unique-ref-v8-1-3082ffc67a31@pm.me> (Oliver Mangold's
	message of "Thu, 13 Mar 2025 07:00:04 +0000")
References: <20250313-unique-ref-v8-0-3082ffc67a31@pm.me>
	<mBH9ahiN0rvkW_87wciSG676vkmnXR0TXkkuPK1xJ8oIpDTC0rJ03Ep83yQ-M_m6-hvbsWvgL8uoAEW16RBiVw==@protonmail.internalid>
	<20250313-unique-ref-v8-1-3082ffc67a31@pm.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 23 Mar 2025 21:46:40 +0100
Message-ID: <87msdb79vz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> From: Asahi Lina <lina@asahilina.net>
>
> By analogy to AlwaysRefCounted and ARef, an Ownable type is a (typically
> C FFI) type that *may* be owned by Rust, but need not be. Unlike
> AlwaysRefCounted, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>
> Conceptually, this is similar to a KBox<T>, except that it delegates
> resource management to the T instead of using a generic allocator.
>
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ om: make from_raw() and into_raw() public, small fixes to documentation ]
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

Please see review comments for the original posting of the patch from
Alice [1] and me [2].


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/all/CAH5fLggscATtCgQwCYSms77oSFOMkjTscRDqAOZsSgoHsOoPQw@mail.gmail.com
[2] https://lore.kernel.org/all/87h64qe3dt.fsf@kernel.org


