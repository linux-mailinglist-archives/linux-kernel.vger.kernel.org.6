Return-Path: <linux-kernel+bounces-286957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AF49520D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421F01C220AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD61BB6AF;
	Wed, 14 Aug 2024 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsMhsC1b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC4A16BE14;
	Wed, 14 Aug 2024 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655708; cv=none; b=k1nYUce+bApEQR6HzydkYHCnzu/zGDjILZZ+xO57MTtODA0yRrhN+wPxrBIQyU7U0fViI5Ohm/DnZisD95+wd/RRztkFwmvkI7hqf5X8bZ+ECcFbNwzCVzQxlyrwyVh++uX/5NyHpViBHiwHv0vrELJZSZ2YBg8Z/Ay0bEwePis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655708; c=relaxed/simple;
	bh=LZNl/0dMNUwtsIJ7Bs4q3NpAqp++UT74bj432Awj02Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSf1GOia9Ns6zGrZBn+mJRzkGyd82HvYeFXQnL0ZI4gYSJrFqMOTJAZuMIAleGKf3R+n0ZIt83MGYZnv2dT8D0uPBxeTXRzl4nFN0iQtpSJIn3X8gQULu/7OeD6ZiG0La+6OpLxxR+QMKF0fWl4qQ9li7QuOjH5kezi0BsvXk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsMhsC1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ECAC116B1;
	Wed, 14 Aug 2024 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655707;
	bh=LZNl/0dMNUwtsIJ7Bs4q3NpAqp++UT74bj432Awj02Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsMhsC1bTlMV+1CFcJDzm9Q9JN8DPtirmVnULKyLMmGs+c922ngMXJJlmR7aWRzv/
	 pSVoZ3DF9GPZKGLCjHKkJ5FSfzfmqgpxNU6C8mvGXpmBLBSN+Bukg/YfB4ukHmw5CW
	 O4c7dhpOT5SrvHwq9dFrM+vl3j3RpE48cxYkU1VaqBswn3me2mmHwKvViFaDVNeURo
	 qy/tQouX9m82sbdFKufG9BjiBK6GJbypq4TjrSiIs3lqQmcalnl2acDIUD2gQQRABI
	 YbQgDsXmcfdAztqXjU1z2GgkXTNubeoz+ez0yPmnLWg+6AOjx9A5A9TJbCyWnhRFRm
	 NI71ngU277img==
Date: Wed, 14 Aug 2024 19:15:00 +0200
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
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrzmFHGXrXxSqXzt@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-5-dakr@kernel.org>
 <b6b3d965-c1d4-4c18-8db4-2e7c19f10a15@proton.me>
 <ZrziXqB5zExntYfW@cassiopeiae>
 <17bcfe21-1af3-4247-98d1-480944be400e@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17bcfe21-1af3-4247-98d1-480944be400e@proton.me>

On Wed, Aug 14, 2024 at 05:02:53PM +0000, Benno Lossin wrote:
> On 14.08.24 18:59, Danilo Krummrich wrote:
> > On Wed, Aug 14, 2024 at 04:21:38PM +0000, Benno Lossin wrote:
> >> On 12.08.24 20:22, Danilo Krummrich wrote:
> >>> +    unsafe fn call(
> >>> +        &self,
> >>> +        ptr: Option<NonNull<u8>>,
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>> +        let size = aligned_size(layout);
> >>> +        let ptr = match ptr {
> >>> +            Some(ptr) => ptr.as_ptr(),
> >>> +            None => ptr::null(),
> >>> +        };
> >>> +
> >>> +        // SAFETY: `ptr` is either NULL or valid by the safety requirements of this function.
> >>> +        let raw_ptr = unsafe {
> >>> +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> >>> +            self.0(ptr.cast(), size, flags.0).cast()
> >>> +        };
> >>> +
> >>> +        let ptr = if size == 0 {
> >>
> >> Why do you do this check *after* calling `self.0`?
> > 
> > Because I need `raw_ptr` in the else case below.
> 
> But you can just return early above? I would prefer the check be done
> before `self.0` is called.

No, we can't return early, we need `self.0` to be called, because if `size == 0`
we free the given allocation, if any.

> 
> ---
> Cheers,
> Benno
> 

