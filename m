Return-Path: <linux-kernel+bounces-376195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8129AA163
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5278D1C22342
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CAC45026;
	Tue, 22 Oct 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MLesC5Oy";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IA0N0glH"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597A19AD94
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597868; cv=none; b=gJzJKEig1SMYWUtGHcY5nq+HoHh09NjWIrcBSryb9fdPOP5A8dKC0TpsKJo6ubM/qvvj/7df1agkYqfuK5X6ebnLqdnjy6frW3LJdSFJ87hmJTkPldnSpV1HIxPNZiYF9qQXk0c9tcfXciyDMDJOidUgdVl4vcZX+R5MdBdJars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597868; c=relaxed/simple;
	bh=+JmY5aroUpTHnfouqw30ucA6jG2HNk7WVTwD7G37o/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqwDOyqjzcEy5Kis07NL12gP80RN69o0E9IECXJF8Tnf/sQdESbko69LAY35qd63T9M2ApEBaS3RULf5PDhsMQ6Y/UBdcbaO8TPto9d8EB1XpRwHnGzteI+8xijJbvzIdM3SacuLSm/hSfnCN3Zb34ysA2wRSrYurBM0ujGLnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=MLesC5Oy; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IA0N0glH; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729597866;
	bh=+JmY5aroUpTHnfouqw30ucA6jG2HNk7WVTwD7G37o/M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MLesC5OygRhMBCKtJ/meZypggNAlHNDiD8D/6IeujHZQ5SZ1O66Q2kQUdiJCEt/eH
	 /UPv3MxIQDAFOcnF8ifdb/3caVmdCwsyhSW8jithcaufcgXlGNFrhsOrGu5QIgu+sq
	 eteFFSbuqA6h9U9d3ssho/zbHkt/GCFhh6NG8LGE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 174E01285CB9;
	Tue, 22 Oct 2024 07:51:06 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HPZybbUFZbvQ; Tue, 22 Oct 2024 07:51:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729597865;
	bh=+JmY5aroUpTHnfouqw30ucA6jG2HNk7WVTwD7G37o/M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IA0N0glHd3piZDHgHjolNdiHRHfZqzJrWJC2UgTcrZElBf97Cq1GZB1yDDvJi5ZHd
	 DLy+pGr3gUvzrIrZZqahB4RrVtJcr5s/D0M2R8plqqijxuxaQO82tT3+mVqA8P0ps1
	 8KSVV0sPaUsqaECaa1GVwzZ6uE1DDShdkm+b6U1w=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0E1371281A31;
	Tue, 22 Oct 2024 07:51:04 -0400 (EDT)
Message-ID: <a4d7222ddb039a03a337fcfb047f5e804bc541d4.camel@HansenPartnership.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig
 <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Sasha Levin <sashal@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 07:51:03 -0400
In-Reply-To: <20241022041243.7f2e53ad@rorschach.local.home>
References: <ZxZ8MStt4e8JXeJb@sashalap>
	 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
	 <ZxdKwtTd7LvpieLK@infradead.org>
	 <20241022041243.7f2e53ad@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-10-22 at 04:12 -0400, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 23:48:34 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > How about this, instead: no one sends -rc1 PRs to Linus that
> > > didn't go through -next. Just have a bot that replies to all PRs
> > > with a health check, and Linus can pull it if he thinks it looks
> > > good.   
> > 
> > Not just -rc1, otherwise agreed.
> 
> You mean have everything go into linux-next before going to Linus
> after -rc1?

I think that's a good goal, yes.  Most developers tend to send a fixes
pull around once a week (or less) after the merge window, which means
it could be soaked in -next.

> I'm one that doesn't do this. That's because my code in linux-next
> after -rc1 is for the next merge window, and the code I send to Linus
> is only fixes for code I sent before -rc1. I tend to keep an "urgent"
> and "core" branch. My "core" branch is everything I plan to send in
> the next merge window and goes into linux-next (via being pulled into
> my for-next branch). After I send my pull request to Linus, and he
> pulls it in the merge window, that "core" branch becomes my "urgent"
> branch.
> 
> But when I find a bug that's in Linus's tree, I put the fix on top of
> "urgent", run it through my test suite (takes 8 hours or so), then
> send a pull request to Linus. My "urgent" branch doesn't go into
> linux-next as it doesn't have changes that should affect others work,
> which is what I think linux-next is mostly for.

That's not necessarily a safe assumption.  The reason we put scsi-fixes
into -next is precisely to pick up if this happens.  I admit it happens
very rarely because of the compact and local nature of the fixes, but
the signal rate isn't zero.

>  I also find known bugs in Linus's tree to be high priority to be
> fixed (I stop what I'm doing to get the fix out ASAP).
> 
> Now, if there was better testing from linux-next, maybe it would be
> worth the time to push my urgent branch there for a bit. But so far I
> haven't seen the benefit of doing that.

It does at least get 0day running over it, although that can also be
configured for your branches separately as well.  It's also not unwise
to have some pause time before fixing and sending ... the fix you first
thought of isn't always the best one (or even sometimes an actual fix).

Regards,

James


