Return-Path: <linux-kernel+bounces-377496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C69ABF97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B674228553F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB7155741;
	Wed, 23 Oct 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpPM/pr5"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7E14F9EE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666754; cv=none; b=K9M4bM8C5wB2EppsvoEgo4C1LMMtkUvFHdT9bj8onx3oK06WOC+G8duIwxWMWMVyXER/CHllph54z2jrsFT4tRZreCE59joA/KMOTe50yly/XvpkTBilcXlrlwAjUSdL/b3rd04P/CYRvsHxwtuAkrHkU358avjavwO7VkMUqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666754; c=relaxed/simple;
	bh=qBH7Iq7ca/YWjSbKnlMY38j7VrvrW/8idOu1Rxjroeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP1PTmnN9qpoKeT/SvZX6cTXhQzYsUBoAhr3M8i6347R5eRzkNJfVrKIJlBOFk2pcC4jnzUmGfFx563IVmXoi0CqCnBuK0E/9GSGE7+TcygmHM4MK0/ZEj0liUZO8fQBM6HLinkoSeBxlIfcIH1mJpQQmLLuPC7HRvhjfa6q4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gpPM/pr5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jp9217593F7B7t3D6LGpvsNQ9L1wY4SIzHSdn4wfYMA=; b=gpPM/pr5TnHOW42lycLn3x0nkL
	RoG27fx9+iV3+TYl0Zr4xQgNAwFuN77QsAs69DbTh6ybHEc3JtHl5N3LrYmjhnFLW8d8XkTBGezM4
	hkFgwoSiJwVXLx0fXa9itaoNhQMFBsNWgXceSWOG4pndqoVspKRlbXSwEHyyzdtg1jp2dEjtO4r4Q
	X9d4lc6fOiz2iCzHOFiiFpSFdISBtFiV2vbjikBXDpY0FIXqy5mXiQm8MwIL4odCOHkk3nNtcq0Ty
	aFY6w0ziPGBe1HW5uGfwNRvHNJ+iSbH9bWTi+tGmkBrHQgV3d6JRMhdzjuonEbT8ycSfOvV0ob+qV
	neRo6sXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3VKp-0000000DIFi-0UXS;
	Wed, 23 Oct 2024 06:59:11 +0000
Date: Tue, 22 Oct 2024 23:59:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
Message-ID: <Zxiev9UaoUlI1xs9@infradead.org>
References: <20241018151112.3533820-1-arnd@kernel.org>
 <ZxidW3lvA5Pqu71m@infradead.org>
 <CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 23, 2024 at 08:57:02AM +0200, Marco Elver wrote:
> On Wed, 23 Oct 2024 at 08:53, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Oct 18, 2024 at 03:11:09PM +0000, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > This symbol is now used on the kasan test module, so it needs to be
> > > exported.
> > >
> > > ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefined!
> >
> > Meh, it would be great not to export internal helpers just because
> > someone wants to test them.  Please just mark that test built-in only
> > instead.
> 
> We have EXPORT_SYMBOL_IF_KUNIT. See include/kunit/visibility.h -
> that's more appropriate, and also adjust kasan_test.c to do
> MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING).

Thats a little better, but at least in this case I still think it is
a very bad idea.  copy_to_kernel_nofault is a perfect vector for
exploit code to probe writing to kernel address without causing faults
so it really should never ever be exported.

