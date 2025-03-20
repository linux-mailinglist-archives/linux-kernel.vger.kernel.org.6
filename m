Return-Path: <linux-kernel+bounces-569921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F994A6A97E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B854C7AF680
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD31E5219;
	Thu, 20 Mar 2025 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pD7NpAzN"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BED192B86
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483789; cv=none; b=aY4sOTOGjsEL+tkEjlSV9Ob+I3lk1R3q95CljrwcC2wGXbvyU/yVeShSOrJlb9+hQ1AW3m8k2pcPLI1ViW2RxtURtvIzIbMooyaXtpQpmMwkWFxq1w0ftd+7JdlQdZylr3dD9zfWT0gsdlpExIopx/qBY1G56iHeCx40L7mhTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483789; c=relaxed/simple;
	bh=m6RbaG5UBdPDJobW3JsiDnRlu3Sit1mKtD1fE5degHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IUYnoweoYRBkbTFTG5t1g9aKTCZfEtOBejAP9R7HOvGtbMfuEB9401YrlZKfQtBPI3A4kFBh6GtS06T4Pq7EK6p5T1zQtNPKN/5A/HI4hOp2BhWfdyYHZ+N79EJTowwwb9VS2/uhB17SDCSHMcPpCYFleNGVY5hEiyY+z6LojVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pD7NpAzN; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742483775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZZRLALnFywosQyAbfYxHqxa+mApnY/ujk8b1UZoQbg=;
	b=pD7NpAzNuRwuLWgqSWOU8Zf1FkMoKvIyDExeNDjj8bm2eJvdnfzt2YjmX+w1iFIRGENLOG
	kMmUvfKYuxJDtso+P8cbqEr9t9de543EW9597nKbdN3IxsD1cJ8p7HvbkkJENtRejOGZdQ
	eGPVw+4P8l8ocOJepro6emUD+/v42kE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,  Jingxiang Zeng
 <linuszeng@tencent.com>,  akpm@linux-foundation.org,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  linux-kernel@vger.kernel.org,
  mhocko@kernel.org,  muchun.song@linux.dev,  kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account
 on dfl
In-Reply-To: <20250320142846.GG1876369@cmpxchg.org> (Johannes Weiner's message
	of "Thu, 20 Mar 2025 10:28:46 -0400")
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
	<20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
	<m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
	<7ia4tt7ovekj.fsf@castle.c.googlers.com>
	<20250320142846.GG1876369@cmpxchg.org>
Date: Thu, 20 Mar 2025 15:16:10 +0000
Message-ID: <7ia4plibspfp.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Wed, Mar 19, 2025 at 10:30:20PM +0000, Roman Gushchin wrote:
>> Shakeel Butt <shakeel.butt@linux.dev> writes:
>> 
>> > On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
>> >> From: Zeng Jingxiang <linuszeng@tencent.com>
>> >> 
>> >> Added cgroup.memsw_account_on_dfl startup parameter, which
>> >> is off by default. When enabled in cgroupv2 mode, the memory
>> >> accounting mode of swap will be reverted to cgroupv1 mode.
>> >> 
>> >> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
>> >> ---
>> >>  include/linux/memcontrol.h |  4 +++-
>> >>  mm/memcontrol.c            | 11 +++++++++++
>> >>  2 files changed, 14 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> >> index dcb087ee6e8d..96f2fad1c351 100644
>> >> --- a/include/linux/memcontrol.h
>> >> +++ b/include/linux/memcontrol.h
>> >> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
>> >>  
>> >>  #ifdef CONFIG_MEMCG
>> >>  
>> >> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
>> >>  /* Whether enable memory+swap account in cgroupv2 */
>> >>  static inline bool do_memsw_account_on_dfl(void)
>> >>  {
>> >> -	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
>> >> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
>> >> +				|| static_branch_unlikely(&memsw_account_on_dfl);
>> >
>> > Why || in above condition? Shouldn't it be && ?
>> >
>> >>  }
>> >>  
>> >>  #define MEM_CGROUP_ID_SHIFT	16
>> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> >> index 768d6b15dbfa..c1171fb2bfd6 100644
>> >> --- a/mm/memcontrol.c
>> >> +++ b/mm/memcontrol.c
>> >> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
>> >>  subsys_initcall(mem_cgroup_swap_init);
>> >>  
>> >>  #endif /* CONFIG_SWAP */
>> >> +
>> >> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
>> >> +static int __init memsw_account_on_dfl_setup(char *s)
>> >> +{
>> >> +	if (!strcmp(s, "1"))
>> >> +		static_branch_enable(&memsw_account_on_dfl);
>> >> +	else if (!strcmp(s, "0"))
>> >> +		static_branch_disable(&memsw_account_on_dfl);
>> >> +	return 1;
>> >> +}
>> >> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
>> >
>> > Please keep the above in memcontrol-v1.c
>> 
>> Hm, I'm not sure about this. This feature might be actually useful with
>> cgroup v2, as some companies are dependent on the old cgroup v1
>> semantics here but otherwise would prefer to move to v2.
>> In other words, I see it as a cgroup v2 feature, not as a cgroup v1.
>> So there is no reason to move it into the cgroup v1 code.
>
> Agreed. Let's think of this proposal as making memsw tracking and
> control a full-fledged v2 feature.
>
>> I think it deserves a separate config option (if we're really concerned
>> about the memory overhead in struct mem_cgroup) or IMO better a
>> boot/mount time option.
>
> Yeah, a config option forces distros to enable it :/
>
> I'm hesitant to agree with making it optional in any manner. If you
> consider the functionality that is implemented, the overhead should be
> fairly minimal. It isn't right now, because page_counter contains a
> ton of stuff that isn't applicable to this new user. That overhead is
> still paid for unnecessarily by users who _do_ need to enable it.

Agree. Memcg is already huge, so another page_counter won't add a lot
percentage-wise.

>
> It seems like a good opportunity to refactor struct page_counter.

I don't think it's a hard dependency here, but otherwise fully agree.

Thanks!

