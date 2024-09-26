Return-Path: <linux-kernel+bounces-340672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A852987679
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529D81F26F28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5B156C73;
	Thu, 26 Sep 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hseXYLKY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC313B5B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364369; cv=none; b=ZCrPRIzbGYWlCQjXGAumG2sj2VdfigQpTa9jqAYJ70ntdi+qD3TUKee/vOzXZdWmL5x1D4wfX/76dG+FYz9qASjmeyhn3v3SrWHNJNHnQEvhRD8ifIro76ABLGr5Ve30uuRSbkriRfcKo6jO5z2dIXb+QE4SKvOGTjDvq8IcuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364369; c=relaxed/simple;
	bh=8CKMsEFdjCKMOgDz8o9NjEloxFEc0Lu3sR7G+gUxs1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHV0Clwi+mOY3s8BWu1Kb7/ACJ/p3+WZq9RJlQijDs+Zbc20FrsHSFPFKkoC7qOLSQebIpoLk8p18PLydQ761ZiMqt93i4nBpXgWmlZIHC7/UCnw7/oiwUPbnoVEa+rQWLMRSAIEhzptmiGcDUOVJxo6O1nhZt/ff09cQ7fpYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hseXYLKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196C4C4CEC6;
	Thu, 26 Sep 2024 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727364369;
	bh=8CKMsEFdjCKMOgDz8o9NjEloxFEc0Lu3sR7G+gUxs1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hseXYLKYZFojVQt6yvgkNk550/l7jDyAVzFhDrt1eKoYnROV9VbKxM9j2J35AtpF+
	 Uv8dOLDgqmGU3MH218rM+FOeK8bIuzjV2sWE94PRfSgA3zT6uDQ1C2CQJceAivSNAl
	 EHblzh/+TeXmUH8ZAWLd23VsxALDacYOoaYfaLb9E+SbnPs2dYmpCQ6hEbpEdxVVVE
	 twIUp3Ir7rnk8kVbsRHu6Vi3mvXTR0PdzmyTne0CEnT4yYbTSPoorAYLGynnr5Et0V
	 JNvIAHkKoK9Y3wn9EWznfUewiXwIsKdkGmBi9kax+er7mAI6D5VBoI+Mtz6O/xu7Bi
	 RbD8JyahzuDgQ==
Date: Thu, 26 Sep 2024 17:26:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 2/4] sched/isolation: Make "isolcpus=nohz" equivalent
 to "nohz_full"
Message-ID: <ZvV9D-aZ3bKd3cmK@localhost.localdomain>
References: <20240921190720.106195-1-longman@redhat.com>
 <20240921190720.106195-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921190720.106195-3-longman@redhat.com>

Le Sat, Sep 21, 2024 at 03:07:18PM -0400, Waiman Long a écrit :
> The "isolcpus=nohz" boot parameter and flag were used to disable tick
> when running a single task.  Nowsdays, this "nohz" flag is seldomly used
> as it is included as part of the "nohz_full" parameter.  Extend this
> flag to cover other kernel noises disabled by the "nohz_full" parameter
> to make them equivalent. This also eliminates the need to use both the
> "isolcpus" and the "nohz_full" parameters to fully isolated a given
> set of CPUs.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

