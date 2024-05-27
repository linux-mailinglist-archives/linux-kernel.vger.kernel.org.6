Return-Path: <linux-kernel+bounces-190188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0C8CFAE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3D1F21A32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD743B1A2;
	Mon, 27 May 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cxA13MmJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4B3A1B6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797127; cv=none; b=bw4qao5CMdlxP4Nsjmg816egjtDPdJOAuXR5AVOdvSRqZthd4DEOqpKkPhywuDW02UdOE6EAXlV6PfhMmTX/7JJPTrMZt6VTrbV/b0F1rTjadT6fe2RiXl7JXl6Wd3xkQZrRqAYKtQfnjD2xx+vyO7XMZiHjlagbBkzn6tc+8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797127; c=relaxed/simple;
	bh=If4SlgCOYVTcYRXsJIvtk287xeqD/dWBiZgkLklzuFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgyYZ2FqYiW+zUjVx95Lb7V1gNorCTD7q9t48W86pOvLE3q4BrCOYG1grxPCVHFWMuuWWoguK+kFC5c7YPPcNbHbQI63oFUSEXVn/3c6m5d21kyt0GvR74hQFZ57rBh3XP81ace+w6/rBxpeD0UZu6LDs8MUNteMxAjwKb1fwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cxA13MmJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E61FcBkbssTLL2V3u7wGrL95bbJZg7QixKBGzobXpds=; b=cxA13MmJ3mgrYkRhM0O9Ye4fx1
	Lbsezn3U5gnMlLn5XZkCKa3x0g2kh6FnnPrI3VyqxHAkvhxtEO9Drq/OJ6zBiift7TaA+vCr9tqVe
	ixdWRmv2ctCjUdYnX2PedGWJTGrO1vg6gDlcZuxFKqe4ebyAuPYcQdfqkonkU6KEfZPAlJUMCC8oW
	LBwn+SwFu++8TR5FKa7iEnLb+v9OD6dUsx5+4cAyeivdatIkTBW4SqKzcnNpE0PdHRoWLDaN1zdue
	53KnRIgqsUwOyGpHQjh8z/tbBTmBTu7KNwi8F2UFbD9XG9GpOtvD9YjLhCE+nu3uFhJs/q0VU1jkb
	Ypn7bcgQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBVLu-0000000BC8A-1JBO;
	Mon, 27 May 2024 08:05:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 285AD3005B2; Mon, 27 May 2024 10:05:03 +0200 (CEST)
Date: Mon, 27 May 2024 10:05:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>, kprateek.nayak@amd.com
Cc: Chunxin Zang <spring.cxz@gmail.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, yu.c.chen@intel.com,
	yangchen11@lixiang.com, zhouchunhua@lixiang.com,
	zangchunxin@lixiang.com
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <20240527080503.GU22557@noisy.programming.kicks-ass.net>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>

On Sat, May 25, 2024 at 08:41:28AM +0200, Mike Galbraith wrote:

> -	if (pick_eevdf(cfs_rq) == pse)
> -		goto preempt;
> -
> -	return;
> +	if (pick_eevdf(cfs_rq) == se)
> +		return;

Right, this will preempt more.

This is probably going to make Prateek's case worse though. Then again,
I was already leaning to towards not making his stronger slice
protection default, because it simply hurts too much elsewhere.

Still, his observation that placing tasks can move V left which in turn
can cause the just scheduled in current non-eligible and cause
over-scheduling is valid -- just not sure what to do about it yet.

