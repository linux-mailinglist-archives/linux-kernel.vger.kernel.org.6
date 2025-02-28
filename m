Return-Path: <linux-kernel+bounces-539234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07EA4A24A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126BE3B6FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612C1F872F;
	Fri, 28 Feb 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh564Eqx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F241C548C;
	Fri, 28 Feb 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769127; cv=none; b=a9y88Zk2bJuZF5v6XPpbsFCdRcZ+l2y961kPQRffcblKRn1l1YAdncpuTGlNNXpWsgS60GgoBnNJyT/B230i6lbRLSoj/5Alzmw91ckvKdwqcX/OETaJNisdqie5DzPxToehp8WTQ3EaNqUuwVzwq5FczUr0KEyf4bMF1QKCtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769127; c=relaxed/simple;
	bh=CIA17vKj86QZVvcuBdGngR2g3nwrDmSjGoJQOl2IIs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGhZWCEhTGEwvfkd77sMIZymsJbwvG+F5aSQ2iYllsR44GTN/AdnW279FXuJh0BwzwqZUXLx5lGCzBDVWx1bArP74KVHNEoBsj25Izh2DtG6FaVpK8ZVKJ0bNDwxRw/MSuXbmwY5DGiRKeNpqZGFiDfSEtKU28fwCIzu12cFftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh564Eqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82186C4CED6;
	Fri, 28 Feb 2025 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769127;
	bh=CIA17vKj86QZVvcuBdGngR2g3nwrDmSjGoJQOl2IIs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Fh564EqxRGkM4ET1BYBiFfp6RT69LGTwBPr/GQ/PAMqX3Y0D2RN+/ad6M4RZL1gGi
	 5/DSOCyVblBbt7bHCOG0S5g6FYcuHeDOvCdkWdKnx1ZnXvE2vMAaSL9zReGjcS5u8F
	 s4zl61WKhzRfdn0Y+v5pRIZaP4SbfRL0/NaA/noarNaUCP4GN6uRjB9ZND9LEaRzhQ
	 /BmP1DcWGYEua/HEb3alrccBqVw+oW4yyr/xDF8BuLXdJ2moQy8aHED3KzfzE7rRPG
	 4DIkfeMY+SJJh2uBaLG9HhKIjrmxhBbUPHGe8tFIOP7FLqcd6fwuJ5Ygpi53x9OCD+
	 J79qRh6kVuGMQ==
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
Subject: Re: [PATCH v2 2/5] rust: macros: support additional tokens in quote!
In-Reply-To: <20250228-export-macro-v2-2-569cc7e8926c@google.com> (Alice
	Ryhl's message of "Fri, 28 Feb 2025 12:39:31 +0000")
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
	<2uURW8_Sq6S8VV2UoJJ6bmoH71NWq1X6b1niImKX2mpjudmVM5tNapWA4OLWXoZ8nmcM--z2XtAdgKiNPx8qQg==@protonmail.internalid>
	<20250228-export-macro-v2-2-569cc7e8926c@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 19:51:21 +0100
Message-ID: <874j0dnbrq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This gives the quote! macro support for the following additional tokens:
>
> * The = token.
> * The _ token.
> * Using #my_var with variables of type Ident.
>
> Additionally, some type annotations are added to allow cases where
> groups are empty. For example, quote! does support () in the input, but
> only when it is *not* empty. When it is empty, the compiler cannot infer
> the item type of `tokens`.
>
> These additional quote! features are used by a new proc macro that
> generates code looking like this:
>
> 	const _: () = {
> 	    if true {
> 	        ::kernel::bindings::#name
> 	    } else {
> 	        #name
> 	    };
> 	};
>
> where #name has type Ident.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



