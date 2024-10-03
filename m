Return-Path: <linux-kernel+bounces-349645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F398698F98E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1371F23763
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269461C9ED5;
	Thu,  3 Oct 2024 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q+daZcbs"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979E1C2337
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993193; cv=none; b=ZBIxwSfITFd54H8yGHBAn47AMKCRqIyysv64JYn3XpStBSz79X2ICyV+7ta+1ex7WfCTEV7IrR09aGqNXH5sInPQ4UAy0hfoWJnzN6jIzi4MQ769y+/lILXamNwA2wC8UEhj3bh6WHC7E0yjG+li04bERJ9WS6l4vVIoSQe+rUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993193; c=relaxed/simple;
	bh=Pt1ZUSvFX87DVRXIwapbBHcWsvds+a/vkDyvcPIZRsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlXke6gjLR1rKxmMqdeRd4MxlUXNIT/gPeXXjyDsHFElWeppGrrS7RA55TCz8nyhJh/t2EJHc9QlFvKAJaRepGqY3S2SFyraNrpimFrIxeZFKoJ+A4LOiORHfdKkpwVsqy1yZeAN5Jjk59D9KbIvQZpA0G0bweGjFNQNAY/bXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q+daZcbs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b9b35c7c3so14900315ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727993191; x=1728597991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/n+Bm+NK1yV3ykOPuXSmp/mRwlagEN1LGfqlR+znwqI=;
        b=Q+daZcbsvqsmbadFRLjG6dF6/7BzcWDMhyc6RnMUaHPCpAHcHQGgRhc9T6r2rMWLSx
         LSNGnYG1NrqN3AF0dAliwj0inSSv5yKaQRNDGKDj2vi992rHyxwYNFQ1lj8USvUOjdvt
         SiuvSeLwZhzX2DmypLgunZM1R9Pt/YmL8nat1LDLlqLpSqeFsOHHV1ZhZWyg7oQqIq5o
         56DQxD1daUlwTxnvWhuM9sSo8wRp85Nh5CneOgJ5pDa97xhR2y1xganV+DdpjNUNDX97
         oLmFDb2duAqtkB5fJ/9h7H/SIx5t88rViVTpmdt8YKYzwk5ZgTIG4gYxk6IfTeqXsYaf
         2wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993191; x=1728597991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/n+Bm+NK1yV3ykOPuXSmp/mRwlagEN1LGfqlR+znwqI=;
        b=R+UkPCex3vaPQ0ZKUN3coHkWOZWEoyuiFR0ZhoVyCqfNsVY/lqETbMe8fNDxEOZQA2
         elbKTcsoz6DfVbFVchsEsvL/Qd329/tOP8eJS5nM7MLfC7bX3nI0KrtZmCqCMycdhxAG
         8XGp2Efl/FrfnNBl4M9Of7OmLVUthrEP/poXGsgad/eD0fs8hnoDoukKW7sD/UJcAj3r
         pv1AsB1oS1GS2slklaoc+/LPwassC6lLfog41TnaEEO7aezswZhKV+HGC+vwxgCyHoN8
         3kUepltk//ETuem6mkdjZE+jHQOkDKpCYP09N1FkYeLH4+zwvy8+wetsYcf/UYaYWUvm
         uesA==
X-Forwarded-Encrypted: i=1; AJvYcCXXYWSHlwDi0DUqiGNAhyOxfPf18JOiFUJHiAb3jR9NlVNNRl1fHpXKeWoeMyEQ8NYO9aflVljlkfuO2wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdzfVjs+9OTw0VrlQMxdmfH6DnpGo2Aj91PfHwdndYa7oz0xY
	TpyT0Po66sEBk2wN2rIpxfbgzfhj3QwUqxXCxaABTTdhi3lPOgZcMGNNkf5iLmqwU7J5CXffrdN
	3bg4=
X-Google-Smtp-Source: AGHT+IG3Z3RoW+4gVwOQPtL97jDrvwXJXpPy+ySiF1kDHRm4DfIx6MZYfO3x19vUvzG8fbDYEx7ERQ==
X-Received: by 2002:a17:902:f64c:b0:20b:982e:73f5 with SMTP id d9443c01a7336-20bfdf6b4d7mr8219805ad.3.1727993190942;
        Thu, 03 Oct 2024 15:06:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca2235sm13554225ad.105.2024.10.03.15.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:06:30 -0700 (PDT)
Message-ID: <d5b34514-aa3a-47dc-9521-d2774c1785a2@kernel.dk>
Date: Thu, 3 Oct 2024 16:06:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Tejun Heo <tj@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Waiman Long
 <longman@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
 <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
 <68f3e5f8-895e-416b-88cf-284a263bd954@stanley.mountain>
 <c26e5b36-d369-4353-a5a8-9c9b381ce239@kernel.dk>
 <Zv8LAaeuJQkvscWF@slm.duckdns.org> <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zv8NBM4mOVoMoBQS@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 3:30 PM, Tejun Heo wrote:
> On Thu, Oct 03, 2024 at 11:22:09AM -1000, Tejun Heo wrote:
>> Yeah, that should be spin_lock_irq() for consistency but at the same time it
>> doesn't look like anything is actually grabbing that lock (or blkcg->lock
>> nesting outside of it) from an IRQ context, so no actual deadlock scenario
>> exists and lockdep doesn't trigger.
> 
> Oh, wait, it's not that. blkg_conf_prep() implies queue_lock, so the IRQ is
> disabled around it and adding _irq will trigger lockdep.

Ah makes sense, didn't realize it was nested under the queue lock. Then it
does look like it's just that one spot.

-- 
Jens Axboe


