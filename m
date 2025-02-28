Return-Path: <linux-kernel+bounces-539241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271AA4A258
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45B21892044
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC11F0989;
	Fri, 28 Feb 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZGMk6bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A8277036;
	Fri, 28 Feb 2025 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769326; cv=none; b=UHyUJnhjJwCmOah9+N2iQ2U52uuqoKsmVPdqQB/5+QApntPdfyvd10KFa3mqLlDfnt1W7Kx32YjAm1IN7QcpzTZHPzPQ9yJ7vD+B7FV+AoyD5TKC8bdL79eXI1R16CxdJo6YpjPI3cVfH4v+obw8StVYI0zcin8oE1hHq+azXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769326; c=relaxed/simple;
	bh=PUoCqXPpUCMbY97368Vkt+ANdYQNlfdQvb4mJC4q8RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdnQtOTBEv4DXJ6PcQPVbeWAxcrspLDLuCY7PFqs4wu5Awo0jXoVC/0zsHRv9sIHIflDSFsL7oJwQ2J9rs1Ez1CuPmLgciPPEW+ghVsQA9qr3DANtvJhEQ3Qbq0orkNCLZw9YGDrMnAheuzcYjQzIRWh9DrJ8zXmRG98nwkPwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZGMk6bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBA2C4CED6;
	Fri, 28 Feb 2025 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769326;
	bh=PUoCqXPpUCMbY97368Vkt+ANdYQNlfdQvb4mJC4q8RY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZZGMk6bbfz311eIP6HtAie5stpG839igCX46G2G0EusTFkNudGXPzDrHYOk18eJ7d
	 kfMmmwdEoXYbeHkxGidzzpG5QsmeObF9SQCI1XP1E8YAAb9IG087r+2Vrr9NEqaPuy
	 Ks74yRqleRb5jH1N/7p9Q/nOVQfwE29rwolbDu/mky8sut2/8YF5BsobIf4Juco32v
	 WNdn1m6WzBhddOZvx5WGW08zQIE6l5wDEr6HfUEvwdDF9A0PV6ZQBGyjPhARCSsEGw
	 HCD9N+FKbYDOoILb5H96ADFJjV2Oi5+0bBHLdPbXLqd5iC/a/1ELJS/goYB8REL2pf
	 OUFciNAhE7SXw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
In-Reply-To: <Z8IBiBi6CSRxfxiE@boqun-archlinux> (Boqun Feng's message of "Fri,
	28 Feb 2025 10:33:44 -0800")
References: <I2EuahEO9YG75qdfIlsanLJ9iOfr0OlKJr6nw_cqOG0rVrZUEZGhdfENkLawNCpSqP8uSGMODCeEmsYv6clgYg==@protonmail.internalid>
	<sOipp6LTmtfq5A37VN_kCA4Kw9zfclZ2HLIMSJYnOdG4ebnuTKUlXIlT4X3GVRLMXFmwT4IwyIA-eqF69yOhSQ==@protonmail.internalid>
	<Z8IBiBi6CSRxfxiE@boqun-archlinux>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 20:01:55 +0100
Message-ID: <87senxlwpo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Fri, Feb 28, 2025 at 06:22:58PM +0000, Oliver Mangold wrote:
>> On 250228 1009, Boqun Feng wrote:
>> >

Something strange is going on with this thread. Some replies are not
attached to the patch in my email client. Lore also has some trouble.

What is going on?


Best regards,
Andreas Hindborg



