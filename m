Return-Path: <linux-kernel+bounces-313470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8796A5CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1611F25A42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6A18FDAB;
	Tue,  3 Sep 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zrS6HZDu"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC014293
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385772; cv=none; b=ANXdF9nnyq3eodPXZSYly8AZcZZ8RsT8SIte52+BhhCM+71gD0kzcnebFT9JcU9a9QbQGOkFCq53y9P2/1jxqWQnmz/O1+WyuXSi8H/oV7ytud/lP5Z9wg8WaBLu4ZksnwWyQwcQqW6O51iAemaLYlr/me9aNZKfXds/m4O+amY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385772; c=relaxed/simple;
	bh=hO84H5jbpsOEEFSrahDKtjPUGAtP9b0mXlIyG+S4hfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1xu0uBvV0sJrVrr7i3udGNrJxtIqq/+QHJDZyFWhHp4kvomlr4dFGoBWXHP0JyVLJKNo8wZmu34VxaEhCmL1Wq5EFA2chVJEZHWXMDMBADLZ06X1Sa6MmGtg9fnOAgbNM0OK9YcLKZtoq5W3QgXJyhJY9K+Zwtde4+g42fbLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zrS6HZDu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206aee40676so1157625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725385770; x=1725990570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZBZsAaomV9xLytZdYqVwOu02sGFD8B+nDd1gunjap8=;
        b=zrS6HZDuZZRJmaMhNWYiLjr1LpA2e8k7WVhYjoQFBo+wnrSYygBxjSkqp+8vJ1Vn0/
         dCrcdP9LhQVftf+JAlJnT9tgiorAwBXB8dxEMjkm8uusvZkqaaQwMDVOFWd4Lq/tOeEf
         t8cE2mAIOAgEvk5I+Ay7DIvS7pCFJIjgSyyj1Ra8mXHucHENpSI4teO1aQs4F4IGjKvI
         KzRMmngR5VZAQcCA0hRT4+mE9kvNllLQMWtVh6TxvqUF6qu8aZLXsxy8QCImCaKKLNmJ
         IGQugYH2I89h8IN62pNleEHK6mNqCIP0H1FXAnBWK9DkeDycJsaA0m38wX8BJ/wN6Slm
         hfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385770; x=1725990570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZBZsAaomV9xLytZdYqVwOu02sGFD8B+nDd1gunjap8=;
        b=IHUut1UCyiVaPA9qldsm70NPFC19o+C1C1IXUxffzd7bXI5MAdxSyMtT+OmTvAksFW
         BAlzLW67xidlXXYB+6vwdbhWbKJELTp1fDY/t5SRu0So7Hs/q7oowK5VabGgCDYWdVc0
         lEkmQksmmEZ3A3scfmrrGkEfaJdS6xZ9saxckob3E9JAevwoU9bh17gZcRaB+rpKIP07
         qhLYvUesU3eT1kduq0fl2YoAsccUdd5YT55kjz8qbrwBh1tVlWOwjisGR/XEqFhNLUJV
         2WR1idoWXyaTLhclkrmmqmTyuq8nDNo59ObuRYhBbp7erd4ZcTsAAaM6Uc86X5JectGC
         5Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCVOKFNVmBVzVfYSs7Haqq0GV1bTgAahp/KkG62VQjKNNNgU0EyIfHwxwCk3qiCjvisZtTMvIR/o/GXKBis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFAkC7eWiY6yIJr8Ax/bndDbeO1pzO8nHMWNhho8lVtLL0ibk
	R3FxCbysr2qItcK/zS6iBckHFx4mIFT5fGuIZQoMbd0OA1JtfVLfWscisq+8ZzE=
X-Google-Smtp-Source: AGHT+IHD9aVjcJj9z14p/fzD6kVebPhcNLSiGgFQ3Xey9RAVe2AWQlDP70iSJUEXeBhYkU+5+u/OmQ==
X-Received: by 2002:a17:903:22c7:b0:205:866d:174f with SMTP id d9443c01a7336-205866d1a85mr53242455ad.44.1725385770089;
        Tue, 03 Sep 2024 10:49:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37cc2sm1169225ad.160.2024.09.03.10.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:49:29 -0700 (PDT)
Message-ID: <dd859c1b-40d0-4a10-a6af-0d7fae28da41@kernel.dk>
Date: Tue, 3 Sep 2024 11:49:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240903115437.42307-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 5:54 AM, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms.
> The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
> scheduling efficiency.

The elephant in the room here is why an 80M completion takes 100 msec?
That seems... insane.

That aside, doing writes that big isn't great for latencies in general,
even if they are orders of magnitude smaller (as they should be). Maybe
this is solvable by just limiting the write size here.

But it really seems out of line for a write that size to take 100 msec
to process.

-- 
Jens Axboe


