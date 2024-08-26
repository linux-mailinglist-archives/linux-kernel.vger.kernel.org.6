Return-Path: <linux-kernel+bounces-302093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F895F9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FEFE1C21F28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CD198E93;
	Mon, 26 Aug 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc/Nm7dr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FA7F460
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700631; cv=none; b=Lo6PTy8rRVmQ8QqmFF5OGUuEp3szRvjC1jw6LEhuUn31CeyTYabP4W4hhAxmnQDCVtCicwMTIVSAudCk2PzXGhq+Fb7UlAdgM2QVGwypDKFDEp3AgjN9NCIn4bJ/P7iCDFamjOTQqBYj2gXDW4JVLPHLc3cpQq7IWhmBW3avzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700631; c=relaxed/simple;
	bh=E1gan4GaPQpanO19xJ4vqkBlLkLMe5LhuKkzJLKBA+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZuLYMhWdR0j4LqI5EXv638ZVjlPCEqRAzqWiUW4U9vkVZ82pS4h3JyT8/BbsuVi0sYdAI1QkVQpyF05ij9wA4H67KIvVTGfusTpAV7bFEsPybmd0Zg1zBIeUP3MczkGvoILrbSdb2wzROeG7qB2Msrxt0OK86Nl/hrzJcSdgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc/Nm7dr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724700628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIDJsT8JfsnF0fOlQyoE0wsNEozg+jaZA+6mr9HP8FQ=;
	b=Hc/Nm7drtZCCYjqvlp5yZosZe5WmfAz/BQ/NPCfMRl2slIBl9o3Ul00NXmTVr13Qxab+jz
	tEzpwG0kUs8nqA8GVDycNYCVflpvEBevgpiNVsYOB6ys2d2Lw6aTjNEphSLDW8PtC2JZug
	ahqobQwQc3K9zhqaP+jI83x5NE7TyFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-V2x8GoLANH21-lBgZvvvhw-1; Mon,
 26 Aug 2024 15:30:20 -0400
X-MC-Unique: V2x8GoLANH21-lBgZvvvhw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 363EC1955BEF;
	Mon, 26 Aug 2024 19:30:18 +0000 (UTC)
Received: from [10.2.16.157] (unknown [10.2.16.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5A63300019C;
	Mon, 26 Aug 2024 19:30:15 +0000 (UTC)
Message-ID: <eaef1faf-c3f3-4664-ae7d-5cca611925e4@redhat.com>
Date: Mon, 26 Aug 2024 15:30:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next 09/11] cgroup/cpuset: move v1 interfaces to
 cpuset-v1.c
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, adityakali@google.com,
 sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenridong@huaweicloud.com
References: <20240826132703.558956-1-chenridong@huawei.com>
 <20240826132703.558956-10-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240826132703.558956-10-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/26/24 09:27, Chen Ridong wrote:
> Move legacy cpuset controller interfaces files and corresponding code
> into cpuset-v1.c. 'update_flag', 'cpuset_write_resmask' and
> 'cpuset_common_seq_show' are also used for v1, so declare them in
> cpuset-internal.h.
>
> 'cpuset_write_s64', 'cpuset_read_s64' and 'fmeter_getrate' are only used
> cpuset-v1.c now, make it static.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |   9 +-
>   kernel/cgroup/cpuset-v1.c       | 194 ++++++++++++++++++++++++++++++-
>   kernel/cgroup/cpuset.c          | 195 +-------------------------------
>   3 files changed, 199 insertions(+), 199 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 07551ff0812e..a6c71c86e58d 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -271,15 +271,16 @@ void callback_lock_irq(void);
>   void callback_unlock_irq(void);
>   void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
>   void update_tasks_nodemask(struct cpuset *cs);
> +int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on);
> +ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
> +				    char *buf, size_t nbytes, loff_t off);
> +int cpuset_common_seq_show(struct seq_file *sf, void *v);
>   
>   /*
>    * cpuset-v1.c
>    */
> +extern struct cftype legacy_files[];

The legacy_files name is rather generic. By making it globally visible 
within the kernel, it runs the risk conflicting with another variable of 
the same name (namespace pollution). I would suggest adding "cpuset_" 
prefix to make it unique to cpuset.

The following functions also have similar issue.

- update_flag()
- update_tasks_flags()
- validate_change_legacy()
- callback_lock_irq()
- callback_unlock_irq().

Another alternative is to include cpuset-v1.c directly into cpuset.c like

#ifdef CONFIG_CPUSETS_V1
#include "cpuset-v1.c"
#else
    ....
#endif

Then you don't need to change the names and will not need 
cpuset-internal.h. It is up to you to decide what you want to do.

Cheers,
Longman


