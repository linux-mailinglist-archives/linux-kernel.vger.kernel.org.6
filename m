Return-Path: <linux-kernel+bounces-169902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E627E8BCF29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A9BB23A13
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99B78C7B;
	Mon,  6 May 2024 13:35:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C678120A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002536; cv=none; b=VmIHZYYRqtNIxPHOqPSkLRNShTZ9NZINkGMSALXMpfWkuJsS3+u5DUQ/GPzNb1PM/bfAZvsrt952svPwu82U3kRhWpWA717M6kh664IKi4vc54eg8Js4lSS63nDqJQ03F1URfmzKHuO8q6InSY6W490JeYhau9hzjMlTnvQiQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002536; c=relaxed/simple;
	bh=2qVCIVjrXQjhdmjyGyo9eB0vRsHKN3medse5AJKFATI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1q3gKHEsBVjlbzY/2PO8gYVa9d/2IUW6m+QOZxcFrw6OYJQkrIM+5f9932jb0dwUf6uYkhwsfNHN/la92NJStnYDDmxNB3xHiLz7qRfRd6wC3odcpq0yLPkGoXT9eOWm8qfceET6YmUjR1mGv1hQee7msYTpKfJ8vopi/Owj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY2Tm24sGz4f3lXG
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:35:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 886211A0905
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:35:29 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgC32w6a3DhmpivTMA--.53986S3;
	Mon, 06 May 2024 21:35:29 +0800 (CST)
Message-ID: <9bad9355-5b5a-de61-8c53-6e65ed3332b1@huaweicloud.com>
Date: Mon, 6 May 2024 21:35:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ubi: block: fix null-pointer-dereference in
 ubiblock_create()
To: Zhihao Cheng <chengzhihao1@huawei.com>, richard@nod.at,
 miquel.raynal@bootlin.com, vigneshr@ti.com, axboe@kernel.dk,
 chaitanya.kulkarni@wdc.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20240428071922.2270892-1-linan666@huaweicloud.com>
 <98698009-e3a2-5c00-7619-6b6e3422cd1b@huawei.com>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <98698009-e3a2-5c00-7619-6b6e3422cd1b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC32w6a3DhmpivTMA--.53986S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1xAr4DJryruFyUXFW3Awb_yoW5GFyUpF
	4kWa4jqrWrCrykWF4DJw1UCFy5Xw4UG3Z5Gr47Z3W8ZrWrJr1Igr4qqr1jgr48Jr4xJanI
	qF1UWrW8uF1xJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67
	AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
	Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU17DG7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/



在 2024/4/28 15:51, Zhihao Cheng 写道:
> 在 2024/4/28 15:19, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> Similar to commit adbf4c4954e3 ("ubi: block: fix memleak in
>> ubiblock_create()"), 'dev->gd' is not assigned but dereferenced if
>> blk_mq_alloc_tag_set() fails, and leading to a null-pointer-dereference.
>>
>> Using 'gd' directly here is not a good idea, too. 'gd->part0.bd_device'
>> is not initialized at this point. The error log will be:
>>    block (null): block: dynamic minor allocation failed
>>
>> Fix it by using pr_err() and print ubi id.
>>
>> Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> ---
>>   drivers/mtd/ubi/block.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
>> index f82e3423acb9..bf7308e8ec2f 100644
>> --- a/drivers/mtd/ubi/block.c
>> +++ b/drivers/mtd/ubi/block.c
>> @@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>>       ret = blk_mq_alloc_tag_set(&dev->tag_set);
>>       if (ret) {
>> -        dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
>> +        pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
>> +            dev->ubi_num, dev->vol_id);
>>           goto out_free_dev;
>>       }
>> @@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
>>       gd->minors = 1;
>>       gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, 
>> GFP_KERNEL);
> 
> There is no need to modify this place. The device of 'gd' is initialized in 
> blk_mq_alloc_disk. Refer to nbd_dev_add.


The print of this dev_err() is:
   block (null): block: dynamic minor allocation failed
	~~~~~~
There is no information about which device failed. dev_err()
use 'kobject_name(&dev->kobj)' here, which is init in device_add_disk()
later. So use pr_err() here can print more detail.

I will split the patch into two in v2 to make it clearer.

>>       if (gd->first_minor < 0) {
>> -        dev_err(disk_to_dev(gd),
>> -            "block: dynamic minor allocation failed");
>> +        pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
>> +            dev->ubi_num, dev->vol_id);
>>           ret = -ENODEV;
>>           goto out_cleanup_disk;
>>       }
>>

-- 
Thanks,
Nan


