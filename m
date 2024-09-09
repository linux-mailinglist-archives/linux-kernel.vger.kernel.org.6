Return-Path: <linux-kernel+bounces-321112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996397149C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F4A1F23F02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FAA1B3F24;
	Mon,  9 Sep 2024 09:59:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253CE1B3F1B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875995; cv=none; b=MpLkLu08JbrAwPmZ1PlnXtXV52R/dz3v2JIsGBo1/O2uj3kDtassgTCVVsbEpjCz0bVlLyOOO5J3tfS4NwG/e8kQUn669040cCpqGtaWYDmXm42If9rfpNapmKsLCOLCsZQo9O98k26SyvB/bv0dXD0W097Ex8bZHNdWtWkysqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875995; c=relaxed/simple;
	bh=fNsV9KPy/Su8oKYzgoxcA9eTFlPxXiz7sPQZDWshyqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+vlrf+T7+O+BBEfIs5GrdZdjYjcf9TVd8GLEDmAQaVWAXAtj+CRnzlYhy7RcQCcKK0WcexZRnX8C6JhOjVj6ubjaJLWylraPz+54b57UaWTuF+jG0Q7d+Gc1MsHApM4MeogK/10m0k+Sc57i3tVn1jwNSWBA8givgMNqkVq8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05971FEC;
	Mon,  9 Sep 2024 03:00:22 -0700 (PDT)
Received: from [10.1.39.38] (e127648.arm.com [10.1.39.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF8B3F66E;
	Mon,  9 Sep 2024 02:59:51 -0700 (PDT)
Message-ID: <73756bc3-5de0-4559-99a3-704db78433f5@arm.com>
Date: Mon, 9 Sep 2024 10:59:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240830130309.2141697-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/30/24 14:03, Vincent Guittot wrote:
> EAS is based on wakeup events to efficiently place tasks on the system, but
> there are cases where a task will not have wakeup events anymore or at a
> far too low pace. For such situation, we can take advantage of the task
> being put back in the enqueued list to check if it should be migrated on
> another CPU. When the task is the only one running on the CPU, the tick
> will check it the task is stuck on this CPU and should migrate on another
> one.
> 
> Wake up events remain the main way to migrate tasks but we now detect
> situation where a task is stuck on a CPU by checking that its utilization
> is larger than the max available compute capacity (max cpu capacity or
> uclamp max setting)

Let me think out loud about this and feel free to object:
If there's other tasks on the rq we don't have that problem, if it is the
only one running it's utilization should be 1024, misfit should take care
of the upmigration on the way up.
If the task utilization is 1024 it needs to be alone on the rq, why would
another CPU be more efficient in that case (which presumably is an idle
CPU of the same PD)?
Or is this patch just for UCLAMP_MAX < 1024 cases altogether?

