Return-Path: <linux-kernel+bounces-544126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F521A4DDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2BB7A7444
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587A20299D;
	Tue,  4 Mar 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAMGvD3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3D1FF61B;
	Tue,  4 Mar 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090601; cv=none; b=BwhA24m8f+g5uGRyxe/kW0NDVRg+R8ITxeSqKe0wlU7r8wfZI5uZaNHx29/sCGv++xxCqOYa2kfYwtjm0LAGyVwpt4vzUZJ4+EdZiOB+0xmZw8YFH99+fmQ+SXwXG4vVQkMYa+AcxvsOoyZ/otCTtpXUMyg+mMyXqb5PciAtZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090601; c=relaxed/simple;
	bh=qU3ZsnpE0cqNktwm1uO7rwCYdRZRijz0VgpjSmIlvP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIXxoCM/bjQqPy0nbk4+QU8M9eNFrf2LR11FAzAQbnBvrziBQ6EnhMjIL8XxG5nOfS2HyaAkQ0HXq2FW/rVy07wDAOC1+7WTtxpfBtw97WDRvMv2/DjcXxYtmrenSOPIH38ogfDUgi4cv4+M+AezpUEQr22WzPJqsUFs/Tkyed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAMGvD3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C2BC4CEE5;
	Tue,  4 Mar 2025 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741090599;
	bh=qU3ZsnpE0cqNktwm1uO7rwCYdRZRijz0VgpjSmIlvP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TAMGvD3JDlK4YIShOzsJbEtGhpmsc9I+todXFSN5xMipN7pU0Mj2NBoLSOyzInNBr
	 neFKcTaKpX5q+Pykp2JPGVU9l63u5jC5d1YlFi3t/qBUkyCHRD+R9FyZH2qkjTnOok
	 5jSno0UphXqgXKg4BaZN9oqOquUY3BNC5FmiWfWhp4qkWwnf0R48ECNs3tUqE09urW
	 9E0wEpS1tncvgIPQsKoyygtfGjgGoo//20I8wfy6Hh76eMa1EUFGE/ApCAjcEddviz
	 ytfXZwXNz8lw9j+qrJcPbtyRXdtg3e5JASzcgYH4yfzxB6giA/5zpptj/Tkc0heMED
	 tC6UGsUQjwSLQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>
Cc: <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,  <apw@canonical.com>,
  <arnd@arndb.de>,  <aswinunni01@gmail.com>,  <axboe@kernel.dk>,
  <benno.lossin@proton.me>,  <bhelgaas@google.com>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <dwaipayanray1@gmail.com>,  <ethan.twardy@gmail.com>,
  <fujita.tomonori@gmail.com>,  <gary@garyguo.net>,
  <gregkh@linuxfoundation.org>,  <joe@perches.com>,
  <lukas.bulwahn@gmail.com>,  <ojeda@kernel.org>,  <pbonzini@redhat.com>,
  <tmgross@umich.edu>,  <walmeida@microsoft.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH V6 1/2] rust: module: change author to an array
In-Reply-To: <20250223174205.48404-2-trintaeoitogc@gmail.com> (Guilherme
	Giacomo Simoes's message of "Sun, 23 Feb 2025 14:42:04 -0300")
References: <20250223174205.48404-1-trintaeoitogc@gmail.com>
	<IF24WGLQXlxxpA3KATMen2BraxQvb-w-Qj8K9mFm9PskrK7A6oFrZJVdFJmiIdYYzpj2nI4VYafUxBd-WmeQFw==@protonmail.internalid>
	<20250223174205.48404-2-trintaeoitogc@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 13:09:19 +0100
Message-ID: <87zfi1gfps.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com> writes:

> In the module! macro, the author field is currently of type String.
> Since modules can have multiple authors, this limitation prevents
> specifying more than one.
> Change the author field to Option<Vec<String>> to allow creating modules
> with multiple authors. Additionally, rename the field from author to
> authors to make it explicit that it can refer to multiple authors.  In
> modules that use the author field, update its value to an array of
> strings, and also rename it from author to authors.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/244
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



