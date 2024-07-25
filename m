Return-Path: <linux-kernel+bounces-262479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F1B93C789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48881F22B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8B19D8A7;
	Thu, 25 Jul 2024 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3vEmBgZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B719B3F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927509; cv=none; b=XMWT5uETlXX3ODjRDzTtkpZ9GozCvRZipB8+2N67HUV8qIsv68Ez1/Gstpro56o+SzA2YekTkv9HdVhkHBvXNICgVEzD6i72KrjzmQDyblxyFJ62IsyM6nZXuXS3B2OGL9TatHF1PiL8DB29tdUuvXGc5eTx9E7cB4pD5qHrZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927509; c=relaxed/simple;
	bh=Yqsz5/5rP8qqF6gLQi+CN5/bfg5TXf2TedAhyYyK3Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cifcVzN00YzdztiZS2KNsZPLycqJkSmPT+iu+2qNSHCJZ61RB8mGOvKSAcAkSzrMPnC2Ak/gjKo5jIiJ8Clv5o3+HGkrZ/cMpcTgZTx0ioiCro958Di2YUmHOyXnc9Vl/u7DO/JQ4OqGFGFv8i/mkKSyi5ncqhU+ZKfbD9FWUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3vEmBgZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721927505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MI94CKgS+ARheFWOvKMQDjVSLqIUbZ9rA0M66DyuLhY=;
	b=Y3vEmBgZ0UI1j0/q2JnSGKuxjuXTNKTV6oN2upTYVX2P3ASAlAp+1TyYwtObXyzLDeGT00
	yVs49wnhA+n8pj0bArmKVDKxyUK2pzwGo+D+JF2XJYcxQgwWlk7ntARe1O6N/rYIVC1CaC
	5sShveWBcC5egTQhp+XjDowWhcfPG5U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-mwvHHg7rPAOPRv7oDZ5maw-1; Thu,
 25 Jul 2024 13:11:41 -0400
X-MC-Unique: mwvHHg7rPAOPRv7oDZ5maw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF2F71955D52;
	Thu, 25 Jul 2024 17:11:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.93])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A21A03000194;
	Thu, 25 Jul 2024 17:11:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jul 2024 19:09:58 +0200 (CEST)
Date: Thu, 25 Jul 2024 19:09:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, clm@fb.com,
	riel@surriel.com, ffledgling@meta.com
Subject: Re: [PATCH RFC exit] Sleep at TASK_IDLE when waiting for application
 core dump
Message-ID: <20240725170951.GB6602@redhat.com>
References: <1936bd18-775b-43e3-bfd5-2cd343565f06@paulmck-laptop>
 <20240725132849.GA6602@redhat.com>
 <21406a91-8801-453a-9833-a4e24c7e90ca@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21406a91-8801-453a-9833-a4e24c7e90ca@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07/25, Paul E. McKenney wrote:
>
> How does the updated patch shown below look to you?

Thanks, looks good to me ;)

Oleg.

> ------------------------------------------------------------------------
> 
> commit a6c7779283d67a409b81616a5b485ac21637d7e7
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Jul 24 16:51:52 2024 -0700
> 
>     exit: Sleep at TASK_IDLE when waiting for application core dump
>     
>     Currently, the coredump_task_exit() function sets the task state
>     to TASK_UNINTERRUPTIBLE|TASK_FREEZABLE, which usually works well.
>     But a combination of large memory and slow (and/or highly contended)
>     mass storage can cause application core dumps to take more than
>     two minutes, which can cause check_hung_task(), which is invoked by
>     check_hung_uninterruptible_tasks(), to produce task-blocked splats.
>     There does not seem to be any reasonable benefit to getting these splats.
>     
>     Furthermore, as Oleg Nesterov points out, TASK_UNINTERRUPTIBLE could
>     be misleading because the task sleeping in coredump_task_exit() really
>     is killable, albeit indirectly.  See the check of signal->core_state
>     in prepare_signal() and the check of fatal_signal_pending()
>     in dump_interrupted(), which bypass the normal unkillability of
>     TASK_UNINTERRUPTIBLE, resulting in coredump_finish() invoking
>     wake_up_process() on any threads sleeping in coredump_task_exit().
>     
>     Therefore, change that TASK_UNINTERRUPTIBLE to TASK_IDLE.
>     
>     Reported-by: Anhad Jai Singh <ffledgling@meta.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Acked-by: Oleg Nesterov <oleg@redhat.com>
>     Cc: Jens Axboe <axboe@kernel.dk>
>     Cc: Christian Brauner <brauner@kernel.org>
>     Cc: Andrew Morton <akpm@linux-foundation.org>
>     Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>     Cc: Chris Mason <clm@fb.com>
>     Cc: Rik van Riel <riel@surriel.com>
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index f95a2c1338a8..b0d18f7b6d15 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -429,7 +429,7 @@ static void coredump_task_exit(struct task_struct *tsk)
>  			complete(&core_state->startup);
>  
>  		for (;;) {
> -			set_current_state(TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
> +			set_current_state(TASK_IDLE|TASK_FREEZABLE);
>  			if (!self.task) /* see coredump_finish() */
>  				break;
>  			schedule();
> 


