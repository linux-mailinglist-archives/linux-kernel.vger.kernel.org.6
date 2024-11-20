Return-Path: <linux-kernel+bounces-415144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458229D31F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2F31F23350
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8422318;
	Wed, 20 Nov 2024 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IuvtI+V1"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E814442F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732067350; cv=none; b=t4g7RCgyyTZHsLZoTkDizgBXeI3qyUymyXSkRL+/ovp4epKYtkbx94pPHcyyRXNZk2mcXO+xzulCbd4vJsem01s9SfEK8vH/gjWidKV0Y1u08w+v1M3kL/ZWd9nhLvNLwfv+vson7Jdgr7GZE4jKKLgG5Of4x2GQDra5vNu2Wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732067350; c=relaxed/simple;
	bh=JGjqoq7putKpKO4oHle35t78CiwTx9TIeAmZM20cr9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sR7q7QoPl44shwbtH/QW8O/0w2Gr8qEScUJSHsxIT4SXjTtq7DAMbtiYJ/OAB40c+uBTqn/WGNJghTaF+20VzJ6bzvdH5QEzjDWPOitOQixD05IhJ+lDe3yS9eN5ce7nb3lCAX8bOnO1ls6vURjWg41UXX38sIM4i55ZZS9aqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IuvtI+V1; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732067339; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TDgLpNIIqRrgBM1H/50gv0zqqcduw7kzbrJ9htOJVOc=;
	b=IuvtI+V1KUpnstxojwxZnQCAAYUcNoKsD14HJkRdVGPU2CIecW47um/NGuddIgqber4DAQO5PHbO0uI/7H0kIHQFP1Dfx4pS5RAs6k6Ir8JteuQu0qA0QzTA09PD2TH3/VifNMrpdLmWzie1948BLL7Qcl5IC2YaHLdzlDJ6pks=
Received: from 30.221.128.194(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJq2fPZ_1732067338 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 09:48:59 +0800
Message-ID: <05c35e8d-4d79-4b65-9bcb-cab70e7d8536@linux.alibaba.com>
Date: Wed, 20 Nov 2024 09:48:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: update seq_file index in ocfs2_dlm_seq_next V2
To: Wengang Wang <wen.gang.wang@oracle.com>, akpm <akpm@linux-foundation.org>
References: <20241119174500.9198-1-wen.gang.wang@oracle.com>
Content-Language: en-US
Cc: "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241119174500.9198-1-wen.gang.wang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/24 1:45 AM, Wengang Wang wrote:
> The following INFO level message was seen:
> 
> seq_file: buggy .next function ocfs2_dlm_seq_next [ocfs2] did not
> update position index
> 
> Fix:
> Update *pos (so m->index) to make seq_read_iter happy though the index its
> self makes no sense to ocfs2_dlm_seq_next.
> 
> Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlmglue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 60df52e4c1f8..764ecbd5ad41 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3110,6 +3110,7 @@ static void *ocfs2_dlm_seq_next(struct seq_file *m, void *v, loff_t *pos)
>  	struct ocfs2_lock_res *iter = v;
>  	struct ocfs2_lock_res *dummy = &priv->p_iter_res;
>  
> +	(*pos)++;
>  	spin_lock(&ocfs2_dlm_tracking_lock);
>  	iter = ocfs2_dlm_next_res(iter, priv);
>  	list_del_init(&dummy->l_debug_list);


