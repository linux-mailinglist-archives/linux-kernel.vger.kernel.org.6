Return-Path: <linux-kernel+bounces-293942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712209586C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A9284F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889A190468;
	Tue, 20 Aug 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S76xv/D8"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB83190063
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156263; cv=none; b=C6w23mxVQVWRyIY3YEfUXzuEokPdg13IF+YJtcgqBuB2JIYUhDJTWqkjJRDg1opjFYHh5MgQUu/e1jvQyMPmM51Djz9SJ9dq4TQ81fNT6MDMXcZzpeP5WxS6abIhqYDSvYxfE0oO6r+agH4px0NzpU4kroVrfXhLRY+QUwGvoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156263; c=relaxed/simple;
	bh=Ux41PtMBoC0aNr/p4vCfh9vjE7ZyxyWu2VLnF4eO6UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckb5KDhRvrDd2S7MKAtJ9OH40ZVP4+iY7baqjMkwWYFtUb291lo2fLn2yrgLC/lmxxRcIhFOCvLbz+GH78kZn/bYbCLJQU4VU8SmW0b0mZuQ34FNqKLjMCv61Jb0CdxYaL778Yr6x1Ac3HY2wWwd3u90mRuXTMwpFD9FEZdY6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S76xv/D8; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724156254; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pS8Sl7F3TJKPCNXozvbz7QlmmLa389OoPFPAxVXCzI8=;
	b=S76xv/D8tZiCRvBr8SitPhWkPNlpTCfMm3jmfVy2H9w94w82wYmpLSLrvZslJtTsdyC/YIi6urgQ69ChpxmlQ1YaeVKMoxqcdMZHyNMGjwwmr2p/jwQ66/bug2veJsTrf5ANZgmWKxeIjfq9zWxvNjNJJzlGnRyhOG1RvJP2tHA=
Received: from 30.221.128.199(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDIaROr_1724156253)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 20:17:34 +0800
Message-ID: <e8b5af8b-6265-4f48-9c8f-d5a8d1302e5d@linux.alibaba.com>
Date: Tue, 20 Aug 2024 20:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Use max() to improve ocfs2_dlm_seq_show()
To: Thorsten Blum <thorsten.blum@toblux.com>, mark@fasheh.com,
 jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240820021605.97887-3-thorsten.blum@toblux.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240820021605.97887-3-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 10:16 AM, Thorsten Blum wrote:
> Use the max() macro to simplify the ocfs2_dlm_seq_show() function and
> improve its readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlmglue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index da78a04d6f0b..60df52e4c1f8 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -3151,11 +3151,8 @@ static int ocfs2_dlm_seq_show(struct seq_file *m, void *v)
>  #ifdef CONFIG_OCFS2_FS_STATS
>  	if (!lockres->l_lock_wait && dlm_debug->d_filter_secs) {
>  		now = ktime_to_us(ktime_get_real());
> -		if (lockres->l_lock_prmode.ls_last >
> -		    lockres->l_lock_exmode.ls_last)
> -			last = lockres->l_lock_prmode.ls_last;
> -		else
> -			last = lockres->l_lock_exmode.ls_last;
> +		last = max(lockres->l_lock_prmode.ls_last,
> +			   lockres->l_lock_exmode.ls_last);
>  		/*
>  		 * Use d_filter_secs field to filter lock resources dump,
>  		 * the default d_filter_secs(0) value filters nothing,

