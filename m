Return-Path: <linux-kernel+bounces-340666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87698766C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32E61F254FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E890613CFB6;
	Thu, 26 Sep 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiZi3lxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0E5672
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364245; cv=none; b=EjKgal5VCFOcSJM7z19A3O7o35+HDNkD24XRqUeSaG1GIq4QjnSLrsm6KECpLapPiLR1ont0MCgqipOcImJxk2QIzXSl85s2cMH5xejcd4+dBI8Zp9ZsPscegqHpWAWTUx9BiJD4p4bDDtOum1bms2N6v9KzJVo4kPsyEMYxKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364245; c=relaxed/simple;
	bh=ZPJcv2AyLcGg09AGT5nHx7hIATRyclXo+9nkNnRxLaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMcufUtAHBJ+vE3nFigKTJ3b+HUp3bn4IIGpbomzWy4MHisIVOyf4t/u0OMTirumrdr6Vcdy5L5nCi17uQROJCIujiUlW1It5ZCumHXaxjAYXHN9EkqWml6wi3YRKNzBTUL5LPulH0Yac1hkt0leB7iaTheN+Ht+OohZMIkb81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiZi3lxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947FCC4CEC5;
	Thu, 26 Sep 2024 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727364244;
	bh=ZPJcv2AyLcGg09AGT5nHx7hIATRyclXo+9nkNnRxLaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiZi3lxAZ6OIRAK8bEGuM1CGeS/MSMDd9PRWEUPmi5BESaOG9YZHJ6KOa0B3MGVMb
	 F6qv3E6flBroyltzri/LqxoI/Jb3njKUKmGVbX0e52szXMMeoQSWRtz8G5o8NDXJgp
	 fO3TytRQAXjZHu+8/2BK9AbgFlBmZa2xf5Q8+RTml4A9umWFHDEGJknRwDijJUrJKj
	 SWRINdAyBfgJi47dpydYX8g7zPfYnj30VBP8KSk1G5nGHBtqhqOor8Zv6vuWuW7JiB
	 /e2awNyXh9KBmhmDkdvs6IXNJJ+s+SD+kADXLgUC5t/mqp+7IXckxuiJIV9eSl/Nfw
	 4Xub7blJsWm3Q==
Date: Thu, 26 Sep 2024 17:24:02 +0200
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
Subject: Re: [PATCH v4 1/4] sched/core: Remove HK_TYPE_SCHED
Message-ID: <ZvV8kqdrRpsW64MA@localhost.localdomain>
References: <20240921190720.106195-1-longman@redhat.com>
 <20240921190720.106195-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240921190720.106195-2-longman@redhat.com>

Le Sat, Sep 21, 2024 at 03:07:17PM -0400, Waiman Long a écrit :
> The HK_TYPE_SCHED housekeeping type is defined but not set anywhere. So
> any code that try to use HK_TYPE_SCHED are essentially dead code. So
> remove HK_TYPE_SCHED and any code that use it.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

