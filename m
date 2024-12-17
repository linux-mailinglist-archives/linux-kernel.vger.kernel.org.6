Return-Path: <linux-kernel+bounces-450018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8A9F5972
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56ABC18804E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D31D90A7;
	Tue, 17 Dec 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRkeUZ6k"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839127C6E6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734473555; cv=none; b=mqQL+3+YQ5KqX0SzVe73j/qZZH26hPmkkSuH4WHWOBBlVVPg2hv0/Z0mj/+FQBZTmbjI6zETbFvY56Tfu+apNWZ23sjCxCqyjquSoWlBU1c48TUTmqeieXzBnfiAOel3m9mxYPmInvqadJBVDe+fxl/h2ShQm/Gyt0C3Re6W3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734473555; c=relaxed/simple;
	bh=xcTipRBQzhhkDDuXn4o6qGA4py9haa/Lle3jU4v/5jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po7F7fRiGqQ2m6u1P5ZJb/HqQpS6HXGW6SKfs3C4xzxlOUU2eUWWRKx5DCi87Q7eNw3IiA2jNNfMCEx3jCnHgZxkuDHDb3K3ltt4DVjma0mL+1aEa+b2Hss8al7b74gczz/ApZI75OUd0NFpypGS/vbEKca0RFVcoqYUE7bQNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRkeUZ6k; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 17 Dec 2024 22:12:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734473549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REQTbXAP3NR0yU/OhaGl8Zz1V8iMGuBFrL7D2r3Zqm0=;
	b=rRkeUZ6k/nDxVZpjv/TCIw+b7db7QuOR1TKue/6vzgZS/oPlHJyw7DPYrRsIQPuptKsmzq
	zB3Q8Ybsy0YNkv8bvw0CS5yTeaGYutSw5lzZmfUTRViD4Dy9Kf/ZR6xpDQBNSinmj/9zEx
	OJwbRFw4uwld7oPA0pWCtkFIOBD4pGo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, mkoutny@suse.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] freezer, sched: report the frozen task stat as 'D'
Message-ID: <Z2H3RwMxuRd350G6@google.com>
References: <20241217004818.3200515-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217004818.3200515-1-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 17, 2024 at 12:48:18AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> logic"), the frozen task stat was reported as 'D' in cgroup v1.
> However, after rewriting core freezer logic, the frozen task stat is
> reported as 'R'. This is confusing, especially when a task with stat of
> 'S' is frozen.
> 
> This can be reproduced as bellow step:
> cd /sys/fs/cgroup/freezer/
> mkdir test
> sleep 1000 &
> [1] 739         // task whose stat is 'S'
> echo 739 > test/cgroup.procs
> echo FROZEN > test/freezer.state
> ps -aux | grep 739
> root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000
> 
> As shown above, a task whose stat is 'S' was changed to 'R' when it was
> frozen. To solve this issue, simply maintain the same reported state as
> before the rewrite.
> 
> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!

