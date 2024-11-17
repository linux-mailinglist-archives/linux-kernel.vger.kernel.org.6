Return-Path: <linux-kernel+bounces-412096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D79D03D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE5C1F2421E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250718FC86;
	Sun, 17 Nov 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VTsWyjjp"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054D18DF62
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846643; cv=none; b=tU7pDi3XmtoKcR6+64F4Jvz5HEQFrwAeX5BGdc7sMzJvVzazI6mCru21qAZVJ+m1guuHYowrtLx5vU2weO3T9uO1+9+ThsxXCWgl4hrfEJf2WYZGgILGfJsLt2n+VjjMzt5hDE0L2kKovG3WzJV6+j6FulXvy9KH3IIvjaUf0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846643; c=relaxed/simple;
	bh=PU7Mhc4QfIRaRXSxWJOQnRVsxdB61TboTHrYgbmxAag=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WD96uKtJyv7NewaFcoAydlVy/aPKSPlRrmWRUcnHX2kt2Si0vnPVS2M6/UgU/YrIHkNQjdmFKXprnzTZhWlf+QT7nR/4Ek0DaDJrqgwk94HFyWqS3V8pcyavPbP5bCeC40qUqUldHHXubYKEQ71KxFfStAIuUUP6iV3YnXLaH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VTsWyjjp; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731846631; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0uM7hB+QgOqsw8eKbPpEFv7cDpaoyQJO7P9vnJovadg=;
	b=VTsWyjjpqS0bBn5MM9oTiOfB4h4KQsp2jv82j9kUoffEB+sJIst4hGQUFxrnsWgUyubASWRBCPOl36sFiDoY5R9TWNxs4vtadTjg+//J1droF1842Ufv0grMvtkCo7yBcGvgV11K562qj2Yub4JP5bcH+W8MqxzIRWSySqJxImI=
Received: from 30.0.179.31(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJZMiR7_1731846629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Nov 2024 20:30:30 +0800
Message-ID: <6a9c30d7-dce1-4323-bd48-0bef8084d5ea@linux.alibaba.com>
Date: Sun, 17 Nov 2024 20:30:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: replace deprecated simple_strtol with kstrtol
To: Daniel Yang <danielyangkang@gmail.com>, akpm <akpm@linux-foundation.org>
References: <20241115080018.5372-1-danielyangkang@gmail.com>
Content-Language: en-US
Cc: "open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)"
 <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241115080018.5372-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/24 4:00 PM, Daniel Yang wrote:
> The function simple_strtol ignores overflows and has an awkward
> interface for error checking. Replace with the recommended kstrtol
> function leads to clearer error checking and safer conversions.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
> v1->v2: reuse ret and remove blank line
> 
>  fs/ocfs2/cluster/heartbeat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 4b9f45d70..18333aa19 100644
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
> @@ -1777,8 +1778,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	if (o2nm_this_node() == O2NM_MAX_NODES)
>  		goto out;
>  
> -	fd = simple_strtol(p, &p, 0);
> -	if (!p || (*p && (*p != '\n')))
> +	ret = kstrtol(p, 0, &fd);
> +	if (ret < 0)
>  		goto out;
>  
>  	if (fd < 0 || fd >= INT_MAX)


