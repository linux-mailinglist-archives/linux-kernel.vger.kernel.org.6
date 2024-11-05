Return-Path: <linux-kernel+bounces-396081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F29BC7BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1979A1C22338
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5AF1FF02B;
	Tue,  5 Nov 2024 08:09:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1518873E;
	Tue,  5 Nov 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794171; cv=none; b=O9ffYbWcW07CtTN+keRWPCOEbFFtxvARiQxiHdNvSQKnjiSFYFoNmhGCvl5IdaDaK8CKi+3XskI1nCmBZA8GdgFPh5DNwo7INsnWA3SWDGKVFYL/etdeqVecXCky1FoZfzhl395hmmxfGI84PcpSFnTsJn47AxfkfRPFWBmsFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794171; c=relaxed/simple;
	bh=wK/PZv3yqK8EESsXCwoqSMsk+5FEJSDRoh6t0UXEYeA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SluaARM4yuHfMaZtX1JNK7OdeS2NhiqOZAl4G2xtUV+iNGyeyAZR1hjbm2umyV7Hx6V1tEwC9CwN1xTEtl6BGI2o+gI9l7wsnj/QevW5VWocV9ynFK2dbTWJWcgIy8ku9IXs+HB7QTpvisIALVpq7agSpsyFWuQ5pbLvpxSqAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjLZm5WtYz4f3mHT;
	Tue,  5 Nov 2024 16:09:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8F3A41A0568;
	Tue,  5 Nov 2024 16:09:23 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4ex0ilnLyCgAw--.62494S3;
	Tue, 05 Nov 2024 16:09:23 +0800 (CST)
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <ZynG3g8o_iLOjwai@fedora>
 <88ffc0a3-10ab-e6fd-01e1-57ff8011c257@huaweicloud.com>
 <ZynQCXVc5OjGaF-1@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8afb2c46-201b-0a0d-c5f8-484c0b84492b@huaweicloud.com>
Date: Tue, 5 Nov 2024 16:09:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZynQCXVc5OjGaF-1@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4ex0ilnLyCgAw--.62494S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy5tr48ZrW8XFWUXr1DJrb_yoW3JryUpr
	Z5JayxAw10qryjv397t3W7JFyFvrs8Kr1xJFnagrn3ZFyq9ry7tayv9F1jgFy8CF4vyF4U
	ZF1DtrWUWw1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/05 15:58, Ming Lei 写道:
> On Tue, Nov 05, 2024 at 03:36:36PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/11/05 15:18, Ming Lei 写道:
>>> On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
>>>> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
>>>> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
>>>> atomic mode after del_gendisk"), hence for disk like scsi, following
>>>> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
>>>> cause following uaf that is found by our syzkaller for v6.6:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: slab-use-after-free in blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
>>>> Read of size 4 at addr ffff88811c969c20 by task kworker/1:2H/224909
>>>>
>>>> CPU: 1 PID: 224909 Comm: kworker/1:2H Not tainted 6.6.0-ga836a5060850 #32
>>>> Workqueue: kblockd blk_mq_timeout_work
>>>> Call Trace:
>>>>
>>>> __dump_stack lib/dump_stack.c:88 [inline]
>>>> dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
>>>> print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
>>>> print_report+0x3e/0x70 mm/kasan/report.c:475
>>>> kasan_report+0xb8/0xf0 mm/kasan/report.c:588
>>>> blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
>>>> bt_iter block/blk-mq-tag.c:288 [inline]
>>>> __sbitmap_for_each_set include/linux/sbitmap.h:295 [inline]
>>>> sbitmap_for_each_set include/linux/sbitmap.h:316 [inline]
>>>> bt_for_each+0x455/0x790 block/blk-mq-tag.c:325
>>>> blk_mq_queue_tag_busy_iter+0x320/0x740 block/blk-mq-tag.c:534
>>>> blk_mq_timeout_work+0x1a3/0x7b0 block/blk-mq.c:1673
>>>> process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
>>>> process_scheduled_works kernel/workqueue.c:2704 [inline]
>>>> worker_thread+0x804/0xe40 kernel/workqueue.c:2785
>>>> kthread+0x346/0x450 kernel/kthread.c:388
>>>> ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>>>> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
>>>>
>>>> Allocated by task 942:
>>>> kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
>>>> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>>>> ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>>>> __kasan_kmalloc mm/kasan/common.c:383 [inline]
>>>> __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:380
>>>> kasan_kmalloc include/linux/kasan.h:198 [inline]
>>>> __do_kmalloc_node mm/slab_common.c:1007 [inline]
>>>> __kmalloc_node+0x69/0x170 mm/slab_common.c:1014
>>>> kmalloc_node include/linux/slab.h:620 [inline]
>>>> kzalloc_node include/linux/slab.h:732 [inline]
>>>> blk_alloc_flush_queue+0x144/0x2f0 block/blk-flush.c:499
>>>> blk_mq_alloc_hctx+0x601/0x940 block/blk-mq.c:3788
>>>> blk_mq_alloc_and_init_hctx+0x27f/0x330 block/blk-mq.c:4261
>>>> blk_mq_realloc_hw_ctxs+0x488/0x5e0 block/blk-mq.c:4294
>>>> blk_mq_init_allocated_queue+0x188/0x860 block/blk-mq.c:4350
>>>> blk_mq_init_queue_data block/blk-mq.c:4166 [inline]
>>>> blk_mq_init_queue+0x8d/0x100 block/blk-mq.c:4176
>>>> scsi_alloc_sdev+0x843/0xd50 drivers/scsi/scsi_scan.c:335
>>>> scsi_probe_and_add_lun+0x77c/0xde0 drivers/scsi/scsi_scan.c:1189
>>>> __scsi_scan_target+0x1fc/0x5a0 drivers/scsi/scsi_scan.c:1727
>>>> scsi_scan_channel drivers/scsi/scsi_scan.c:1815 [inline]
>>>> scsi_scan_channel+0x14b/0x1e0 drivers/scsi/scsi_scan.c:1791
>>>> scsi_scan_host_selected+0x2fe/0x400 drivers/scsi/scsi_scan.c:1844
>>>> scsi_scan+0x3a0/0x3f0 drivers/scsi/scsi_sysfs.c:151
>>>> store_scan+0x2a/0x60 drivers/scsi/scsi_sysfs.c:191
>>>> dev_attr_store+0x5c/0x90 drivers/base/core.c:2388
>>>> sysfs_kf_write+0x11c/0x170 fs/sysfs/file.c:136
>>>> kernfs_fop_write_iter+0x3fc/0x610 fs/kernfs/file.c:338
>>>> call_write_iter include/linux/fs.h:2083 [inline]
>>>> new_sync_write+0x1b4/0x2d0 fs/read_write.c:493
>>>> vfs_write+0x76c/0xb00 fs/read_write.c:586
>>>> ksys_write+0x127/0x250 fs/read_write.c:639
>>>> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>>>> do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
>>>> entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>>>
>>>> Freed by task 244687:
>>>> kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
>>>> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>>>> kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
>>>> ____kasan_slab_free mm/kasan/common.c:236 [inline]
>>>> __kasan_slab_free+0x12a/0x1b0 mm/kasan/common.c:244
>>>> kasan_slab_free include/linux/kasan.h:164 [inline]
>>>> slab_free_hook mm/slub.c:1815 [inline]
>>>> slab_free_freelist_hook mm/slub.c:1841 [inline]
>>>> slab_free mm/slub.c:3807 [inline]
>>>> __kmem_cache_free+0xe4/0x520 mm/slub.c:3820
>>>> blk_free_flush_queue+0x40/0x60 block/blk-flush.c:520
>>>> blk_mq_hw_sysfs_release+0x4a/0x170 block/blk-mq-sysfs.c:37
>>>> kobject_cleanup+0x136/0x410 lib/kobject.c:689
>>>> kobject_release lib/kobject.c:720 [inline]
>>>> kref_put include/linux/kref.h:65 [inline]
>>>> kobject_put+0x119/0x140 lib/kobject.c:737
>>>> blk_mq_release+0x24f/0x3f0 block/blk-mq.c:4144
>>>> blk_free_queue block/blk-core.c:298 [inline]
>>>> blk_put_queue+0xe2/0x180 block/blk-core.c:314
>>>> blkg_free_workfn+0x376/0x6e0 block/blk-cgroup.c:144
>>>> process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
>>>> process_scheduled_works kernel/workqueue.c:2704 [inline]
>>>> worker_thread+0x804/0xe40 kernel/workqueue.c:2785
>>>> kthread+0x346/0x450 kernel/kthread.c:388
>>>> ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>>>> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
>>>>
>>>> Other than blk_mq_clear_flush_rq_mapping(), the flag is only used in
>>>> blk_register_queue() from initialization path, hence it's safe not to
>>>> clear the flag in del_gendisk. And since QUEUE_FLAG_REGISTERED already
>>>> make sure that queue should only be registered once, there is no need
>>>> to test the flag as well.
>>>
>>> But disk can be added again in case of sd rebind, so the check should be
>>> kept.
>>
>> I don't understand yet, I mean the other flag QUEUE_FLAG_REGISTERED can
>> cover the case to call percpu_ref_switch_to_percpu() for the rebind
>> case, the flag QUEUE_FLAG_INIT_DONE now is useless other than
>> blk_mq_clear_flush_rq_mapping().
> 
> OK, looks fine, since queue usage counter only works in percpu mode with
> disk attached for !GD_OWNS_QUEUE, maybe QUEUE_FLAG_INIT_DONE can be renamed
> too, but anyway:

Yeah, I do think about rename this flag, but I don't come up with a
better name myself. :)
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review!
Kuai

> 
> 
> Thanks,
> Ming
> 
> 
> .
> 


