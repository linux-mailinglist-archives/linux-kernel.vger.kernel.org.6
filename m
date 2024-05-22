Return-Path: <linux-kernel+bounces-186579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7F8CC5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD36F1F21D48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C211145B03;
	Wed, 22 May 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JZW6DHNi"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188FD46AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400660; cv=none; b=AV/NhT7eFfqOszWiollQSJemYGHgYWdMJsN9nvAUs1PJk75Mp0WjSMIivZsb+OHkiKeqedW6MHZtjwg/FuQFB1Z24rxr0/GdEZNuxCD279UoWmK+HQMLL87aUkJbfHaUSUiiXjLG68jT0aeZr0cXNcfjbpWc47qkmnH5ZKZoyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400660; c=relaxed/simple;
	bh=km6GkJRH1oXle4Y0aeGjvJ9VZaAmz5Ww5mIIUQ0fpFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTZdu/xKz2RJgmPT6WZCdT9mRApUtk8e3axFiHzb49MTa+mTCHiHxHt9q+imIOe1NC7wEMy/1KM06Nv1jGYP6IFkLkwxCt4qOBteLr8GhTm3+Baie9zQm3z3LGwN0QxOBssF0M+ZL2Am5JkfpggMluv9AF0PbKvo31bGN/2nBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JZW6DHNi; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e1b8718926so44148739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716400656; x=1717005456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvzMaUzKqFOseklIwtjARXZ+I/8PBiP7raqhNOSJqDw=;
        b=JZW6DHNik4i+ZmVTi1e+aXeZz/LUGUchQgL0lIocvg46NrLytfU85zIPLLbXqDkhI0
         2sJIrooVtdWhV0jLn9Xr+hwJkEWE/YIgzaqOw9f0lj00XDdPF8L39HtGjXHdGkinbGUK
         CqKk96pF0CAN7DsyFzG3HjYdq4+KbTXLmh5ehWP/bmR6nkOx4uiz47Yzc4z1jAye+v5H
         IvecX/zyJ1duFRJHFRPsN/rLww5pnKXPrqXgF+Nrb7XCq74YRwmAcp4Ewq2b9qh+oIkV
         yhixLCJvX3V07vtJas59GoGcoXNhQ2DG4twxLCZ9usbMFJokJMO1WEo14A8Zfz7dv48d
         KihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400656; x=1717005456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvzMaUzKqFOseklIwtjARXZ+I/8PBiP7raqhNOSJqDw=;
        b=B6eJ3LfDZpMubm6QMg75vJT2jEqigZzBjAS9ZINyYAocIiLoBJPvaQbHDkRgyDI79f
         69O+YT/VA7uQEmVLe2UKIX15y4l9aK66PaiJNk+4ymzDEf08BrGkd5AGx2CVu8mUabAR
         gQOyJ4w6TPYPyJN+OSDnJtStP8v8Rby/E/n28ja9B+jLzqEmWrCOp8Ev38vxiYrgo4Go
         adKTp+eYIXs5Pb2q+ujq3jjWHoofgijpCOawb+mFR0X/H25ffPmDwnWyKMffWaF83mXH
         5APKxnNHTIxGANzV+75826bBF4fXXEaoxKElL0zFdUiEVQRVtVQKACzZ/yt6js0bRR5z
         Apmw==
X-Forwarded-Encrypted: i=1; AJvYcCWT9wc5GRhAjjRnLEbihEaPC1TIq/ZDm3QKpRqfHhm/nT/2HOULafRppNx9T5nogV8Qd1gZOfKXSeDclrGqXOmm65rCUxhadsDPUD0W
X-Gm-Message-State: AOJu0Yw3EGtQbSIzOFQ9mluFHwZFyYE6YABMIbQpfe9aQeuEiiK1GPsb
	hg+IxXVYiUYuPZy6VVNFK7w3Jev96VpwqyYcXkwL08vp/Y6NCVp54/6oaLNdaR8=
X-Google-Smtp-Source: AGHT+IHXUHRzeijL9T4CaAAoS3S+jdJoetWF8AHLSeL5TvrVSBx4SyHEVK6B66pE+FSdZ/SqPFVxTA==
X-Received: by 2002:a05:6e02:1c47:b0:36c:c86b:9180 with SMTP id e9e14a558f8ab-371f56c8a4amr30384885ab.0.1716400654771;
        Wed, 22 May 2024 10:57:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3732463eeb2sm601815ab.84.2024.05.22.10.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:57:34 -0700 (PDT)
Message-ID: <68cfbc08-6d39-4bc6-854d-5df0c94dbfd4@kernel.dk>
Date: Wed, 22 May 2024 11:57:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: inherit the ioprio in loop woker thread
To: Bart Van Assche <bvanassche@acm.org>,
 Yunlong Xing <yunlong.xing@unisoc.com>, yunlongxing23@gmail.com,
 niuzhiguo84@gmail.com, Hao_hao.Wang@unisoc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240522074829.1750204-1-yunlong.xing@unisoc.com>
 <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5166bc31-1fd9-4f7f-bc51-f1f50d9d5483@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/24 11:38 AM, Bart Van Assche wrote:
> On 5/22/24 00:48, Yunlong Xing wrote:
>> @@ -1913,6 +1921,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>>           set_active_memcg(old_memcg);
>>           css_put(cmd_memcg_css);
>>       }
>> +
>> +    if (ori_ioprio != cmd_ioprio)
>> +        set_task_ioprio(current, ori_ioprio);
>> +
>>    failed:
>>       /* complete non-aio request */
>>       if (!use_aio || ret) {
> 
> Does adding this call in the hot path have a measurable performance impact?

It's loop, I would not be concerned with overhead. But it does look pretty
bogus to modify the task ioprio from here.

-- 
Jens Axboe



