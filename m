Return-Path: <linux-kernel+bounces-418432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E1B9D617E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D5D28261F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4731514FE;
	Fri, 22 Nov 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BlxwRA2E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35260890
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290181; cv=none; b=Jdl9sS28uni3kHBf+DrRyVYyOWSdPmXDXldEBaKcLxT2oqB4K3n2BiRH758qIx9WcwQq+ALEBX4zLJfn7Rf01X3WoKqznt4EINOBTeLTOWMfOgF11DaHMGeI5cHfabh7FhUFZVCe4rhT39ja50ey+e9go1ZTXiX+irlZYy+TrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290181; c=relaxed/simple;
	bh=jtmfzGPszDdvV+y408JrBDnu/inX7FBBktOh+Pt++50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSivN0RWBiACAfv8RsKNCUiP/Hnse4qHJaWCjutV1+4QZr5EMealacbJFfzK+ObadRj8VILPLvCOeaivFeRiuyWLnln20LxfN5gTEymcMUeAC6FPhzI5MHpBTaXj1f001oJEoKrSn2aTtr5IFJImYjjbtpb88XtAJmG/eaJ0bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BlxwRA2E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jtmfzGPszDdvV+y408JrBDnu/inX7FBBktOh+Pt++50=; b=BlxwRA2EbghNnNVP3/SRGvtHJt
	OgQQZS2ISUll+QAWKFnvtni6IT23RHpdW5XAni2KYKn20gEC1dFOHsg2afzkJMQwb5MrPlVI2fOj6
	kI1mZh44F9M5VFQ7AsmLW0bdCLt5g3UgqmS3WWBgLayaJW/3+8yM62BG35q54+pxH7pO7ilraESyu
	uuVGrLU8vWR2lcX90YnNkh7uSrVzd45buKExu2pfuEqzAdFvEe4l86mQWOwKMbjKfhfES+NchYB82
	3NiexEV2xOsp3XQZBvly+AAPsmK5i4Phhu9Y5nbZTQuhKgEfhRmKxDnf+rFvx9343P5KKuxRYSghc
	PInDOOdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEVo4-00000007xf0-28mD;
	Fri, 22 Nov 2024 15:42:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 270A030066A; Fri, 22 Nov 2024 16:42:53 +0100 (CET)
Date: Fri, 22 Nov 2024 16:42:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: properly serialize the cfs_rq h_load
 calculation
Message-ID: <20241122154253.GZ24774@noisy.programming.kicks-ass.net>
References: <20241122152856.3533625-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122152856.3533625-1-neelx@suse.com>

On Fri, Nov 22, 2024 at 04:28:55PM +0100, Daniel Vacek wrote:
> Make sure the given cfs_rq's h_load is always correctly updated. This
> prevents a race between more CPUs eventually updating the same hierarchy
> of h_load_next return pointers.

Is there an actual problem observed?

