Return-Path: <linux-kernel+bounces-342357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F6988DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 07:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD679B21800
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 05:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399219D8B8;
	Sat, 28 Sep 2024 05:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kbxfk/Zt"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14127442
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727502394; cv=none; b=CUjB5+tACDna/6uTGHVOhbbioxjnacOaoMhUjVCGf/ELgDIjB61F8K0VZqrSapa6x3D+/WH0AfkP+LhnNmW8VxnG3Tx4Zm09Ea+igVxowOcLD5iDTMCJIjhb54XRiS0Ir3DJytnFTbJVENxzz5eguK7tdn1rd/9Q753BRovFhnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727502394; c=relaxed/simple;
	bh=QHf5SJC6OBWgmLeQDGOJNNsjAI45f7I3sesWY8huJDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrLJaQG6CK8jmKHkCWhkB6J7ufNknhfsKewVQkkwMOEZtZUqrksIpMwaT/O52KvMplxSpDhEi1OMM0V7PR9NEuIoybOUEhMCZ0kJILoJQRZs+9nVwipomP64ISUMkaqZTTKFwtVlkGGGTcfwjoPJ3ZVZAPVW8+Mbl7EDb+yDzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kbxfk/Zt; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3dd5dadf-824c-4a28-a133-9967027c45f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727502389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mk1SsERiMfzZUP/WYdMOG+cu1/pOuygaFFhk7jBMFPc=;
	b=kbxfk/Zt+n9+SSu+hDo0hkxjsgXipMmqqXF1ue20TMzbHf5gV4CnMSfn5jGBo/KMDHu9tY
	aOAGRD3s2rqHPcyaaKpVryBmCaXBkvuBDhfyH+xLooeQxNRqsWOVevCtXAP9Qm2Mof+u74
	piVTIZPfzOSRU3pM5ahQ9uIN+bu6tKc=
Date: Sat, 28 Sep 2024 13:46:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 4/8] mm: Provide a new count_objcg_events() API for
 batch event updates.
To: Yosry Ahmed <yosryahmed@google.com>,
 Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 nphamcs@gmail.com, usamaarif642@gmail.com, shakeel.butt@linux.dev,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
 vinodh.gopal@intel.com
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkY_PG6vMwExts28Wa2+QcRYcLubbMfctjyVFv94yd9w3g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkY_PG6vMwExts28Wa2+QcRYcLubbMfctjyVFv94yd9w3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/9/28 11:02, Yosry Ahmed wrote:
> On Fri, Sep 27, 2024 at 7:16 PM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
>>
>> With the introduction of zswap_store() swapping out large folios,
>> we need to efficiently update the objcg's memcg events once per
>> successfully stored folio. For instance, the 'ZSWPOUT' event needs
>> to be incremented by folio_nr_pages().
>>
>> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>> ---
>>   include/linux/memcontrol.h | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 15c2716f9aa3..f47fd00c5eea 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1778,6 +1778,21 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
>>          rcu_read_unlock();
>>   }
>>
>> +static inline void count_objcg_events(struct obj_cgroup *objcg,
>> +                                     enum vm_event_item idx,
>> +                                     unsigned long count)
>> +{
>> +       struct mem_cgroup *memcg;
>> +
>> +       if (!memcg_kmem_online())
>> +               return;
>> +
>> +       rcu_read_lock();
>> +       memcg = obj_cgroup_memcg(objcg);
>> +       count_memcg_events(memcg, idx, count);
>> +       rcu_read_unlock();
>> +}
> 
> Instead of replicating the code in count_objcg_event(), we should
> change count_objcg_event() to become count_objcg_events() (i.e. add a
> count parameter). The existing callers can pass in 1, there's only 3
> of them anyway (2 after patch 6), and they are all in zswap.

Right, agree.

> 
>> +
>>   #else
>>   static inline bool mem_cgroup_kmem_disabled(void)
>>   {
>> @@ -1834,6 +1849,11 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
>>   {
>>   }
>>
>> +static inline void count_objcg_events(struct obj_cgroup *objcg,
>> +                                     enum vm_event_item idx,
>> +                                     unsigned long count)
>> +{
>> +}
>>   #endif /* CONFIG_MEMCG */
>>
>>   #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
>> --
>> 2.27.0
>>

