Return-Path: <linux-kernel+bounces-376870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A39AB6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9336B245E3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957F1CBEBB;
	Tue, 22 Oct 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAL+lD6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09C1CB523;
	Tue, 22 Oct 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625585; cv=none; b=fUbjbqw7NBB7KNbSKSSCGT10po3G7XFuDbsYN7czNasWFYxImeX6JnVjyZxaNRRHY8VvsPlQUKGmkjStAMraDzJGH7kgdJ5YF0NdWggbgFVeQsD6Ada27voC5Fcy3Wa5MDArqzoMyqtstef4uDK7KSPEHcFMay0ZRUx0IgvUwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625585; c=relaxed/simple;
	bh=a4DgBiIqe9Fs7Zr5cW4NA4hQC4B2qUq17gqU8pINsjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRJ4KgTJDL5NLB1RBNYObyzP/a3CjmSprLUYg98wO0pU905he8vxZQUi0a9ACzetOP7oCe/s3CXwpIYoCL05K8E7Rl/p4IvR1xSTIJS8i2sTQSgjaJ651duEYnb1nGZx4AEeKx/UQ7zIs9/8wNy7LnYsxhP3CSH9aJOdEOnnaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAL+lD6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE7C4CEC3;
	Tue, 22 Oct 2024 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729625584;
	bh=a4DgBiIqe9Fs7Zr5cW4NA4hQC4B2qUq17gqU8pINsjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAL+lD6aCu6tPVamnUvDC0bW1LK6h3ab+Ung2Y2YWTvMUnlLUZq1YRhBTCifBM6/b
	 bcWpKUYLKirT46Cy5joqmkgMs94tl5oQhCiJOyYUgLUv2hkUuGYBt3Z4JEZUuSI3Is
	 +ha/EbuWWcR26A+jxDZbYlGlB25o09qYFlx/pLni5cxkhbzs9LJeXb1N/p72WJqNgN
	 wplW2Eruq3ADmWg9h3g6e6Qv5r2FvfkU8Zq8OtLCfQ/1ewjGvBkS8lkFFl6gTdLwvN
	 7IOoELsEE2g5c0SxgtyeYqpfeFSTV7/pRscr2TNGfTpnECM49qvAJamVf3Y0pWYRSi
	 QLD9fSPVE8j5g==
Date: Tue, 22 Oct 2024 12:33:00 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <202410221231.55C03584@keescook>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041243.7f2e53ad@rorschach.local.home>

On Tue, Oct 22, 2024 at 04:12:43AM -0400, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 23:48:34 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > How about this, instead: no one sends -rc1 PRs to Linus that didn't go
> > > through -next. Just have a bot that replies to all PRs with a health
> > > check, and Linus can pull it if he thinks it looks good.   
> > 
> > Not just -rc1, otherwise agreed.
> 
> You mean have everything go into linux-next before going to Linus after -rc1?

It seems like the most useful signal would be for the initial PR for the
merge window. After that it becomes a lot of fixes that didn't get tons
of soak time in -next, etc.

-- 
Kees Cook

