Return-Path: <linux-kernel+bounces-205218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD48FF994
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27061F23CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7713101E6;
	Fri,  7 Jun 2024 01:32:39 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA7320E;
	Fri,  7 Jun 2024 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723959; cv=none; b=pEhgYj6zXB/rFxAHJq19eI0OIAg8cP5q3ahLj5x8Jt8D4P6DFDhL5N4UPzzLZ020DlK7EVP4bXN7L7R3eRDuR2D8j8HwmcprvX6VzsfI1isye3xXnojjPiU+G+pECzX/h2mG8U4FFklNOu+eBUMHKkcyfYYuFBrNojYfGED0Q5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723959; c=relaxed/simple;
	bh=tJJ8w700Y5azze14mZ9VNXAQIMtjQyGHpE2yUrduT7A=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uOi03is8cwlL5lFh/3JYEQWNRG1ctIERFBURjpwmwX9HZw3BsZkN+b1TQ+DL6ug7ebNmrJM1Y8eLlwcK2e8RiwqaaJPK3Wu/tqvkKI+koOBQKo8BrIDLaoDn+/+xhwzK+iBEjLxfLD4MTDcYJeEZeHH65BxY9PhNhnwLDo3x9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VwNwj3CHBz4f3jsP;
	Fri,  7 Jun 2024 09:32:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 357A21A0BD4;
	Fri,  7 Jun 2024 09:32:31 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw4tY2JmAauZPA--.64625S3;
	Fri, 07 Jun 2024 09:32:31 +0800 (CST)
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
To: Ming Lei <ming.lei@redhat.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmJQwvBXfm3zw+Xs@fedora>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
From: yebin <yebin@huaweicloud.com>
Message-ID: <6662632D.7020000@huaweicloud.com>
Date: Fri, 7 Jun 2024 09:32:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmJQwvBXfm3zw+Xs@fedora>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw4tY2JmAauZPA--.64625S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1kurW3tr47Wr4xGrWUtwb_yoW7Ar1rpr
	W8tF1jkr48Xr47XF47XF17Jr4Ika1UAF1UGr4xZryrXF98Zwn0qr1UGryUX3WrCrs5uryI
	qr1qq34vqrn8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/



On 2024/6/7 8:13, Ming Lei wrote:
> On Thu, Jun 06, 2024 at 02:26:55PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's a issue as follows when do format NVME with IO:
>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>> PGD 101727f067 P4D 1011fae067 PUD fbed78067 PMD 0
>> Oops: 0000 [#1] SMP NOPTI
>> RIP: 0010:kfree+0x4f/0x160
>> RSP: 0018:ff705a800912b910 EFLAGS: 00010247
>> RAX: 0000000000000000 RBX: 0d06d30000000000 RCX: ff4fb320260ad990
>> RDX: ff4fb30ee7acba40 RSI: 0000000000000000 RDI: 00b04cff80000000
>> RBP: ff4fb30ee7acba40 R08: 0000000000000200 R09: ff705a800912bb60
>> R10: 0000000000000000 R11: ff4fb3103b67c750 R12: ffffffff9a62d566
>> R13: ff4fb30aa0530000 R14: 0000000000000000 R15: 000000000000000a
>> FS:  00007f4399b6b700(0000) GS:ff4fb31040140000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000000008 CR3: 0000001014cd4002 CR4: 0000000000761ee0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>> PKRU: 55555554
>> Call Trace:
>>   bio_integrity_free+0xa6/0xb0
>>   __bio_integrity_endio+0x8c/0xa0
>>   bio_endio+0x2b/0x130
>>   blk_update_request+0x78/0x2b0
>>   blk_mq_end_request+0x1a/0x140
>>   blk_mq_try_issue_directly+0x5d/0xc0
>>   blk_mq_make_request+0x46b/0x540
>>   generic_make_request+0x121/0x300
>>   submit_bio+0x6c/0x140
>>   __blkdev_direct_IO_simple+0x1ca/0x3a0
>>   blkdev_direct_IO+0x3d9/0x460
>>   generic_file_read_iter+0xb4/0xc60
>>   new_sync_read+0x121/0x170
>>   vfs_read+0x89/0x130
>>   ksys_read+0x52/0xc0
>>   do_syscall_64+0x5d/0x1d0
>>   entry_SYSCALL_64_after_hwframe+0x65/0xca
>>
>> Assuming a 512 byte directIO is issued, the initial logical block size of
>> the state block device is 512 bytes, and then modified to 4096 bytes.
>> Above issue may happen as follows:
>>           Direct read                    format NVME
>> __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>    if ((pos | iov_iter_alignment(iter)) & (bdev_logical_block_size(bdev) - 1))
>> 	-->The logical block size is 512, and the IO issued is 512 bytes,
>> 	   which can be checked
>>      return -EINVAL;
>>    submit_bio(&bio);
>>                                        nvme_dev_ioctl
>>                                          case NVME_IOCTL_RESCAN:
>>                                            nvme_queue_scan(ctrl);
>>                                               ...
>>                                              nvme_update_disk_info(disk, ns, id);
>>                                                blk_queue_logical_block_size(disk->queue, bs);
>>                                                  --> 512->4096
>>       blk_queue_enter(q, flags)
>>       blk_mq_make_request(q, bio)
>>         bio_integrity_prep(bio)
>> 	 len = bio_integrity_bytes(bi, bio_sectors(bio));
>> 	   -->At this point, because the logical block size has increased to
>> 	      4096 bytes, the calculated 'len' here is 0
>>           buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
>> 	   -->Passed in len=0 and returned buf=16
>>           end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>           start = ((unsigned long) buf) >> PAGE_SHIFT;
>>           nr_pages = end - start;  -->nr_pages == 1
>>           bip->bip_flags |= BIP_BLOCK_INTEGRITY;
>>           for (i = 0 ; i < nr_pages ; i++) {
>>             if (len <= 0)
>>                -->Not initializing the bip_vec of bio_integrity, will result
>> 		 in null pointer access during subsequent releases. Even if
>> 		 initialized, it will still cause subsequent releases access
>> 		 null pointer because the buffer address is incorrect.
>>               break;
>>
>> Firstly, it is unreasonable to format NVME in the presence of IO. It is also
>> possible to see IO smaller than the logical block size in the block layer for
>> this type of concurrency. It is expected that this type of IO device will
>> return an error, so exception handling should also be done for this type of
>> IO to prevent null pointer access from causing system crashes.
> Actually unaligned IO handling is one mess for nvme hardware. Yes, IO may fail,
> but it is observed that meta buffer is overwrite by DMA in read IO.
>
> Ye and Yi, can you test the following patch in your 'nvme format' & IO workload?
>
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 82c3ae22d76d..a41ab4a3a398 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -336,6 +336,19 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>   	return 0;
>   }
>   
> +static bool bio_unaligned(struct bio *bio)
> +{
> +	unsigned int bs = bdev_logical_block_size(bio->bi_bdev);
> +
> +	if (bio->bi_iter.bi_size & (bs - 1))
> +	        return true;
> +
> +	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1))
> +	        return true;
> +
> +	return false;
> +}
I think this judgment is a bit incorrect. It should not be sufficient to 
only determine whether
the length and starting sector are logically block aligned.
> +
>   int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>   {
>   	while (!blk_try_enter_queue(q, false)) {
> @@ -362,6 +375,15 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>   			   test_bit(GD_DEAD, &disk->state));
>   		if (test_bit(GD_DEAD, &disk->state))
>   			goto dead;
> +		/*
> +		 * Not like other queue limits, logical block size is one
> +		 * fundamental limit which can't be covered by bio split.
> +		 *
> +		 * Device reconfiguration may happen and logical block size
> +		 * is changed, so fail the IO if that is true.
> +		 */
> +		if (bio_unaligned(bio))
> +			goto dead;
>   	}
>   
>   	return 0;
>
> Thanks,
> Ming
>
>


