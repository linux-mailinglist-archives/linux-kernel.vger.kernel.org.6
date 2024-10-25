Return-Path: <linux-kernel+bounces-380820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC69AF691
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBBC7283292
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82C1DA26;
	Fri, 25 Oct 2024 01:17:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28E4C81;
	Fri, 25 Oct 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819053; cv=none; b=VExyPzkRrY9wYtaVe7l1yThsjs9z/vINnyhJLCG/BcoIAI3Nv5bnhoVlhEslsACRyWpooZIld087y1tIjyR3VuQxznB7OFP6H8lRq0azp4nPJIaZWz8yyPBKfAW+n+soe9rYJ+Uzfvsyo7s3gPWdXVOlTFGCzbiRUM5tlnSRpdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819053; c=relaxed/simple;
	bh=A4OHkC/Gy6/+k6+8VPRKb67Rjjjo9qvTamzKGDikBuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alNjE56fjts7PVy3ZJMdibdpc526CKbq9XQvT0PXj9vPMa8l5YOPMZfPb76ga3G7Pf1TMFuXQISK6kYsUbdZOWed1j3u76oKayQI4iMYWQyCAqmifWYlZ2D1D3EFRKajNWmyXyyzJu7sNG4UnY6n0yuG1mCFjbtH76sfaLgmei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFB9C4CEC7;
	Fri, 25 Oct 2024 01:17:31 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:17:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Michael Ellerman
 <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Christoph
 Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, Sasha Levin
 <sashal@kernel.org>, torvalds@linux-foundation.org,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <20241024211728.0e2304fd@rorschach.local.home>
In-Reply-To: <ZxqJj9IZ2GF3IStb@bombadil.infradead.org>
References: <ZxdKwtTd7LvpieLK@infradead.org>
	<20241022041243.7f2e53ad@rorschach.local.home>
	<ZxiN3aINYI4u8pRx@infradead.org>
	<20241023042004.405056f5@rorschach.local.home>
	<CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
	<20241023051914.7f8cf758@rorschach.local.home>
	<8734km2lt7.fsf@mail.lhotse>
	<20241024010103.238ef40b@rorschach.local.home>
	<07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
	<20241024024928.6fb9d892@rorschach.local.home>
	<ZxqJj9IZ2GF3IStb@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 10:53:19 -0700
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Thu, Oct 24, 2024 at 02:49:28AM -0400, Steven Rostedt wrote:
> > Now I have to ask. What's the benefit of pushing to linux-next over
> > waiting for the zero-day bot?  
> 
> 0-day only does build tests by default, there are many places which have
> actual run time tests which *run* off of linux-next, those are both bots
> and human. Granted you can get your own run time tests out of your own
> branches but that's on each developer to set up and a developer's test
> exposure of just one branch is small compared to linux-next. For example
> I've seen obscure bugs creep up on linux-next for modules which only some
> odd arch or setup was able to capture before which no test we had during
> development was able to capture. So more exposure to system variability
> and test variability.

I have a test suite that takes 8 to 13 hours to run (depending on how
many commits I'm testing) that I run before sending to Linus or linux-next.

> 
> The other benefit is you get to see *way ahead of time* possible merge
> conflicts, and if you can coordinate with the respective maintainers
> which your code conflicts with, you can prepare so that this is smooth
> sailing upon pull request to Linus.
> 

Remember, this is talking about fixes after -rc1 not for things heading
to the merge window. I find linux-next extremely useful for that work.
But for fixes, what benefit is it to push to linux-next before sending
to Linus a fix that adds a missing mutex_unlock() in the error path?

-- Steve

