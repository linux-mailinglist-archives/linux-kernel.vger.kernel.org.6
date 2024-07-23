Return-Path: <linux-kernel+bounces-260114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C593A335
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4898D284545
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C7156C49;
	Tue, 23 Jul 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iM51JkRe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6347156F21;
	Tue, 23 Jul 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746221; cv=none; b=S89aR5V9it6mGQl13VTReuZ6l5OA9fgpXOLNtev6+Ro+VkYXZwyVIPkaXbeFvZdfqTHZUd2DztFYkEkEyXMmioqu7VN5Hi/NslLHXfE5Mu38h35EfPeXbMFiHEnlzAeZab5ZUd6zCodmkQEMHtca3QnW36dHlq58eVVvRcRtaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746221; c=relaxed/simple;
	bh=JbFRFZR+rTdk5D5OdQPv9NbhNeONFHjpg/SS8MMWpeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/3Bi7RSRHGeyjwgek3dFpYwrhbRN1j/OpH3tc6rduEjRUeHPn5+ZMrTVaN3KsQDqVwSJmIAFerQav9d69FHm4IuCqcQhRnEV/00rz0KuRhK/eHUG85yiqAMt0pzFhAX4sTg9BJgc+7prhPZML/7GlmDVL41Fo0PlVV3y/Z7eWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iM51JkRe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jYWVnpw0/I8x56Kco6vA/ZpE9Ty7o70/Ja2C3Pi/lJI=; b=iM51JkReSoz3OjbOTIJFF8ELeE
	KC0SaGCqdZSoW4Kd00KCcHD0VPEQtZRUATO38BuYSwL3MtaGW23wxEMOQGxvl/+r/PzI/KNwLDdYG
	FmmurlUrzqnyjvWFY+O7RrataQ1UOmupaML6s9ZXllZ5ez72yg+4sqbMVUoBc+X2reG8B6ktVbv+t
	2n3q0qBO5yHLcnon5aLNLD1+EkqIXK0zZwbvm4nlXKSwQqwKN4gB5rDNbyY7PwsVPEWgM/B4+UDip
	uQIrS5JGyfV5Uq3HFfcQGhJ8/zEDwc8m2cG0j2MpC4ZAz7TFAqjbNhpoK5jFhfnpql6wQHe3C87v4
	EE1rM+Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGq8-00000006yW4-2hq3;
	Tue, 23 Jul 2024 14:50:08 +0000
Date: Tue, 23 Jul 2024 15:50:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <Zp_DIEOj0PtNywmA@casper.infradead.org>
References: <20240723-vma-v1-1-32ad5a0118ee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-vma-v1-1-32ad5a0118ee@google.com>

On Tue, Jul 23, 2024 at 02:32:03PM +0000, Alice Ryhl wrote:
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.

If I were reading the documentation, I might want to know if it's safe
to call in interrupt context (either soft or hard).  ie can mmdrop
sleep (if it turns out to be the last owner of the mm).

> +/// A wrapper for the kernel's `struct vm_area_struct`.
> +///
> +/// It represents an area of virtual memory.
> +#[repr(transparent)]
> +pub struct Area {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}

That seems like a very generic name!  MMArea?  VMA?  Certainly when I'm
talking to people, I say VMA.  struct vm_area_struct is a terrible name
and I'd be happy to change it if we could stomach that churn.  If I were
naming it today, I'd want to call it struct mm_area.


