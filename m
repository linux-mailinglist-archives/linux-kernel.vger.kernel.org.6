Return-Path: <linux-kernel+bounces-299475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E777A95D547
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8661F1F23973
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A326190682;
	Fri, 23 Aug 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSKx49ns"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92518E059
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437403; cv=none; b=rgH7u6TEY3lSiYakdOEUS9lVO3Uca+Gbx/4l3Z0zZTRwUI74UUzomK1zDbbhQ50JOWYvec/pAaqttc//EUkO01vWvoEHn6bXKGvqELRR2m/4oSVoUgRRmLZ7NmuIeOpgBTD32I7rr0t/U97a7hIehY1NOipz2ogrzyZrvPiU3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437403; c=relaxed/simple;
	bh=j8J7kjLSZ9VxBNdPmDoYVazhEVlzCZEjgiOZthKKvks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvZpsOAKXQXo2bqbkTctU5TWpvPxh1f9U0TjwKtKXpBvEMJUNv/DEyJeFgefi3OXrei9gYXvm37/YLkbHRLzG7INVm1/7PeQvEJyFAT23vqFDi7MibqqsXkBbNF4KRaT5fqGTcHDxeGGXBstohbgOrdu1dOsWVIV5hfW1nBEOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSKx49ns; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724437400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYirchkIoQm8fPzZRazyjwO0QfXtAKKz8sBveHCKcks=;
	b=LSKx49ns7wTdnROT0Ha7Lo2D/2Tzn70mYOF19ddnEM0blV/7YdoZcaIpbAMbJbGkLJr67T
	MZVIZAJbonnaeQomzDTCs3CW2mP68NLpz/yc+udQ4WJ/rwj0J7CnVfoRAJwoRJer0YduXf
	X111sk4JSWpNRsOgW4BjFso2GiXkUYM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-_JdmovXMPSS7AHQHoI_e1g-1; Fri,
 23 Aug 2024 14:23:17 -0400
X-MC-Unique: _JdmovXMPSS7AHQHoI_e1g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B7FC1955F3D;
	Fri, 23 Aug 2024 18:23:15 +0000 (UTC)
Received: from [10.2.16.95] (unknown [10.2.16.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D65513001FE5;
	Fri, 23 Aug 2024 18:23:12 +0000 (UTC)
Message-ID: <4f853be5-287b-43f6-9173-c56cb04f4b3a@redhat.com>
Date: Fri, 23 Aug 2024 14:23:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] sched: Miscellaneous isolation related cleanups
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240818234520.90186-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/18/24 19:45, Waiman Long wrote:
> This series contains a number of miscellaneous sched/isolation related
> cleanups.
>
> Waiman Long (3):
>    sched/isolation: Add HK_FLAG_SCHED to nohz_full
>    sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
>    sched/isolation: Consolidate housekeeping cpumasks that are always
>      identical
>
>   include/linux/sched/isolation.h | 19 +++++++++++++------
>   kernel/sched/fair.c             |  7 ++-----
>   kernel/sched/isolation.c        |  2 +-
>   3 files changed, 16 insertions(+), 12 deletions(-)

Ping. Any comment or suggestion on these patches?

Thanks,
Longman


