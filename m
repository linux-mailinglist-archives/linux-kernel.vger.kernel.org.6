Return-Path: <linux-kernel+bounces-358141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01C5997AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8003B1F23CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A81187352;
	Thu, 10 Oct 2024 02:38:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BABE57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527927; cv=none; b=LjFN8eDtUx+YRDqBIB/0SYAbZXCMdgtvWfMe4zZuGc0wfEfZabYXKrnvJYXx1Q2mvSce7X8oDFflMNCeCgAmt+j0AJEKFTWCOeSkHqVgoZrRcbmGA+7qS2kmXVuYptZMAnPRlNkwhK2g2eycryJ13ba1D4hdYs9QRzlA069I/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527927; c=relaxed/simple;
	bh=oMNXi33nq/miGXCp0L3JhJV+hdbwp2htfmg1QZBpvpI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=khB/8S3dYH/9j2qdsoOaruscp8cRu2wtYm6gdspDyLZAZkx76W4YC9RlC4s7g2kIcskGn5B0NY2VWaU07YDMn1WKin5qcKx3a2cOzqo4U6Jytxzn9pbbi4CrLX69/GOuP3MlgLTG+rI1bpjPZ8XIxW/UIlOHNz47uE06J/o079E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPDQl5f5QzfdCK;
	Thu, 10 Oct 2024 10:36:15 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id D71B81402CA;
	Thu, 10 Oct 2024 10:38:39 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 10:38:39 +0800
Subject: Re: [patch 06/25] debugobjects: Reuse put_objects() on OOM
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164913.326834268@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d17d3c50-0488-7013-29bc-d5a8d3cb06c2@huawei.com>
Date: Thu, 10 Oct 2024 10:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164913.326834268@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:49, Thomas Gleixner wrote:
> Reuse the helper function instead of having a open coded copy.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/debugobjects.c |   26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -429,7 +429,6 @@ static void free_object(struct debug_obj
>  	}
>  }
>  
> -#ifdef CONFIG_HOTPLUG_CPU
>  static void put_objects(struct hlist_head *list)
>  {
>  	struct hlist_node *tmp;
> @@ -445,6 +444,7 @@ static void put_objects(struct hlist_hea
>  	}
>  }
>  
> +#ifdef CONFIG_HOTPLUG_CPU
>  static int object_cpu_offline(unsigned int cpu)
>  {
>  	/* Remote access is safe as the CPU is dead already */
> @@ -456,31 +456,19 @@ static int object_cpu_offline(unsigned i
>  }
>  #endif
>  
> -/*
> - * We run out of memory. That means we probably have tons of objects
> - * allocated.
> - */
> +/* Out of memory. Free all objects from hash */
>  static void debug_objects_oom(void)
>  {
>  	struct debug_bucket *db = obj_hash;
> -	struct hlist_node *tmp;
>  	HLIST_HEAD(freelist);
> -	struct debug_obj *obj;
> -	unsigned long flags;
> -	int i;
>  
>  	pr_warn("Out of memory. ODEBUG disabled\n");
>  
> -	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
> -		raw_spin_lock_irqsave(&db->lock, flags);
> -		hlist_move_list(&db->list, &freelist);
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -
> -		/* Now free them */
> -		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
> -			hlist_del(&obj->node);
> -			free_object(obj);
> -		}
> +	for (int i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
> +		scoped_guard(raw_spinlock_irqsave, &db->lock)
> +			hlist_move_list(&db->list, &freelist);
> +
> +		put_objects(&freelist);
>  	}
>  }
>  
> 
> .
> 

-- 
Regards,
  Zhen Lei

