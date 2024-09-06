Return-Path: <linux-kernel+bounces-318895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DA96F4B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AC81C23CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAF1CCB49;
	Fri,  6 Sep 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulbJyjDb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B11C9EBB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627234; cv=none; b=MXvjiYgHVpdVSTASE+D6SXAuks50c3Z8bJbAjTCJB4nZK2c7Gp0LfSn6BenTad9vsy8XGkgFNK/xJEWMQYzL2A9R8uvboXGbD9KIPMPvmIp6eVrNs0uIESpMB7XvS0Y1KtuCmsx7PutBzzVpeVlUDmCeZt0N2GaLmVLLxc8QwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627234; c=relaxed/simple;
	bh=FQquC8C5I/dDQukjjSCFxWMh6nkN285LKr1R53TYDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELYg6nmlkavGtKyvuBIQx/J7MxpTflXKUZwVHbetUWRU8MJiCbCtsDKqbJLpcsE06L30bAx6bQsdKLXP0PG42N1KA9zxKmUsX2riw7rUumW80ZI4G0w8+uRfLWNf0vAIYK3rfRV+nZyzkw3blCE70DmN92lVOU1Rcyl08yRrjXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulbJyjDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A3C4CEC4;
	Fri,  6 Sep 2024 12:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725627233;
	bh=FQquC8C5I/dDQukjjSCFxWMh6nkN285LKr1R53TYDz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulbJyjDbxmiOZK+dwRvGNvr8u29v3hkLASgDwDY1KG81wjI1DYeeBOvuhasXcNoK7
	 1S8G+uQO9b07VciLyvPBezqI7z9PeP8uw28xl7dduFJHLYRGycy5KMTGyYjaNlQdqo
	 jRtVP+K7bIVjF48YHG4X247wizxfq5X+zIP6Hb+5gdWGPlNmJrQccbMZ28yp0OfdAW
	 JO3au5rOE7X60cHu552tPfq8q71uhukZIp3AwATRgpQpTSwN1CUVHVn5FUfQE53b4X
	 JDqs6fX7aIJJNFr6dSkp/fsjdTtED5IPKmWD/OOfP+aOsn1u4g0oxWw/ZdgNzpxZJM
	 GP3ebutekYTLw==
Date: Fri, 6 Sep 2024 14:53:50 +0200
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
Subject: Re: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
Message-ID: <Ztr7XgZd5pUWNLnY@pavilion.home>
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-3-longman@redhat.com>
 <ZtcLUcJvqSV3vXd2@localhost.localdomain>
 <d43165ae-9124-4034-b816-d09c9a48ecec@redhat.com>
 <70e5a6f3-1cff-46c9-af34-75664961eae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70e5a6f3-1cff-46c9-af34-75664961eae2@redhat.com>

Le Wed, Sep 04, 2024 at 10:54:15AM -0400, Waiman Long a écrit :
> 
> On 9/3/24 09:53, Waiman Long wrote:
> > 
> > On 9/3/24 09:12, Frederic Weisbecker wrote:
> > > Le Sun, Aug 18, 2024 at 07:45:19PM -0400, Waiman Long a écrit :
> > > > As the previous commit has enabled the setting of HK_TYPE_SCHED
> > > > housekeeping CPUs in nohz_full setup, we can now use the more aptly
> > > > named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.
> > > > 
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > Can we instead merge HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER,
> > > HK_FLAG_RCU,
> > > HK_FLAG_MISC and HK_FLAG_KTHREAD into a single
> > > HK_FLAG_KERNEL_NOISE / HK_TYPE_KERNEL_NOISE ?
> > 
> > Sure. I am open to new name as I am not good on that.
> > HK_FLAG_KERNEL_NOISE does make sense.
> 
> I can't merge HK_FLAG_TICK just yet as it can be independently set by using
> isolcpus which can set just HK_TYPE_TICK, HK_TYPE_DOMAIN or
> HK_TYPE_MANAGED_IRQ. That is the reason why they are still separate.

Ah I think we really need to unify behaviours of isolcpus=nohz and nohz_full=

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..9bc8fbf326cc 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -212,7 +212,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	while (isalpha(*str)) {
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_TICK;
+			flags |= HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
+				 HK_FLAG_MISC | HK_FLAG_KTHREAD;
 			continue;
 		}
 


