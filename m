Return-Path: <linux-kernel+bounces-390196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE49B76C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF01E1F21E80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D12194A6F;
	Thu, 31 Oct 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhN8NuN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC08F5C;
	Thu, 31 Oct 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364658; cv=none; b=Lf0C6nPny57Rp7y3C/pMMD5fGsBEr8g91/U9eQzdahnckgxzquntFVseUeddxK6o4PVZ3PSjddaI4lTZNZ4sIGghDYO5OhbhU9x4zfZRR4YOUGUBUFFnJFTslcwVwYV0yXvcCt2MmXCFlwah5v468xSnCwJ4ppWgg/YCfIhVzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364658; c=relaxed/simple;
	bh=5nxsWTrLROjlD6GbFhe70Ry68Ml5itSMkuGKF63D778=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D12TG+1Re3K+iLl6H/RDpds56B3sSmW5jbCcUMzOjBe2I+mjZjUI7vtunwjVr/WMJbkTDFplTXRFA5csUHmreORgzjAyw/mjs7HnTaeBhk9kFQZHEliQqP9wK6r0dF77GmNs16bM6SzEasYG2KETLKld84nLaCSF1myJ8NDS/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhN8NuN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F3C4CEC3;
	Thu, 31 Oct 2024 08:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730364657;
	bh=5nxsWTrLROjlD6GbFhe70Ry68Ml5itSMkuGKF63D778=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FhN8NuN5eZnvWxnJp3LChAmf/7n923ddxGyXM5v0FFwAWlPO4hFWc7dT6WCEz4a2P
	 YP2bcuTEuzDIcZZ03UhiknY9NzWR9CzZzzF+fbFo8jdGSSNqKR5EmUCxt6qzFHx4A4
	 fkOdCL/m5cLK6r/XDf8czMRyUDvKE15mygnSh3n6oxOJMhjXxEXd5AGe7LdoPoTk4c
	 tAENdZV6qXuCMkvCxUXMgtGDvrPvcHFd/SRzPqZFrl6/DKPMgh9vpry0YMCfKNb1D9
	 JFJa2XjpomSlZSwDATXOjfCBIT51EJu8F+fAvNizxkBXEU62LvkeZWVx1OwoSYx1Cl
	 7GbGT2Rs/AYxQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Martin Rodriguez Reboredo"
 <yakoyoku@gmail.com>
Subject: Re: [PATCH 5/5] rust: add improved version of
 `ForeignOwnable::borrow_mut`
In-Reply-To: <20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com> (Tamir
	Duberstein's message of "Wed, 30 Oct 2024 16:46:42 -0400")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<dRdemlQoKKeflc1Ti5B10auAxUEmuuQYkbPZdUjE3AR-Snp03qz4q-JqVcp91_LW9Q-PY0PJut6RMzDMEP3-aA==@protonmail.internalid>
	<20241030-borrow-mut-v1-5-8f0ceaf78eaf@gmail.com>
Date: Thu, 31 Oct 2024 09:50:27 +0100
Message-ID: <87ttcsodv0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> From: Alice Ryhl <aliceryhl@google.com>
>
> Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> that was intended to provide mutable access to the inner value. However,
> the method accidentally made it possible to change the address of the
> object being modified, which usually isn't what we want. (And when we
> want that, it can be done by calling `from_foreign` and `into_foreign`,
> like how the old `borrow_mut` was implemented.)
>
> In this patch, we introduce an alternate definition of `borrow_mut` that
> solves the previous problem. Conceptually, given a pointer type `P` that
> implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> kind of access as an `&mut P` would, except that it does not let you
> change the pointer `P` itself.
>
> This is analogous to how the existing `borrow` method provides the same
> kind of access to the inner value as an `&P`.
>
> Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> immutable access to the inner `T`. This is because mutable references
> assume exclusive access, but there might be other handles to the same
> reference counted value, so the access isn't exclusive. The `Arc` type
> implements this by making `borrow_mut` return the same type as `borrow`.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg



