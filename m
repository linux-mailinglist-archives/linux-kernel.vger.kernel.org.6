Return-Path: <linux-kernel+bounces-433052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E899E5368
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA7C164882
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B21DDC03;
	Thu,  5 Dec 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JM7uDiJn"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DA1DB92E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397007; cv=none; b=XPEVQcNyKLuy5WtHZQi/wi6FXv4oQ2jbYDA6g+BeUl+OaKmTpAHZzsFQz53cmo0vWGriaXjoii9WjMP5mmyPVmbHC1LDnXo7Z6L4U/4q/KfJmMo0w0oRj2EqpkKk2gsG8O/4k/6DFkIZ4GOBgUHEzIcc74HY0VeUmE0YZ4KgaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397007; c=relaxed/simple;
	bh=CBk15y+1bosoiqQS4z+r5vbsAgsLzPYuG8w/fSH88vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBWC8WFM7jIcZVhXqxotVoND65Z1dK4QcO/ZfhS1SHb3o8Xhmu0UoDY9AhOhhSVY0HV4Aah56ahZyBsxWpSemJB3WJRYgkYY84SDtS+5OVIYAg10WPjJfe0OpDGZRkPEBNQtT7QxsbmRSmsd9yZ1Pkc8FtbWxoJ7hZob6VLxIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JM7uDiJn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733397002; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O4Cy8bh2P+MEfj7/h17yeYf2vJikGyZup4YjTbGEAac=;
	b=JM7uDiJnGiyWjG1aASyLJjL14hc/YOHh1mL5YnvZQoHfh/+E7n8/OzbInUyeL6F5pQYYsXwvIC8PmreKSnYtUfUinTTgS2GpHh4neICr/XaYLnELbiNjhhwXDwDpYMCfT3hjltgQqkOs0QYWhdYpXFYAvEDG0cmdYMvWXuuEhEA=
Received: from 30.221.131.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WKt170B_1733397001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Dec 2024 19:10:02 +0800
Message-ID: <2a72a270-e551-4529-b900-c955cd378ef8@linux.alibaba.com>
Date: Thu, 5 Dec 2024 19:10:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ocfs2: fix the space leak in LA when releasing LA
To: Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@lists.linux.dev,
 akpm <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
References: <20241205104835.18223-1-heming.zhao@suse.com>
 <20241205104835.18223-3-heming.zhao@suse.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241205104835.18223-3-heming.zhao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/24 6:48 PM, Heming Zhao wrote:
> Commit 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
> introduced an issue, the ocfs2_sync_local_to_main() ignores the last
> contiguous free bits, which causes an OCFS2 volume to lose the last free
> clusters of LA window during the release routine.
> 
> Please note, because commit dfe6c5692fb5 ("ocfs2: fix the la space leak
> when unmounting an ocfs2 volume") was reverted, this commit is a
> replacement fix for commit dfe6c5692fb5.
> 
> Fixes: 30dd3478c3cd ("ocfs2: correctly use ocfs2_find_next_zero_bit()")
> Signed-off-by: Heming Zhao <heming.zhao@suse.com>
> Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/localalloc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
> index 5df34561c551..d1aa04a5af1b 100644
> --- a/fs/ocfs2/localalloc.c
> +++ b/fs/ocfs2/localalloc.c
> @@ -971,9 +971,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>  	start = count = 0;
>  	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
>  
> -	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
> -	       left) {
> -		if (bit_off == start) {
> +	while (1) {
> +		bit_off = ocfs2_find_next_zero_bit(bitmap, left, start);
> +		if ((bit_off < left) && (bit_off == start)) {
>  			count++;
>  			start++;
>  			continue;
> @@ -998,6 +998,8 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
>  			}
>  		}
>  
> +		if (bit_off >= left)
> +			break;
>  		count = 1;
>  		start = bit_off + 1;
>  	}


