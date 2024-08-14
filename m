Return-Path: <linux-kernel+bounces-287124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB6952349
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241461F2141C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01A1C37A7;
	Wed, 14 Aug 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fwhs2YKg"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C231BE86D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666946; cv=none; b=CCSJHyy8M/xxVxItZ12y7XoOenM2voU7rXA6T5Mt4QKWJK48860xYO9DG5niXs08GseKnNZBiFreiPWRb3o+cIGmqC83q218cuTWYWOBGPle5BtJv8r5bxvVuFCnpfSwhrTZ7g5bzqcnyTCo4fuSqN51/fVQvTMP+SLCEI3laAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666946; c=relaxed/simple;
	bh=5SRnXsvGe0ks1PPk2d6iR2E36xrdoQ/xKFVPBkEc0G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3W9kG3Ivg+WIQSsf/L5CShy1MKN3tLG12Fla87AZB0l2sLhIdUEsNERygcPBAyGGMmzTu0ihSa4R3amYxXrVNPUnWBXjHo9r5A8C/4FHho2jwcmkj7s0zZgZu8oxNIUiY/Wvn/hKOrT62scy+gaBjUhDdnLA0RnTu/QpT1beqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fwhs2YKg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-75abb359fa5so44946a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723666943; x=1724271743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qrLHDtIlgRrYjlbN2SIttaAtVkHKsw4QroqjhY2qOA=;
        b=fwhs2YKgxuOfojl6WgZszKAS5tEhCkLnpAN5NGBczmLdI4grvofulZLsuyIvozQ+7a
         +hgwttuGNTh7q9OFX3jm9yiwzEZN5Sl5bncFYFN544jc5rdKlMoVM/b2hYdPsvSffLRJ
         rThwPfX88UdOZkg6DANdhzUMNgmt2K04xi6WIXhne4UUFqHUKnblPXgys5uXcUqUwcs1
         lGFj50xjyjNBfuiRs9l5AAGudUi24qB35H3j7fNaYNLGBEGQAwLUz6U6J8GOISTOcKlE
         JXb9kByScn+BgyoNPy/T1ala5Abcs89KhPB/Uaxy1FhLxN456pm7moWEAO77HtddLah+
         ZtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666943; x=1724271743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qrLHDtIlgRrYjlbN2SIttaAtVkHKsw4QroqjhY2qOA=;
        b=Rt+dSTIZSeS2bbt4z8H8slNOW8sK0z8jSypOwR9UNG0g/hteEZivZcqQL0GDRroq+M
         KVT4hv3s3xrJ6618qIlCxDRfVXGudpUAgP5SF87T1UQOlc/mnrMHPScaqJqY0EF9c2CR
         ZSXIHOWmw9Y+eKVktYtKVGkqMAS3jgLqgwfKHtgnvSWkwO8wYAkje3lwZ6jvHuWgwjOa
         qOEwZPu/iA9H51kdEs+Vm7tRXY/NWAo4eQ/FmKGD4oaEBusEpuB0keSOgUrAVPvuFU/L
         +m0Y2RC65l6/HkNy45YZS1lO2jk3seZyyxYmt03R4DTgIdngspwuONa0bkMUHtjhS3yY
         s9bg==
X-Forwarded-Encrypted: i=1; AJvYcCUGC0mBNX56ng9I234A6MgGTkhb7pPAfmXDFxlkQzsbfs3JIcIF1lodMTucFvcckqc/LJ8z00hlTM5ZfRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtHPS6rwaCIytaLKA8JwYPmGvqms/ncUX0w8wnIrHGJ22/AM0
	B4s9MYPpk5XynsnTvgIrGNcZHwfNKBCPc+Ymg38sAbMD9kHIOqBGaRQrxsqaFo8=
X-Google-Smtp-Source: AGHT+IHvS4UxsLTCsRRg68/apHusWWi9hP1XGhri9rFG6yGlwDroEV/2XrWn3KKUdwV+vsDuC1Zbjg==
X-Received: by 2002:a05:6a00:9446:b0:70a:efec:6b88 with SMTP id d2e1a72fcca58-7127831d8e9mr331374b3a.3.1723666942573;
        Wed, 14 Aug 2024 13:22:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac4184sm7717850b3a.215.2024.08.14.13.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 13:22:22 -0700 (PDT)
Message-ID: <6e729890-7374-4335-ab7d-ead00775057e@kernel.dk>
Date: Wed, 14 Aug 2024 14:22:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix potential deadlock warning in
 blk_mq_mark_tag_wait
To: Bart Van Assche <bvanassche@acm.org>,
 Li Lingfeng <lilingfeng@huaweicloud.com>, hch@lst.de, jack@suse.cz,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, yukuai3@huawei.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, lilingfeng3@huawei.com
References: <20240814113542.911023-1-lilingfeng@huaweicloud.com>
 <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ad92f738-9ba5-4cfc-aef5-3918a35e77ec@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 1:52 PM, Bart Van Assche wrote:
> On 8/14/24 4:35 AM, Li Lingfeng wrote:
>> When interrupt is turned on while a lock holding by spin_lock_irq it
>> throws a warning because of potential deadlock.
> 
> Which tool reported the warning? Please mention this in the patch
> description.
>>
>> blk_mq_mark_tag_wait
>>   spin_lock_irq(&wq->lock)
>>        --> turn off interrupt and get lockA
>>   blk_mq_get_driver_tag
>>    __blk_mq_tag_busy
>>     spin_lock_irq(&tags->lock)
>>     spin_unlock_irq(&tags->lock)
>>        --> release lockB and turn on interrupt accidentally
> 
> The above call chain does not match the code in Linus' master tree.
> Please fix this.
> 
>> Fix it by using spin_lock_irqsave to get lockB instead of spin_lock_irq.
>> Fixes: 4f1731df60f9 ("blk-mq: fix potential io hang by wrong 'wake_batch'")
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Please leave a blank line between the patch description and the section
> with tags.

Please just include the actual lockdep trace rather than a doctored up
one, it's a lot more descriptive. And use the real lock names rather
than turn it into hypotheticals.

-- 
Jens Axboe


