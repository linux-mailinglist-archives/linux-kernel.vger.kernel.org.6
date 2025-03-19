Return-Path: <linux-kernel+bounces-568750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A880AA69A17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB91171DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA409215173;
	Wed, 19 Mar 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkktvrLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F006D214A9E;
	Wed, 19 Mar 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415404; cv=none; b=HC4RueHXq6tYLVVFBfVOo3J4RWqDlpTxWQkX+TAKpRgtJ3pAiddUrgQgccKuuB5Kjzc5TeZZkd5F7ibt6POGlaT4ywqaDcPTKcyBxSSV9JocTzvVGu9qJCJfTFq3i2/aKZHWzdDXNDsPej+PG6ZHUQg80foDIzlqZHpZLs6HLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415404; c=relaxed/simple;
	bh=MSxPamEBHGPvu7IMAPqcyi0fJsP5xyqutLFnzVFpxY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fb5KwYnaDgqP1Hmqq4EZaidodd3ZUexytY3W9meoeT3yFRkLTnuAz6q1sMf55qtBySyC/jPug8UpJxvxFE2yZW3MDSlOqNdv8kUDVWM5lLSuHDmg60Rr/TlfqkgXnhTOkHxxkm/K8MwIJWul0T7na4AUQBtTOwO1nJpaC0g3BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkktvrLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837BAC4CEE9;
	Wed, 19 Mar 2025 20:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415403;
	bh=MSxPamEBHGPvu7IMAPqcyi0fJsP5xyqutLFnzVFpxY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gkktvrLQWUEklfjqWkk5x547LQ14HK9G5SNK4z9q1i/9cE61AXlv03sAsOE+nVORs
	 zuE2AntdSmIWwq9cRLm1mKb7Evb1wxIfxWTnhwzm4QPDeSBzlGZ0gjHeVkZ5H9jfOc
	 XRQnw0MLMGCJAKHLqUE5s03U4ygD8yMmYQk6rgQwpZtFL8BvQoTUCVpaGcaTDUpwx3
	 m1PGCp6hEYdsja5RBD/TIWzm3iqVNlLBSunk+dUaVBdIF83ToJsUAIrikiyOH+RWu/
	 ea4TiCzJPS3AOJuXBFqsAzIj39kn+53tiHi4yPRCc4rNCi7OgQVabUU8zNz1UBbrzF
	 zatIAEmXvchFw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] rust: miscdevice: Provide additional abstractions
 for iov_iter and kiocb structures
In-Reply-To: <20250311-iov-iter-v1-3-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:14 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<F1M8U62rghdw4RaELLHxMh1meevFz5toqtnX_01OqcA8NYebCaSWdHqSlVPBu8XNTWqI9_bRF10kDbWJnzvDBA==@protonmail.internalid>
	<20250311-iov-iter-v1-3-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 21:16:27 +0100
Message-ID: <8734f8g4is.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These will be used for the read_iter() and write_iter() callbacks, which
> are now the preferred back-ends for when a user operates on a char device
> with read() and write() respectively.
>
> Co-developed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

[...]

> +impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
> +    /// Get the private data in this kiocb.
> +    pub fn private_data(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
> +        // SAFETY: The `kiocb` lets us access the private data.
> +        let private = unsafe { (*(*self.inner.as_ptr()).ki_filp).private_data };
> +        // SAFETY: The kiocb has shared access to the private data.
> +        unsafe { <T as ForeignOwnable>::borrow(private) }
> +    }

Another quick observation: `kiocb` has a `void *private` field that is
used in the same way that `struct file` `private_data` field is used.
The naming of this function is misleading, since it does not return the
`kiocb` private data.

Either rename this function or exchange it for an access method for the
associated file.


Best regards,
Andreas Hindborg



