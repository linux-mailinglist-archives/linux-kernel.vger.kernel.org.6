Return-Path: <linux-kernel+bounces-421831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B39D90A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8BD0B241E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1B44360;
	Tue, 26 Nov 2024 03:10:02 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395E2F85C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590602; cv=none; b=u7ol5NLF181Ji3ZHcl8keE1wwtQ+VDMfVR28yTWgP+JNYjMBE8KcXf3sVluyFSgKEr7Ku3zjb6yN2jsrXPxRcJKIlhksf9cSx5z3rBaKIeRVI+qlkF+4QABPtOmP92Ck+qxN7sGyhfCIPSAEFMt1Vl1LXbAy1JkE6nNk/Ps5sf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590602; c=relaxed/simple;
	bh=mwwX5uSnu021IidzJq3bWzTh13axIG8XJQz4pVfMLIY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CkFU++ta1U8aCYti2GNRQrCmquwSsXse/iexMoUUkwb0cGdRxk970JAC7WPE88OQ6KhxYd3tEnBAEqkvs1ec8xkYuXxaueWfCuE0A1y5gU3u2X2M1z/Sr+jqkHcJ9c5OEwtKMrktFQxsIcNikPjkw8omEAYOYony5WfNb/JuQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xy6yC0tSYz1yqrm;
	Tue, 26 Nov 2024 11:10:11 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 19D651A0188;
	Tue, 26 Nov 2024 11:09:57 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 11:09:56 +0800
Subject: Re: [RFC PATCH] mm: memory-failure: add soft-offline stat in mf_stats
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>
CC: <jiaqiyan@google.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c25e8ca8-5858-987e-6b1e-2e139d901dc5@huawei.com>
Date: Tue, 26 Nov 2024 11:09:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241121045504.2233544-1-misono.tomohiro@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/11/21 12:55, Tomohiro Misono wrote:
> commit 44b8f8bf2438 ("mm: memory-failure: add memory failure stats

Sorry for late, I've been swamped recently.

> to sysfs") introduces per NUMA memory error stats which show
> breakdown of HardwareCorrupted of /proc/meminfo in
> /sys/devices/system/node/nodeX/memory_failure.

Thanks for your patch.

> 
> However, HardwareCorrupted also counts soft-offline pages. So, add
> soft-offline stats in mf_stats too to represent more accurate status.

Adding soft-offline stats makes sense to me.

> 
> This updates total count as:
>   total = recovered + ignored + failed + delayed + soft_offline>
> Test example:
> 1) # grep HardwareCorrupted /proc/meminfo
>      HardwareCorrupted:     0 kB
> 2) soft-offline 1 page by madvise(MADV_SOFT_OFFLINE)
> 3) # grep HardwareCorrupted /proc/meminfo
>      HardwareCorrupted:     4 kB
>    # grep -r "" /sys/devices/system/node/node0/memory_failure
>    /sys/devices/system/node/node0/memory_failure/total:1
>    /sys/devices/system/node/node0/memory_failure/soft_offline:1
>    /sys/devices/system/node/node0/memory_failure/recovered:0
>    /sys/devices/system/node/node0/memory_failure/ignored:0
>    /sys/devices/system/node/node0/memory_failure/failed:0
>    /sys/devices/system/node/node0/memory_failure/delayed:0
> 
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
> ---
> Hello
> 
> This is RFC because I'm not sure adding SOFT_OFFLINE in enum
> mf_result is a right approach. Also, maybe is it better to move
> update_per_node_mf_stats() into num_poisoned_pages_inc()?
> 
> I omitted some cleanups and sysfs doc update in this version to
> highlight changes. I'd appreciate any suggestions.
> 
> Regards,
> Tomohiro Misono
> 
>  include/linux/mm.h     | 2 ++
>  include/linux/mmzone.h | 4 +++-
>  mm/memory-failure.c    | 9 +++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5d6cd523c7c0..7f93f6883760 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3991,6 +3991,8 @@ enum mf_result {
>  	MF_FAILED,	/* Error: handling failed */
>  	MF_DELAYED,	/* Will be handled later */
>  	MF_RECOVERED,	/* Successfully recovered */
> +
> +	MF_RES_SOFT_OFFLINE, /* Soft-offline */

It might not be a good idea to add MF_RES_SOFT_OFFLINE here. 'mf_result' is used to record
the result of memory failure handler. So it might be inappropriate to add MF_RES_SOFT_OFFLINE here.


Thanks.
.


