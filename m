Return-Path: <linux-kernel+bounces-417116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FB9D4F39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A51F23234
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570F1DBB36;
	Thu, 21 Nov 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fLOLq24X"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5141ABEB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200573; cv=none; b=umpzqdiueL9/5UGOSbNnEeTezN3SDzJQjIe9B0vjZtwdtQjQyiL/DyS0GsGBZFNC38bNhy4A5wbDNZw0nvBl1vTEuhJVVKaXzhpJsgSdc6yGUD5QmoLwe6q/bzCupT6BJnXXsSY5AoUXJWk+8cBZGw4PNmRmL/U6SM4GB/vJ8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200573; c=relaxed/simple;
	bh=lyH7Vau7UK9NgcpywHmI/4QQPnjva331llXpYSQB2rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN1H5iinZAaYVGuqRsLIQF1imB75AHOvIwnPgXCcTaU+abZDZNNwu4r8+WF0IenQPb9HYK6abGsiVfw51y/wVHauPK8EkoKB/maLXaDkx3eNF6QZ/JITZq8cUW3EtIGifMld5dtBq7ZbDnawuMn+Tgn5aaN2/MAtOX71473UfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fLOLq24X; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2962feec93bso663661fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732200570; x=1732805370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+/66L19zIqWL9MK0xfwzldJbGf6XYUQHlYyTGOsrnI=;
        b=fLOLq24XME45HprqIdBtDrUtFVRt0KKf4D7XQU6GElDiCo/1pqpspoV6Cojat/tHRf
         P/j+ep+X/mbtTcJfV1ztkRFrtTqmYJzz4+JDhz9p/eYtg7LZbjyRXBYJhR6K2dggdOcc
         65QWGaNcfsWQ7+kfbYFRqzS8mwZes6nOIG58pQg+GX5xFWF5VY9pylH9HARVff5CNl1N
         8tDTYXanP/qxtM21t37snWQF40Cnvl/DcCtr0dRFM4PjSe8/FjX6/S/GKuUy9APigciO
         J6FvuUCYJt2X9zGasxSG5NayGXwS0RmaYBfKph76HXQ8WcXO1sTNQliLkq+Nw0LXdIu5
         ochw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732200570; x=1732805370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+/66L19zIqWL9MK0xfwzldJbGf6XYUQHlYyTGOsrnI=;
        b=P5YHuEzkY3iNu1QNDgRQYQjLQs5NHrC/DUhaQ2yj/K6m+WieCN6fH7TH8hgCinCQkS
         6fTuFj2aTKba987nhf+tNLSljwfK/N7zyccIHuMSQpRf8N4qwhZZubPEWoT9KS6dlCgN
         kXplQ2Zg+tl5zvB15RcpM1cHGcZkE3v89JF3Bg6M37lXt5q1pJgV2nzTzY1cI4Qhicgc
         80sVNe/Ur1G0+zogPlKX/NSdNVjTnrZKB7dfywti5QFIgFK5gLQNOWOpDl9CnuonChUH
         OXw9rj/m+ysyxFLi4yZhIhAOP3DToPOT54JjRxX6Oa0uJfgNQ7xIXbqfTPDUOnmmcsm9
         XfGg==
X-Forwarded-Encrypted: i=1; AJvYcCUM6dKAD7Fius1DrrNqXvkxomMt3aBW351KIMUQrRR7htjz32mk53q41+MP+LWnbMxAKEXt3RL1UnnCQT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/G6JkM1MdjKs9u/R9nlxodMWlZSt0HLOrZaYonvg9a6UkxzL
	cPovvQVKyeQ1FkO3d9wr7VxaJGG5ea6FET2N9Q7O0yN6OqQzepGxEnLeS3xwqeQ=
X-Gm-Gg: ASbGncv6juXp8GJN1HqraYbrM5SBy465mc0wg1QrRCrYWxqilH/3yXLEWEwW0psIAZ7
	7UZKd2sGo6Mi25xPX9tOUbs0OFnHqNYvU22DIEQuBflV2sVPIZWMIsn2kNXbzzwz/mp6mpMjc+O
	e3QBTXHkrOT+G3YtrhQ/dX+lGwyAn9jkp12Q3Tu7KfMbL4rdyxnKqCRm5QmD9N038ndTULLq3vi
	zCstnS3zQ6mKL7lIR5KcAkdZ8B0pf8CeMxvn4GRMyEi6Q==
X-Google-Smtp-Source: AGHT+IFNrnSalwJ8Ln03ltl79/WoctqRlWoKBzFj94ZqnpbO7kUvel0Z5aZJ8hZfVYejeQ5nDN2fHg==
X-Received: by 2002:a05:6870:b50f:b0:296:9dba:6398 with SMTP id 586e51a60fabf-296d9ae3ab8mr7166734fac.7.1732200569835;
        Thu, 21 Nov 2024 06:49:29 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651b2fbd4sm4927124fac.44.2024.11.21.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 06:49:29 -0800 (PST)
Message-ID: <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
Date: Thu, 21 Nov 2024 07:49:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Phil Auld <pauld@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241121113058.GA394828@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 4:30 AM, Phil Auld wrote:
> 
> Hi,
> 
> On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
>> On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
>>> On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
>>>> Hi,
>>>>
>>>> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
>>>>
>>>> Bisect root cause commit
>>>> ===================
>>>> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
>>>>
>>>>
>>>> Test details
>>>> =========
>>>> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>>>> - Test is on ext4 filesystem
>>>> - System has 4 NVMe disks
>>>>
>>>
>>> Thanks a lot for the report, to narrow down this problem can you
>>> please :-
>>>
>>> 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>>>     have used for this benchmark ?
>>> 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
>>>
>>> This way we will know if there is an issue only with the ext4 or
>>> with other file systems are suffering from this problem too or
>>> it is below the file system layer such as block layer and nvme pci driver ?
>>>
>>> It will also help if you can repeat these numbers for io_uring fio io_engine
>>> to narrow down this problem to know if the issue is ioengine specific.
>>>
>>> Looking at the commit [1], it only sets the max value to write zeroes 
>>> sectors
>>> if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
>>> write zeroes value.
>>
>> There's no way that commit is involved, the test as quoted doesn't even
>> touch write zeroes. Hence if there really is a regression here, then
>> it's either not easily bisectable, some error was injected while
>> bisecting, or the test itself is bimodal.
> 
> I was just going to ask how confident we are in that bisect result.
> 
> I suspect this is the same issue I've been fighting here:
> 
> https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/
> 
> Saeed, can you try your randwrite test after
> 
>   "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
> 
> please?
> 
> We don't as yet have a general fix for it as it seems to be a bit of
> a trade off.

Interesting. Might explain some regressions I've seen too related to
performance.

-- 
Jens Axboe


