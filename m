Return-Path: <linux-kernel+bounces-315028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2796BCB3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33137287322
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC91D9344;
	Wed,  4 Sep 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5ll4F9G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6791D221B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453869; cv=none; b=kLCFrplUO2m3VfRej6/tkT2evoqsljDA3o6Og7IVEWs7N/TD28ZL6jTQq3YEC5lfjf8Lgu8sVyMOZjJZ9l3AuGRj9bFJQdh9NVrPr5M0BZzh8eXfoc95ZRGgWTIlZxKZHQbKakBtHFFBynd2xPGJT2ddqMsN792BArotelbX/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453869; c=relaxed/simple;
	bh=+5K1F1NRdmBOL7Wej9F0GpolAlWLbjktOaDP1YDt5FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVQ20niOr7hJjn4H+2wyoUMUEA+oIs/+Ix/VLjZfA9aS9HO5nYUumJLTSUMN8bWvhPCQiAAQji19CSycmu9Rm3dt2///kZkJK+xNa7sRSOiSDxWvcFIVhPWChWFxrRYZdiiETNYGTTk1QMmP9lg643aiUfNJfAbNlwosrKnzTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5ll4F9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B5BC4CEC2;
	Wed,  4 Sep 2024 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725453869;
	bh=+5K1F1NRdmBOL7Wej9F0GpolAlWLbjktOaDP1YDt5FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5ll4F9GV7P6/pMcyHYWxkqP0vikszvnoLOi97gZp8NBu0dVuUDZxuC8ncMZlFK7O
	 9vqctLqmgu0SCpCaZ5MLMUTTnsHDzzw/nc6IxUy9LNdslECzyat31ZmrzOl90/4/ZJ
	 M0nuRlZrGROYyvJD89W6xiVuAlLaVUl5pCRjsz1m0RpB4vCfrQXqgl2UvTZjJAiR9E
	 TmHI9CKyw3IYTNbHlCvZ7L1PeudHxA25vDhpv9nr4IC1qKp6erULO/nYCOMleRDopA
	 d8bI6nBln4c/onuqrmXYX4sGLyH3aWv9GMPX8CDupAfnQxsNGR127dPAiAWLrLY/VI
	 LKzQcCdKeFh8w==
Date: Wed, 4 Sep 2024 14:44:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
Message-ID: <ZthWKgK9B_AUqSs1@localhost.localdomain>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
 <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4822d111-b02d-469a-a457-46392c35021f@redhat.com>

Le Tue, Sep 03, 2024 at 09:23:53PM -0400, Waiman Long a écrit :
> > After discussing with Peter lately, the rules should be:
> > 
> > 1) If a nohz_full CPU is part of a multi-CPU domain, then it should
> >     be part of load balancing. Peter even says that nohz_full should be
> >     forbidden in this case, because the tick plays a role in the
> >     load balancing.
> 
> My understand is that most users will use nohz_full together with isolcpus.
> So nohz_full CPUs are also isolated and not in a sched domain. There may
> still be user setting nohz_full without isolcpus though, but that should be
> relatively rare.

Apparently there are users wanting to use isolation along with automatic
containers deployments such as kubernetes, which doesn't seem to work
well with isolcpus...

> 
> Anyway, all these nohz_full/kernel_nose setting will only apply to CPUs in
> isolated cpuset partitions which will not be in a sched domain.
> 
> > 
> > 2) Otherwise, if CPU is not part of a domain or it is the only CPU of all its
> >     domains, then it can be out of the load balancing machinery.
> I am aware that a single-cpu domain is the same as being isolated with no
> load balancing.

By the way is it possible to have a single-cpu domain (sorry I'm a noob here)
or do such CPU always end up on a null domain?

If it is possible, it's interesting to notice that such CPU can become ilb
(as opposed to null domain).

> > 
> > I'm a bit scared about rule 1) because I know there are existing users of
> > nohz_full on multi-CPU domains... So I feel a bit trapped.
> 
> As stated before, this is not a common use case.

Not sure and anyway it's not a forbidden usecase. But this is anyway outside
the scope of this patchset.

> The isolcpus boot option is deprecated, as stated in kernel-parameters.txt.

We should undeprecate it, apparently it's still widely used. Perhaps by people
who can't afford to use cpusets/cgroups.

> My plan is to deprecate nohz_full as well once we are able to make dynamic
> CPU isolation via cpuset works almost as good as isolcpus + nohz_full.

You can't really deprecate such a kernel boot option unfortunately. Believe me
I wish we could.

Thanks.

> Cheers,
> Longman
> 

