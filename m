Return-Path: <linux-kernel+bounces-379564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686439AE08A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A97B22D71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF81B4F24;
	Thu, 24 Oct 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4pU1CwVb"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D51B3929;
	Thu, 24 Oct 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761901; cv=none; b=Y6xEL1fixgkFbNfvdRxnft77simwa2HrxjLZjLdSWf7eHqZWcckzD1fQAW/fCe5Ydwy1B9zty+Ld6SCkOyKScPHJNGxecFrzXRBvUbN9Ha2tRwwxO4pE4ICq+bPfe8Z4ho9KodHb+keARvDLglvnfmR3RNW+EoWky3/9HkpZQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761901; c=relaxed/simple;
	bh=V2bqIBJBKNZHpaj9S1oaX/7xeY4aOrtvjdJfPa7IcrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqujFIiQoQssXKXyIWTyFlsD66I9wWzhfGBvcmKiVkstLNEtsSFEUxYy4JLGBhiPR76taFRZYehyfWV7o5LRZ6NEbSWYbe60WQlsZ7DO3abJeUkpb4nfUbscpAgZRhtDxqhWkD4CAsFVsgfCDP0mlfaJTNyGTgxWHBtEyfomPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4pU1CwVb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q7b3zRo7F5ZGBsioig3luyDrMko+mehs3AE6yBCh0dg=; b=4pU1CwVbQfr+woX2Lwf1BhwZuz
	dSw541s2AYUXdvfpwcj5003w2M6/uUFsHr05d3TKj0HUdqGo9Xexo+15WPJfIUZyQUHsEIjNtLJlZ
	VQxDonn7ilYCY8cVcs6gglrtOnn2nLb0PLhzsBi6g9oFfrMPrXxgsxjgqH9qIPkdwz7AhrVl/BKaW
	2kr2nCiSoXtkw+nL+jJedkNJbsHc7z++zqj6v/Nlf52HN7Cfgsr8YqMmqJC7Q6UAmWhzybC5IPb9X
	FX5XR6Rc9L8jpNw0wauLFo+BgGVRTRR72b7W4k3Yy4WVpKCLr0tQ6F+z/60xQ1i2lE1wYnIldTWNn
	V4HlPhRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3u5N-0000000HRWY-1bKn;
	Thu, 24 Oct 2024 09:24:53 +0000
Date: Thu, 24 Oct 2024 02:24:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxoSZQSw0z6AdgaU@infradead.org>
References: <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
 <20241024052139.2cf7397f@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024052139.2cf7397f@rorschach.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 24, 2024 at 05:21:39AM -0400, Steven Rostedt wrote:
> them as small as possible. That's not always the case, so maybe I could
> push it. But it will change my workflow quite a bit or burden Stephen
> with broken branches.
> 
> I'm still not convinced it's worth it.
> 
> We are not talking about new development code. We are talking about bug
> fixes for code that is in Linus's tree. The zero day bot and my tests
> appear to find most issues. Bugs that happened on my fixes patches are
> usually other use cases. For instance, cpu hotplug while tracing from
> rtla. That's not coverage I get from linux-next.

Seriously, just add your damn fixes tree to linux-next.  If your fixes
are as perfect as you claim that one time setup is all you need to do,
and you have less work than you spent arguing on this thread already.

If it catches bugs eventually you will need to do more work, but save
others from deadling with your regression.  There is no downside for
you.


