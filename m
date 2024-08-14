Return-Path: <linux-kernel+bounces-287286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F113D9525F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCAB1C20FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C114AD3B;
	Wed, 14 Aug 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKbvnFq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169217346D;
	Wed, 14 Aug 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675610; cv=none; b=he2OLh+81bMXQv3ngDSgs+sbkkxenuieXoab9uxOSid133JXQZSakPK8XztpaoOT4WzrpdF2+hh5uVx4lg7JafgDBQSw6kor+INqF1NKiyzjik7BZfTt25z+6h77r2rknQlRera4JyqlhD1ZT7pqyjUUncNQR4uQx1vjDIIhnRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675610; c=relaxed/simple;
	bh=J/IhgfoTTGNLlC6gXnP04bsS2JW2XPAB2U4xnF9Lvjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUksSQpurvO/D6XL9dE1S+FLDSrpM1g0jGxpl72ReGg8ESQjCsh0kG8fOvR/9lZmkSmZ4caVvufCDFB0/j7c2/NvLmJHMcPW+Y4DiZAvYt+WUQcEcTaXd3E0B2lp5z0tn9m+OD7A50wZlVRbw5L+UjeWa/kCGNQC/E/JkeJfowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKbvnFq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3360C116B1;
	Wed, 14 Aug 2024 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723675609;
	bh=J/IhgfoTTGNLlC6gXnP04bsS2JW2XPAB2U4xnF9Lvjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKbvnFq69EFAhB6pU5+2+oAbesuU7VfjBQCW1kVBwk9ertWekxmuinZpOP2NcCiRc
	 zB3eQj6ya17dYeu8WrFA2yb5bP27PP8WonU6xAjUhTAkXrH0fq+jmGj0J/9XXvowSd
	 fUpf5T0ONumN7xqtFoxqu3DVtr1Z8/fuNBuuXUBCXMmcdd1Jiesbc0f1ykEEEaSTBL
	 A77jMHZrHShIfty+LHRGK22oUg6y6qyMXxXtWSJlGY/3fbDl+Sdt7IF98XErOQ6QJt
	 3vLOZu942+URWPenXjjBXm7hd9Tqui2RFBqSSevatSdI4itDkeoFL9IFafXKZefOJw
	 Yzt+7GCqoO58A==
Date: Thu, 15 Aug 2024 00:46:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <Zr0z0fBM_acHFezv@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-14-dakr@kernel.org>
 <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com>

On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
> > +#[macro_export]
> > +macro_rules! kvec {
> > +    () => (
> > +        {
> > +            $crate::alloc::KVec::new()
> > +        }
> > +    );
> > +    ($elem:expr; $n:expr) => (
> > +        {
> > +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> > +        }
> > +    );
> > +    ($($x:expr),+ $(,)?) => (
> > +        {
> > +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> > +                Ok(b) => Ok($crate::alloc::KBox::into_vec(b)),
> > +                Err(e) => Err(e),
> 
> Hmm. This currently generates code that:
> 
> 1. Creates the array.
> 2. Allocates the memory.
> 3. Moves the array into the box.
> 
> Whereas the stdlib macro swaps step 1 and 2.

Isn't stdlib [1] doing the same thing I do?

[1] https://doc.rust-lang.org/1.80.1/src/alloc/macros.rs.html#49

> You can do the same by utilizing new_uninit. A sketch:
> 
> match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {

How do we get the size here? `#![feature(generic_arg_infer)]` seems to be
unstable.

>     Ok(b) => Ok(KVec::from(KBox::write(b, [$($x),+]))),
>     Err(e) => Err(e),
> }

