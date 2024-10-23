Return-Path: <linux-kernel+bounces-377187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E39ABB02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE257284DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A6028DD0;
	Wed, 23 Oct 2024 01:27:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB255896
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646875; cv=none; b=lQdtQ8xB8VLzCy5hVtcL9k+bA/oRhWIcpTeKP6q8G6SMLUCzTVBFEQTH45fAaWiyGLmFduoyU5OT7jkbTX8mRO8EJEaxcCJxpAXC/iLkgnUGKDJtv1oFWqSh4ZRDmtZU56q1xarEGF+oHV73Nj/KGSeRTQUDbfMHJbOOXJGUKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646875; c=relaxed/simple;
	bh=Cd3w/qucgjkjHi54Wn7fHFRhzvTWQIR73dNejp0ctmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iI8ah6STley4XhhEeco1g1+V4+kw3Y+d65beEvCjtnu2S/wiyyH/eqdfjPGAq+RixHKs3gbWAJM8Zi9wa541wwg6pLjvtKZFSWf8RC3qauJSrIPNE4+gWKv+sFA5idlLMSsYajWcF4dm1tybb6Pyre7o4BfzW/ZvQUMcxsT8EhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYBHX5ZNXz4f3jkd
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:27:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1B8951A0196
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:27:49 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8QTURhnBDttEw--.15426S3;
	Wed, 23 Oct 2024 09:27:48 +0800 (CST)
Message-ID: <69dc6dac-b353-b280-4874-68466e817299@huaweicloud.com>
Date: Wed, 23 Oct 2024 09:27:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/2] mm/damon/vaddr: Fix issue in
 damon_va_evenly_split_region()
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, foersleo@amazon.de,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev,
 sieberf@amazon.com, yeweihua4@huawei.com
References: <20241022180537.42492-1-sj@kernel.org>
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20241022180537.42492-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHR8QTURhnBDttEw--.15426S3
X-Coremail-Antispam: 1UD129KBjvJXoWrZr47WFy8GF43Xw48trW5Wrg_yoW8JF4Up3
	Z3Wa15tFyvkry8u3Wxua1av3Wkt3y8J345GFyUtrnYkwnYga4ayF1Igw4jk34UCry3C3W2
	va10qFZ3CFn5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/10/23 02:05, SeongJae Park wrote:
> Hi Zheng,
> 
> On Tue, 22 Oct 2024 16:39:25 +0800 Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> 
> [...]
>> To fix it, count for each piece split and make sure no more than
>> 'nr_pieces'. In addition, add above case into damon_test_split_evenly().
>>
>> And add 'nr_piece == 1' check in damon_va_evenly_split_region()
>> for better code readability and add a corresponding kunit testcase.
>>
>> Zheng Yejian (2):
>>    mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
>>    mm/damon/vaddr: Check 'nr_piece == 1' case in
>>      damon_va_evenly_split_region()
>>
>>   mm/damon/tests/vaddr-kunit.h | 2 ++
>>   mm/damon/vaddr.c             | 7 +++++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Thank you for addressing my comments and posting this new patch series.  I
> added my Reviewed-by: tags with some trivial comments to the patches.
> 

Thanks for your review and comments !

> Btw, at least on DAMON mailing list, we usually post new revisions as new
> threads, rather than as a reply to the previous revision.  If you want to make
> sure involved people aware of the new series, you can send the lore link for
> the new series as a reply to the previous revision.
> 

Got it :)

> 
> Thanks,
> SJ

-- 
Thanks,
Zheng Yejian


