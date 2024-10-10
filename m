Return-Path: <linux-kernel+bounces-358157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9A997ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474C11F24ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A84188A0D;
	Thu, 10 Oct 2024 02:54:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825B187849
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528884; cv=none; b=aap1xDvcRMrrY47yT3/L0Un3IwOviu8fFdOEOELyN9cT+/5XH8aYHwdH9uhN7UODOCTFd4k88vqW2CAuMmfmxahGFlMNTYSS0Ue7WypdQIDqbsU1CpwrMrUoqV0IbVkpc/s1vl8AU3Ny7UAe1PebVzVdVpVrM/TYLmpa/EYXaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528884; c=relaxed/simple;
	bh=rAH7haOS3mjoA6IhhSlbAv2q4GVqJIO7Ej8vlH+VSvk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hfTxD2GgVLn1R6tptZRfjZP8BmLzcZbcogWzQjzGRLC25yXyKXvNS3v0HcPJV48TXzPE3j6FT8+htkKhahkFZ1+bWWLTV20IIixtLK0x4E85YCQDkg7m9aOw7A16s5E152bM07A5MyA2Ufm44ceV7gMLNBlt2ijbpbss2AUbeMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPDph6tBLz1j9f1;
	Thu, 10 Oct 2024 10:53:32 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E150B180041;
	Thu, 10 Oct 2024 10:54:38 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:54:38 +0800
Subject: Re: [patch 08/25] debugobjects: Provide and use free_object_list()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.453912357@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9a23ef1f-096a-c808-8ddf-27f6e1673581@huawei.com>
Date: Thu, 10 Oct 2024 10:54:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.453912357@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Move the loop to free a list of objects into a helper function so it can be
> reused later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -125,6 +125,20 @@ static const char *obj_states[ODEBUG_STA
>  	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
>  };
>  
> +static void free_object_list(struct hlist_head *head)
> +{
> +	struct hlist_node *tmp;
> +	struct debug_obj *obj;
> +	int cnt = 0;
> +
> +	hlist_for_each_entry_safe(obj, tmp, head, node) {
> +		hlist_del(&obj->node);
> +		kmem_cache_free(obj_cache, obj);
> +		cnt++;
> +	}
> +	debug_objects_freed += cnt;

debug_objects_freed was previously protected by pool_lock. Use atomic?

> +}
> +
>  static void fill_pool(void)
>  {
>  	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
> @@ -286,7 +300,6 @@ alloc_object(void *addr, struct debug_bu
>   */
>  static void free_obj_work(struct work_struct *work)
>  {
> -	struct hlist_node *tmp;
>  	struct debug_obj *obj;
>  	unsigned long flags;
>  	HLIST_HEAD(tofree);
> @@ -323,15 +336,11 @@ static void free_obj_work(struct work_st
>  	 */
>  	if (obj_nr_tofree) {
>  		hlist_move_list(&obj_to_free, &tofree);
> -		debug_objects_freed += obj_nr_tofree;
>  		WRITE_ONCE(obj_nr_tofree, 0);
>  	}
>  	raw_spin_unlock_irqrestore(&pool_lock, flags);
>  
> -	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
> -		hlist_del(&obj->node);
> -		kmem_cache_free(obj_cache, obj);
> -	}
> +	free_object_list(&tofree);
>  }
>  
>  static void __free_object(struct debug_obj *obj)
> @@ -1334,6 +1343,7 @@ static bool __init debug_objects_replace
>  	}
>  	return true;
>  free:
> +	/* Can't use free_object_list() as the cache is not populated yet */
>  	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
>  		hlist_del(&obj->node);
>  		kmem_cache_free(cache, obj);
> 
> .
> 

-- 
Regards,
  Zhen Lei

