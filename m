Return-Path: <linux-kernel+bounces-541660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BFA4BFD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C693A6703
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F33920E333;
	Mon,  3 Mar 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FG/iMPId"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34D1FAC4F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003233; cv=none; b=twFtz5d0nCXyazl6dQZ4+PW/5A9e6nDaSnISCSJ/efIgU9XCwmH//6saAnrtiF4+ERTAurl94JBQiKzbKoTY9nVk135Ijdjn/kMoDjxB71X3iPy7TGyLOIlzHfFjFAdoWwGbDJHj4315kM6DwMGayEauemTNTwT8d2GA23PdHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003233; c=relaxed/simple;
	bh=4vnIdIC3/tXXBoqJqE/x9dY1Cli4pumikDQThNCvf3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/wuCFe3S0cPHcT7pPrWc1YZw6auxRdA1kGtNh24RIqipziadBRULMwcDRQONwGj9/bBPVs6ERUrsnxbLXjGUUFTaW2M8CF6Zflxg7bdrCMYax0vkA0q5OTqK96vbbwGt4PnZSBm8tMSCA+k6o1a1hJnHfUpkvBu1xru7LpP6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FG/iMPId; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1nf4vuB++QQrN1aNpb661Gdb8G27vcqCTg2OPjJYzl0=; b=FG/iMPId7dhtXZyawOqhqru92M
	Vg+E53IUMK3wFUYDjTkzvUIpbcJzat5ADGWA8Sc2bNE8wuwVgBjOVY1rzhhX0WfSDda+nkhVTAUNo
	7u7jEJtiB3FbRQVzlQ+58tHa8kY73jiiFbPgcf5Xco/e5xpqTZRpRlC3Tw40K9MdZxyWOvobGi8zB
	q5U80jyUKntcKcOME40rfTgIZyir25P8FlLLYbl0X7t5ykbnVOw1xTQcenZSiP+mlWfCLhx8qyzNt
	yZKTEguZxzti0YVXpm84A6QY98pxaqzV42M+M6L3hTQWlLzxjfpeKCGiGJw1NwBdlKNTO0l4A6qa/
	QJSJ8tnA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tp4T8-0000000BadK-1qGj;
	Mon, 03 Mar 2025 12:00:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84B4230049D; Mon,  3 Mar 2025 13:00:21 +0100 (CET)
Date: Mon, 3 Mar 2025 13:00:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vincent.guittot@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH V2 0/3] sched/fair: Fix nr-running vs delayed-dequeue
Message-ID: <20250303120021.GA11590@noisy.programming.kicks-ass.net>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>

On Mon, Mar 03, 2025 at 06:52:38PM +0800, Xuewen Yan wrote:
> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> lag has elapsed. As a result, it stays also visible in rq->nr_running.
> However, sometimes when using nr-running, we should not consider
> sched-delayed tasks.
> This serie fixes those by adding a helper function which return the
> number of sched-delayed tasks. And when we should get the real runnable
> tasks, we sub the nr-delayed tasks.
> 

Is there an actual performance improvement? Because when a runqueue
looses competition, delayed tasks very quickly dissipate.

