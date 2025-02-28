Return-Path: <linux-kernel+bounces-539148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DAA4A18C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75AC31893E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898A27604B;
	Fri, 28 Feb 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNVASr6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B01F4C85;
	Fri, 28 Feb 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767353; cv=none; b=BHnr5aQ9h7YncIW4YfL0ocjXUTK0MXt9x/+Ch6CH8f7Ee2ueronA2fa/ZAP/CefdiJDoXvaMXHDamFPFtsbNXRmbQTfiAVZDjIK46IZXIunZyWQLb2Tc+Xu7xRPCxZfk++05XyuMWNfHeDFG56qeLXJ6o/WEVqdlLzcFhLFwtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767353; c=relaxed/simple;
	bh=+vOIjyiiLtVaLNR4TkknfidJzzH1lydetnHTsM3M5Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNf7Cd5UsHS4VxAoEIVOSksSi9i2grFb5iN14+qb6kdxy5ZAyttsMIbOYMcatrs1Rq3EyB4pfzsDP+NRRPwgTzBlSgyjXCBuilp2Rh3ZgfP62gSsev5bCJo4tPxwSCUUjjknyOEAIxuJtrknrpQxCoqQ0pr1UNnq6VBm0Z13gtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNVASr6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F09C4CEE2;
	Fri, 28 Feb 2025 18:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767352;
	bh=+vOIjyiiLtVaLNR4TkknfidJzzH1lydetnHTsM3M5Ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PNVASr6Q63EkrDf9s+27lNtNmVKtsJzWvv86NgdeCb6HzXpZIGH7FV6FTggPTRUk1
	 qxevy5676b7NPXxA/pegE7MzsXwamHMpPFS9PkEcCmi78shuQ9Mf3uNCTlswXg0UYQ
	 O4DU3vNNeM/8zZm87tbreJhZg0eqBeR7arejRYkfPz9deRbR/LOGVCh1dS0vKxTBJm
	 /kLmNSXaS+BEIk1uwYzpa82PVitMKJEel8GtTYUMNnCP+KsOlKx7pfgolDXsQRpgx8
	 Jz/OljzlrOMvqX1KE0sIkrSiMSHQAIXpW90M8PpLr2+DmbG3yuRIA0OUKED0RpzzZK
	 Ak+eCma6zMW6Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <Z8H6EUy1HqLrzytE@laptop> (Oliver Mangold's message of "Fri, 28
	Feb 2025 18:01:55 +0000")
References: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
	<MFrukGViddXfhKeURDySTWCDW6Pk8Oo5keozdVg9hehiS3P4FVHKv4d-Fwn87yprBUeyTHcY6T1k9htIhPzc9Q==@protonmail.internalid>
	<Z8H6EUy1HqLrzytE@laptop>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 19:29:02 +0100
Message-ID: <87frjxncsx.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> For usage with block-mq, a variant of ARef
> which is guaranteed to be unique would be useful.
> As chances are it is useful in general, This implements it
> as kernel::types::UniqueRef.
> The difference between ARef and UniqueRef
> is basically the same as between Arc and UniqueArc.

I would suggest splitting out the use case from the commit message:

  rust: add `UniqueRef` for `ARef` references

  Add `UniqeRef` as a variabt of `ARef` that is guaranteed to be unique.
  This is useful when mutable access to the underlying type is required
  and we can guarantee uniqueness, and when APIs that would normally take
  an `ARef` require uniqueness.

  ---

  Upcomming changes to the rust block device driver API depend on this
  patch. Please see [1] for a use casel.

  [1] https://github.com/metaspace/linux/blob/41034cb4ea7cd20b981ce320136b6526a9fa9db6/rust/kernel/block/mq/request.rs#L406


The comments after the --- will not got in the commit log, they are a
message for the review process only.


Best regards,
Andreas Hindborg



