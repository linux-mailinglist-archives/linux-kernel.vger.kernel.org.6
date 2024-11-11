Return-Path: <linux-kernel+bounces-404013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C762C9C3DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765131F21F59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E519ABC4;
	Mon, 11 Nov 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir6vrS64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D515539A;
	Mon, 11 Nov 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326842; cv=none; b=tW6bJKI563OP3LBrP8UFsv+lib5uM+PDHYAg5f8TpyoInE1oQqWFGooHn9b3ng1r5iQr59KBgkF7xOPjE+t9NBlFs0ATael9QZuPAGFFbnWTLZzFL1yySFUEnoZJzUNemxi00kBsi/ysvOqUtTBrtWSKdWCJgvLIoCzqYfzsPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326842; c=relaxed/simple;
	bh=Aby8kL7QLP4bhaOzikdtXuKtq+0cyWv1UxhuOdpDHF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWtKzdRFGxjtnVtOGFem+rDLGTmV0+l2B4mThqOFu0uPVjtJYVAGjQdUXWbV6XCxz096KNpY35FZgosKf8EmFKpWNk12A0dtDK4tcR65KAVvuFnablBWL11KQXck6HQAmdW/8y2w1RnQkkaxo5xsPTpyuEqMzpc5n+BCRRC4Xt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir6vrS64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E309C4CECF;
	Mon, 11 Nov 2024 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731326842;
	bh=Aby8kL7QLP4bhaOzikdtXuKtq+0cyWv1UxhuOdpDHF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ir6vrS64DQVWfBVy4M+uW9KilWVA9GWJSkvqBFCkr5jJKDzW/HGNlFf6PM9u9nuvd
	 ZzrwuMz5W/zfvCDxzwJpRJtTp6z7Je4GirZ+lfaw+wVRcH6D1Thmna9gPRPucTsjl8
	 HfBpDsbmPE310MPVjXpA/9mvlh3s3JnsquGWcN6D2c5EjmdSc0bXgHeZNYMBaajcMT
	 aSQfRBKJ4leehP0RJWfiyJEtNG07MwKoe9BawMBQ9cKqbn1jLhkrtaPZ+20YbGYlsz
	 /tPvnIwopsxDPbuCiU5mNzGXWB1BAnGGZMhRb5t2/ebXZN96KndpWWmOYVv3x8CEpj
	 pJFPns9C2+IDA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alistair Francis" <alistair@alistair23.me>
Cc: <linux-kernel@vger.kernel.org>,  <boqun.feng@gmail.com>,
  <me@kloenk.dev>,  <benno.lossin@proton.me>,  <tmgross@umich.edu>,
  <aliceryhl@google.com>,  <gary@garyguo.net>,  <ojeda@kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <alex.gaynor@gmail.com>,
  <alistair.francis@wdc.com>,  <bjorn3_gh@protonmail.com>,
  <alistair23@gmail.com>
Subject: Re: [PATCH v3 01/11] rust: bindings: Support some inline static
 functions
In-Reply-To: <20241111112615.179133-2-alistair@alistair23.me> (Alistair
	Francis's message of "Mon, 11 Nov 2024 21:26:05 +1000")
References: <20241111112615.179133-1-alistair@alistair23.me>
	<x6OyXuGQi1xeknAX_pjcl17BOpxRM6OGtLWGhGOH4LUgghJaP29a4ebzCT21QdfxBb88PwZCc2U7zizrTTSzVg==@protonmail.internalid>
	<20241111112615.179133-2-alistair@alistair23.me>
Date: Mon, 11 Nov 2024 13:07:11 +0100
Message-ID: <878qtqt1n4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alistair Francis" <alistair@alistair23.me> writes:

<cut>

> diff --git a/rust/exports.c b/rust/exports.c
> index 587f0e776aba..288958d2ebea 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -18,6 +18,7 @@
>  #include "exports_core_generated.h"
>  #include "exports_helpers_generated.h"
>  #include "exports_bindings_generated.h"
> +#include "exports_bindings_static_generated.h"

Generating `exports_bindings_static_generated.h` depends on `exports.o`,
which depends on `exports.c`. Does this not create chicken-egg kind of
problem?

Best regards,
Andreas Hindborg



