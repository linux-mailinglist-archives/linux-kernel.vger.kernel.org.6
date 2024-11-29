Return-Path: <linux-kernel+bounces-412098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20A9D03D9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A63A28295E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A818E373;
	Sun, 17 Nov 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pXPzGb3d"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852318C33B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847036; cv=none; b=VH61WlN4TVs2HCZb0i72eyQi93VsLETKA6eoOp1uFPEO+ApOMi1j14IQibbWe4+7il7exq8iNDuRybkYSWxOS3skgxDjycMP/JipJzIKFK5+HrEeurKUySslDRrv9DErXWKgO6ZXh3N02lIm2GksaDboEXNkFivGrqlJDqbXKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847036; c=relaxed/simple;
	bh=3ptpaSTU7u2ZLBagCzlW0Cgy1Z4aHdOAnBD1uKeBybA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Xkdu0zYBTuX0XF8GDUWbiBmqj6V/0DXB+eXN8sfFtGObV6vpSezJ0uioJep/B09XV+tY663cc7TH0NFNFas1lZC0YEmq9XW7mLSxyfHbzbs4OuJRcjmJA+NjXFvN52UpHNBALxPP1dzHVRYiWaB5OpNYYeq8x9o7W/8a+UKU6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pXPzGb3d; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731847023; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pgtIAPsqThKFymRr4rV6egKD24ElMHTERpSkVAxHhoI=;
	b=pXPzGb3dL4tpsZNKkiMbQclis61Nr+fZYanRGfRUudsgdIoXtaaYrhM4iRiNYBigSyAUshHW9zCWP30cJRpoGOk/Igs08r5R0qMEbDG6lDOspXUm8w4fPWqAChLELRMQ/4o7zJmCYv1t7ppyiieQr/S7LbCN3KkKgABGRcK4kbA=
Received: from 30.0.179.31(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJZQeSy_1731847022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 Nov 2024 20:37:03 +0800
Message-ID: <ce0227ac-0262-46b7-8f77-6f6953b549ae@linux.alibaba.com>
Date: Sun, 17 Nov 2024 20:37:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
To: Daniel Yang <danielyangkang@gmail.com>
References: <20241115075131.4457-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: "open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)"
 <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
In-Reply-To: <20241115075131.4457-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/24 3:51 PM, Daniel Yang wrote:
> The function simple_strtoul is deprecated due to ignoring overflows and
> also requires clunkier error checking. Replacing with kstrtoul() leads
> to safer code and cleaner error checking.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> v1->v2: moved ret definition and removed blank lines
> 
>  fs/ocfs2/cluster/heartbeat.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index dff18efbc..84ee5e340 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1536,9 +1536,8 @@ static int o2hb_read_block_input(struct o2hb_region *reg,
>  {
>  	unsigned long bytes;
>  	char *p = (char *)page;
> -
> -	bytes = simple_strtoul(p, &p, 0);
> -	if (!p || (*p && (*p != '\n')))
> +	int ret = kstrtoul(p, 0, &bytes);
> +	if (ret)

The preferred code style is:

...
int ret;

ret = kstrtoul(p, 0, &bytes);
if (ret < 0)
	return ret;

>  		return -EINVAL;
>  
>  	/* Heartbeat and fs min / max block sizes are the same. */
> @@ -1623,12 +1622,13 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
>  	struct o2hb_region *reg = to_o2hb_region(item);
>  	unsigned long tmp;
>  	char *p = (char *)page;
> +	int ret;
>  
>  	if (reg->hr_bdev_file)
>  		return -EINVAL;
>  
> -	tmp = simple_strtoul(p, &p, 0);
> -	if (!p || (*p && (*p != '\n')))
> +	ret = kstrtoul(p, 0, &tmp);
> +	if (ret)
>  		return -EINVAL;

Better to return 'ret' directly since it may be -ERANGE.

>  
>  	if (tmp > O2NM_MAX_NODES || tmp == 0)
> @@ -2141,9 +2141,8 @@ static ssize_t o2hb_heartbeat_group_dead_threshold_store(struct config_item *ite
>  {
>  	unsigned long tmp;
>  	char *p = (char *)page;
> -
> -	tmp = simple_strtoul(p, &p, 10);
> -	if (!p || (*p && (*p != '\n')))
> +	int ret = kstrtoul(p, 10, &tmp);
> +	if (ret)
>                  return -EINVAL;

Prefer to:

...
int ret;

ret = kstrtoul(p, 10, &tmp);
if (ret < 0)
	return ret;

Thanks,
Joseph
>  
>  	/* this will validate ranges for us. */


