Return-Path: <linux-kernel+bounces-221427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5890F376
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4AC1C21FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909F158DA8;
	Wed, 19 Jun 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JcyNo0Ud"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC4153519
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812293; cv=none; b=sAUaItOt9dtk6oFipiGPB0/N0J34jNG3bzOTZE54PLKzLKISbFoNKpaWquEruQem6fSyxzAuX5FX1GYhx8kqDn01UMZKSjivnfaVM/JOz2LadyhYeuTYCaFgULgkgbhlULWe2VrU2/UhTDWh+pRyMjbv+YD3+KLEsinuptAiHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812293; c=relaxed/simple;
	bh=22Pp9746fqe+xb8Vx606N6eQFqXubN8aYhh8I9/nH3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssvN5zvfsxJUFdeht9Igzb1G7eU4JCJPXIyfT3gc73pnYdIG8NMeQw5fXiMSxZ/KITaWUY7j/5ETu3I5OwxGQ8O5H1+5Y+HNhbtBXmtZqGIon8PUKrUFgiU5UwiI9BdodeytrVWcJ1K9aLZVvlfZQFBuDghP5tDHiRg0ZCfaP7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JcyNo0Ud; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9a8c59d44so825085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718812291; x=1719417091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRh2qBjBno25fyOZvYEcCWdKsE/a2pTFCtImaQJAP4U=;
        b=JcyNo0Ud9AkNcwytLv7pd8dxVghAkp1d9nG9f9w6Bpr0AuZ9gFB/ef8TEv7Maee8D5
         0BlO4XYIMD1xtG9M3NAwSf56T1PEmn+RYhgA7rZKtGUGGOCqUe1uGhXYJlJiUArMYSjo
         Leqqg1lCgAtemk/+gG9P47tos4W49tksrkS9VAgzIEzZXVmrW8U8Q7Z/nnbkcWuxcke/
         hiUb9PVV5G9cwsG9WhPyfgAVb48t4XimsVzNF+PDf4G2+rwgiE4vwAFcscQBD7I6iL8V
         gMJiFwsnLF5YvWgSTPHSLB/KVpJ/+9yaLnfnst2V3m+2PBqQvAf1+vfQcsaStDiUkZew
         ykpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812291; x=1719417091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRh2qBjBno25fyOZvYEcCWdKsE/a2pTFCtImaQJAP4U=;
        b=q1/KjwllmsG9TuqiOGbmISNsuK6roo22sNnktepJ415uJMDMdh1tSsfozlkR7Qaq5w
         Xd6r+ejUiReD8zsbPiNU00ZhsTx+77u0t0mC0juJxbCYKZvTwKJi2TqVopkk2pq87V1h
         3O/RVwZUFPsR/cX/ftgCEIXsWH1+PSLHYK6WP9yw7CUH+r0Ol8GgJor4RBGwIoyuyHUq
         QJfwbCQp9QoCkLO4xO7FK6nCjFgGKY1mkoBCt+otl0gGY6554b0ibdWEdrmDh3TDbkuY
         tzb+qSL/7EyyChoNzRH8XNJGhLpd4G/KdvjuafD+3z9CiuA+0LWVZPm/FDQamYg+Alv/
         Wg1g==
X-Forwarded-Encrypted: i=1; AJvYcCU20R+L8SGiyyFamsgCdsdB9mTXlxoXfJsZ4HWIKPpMUhXO8UnQGGmKv3OFXcsFWGm5BNYggqEYdaLiinwCs8NPeRmMUIRB42GsoheY
X-Gm-Message-State: AOJu0Yyz4jpeHiVJU1OfOuX3yfWrdXya0jvjxnsV741+buXh8CKGBVkH
	HCXkB3yYY7vLeJw2Gt3d8mMny/bYTVae6tMxNrbvbx1sqAU5Jgq8Kmi3ux7iZfI=
X-Google-Smtp-Source: AGHT+IEeGRimURdWTiJcHH8MZs1FtHI2wgZpmcKVNRznQgoxss+Le4aXnsvAGiS9ArRp4dzntU5Law==
X-Received: by 2002:a17:902:d503:b0:1f7:1bb7:39db with SMTP id d9443c01a7336-1f9aa870f6amr29410245ad.5.1718812290685;
        Wed, 19 Jun 2024 08:51:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d13esm118447065ad.287.2024.06.19.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:51:30 -0700 (PDT)
Message-ID: <5146c97b-912e-41e3-bea9-547b0881707a@kernel.dk>
Date: Wed, 19 Jun 2024 09:51:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Subject: io_uring: releasing CPU resources when
 polling
To: hexue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CGME20240619071833epcas5p274ddb249a75e4b3006b48d1378071923@epcas5p2.samsung.com>
 <20240619071826.1553543-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240619071826.1553543-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 1:18 AM, hexue wrote:
> io_uring use polling mode could improve the IO performence, but it will
> spend 100% of CPU resources to do polling.
> 
> This set a signal "IORING_SETUP_HY_POLL" to application, aim to provide
> a interface for user to enable a new hybrid polling at io_uring level.
> 
> A new hybrid poll is implemented on the io_uring layer. Once IO issued,
> it will not polling immediately, but block first and re-run before IO
> complete, then poll to reap IO. This poll function could keep polling
> high performance and free up some CPU resources.
> 
> we considered about complex situations, such as multi-concurrency,
> different processing speed of multi-disk, etc.
> 
> Test results:
> set 8 poll queues, fio-3.35, Gen5 SSD, 8 CPU VM
> 
> per CPU utilization:
>     read(128k, QD64, 1Job)     53%   write(128k, QD64, 1Job)     45%
>     randread(4k, QD64, 16Job)  70%   randwrite(4k, QD64, 16Job)  16%
> performance reduction:
>     read  0.92%     write  0.92%    randread  1.61%    randwrite  0%

Haven't tried this on slower storage yet, but my usual 122M IOPS polled
test case (24 drives, each using a single thread to load up a drive)
yields the following with hybrid polling enabled:

IOPS=57.08M, BW=27.87GiB/s, IOS/call=32/31
IOPS=56.91M, BW=27.79GiB/s, IOS/call=32/32
IOPS=57.93M, BW=28.29GiB/s, IOS/call=31/31
IOPS=57.82M, BW=28.23GiB/s, IOS/call=32/32

which is even slower than IRQ driven.

It does use less cpu, about 1900% compared to 2400% before as it's
polling. And obviously this is not the best case for this scenario, as
these devices have low latencies. Like I predicted in earlier replies,
most of the added overhead here is TSC reading, outside of the obvious
one of now having wakeups and context switches, about 1M/sec of the
latter for this test.

If we move to regular flash, here's another box I have with 32 flash
drives in it. For a similar test, we get:

IOPS=104.01M, BW=50.78GiB/s, IOS/call=31/31
IOPS=103.92M, BW=50.74GiB/s, IOS/call=31/31
IOPS=103.99M, BW=50.78GiB/s, IOS/call=31/31
IOPS=103.97M, BW=50.77GiB/s, IOS/call=31/31
IOPS=104.01M, BW=50.79GiB/s, IOS/call=31/31
IOPS=104.02M, BW=50.79GiB/s, IOS/call=31/31
IOPS=103.62M, BW=50.59GiB/s, IOS/call=31/31

using 3200% CPU (32 drives, 32 threads polling) with regular polling,
and enabling hybrid polling:

IOPS=53.62M, BW=26.18GiB/s, IOS/call=32/32
IOPS=53.37M, BW=26.06GiB/s, IOS/call=31/31
IOPS=53.45M, BW=26.10GiB/s, IOS/call=32/31
IOPS=53.43M, BW=26.09GiB/s, IOS/call=32/32
IOPS=53.11M, BW=25.93GiB/s, IOS/call=32/32

and again a lot of tsc overhead (> 10%), overhead from your extra
allocations (8%).

If we just do a single flash drive, it'll do 3.25M with 100% with normal
polling, and 2.0M with 50% CPU usage with hybrid polling.

While I do suspect there are cases where hybrid polling will be more
efficient, not sure there are many of them. And you're most likely
better off just doing IRQ driven IO at that point? Particularly with the
fairly substantial overhead of maintaining the data you need, and time
querying.

-- 
Jens Axboe


