Return-Path: <linux-kernel+bounces-424517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CC9DB535
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E71282833
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253C191F79;
	Thu, 28 Nov 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o66XLKFs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979C84E1C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788239; cv=none; b=CpRp5LX7yJpCZ2H9PZxrcjvc5oOU16yn4tFSfWTUBtUnz12ktlSI3+zhW2gBD+iVogt5cdvgZSfNCYYyyDiFbxWszuvr7qUzbuR8VK7bxjyh+n4oFDJ+lqJXBkb9bK3RDMIn2LVUU1KbHXP3vUCXyw1uXfZz5QoAM2RKDA43Gcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788239; c=relaxed/simple;
	bh=i3zKEdcNdnHsGuXqihiHbAd8ZLpjA3IgVI//cbeoNww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxsAFRVwjf0Rpt4OqFH5U8lGcKbitOoSLmI/HgiAQa6XO23MkUSv/pdIpbK5F8PD8yCJ2rkfoZmRqyLkMmvjX4+63aSfbImulBvgc5aBX7G2gNsQYcoEHblekBJLAKOVcATLhPOHYpbHWCPjFsez68SwLLWl2ngtbrMR383VipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o66XLKFs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cAWH7TJ/SE/rLcXm/WyYVMkfcOhFnCWGLIUAwZRnL8Y=; b=o66XLKFs66yKZ4oy4dJdiGrZ/V
	IyHzp3aH9cCMk7q7yfH2bivOykNdb9XEDgOUdCQvDN5xOMcINTskv31m3hnmhlJAMAHUaU2FkiFq8
	kG4yLIaLtrTRkAwCMggJZQIxIw4Pz21rf94hDczxH6kiySh1BlgbgqqZeSjStisR4vjwPHka5psd7
	6PDRDYb6hJn/kgl3I5vPwRSCjZAHUf6of3KQru4yqKiyqTZiQYJbF+7InaburFNC/3SM/mIOZDgfu
	PkVTJIkbw4gls2E6halFpvWimxuD8FUFSDwWvZa0DwmOei5wOuvjuhZllL7kAz7lu4cgVToUGbRcP
	dxxawcOg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGbNF-00000001aIk-0Pmo;
	Thu, 28 Nov 2024 10:03:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75010300271; Thu, 28 Nov 2024 11:03:48 +0100 (CET)
Date: Thu, 28 Nov 2024 11:03:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 6/9] sched/fair: Removed unsued cfs_rq.h_nr_delayed
Message-ID: <20241128100348.GC24400@noisy.programming.kicks-ass.net>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-7-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128092750.2541735-7-vincent.guittot@linaro.org>

On Thu, Nov 28, 2024 at 10:27:47AM +0100, Vincent Guittot wrote:
> h_nr_delayed is not used anymore. We now have
> - h_nr_running which tracks tasks ready to run
> - h_nr_enqueued which tracks enqueued tasks either ready to run or delayed
>   dequeue

Oh, now I see where you're going.

Let me read the lot again, because this sure as hell was a confusing
swizzle.

