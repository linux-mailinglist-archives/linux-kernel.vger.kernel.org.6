Return-Path: <linux-kernel+bounces-568716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA45A69998
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC73D177098
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED38214801;
	Wed, 19 Mar 2025 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sagYOB7+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C382144DD;
	Wed, 19 Mar 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413097; cv=none; b=VKb9ymj2M6SeZgcWmoiYCiUPJ6AciI2b4ljzD051GFsCPoceaBtvdx4iYTVfmnJvxaA3oigs1LR+yiZmT8mSG4MxMBHxlUvSUWgLAMNZnED9GRqdtHeXw1/SFyyVozNGcincUSbYKfR6rSupwPOrvaEU/biIsUqJb9sztst448U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413097; c=relaxed/simple;
	bh=N5ulEUpO2sMJjhG4zyDhLr3G+8EKyFV5hbw4wDUG3Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJHEyX9t0RtOB9VJvT7SV29m7SNrsuSXx970zMhtCzm8ieneQcUJeXypc8gcp9AENGvNfUFNTKJVPGvIgdBwNDN2qVqXw6Y7guRb0wSh6vOQ4orax1FzvyE1LJbDqlI5Y6nvFi2VMHtihR3lIMLKfR36ehkWmzBVFTaw1PTl76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sagYOB7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F169C4CEE4;
	Wed, 19 Mar 2025 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742413096;
	bh=N5ulEUpO2sMJjhG4zyDhLr3G+8EKyFV5hbw4wDUG3Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sagYOB7+5EFuhBY3jydVWTwr34dku/yyRVC1jP20xgC1SxFA2bmtfekQHuiohe7ys
	 cVYYXvWxmyzMPfhKdoahXqshwV/fWtUISSci9n7+XHgqvf5fBwiDYl6oxPysrU1O5y
	 y4gxN+ks5aYbhg3c9h6Z+nY7avyug1VnLdqOszUezQqu8FIeWFGYiIOk75yENs/wuV
	 S0gm3FzwNFShPK/MeJExK+xs4dbUnPrWZC9Kv9F6nscLNm27wFov4sho+Sb1kNiZvS
	 2uwYesJ++5DMO/O0GwHFd6RMwcjJSt14UgbFaRe7wAkyXx+7MW0VfFeGmuC/UlNOVv
	 uPvCVYvkJBUlQ==
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
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::clear
In-Reply-To: <20250311-iov-iter-v1-4-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:15 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<nkUtY3LPWZIn_rd_VdCwJ5zNHqANSBEvWXOAvJerY0wQVbNYAbZ1lKN5SM3LtIxWbOrjdpgjDjz2MrUnN9cS8Q==@protonmail.internalid>
	<20250311-iov-iter-v1-4-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 20:38:04 +0100
Message-ID: <87jz8kg6ar.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Our custom Vec type is missing the stdlib method `clear`, thus add it.
> It will be used in the miscdevice sample.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




