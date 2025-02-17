Return-Path: <linux-kernel+bounces-517263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70DA37E67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF753A8FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529B212D6E;
	Mon, 17 Feb 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AJ3qmLJv"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269F212B3A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784410; cv=none; b=QsU55cp4+a8YP9kkFL7ZUCbbd5xpZO1PTvXEoVpO9EoZftzcii3w6qwIzirgJ2fZyCoqc5YED+Uv5KK8wqIgAmOp8MglODZTfm6pG+b0Kmu87CoVXWYiyHwBcbzHIEybIaltToNm6ufOIelK/L+lbLuX4W3BEDLdR+PR2TtVR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784410; c=relaxed/simple;
	bh=tgBMol/cewm+/+LjC+8L5fqETb26KHvGGKlLD4VyrtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rx+hDMqeuJRfxnnwDhKRgi2I6OgVTmwoJ6rYviJ9+hh1owa1Z0lh+JU90PcPtHd26NPyVK2eVZDYj7h+8XD4G92/f0Uaz8xlwrMb+AztHZDOsg/w/Hzaqc03UPjZ52UYqW+tepGkqr+9wCTL0Srp0a35sjPqKJbFGz5e9u1NC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AJ3qmLJv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739784396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yChr421fU7wu4+Vnk0ShZQOwDDDdkVp+OBbAuZ/muuk=;
	b=AJ3qmLJv0ZKsRubEEWD9iSJp9srUlgVpW0k3Jg2rB6Z9CoPBhjX+Q1wSr4ekYq2WNjVjfqTv6qMh6NKrHg1ZdBPc3hwfRqDIVEC0w3JzrS8RlQjHEHy9/5mRnHNoUS0Lmn94BWHc4O4tXI1UfJnCNqbW47VPt89q4w1jQ4FTQvQ=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPd2ARk_1739784395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 17:26:35 +0800
Message-ID: <c1da1e6c-0587-44cf-8107-4917a7a60d46@linux.alibaba.com>
Date: Mon, 17 Feb 2025 17:26:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: get rid of erofs_kmap_type
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250217091044.2311-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250217091044.2311-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/17 17:10, Bo Liu wrote:
> Since EROFS_KMAP_ATOMIC is no longer valid, get rid of erofs_kmap_type too.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   fs/erofs/data.c     | 16 ++++++++--------
>   fs/erofs/dir.c      |  2 +-
>   fs/erofs/fileio.c   |  2 +-
>   fs/erofs/fscache.c  |  2 +-
>   fs/erofs/inode.c    |  6 +++---
>   fs/erofs/internal.h | 10 ++--------
>   fs/erofs/namei.c    |  2 +-
>   fs/erofs/super.c    |  8 ++++----
>   fs/erofs/xattr.c    | 12 ++++++------
>   fs/erofs/zdata.c    |  4 ++--
>   fs/erofs/zmap.c     |  6 +++---
>   11 files changed, 32 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0cd6b5c4df98..386e312de8c0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -26,7 +26,7 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>   }
>   
>   void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
> -		  enum erofs_kmap_type type)
> +				bool need_kmap)

leave in the same line?

Otherwise it looks good to me.

Thanks,
Gao Xiang

