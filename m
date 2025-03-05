Return-Path: <linux-kernel+bounces-546543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB9A4FBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A323AB7B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54096207A18;
	Wed,  5 Mar 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4lTgPYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2F207A04;
	Wed,  5 Mar 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170587; cv=none; b=lrr1SrMqH3/WTN9UUVa8nC3mudbULBaHqsk8nrlJRfguzWbyjDJAEXvtIQKn+eSX1fjzmBKLl6QrOp8REV2EarKtor3j60Nm27a9oNy1k5Aa3c9jfMVwYQcaOi7KWfNtHXJDBxjHQ1Xp/bXdpim+f+qWvm5i56iyJCrxxZkLwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170587; c=relaxed/simple;
	bh=lVBqX05U/5AQvPg1bUgY5hUs8CHxJLa2ygjR4iaYruw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d83wia4y5XCfzMORcOYX00ue5CGig6Y1CiGkQN698YmWNkgk6KmcETw9jHPqWDMM2djJCG2fGMq9JUPkfsGwnYr2kuOl4wkTHoqlClUEKyay5sf49J4ZD/UF9dkxxm/EIDBNq93VaJxQgoLDmXTkNph8Ty2SKScosWUzg5by5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4lTgPYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CB4C4CEE8;
	Wed,  5 Mar 2025 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741170587;
	bh=lVBqX05U/5AQvPg1bUgY5hUs8CHxJLa2ygjR4iaYruw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C4lTgPYtgLFl6LV9UkNA2JiLGu9nS1/T6wx2EPTPiS1bjf+6jnUuyp7heiCq4lZcY
	 UpPRtYBt/B1FCRjLpTJ6y5C/TY12yeZskRrXi7dy8DJWzJJunDovumYGSk3yGW6eIM
	 Q4AOnvqItRJIemkWyFEfE7iMlfYHk+Ytv1rk7cLqpXWnJHWEYpGk9WziowAI2Woyw5
	 GcDgs3PUQHIsOKdD2vS31t6cfc4n4xUzsCni776DiWTqw1GtrLVtmT3107D0+inpfg
	 vmNGPY1Whmce/CZTPPOPObFoH6C/DPy++VwYXCmo+JzoatpiAk1FYyK1TQfk9Al5HW
	 XTGcPaKNkLxNw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/22] rust: pin-init: call `try_[pin_]init!` from
 `[pin_]init!` instead of `__init_internal!`
In-Reply-To: <20250304225245.2033120-7-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:57 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<BAnKgFsWDfh7mYY2xEZ5-fdyAyW7MBI-qePp8A2MVHR-JrW11fbzy05HaapbTZdrgWrNISBXP9Ke8zTKruacUw==@protonmail.internalid>
	<20250304225245.2033120-7-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 11:12:26 +0100
Message-ID: <87wmd3eqgl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> The `[pin_]init!` macros have the same behavior as the `try_[pin_]init!`
> macros, except that they set the error type to `Infallible`.
> Instead of calling the primitive `__init_internal!` with the correct
> parameters, the same can thus be achieved by calling `try_[pin_]init!`.
> Since this makes it more clear what their behavior is, simplify the
> implementations of `[pin_]init!`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




