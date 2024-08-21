Return-Path: <linux-kernel+bounces-294725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4579591A8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209FC1F2144B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30A51C01;
	Wed, 21 Aug 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CzhQFAyx"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229283C0B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199241; cv=none; b=nGcHkXYkg1tmNLEw0JzXZiWZzXbuaO1BIfoLngTwWEIeU1A8MqOuueVQWVTV1zMbaf1UHLbn/AEiusyQTJGwP6qW5VjnuK9c+aCtz2ZlJxVcvsC7LdxEZxLPxLSAY5Vj9JSVRQWZ+ml0KyjzXC77k5/XP75C0zap7+kpk3qJElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199241; c=relaxed/simple;
	bh=p3dA9/En9kfVb7bw9vF09rEAf/8yLOR+1r+RhSE3TTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOGge1JVfecq+wNPM4WApQar2mmIkbRIxzHvnDzI2LmbA7t2e9dRUtOEsaKFmHoV3ZOJv+kciCcfhbxVsKLtZgTbEjziBR/czvopflFOXEz/ZJ7kT3VT890S3PqfzHs0LXgtlsxTWxyc4El+9jOnpmdsqcZCrDwc+U+mLlf2ZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CzhQFAyx; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724199236; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GcAXD9iBBfjMXq2km1UKv5nnHqGtH92Htt5r1IL/qZ8=;
	b=CzhQFAyxZjQBw6B3Dxs6gFRp4hzKaMDFpARl5fuak3ez0KkR1qLXY7fKbBwWo061y/fc1mCjmXTplnwLl/qk1j5hlEzLxcBCGkaS8KOjeHnowbv6e374bvtuXp4RbaBDkZDuDT6JAQczx/+jlEUxVDhSvD6fOG4fh5AtevbuX+E=
Received: from 30.171.230.57(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDJpstE_1724198924)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 08:08:45 +0800
Message-ID: <7da687ce-ffb7-44e3-bddc-d5c2f4f48c95@linux.alibaba.com>
Date: Wed, 21 Aug 2024 08:08:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] ocfs2: Fix uaf in ocfs2_set_buffer_uptodate
To: Lizhi Xu <lizhi.xu@windriver.com>, heming.zhao@suse.com
Cc: jlbec@evilplan.org, linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <980b3f4d-f265-4eb4-96a3-8f1a75588193@suse.com>
 <20240820094512.2228159-1-lizhi.xu@windriver.com>
 <20240820094512.2228159-2-lizhi.xu@windriver.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240820094512.2228159-2-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 5:45 PM, Lizhi Xu wrote:
> In the for-loop after the 'read_failure' label, the condition
> '(bh == NULL) && flags includes OCFS2_BH_READAHEAD' is missing.
> When this contidion is true, this for-loop will call ocfs2_set_buffer
> _uptodate(ci, bh), which then triggers a NULL pointer access error.
> 

Or it may simplified as the following:

When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
bh is NULL.

> Changes from V2:
> * Make the code more concise
> 

This is not the right place for changelog.

Thanks,
Joseph

> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  fs/ocfs2/buffer_head_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..8f714406528d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  		/* Always set the buffer in the cache, even if it was
>  		 * a forced read, or read-ahead which hasn't yet
>  		 * completed. */
> -		ocfs2_set_buffer_uptodate(ci, bh);
> +		if (bh)
> +			ocfs2_set_buffer_uptodate(ci, bh);
>  	}
>  	ocfs2_metadata_cache_io_unlock(ci);
>  

