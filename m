Return-Path: <linux-kernel+bounces-403994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A719C3DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB00B231E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814A18BBA2;
	Mon, 11 Nov 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBCvF9nI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40A139578;
	Mon, 11 Nov 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325636; cv=none; b=D0TyxCJvIfYUoNHRDsoaQv3cLUbpiKS/9tkfz5V/Win4B/CnEDqe/6HRqZ8kT5C99Hhy+7FYQxisflepdWN0DO+CreyUw7++SbKs3BELyAdSFRVo463fctRikNRKMdFLgPSFx2F6EQYQY47FCDzADJ20TSMf7s3PZnlPeonc/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325636; c=relaxed/simple;
	bh=ahzrlY6OwFk0VzvSBw1IShk2Bx/oulWv8n9Ybo9astE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ngkvr03R22wK/CXHGXVi7hv2a+4O166c2dBbr1or8m/07SwZpg2D5zivM45vIm+8bJuoYUovXiSNrNit9gt9hXpXsVlP8rjsYT739T+u7h01G0bdxrNBtrXSTY16zQKWllJKk6Hh60v315PK9b0YsQCtiMVFU/4Pb+tGoftzj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBCvF9nI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53716C4CECF;
	Mon, 11 Nov 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731325636;
	bh=ahzrlY6OwFk0VzvSBw1IShk2Bx/oulWv8n9Ybo9astE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vBCvF9nISBDR4GE7OpYrsQxoh/b5Hw/U0yiDJecB5a5nbThfVLjRXS/sxJ15stMOl
	 J6617r5XRtxmJ9iNfFCppV6hsPcjfHndaJ7yvTGUdcHYIVdJjB8VVnsCGBiHAv6N8n
	 OK3emS4THJgtEorejJoTlt9ogmGx/Cf5iurWQgv8bytnxIyv9w7S6mOAKSlqbJvQKZ
	 7uvKLyDMNxTsT1FQax3TnmK2TtT6kzKQi1piHHeuVyHR+4iM8/d+2ZT9uXEm5UFCeL
	 5wQGFqJPQk9SUdE7E2xabA/hsIWPMhEkSGBvE7ptccmMKO3FsVqdB3LScG/DpyRT3/
	 mqWwif0CWLIzA==
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
Date: Mon, 11 Nov 2024 12:46:50 +0100
Message-ID: <87cyj2t2l1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alistair Francis" <alistair@alistair23.me> writes:

> The kernel includes a large number of static inline functions that are
> defined in header files. One example is the crypto_shash_descsize()
> function which is defined in hash.h as
>
> static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
> {
> 	return tfm->descsize;
> }
>
> bindgen is currently unable to generate bindings to these functions as
> they are not publically exposed (they are static after all).

Very cool!

What does this mean for our minimum bindgen version? Is the feature safe
to use in our current required version of 0.65.1? Did the feature change
in significant ways between 0.65.1 and whatever version it will be
stable in?


> diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
> new file mode 100644
> index 000000000000..1f24360daeb3
> --- /dev/null
> +++ b/rust/bindgen_static_functions
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Don't generate structs
> +--blocklist-type '.*'
> +
> +--allowlist-function blk_mq_rq_to_pdu

Should this be moved to the "Remove blk helper" patch?


Best regards,
Andreas Hindborg



