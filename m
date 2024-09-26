Return-Path: <linux-kernel+bounces-340679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E057987689
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEFF1F26DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD58A1459F6;
	Thu, 26 Sep 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoJOFzXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEC4D8C8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364813; cv=none; b=UgWWpCGo76LWU31tqm+Gwpsc/kBxEWqfMxD2fU9MhYokCpeOW6dHgfCTla2f5+aM2P4xcBXHY2FCBmgNDj0Zx6A2+1zNfu6BOG37lDnxJszTVjr/SIrgTEZPO6orQB+AwDCx6lzluyrRm5Ix8oXS1qMzFlVfiuFyXjxmD+w7vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364813; c=relaxed/simple;
	bh=FoutegY6W60lqMf1r5yJ5ozY5nx1SKBj4vqnXfKqYiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai6Fy6+uL1oscfuaTyk9iP52nN/ghaZWFUiimpChHmBaETB/l7Mb0uCkegjhL/m6eiUQi5nYxLbtpkS5ALy8oX423EpV3hu4HETmb5Bo51E/02Wl/yob9okjb9KY2wbFcEai9nrR6pjmUueDzxzZgIF5lDD7PXbQiygequvZJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoJOFzXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52245C4CEC5;
	Thu, 26 Sep 2024 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727364812;
	bh=FoutegY6W60lqMf1r5yJ5ozY5nx1SKBj4vqnXfKqYiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoJOFzXcneIdeFrJv+NmkGHDYs1jU+nVmFwOXhDuZNVbGA6W/Ej2MKNiuuJ74xi28
	 X0K1otXpU/Agk4b61Nj+WdpiSGw76BWu+0zYmQLyO4koDaL+Naq0i4oZ1eSie27/1I
	 dlgiins6JM5HZLxM/mgO+hUfXcW9yge7yOn0ubpeULHRYS3Hom1Q3MKFNHw/nYyQm0
	 DMrWTYzEloQoXEl5hdqA/vm/g0rfAWrKinubupmKBzxhUgnFrUjegIuvztYOAcIfI+
	 1yLUp6/LuwtG+o0pcqhigxek4NGf72gLlczsfJ4t6L/bncWib7aUmFxDvFUW5HYvUA
	 hmo4L1h2WN8tQ==
Date: Thu, 26 Sep 2024 17:33:30 +0200
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
Subject: Re: [PATCH v4 4/4] sched: Unify HK_TYPE_{TIMER|TICK|MISC} to
 HK_TYPE_KERNEL_NOISE
Message-ID: <ZvV-ykjU95R9v8Eo@localhost.localdomain>
References: <20240921190720.106195-1-longman@redhat.com>
 <20240921190720.106195-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921190720.106195-5-longman@redhat.com>

Le Sat, Sep 21, 2024 at 03:07:20PM -0400, Waiman Long a écrit :
> As all the non-domain and non-managed_irq housekeeping types have been
> unified to HK_TYPE_KERNEL_NOISE, replace all these references in the
> scheduler to use HK_TYPE_KERNEL_NOISE.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

