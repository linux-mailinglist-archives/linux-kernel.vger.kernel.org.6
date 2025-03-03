Return-Path: <linux-kernel+bounces-544687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E344DA4E406
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE11422823
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711C27F4D8;
	Tue,  4 Mar 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSwX0+eP"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D727C87C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101957; cv=pass; b=NoXRKGC3j0Rgvtm9//njy3rYM7XgY1QHQIavkuKT85XeiUpQG7D43c0W6TyxfZ3wXk9MobOMwFLYXUfb4pIa9wOAxkOPgtjJzNPBEnF0EFeADExzqiSNqanPgqRFVn4xN7iWlzDxOBtCeqEJ8EMDn3niWWYUwQGF6NOegc0Mrek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101957; c=relaxed/simple;
	bh=4Y9h9Junw2qorQN9fokN1ASjhbtEC6V0icdZP7DXRU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJ6sPcIAUWbTjTOy7tCENfVO9SDU7S58PyBKaPIFsKhW2BcrBDyu7JP9IEGFTAZEYdm3ab0goV2YbVsi5DX8qWDXzrEpGedT9EzJ2jzNBtBoVGiPLIDczX3Oe/sDT3qMOKUcHnB4s+GXGxUKGCELjd0s8jaoAyVd76LfO34r+Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSwX0+eP; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 8387440CEC84
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:25:54 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TSwX0+eP
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fc746DRzG0Dc
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:24:23 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 715E04273C; Tue,  4 Mar 2025 18:24:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSwX0+eP
X-Envelope-From: <linux-kernel+bounces-541885-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSwX0+eP
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 6E49C41D89
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:10:33 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 45E872DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:10:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB36188869A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A622213E70;
	Mon,  3 Mar 2025 14:10:14 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fc746DRzG0Dc
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741706672.74467@qHKPUnhJBzZSKLV4Tu9Jdg
X-ITU-MailScanner-SpamCheck: not spam

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




