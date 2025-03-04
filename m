Return-Path: <linux-kernel+bounces-545604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDCFA4EF28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6149F18802F3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8D265CB2;
	Tue,  4 Mar 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UTsxy9+U"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4E251788
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122516; cv=none; b=ZZG5CniL1KMBeW8YY0uGvcX5F7NMKrAfjPq38bS8atWmJ4p+hICorN4JSRhXRZa0EeJcalm+vn+oYe1s843Sv1enOhCz/nOMbgXEzFfU4+hOGNc4Tgsfv6Y04AY/02D+j9kxfObpIlZMt0KtZbngWJgCYtQW1wGLhJ7f2y+R0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122516; c=relaxed/simple;
	bh=R4+Olqil3QTAYRU0IqZr9m/+P7NpX0KNMilzKkpZL48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATI13eNFLiiyQc4y02c2luzcYFTpGSgIA8kV1mvukyibSgk8P9iC+qPwSGea62FkYRsYkhZCoT9XtXcUN17l5PiZLrlQYhoV0F7nfdU7ysHUmyz5bqdoul+GyMIRyKViOJqiW6Myfkx1H0MtjzIB4iMcQqcNLsqdR044wT3YCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UTsxy9+U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3cll4HEGgBga+xhcxslXnif10dGHllwX0pwA/5D+hoU=; b=UTsxy9+UvODNWELurRpUkghxZS
	qIYkMPjzyivCL3DeQHfHkGDeG6e2jRGFzaY68aZwMtgDVWaP1SXbMlowHPhjEysPdAqw+sCe0baaq
	WaXfk5/zl7NxHCOQt+t9KZv3gqbVtwjbpeSE7ubvO/q9z/QM/m9VtfulWdC+ZQ70s9sd9pD78bdRe
	LE8dm8KKVjZrkTkYFzFvYkJVT1zmjYkB2wWGap+KpzcoDaOMW785lQqDhVc/xd1RuF/qNILgDe0IP
	jtDV2iXxNlPEqLB7oHeXmoWg/oMaHjm+jC5Gz4RDuwoC2tU2IIu5Rt+49CH2HYYuZv5UFSIiFFLcu
	oKSgFlWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpZV8-0000000475Y-25em;
	Tue, 04 Mar 2025 21:08:30 +0000
Date: Tue, 4 Mar 2025 21:08:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] intel_th: avoid using deprecated page->mapping, index
 fields
Message-ID: <Z8drzoRVJL3P1jlN@casper.infradead.org>
References: <20241203080001.12341-1-lorenzo.stoakes@oracle.com>
 <0fcfc239-19c7-404f-bbc5-70a29ccf6ec0@lucifer.local>
 <87v7tyyrvb.fsf@ubik.fi.intel.com>
 <64514bd2-0271-4b2e-b1f5-a35520fae4ff@lucifer.local>
 <87sep1zw6d.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sep1zw6d.fsf@ubik.fi.intel.com>

On Wed, Jan 29, 2025 at 01:39:06PM +0200, Alexander Shishkin wrote:
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> writes:
> 
> > Thanks very much! Yeah just keen to get this in as we are moving towards
> > removing these fields very soon.
> 
> My understanding is that this is a part of larger effort to reduce
> struct page to 8 bytes and an optionally dynamically allocated slightly
> larger structure, is that correct? Just curious.
> 
> > Could you take this in your tree? I think that'd work best.
> 
> Sure, will do.

Hi, this doesn't appear to be in linux-next yet.  Could you confirm it's
scheduled to hit the next merge window?

