Return-Path: <linux-kernel+bounces-208065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A332C902029
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534261F21E82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA047C09E;
	Mon, 10 Jun 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp/ot4c5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE597A702
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017836; cv=none; b=JJigLoUx3Hsa1bTQuxx7N+gk1pDLmY2qCy6XLQAAv7ocSPY+lsgThEOMSJkSf9xKqo5sdVzjIszktx57fYV4imOOey6RBSzceNwqhuNl4awgY950Fpj20EaWIxBiP8d1DRGOgDMqCa/dDC6l3QmIr8Q4Vpd1+NP8WPHPYWxpbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017836; c=relaxed/simple;
	bh=BoPTxfeDEbyvV28yFmdnIkcBko44Dr+qdq4z0jGqZm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCEHTx6DvCUdJIfnjl0sjNE+ziDC05h77NmbIcI7v8fVYgRg8+VwX/hDUm7XDvHQFGddPIEmEVR3naVqwtHQOt9sdqgNHcGq5JWiRRbEJAQjpXRbWnz0zdVN+wNT00w65dCtoG1rVRE5zzxFvTRSJT5DFpU/zxq+vVkPpeTCRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dp/ot4c5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718017833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ouFRMuOm0IWqoGx+yiBe7RuD+elI541Nr6zBjwlU0fI=;
	b=dp/ot4c5rjZ4tdebFCo5tmXDRl0WEpsHqCs8m0EkKPHgK9S8htGePyQ7RX04R0lJcB89yg
	b4kJ5pf/rKXiZQcxX9TMaeN94uzzhp8FQuTvLuZNhvXEtjyqX+RfNbHYvhFrXtEq4QJ1la
	bofSqrH3TTRFa5Ysn1Dcjfj1RJ2jkUI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-s6WuHZtcO5a9BYhe-rt-BA-1; Mon,
 10 Jun 2024 07:10:28 -0400
X-MC-Unique: s6WuHZtcO5a9BYhe-rt-BA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CD7E195608B;
	Mon, 10 Jun 2024 11:10:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2968419560AB;
	Mon, 10 Jun 2024 11:10:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 13:08:56 +0200 (CEST)
Date: Mon, 10 Jun 2024 13:08:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Q: css_task_iter_advance() && dying_tasks
Message-ID: <20240610110852.GA21828@redhat.com>
References: <20240609142342.GA11165@redhat.com>
 <20240610105028.GA21586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610105028.GA21586@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Sorry for the spam, forgot to mention. Either way the usage of group_dead
or atomic_read(signal->live) in these paths doesn't look "perfect", but
this is another thing. The pseudo code below tries to mimic the current
logic but again, I'm afraid I misread this code completely.


On 06/10, Oleg Nesterov wrote:
>
> I never understood the code in kernel/cgroup/ even remotely, most probably
> I missed something, but let me ask a couple of stupid questions anyway.
>
> cgroup_exit() does
>
> 	css_set_move_task(tsk, cset, NULL, false);
> 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>
> but unless I am totally confused css_task_iter_advance() always ignores
> the "dying" sub-threads, so perhaps it should do, say,
>
> 	css_set_move_task(tsk, cset, NULL, false);
> 	if (delay_group_leader(tsk))
> 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>
> and then cgroup_release() can check list_empty(cg_list) before it takes
> css_set_lock.
>
> No ?
>
> Or, perhaps we can do even better? Can't cgroup_exit() do something like
>
> 	// group_dead should be passed from do_exit()
>
> 	css_set_move_task(tsk, cset, NULL, false);
>
> 	if (thread_group_leader(tsk) && !group_dead)
> 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>
> 	else if (!thread_group_leader(tsk) && group_dead) {
> 		leader = tsk->group_leader;
> 		if (!list_empty(leader->cg_list) {
> 			css_set_skip_task_iters(task_css_set(leader), leader);
> 			list_del_init(&leader->cg_list);
> 		}
> 	}
>
> and then
>
> 	- kill the atomic_read(&task->signal->live)) check in
> 	  css_task_iter_advance()
>
> 	- kill the code under css_set_lock in cgroup_release()
>
> Oleg.


