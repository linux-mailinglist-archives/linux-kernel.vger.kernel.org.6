Return-Path: <linux-kernel+bounces-323141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55455973873
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70D61F225BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A71922F4;
	Tue, 10 Sep 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xWBGKbdJ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE255674E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974256; cv=none; b=LfTZ5AOFVszR9HDyavuHJ1YENliTINRQce4iqFjL2w2iXpwfUYJ6XUBD6lDBjJ7wZlGkqrvuSMh/wmi900SX1zlDuQjQO7jA0WTA5bLRTBuGOlEs3ycu1u0b05+u5sk8+90lqxk0mKNbFspzOxD5j89PSU4MIXapfWhE7GOiEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974256; c=relaxed/simple;
	bh=rElpwe74QCdlkppKx+/nrl9b08LTiSv9pKFzn9ku2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k792cRc6FeUXONKhSA3Kwf67BEIUwwSYKhNV44dYVLsSjMux5ue2aRQ6IZux4QLkPnGND4bVYzMf6yFVClPh99jTjXCwSF9z7MfcoyAhRqYqcbb72nV8UtlZ/bUdYbHWfbFBwwedsQFwcet5yzSPVwjF34m3Aa66QbkKer3qnjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xWBGKbdJ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cd93a6617so113167739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725974252; x=1726579052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpD4HVzD9Ke7dsGx30VPgTZhr78oR5oyb23tn64z8zE=;
        b=xWBGKbdJ2J/1CDF+P/sXVYKNEJt3Q/70tGAkgOqs2Hyua1+QzZh7YmPpTa0oy6xZus
         347j7c3HqIUsGL11OrQYC0rBXb1poSbi1eMj+YPQYgHhI3iogN9P9PS6eWIW0Yjky/oW
         M9xb7EuJLhhML3WD3yba7iQM8PoA/TExvSLThLKoCzqIuxv28pHNlBTYs2Ukx4PYzxRv
         sjLUKhekijddatC7hSOi6QEXjmHI9oaTChPLY2y/h77ue59zi3Z8Z1BmGZi0bTNJgFzb
         +LpNnlmmQe/rJDUEwBJ6lknYYcZxSqpKkHYwV5dE+n96DZai0Sm7E8J6DVhmc3wGQruS
         rhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974252; x=1726579052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpD4HVzD9Ke7dsGx30VPgTZhr78oR5oyb23tn64z8zE=;
        b=BtM1golwAMP7ExmQD22K/Am+9whb+2ei4ib7CuULJmKpDNC/LDCZVt2C5naJ6FnckK
         FMjHFGzZ7x5oY8voCkms6XbOgZrLpUXDTk6i+B7/F0yMW0OGUty5qWiO3ARNMFKJ+JND
         cre4iYfcCPF2jIScvGJfW3nW+mfrHXkJPQX3ENn82dWZvGGt36kp2IrrAIRI2ckZus8G
         H5kNw+ebup1n8epTxcDtQNlEWzPWwUKd16KfVv1RCXtGpE/eBJX7tgdLz5QkjpLYbXrW
         zn0qKVS5+6t034DhI0mcOpfJBxg+9I0lhuoJjvZ91M56DTz7xxt/55Y9MhbBflf0wmT5
         ENEA==
X-Forwarded-Encrypted: i=1; AJvYcCVf2VkwVDTlCbmxjTOL4Wfl1tEfXJXVzrAszoF1I3sfEElA/DGAH2zzMl/vZb/xN5v/9L2piPeugrOMl2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73yPdX+HxBOQwabRyYED+mulsFMpeEbY5nei+gDN6UNVsyDzt
	NzWWdBHZHNXRerGagDT2ehfUBlz2L3BrfakIAvG+52rzleamTQXUt3mVFBbWxHA=
X-Google-Smtp-Source: AGHT+IGfyK24HYfbbx9rnx5YqzuHbqBuNQFAY7I1lFziboEeJC6YZXRSh2213qMBbZThLW4sVWXvqw==
X-Received: by 2002:a05:6e02:194e:b0:3a0:4355:11f7 with SMTP id e9e14a558f8ab-3a0576adeddmr107270105ab.17.1725974252303;
        Tue, 10 Sep 2024 06:17:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d1ff20867csm456359173.167.2024.09.10.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 06:17:31 -0700 (PDT)
Message-ID: <0e4e1f5a-30fd-430b-99ec-8b1004d8e3fd@kernel.dk>
Date: Tue, 10 Sep 2024 07:17:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block: fix missing dispatching request when queue
 is started or unquiesced
To: Muchun Song <songmuchun@bytedance.com>, ming.lei@redhat.com,
 yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 muchun.song@linux.dev, stable@vger.kernel.org
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-2-songmuchun@bytedance.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903081653.65613-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 2:16 AM, Muchun Song wrote:
> Supposing the following scenario with a virtio_blk driver.
> 
> CPU0                                    CPU1                                    CPU2
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                         blk_mq_try_issue_directly()             virtblk_done()
>                                             if (blk_mq_hctx_stopped())
>     blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
>     blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
>                                                 blk_mq_insert_request()
>                                                 return // Who is responsible for dispatching this IO request?
> 
> After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
> But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
> of completion of request, so it will run the hardware queue and marks the queue
> as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
> and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
> hardware queue and returns. It misses dispatching a request. Fix it by running
> the hardware queue explicitly. And blk_mq_request_issue_directly() should handle
> a similar situation. Fix it as well.

Patch looks fine, but this commit message is waaaaay too wide. Please
limit it to 72-74 chars. The above ordering is diagram is going to
otherwise be unreadable in a git log viewing in a terminal.

-- 
Jens Axboe

