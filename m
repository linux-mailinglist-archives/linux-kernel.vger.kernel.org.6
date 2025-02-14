Return-Path: <linux-kernel+bounces-514433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26FA356F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2CB1891ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1966A1FF7DB;
	Fri, 14 Feb 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HZQIWECm"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A118CC15
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513915; cv=none; b=Ee6R/Z0bAl1gZjIW+nXgwpI+onO9HC7DzaXkszox8V6KCNv0uExPgRqFJ0jqZqDNN4ha2/8AGlpcg1nWHZlND7yrm3Ynsvd32y43wHvwEMpwhwleoD2lXIIU4e2qIhoYMBfCBdyWSV+CA/OVDO4f/LD27Bp7uL6T888EQIGRD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513915; c=relaxed/simple;
	bh=0HETSp4pmmvjNN1DgIVpNcce5dCbtglud0p0QHKoMzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxALgSdsgGnQ1iLlmRDzx/FG8Ooz3syr+vpdKa+obS/93HaL3Bc3lvr6i5Q2s3qZjt9wbsM0qdPWObOawj81JJ3oK+6X+IOSfGLlW/McyxlNGNOe00EAxg1TC3fr6PRCbFBc4PMFQybiyVsWXgXSGHsBfrMr85BfjFWaIZb3ELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HZQIWECm; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739513904; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PuYGKsFncvAhPtWK3+j5Q+//S+1/fBy7fbKsaBB8yNo=;
	b=HZQIWECmxcrvvXqsyXrtazfn5p9MWDg7m2gNbVRE2KZh2HjpQkI6alFCazduNTosh/OK0Ch7DZvbHYjmdNo1N43yp7uC2s6WFiNzJ1HUVSo4aIsmsw3n+55katVkxEIYmRgJsmk6yzi/nzzPluKzXMZ4kNnCjmeYuDLRbGQVG/I=
Received: from 30.221.128.236(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WPPo2Gj_1739513903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 14:18:24 +0800
Message-ID: <2d12eb70-5fbe-415b-9970-78af2ab7945c@linux.alibaba.com>
Date: Fri, 14 Feb 2025 14:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: validate l_tree_depth to avoid out-of-bounds
 access
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: lvc-project@linuxtesting.org,
 syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 Kurt Hackel <kurt.hackel@oracle.com>, Joel Becker <jlbec@evilplan.org>,
 Mark Fasheh <mark@fasheh.com>
References: <20250213191642.720812-1-kovalev@altlinux.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20250213191642.720812-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/2/14 03:16, Vasiliy Kovalev wrote:
> The l_tree_depth field in struct ocfs2_extent_list is defined
> as __le16, but according to the comments in the structure
> definition, the high 8 bits must not be used, meaning its
> maximum valid value is 255.
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
>  fs/ocfs2/extent_map.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 930150ed5db15..0d9c25fdec029 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -415,6 +415,15 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
>  	tree_height = le16_to_cpu(el->l_tree_depth);
>  
>  	if (tree_height > 0) {
> +		if (unlikely(tree_height > 255)) {

In fact we won't allow larger tree depth.
IIRC, it is OCFS2_MAX_PATH_DEPTH, refer ocfs2_new_path().
BTW, I'd like add this check in __ocfs2_find_path() instead.

> +			ocfs2_error(inode->i_sb,
> +				    "Inode %lu has too large l_tree_depth=%u in leaf block %llu\n",

It's not leaf, but root.

Thanks,
Joseph

> +				    inode->i_ino, tree_height,
> +				    (unsigned long long)di_bh->b_blocknr);
> +			ret = -EROFS;
> +			goto out;
> +		}
> +
>  		ret = ocfs2_find_leaf(INODE_CACHE(inode), el, v_cluster,
>  				      &eb_bh);
>  		if (ret) {


