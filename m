Return-Path: <linux-kernel+bounces-377588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445C9AC0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8241E1C21114
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BA15820C;
	Wed, 23 Oct 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1VZmLGA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D915746F;
	Wed, 23 Oct 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670612; cv=none; b=dk+855uc0EG4X/KK8bre+lH/rk9S8vRnu0MPnrnkwliIN1WqKEH8p2uDKlmYCkCAQCvZJdIxxwKjwU7WPV01Rwm0yFtS0tw0eIiiaJOziSsWKrS95qHLXet9AZH8ELVUTMk5pbchkqAw7Qb36QkKxYAj8RdIhb+TZGcUr7SWkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670612; c=relaxed/simple;
	bh=qPebdNS2aZYLxjo58zmxZfxOdumUpjrXTsuehOimBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/lS4PKJH9XcS+tDaAqI9WSLjz8bSxkbHYKwZ0+fHtYZDZ+FwUR4jgCzrHZTkWuyZQXO6UuqKT39eRW7XKmBgFWjEcjG8bOJYiJTsZM56cc040IlbtTnDLz9Arzyd98QYXMlmcH52OUKfMVz8xf5OmLFCp0Yoj2yETsYM/qx2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1VZmLGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80078C4CEE5;
	Wed, 23 Oct 2024 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729670612;
	bh=qPebdNS2aZYLxjo58zmxZfxOdumUpjrXTsuehOimBRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1VZmLGAPQf3BbaiH4BF1pdl5mZjnC7vZgcQdbMibFnskAF+suTYPsI3Tv5OQ6yZ8
	 VqSqwj20SjVTSNOxyiRiXSPMD9K2gxAHbxHvabOfMyObvLUEXQx+19SwjscyenwyNu
	 Z15/Q+BEs1ZKDW/ppPdbiI3zmkqCabfhfmBJ+NKzedKapk0MWzJpgkVLzvRpYkT0U0
	 h6eirFHPMz3Fr58iOi/0TvZ6h8zSMX/15gPTwISjXFaEW3s/y8zF4YicxvaDJdorr8
	 7pb/go92J4BoxNMCpXPf+aisiqJ1ZtruQ1/Tt6tYuFQHbvwhI2OMwNqSPvOl7v2Nin
	 GcPZr65Ao1O3Q==
Date: Wed, 23 Oct 2024 10:03:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 0/5] Introduce Owned type and Ownable trait (was:
 "rust: page: Add support for vmalloc_to_page")
Message-ID: <Zxitz41uPPeloK0o@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>

On Wed, Oct 23, 2024 at 01:44:44AM +0300, Abdiel Janulgue wrote:
> Hi all,
> 
> This series introduces the Owned type and Ownable trait which is the v2 of
> "rust: page: Add support for vmalloc_to_page" [0]. This series includes changes
> for firmware as well to make use of the new wrapper.

Please make sure to add all relevant maintainers. Since this includes a firmware
patch, you should make sure to add all firmware maintainers. Remember to use
scripts/get_maintainer.pl.

Also there are a few minor checkpatch warnings. Please also make sure to run
scripts/checkpatch.pl.

Please also make sure to compile the code with `CLIPPY=1` (there are a bunch of
warnings) and make sure to also run the `rustfmt` target (there are some
formatting issues).

I wonder if it would make sense to make `CLIPPY=1` the default and only disable
it by explicitly passing `CLIPPY=0`.

> 
> Changes since v2:
> - Use Owned and Ownable types for constructing Page as suggested in [1]
>   instad of using ptr::read().
> 
> [0] https://lore.kernel.org/rust-for-linux/20241007202752.3096472-1-abdiel.janulgue@gmail.com/
> [1] https://lore.kernel.org/rust-for-linux/ZwUYmunVpzpexGV8@boqun-archlinux/
> 
> Abdiel Janulgue (5):
>   rust: types: add `Owned` type and `Ownable` trait
>   rust: page: Make ownership of the page pointer explicit.
>   rust: page: Extend support to vmalloc_to_page
>   rust: page: Add page_slice_to_page
>   rust: firmware: implement `Ownable` for Firmware
> 
>  rust/kernel/firmware.rs |  31 ++++++-----
>  rust/kernel/page.rs     | 116 +++++++++++++++++++++++++++++++++++-----
>  rust/kernel/types.rs    |  62 +++++++++++++++++++++
>  3 files changed, 184 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 15541c9263ce34ff95a06bc68f45d9bc5c990bcd
> -- 
> 2.43.0
> 

