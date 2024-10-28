Return-Path: <linux-kernel+bounces-383914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D26219B21DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1A8B20B71
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 01:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27C13C8E2;
	Mon, 28 Oct 2024 01:14:00 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5E7DA62
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730078040; cv=none; b=ff1gYPAFWP8r1NcovsEM7Gez/OWPiI7LV8rmU7jKaiiBEHPgusrZSOu3RJ9+g9Qfm8FeBY2cVtx8umojry8HV5UILsbCltRjW1FtNgjuMjZRubi6IumGAJbpFFb3N4oe0YY6LWXvmaSoevc/95sBP2NlSUIl86xkAMihM9lUa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730078040; c=relaxed/simple;
	bh=FgrtwbrH9ZfBy6/s/vaJjYJASDQJzXFc55OfS9SWJLc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XyqEpIPJjbXUuHa8JBe9Ji9h9Dtp0CIn377rGkUo/usaEe4MH55KmWpw+SNlPPx3U7W0KGszAWm1dvxpyC8ziaR15tv3JNXq/GoO6u1Y3kL0MEcCY/UtuU4suDay5vc5BRlV8yNs9XywRdZ95gaSg5lznli84rKshyi9OwPBJFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcFhN2cPMzfdG0;
	Mon, 28 Oct 2024 09:11:16 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id D4A4C180115;
	Mon, 28 Oct 2024 09:13:48 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 09:13:47 +0800
Subject: Re: [PATCH] jffs2: Use str_yes_no() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>, David Woodhouse
	<dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Randy Dunlap
	<rdunlap@infradead.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241026111903.112647-2-thorsten.blum@linux.dev>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cb01b563-a636-ed47-4cbd-42c5ed806860@huawei.com>
Date: Mon, 28 Oct 2024 09:13:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241026111903.112647-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/26 19:19, Thorsten Blum Ð´µÀ:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   fs/jffs2/nodemgmt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
> index bbab2bdc71b6..69569864630e 100644
> --- a/fs/jffs2/nodemgmt.c
> +++ b/fs/jffs2/nodemgmt.c
> @@ -15,6 +15,7 @@
>   #include <linux/mtd/mtd.h>
>   #include <linux/compiler.h>
>   #include <linux/sched/signal.h>
> +#include <linux/string_choices.h>
>   #include "nodelist.h"
>   #include "debug.h"
>   
> @@ -317,9 +318,9 @@ static int jffs2_find_nextblock(struct jffs2_sb_info *c)
>   			   And there's no space left. At all. */
>   			pr_crit("Argh. No free space left for GC. nr_erasing_blocks is %d. nr_free_blocks is %d. (erasableempty: %s, erasingempty: %s, erasependingempty: %s)\n",
>   				c->nr_erasing_blocks, c->nr_free_blocks,
> -				list_empty(&c->erasable_list) ? "yes" : "no",
> -				list_empty(&c->erasing_list) ? "yes" : "no",
> -				list_empty(&c->erase_pending_list) ? "yes" : "no");
> +				str_yes_no(list_empty(&c->erasable_list)),
> +				str_yes_no(list_empty(&c->erasing_list)),
> +				str_yes_no(list_empty(&c->erase_pending_list)));
>   			return -ENOSPC;
>   		}
>   
> @@ -883,7 +884,7 @@ int jffs2_thread_should_wake(struct jffs2_sb_info *c)
>   
>   	jffs2_dbg(1, "%s(): nr_free_blocks %d, nr_erasing_blocks %d, dirty_size 0x%x, vdirty_blocks %d: %s\n",
>   		  __func__, c->nr_free_blocks, c->nr_erasing_blocks,
> -		  c->dirty_size, nr_very_dirty, ret ? "yes" : "no");
> +		  c->dirty_size, nr_very_dirty, str_yes_no(ret));
>   
>   	return ret;
>   }
> 


