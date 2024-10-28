Return-Path: <linux-kernel+bounces-384546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008DB9B2B95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1789F1C21C64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A889918801F;
	Mon, 28 Oct 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RetUAL2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587817DFF2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108040; cv=none; b=ha//6tay7P5/6wLM5kGmoTKEa6McNxjHcrYxI/3QPSPTTpxbcSExxuejqgLdyoGRxHDDbCpWNQLIMCVnK0XDYxdGR2tz7adeVj1L4KMHVEjzUBeXgCWR7m3wWlX1Zrq9OQr1vrwmboge/+l0zTEewgTR9MVCO/o3HjCwjJ4O+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108040; c=relaxed/simple;
	bh=dnGFplpXtdXmv74hrDBEMPzNNFSWKG3VBi8j7yZuIJM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hwyXZAkHD42Qp+dA/a9a0j3YMqD7521kHgfHSOCeChtgrIf4ekBjvIVB6VDQ72EwQzM6I0h5ilPZwNrbP+IS/u5+Ajj0yLFrIX7qgfDobx2+xMRUF1ak04RoFc+tqw0pP3Dk2TniiVVsHGwi5VXCQGhNMv+yJwqG53xOl/8k7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RetUAL2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D486BC4CEC3;
	Mon, 28 Oct 2024 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730108039;
	bh=dnGFplpXtdXmv74hrDBEMPzNNFSWKG3VBi8j7yZuIJM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RetUAL2P7RQI6rmFqD5AhYhCGx+dYZi0q407G+GHWBgtJOkwPzOlzzjjHRzXdVHf7
	 BGXtJIHFybBT84XUuDEkI8RsmmOv7gLpPdKF3ATeSe/pXWY0MJzmiJJE6b2aeXRY4m
	 nJLKFG6ec+d3DKbTmRyhrBWexlNdrSQKUtFLxV2BUjJ4tgd6DrTJ6Y67x7870Q1erC
	 CEYCbTDh4fNwqtBuBHOwX1LCaemttEkJSoUl8JtssXLNZT560KonXBENPEwnDIUdJ2
	 XRNvW91o36FSSdiuOU2FOSNYP0m/ClUoMM5OHiS02x3dMSl2UK6oKiinBpj0R8prrV
	 LZ/JmH6t75Zrw==
Message-ID: <7d68560a-19ea-455c-ba23-1dda32ed4d15@kernel.org>
Date: Mon, 28 Oct 2024 17:33:55 +0800
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
Subject: Re: [PATCH V2] f2fs: fix to avoid use GC_AT when setting gc_mode as
 GC_URGENT_LOW or GC_URGENT_MID
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1729652883-12202-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/23 11:08, Zhiguo Niu wrote:
> If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
> approach should be used, but if ATGC is enabled at the same time,
> Age-threshold approach will be selected, which can only do amount of
> GC and it is much less than the numbers of CB approach.

The code looks fine to me, there is one more thing, can you please update
description of gc_urgent in sysfs-fs-f2fs? so it can describe explicitly
that configuring gc_urgent to low or mid will setup GC_CB GC policy which
will override GC_AT.

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
> Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
> Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> v2: make GC_URGENT_LOW also use CB approach
> ---
>   fs/f2fs/gc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e40bdd1..3e1b6d2 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -257,6 +257,8 @@ static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
>   
>   	switch (sbi->gc_mode) {
>   	case GC_IDLE_CB:
> +	case GC_URGENT_LOW:
> +	case GC_URGENT_MID:
>   		gc_mode = GC_CB;
>   		break;
>   	case GC_IDLE_GREEDY:


