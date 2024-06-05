Return-Path: <linux-kernel+bounces-203048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17C8FD595
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D7FB21C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA22030B;
	Wed,  5 Jun 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZqwD01Hy"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A8C15D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611261; cv=none; b=mGPz0HE6IJjemtaxo6SYI/albxtaG9QsASntpOOG62DTXVznnlKxwtFaAXuDjtVPy6kt35vzo/n7xgx/c+RgpcHzf5xB7QuBYsQiq3afYX18mBmeMOSdEB5FJbTX2uQAwnUwmTMB2Z5QaFOZPVYXWYLqkRKy4wkz8ipGSAbVsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611261; c=relaxed/simple;
	bh=XlaBgIk03gwg9hXViHjBnESCujBmUxLENhKIfLNL8Xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UOsPpRl5SgdxsG19C9R5iYYolkhMqM39qRaSXD4oHz6EXX+HCnZuK7IpQDtzD9EPaxmXt0udZJIQzofdxGL52Aq6eLz5xrGRSxqmSMUwXaXL9KSB/l96rWThaiY15LYeYJG5h3S+XDMuD9mjHty0P9E56o/Fn94C5BzzY5sYwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZqwD01Hy; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-250932751b9so4104fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717611258; x=1718216058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oSVIp5tH0Fdf6LZyEl2CHXsReyyORLHTvKvZ7WJfPCg=;
        b=ZqwD01HypASHFhJ+pcja4rsJC4HnYDvOeViMjtHeSwl0sAeVMno/reK2nUKaUGK2YW
         3qT/KG2R+F8YLIK1ifGcw1GuJTx6YZSYurxRkYi1UFQrIhK11bHoWzcTHFvoIRdVYGdK
         yFrAK1OeHW82H7d5TcwdiNWxu698TGXIaG1dHHaWZV5h9sCG+lzlZPXHIHxAUR1fMezY
         YKaLUIYj0ew+1NVNPbE1/zCJ3K4SQKXNkS4aSk6w1O5fZJJfdxD2c+5SOBKxnwn5RPsD
         iW9MFPkf4YrpTEYQY4VREf1C0cKrpalFgKOBWBVtzWAkuKZjaLf8TBVXMWDPuzGvPDsl
         Kx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611258; x=1718216058;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oSVIp5tH0Fdf6LZyEl2CHXsReyyORLHTvKvZ7WJfPCg=;
        b=oh63rvXntG2dJG+h7cBy6YBjzgAuzvhRm9HkDrmoOIg1GN+rh/cAump1LJhZ8weFck
         0JAqF4byNnOnvCyC4MeB6Zy8oCXob02ViZuS5kLzlPoa8NNw/EGpbgMh0LoHHYScytef
         sFJPoKc84/ntatC+DGKezR/XMc5N5Qe7MbfFWqc3euhTwdW44rpPRAbxPSXnQJdZh7gS
         zvK3PHjhvk+JwBsFhM5Zyn8an220gSb/5EsJT03b6NGG728RACAOBVshrY0jVqYqDquD
         Jyuhr5wg35ikysGFa9OhYaPMpqtD/H+BsHkkByEztM06+9IzcOc7Eslq1QL0Q07/Dh05
         SIdA==
X-Forwarded-Encrypted: i=1; AJvYcCW7GsEGofgDqXzLhTunBkX5ePTQThEa0NbgQ7y7XcYNlPa9haTkJ+veaLqlVwjDZo7BzSp1fNgThwu7vNHs7MvkE3bp3IEHdMfuZXSs
X-Gm-Message-State: AOJu0YwdApUJ8iO/MmVXX/dqo5rJO3kVqWNSt0bRTg2L4ehVx0OHR1Yc
	wm9iwfONLQidE/gCYX63RQDMrb5nRLH4l8dKLYI577Bl+u7VzXvBTpPlI3FO6io=
X-Google-Smtp-Source: AGHT+IH3rTwst3rxHfabtcaxMo9YJRolfNWPOCLPBsmQkznjrFlkHCCWS0vObDUTUJlxOHzHgjR8hA==
X-Received: by 2002:a05:6870:ec94:b0:250:7928:6550 with SMTP id 586e51a60fabf-2512236d536mr3634384fac.3.1717611258005;
        Wed, 05 Jun 2024 11:14:18 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-250852250fdsm4082020fac.44.2024.06.05.11.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 11:14:17 -0700 (PDT)
Message-ID: <cc2bd808-194e-431d-b733-4aa7bd410da3@kernel.dk>
Date: Wed, 5 Jun 2024 12:14:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix request.queuelist usage in flush
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com, bvanassche@acm.org,
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240604064745.808610-1-chengming.zhou@linux.dev>
 <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Content-Language: en-US
In-Reply-To: <171751063844.375344.3358896610081062168.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 8:17 AM, Jens Axboe wrote:
> 
> On Tue, 04 Jun 2024 14:47:45 +0800, Chengming Zhou wrote:
>> Friedrich Weber reported a kernel crash problem and bisected to commit
>> 81ada09cc25e ("blk-flush: reuse rq queuelist in flush state machine").
>>
>> The root cause is that we use "list_move_tail(&rq->queuelist, pending)"
>> in the PREFLUSH/POSTFLUSH sequences. But rq->queuelist.next == xxx since
>> it's popped out from plug->cached_rq in __blk_mq_alloc_requests_batch().
>> We don't initialize its queuelist just for this first request, although
>> the queuelist of all later popped requests will be initialized.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: fix request.queuelist usage in flush
>       commit: a315b96155e4c0362742aa3c3b3aebe2ec3844bd

Given the pending investigation into crashes potentially caused by this
patch, I've dropped it from the 6.10 tree for now.

-- 
Jens Axboe


