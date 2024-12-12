Return-Path: <linux-kernel+bounces-443294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE89EEB37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18593188C38B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6A215795;
	Thu, 12 Dec 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ii9ySUaj"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFA215F6A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016651; cv=none; b=kxUY+8buk7+wUW5iEMD/Aj12a8yWEEqUR39SczXPFMJcOn/niev/hLGqBOSXvkqs3fIhUXl4l9sc69Hxi2NExTEXQatNv6+nA0Uz5jq3NWZ+7Aj4iie+0nDvuBDAPaYTH9ZQzFh69obc1h2jbthPNCF4fX29SOusIbLpYon+Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016651; c=relaxed/simple;
	bh=O34mU9BicOTIzXXlemC0SOP4MHckW/JauB2QDV8v38M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UxByKYXZhAMbw0VYCOo0JhftQZhUh6wQzs38twcPuM5yd/4XhMVCUFCQUGc+OfxHcrWwl3N2ab9sjB+53phwK4OP5ws9puUhoEeaS0lKIIzWPWB1H/geH8nrDq+YG6MxjSIMOSFTjmzvF/+1AATGoY0lrI5hC8C+Wr3esjU6fG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ii9ySUaj; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844e1eb50e2so17508639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734016646; x=1734621446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fehtCmfLEhAnhMAs9XmPpXkgNCPRSdop9c/IyGTf0+A=;
        b=ii9ySUajsZSR4Z+Phk3rSmKhjR+Tiv+fhKuLUsbnZlFl8SS9A7zABfzccUjtT9Yc1d
         A03B2a3MSVeQEh5WtVarpXkbD3eaaD/hDi30U49qnp4skOx+M98JZ31UBFIrK/hLpKJQ
         B2URDSGmAgYI7aJvP+qrWjkomT0gepjyP1l6gaCJZehtZxKJGrSgM/r3pb6fwSgORER9
         vZ01oBAPraUfGTy6B0Neb+P7V98yfo4kGLCipSbNzxglEbfwVT0CeQkfzCkJfkHbRCdy
         POQZEG18lXiJe2P7+KhwY+KWxUHRHI+O3fOARnr/uQv5SXk6irePOMSDzWaoy34NnCsg
         v86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016646; x=1734621446;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fehtCmfLEhAnhMAs9XmPpXkgNCPRSdop9c/IyGTf0+A=;
        b=NG6ZnlsJrj5vGBA650owD52L40LJk1YWLQRkS971Cizl2y7/9EsDrzs26W8Q+4WvUA
         gD8rcMl/WibFsXKVlb3feyO0BkLRqnQFiByMCN5vLN9Iwb1IKY74JVehPcnSvu1cVXin
         /2AsGyVwPjrvrtlgtO62MiIlskh+zqHDmk/DWmVhnnyuEC7o+DeIYnHnyYOlK5TD6Glj
         kZUKWCyRkCL+Gwo6l9IdWNKpEtFTI0YaCxStCxjYyTKBgUJxRJT6Ng9dF/sD66LqZ9+R
         P6QkFbhqQadeS0ZPCFIjSUyJSFGAgjBF/oHxC5jyj/mgb/6VHrEPaGFbOtSznYiXL+bH
         DEQg==
X-Forwarded-Encrypted: i=1; AJvYcCUDQ/+Mo+KmJ5E/2gjJFSTNIf6dlYTZ9HGkzlhlplVWNt1VFFUFj6Q2yW4POe/Mo2AolluP61II7aWm0Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwLgzrAef910XyzAh/4f4xsSRTLNlAeOlm2qMG2neus25zD97
	mhb0NHcUr2gZw4ZzXxno1m2hdSOf2Mqtq5NXuVGsrzpoj1gBF7baAnUJocB6zQU=
X-Gm-Gg: ASbGncsdCzu2NTHpyeVMwsJamOtr3XCg07mPilIZ5JR7JGkisNOc6dhzLRESKbcUOxR
	wn26rTYSLdZnojI73tqqUVPCdBvysWqzh9olYNrze/dPqyKoFA1/yqVvxEj8/HFTwH1A2YRinEZ
	t+GC/ZZnXC0Z1L9bQkLaKpHf4Ct0GvfquEi/ME22DDS8n2FUB1R8UUZfgfuSQxmfDKfyDvPPvis
	jm4x97EWrw7Ult3flCIWyr/NxwbEavg78Cw59WSDN+SFDwp6fOm
X-Google-Smtp-Source: AGHT+IFQm9CYltIiC/WcZ0xxvnBpS/y1h3K0WB8iYdoJ3KTbqlSyxjRiufO1azrHA+/MYhJjiv+1+A==
X-Received: by 2002:a05:6602:6414:b0:843:e667:f198 with SMTP id ca18e2360f4ac-844e55fe6d4mr86288139f.2.1734016645749;
        Thu, 12 Dec 2024 07:17:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844c56a9242sm120215739f.23.2024.12.12.07.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:17:25 -0800 (PST)
Message-ID: <b2414e26-4932-42b8-adea-c79febf8e30a@kernel.dk>
Date: Thu, 12 Dec 2024 08:17:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [io-uring] use-after-free in io_cqring_wait
To: Pavel Begunkov <asml.silence@gmail.com>, chase xd
 <sl1589472800@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CADZouDQ7TcKn8gz8_efnyAEp1JvU1ktRk8PWz-tO0FXUoh8VGQ@mail.gmail.com>
 <54192dd9-d4e6-49ba-82b4-01710d9f7925@gmail.com>
 <b5a0393e-dda8-442c-be8b-84f828ddcc51@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <b5a0393e-dda8-442c-be8b-84f828ddcc51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 4:30 AM, Pavel Begunkov wrote:
> On 12/12/24 11:21, Pavel Begunkov wrote:
>> On 12/12/24 10:08, chase xd wrote:
>>> Syzkaller hit 'KASAN: use-after-free Read in io_cqring_wait' bug.
>>>
>>> ==================================================================
>>> BUG: KASAN: use-after-free in io_cqring_wait+0x16bc/0x1780
>>> io_uring/io_uring.c:2630
>>> Read of size 4 at addr ffff88807d128008 by task syz-executor994/8389
>>
>> So kernel reads CQ head/tail and get a UAF. The ring was allocated
>> while resizing rings and was also deleted while resizing rings, but
>> those could be different resize attempts.
>>
>> Jens, considering the lack of locking on the normal waiting path,
>> while swapping rings what prevents waiters from seeing an old ring?
>> I'd assume that's the problem at hand.
> 
> Were users asking for both CQ and SQ? Might be worth to consider
> leaving only SQ resizing as CQ for !DEFER_TASKRUN is inherently
> harder to sync w/o additional overhead.

The CQ resizing is the interesting bit, SQ is just there since it's
pretty much the same operation. SQ resizing alone is useless imho.

We could always just make DEFER_TASKRUN a requirement for ring resizing
for now. That's where we want folks anyway.

-- 
Jens Axboe

