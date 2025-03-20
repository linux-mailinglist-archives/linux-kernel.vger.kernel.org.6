Return-Path: <linux-kernel+bounces-569244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0949A6A07F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C97189E03B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD220C019;
	Thu, 20 Mar 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+P69TQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6611F4CAA;
	Thu, 20 Mar 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456063; cv=none; b=enXF75o6V4N/lBE+34bSp/kmLijKyzaySV8TgIyeMB0hwXarc4liQ6tn8foB/mYwrB2NQLCzDzOzleFOXHOYEq3iMP0dto/KXwUwEHDw1aWXQe17PqzLY3UVIcEWRDUfzGSoXVGGuMc36W4Uh/023WLm4kynewXV+o5yC5CSwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456063; c=relaxed/simple;
	bh=D8dEjTpCok8GhumKlynQf36TwBF26qcEOQJa75sXYwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GR/iPrjHalZ5LjdFTEiMkXQADWDfeY2lgRGRTg/J0oUbm1lX8wmSZErRCjV/zLGIRCx8c2Zr+Qxc5/24va0Pd4PCAsxGZ9q2d8ZuQq2mZtWMo7Khj905tHpWzmxMGHwmTIRgvMXLhWDGTnE8dNAFVi+aF9PZgbafCIp7JKqzScA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+P69TQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940A4C4CEEC;
	Thu, 20 Mar 2025 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742456062;
	bh=D8dEjTpCok8GhumKlynQf36TwBF26qcEOQJa75sXYwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T+P69TQ5Ud7PPISyxUjWGt4LntRsjBZFE8ItGUVLxjXKltHFHJ/ZMSaxbQwzgK1DM
	 YAB2qrK1xTKlk2KDcZv9HDjY5Tz9ejJonjXAZ3vyxG55wYXiCNsF/Ikh9Nt5XrWqIv
	 Qxbzurion/SX1sORPg8z/gRISPqfFBPhE4PixUzIrfjkPPuY5Qoy3i0njXkxchYS4M
	 rWrdBMxumzTShbIv5ftN0rrXpwjc9mn+kKgtTmbUuiwtk6DCuofZxXa5TWINocXfR2
	 5wa++JRKytY40ANju3/ScagMq/jRuQdHjsjVue/WtCKYRzGL30Qyp//J6CL50RnNzX
	 0BzTE4KL8juVA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Antonio Hickey" <contact@antoniohickey.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 17/17] rust: clippy: disallow `addr_of[_mut]!` macros
In-Reply-To: <20250320020740.1631171-18-contact@antoniohickey.com> (Antonio
	Hickey's message of "Wed, 19 Mar 2025 22:07:36 -0400")
References: <20250320020740.1631171-1-contact@antoniohickey.com>
	<orynt7hABIvK7AQ6jcYlCEZEInSFjqSs356m4sceNtXzqRxNh8j2chJW8b-32sAY_x8eyhh4pMbOq67cpu2Efg==@protonmail.internalid>
	<20250320020740.1631171-18-contact@antoniohickey.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 20 Mar 2025 08:33:24 +0100
Message-ID: <87ldt0dum3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonio Hickey" <contact@antoniohickey.com> writes:

> With the `raw_ref_op` feature enabled we no longer want to
> allow use of the `addr_of!` and `addr_of_mut!` macros.
>
> We instead want to use `&raw const` and `&raw mut` to get raw
> pointers to a place.
>
> Note that this lint isn't currently reliable, but we enable
> it nevertheless because:
> 1. Document that one shouldn't use the `addr_of[_mut]!` macros.
> 2. When the lint becomes useful we will already have it enabled.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Link: https://github.com/rust-lang/rust-clippy/issues/11431
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




