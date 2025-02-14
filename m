Return-Path: <linux-kernel+bounces-514591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612CA358F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72C63ACE91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387F158D96;
	Fri, 14 Feb 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hitYYJLF"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC31F8908
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521986; cv=none; b=Dl3zIc8nj3oMdMz5JkULjeQHqVGPzq61KfhVBagjbZpiZZz1bYSJ3Q7CtGbxDQbGcaewew2pvL0WqYzvXClKzFH60j0b4snZ3PkUmNEC0qNnKsFlxNjuqiUmMW8odz/biyNKfiJhR0pT5nBKfyM+7b9LDDchW2Sk3RukJ5/teaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521986; c=relaxed/simple;
	bh=oR0X/z+von3uc5jjWn5XOjRVBnwpWPVgeCO51TG9Bxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmVEXea14FC3dTgaltXylkeLD1YBgd1KgNnNHUFvN4W09M7dRmVw5KhqNG8JpvydwQR8lHOHcFOxqRSw/xSCWg3nK5hNPIaWVC5AXh1MSOyzExLm158wVo3lP0U4AKKjrieSXzY1WpCYDKvVHjM9gdIPIdk5kvo3BHORACgkRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hitYYJLF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739521979; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1VEjYcuNxhMfiG1aQzMZlAaDFvkvTZejkm3N4TbLLug=;
	b=hitYYJLFC4xT4ozdxloNC6q4YDYmfTw5iGlBIFnEsVAr9vRTSNSD8U3GhQMEUg56yzEOngveTLGw7c7a8oRlbeakSv9BmXcjtywOI1t5P0dLD6QrFE1WDo9Ywinq9tcYo5aVptwkcdR/8yRWShyOIUZfWr2YV1ejQpEtKJYmGSI=
Received: from 30.221.128.236(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WPQIGce_1739521978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 16:32:58 +0800
Message-ID: <bb8e95f6-ee91-47b9-82a0-86d576f67e39@linux.alibaba.com>
Date: Fri, 14 Feb 2025 16:32:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: validate l_tree_depth to avoid out-of-bounds
 access
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: jlbec@evilplan.org, kurt.hackel@oracle.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com
References: <2d12eb70-5fbe-415b-9970-78af2ab7945c@linux.alibaba.com>
 <20250214080038.735185-1-kovalev@altlinux.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250214080038.735185-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/2/14 16:00, Vasiliy Kovalev wrote:
> The l_tree_depth field is 16-bit (__le16), but the actual
> maximum depth is limited to OCFS2_MAX_PATH_DEPTH.
> 
> Add a check to prevent out-of-bounds access if l_tree_depth
> has an invalid value, which may occur when reading from a
> corrupted mounted disk [1].
> 
> Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
> Reported-by: syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=66c146268dc88f4341fd [1]
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> ---
> v2: Restricted depth to OCFS2_MAX_PATH_DEPTH and moved the check
>     to __ocfs2_find_path().
> ---
>  fs/ocfs2/alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 4414743b638e8..cec8fc5cb8e87 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -1803,6 +1803,14 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
>  
>  	el = root_el;
>  	while (el->l_tree_depth) {
> +		if (unlikely(le16_to_cpu(el->l_tree_depth) > OCFS2_MAX_PATH_DEPTH)) {

More precisely, it's ">= OCFS2_MAX_PATH_DEPTH".

> +			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
> +				    "Owner %llu has invalid tree depth %u in extent list\n",
> +				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
> +				    le16_to_cpu(el->l_tree_depth));
> +			ret = -EROFS;
> +			goto out;
> +		}
>  		if (le16_to_cpu(el->l_next_free_rec) == 0) {
>  			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
>  				    "Owner %llu has empty extent list at depth %u\n",


