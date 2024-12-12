Return-Path: <linux-kernel+bounces-443152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9489EE7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6223B165061
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589521504F;
	Thu, 12 Dec 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrvcC4X8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C182144A6;
	Thu, 12 Dec 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011106; cv=none; b=bDRXdwhkIdBIIL1woyVk2sc8D/eb9KVPXa6F648WbS0MZN5F10vCiX4d6vIzgV0XMOFg41+Q9JodG1rn4v58TlwzFxp9vJmcRkPRbtdvjKrY5cJAYIDBvpIOv4yc/pfO5ozpVdxV/67/6OjReIGjfR/RS5A0I/5s71TGQPVRpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011106; c=relaxed/simple;
	bh=OsdKk7qDtjnvi8BPvCtOetXim0Vw4TwPy04y4MsZm/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar4tXAgbnUWj1JTvuNulsLcBOC8ux+HXjDMBqqe0aSMuQ4DYGHdDyk7H8+bwujX4Z6GB/sgmiaAMSjSvQkvw3R1lYECx0nJn7aNP+Micu8/mb0dAFKxQyB2cTBiUZ1jH1VVACAwOaMVKHXJ2T2cSa5ggoB5JHaqhc0yRwkl3HMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrvcC4X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA7C4CECE;
	Thu, 12 Dec 2024 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734011106;
	bh=OsdKk7qDtjnvi8BPvCtOetXim0Vw4TwPy04y4MsZm/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrvcC4X8t1HlPbb8j5EPfEwYDAdSga24Dwgil/G6F8jQUH5kmsocXmtt3u0Ov4Y8B
	 Y1tdDRkdiHb9MuB6iubR10o5XbCdnD8oGvDoA+VZJGLpNVv6fK6xw7/Xh3fN8fbbTJ
	 4ZrThme8FEmxxcMJ5tHgLIk93W6e/UY5IkeBNB0KYo90HBCW/XqikvVWWJnyGpHwuL
	 foYTcIsPo61B4vd7V7ceQ6BhEZthufv8AOuOtPgsQCp8QA++ak9JWgKh+dp4FHBqbr
	 euO1O818A+bmSkAeYeB0NGy+3f8jyHX1Rv5W7KaRE8MDrSbR5hUqb7yHUjKAWqsuJq
	 y+oENKPUDeR9w==
Date: Thu, 12 Dec 2024 14:44:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>, Filipe Xavier <felipe_life@live.com>
Subject: Re: [RFC 1/5] locking: MAINTAINERS: Start watching Rust locking
 primitives
Message-ID: <Z1ro28-C63dHnGBI@gmail.com>
References: <20241128054022.19586-1-boqun.feng@gmail.com>
 <20241128054022.19586-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128054022.19586-2-boqun.feng@gmail.com>


* Boqun Feng <boqun.feng@gmail.com> wrote:

> It makes sense to add Rust locking primitives under the watch of general
> locking primitives maintainers. This will encourage more reviews and
> find potential issues earlier. Hence add related Rust files into the
> LOCKING PRIMITIVES entry in MAINTAINERS.
> 
> While we are at it, change the role of myself into the maintainer of
> LOCKDEP and RUST to reflect my responsibility for the corresponding
> code.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 443217066eb9..3a6a193fad99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13351,8 +13351,8 @@ LOCKING PRIMITIVES
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Ingo Molnar <mingo@redhat.com>
>  M:	Will Deacon <will@kernel.org>
> +M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
>  R:	Waiman Long <longman@redhat.com>
> -R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> @@ -13366,6 +13366,11 @@ F:	include/linux/seqlock.h
>  F:	include/linux/spinlock*.h
>  F:	kernel/locking/
>  F:	lib/locking*.[ch]
> +F:	rust/helpers/mutex.c
> +F:	rust/helpers/spinlock.c
> +F:	rust/kernel/sync/lock.rs
> +F:	rust/kernel/sync/lock/
> +F:	rust/kernel/sync/locked_by.rs
>  X:	kernel/locking/locktorture.c

Good idea!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

