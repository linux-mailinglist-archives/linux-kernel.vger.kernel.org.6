Return-Path: <linux-kernel+bounces-313017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30430969F11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0370B2130F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBCA6FBF;
	Tue,  3 Sep 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pz5c/qkW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03B15C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370300; cv=none; b=hYScaAnUxFmgtJMe9xxxDcZWhUCzKCMMDpv6VqJ9mXFmXfYsJu5bjlq/pBG2kNvP7T4kAbPUuI1qlSB542OQ9A9bDmtXSDpl/lYfkqBgSfXP5sWU9Ja/FuHaYKImwPXdKwS0EwsmJDsauRUyZyS9MdFUZg7nPFdE/mfh/EP3ZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370300; c=relaxed/simple;
	bh=WIPc17elWR6wpOm3CZoNk9P3NBR0+E6sXBCd4264BDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGQNs2tmhMH5SrShGYZf6mFi7RNoLUfVicHhYpRYZBqkYz4fuFf1kZMJ51RF3yCfjxDpaNDWSStarwrlOLjzQ1qHMx/DcAJlYdHmEsWoNl++vbwDvRdrsPt/QjgujwZffaHtP7+Di3bCW7qetggQ5Z7iGZmpzOSlxlx5HyvUcAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pz5c/qkW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jbrXImHY04BE5yIVzrOhDP6FyF/Wk8BHa1sV1Rre8Nc=; b=pz5c/qkWWWtwP8eNjxDX4ugX27
	cYKUkQ6H8Xkok5AkOT4DM89yWsIeOisaKOgdxTMBkV+sLTI8uod5XRuxtzpx52duutF/+WgXHDg3H
	u6lVXlpQXyusDvv8NVc8ee3bIROeaSLVPtuk1KH5Gr2zps6fSNGd0+rLxlTxFjp+iHKOm9q5nW9jc
	V6R7sl+v4dGaLHjxaOBvH7AH0CY/M3JVZ2xF9AnMW53l3Yuir4bjomIt+Q4W5VnrfCO0aRAzukwW1
	2YLg0zYQshdmfBdzybvoMJC7g3Aghx0NO27blhv1yYJkXiDE/2Mefrz0H/5iOTaiMSG1gAnTaKjru
	eMHU6uOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTd5-0000000CKoY-3SA5;
	Tue, 03 Sep 2024 13:31:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 76F7730050D; Tue,  3 Sep 2024 15:31:31 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:31:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: mingo@kernel.org, void@manifault.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	joelaf@google.com
Subject: Re: [PATCH 9/9] sched: Add pick_task(.core)
Message-ID: <20240903133131.GW4723@noisy.programming.kicks-ass.net>
References: <20240813222548.049744955@infradead.org>
 <20240813224016.471745809@infradead.org>
 <ZsZyq-_vUpruRHsR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZyq-_vUpruRHsR@slm.duckdns.org>

On Wed, Aug 21, 2024 at 01:05:15PM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Wed, Aug 14, 2024 at 12:25:57AM +0200, Peter Zijlstra wrote:
> > In order to distinguish between a regular vs a core pick_task()
> > invocation, add a boolean argument.
> > 
> > Notably SCX seems to need this, since its core pick
> 
> Tried converting scx to use the new interface and it looks like SCX doesn't
> need this either. With small behavior changes around ENQ_LAST and
> stopping/running, pick_task() can behave the same for regular and core-sched
> cases.

OK, dropped the last one.

> Everything else looks fine too. Once this patchset gets applied, I'll pull
> and update right away.

And the rest should now be in tip/sched/core

