Return-Path: <linux-kernel+bounces-402233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B99C254B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71CD284310
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42762233D88;
	Fri,  8 Nov 2024 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atUA5kVz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FC1AA1CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092511; cv=none; b=GcGoBiM/9oNKq1eVplyUvXUlL2hFmHi3arErjK/Ca03xpHDP1B74N57MOAIdVYD6fa31ocfqTAvwlyHC81JhpZ8O3soV2q7qSBQzZr2HNebI3dnnMbE5w25bGAE6JJ+oFYqM/nSusrYv227WkY29xT4pyTb1IB5j+1Bzi0bAAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092511; c=relaxed/simple;
	bh=1RrxzrubZi0A7yUUznbJoZiOCaxffMkkIl+KrTGTeeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnZ1+7evn0B3dAX8TI9MA/O3HN/iDHy1PfjDeFb/I74LiXyywv7/HtyBxsn37G2sTQMeWSZXuDh4pkKgUJlxqHCoRu+Y7GTC2bAgm5lAufV5SuFQhFWqCRzficqb+YL5ivN9lVStRGSsaFqMUcyf3Er4nKfEzwlhbFDCm3iexEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atUA5kVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFCC4CECD;
	Fri,  8 Nov 2024 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731092511;
	bh=1RrxzrubZi0A7yUUznbJoZiOCaxffMkkIl+KrTGTeeQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=atUA5kVzLxI/KkTe/VOrdeR+Ct0ijyN5nNkBwQmgMbypyi6kGAk+Rn6wrfrLo967c
	 LxB4IJzm6LH9lPQgP3X/DVpaiTwoUvH3MX16c1U0YZ1ZpcP76gOhibPy9x0klrAsS6
	 fDgYmngq4G1Gi8I1wCzRbTALZC06e8uCFXUZlDzrJQc3+Flk97aKa7jaXWSiDtAxRs
	 IOY9HU2jsdW40MdVSQrA/6IuOQi73F2JtkaIsSwZx6oh14jj1QLUh/26d0VOrWovRY
	 Ql0+RWeIrEm/nmQqKpPfAE5WCMJ6AWp33cbQTaPPtzGTivQ0vAZFmAauqAjJBjWdZx
	 jTvGyvDxOqWzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5DEBCE09E4; Fri,  8 Nov 2024 11:01:50 -0800 (PST)
Date: Fri, 8 Nov 2024 11:01:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	cl@linux.com, iamjoonsoo.kim@lge.com, longman@redhat.com,
	penberg@kernel.org, rientjes@google.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/4] scftorture: Avoid kfree from IRQ context.
Message-ID: <8c55831f-ca63-4ee5-9351-b8921562a35a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
 <Zy5OX5Wy0LsFPdjO@Boquns-Mac-mini.local>
 <18b237cf-d510-49bf-b21b-78f9cebd1e3d@paulmck-laptop>
 <20241108184510.O8w42_-e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108184510.O8w42_-e@linutronix.de>

On Fri, Nov 08, 2024 at 07:45:10PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-08 10:33:29 [-0800], Paul E. McKenney wrote:
> > Sebastian, I am guessing that the Kconfig change exposing the bugs fixed
> > by your series is headed to mainline for the upcoming merge window?
> 
> Yes. It is in tip/locking/core.
> 
> > If so, I should of course push these in as well.
> 
> That would be nice ;)

Very well, I have started testing and if that goes well (as I expect
that it will), I will rebase them and put them into -next.

							Thanx, Paul

