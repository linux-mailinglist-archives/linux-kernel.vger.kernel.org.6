Return-Path: <linux-kernel+bounces-537990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4EA4934E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D4318907D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBA2459FF;
	Fri, 28 Feb 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVphZviI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A1242904;
	Fri, 28 Feb 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730830; cv=none; b=bQdvvksLugzYSDzvAQ33upuIB4jxQGdfLZc4TsMMywJfaYmthvUYc6eWxmIwpIfkExm/QQqSUL8RV58R6klsEpybmP7c0M+plqI8PXHoKyBQVZTzhaih52RBO5ziSxPt5s/tB12FTAWROnzUAYrGk1YRaq9x08ktets6YOJhUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730830; c=relaxed/simple;
	bh=8yTO/llICtnbsknrcvGs4/GhXN3R2fhImtsrIebDg+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeE+FUBcWFXOilxFAQDhSupccVJjPwYJ031SNM56gwKyYyi6UqwDlI8+KR0XzlIDvjY9FXm5tqyGxVvqnps7Po9HFlFcJ28uhtz4ZwsZAuhnwJ/yNyjz+ix0nQFhbSKaxNGEm1gn3blD8U8iTOduamWDKvFFdCUqZUeeqmX9CLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVphZviI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB0C4CED6;
	Fri, 28 Feb 2025 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730830;
	bh=8yTO/llICtnbsknrcvGs4/GhXN3R2fhImtsrIebDg+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JVphZviI2BP21J+rsLbShFP+I+sXr+H4DNDYOwwFPt7phwM3tNOPrSOAMNwnvIOgN
	 +jaW6MGSpZZLvuj4Ddk4M96WMF24TmYHMHLZpAjKHDf3DiQw5eMcPxQ7MWnG+lPQbk
	 dWGgjVEjN4xvakGoYyGY/nG8ZIX6HIHVgg1Hojzsi4IT5xt+x0vDYkLjgoxAQrpUUH
	 tUlcbEgLiJT++KN50RvHszDn7yaIBigkx+1/Pz3E1HApbUqMKdzzINYpP/YetbiG0m
	 iVNGxufsOUf6aPNJw/v3W/nr76Sh7+qmYo/IIGggTH5dqvTgc/ey+mSd901kx0xkfz
	 /SSF3jb9/PdQQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Petr Mladek" <pmladek@suse.com>,  "Steven Rostedt"
 <rostedt@goodmis.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] print: use new #[export] macro for rust_fmt_argument
In-Reply-To: <20250227-export-macro-v1-3-948775fc37aa@google.com> (Alice
	Ryhl's message of "Thu, 27 Feb 2025 17:02:01 +0000")
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
	<HPpa1v7Unxin25S5VB3PgIDTgvQzpNQV4MyFqkGDP7w5sHWVmjRpH3OgnbagOSqHHCY9mnBIc3mlkAvEmEP5Kg==@protonmail.internalid>
	<20250227-export-macro-v1-3-948775fc37aa@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 09:15:09 +0100
Message-ID: <87plj2o582.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This moves the rust_fmt_argument function over to use the new #[export]
> macro, which will verify at compile-time that the function signature
> matches what is in the header file.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



