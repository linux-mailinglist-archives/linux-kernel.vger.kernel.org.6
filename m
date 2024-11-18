Return-Path: <linux-kernel+bounces-412313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4699D0763
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3235B21ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B617BA2;
	Mon, 18 Nov 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v61yTMEY"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A477610D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892295; cv=none; b=g3z8vi0/v9elgCr4S+zX/hwD8oKoE4fzIorOgBrn3JbLEaFormI3s2aj4xIM0CAEl6vSaOfuXzKHVmWfCFMF9JHko59+ykUsO2U1minNBDZNNexuP7MHrStqHT3ziD0pBuOqqGCYf67+dFNQVVDjzAVsL75WshujfbFvh/4zH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892295; c=relaxed/simple;
	bh=LQf7kbzlpRxF5GWMAtn35rWyz1fS5TX9dSdMmsCXubc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ROCdcCKomuE8o4sZYdh0dK3dYAtnxPv4v51HsaFr8fpuoeVu2sLG03SIv2roa3InvwWumXqbvhwpLbht3NInH1YgsGTsbiK8u+ank39MvdnMdps7B+Vny7gTuNFPqzh+ZnT0OrzhuEwDmrm6URztQbaeemkeKwRa81aVxUK+Gz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v61yTMEY; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731892284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dp8VSuA7rOBJYAzDEEwyzxRkoPG+lS1PRg2VSlsG8nI=;
	b=v61yTMEYxVbmy11B2f7ma4EyUeX8iIpbWX7ZsND2gNtJaeQrfSAwoQJ2uDEti5nzx57ZcVLejsC9Edjo3b6EzbGOprgBTXDKEBH2JgHKv/WJIFGN0DC3Ib+0NaJSeEarecAs0wbl+hqaTcnKsOuWfnQL60xlZGX0vmdZxJ+UTh4=
Received: from 30.221.128.223(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJact4X_1731892283 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 Nov 2024 09:11:24 +0800
Message-ID: <46e3bfb7-ae28-412e-8996-900f6a2902fc@linux.alibaba.com>
Date: Mon, 18 Nov 2024 09:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ocfs2: heartbeat: replace simple_strtoul with kstrtoul
To: Daniel Yang <danielyangkang@gmail.com>, akpm <akpm@linux-foundation.org>
References: <20241117215219.4012-1-danielyangkang@gmail.com>
Content-Language: en-US
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 "open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)"
 <ocfs2-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241117215219.4012-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 5:52 AM, Daniel Yang wrote:
> The function simple_strtoul is deprecated due to ignoring overflows and
> also requires clunkier error checking. Replacing with kstrtoul() leads
> to safer code and cleaner error checking.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> v2->v3: code style change and return ret
> v1->v2: moved ret definition and removed blank lines
> 
>  fs/ocfs2/cluster/heartbeat.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index dff18efbc..76f1e7bfd 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1536,10 +1536,11 @@ static int o2hb_read_block_input(struct o2hb_region *reg,
>  {
>  	unsigned long bytes;
>  	char *p = (char *)page;
> +	int ret;
>  
> -	bytes = simple_strtoul(p, &p, 0);
> -	if (!p || (*p && (*p != '\n')))
> -		return -EINVAL;
> +	ret = kstrtoul(p, 0, &bytes);
> +	if (ret)
> +		return ret;
>  
>  	/* Heartbeat and fs min / max block sizes are the same. */
>  	if (bytes > 4096 || bytes < 512)
> @@ -1623,13 +1624,14 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
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
> -		return -EINVAL;
> +	ret = kstrtoul(p, 0, &tmp);
> +	if (ret)
> +		return ret;
>  
>  	if (tmp > O2NM_MAX_NODES || tmp == 0)
>  		return -ERANGE;
> @@ -2141,10 +2143,11 @@ static ssize_t o2hb_heartbeat_group_dead_threshold_store(struct config_item *ite
>  {
>  	unsigned long tmp;
>  	char *p = (char *)page;
> +	int ret;
>  
> -	tmp = simple_strtoul(p, &p, 10);
> -	if (!p || (*p && (*p != '\n')))
> -                return -EINVAL;
> +	ret = kstrtoul(p, 10, &tmp);
> +	if (ret)
> +		return ret;
>  
>  	/* this will validate ranges for us. */
>  	o2hb_dead_threshold_set((unsigned int) tmp);


