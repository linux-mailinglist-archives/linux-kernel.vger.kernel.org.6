Return-Path: <linux-kernel+bounces-185660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47278CB88D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0738BB2100D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1486AC0;
	Wed, 22 May 2024 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C6maWd24"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D062595
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716341979; cv=none; b=GJsvwMwms93JjvojzzHiDrBqN2vBvQswRtE5eJH7Do08MIDhY2MACq/H3TMf/a8KrcITRAWr6xCsvzYbGJYXWGd7xYHx1edxVZOhbRJc0RHLGxh8Zmh+j5mr6BwT2zXRhIRHGpIgRMBsj1NiIDdtDQqR6btGy4elX5Ydawcxk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716341979; c=relaxed/simple;
	bh=1WwCIjW+QYZ8B5shPiF0CpPutf23ixubnTbRYcKHs68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3vb0HfQpwhcrjeMiLrzkiDcSuvemzlEqg8pkXNgtccu6r/c0pDz6fATABWMTKkyHSRJfAuH728SEaUgYVaAPME+GP3Ecgjd1AoLS0oGDs3tQVNY4rpGyTk08jgxEjgiXTt0Mti/w6QOCwfY7xJTRQE3toZ5uFyHLJBgKLwYez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C6maWd24; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec4ef7d13aso968135ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716341977; x=1716946777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/SglNeSrL+bAHmb25h1R4JUv+l/fpVwpE+XdiicPe0=;
        b=C6maWd24za/zjQwqbAJHIIdxbDW3JUFR180bxHXggbMQ52ZU098CDSIJHWOMOngdtg
         0iiJwrPn0FyKG8a08qFN5FokZRwtRguoR2feglW7o3XwPamgMSSXdiM55JvWrGOHTnxq
         RM1XnaOHZou6bAPfNEC02XrFMsBJ2My95F9y82nmrwHXZ50ABL54wURLk8b21IYtF34z
         QGl8hcpXYJGpHIu2PbjZc+6PvGgQlUAYAhG6ILxVZZnpSh+c2RWrYytHWI8hhZXrbWOg
         ouaIsuFzUYn/9ebndm6vD0hoKCx9vOGr+NBdeRBx+9zGRdxo6M5lp0VfZ4k0oywDWzx/
         dMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716341977; x=1716946777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/SglNeSrL+bAHmb25h1R4JUv+l/fpVwpE+XdiicPe0=;
        b=KYaH1VELiyGbspyXjohHhehq9XCLvI+12QeQeUZAcll9JZ5DqbV+MiyzYsegNAur1R
         RMh20dHOMn3b+gDo1x9pX3OTMbSCLPGVLBzw1PHAAqNHtfaRyVC6th7sT6DuJBZDRbs9
         j20IzQ9UUKHWXfzB/G4vu1HsZ8+846jHxIXhpjbmvw1ykWo1lCTaQrFFuwcv3ZAsp+Dt
         tTtfkreCw7s574z6s7VzTuR4OH9eBFNEeo0/kP6yYaQo5qWUhREIAVJsAwxA5frjk/7+
         w3oYPW1wAE/U9MClsu9uyfzOBPTVGvQVkJ5vqCyGHkuyf62RGHw327bMwg9sTOe5b4sk
         7v6g==
X-Forwarded-Encrypted: i=1; AJvYcCUsnaLr1jekaaAIFb4HvHjDfM55W0mHKjCJ/M9NngGYZN8blDwaCex9yBakjQRJEkr2ILhKAV988ybfAomfenT7Yfa1+QFSh1F9Wsb7
X-Gm-Message-State: AOJu0Yx1zRtidb3o0ReF/U2JRaDumHzrv4Y8+Jpuu1Vmv3yRS8IB8nXP
	QwGKUVWSfydXIeW4ovXyoKUGQeLmXoMz+UCEwG+v0sIzrane9jz3PLDCzPCHsTY=
X-Google-Smtp-Source: AGHT+IGZ5Dzet+It/SNVh6yNDJY38hstpJVORVy8wNn2KqW50FEzmNwEPkFFvTlXJA9hHBB0ZQ4+WQ==
X-Received: by 2002:a17:902:f688:b0:1f2:fae6:3ace with SMTP id d9443c01a7336-1f31c966f9amr7965285ad.2.1716341976695;
        Tue, 21 May 2024 18:39:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d484fsm227102355ad.39.2024.05.21.18.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 18:39:36 -0700 (PDT)
Message-ID: <dcd2dac3-07d2-4ee8-addf-b9266a84f7fd@kernel.dk>
Date: Tue, 21 May 2024 19:39:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 for-6.10/block 1/2] loop: Fix a race between loop
 detach and loop open
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, hch@lst.de
References: <20240521224249.7389-1-gulam.mohamed@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240521224249.7389-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/24 4:42 PM, Gulam Mohamed wrote:
> Description
> ===========
> 
> 1. Userspace sends the command "losetup -d" which uses the open() call
>    to open the device
> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>    function loop_clr_fd()
> 3. If LOOP_CLR_FD is the first command received at the time, then the
>    AUTOCLEAR flag is not set and deletion of the
>    loop device proceeds ahead and scans the partitions (drop/add
>    partitions)
> 
> 	if (disk_openers(lo->lo_disk) > 1) {
> 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> 		loop_global_unlock(lo, true);
> 		return 0;
> 	}
> 
>  4. Before scanning partitions, it will check to see if any partition of
>     the loop device is currently opened
>  5. If any partition is opened, then it will return EBUSY:
> 
>     if (disk->open_partitions)
> 		return -EBUSY;
>  6. So, after receiving the "LOOP_CLR_FD" command and just before the above
>     check for open_partitions, if any other command
>     (like blkid) opens any partition of the loop device, then the partition
>     scan will not proceed and EBUSY is returned as shown in above code
>  7. But in "__loop_clr_fd()", this EBUSY error is not propagated
>  8. We have noticed that this is causing the partitions of the loop to
>     remain stale even after the loop device is detached resulting in the
>     IO errors on the partitions
> 
> Fix
> ---
> Re-introduce the lo_open() call to restrict any process to open the loop
> device when its being detached
> 
> Test case
> =========
> Test case involves the following two scripts:
> 
> script1.sh
> ----------
> while [ 1 ];
> do
> 	losetup -P -f /home/opt/looptest/test10.img
> 	blkid /dev/loop0p1
> done
> 
> script2.sh
> ----------
> while [ 1 ];
> do
> 	losetup -d /dev/loop0
> done
> 
> Without fix, the following IO errors have been observed:
> 
> kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
> kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
>         phys_seg 1 prio class 0
> kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
>         phys_seg 1 prio class 0
> kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
>         read
> 
> V1->V2:
> 	Added a test case, 010, in blktests in tests/loop/
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
>  drivers/block/loop.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 28a95fd366fe..9a235d8c062d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>  }
>  #endif
>  
> +static int lo_open(struct gendisk *disk, blk_mode_t mode)
> +{
> +        struct loop_device *lo = disk->private_data;
> +        int err;
> +
> +        if (!lo)
> +                return -ENXIO;
> +
> +        err = mutex_lock_killable(&lo->lo_mutex);
> +        if (err)
> +                return err;
> +
> +        if (lo->lo_state == Lo_rundown)
> +                err = -ENXIO;
> +        mutex_unlock(&lo->lo_mutex);
> +	return err;
> +}

Most of this function uses spaces rather than tabs.

-- 
Jens Axboe


