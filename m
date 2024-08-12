Return-Path: <linux-kernel+bounces-282611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA394E66E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745F21C214F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24413632B;
	Mon, 12 Aug 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gLzEqPXO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB014E2F1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443304; cv=none; b=NmJVr0ow0hEv1f4GZAFvbR8TffX0bMV+dgqrDCkjQ9JZFxpJfImAsgFJwNRzE0NCBEhwcm6IGjjP5Ye0iRMRzTigwefYWVQv/RhQR/YqwX71e98qgBdE1EKvUGH7rgkFP8tGbW95SvCnKqTBoRF7myYUAW+REcBP9/M218RfKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443304; c=relaxed/simple;
	bh=a8sxPKJB2KEzpHj9VFKrm0DUNbhiAtM2HYSAkQ+gBs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AypNNusREuns0wnNlKfKMNUI3ocW5OmmK60IparARjvx9/p36eRrQ35nxdaI/IUoXFCt66OxZhW0rrgdCyiPG9V4YhVbQVLUQGbwIayEhFjuGrtsUpQKApslLHOIKIqsF0XibQscAMSOMucPWeGjxA0+TbX3FvCTY2iI98Ay7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gLzEqPXO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xg7KmYffqZBLpF30epvwg0Mu05bAAH+x/ZEjiAYXFjo=; b=gLzEqPXOi98HdUP3XYk+tpLNJE
	3qSsOiFZezC5a6NrAzXgY0Il4il3ryTNfS64dAFOuy71pwRtYmWcwj8gs+9Qd4cqvklH0h+35heBO
	fhCacW3DFketHD0mdqs5gCb980cI/Vr0wNsSa/1CIqvtJs2Qp1r3a/hRhiWMRlKasWaNc0RhsVU8q
	ZpK65kgwSH0hxTrxyWy0ktGkJCHHICUs/NqAke7KzVeme55R6/q+cOfrRZmu//sJJ1YxHr3b+vly0
	u/rtp7OleHvaRVGemr1emVnfR0CiBOnQqaCJnl+RNZe7smkZ6R96QnMFpGJgrOr6c2U/PH0H1/Crx
	7YbNTN+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOKa-0000000GyyG-284i;
	Mon, 12 Aug 2024 06:15:00 +0000
Date: Sun, 11 Aug 2024 23:15:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Max Ramanouski <max8rr8@gmail.com>, x86@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, jniethe@nvidia.com,
	jhubbard@nvidia.com, linux-mm@kvack.org, tglx@linutronix.de
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Message-ID: <ZrmoZKI1UHRRln7j@infradead.org>
References: <20230810100011.14552-1-max8rr8@gmail.com>
 <87wmkr4jgj.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmkr4jgj.fsf@nvdebian.thelocal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

(Somehow I can't find the original in my inbox, so replying here).

The correct helper to use is is_ioremap_addr, as in the generic
iounmap implementation.  This won't matter for x86 currently, but
it clearly documents what the code is doing.

More long term, but I really hate how x86 is not using more of the
generic ioremap code.  kmsan_iounmap_page_range should really move
to generic_iounmap, as should memtype_free after adding a properly
stubbed out API for it.

With that x86 iounmap would just contain a hook for the magic
ISA region, the mmio trace call and then call into generic_ioremap
and we'd get rid of these open coded checks.


