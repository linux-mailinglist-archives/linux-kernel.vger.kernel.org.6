Return-Path: <linux-kernel+bounces-405072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCA39C4C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CFE282EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C4204F84;
	Tue, 12 Nov 2024 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GBJ+52Xl"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C568201009
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378766; cv=none; b=jvlUAhs2hLg9VraZ0oKg1ot2Z/HAajpzgTLGqKWEvNRUOiuaskOHjVq8HZtCCU/yEzvLOlgcIQiBlbfFjbaKcMPgkyoX6KnxG1ffJiHCqLTGRQOTvkkGgiI57d/IHkDUxCYbCclWoNVLCMg2w1AKLwagR8tqw3dzA4J6iSsyyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378766; c=relaxed/simple;
	bh=SL01iUH93AkK+lnt5Ok+r1in4PZR2vkRFm+cibj3GqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCaXssG/T10UL0ryVkeglhfmY/td4KdnWsT1JBFTQbGLOslDIt5i+mlsvqjYfT1KJZbeyfy1+o9kUvImvOaxqHXWCUktKJrZHMw8lX5JZnQ5eu2TmDAaw2NTCgEt5VgTU+ndMigt8RZp2RnmasfiNAT7TKg4XhFagu23mJdXaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GBJ+52Xl; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731378761; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jbj91BmDvvsxwWvx8lHwWl07tIkYm+T47B95nubtj1Y=;
	b=GBJ+52Xlh07HJJ5qVH6QxWNUOJj2Uki/1z9ZlpgYvJr1t4BU7BUHd4PV4mSnf1nm3vjkxPiMlLz/wRPki8Ada1kEpUO6Wew3gtSBdSYIRbFd7Ro+m97ejPHRU/B/ezZtBh5HhbEyD8vjHi33jyXAIZ7XSZ5lOSNegSnXSz4QhwA=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFJuX2_1731378760 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 10:32:40 +0800
Message-ID: <1ce4a2b4-1b2f-48d1-99e5-f664b760a7bd@linux.alibaba.com>
Date: Tue, 12 Nov 2024 10:32:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: free pclusters if no cached folio attached
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241111113842.469080-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241111113842.469080-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just two extra minor nits...

First, the subject line would be
"erofs: free pclusters if no cached folio is attached"

On 2024/11/11 19:38, Chunhai Guo wrote:
> Once a pcluster is fully decompressed and there are no attached cached
> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
> will significantly reduce the frequency of calls to erofs_shrink_scan()
> and the memory allocated for `struct z_erofs_pcluster`.
> 
> The tables below show approximately a 96% reduction in the calls to
> erofs_shrink_scan() and in the memory allocated for `struct
> z_erofs_pcluster` after applying this patch. The results were obtained
> by performing a test to copy a 4.1GB partition on ARM64 Android devices
> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
> 
> 1. The reduction in calls to erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (times) |   11390   |   390    | -96.57% |
> +-----------------+-----------+----------+---------+
> 
> 2. The reduction in memory released by erofs_shrink_scan():
> +-----------------+-----------+----------+---------+
> |                 | w/o patch | w/ patch |  diff   |
> +-----------------+-----------+----------+---------+
> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
> +-----------------+-----------+----------+---------+
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

...

> -static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
> +static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
> +		struct z_erofs_pcluster *pcl, bool try_free)
>   {
> +	bool free = false;
> +
>   	if (lockref_put_or_lock(&pcl->lockref))
>   		return;
>   
>   	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
> -	if (pcl->lockref.count == 1)
> -		atomic_long_inc(&erofs_global_shrink_cnt);
> -	--pcl->lockref.count;
> +	if (--pcl->lockref.count == 0) {

Second, EROFS codebase uses `!--pcl->lockref.count`
coding style instead of `== 0` since the old checkpatch.pl
will complain this and I'd like to keep consistentency..

Otherwise it looks good to me, if you send out a
new version, I will apply directly.

Thanks,
Gao Xiang

