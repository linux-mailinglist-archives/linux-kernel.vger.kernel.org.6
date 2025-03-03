Return-Path: <linux-kernel+bounces-541885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F95A4C2E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0EA1886AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033D2139C6;
	Mon,  3 Mar 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSwX0+eP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC292135B1;
	Mon,  3 Mar 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011011; cv=none; b=DOvpjBpV737ZRqoBt7Rvy/wv8DUOstspRQzNoyd/8KsakOMyJIeVD1O+h/5+B5V4VjPVYp03N8tWLa3kja/9Amwpqo7OxrsorS0JLLwFuDynQHU3GtPIf6e0XHiU6ufsTB4Vo/l4VtNSMIFfEhtkvqx1KAS+pGWF/GXygH+8pIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011011; c=relaxed/simple;
	bh=4Y9h9Junw2qorQN9fokN1ASjhbtEC6V0icdZP7DXRU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TnBxA9FguTvomXfcfwQCF1frPI/QFvI45k0T+9HHmgr168oUxDFk/457cqJapRjzjvH3caO3EkOAjfpBKi9ksHuUsANzwYPKQLQgzICa8Dc6x+6cMZh9E3zctEx97rah1qQJ5Wq0IcmOWGn6lk53uG9NOiEmBj9doAKb385fpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSwX0+eP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD59C4CED6;
	Mon,  3 Mar 2025 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011009;
	bh=4Y9h9Junw2qorQN9fokN1ASjhbtEC6V0icdZP7DXRU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TSwX0+eP8YJl/OTJ6QsFkoj29zeXZf0wTJ37LlGamFmF0G5qoK2VMOPais4cYGbAa
	 bHKhHb5K+cI5pC2bQbYFZErKe6ev/RFyAqivqB3HZ9oGACyWcuDSiuKx8kyd0K6UHx
	 5kt5SqgvbMj74XWnDtRYPf1MMZEewaCTI3at7gvbHv2BnUKvKZt58wbeLgQt+H1IfF
	 609jXDfA3aC+eSwQc1SBAxS2LNNiaOR0ncLOwo7TZV0jYLh0wqUebgLHxJx6oaqwg/
	 bV8UmA1wTBOZiY5DydDqSVOUMms6Y3O9WP3bQ+JSktwUUdwRJUxhCM9YNg7SBSoyIs
	 41eXT969uouMw==
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
Date: Mon, 03 Mar 2025 15:09:59 +0100
Message-ID: <87zfi2jjd4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

[...]

> +/// Types that are [`AlwaysRefCounted`] and can be safely converted to an [`UniqueRef`]
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the methods of the trait
> +/// change the reference count of the underlying object such that:
> +/// - the uniqueness invariant is upheld, i.e. it is not possible
> +///   to obtain another reference by any means (other than through the [`UniqueRef`])
> +///   until the [`UniqueRef`] is dropped or converted to an [`ARef`].
> +/// - [`UniqueRefCounted::dec_ref`] correctly frees the underlying object.
> +/// - [`UniqueRefCounted::unique_to_shared`] set the reference count to the value
> +/// - that the returned [`ARef`] expects for an object with a single reference
> +///   in existence.
> +pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
> +    /// Checks if the [`ARef`] is unique and convert it
> +    /// to an [`UniqueRef`] it that is that case.
> +    /// Otherwise it returns again an [`ARef`] to the same
> +    /// underlying object.
> +    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>, ARef<Self>>;

This could just be `try_into_unique`, since the type of `this` gives the
rest of the context.

> +    /// Converts the [`UniqueRef`] into an [`ARef`].
> +    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self>;

Similarly, this could be `into_shared`.


Best regards,
Andreas Hindborg



