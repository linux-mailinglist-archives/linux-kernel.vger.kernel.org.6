Return-Path: <linux-kernel+bounces-287460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F4952802
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4399EB23C53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BB383A2;
	Thu, 15 Aug 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4sEqKBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8629422;
	Thu, 15 Aug 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690370; cv=none; b=IotpLnKXb2nAiV0QxqtDaXzqOSpVWPCZ7OH5YVb7gE8rDDtgXjbZAeWzIU65WhPkFh193+be/CuPBOGj5EJrT6Kfit6toED9slg9fZbyJPYUOg1VKkpfiOAB3Xc5xZ8z66DOMOLjMyIsqYZgWbC0xnhuz9Zi7hlCb1R5FYlfhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690370; c=relaxed/simple;
	bh=9lHi4Fn05Fqn+UhryIcKZ35IIPLC/wPvR9F2k2Ns8cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhbwU+LTpbY2PGSD/M6pvRi61Lokkv3r0abD7Ore/eiX3tmScVd4EBK+rvYpzP1+DIsUzcZoAWQpPiBtExMelHEJ6TQUA1n0arOwnfdX6d+t/d734G87SoXwOJe65Gt3eSCqPEaeq18XzEnSMubwGfz/oSyjwBWCG2e7f4bNfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4sEqKBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05297C116B1;
	Thu, 15 Aug 2024 02:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723690369;
	bh=9lHi4Fn05Fqn+UhryIcKZ35IIPLC/wPvR9F2k2Ns8cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g4sEqKBrmnWlBt8i+NAmFnBQMJb+TClGPq40kRq6aEOzy237abhszxAqG4/VQ+F/j
	 ii94cDngj1RVzVnol55shUXUhi4xiYB/b1vEjG4xcqkLbZvRBnmgMjzc61Sf4CIlwO
	 fg7l5at6aBTJ5pp4jaPmy9kdi0Pk78YH6RU7M58fk61jA1o4RmmHx/XmeXJZDOHNuX
	 nStvf4Lpj9ESgk9bDUnXXKMgXQz6IaEU3pqrv3G1kY0f95DvAbQPqjlfXuqd2QXPGr
	 m4TBkP5QZoDInMNeIWSZLC8YLyZdxPUdWUbg34znsyQjGncYMklpZ8d1bHDlfvUz44
	 S05Ge/Pu47omg==
Date: Thu, 15 Aug 2024 04:52:42 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/26] Generic `Allocator` support for Rust
Message-ID: <Zr1teqjuOHeeFO4Z@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <Zr0GP0OXliPRqx4C@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr0GP0OXliPRqx4C@boqun-archlinux>

On Wed, Aug 14, 2024 at 12:32:15PM -0700, Boqun Feng wrote:
> Hi Danilo,
> 
> I'm trying to put your series on rust-dev, but I hit a few conflicts due
> to the conflict with `Box::drop_contents`, which has been in rust-dev
> for a while. And the conflict is not that trivial for me to resolve.
> So just a head-up, that's a requirement for me to put it on rust-dev for
> more tests from my end ;-)

I rebased everything and you can fetch them from [1].

I resolved the following conflicts:

  - for `Box`, implement
    - `drop_contents`
    - `manually_drop_contents` [2]
    - ``move_out` [2]
    - `BorrowedMut` for `ForeignOwnable` for `Box<T, A>` and `Pin<Box<T, A>>`
    - `InPlaceWrite` and updated `InPlaceInit`
  - for `RBTreeNode`, make use of `Box::move_out` to replace the original
    implementation partially moving out of `Box`

@Alice: Please have a look at the changes for `RBTreeNode`. Maybe it's also
worth having them in a separate patch.

- Danilo


[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust-dev/mm
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/commit/?h=rust-dev/mm&id=ef80ccca2ccebf3c7bcafdc13d1bfe81341cbe63
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/diff/rust/kernel/rbtree.rs?h=rust-dev/mm&id=c361d66df7fb7760064fbca6bf9d72171c352a73

> 
> Regards,
> Boqun

