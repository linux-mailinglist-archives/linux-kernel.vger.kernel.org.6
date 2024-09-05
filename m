Return-Path: <linux-kernel+bounces-316282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0EA96CD74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E661C1C22021
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0001494B0;
	Thu,  5 Sep 2024 03:41:21 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41449539A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507681; cv=none; b=BxDV4WyqxEoQvwBkLY5CArEvp4KGcLV8fv8Oz0q20l+fqqrVcfYE0HHn9aNCB/tn37WNfiqxyKnm9nuPfrPfrlMsEjluLAMvFDwlFrCWM4vY65y7CohthCBABT665SORGO2VAoXxns0uzg4SuwhyQt8jZYqFMkeQ5zXM2OIHHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507681; c=relaxed/simple;
	bh=yesN/07Bs+fSMZgCuDMW8EC47sPEzYC1CsLb8zdAEHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kEOWW9PgQU5hnF/9NClxWIKbqi94LsE4DyRiDbHXZRUcLjGvZUwCJzyCLnul6MdeEbWfXJ7VwSxfTm9mC7SQrYaXiKbQWx37sr+XtlNTBMQGDnlmeFMXHvkgLJjor2WlDafzv+bmqZjtkxcdk1bPFlDO6aAg4vvXcF3MphjXBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WzlWV1FW7z1j88L;
	Thu,  5 Sep 2024 11:40:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A3791A0188;
	Thu,  5 Sep 2024 11:41:15 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 11:41:14 +0800
Message-ID: <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
Date: Thu, 5 Sep 2024 11:41:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in
 sysfs_slab_add()
Content-Language: en-US
To: Liu Shixin <liushixin2@huawei.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20221112114602.1268989-4-liushixin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2022/11/12 19:46, Liu Shixin wrote:
> There is a memory leak of kobj->name in sysfs_slab_add():
> 
>  unreferenced object 0xffff88817e446440 (size 32):
>    comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
>    hex dump (first 32 bytes):
>      75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
>      00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
>    backtrace:
>      [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
>      [<000000002f70da0c>] kstrdup_const+0x4b/0x80
>      [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
>      [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
>      [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
>      [<000000009326fd57>] __kmem_cache_create+0x406/0x590
>      [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
>      [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
>      [<000000007a6531c8>] 0xffffffffa02d802d
>      [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
>      [<00000000995ecdcf>] do_init_module+0xdf/0x320
>      [<000000008821941f>] load_module+0x2f98/0x3330
>      [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
>      [<000000009339fbce>] do_syscall_64+0x35/0x80
>      [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0


Hi，every one,

I found the same problem and it solve this problem with the patch, is
there any plan to update the patch and solve it.

> 
> Following the rules stated in the comment for kobject_init_and_add():
>  If this function returns an error, kobject_put() must be called to
>  properly clean up the memory associated with the object.
> 
> kobject_put() is more appropriate for error handling after kobject_init().
> And we can use this function to solve this problem.
> 
> For the cache created early, the related sysfs_slab_add() is called in
> slab_sysfs_init(). Skip free these kmem_cache since they are important
> for system. Keep them working without sysfs.
> 
> Fixes: 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  include/linux/slub_def.h |  4 ++--
>  mm/slab_common.c         |  6 ++----
>  mm/slub.c                | 21 +++++++++++++++++----
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 26d56c4c74d1..90c3e06b77b1 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -144,11 +144,11 @@ struct kmem_cache {
>  
>  #ifdef CONFIG_SYSFS
>  #define SLAB_SUPPORTS_SYSFS
> -int sysfs_slab_add(struct kmem_cache *);
> +int sysfs_slab_add(struct kmem_cache *, bool);
>  void sysfs_slab_unlink(struct kmem_cache *);
>  void sysfs_slab_release(struct kmem_cache *);
>  #else
> -static inline int sysfs_slab_add(struct kmem_cache *s)
> +static inline int sysfs_slab_add(struct kmem_cache *s, bool free_slab)
>  {
>  	return 0;
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 55e2cf064dfe..30808a1d1b32 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -237,11 +237,9 @@ static struct kmem_cache *create_cache(const char *name,
>  #ifdef SLAB_SUPPORTS_SYSFS
>  	/* Mutex is not taken during early boot */
>  	if (slab_state >= FULL) {
> -		err = sysfs_slab_add(s);
> -		if (err) {
> -			slab_kmem_cache_release(s);
> +		err = sysfs_slab_add(s, true);
> +		if (err)
>  			return ERR_PTR(err);
> -		}
>  		debugfs_slab_add(s);
>  	}
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index a1ad759753ce..25575bce0c3c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5881,7 +5881,7 @@ static char *create_unique_id(struct kmem_cache *s)
>  	return name;
>  }
>  
> -int sysfs_slab_add(struct kmem_cache *s)
> +int sysfs_slab_add(struct kmem_cache *s, bool free_slab)
>  {
>  	int err;
>  	const char *name;
> @@ -5911,14 +5911,17 @@ int sysfs_slab_add(struct kmem_cache *s)
>  		 * for the symlinks.
>  		 */
>  		name = create_unique_id(s);
> -		if (IS_ERR(name))
> +		if (IS_ERR(name)) {
> +			if (free_slab)
> +				slab_kmem_cache_release(s);
>  			return PTR_ERR(name);
> +		}
>  	}
>  
>  	s->kobj.kset = kset;
>  	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
>  	if (err)
> -		goto out;
> +		goto out_put_kobj;
>  
>  	err = sysfs_create_group(&s->kobj, &slab_attr_group);
>  	if (err)
> @@ -5934,6 +5937,16 @@ int sysfs_slab_add(struct kmem_cache *s)
>  	return err;
>  out_del_kobj:
>  	kobject_del(&s->kobj);
> +out_put_kobj:
> +	/*
> +	 * Skip free kmem_cache that create early since they are important
> +	 * for system. Keep them working without sysfs. Only free the name
> +	 * for early allocated kmem_cache.
> +	 */
> +	if (free_slab)
> +		kobject_put(&s->kobj);
> +	else
> +		kfree_const(s->kobj.name);
>  	goto out;
>  }
>  
> @@ -6002,7 +6015,7 @@ static int __init slab_sysfs_init(void)
>  	slab_state = FULL;
>  
>  	list_for_each_entry(s, &slab_caches, list) {
> -		err = sysfs_slab_add(s);
> +		err = sysfs_slab_add(s, false);
>  		if (err)
>  			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
>  			       s->name);

