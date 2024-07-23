Return-Path: <linux-kernel+bounces-260027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC193A1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9E1F22D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A20515351C;
	Tue, 23 Jul 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cWXCKqgX"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A8208A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741939; cv=none; b=LveJQpMZcPfT/dznd2f9rLS2+pWZLky1y77OqsTovDQN8MuCtDRxcxrTTYXyk39bdr06PBK7jvqJf7EMo6K9A6Y+xRUn52dTt5UI0Ah1S6UySRmDpUH+/PCtwyW9VrLK9qXqLekHf6lIHHQfai87U1hkmx+ieS4nff/Mn0D4eb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741939; c=relaxed/simple;
	bh=8MEcbrpEYT3seR0+A+mnGF5FSnnA2FLWJBXqxH7NDt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl/ZdWZxO3O/6HRB1TyUcxRyfADHqGIJkpQauNJCE3tM98RmpjZw4uIySQri1j4e4RWdBnvgTlZeYbJZLaBowddafldb/JUmedXAiW6j6kaPmS1RGGlqVcIei44TwXZ9G8cJn/CF2TOGXBOVv7g3r/dRdZ9Dhyvd2zk94ICP7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cWXCKqgX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb50bcabd1so2976434a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721741936; x=1722346736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yusSAvRfd/ioZ+bDOVdXvZOOrr/DXwdWhxWzOGauvYU=;
        b=cWXCKqgX2H1MLLVe0HQXzWu8vNEqn2uv48Ardktv/Xe7Lley+NcnA7DWxt2jzl6cA7
         HTXTTv/Bq7/f04iORqWjy33PJr8vFzU1IwdVBMpibUGrqM0msyoSgThGEJ/kb40Zg7Fe
         C5TnrAQ2MdBCzPnh9FcYZ3snrSjJsYcD3nI3QKgHYkrzBeviritT07PeQQqfdMdR86P1
         INySjnw71sXkCuHtXH5joObec3aYfR1DElNCScpPSg5s7CLCm54lwwswHvObcXIiMy3Q
         KLp597zkO7/dIr2AVw+hFQAfyQ9F7L9XBouNlEtQJwzVeJwd3l4H0JiAuGE4qw8zlIu+
         22FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741936; x=1722346736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yusSAvRfd/ioZ+bDOVdXvZOOrr/DXwdWhxWzOGauvYU=;
        b=QtMPC2aUoH0aswwK/S+8VKF9a4nd6ht7ovu5seB4Nu3rmuDiFzhSnfk4Kk3fc1hxBo
         0CkaHs3i1sMclnVS8rZui/gqIRdEKjKBZtyErg7ENik2RbVWuq3YwA1opzT3s0vVTHbJ
         z7/r6Xkyem6mTHJ0TA9V2nJrS7NkJ+JE8s5aY0HqO9IAOClq710xrsfwcbJEdaFLJr4T
         c5fRQ/2LmyWHiMf4JRmCmp2G2SneWhMoKcfyy/8AqQUBkRLxycr41/rIAL3u74kJQwfT
         tGJ47Pp/kFZrSsGXQwRnqbnKh2gXJISzUtBfCBNIXc1Dc5HfJ1Ci2BU5OpaBAF+bZF2D
         oMZw==
X-Forwarded-Encrypted: i=1; AJvYcCXcV47cP7IJGbhFS9Ffch/m4HWbaA/oMGB2HN0Rl6YUnSNkX12e2VV6ggAJflvhohxvobhioVS1GalLp6ZesZDaQC5GKzjy4C+L2YOf
X-Gm-Message-State: AOJu0YxtMYVGkNOnomlDEqAGMdKryaPiUN2wkj3TtOXMHUJZ1hBuAw6h
	qKOB/DHbqZeGSjxymWfjLiw6zXaNS15isqkrWWF6yTg5a2sTbrxsmJD71/b7o04=
X-Google-Smtp-Source: AGHT+IH8sMffgQYvkVWYv0CcnvOJkibmRKNAI0zUHLWKAAHTz6w9PjLw+JR4PLpsYysPOFoDg1f8eg==
X-Received: by 2002:a17:90b:120c:b0:2c9:9fdf:f72e with SMTP id 98e67ed59e1d1-2cd27431338mr6227037a91.26.1721741936481;
        Tue, 23 Jul 2024 06:38:56 -0700 (PDT)
Received: from [10.254.218.171] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f29d806sm74197365ad.105.2024.07.23.06.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:38:55 -0700 (PDT)
Message-ID: <e3a75483-d3f7-4963-9332-4893d22463ad@bytedance.com>
Date: Tue, 23 Jul 2024 21:38:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/numa_balancing: Fix the memory thrashing problem in
 the single-threaded process
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, peterz@infradead.org,
 mgorman@suse.de, ying.huang@intel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zhongkun,

On 7/23/24 1:32 PM, Zhongkun He Wrote:
> I found a problem in my test machine that the memory of a process is
> repeatedly migrated between two nodes and does not stop.
> 
> 1.Test step and the machines.
> ------------
> VM machine: 4 numa nodes and 10GB per node.
> 
> stress --vm 1 --vm-bytes 12g --vm-keep
> 
> The info of numa stat:
> while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
> anon N0=98304 N1=0 N2=10250747904 N3=2634334208

I am curious what was the exact reason made the worker migrated
to N3? And later...

> anon N0=98304 N1=0 N2=10250747904 N3=2634334208
> anon N0=98304 N1=0 N2=9937256448 N3=2947825664
> anon N0=98304 N1=0 N2=8863514624 N3=4021567488
> anon N0=98304 N1=0 N2=7789772800 N3=5095309312
> anon N0=98304 N1=0 N2=6716030976 N3=6169051136
> anon N0=98304 N1=0 N2=5642289152 N3=7242792960
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=4837007360 N3=8048074752
> anon N0=98304 N1=0 N2=3763265536 N3=9121816576
> anon N0=98304 N1=0 N2=2689523712 N3=10195558400
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312
> anon N0=98304 N1=0 N2=2515148800 N3=10369933312

.. why it was moved back to N2?

> anon N0=98304 N1=0 N2=3320455168 N3=9564626944
> anon N0=98304 N1=0 N2=4394196992 N3=8490885120
> anon N0=98304 N1=0 N2=5105442816 N3=7779639296
> anon N0=98304 N1=0 N2=6174195712 N3=6710886400
> anon N0=98304 N1=0 N2=7247937536 N3=5637144576
> anon N0=98304 N1=0 N2=8321679360 N3=4563402752
> anon N0=98304 N1=0 N2=9395421184 N3=3489660928
> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
> anon N0=98304 N1=0 N2=10247872512 N3=2637209600
> 
> 2. Root cause:
> Since commit 3e32158767b0 ("mm/mprotect.c: don't touch single threaded
> PTEs which are on the right node")the PTE of local pages will not be
> changed in change_pte_range() for single-threaded process, so no
> page_faults information will be generated in do_numa_page(). If a
> single-threaded process has memory on another node, it will
> unconditionally migrate all of it's local memory to that node,
> even if the remote node has only one page.

IIUC the remote pages will be moved to the node where the worker
is running since local (private) PTEs are not set to protnone and
won't be faulted on.

> 
> So, let's fix it. The memory of single-threaded process should follow
> the cpu, not the numa faults info in order to avoid memory thrashing.

Don't forget the 'Fixes' tag for bugfix patches :)

> 
> ...> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 24dda708b699..d7cbbda568fb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2898,6 +2898,12 @@ static void task_numa_placement(struct task_struct *p)
>   		numa_group_count_active_nodes(ng);
>   		spin_unlock_irq(group_lock);
>   		max_nid = preferred_group_nid(p, max_nid);
> +	} else if (atomic_read(&p->mm->mm_users) == 1) {
> +		/*
> +		 * The memory of a single-threaded process should
> +		 * follow the CPU in order to avoid memory thrashing.
> +		 */
> +		max_nid = numa_node_id();
>   	}
>   
>   	if (max_faults) {

Since you don't want to respect the faults info, can we simply
skip task placement?

