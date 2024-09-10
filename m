Return-Path: <linux-kernel+bounces-323701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0F5974218
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB54F1F270E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90071A4F29;
	Tue, 10 Sep 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnoZPb6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EE1A4B7A;
	Tue, 10 Sep 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992813; cv=none; b=hiVcqGjfxriWzh9so/9TTIk5c3+xN6UBM5g3DUQGNGP5StUiunyHGsLG4y37tirX/ybPyY2Q9HORh4MILUNxMGFWSykY4C6v9gw0fd6OSnpeNU1P+qve4/ZWvVY3KkxY3KcSsYoQZDi620WHyxbvgQjfT5d2UGsNkb/UIpXhSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992813; c=relaxed/simple;
	bh=1K8WGPISx1mqVVku5h0gwhi9A7UiUfs/Bez4uxWR74s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZxC52pEclqSLT67IJKeJOI/3bK4frEkr7VO8syILFt4CukS6EQY4XnVESDwp3vZw0HERFaa1H2JWgiZT+K8cnrAhLkicCy/Z7yO1+7ww9vzJlhl2x4sygcqKWj+02iYBNSbIdQuMiQ3g6E5gQiUiR/3LPXCdMFWOe9bSzsTf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnoZPb6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1509BC4CEC3;
	Tue, 10 Sep 2024 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992812;
	bh=1K8WGPISx1mqVVku5h0gwhi9A7UiUfs/Bez4uxWR74s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnoZPb6EH2O8Z4BCi7+cQElu+buiCehPlyMRNksd+yo0dcHHXkEQZQeCd/ityMWiA
	 WthYoES9IxQjDUl9w1GCr8MnPS/bwbK8mhb2aqW3Kzihhx6eNuqPoS5Py0HsqlHmwW
	 +PTk8xPGgb4qYVOYTZuPYkesUElRkV0OIrwl+mNnxLfhVu3dlzK45Jb4OzeN7ehKFO
	 ZbumVu/Ss1vWtGFVLy6iYmKdca0L70r5/p9uH7QuF/VUT7jmJsaJrBfguT4hTp12Mo
	 36byu1si00e/A6njeaseiid4jPyJ8exIjKT1u8/0/TRuoLRNHHUpxIBimH1j+4Df2m
	 hGH1zwfB1e2Xw==
Date: Tue, 10 Sep 2024 20:26:42 +0200
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
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <ZuCPYq9p61_Q9YwC@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-14-dakr@kernel.org>
 <ZtdemCduZ1KqayXw@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtdemCduZ1KqayXw@boqun-archlinux>

On Tue, Sep 03, 2024 at 12:08:08PM -0700, Boqun Feng wrote:
> On Fri, Aug 16, 2024 at 02:10:55AM +0200, Danilo Krummrich wrote:
> > `Vec` provides a contiguous growable array type (such as `Vec`) with
> > contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> > `Vmalloc` or `KVmalloc`).
> > 
> > In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> [...]
> > +
> > +impl<T, A> Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> [...]
> > +    /// Forcefully sets `self.len` to `new_len`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// - `new_len` must be less than or equal to [`Self::capacity`].
> > +    /// - If `new_len` is greater than `self.len`, all elements within the interval
> > +    ///   [`self.len`,`new_len`] must be initialized.
> 
> Maybe use "[`self.len`, `new_len`)" to indicate `new_len` side is open?

Agreed.

> Also `self.len` may confuse people whether it's the old length or new
> length, could you use `old_len` and add note saying "`old_len` is the
> length before `set_len()`?

What about:

   /// - If `new_len` is greater than `self.len` (from before calling this function), all elements
   ///   within the interval [`self.len`,`new_len`] must be initialized.

