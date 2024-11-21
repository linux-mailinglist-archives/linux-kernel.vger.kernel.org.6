Return-Path: <linux-kernel+bounces-416460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB049D453E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1FA2823CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316C2744B;
	Thu, 21 Nov 2024 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gRNXD9Ms"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CA29B0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732152017; cv=none; b=pAs31g+fh7eKIrlHqyhfNZIVkFmO9Qia+zPNOnWPbwCaxbyn3JHztz3+3EFa/4aNa0+B5oJNlv52sugfkwJhHVzqaQtWD5GGKFcp/mEnAtSwOrjrAnYaE9M1vOa6dWUgLFbsBZreMl+eWKqbOrImYzYVxpl57eSUulzr7ebNg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732152017; c=relaxed/simple;
	bh=SwrayaS9SXI7PTvhF8xvn0J7hiUFeyiRh9Ow7gOPGsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMnn5sNpPxE/5r90GHwZVJVkDXuFXqDT8Om+eXCgr7wccbGEbBnulSBUF5msnDwEQhTPGfbnpxDclRXWcOzoTTaCZxCnAwFbnpQRwq259c+Scn5IqTg3FabcODnK5dww6xIHkbAMC2VG575HppCHWALs6m3Aaj1xpot9OS6yc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gRNXD9Ms; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so359751a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732152015; x=1732756815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zzioji6t5EJYtuRjVDNljcfalXHvMtqqSYFYu6hs34=;
        b=gRNXD9MsOOOXJG0HYrVryPXW7zud2iiiDXvYJic9ZrfCX0xHJrX1TpkdvjZVp2ombD
         5Qx1RRjqKPKYHwoJidXGw2ch+E1zk/CxJfKJ3ZYQx7AbL7KhgaFW1Y8rn/cMs5FOBRAw
         lgH+0vKoAu9Wm3tmzRMXWLtpiO1KtzsluiywpksuNgq8HrL7NStRshTMWdp+PBOZSj/7
         1YUydcLEu7VS9yp179ubAC11ThXhBH2CR9+p+oIaL4oPQx6O1q2d4CqfH/BwUk2l6g1+
         X9SrqjzXLt1OWMb/U/xp5IxjVrzQUWXAntyCgg+YIqqtIXdD+5mDrxa0wuaORK8LnoVu
         CfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732152015; x=1732756815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zzioji6t5EJYtuRjVDNljcfalXHvMtqqSYFYu6hs34=;
        b=KeU+k4eDFoD9iCX/KbnsirSZrPmswDpFgLyS66rLh/hiiFsqImhRhsRVkIFOZgDY9U
         rYRHxjy0w4HnEGsee+QBa4egarir0ynYdtqm/q79H6IiOJ1/stlih3X91/tK0Q+7Tzds
         LdfhbJWL0jiOyxH5dCYbV+JLUz/6vKrqSUOWFqJkzfEwWimxuWGltGeNCOWboyilBhpR
         H0yMwa11GWYOask/Lu8nMr3XvFD8iNEz+rDFjJ1qjm5z3jXy/enUttvkrUFBM2wHw79H
         FaxeOJ0SxtrEdVpotF5ZbyXhcl53zpEDmUdFVOrk6tM9PsoxZ2aV/57OK/lcrCrarbuQ
         5ajg==
X-Gm-Message-State: AOJu0YzHeqQPgDr6pBmhKh3o1mlM7fBCsBSSz37WhdpS4hvA+fw1S3cC
	WWdhT3UfCauM/bdG7AO7IDNhbYozE90lNMIyCWZckhopMVDI5I1F/+ok4rrbFgU=
X-Gm-Gg: ASbGnctE2gJfLYGxlDY+D7chCSN9SJiJziBzyMxv6HUN2oCAFmV6WxLf58UayBZM6vw
	w7oWzXrl+O8nBFEwB6KqDD448iivZLod5qKAG5C8mo9CLJmqdUkZ1wG98XY3FTnC4R2I1YXHaKp
	4RVXfqdpdk/RWT2G6yO4OG881x+hkNKzKTzwo6k+U5ak4qql3Yv8Q3+WlF0+ikgDUBYri/pHvy+
	0T+HzqXPX+kZbREICbhfcfcFa4rzWGeWfv7apkCrVZUPGo=
X-Google-Smtp-Source: AGHT+IEPMWVWiZ4xgW98q/E3liAMRD6U3r199xc/qsSzLuoWoDnGWtMOom3v8Ddt9yv6CjLmcWTJsQ==
X-Received: by 2002:a17:90b:1bc3:b0:2ea:5ff8:f325 with SMTP id 98e67ed59e1d1-2eaca6b3c34mr6230031a91.8.1732152014776;
        Wed, 20 Nov 2024 17:20:14 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee19c6sm1895245ad.123.2024.11.20.17.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 17:20:14 -0800 (PST)
Message-ID: <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
Date: Wed, 20 Nov 2024 18:20:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] 5-9% FIO randomwrite ext4 perf regression on 6.12.y
 kernel
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Webb <paul.x.webb@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
> On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
>> Hi,
>>
>> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
>>
>> Bisect root cause commit
>> ===================
>> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
>>
>>
>> Test details
>> =========
>> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>> - Test is on ext4 filesystem
>> - System has 4 NVMe disks
>>
> 
> Thanks a lot for the report, to narrow down this problem can you
> please :-
> 
> 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>     have used for this benchmark ?
> 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
> 
> This way we will know if there is an issue only with the ext4 or
> with other file systems are suffering from this problem too or
> it is below the file system layer such as block layer and nvme pci driver ?
> 
> It will also help if you can repeat these numbers for io_uring fio io_engine
> to narrow down this problem to know if the issue is ioengine specific.
> 
> Looking at the commit [1], it only sets the max value to write zeroes 
> sectors
> if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
> write zeroes value.

There's no way that commit is involved, the test as quoted doesn't even
touch write zeroes. Hence if there really is a regression here, then
it's either not easily bisectable, some error was injected while
bisecting, or the test itself is bimodal.

-- 
Jens Axboe

