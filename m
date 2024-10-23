Return-Path: <linux-kernel+bounces-377233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4BF9ABBB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCAD2841A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716E81749;
	Wed, 23 Oct 2024 02:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoDhXfQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43D44CDEC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651348; cv=none; b=KGhxR+C8h3PhuO9X22wSHPlXn4krvNuSdWrf71z6BI5GKnwB3Bh1kTt77rl/w/YD34v53VfTIgwg0TveKGosB+kGtEl0JCVNYLX5SDiCcoPRUx8OG+5W39fEjUS0T+17Hyg5/pOkhheK8M154u/OfzDKyAc5b4syIv+ajxLl0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651348; c=relaxed/simple;
	bh=zmCAxVblrWxgvcfRLK0nZDoD+ZC3BM86UGf4ASXgOBY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qiywCvMgP8CI1PUwPago7nW0k32tNNB06cRVj/KluxrOjCX12KVSuQgoCTV0d+5rB2T0ygCMxUkGrnipdJSjbkICIr8rs0+QenV5ok3HHZPZsCsOCAx59kS3UiXQl5dr3OOyeOSij6cNONersU+fPM5M/w541Rsie/N/BuxaopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoDhXfQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D22EC4CEE4;
	Wed, 23 Oct 2024 02:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729651348;
	bh=zmCAxVblrWxgvcfRLK0nZDoD+ZC3BM86UGf4ASXgOBY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IoDhXfQfFC2mf8gvAAVjFcSlfHCpzeq9Z4wNPH2GOLJJLDW+PFkvCv/fA+cmoumZk
	 x6DrvFLLwovMFNRlFxgWoRN9RliTdpr33kHVgizWexIVcYuFK5xbwAxGFP5aO9hidt
	 nk8i69Oi6J9GLxjIjx45Bl8mOv5zBxPAGsSsl8n7teIxPAwgIfgB+hmZrzxSk+xDKK
	 F1In2AZlH0KfYQeKcG0q2ETpyv32gg+820E6mqEALB+kF1/QuqI5k3RbSJRSLMkW5R
	 AKYLdJmMSSXKjFZVaHR3uX3PcJqQH9TPBpGX7iMt3o6mcy7B+Yq778LMu74GyM0pF5
	 YKZDdwt9JFBNw==
Message-ID: <28ad2c90-a95c-440a-ae6a-5fb19bacd252@kernel.org>
Date: Wed, 23 Oct 2024 10:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH] f2fs: fix to avoid use GC_AT when setting gc_mode as
 GC_URGENT_MID
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1729588481-29390-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1729588481-29390-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 17:14, Zhiguo Niu wrote:
> GC_URGENT_MID is introduced by commit
> d98af5f45520 ("f2fs: introduce gc_urgent_mid mode"), aim to does GC
> forcibly uses cost benefit GC approach, but if ATGC is enabled at
> the same time, Age-threshold approach will be selected, which can only
> do amount of GC and it is much less than the numbers of CB approach.

gc urgent low(2): lowers the bar of checking I/O idling in
		  order to process outstanding discard commands and GC a
		  little bit aggressively. uses cost benefit GC approach.

GC_URGENT_LOW uses CB algorithm as well?

Thanks,

> 
> some traces:
>    f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
>    f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
> 
> Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/gc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd1..daecf69 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -257,6 +257,7 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
>   
>   	switch (sbi->gc_mode) {
>   	case GC_IDLE_CB:
> +	case GC_URGENT_MID:
>   		gc_mode = GC_CB;
>   		break;
>   	case GC_IDLE_GREEDY:


