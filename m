Return-Path: <linux-kernel+bounces-198661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FAB8D7BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986851F22559
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6D7D096;
	Mon,  3 Jun 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6Wjim7A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5F364A0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396797; cv=none; b=DNQzrArbLj0UDHpXnbBdWZgeVvv5jYobm/7m9oddYvsKzCENIrciT8Zo4vTMOmTnlMxJWntXGS7coSgoQj1ckAHUoa2+L5TjXZgLJtpA1w4uVUSyHGW+6cPSJsVmlEp9NkfdH7jQtcWMafTuRUf76ZXxrlDzXVw9N/t0CP9r0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396797; c=relaxed/simple;
	bh=yMVHDPZTk2KiIA4M5duiDTFOwyQCPZJ4+zZKOyjLkCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT4zevaL+Fd9yGmVByEk4W3YHflun7J164NvdDF+7yHU3lVfPpHFL/9gzLFQrm7fESJI5Jf2WaDtfWdJiK53TzWIKalJOPquntdW8DnxpWgE76X55wcwZPr7AOoe2D03FX/nQe4xhscmYz/n9E3vfNNknZ5nyXIrWKByOxe90x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6Wjim7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A936DC2BD10;
	Mon,  3 Jun 2024 06:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717396797;
	bh=yMVHDPZTk2KiIA4M5duiDTFOwyQCPZJ4+zZKOyjLkCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F6Wjim7ABkZMuZmkWslsUYfIjuqeMGoOQ5VHlSs7N4rpNsgE09DypCXPvJb51g3kt
	 UoBg/grrCvrX7PT5SkbG/8O50M9pL0eIRFfrGY8TKPkeVduPouTL4t2a+AcI+mj7+Y
	 +cgwyWZKKEaE3Njox0+uxrz5kIMd+r/AnF/n3bWnZE2feQquAY7bTxaZPTJ45uTYGS
	 +c9YAe77T8hz9SvEtxtuv5ibtGbk+f8yIYJVSbPzh20nsi7XOeTScdv+xFA34iz/2Y
	 3mPkXf++5nxkgtDbHzvjuxAMetR3bQ4cqdhOfnF3T1vrdHM7IUz0u7jM8lsqsfI3Sb
	 Mj5y4ewYMOIVg==
Message-ID: <b0c9f3dc-417a-4891-bdf0-25b849828e3b@kernel.org>
Date: Mon, 3 Jun 2024 14:39:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: use new ioprio Macro to get ckpt thread ioprio data
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1717146645-18829-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/31 17:10, Zhiguo Niu wrote:
> Use new Macro IOPRIO_PRIO_LEVEL to get ckpt thread ioprio data(level),
> it is more accurate and consisten with the way setting ckpt thread
> ioprio(IOPRIO_PRIO_VALUE(class, data)).
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 72676c5..55d46da 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -340,7 +340,7 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>   	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>   		struct ckpt_req_control *cprc = &sbi->cprc_info;
>   		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
> -		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
> +		int data = IOPRIO_PRIO_LEVEL(cprc->ckpt_thread_ioprio);

So, can you please use 'level' to instead 'data' in f2fs_sbi_show() and
__sbi_store()?

Thanks,

>   
>   		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
>   			return -EINVAL;


