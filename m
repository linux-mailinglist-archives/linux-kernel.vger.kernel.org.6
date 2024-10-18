Return-Path: <linux-kernel+bounces-372445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796609A489C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84331C22DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1C18E348;
	Fri, 18 Oct 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TDj/sEPo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEB518D64F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284927; cv=none; b=d/4VfEL8k/CVWrAW596bU9GaFC0u1gn0yN2PzUs7GNbO2QwOj9GQbDrgK38feYnobvfTVLnQX9wJ2LqambOH+4JsDUTQJLFkZ/L2VPx0Y1CG/NC1H0f2DOssV/OGKvK66NBUSAkleJOxdzOJvG+c55VBRz/L054hz0pnqeJOHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284927; c=relaxed/simple;
	bh=VzngsTUFP/1xT/m4LaB2BmzLki44ySVZAmwd67mxhAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk8Y4NJ55bDhprNOpAeeV6ZRbJfai5H+Yu5AgzpisB6JRhbxnO01i6wKoa48FsOs8MAfCX6I3LnZQqByTloUZEM0nh34MM8xSIXLMXpijbFmov6dI1pNDP59L3ZF8XULg4Rh5JmjpJjmdUkErqHUBaVCLGaIjcreCw87nl0Htfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TDj/sEPo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YG0aKuNIfZU8ybH8uXRKY2sJyAHtBWGk9Y5OxRE6S94=; b=TDj/sEPoRnr7lQ1BvmrFEVNq0v
	Fv/RsVzRz4AmpmFkA03f3M//kH5EY1WpWJwDhRpRrO6Su63UMEwQoxfuDlhMI8XWBvq3T4yntWhTI
	Y4Bo/vzdy5/YP2WFw34e4sOQGE/3tBrc257MDiBhn1dVcqdEy9WtaHGuNfbY3QAfFgPnKk/hab7q/
	u1rpwVz+DulrKwRbrR2RxiE6FryNWVrEh1Ska8LixRbWNMYT+DOfY7yE5bvWTMMYrQ4Bt3Ii6MHeg
	DivXcK/fSCvhfU0Ytmt45HlsFnhBcxg9iPMVZj89ffgS88J64fVCEcx16DYmCK0HT4Nb2+AFLrMiS
	jaBiH1Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1u0E-0000000DadV-07Lt;
	Fri, 18 Oct 2024 20:55:18 +0000
Date: Fri, 18 Oct 2024 21:55:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, zswap: don't touch the XArray lock if there is no
 entry to free
Message-ID: <ZxLLNfbLifp-b3W7@casper.infradead.org>
References: <20241018192525.95862-1-ryncsn@gmail.com>
 <ZxK7G3S0N42ejJMh@casper.infradead.org>
 <CAMgjq7AjBMJAE-rj2MmB53FrQKcsARK5tZ3sKB4+uhWhkQ=EGA@mail.gmail.com>
 <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZMTJKYR+au2rjP1v+c8PvdP4D39j86tHg=o2riKGYynQ@mail.gmail.com>

On Fri, Oct 18, 2024 at 01:40:18PM -0700, Yosry Ahmed wrote:
> Oh I thought xas_reload() is enough here to check that the entry is
> still there after the lock is acquired. Do we have to start the walk
> over after holding the lock?

Yes.  The entry is guaranteed to still be valid, but the node you're
looking in might have been freed, so you can't modify the node without
making sure the node is still in the tree.  We could make that cheaper
than a rewalk, but you're going to need to write that code since you're
the first to want to do something like this.

