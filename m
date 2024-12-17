Return-Path: <linux-kernel+bounces-449098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DE9F49DA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58F41889FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A541EC00F;
	Tue, 17 Dec 2024 11:27:19 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3750276
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434838; cv=none; b=t1nhM3YGNyyvODkAVwqgjw+2iNGZuNSfBbRK60d4SS1BHLt1oh5K/Pl36Zb4ISWQn30w/3+Gvx7EafqxZaoXgITbLVyfwwI4/t4WKGdccvxe4u3cemF3bDrHK3raw0NXms1I5NqVLMzSzJ/qag+G4comavOXLu1bzFEI0Zw+DEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434838; c=relaxed/simple;
	bh=vqALQt09fwYnd0MOAWYVVvbDKV3l718+gC/GiJHJjMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFWSUtgyiceSUrOIM43hyWGAu7av2s+E+G87z1FwUPqNnPRNroKSFFRZHmyCq8koVLnQvScqr/tE0IW4zDQ6aiA5ALR/vhz/XwH6bf+5GA/yk6SxOxxcB4r87b3CTbu6Bn4+IJCoVx/yzXkJ20yqdOVgwcp3TTwqApKc8GZdgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCDzZ1XDMz4f3lDK
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:26:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B35851A07BA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:27:10 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgAXP4MLYGFnpi5sEw--.55710S3;
	Tue, 17 Dec 2024 19:27:08 +0800 (CST)
Message-ID: <30e13c1c-5dd7-da94-9d2a-6277ade3e9e4@huaweicloud.com>
Date: Tue, 17 Dec 2024 19:27:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] maple_tree: Fix mas_alloc_cyclic() second search
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, brauner@kernel.org
References: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
 <20241216190113.1226145-2-Liam.Howlett@oracle.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241216190113.1226145-2-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXP4MLYGFnpi5sEw--.55710S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWkWF4xWr4rKFy5Cr18Grg_yoW8Gw45pa
	1DWa1UKrZ7Jr48Kw1kWrWUXas2qrnYgr1xWayDJw1rZry5JFySgr15CFWfuF47Z3srA3Wa
	yF4av3W0ka4DZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/17 3:01, Liam R. Howlett 写道:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The first search may leave the maple state in an error state.  Reset the
> maple state before the second search so that the search has a chance of
> executing correctly after an exhausted first search.
> 
> Link: https://lore.kernel.org/all/20241216060600.287B4C4CED0@smtp.kernel.org/
> Fixes: 9b6713cc7522 ("maple_tree: Add mtree_alloc_cyclic()")
> Cc: Yang Erkun <yangerkun@huaweicloud.com>
> Cc: chuck.lever@oracle.com
> Cc: brauner@kernel.org
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>   lib/maple_tree.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

This looks more clear!

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 940d30653407b..f7153ade1be5f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4335,7 +4335,6 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
>   {
>   	unsigned long min = range_lo;
>   	int ret = 0;
> -	struct ma_state m = *mas;
>   
>   	range_lo = max(min, *next);
>   	ret = mas_empty_area(mas, range_lo, range_hi, 1);
> @@ -4344,7 +4343,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
>   		ret = 1;
>   	}
>   	if (ret < 0 && range_lo > min) {
> -		*mas = m;
> +		mas_reset(mas);
>   		ret = mas_empty_area(mas, min, range_hi, 1);
>   		if (ret == 0)
>   			ret = 1;


