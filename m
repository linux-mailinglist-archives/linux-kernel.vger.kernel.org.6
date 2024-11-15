Return-Path: <linux-kernel+bounces-410120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15F9CD4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13FD1F21BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4EB3FBB3;
	Fri, 15 Nov 2024 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iuwaPKyP"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC311370
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632732; cv=none; b=az74SiVdmbOIo7Hu2bTfFLsldUU796Jq5VW4ZCqYGug6t0ZMYk4lK8pg46AOaLw/Z2wFMBqb86g1Q+xeSKWmhKINAh0accxGnR+LwRT8ZleIfA+tv5SBjWGifabc7plao4wq8LNvKJHyyB/u2mOHYfmqHfe9GmmlKt1EsQEp54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632732; c=relaxed/simple;
	bh=0Mnaiv5giTJkitdFkwpfO+YuGFwyyLXQhkeoEFqz4ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R/iQkfI0rAVv0yKYEOMnwNpFxxn3n5LUsYJ9uJFbzB/c7Cy37SI/CYGgqOl+U+MrmK9ocFZ3TzL31CaRN+ZaKH0IxcL2k9lLKAZKzNqeFeCI9/QQKaKc+/yQue+HhVNV/ezldPQQEWoHmjOIfOmCZp5scJtQZu/JtsPRPzjDT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iuwaPKyP; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731632727; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XJIkwQcYcCQ60i+iSidawmFPjuxY32QLzg7OO5XGm3o=;
	b=iuwaPKyPOjg1bzER21+80/VUtSH6GMGQQONb+MkDXa3W25QpUxvKRnVslkK8cQe7I1fsSWay+iyOHDd4i/ss2F2j4gpzx7HnrE1XER1/bUwfF66ogVP2rAonCDo2XKkpoaW20rJtzGlSavq3s6L1DM415ELjrEPj06sL9a9fOn4=
Received: from 30.171.192.161(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJQc5P6_1731632726 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 09:05:27 +0800
Message-ID: <35b0534a-0ccd-4b92-b493-33434a81845e@linux.alibaba.com>
Date: Fri, 15 Nov 2024 09:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: replace deprecated simple_strtol with kstrtol
To: Daniel Yang <danielyangkang@gmail.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>,
 "open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)"
 <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
References: <20241113080913.182499-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241113080913.182499-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/24 4:09 PM, Daniel Yang wrote:
> The function simple_strtol ignores overflows and has an awkward
> interface for error checking. Replace with the recommended kstrtol
> function leads to clearer error checking and safer conversions.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 4b9f45d70..dff18efbc 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2004, 2005 Oracle.  All rights reserved.
>   */
>  
> +#include "linux/kstrtox.h"
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/jiffies.h>
> @@ -1777,8 +1778,9 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	if (o2nm_this_node() == O2NM_MAX_NODES)
>  		goto out;
>  
> -	fd = simple_strtol(p, &p, 0);
> -	if (!p || (*p && (*p != '\n')))
> +	int p_to_long_ret = kstrtol(p, 0, &fd);
> +

Please define at the beginning.
Seems we can just re-use 'ret'.
BTW, the blank line can be eleminated.

Thanks,
Joseph

> +	if (p_to_long_ret < 0)
>  		goto out;
>  
>  	if (fd < 0 || fd >= INT_MAX)


