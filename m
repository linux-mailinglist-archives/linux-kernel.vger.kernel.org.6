Return-Path: <linux-kernel+bounces-409805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7889C91E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC1F1F22DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69048199E92;
	Thu, 14 Nov 2024 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrTHoDMO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D117583
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610354; cv=none; b=IhbLobGoYF1+Q/+ZFOn/cuWM8eDvolxoH5pMCbMCBvBMsSTLmttqVBahqwCOOvK/c247ZcAkEM00rIbHZ35K9d6z+rtv6ZQzO5ylPOQ0pJ7UBziH2Y8uZGFmNsvRx983hP95QsQNUcfxaT9R3HoM5Nh4+CBcx/JuR9pqzN8fd6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610354; c=relaxed/simple;
	bh=qCkfveWfxDFMc9eMfoxMX6NEyCiAnf61KDfIGEcg3PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+HtmvgelfBStBagd8yVVA4D9FNL6vO/b5YzSpdnh8WdnX/MGTEN6O3pVs8/n1ZM8fjDV1oEQKYzGIUq1lleVdmfXaUnfjfJMvV7H5jBBeNqsXRsxI1krK5hAdDLNCHno3ihP8i7e/7rpFbRyJ7nIiSGzG+yfi0pOWQx3sIqdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrTHoDMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731610352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsbD+r91jBNGH5pSpTvuS0GStDOM03HerGRGdLTpNow=;
	b=GrTHoDMOim7QYaZOrLFuHD+1aZUf18TD7JD7K6X3rA7+zuPqne7KcvU5Fvx+NNx9Ibyrp7
	ToFiB05XNGCU95XwjUJ07xrJZlTp4OFd5RkdHcwpMEjP3fy/27mC3DBm4+aYppl75lDk5s
	Re/lkAc7oEXIJfFHU1xxX5u9Sa4NyJ4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-EO3AZNbfOU-yYKr104-NcA-1; Thu,
 14 Nov 2024 13:52:29 -0500
X-MC-Unique: EO3AZNbfOU-yYKr104-NcA-1
X-Mimecast-MFC-AGG-ID: EO3AZNbfOU-yYKr104-NcA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CE0E194510C;
	Thu, 14 Nov 2024 18:52:21 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.110])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1881955F43;
	Thu, 14 Nov 2024 18:52:17 +0000 (UTC)
Date: Thu, 14 Nov 2024 13:52:15 -0500
From: Phil Auld <pauld@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: add READ_ONCE to task_on_rq_queued
Message-ID: <20241114185215.GF471026@pauld.westford.csb>
References: <20241114162128.1818680-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114162128.1818680-1-jon@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Nov 14, 2024 at 09:21:28AM -0700 Jon Kohler wrote:
> task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
> set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
> in __block_task, and also read with READ_ONCE in task_on_rq_migrating.
> 
> Make all of these accesses pair together by adding READ_ONCE in the
> task_on_rq_queued.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  kernel/sched/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c03b3d7b320e..dbbe5ce0dd96 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2277,7 +2277,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
>  
>  static inline int task_on_rq_queued(struct task_struct *p)
>  {
> -	return p->on_rq == TASK_ON_RQ_QUEUED;
> +	return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
>  }
>  
>  static inline int task_on_rq_migrating(struct task_struct *p)
> -- 
> 2.43.0
> 
> 

That looks right especially when seen with task_on_rq_migrating()
right below it, as you said.

Reviewed-by: Phil Auld <pauld@redhat.com>


Cheers,
Phil
-- 


