Return-Path: <linux-kernel+bounces-414437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC509D27F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C5F1F26ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DE1CC14A;
	Tue, 19 Nov 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="odsWDnIQ"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB741CEAB7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025899; cv=none; b=p22Asjx4sILJEHBMhS7RdCKNxOloQBpU/lvqyh9ykh/2H5x2na+AHPJ33Opjj0hF00fi3c6rm9phg3m50Sg81hrNfCjWX4qzCFMe3CIMHaQdn95y8POWfm5KRtMKflS108CRZLXVG/iDQlV33zHu8A6NHkMbOq+D7vb9p9BlZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025899; c=relaxed/simple;
	bh=ukG8C7BWHe5Y+Qa15kKWaBrlUzdwqACwP9Mhv+C5z4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw60umyrKzgLnf0B1Mxxuib3mATuQ4IcAjOiT6geMD1MeJ3PUxyJqqTgFzOi8VIugZgF1kP+hRUQ4/GjRJ7tw7p1St9/R5AiI/1Z3UYEwsrtOBArfMu91WKO9so4vvlv/Vas+xv8rlmI1jkLN87zcbeOZRdbX7ljU7OfPws0KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=odsWDnIQ; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71811707775so1642600a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732025894; x=1732630694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YCU4Ph89eGeckmMQE/mFPhmJ8uD9/JrjqWEnMFrytk=;
        b=odsWDnIQ2z8Uom7kZsjSqy5cZZUnP/5iFCAv14+HNJo3WxrW53vDiuH1B+rD2jNPUS
         LI4EeD2lFMxqfXeZSgjnFtyl/tEfnLqtMGaAE24k590DLRtQ9VkfQLKgBdNeCPkjfG2j
         dDurjWYSpjXEwrmXs8QRBeZ6KzANclTeVwUagYMS42T6vWD+nXjx9/ipxV4N/rvonypH
         OU/pGqaHRGsBFZXGtiWzVZCrL4KBJY6Fp4nogQwU1bt68CxZ0v6CKhTLb1UmBqdkJ/+m
         mAbPZuLdez4YRek2wPEIC3zy42pihnbbGr6RYVunk2zi9Ibr2vBHnzKIaOkbusfXHN/7
         xDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732025894; x=1732630694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YCU4Ph89eGeckmMQE/mFPhmJ8uD9/JrjqWEnMFrytk=;
        b=KUcnM9NNvF4Jz+DO6XgowTe8ThgfDDYSqhYTzrPsvsm2aV+/2a4acpUeCsowKFgRmu
         2NUItjppQZH9Isk3/zuA+cWLkt1KvLUyH/jHqHrLO0p8B5emDBg/Kv545RI/nIDB1iCi
         zB5aOIKa7TUxErf2yX7ua0AdXJUjI0L2RkU4aNZ+Y+i0lfmC74sqOXSrBCCKVPqFF9IP
         I5+r5xmyLqvyIK/9pFxgvcRMdCa2mmF1mAK/UnqVf5GJYEAV5EEiDQlULWJrI8VFRfB/
         xBJSs6NyJSaTO5I77e2P8MqVovAQjWWMzpqrqygJJh6SqIjzBnt1K3JDtlJw4/3aJsk5
         FLRA==
X-Forwarded-Encrypted: i=1; AJvYcCWkL3r71dFUwYl2fIspkU/iLF4LFk8yhMh1MN6xh0d/ufwLmm/GTC60/PZvWhNNiUnkQZ8JEqXiSAN3eSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdl0ISrXxkI8drLyXcO3KONYZbk/BVp0oKkIZeA8AG1T7BBme8
	+BZHAcdwa4S8lY03CLG2hiOI3x57HajhgG17gkVXg2PR7TkCTqlCC5KMv5aMJeA=
X-Google-Smtp-Source: AGHT+IGY3SFdEky/5fs9T+pnu4Xtp8lHfryoBMtEYmwNi+RxIEv73jAdUtTIrBPSopGCOhID4f786w==
X-Received: by 2002:a05:6830:4901:b0:718:bdd:d1d8 with SMTP id 46e09a7af769-71a7792e95amr14314195a34.8.1732025894587;
        Tue, 19 Nov 2024 06:18:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a781a18e0sm3368901a34.51.2024.11.19.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 06:18:13 -0800 (PST)
Message-ID: <74141e63-d946-421a-be4e-4823944dd8c9@kernel.dk>
Date: Tue, 19 Nov 2024 07:18:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [exfat?] possible deadlock in fat_count_free_clusters
To: Ming Lei <ming.lei@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-block@vger.kernel.org,
 syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com>,
 linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
 syzkaller-bugs@googlegroups.com
References: <67313d9e.050a0220.138bd5.0054.GAE@google.com>
 <8734jxsyuu.fsf@mail.parknet.co.jp>
 <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9+FmQLLQkO7EUKnuuj+mpSUOY3EeUxSpXjJUvWtKfz26w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/19/24 5:10 AM, Ming Lei wrote:
> On Tue, Nov 12, 2024 at 12:44 AM OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> wrote:
>>
>> Hi,
>>
>> syzbot <syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com> writes:
>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1621bd87980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> This patch is to fix the above race. Please check this.
>>
>> Thanks
>>
>>
>> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Subject: [PATCH] loop: Fix ABBA locking race
>> Date: Mon, 11 Nov 2024 21:53:36 +0900
>>
>> Current loop calls vfs_statfs() while holding the q->limits_lock. If
>> FS takes some locking in vfs_statfs callback, this may lead to ABBA
>> locking bug (at least, FAT fs has this issue actually).
>>
>> So this patch calls vfs_statfs() outside q->limits_locks instead,
>> because looks like there is no reason to hold q->limits_locks while
>> getting discard configs.
>>
>> Chain exists of:
>>   &sbi->fat_lock --> &q->q_usage_counter(io)#17 --> &q->limits_lock
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&q->limits_lock);
>>                                lock(&q->q_usage_counter(io)#17);
>>                                lock(&q->limits_lock);
>>   lock(&sbi->fat_lock);
>>
>>  *** DEADLOCK ***
>>
>> Reported-by: syzbot+a5d8c609c02f508672cc@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=a5d8c609c02f508672cc
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> ---
>>  drivers/block/loop.c |   31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 78a7bb2..5f3ce51 100644
>> --- a/drivers/block/loop.c      2024-09-16 13:45:20.253220178 +0900
>> +++ b/drivers/block/loop.c      2024-11-11 21:51:00.910135443 +0900
>> @@ -770,12 +770,11 @@ static void loop_sysfs_exit(struct loop_
>>                                    &loop_attribute_group);
>>  }
>>
>> -static void loop_config_discard(struct loop_device *lo,
>> -               struct queue_limits *lim)
>> +static void loop_get_discard_config(struct loop_device *lo,
>> +                                   u32 *granularity, u32 *max_discard_sectors)
>>  {
>>         struct file *file = lo->lo_backing_file;
>>         struct inode *inode = file->f_mapping->host;
>> -       u32 granularity = 0, max_discard_sectors = 0;
>>         struct kstatfs sbuf;
>>
>>         /*
>> @@ -788,8 +787,9 @@ static void loop_config_discard(struct l
>>         if (S_ISBLK(inode->i_mode)) {
>>                 struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
>>
>> -               max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
>> -               granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
>> +               *max_discard_sectors =
>> +                       backingq->limits.max_write_zeroes_sectors;
>> +               *granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
>>                         queue_physical_block_size(backingq);
>>
>>         /*
>> @@ -797,16 +797,9 @@ static void loop_config_discard(struct l
>>          * image a.k.a. discard.
>>          */
>>         } else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
>> -               max_discard_sectors = UINT_MAX >> 9;
>> -               granularity = sbuf.f_bsize;
>> +               *max_discard_sectors = UINT_MAX >> 9;
>> +               *granularity = sbuf.f_bsize;
>>         }
>> -
>> -       lim->max_hw_discard_sectors = max_discard_sectors;
>> -       lim->max_write_zeroes_sectors = max_discard_sectors;
>> -       if (max_discard_sectors)
>> -               lim->discard_granularity = granularity;
>> -       else
>> -               lim->discard_granularity = 0;
>>  }
>>
>>  struct loop_worker {
>> @@ -992,6 +985,7 @@ static int loop_reconfigure_limits(struc
>>         struct inode *inode = file->f_mapping->host;
>>         struct block_device *backing_bdev = NULL;
>>         struct queue_limits lim;
>> +       u32 granularity = 0, max_discard_sectors = 0;
>>
>>         if (S_ISBLK(inode->i_mode))
>>                 backing_bdev = I_BDEV(inode);
>> @@ -1001,6 +995,8 @@ static int loop_reconfigure_limits(struc
>>         if (!bsize)
>>                 bsize = loop_default_blocksize(lo, backing_bdev);
>>
>> +       loop_get_discard_config(lo, &granularity, &max_discard_sectors);
>> +
>>         lim = queue_limits_start_update(lo->lo_queue);
>>         lim.logical_block_size = bsize;
>>         lim.physical_block_size = bsize;
>> @@ -1010,7 +1006,12 @@ static int loop_reconfigure_limits(struc
>>                 lim.features |= BLK_FEAT_WRITE_CACHE;
>>         if (backing_bdev && !bdev_nonrot(backing_bdev))
>>                 lim.features |= BLK_FEAT_ROTATIONAL;
>> -       loop_config_discard(lo, &lim);
>> +       lim.max_hw_discard_sectors = max_discard_sectors;
>> +       lim.max_write_zeroes_sectors = max_discard_sectors;
>> +       if (max_discard_sectors)
>> +               lim.discard_granularity = granularity;
>> +       else
>> +               lim.discard_granularity = 0;
>>         return queue_limits_commit_update(lo->lo_queue, &lim);
>>  }
> 
> Looks fine,
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

The patch doesn't apply to the for-6.13/block tree, Ogawa can you send
an updated one please?

-- 
Jens Axboe


