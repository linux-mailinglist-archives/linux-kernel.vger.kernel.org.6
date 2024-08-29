Return-Path: <linux-kernel+bounces-307756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F4965274
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6212A1F2509C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC41BA28A;
	Thu, 29 Aug 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtXHr0bT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5915C138;
	Thu, 29 Aug 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968583; cv=none; b=O7OqALqmIfayIHTefBCg3UKAIvOalPTcdVyjetcuJE37YcyCgbD63ldeXaxxpa/+fbMgeh200xKWyfnP7PTpqxdI3qoomZzaEM8vR5iOufbRMD9RSHKMtkEw7kC4yRygVZP9VnMT9pzI0ViiF1aj6lf7tPodP8/0c1/a4RTs1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968583; c=relaxed/simple;
	bh=FObmfTahpuIOJ8yu7UnULI90tps2h+H4ynBgK+BEgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgpz3SB++zrIz4W45jp7r84y4lkRIrjh/eYu/735Hs5bNYOdpw/xjya8qPQQkE9hxEthdI0/n1O8ifnmHgdzAlni88xb3KjNfhuibPffZMtrjDMPM4psF2QLTWud8hAagU71AsJxxwBsEy/Gz6JC8I2pMtAYqfm8JCabCTJAzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtXHr0bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8240DC4CEC1;
	Thu, 29 Aug 2024 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724968583;
	bh=FObmfTahpuIOJ8yu7UnULI90tps2h+H4ynBgK+BEgGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtXHr0bTCh95yK3obYsgx8Xt2tMrDFnCUBRIWrTCdcsJm6sUc7mJLQ6cpT1o9mbaM
	 cSv6fmbir18IyPdwz4WvLJ20whNlXR8WkFwFLwxF/E1rWWPUbHjukgD82n7eIJBAJ5
	 /3Xgww+aPE9lk8E704/mpZSFkMNCqjtsqXcuLoX0LD32/w2lvdrOZAfcBiHCuVnKyP
	 WxwP8gu7IvOFg7ReSbuBHl1oLt3SLskfV4VppltJwurlcvX2yVxdE6UvifI4zmTk7e
	 jm4sQCCfi77ofb61l1TKAX6i4YubPQ4N3u4yS0AnpABlpAIvAApkk+2JqkbftXFYk0
	 ECJKBIVJg0Okg==
Date: Thu, 29 Aug 2024 23:56:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <ZtDuf0QGfhiy5X_I@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-2-dakr@kernel.org>
 <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me>

On Thu, Aug 29, 2024 at 06:19:09PM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> > 
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> We discussed this in our weekly meeting (I think ~one week ago?). If you
> give me a draft version of the comment that you plan to add regarding
> the `old_layout` parameter, I can see if I am happy with it. If I am, I
> would give you my RB.

May I propose you let me know what you would like to see covered, rather than
me trying to guess it. :-)

> 
> ---
> Cheers,
> Benno
> 

