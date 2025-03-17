Return-Path: <linux-kernel+bounces-565123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C3A66160
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B94C1895CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4601F583E;
	Mon, 17 Mar 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEkhGB+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6D14885D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249817; cv=none; b=imSD8YCdg1Dma5pMSKMfTtVZ6lPqlwMcYxZaHaWnlJR5blBR2WGlnf/L5ThRrRH9UjQRoXsw3R1kDZ1q3guG6kUtZzYhKnwtZfAiamgXYOSp97m/Tu2l0ppq1TI222EbPCgmkhqddbc0fGkJ4KPXa9uhXi3+ECCB84BQqB/2rVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249817; c=relaxed/simple;
	bh=f6fC9smBEkW/u6Y+3GtorlrviGbeQUARyXTsS0LqDIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0zfUc/iuFCv/YFSKI9YqO8rfzpgMtrHG3SrkxX97hdXeerO+F2MEM55SnLQb6mshUIwmqSfGksZ6vRi4lsz/+vntzuGsFe+Rcrwhw/lHHGzdEt+m2uIc0AJuR3oR9EFx9nWg6zNGkatr7h0L6d3xF2H4KOE4xKx8Mv4Z54eRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEkhGB+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96DCC4CEE3;
	Mon, 17 Mar 2025 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742249817;
	bh=f6fC9smBEkW/u6Y+3GtorlrviGbeQUARyXTsS0LqDIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEkhGB+6Yf6sD42r47I/dZqxrTDaY9bpAP/V/OhFdAQM034E7zHZ431C3V+N8bNB1
	 yN0/3cSZbzftQgQlylsTHhVt1oBHoKz6V2rQnm3crcxTy/01T9dc3VbIYPg6cKS7Os
	 ZES1xRRmuKrgpD+I0PSQXzzI/hSIPrC3MttbldwcFN8AKodOdbXlg80cORGqKGpR++
	 +H2WqhcBsCBqq3GBzdGkuGv0eU58yzPqISls0VdfPKKjmW/ertI2J/YjUpXuejG2qi
	 5cN+BRHw2DE69lyU2W8WHadFpiW4VZVGqY6tg2LCZc5XCMKirfHfu9m2iv+oW88uLk
	 ixcgZKk5InPvQ==
Date: Mon, 17 Mar 2025 12:16:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <Z9ifV3UcLPNvBttF@slm.duckdns.org>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
 <20250317103101.GC34541@noisy.programming.kicks-ass.net>
 <Z9hUby9e1JYaE6iC@slm.duckdns.org>
 <20250317170602.GE6888@noisy.programming.kicks-ass.net>
 <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9e6300-113e-4a89-8fc3-2ae895c77794@nvidia.com>

Hello,

On Mon, Mar 17, 2025 at 10:48:16PM +0100, Joel Fernandes wrote:
...
> Just to clarify, Tejun is suggesting that in mixed mode, we boost EXT
> independent of FAIR. And in normal mode, we we boost both FAIR+EXT, because well
> - nothing would be running as fair anyway.
> 
> But what is the point of doing that, if we have boost EXT independent of FAIR
> anyway? We need that code _anyway_ due to mixed mode so it would not simplify
> anything.
> 
> Or did Tejun mean something else about "toggle the reservations"?

My understanding is that if we have both FAIR and EXT's DL servers reserving
execution time all the time, we'd be reserving execution time for something
which can't be active, so the only change necessary I think is just
retracting FAIR's or EXT's reservation whent we know they are not active
(ie. if EXT is not loaded or EXT is loaded in full-sys mode).

Thanks.

-- 
tejun

