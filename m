Return-Path: <linux-kernel+bounces-377383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA99ABE25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E2B24301
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C914601F;
	Wed, 23 Oct 2024 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nzs/xrcu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C487482;
	Wed, 23 Oct 2024 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662606; cv=none; b=FfSr0Ekg51/fttYMg9DdVHvOVIKfJagUQMeByQiqpBuCjoMN2MRxPVgd/1XbZRxWy+bKxFsTjHkS1dVGJTnpGt8++bFXB3eIMTkrzlJdA7QoGfZXcIDoaHeCxwzhnCp8+uMnUt6pnlg4ATvsjGLDukEplM0PchcPSB/5oFqLmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662606; c=relaxed/simple;
	bh=d/n2Vt+6hn2xix8vmY7xEn3YMJBlN8+MoI2zLkc2M9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQMK6DIkdoEwErWysiemvPDPZ2G2m53quQ5oAP6/IJZMeJqkqiMWtr9v17KpwRW2LhLPurBNMlY+WpcIVsjlfvGtOnT0ZkbrB95Nh8WfRhsEO3yMPGBUcrojYeqcvqRu/G4YSwEuI4QYw8hfEzyuoPskpjDSVQ3TWzqALTGBMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nzs/xrcu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T2PL3JN2OrnUN8GJGZRZUS5IzLSw/mh0EOvKuZwt5wQ=; b=Nzs/xrcuQU59EJfLJxyWzBdAeN
	pxX7DpRx1YLpXqn5Kz2mTGkq4S0Y0Xr3ETfcY06RV2r35hXipvEKlgSkE8Iy3rSHIrZ4/x+2VwXj9
	oAFEI5ghxjGd7r+GPnhti/4+m5AjvF0SaGAgoKfgy9LECP3KJwP8MssIpEcfcI+lmzyanf5eZ1vNd
	SR/2Td6jus6Gv57guKDulmtUh9rUYMjfcOs3H/TohOTcEzu+pPcsUnUxd/OHGXaiLZSXg7O11d79b
	SbOY+msR7o/odfsnBla/PnSkCDeQOckXDHvaaBFBxr+lsKllHSOvyOy0eOBeF0IgszLX2YIgBTwob
	LfJzfMeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3UFw-0000000D6VQ-2H6c;
	Wed, 23 Oct 2024 05:50:04 +0000
Date: Tue, 22 Oct 2024 22:50:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxiOjBRdO6EMAY4H@infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxdyYjzxSktk34Zz@sashalap>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 22, 2024 at 05:37:38AM -0400, Sasha Levin wrote:
> We could add a report for the above, but:
> 
> 1. Linus consistently pulls patches that haven't seen the light of day.
> 2. Linus explicitly objected to making a linux-next a must have.
> 
> So unless these results would be actually used, what's the point in
> writing all of that?

Yes, without Linus caring we're not going to get our process worked out.
Not sure how a tree that probably won't have much better latency than
linux-next is going to fix that, though.


