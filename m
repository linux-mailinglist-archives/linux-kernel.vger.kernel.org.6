Return-Path: <linux-kernel+bounces-375740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E696B9A9A38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068951C21238
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90146145A19;
	Tue, 22 Oct 2024 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dMBk1o9s"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC0C8FE;
	Tue, 22 Oct 2024 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579717; cv=none; b=Wsm2XM+7NRfoJLAkNxVKtH9Se5wpTYAVBXJMV4/2hyS4i4gDoEIWFcDH6Tg+bXH7Zm4Ums/ptpchCeGHW/aH7b2DBDXHqSXtPfjE0ElljclhKjXTpYOdJMZpsuCvvSnfoxf+ZERuFjcJRlTXnPWkbOi4eCC13AzqPiqeCPl/qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579717; c=relaxed/simple;
	bh=v4Pn30n3gbCI/ekr3UiSt2uBdJPfTaiva2V8mh8TzSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8GfCYlVz0rhBso7uvoiRIMMAViA+Ae+FNtx/SDVc097VbPfGTKTaCiECGdnY577/sJgD+xS9coKJTzeoQNI60E1YvYH7GXEToRJ2gzdQf2WeXwwo5XsExtLPHuT6EHtoaX4TbXF6Q/fjvkYaDFijo9Z1TeDK6GwaAEiDxZbOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dMBk1o9s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OGeAcum0O5iLJmsWuzSw/XxgU1ysQE6PoSfFkLPPEx0=; b=dMBk1o9sU8/NYWzwq5LmYinfq0
	MW8uVEKty6TJtgO+2YgucBZSBiilHu1rualTO2vowxhp23Z8h9ytjjpD3Q+7SvbjOC99Ls42HHV3h
	7XFL17w6Y1RLaAH/0EtJLABSK1BTLUejzLNJr3t7GyL3dg6dHS+PnMIoiz+1rYhDufXCDjS0ZNzbX
	2/CoHN5n/zgok2t/g7Ms5P4Eco7Bn45+P3CKJ083gU1N0pUK0IXTli+B0zE0JTVLkYH1pwFDAuUlP
	EferR7FwJ9xVDoksz6HkTNSnfdrkEAzxzJkndqt5hip6xoFx6h/tYEXKizhNNIQEBwXzMVZCdvwI2
	q7BNiHuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t38h0-00000009s92-3fDa;
	Tue, 22 Oct 2024 06:48:34 +0000
Date: Mon, 21 Oct 2024 23:48:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxdKwtTd7LvpieLK@infradead.org>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> >	1. Composed of pull requests sent directly to Linus
> >
> >	2. Contains branches destined for imminent inclusion by Linus
> 
> But this means hours or a day or 2 at most.

Yeah.

> 
> >	3. Higher code quality expectation (these are pull requests that
> >	maintainers expect Linus to pull)
> 
> Are people putting things in linux-next that they don't expect to send to Linus? That seems like the greater problem.

They shouldn't.  If they do we do indeed have a problem.

> >	4. Continuous tree (not daily tags like in linux-next),
> >	facilitating easier bisection
> 
> I'm not sure how useful that is given the very small time window to find bugs.

Same.

> >The linus-next tree aims to provide a more stable and testable
> >integration point compared to linux-next,
> 
> Why not just use linux-next? I don't understand how this is any
> different except that it provides very little time to do testing and
> will need manual conflict resolutions that have already been done in
> linux-next.

Exactly!

> How about this, instead: no one sends -rc1 PRs to Linus that didn't go
> through -next. Just have a bot that replies to all PRs with a health
> check, and Linus can pull it if he thinks it looks good. 

Not just -rc1, otherwise agreed.

> For example, for a given PR, the bot can report:
> 
> - Were the patches CCed to a mailing list?
> - A histogram of how long the patches were in next (to show bake times)
> - Are any patches associated with test failures? (0day and many other
> CIs are already running tests against -next; parse those reports)
> 
> We could have a real pre-submit checker! :)

That would be very useful.  Items 1 and 2 should be trivial, 3 would
require a bit of work but would still be very useful.


