Return-Path: <linux-kernel+bounces-274427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994639477F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5592C281B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A514D71A;
	Mon,  5 Aug 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILiDjGSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB301DFE8;
	Mon,  5 Aug 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848868; cv=none; b=hKVlvHZDQTB77+YIj2UjruoaeX84yjaq3UkbukDlwTCHsKHMigxkE/39+cAoIPSQTn7R/qYKlKofkA9NK+U+ZPoVvvvIr565CN62d7bJNUBlAGrznIfGZGXricSRW4b55+wBYdN4jXCs4LQFKf2RktBWesBBjkOfCc8lgCwi4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848868; c=relaxed/simple;
	bh=T1mgH9qpu6hnvoWQ5/bqVe70+OJ7MFBwK9OmkrHNb9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eY3ZNZc0q+mUZTaFQSR0O/6CGjKSmwnLfc/0pIM7eqR5FVYUWUFo1+Ml9jVQXUPo0J2zb4CQyfzK+TOdF2Z61tfGrGbhoXmgKU8+HiGtWWMNmVmCSLEg+JRy7m2KqqeggebANAx21gJpIpYOUUFJOBwDZsg2wtEgBgj8ByCncAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILiDjGSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055AAC32782;
	Mon,  5 Aug 2024 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722848868;
	bh=T1mgH9qpu6hnvoWQ5/bqVe70+OJ7MFBwK9OmkrHNb9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILiDjGSF8VjdshepXedPYE3tGW1/rJC4PMwI7FP50jJt3fY3X2txEL29DDW3LUzXh
	 2YkLdQmA6liY0VGgTta0IBgENanreMQKKeYkpqxz4voONSewv6oqK5fEa0FKSESqP4
	 Mwyi859gdwr5lBun+zoGAJqYszw222HWrQyORcBmH5Z5BAIROlbp2smk/P586Kj+ov
	 Zo/FTt1xGrOqO+JkTD+PC2Uc58cLAjRgmmT7kbp+Q2Up7XIGZCsMkvmYqKFPC/+LtC
	 AmwoE748FGUfP8z8JJHZVRuwrj3Swkvlk+71KHKK7fUpdV4cs+HV6gtcdzVLM98lDf
	 qRwgqKwcWL54Q==
Date: Mon, 5 Aug 2024 11:07:42 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <ZrCWXmvCF9L24TdO@pollux>
References: <20240803141639.3237686-1-benno.lossin@proton.me>
 <2ddc08c1-ac38-4cc6-a102-2ad336d6b617@kernel.org>
 <CAH5fLgj2urZ6OD2ki6E=6EuPqW3Z8BGg8jd6Bgo4OOrNiptnDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj2urZ6OD2ki6E=6EuPqW3Z8BGg8jd6Bgo4OOrNiptnDw@mail.gmail.com>

On Mon, Aug 05, 2024 at 10:43:57AM +0200, Alice Ryhl wrote:
> On Sun, Aug 4, 2024 at 1:22 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On 8/3/24 4:16 PM, Benno Lossin wrote:
> > > Sometimes (see [1]) it is necessary to drop the value inside of a
> > > `Box<T>`, but retain the allocation. For example to reuse the allocation
> > > in the future.
> > > Introduce a new function `drop_contents` that turns a `Box<T>` into
> > > `Box<MaybeUninit<T>>` by dropping the value.
> >
> > Is this (and the stuff in patch 2) used somewhere? Otherwise, I think it
> > would probably make sense to base this work on top of my allocator work.
> 
> Yes, please see the red/black tree.
> https://lore.kernel.org/rust-for-linux/20240727-b4-rbtree-v8-0-951600ada434@google.com/

Ok, unless preferred otherwise, I'll pick it up in the corresponding patches of
my allocator series then.

> 
> Alice
> 

