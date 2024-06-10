Return-Path: <linux-kernel+bounces-208054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E70902000
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BB71C21BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1C7FBA1;
	Mon, 10 Jun 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwFhTbLI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2844501B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016734; cv=none; b=kAwIJpnVQx+HMvQ0ugclFS3QChykRi3o5pqyDXfSaR7BPkQsAxLeeCeLaDbGqw93qVymkhMAgCdpJnbK+gK3zufPtDR/c+Ze9LrpKwQt/zE8X7IqJpIJ+ANG771IypuxIrS8ZuC+8CwLc2REhRYR/13FThYImQCFUZ2ZYj77IOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016734; c=relaxed/simple;
	bh=JDVoccY+wG4z/DB1isfrW0m6mvQ6J+Tc307BKmzKkt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmXxgwb8G/W8yMQNH38ql8xUAhKpJf3npFMaFjguLYsU+UiIcBJlPA+qBeb1h+eZ4Vo5hvQzHYBthI08MD6BYHl4xft3YzdtIJQjmcETs0yzGCMWRKi3Et3sNCL2xk/CHQx0cL+awJ7PPyUXBx9q9C4oTde2ZOU025TUj6kcumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwFhTbLI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718016731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qgz7Qrwel3wRmMG9l/1WxawstzC9GI/ySiVRJ9yU2g=;
	b=ZwFhTbLIqFpbwf0d8HOj5Ldbt3ePXPe2nv8eQNg+4teBmscGXGXL5icHPn7XEDSEYfSK0H
	nKT9hznNgAa1jmHUlkOM2QUgPN+JWlk+W8e4RSqjKDcThIC/CyTD47XqDhZarMpaWWKshm
	FUfJajtafIoVVcCKi/71Egx90rtfrz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-j0OfkEBBMOaEopN-oC4bGQ-1; Mon,
 10 Jun 2024 06:52:05 -0400
X-MC-Unique: j0OfkEBBMOaEopN-oC4bGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5245919560AE;
	Mon, 10 Jun 2024 10:52:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A86C1956048;
	Mon, 10 Jun 2024 10:51:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 10 Jun 2024 12:50:32 +0200 (CEST)
Date: Mon, 10 Jun 2024 12:50:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Q: css_task_iter_advance() && dying_tasks
Message-ID: <20240610105028.GA21586@redhat.com>
References: <20240609142342.GA11165@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609142342.GA11165@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I never understood the code in kernel/cgroup/ even remotely, most probably
I missed something, but let me ask a couple of stupid questions anyway.

cgroup_exit() does

	css_set_move_task(tsk, cset, NULL, false);
	list_add_tail(&tsk->cg_list, &cset->dying_tasks);

but unless I am totally confused css_task_iter_advance() always ignores
the "dying" sub-threads, so perhaps it should do, say,

	css_set_move_task(tsk, cset, NULL, false);
	if (delay_group_leader(tsk))
		list_add_tail(&tsk->cg_list, &cset->dying_tasks);

and then cgroup_release() can check list_empty(cg_list) before it takes
css_set_lock.

No ?

Or, perhaps we can do even better? Can't cgroup_exit() do something like

	// group_dead should be passed from do_exit()

	css_set_move_task(tsk, cset, NULL, false);

	if (thread_group_leader(tsk) && !group_dead)
		list_add_tail(&tsk->cg_list, &cset->dying_tasks);

	else if (!thread_group_leader(tsk) && group_dead) {
		leader = tsk->group_leader;
		if (!list_empty(leader->cg_list) {
			css_set_skip_task_iters(task_css_set(leader), leader);
			list_del_init(&leader->cg_list);
		}
	}

and then

	- kill the atomic_read(&task->signal->live)) check in
	  css_task_iter_advance()

	- kill the code under css_set_lock in cgroup_release()

Oleg.


