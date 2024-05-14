Return-Path: <linux-kernel+bounces-179007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7178C5A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B88F1F24248
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82371802A5;
	Tue, 14 May 2024 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1/qr7dii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68117F378;
	Tue, 14 May 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707685; cv=none; b=NZEVaq4UsELjf4YyLf7Ph0kg1vONKmE1zRLfvQX8srgBu7mMJOwc7lMFq83D7p/Pba8LDAIKTTO7RAiXHFpabmoIHjkHirs1uXAQD1wKlzSpGelft0JUuhOccMu3ApUa0jTZD9TgbcEOGLq1/zSBG4PaMhmfrmQaVlU52JBNiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707685; c=relaxed/simple;
	bh=Ex1jECYg9YCi18DK+c5M5YI2kVJQ/OqqOZjhQriYWAA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NI1WQN/+UjKaVBNGP79AUYxh4m6ECo80aBu9TFoTlDaVAGt7i8XPk4qR/DlWkK3pqayg7GrvrOqulG/fYHqZ15TQ69LWKK6I6x5Esws+acuBIgPiOoNQZ9BuwlzVoFGk+olFvylcXSn3eSnmW+wEE/CdTG4D0C6ZZca4WC1eELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1/qr7dii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BCC2BD10;
	Tue, 14 May 2024 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715707684;
	bh=Ex1jECYg9YCi18DK+c5M5YI2kVJQ/OqqOZjhQriYWAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1/qr7diiZFoMOkRRQAHecS9twVK6/XddQVf6LcYQfZ8frrVMFvQPtesA7vPTTbTlS
	 b6lXYLnfiexNKGDEEeSSHJNv82F9Xc9xqceX5XyBR/td70xNUY8HsYwTZHF9+ceK3T
	 eeiBtwEtzFdoNRXSrh9s41596Job3PtivO6KBaXw=
Date: Tue, 14 May 2024 10:27:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?"Bj=F6rn_Roy_Baron"?= <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?ISO-8859-1?Q?"Arve_Hj?=
 =?ISO-8859-1?Q?=F8nnev=E5g"?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor
 Gross <tmgross@umich.edu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-Id: <20240514102757.b7034966a58e6cf44d75dc7d@linux-foundation.org>
In-Reply-To: <20240418-alice-mm-v6-2-cb8f3e5d688f@google.com>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
	<20240418-alice-mm-v6-2-cb8f3e5d688f@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 08:59:18 +0000 Alice Ryhl <aliceryhl@google.com> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Rust code needs to be able to access _copy_from_user and _copy_to_user
> so that it can skip the check_copy_size check in cases where the length
> is known at compile-time, mirroring the logic for when C code will skip
> check_copy_size. To do this, we ensure that exported versions of these
> methods are available when CONFIG_RUST is enabled.
> 
> Alice has verified that this patch passes the CONFIG_TEST_USER_COPY test
> on x86 using the Android cuttlefish emulator.
> 
>  ...
>
> -#ifdef INLINE_COPY_TO_USER
>  static inline __must_check unsigned long
> -_copy_to_user(void __user *to, const void *from, unsigned long n)
> +_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {

I think it would be helpful to have some comments in here describing
why we're doing this _inline_* thing.  What problem is it avoiding?



