Return-Path: <linux-kernel+bounces-315196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4529596BF1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB63B24CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ABE1D58B9;
	Wed,  4 Sep 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hS+jiD42"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312441DA108
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458011; cv=none; b=qxarBj4T1taMZLk8mrRcl3PJwRzxO6SVEgJRfKn6mi0wb6OVBCyf8cWFNSNP4aSfP1vvJbClGWCF5AMbdm2ix+ditvjvvoNUO5JCUekdU70vRnDOGJayYF1RtQvsA0uqbYwWUd33+5zA14LcN8QYHUL5agY+KRlywVWN0iFnTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458011; c=relaxed/simple;
	bh=bCCy75tHcqfvZeyJUrW++3GDyn/NtOzf4apKrtPuliU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeDMTLd6+imt1avLTxEN5VCQ7Z3vREgMv9URl22pH+LPR90kpfqlLIR5dp73W+T7L6WTJHSsxOb+9qtuNrKFaEcpHnMocN60Qj8PsDPB+Be/hack67o3YuOOo6GmWMQff4wLz16x1GoDdQK5uJs3MxSB4HFs954Bp9lKiqkVRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hS+jiD42; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a043390030so1382945ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725458009; x=1726062809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7kTLsJyk/MZC3WNMNI51yi9z/rphbSOOoUjCA8uaQU=;
        b=hS+jiD42ovTUTXrGPKwMNlHJK4jmIQJHFnWuOci2WN+EtaiEsn9EgDSJSbAcN9hiit
         tP+zPzXU7/cOtUaXqvlYcKF1Y6jyvyEOdpbpuid/NM1kUbNyoQx2nXGmkWQMO6lTfeP/
         EIv3RjTyOXtDeKvae6MfJgcit22cIkOYnSGqwh4ZDthm//yc8Rb0v4qIehsz0W1GjI8C
         PC7ann68RESdFHynVlWlWSEGrGQ9BdO2CYlWXsAZDeVSt1+N21+AwRZ5fTytNJntWNyd
         OXtRihc+bJ7WijOX6PbFyGqeivUxq4QxePjTPBjMWdZzK3nXYEC7vOARZjFpXEFl74ea
         e/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458009; x=1726062809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7kTLsJyk/MZC3WNMNI51yi9z/rphbSOOoUjCA8uaQU=;
        b=AQSnY7EiSuWUx6pTqtzB6QMC/xVa+VevgJAhd3LhxEPWwoeY5ixkV7FDHNaCqKvWva
         eBrjuFaBAcNZwXNfeJQBAxLYsfZ7AQkqioykN4TjfBDxMpVxXweYbg3i3Riw6wj3uXlE
         gbzPTfjDGD0GNZgDDOafpIQh1gqnL5vJ7BTBPktAiIJbqp85QDqAlKyfYYEtQekebvoZ
         RyqQsCtlcGF060bNpXp77CTnd2xnGoogeJ3THB8qMyAYiNIQWS+FrKHZh119Rb2XNLbt
         hjs7QSPc51wGg5pXwvxKsgXHyaPytCW84WYakPIvHPnA05SZyiR5PPlYqnFLw00vGGdT
         FTwA==
X-Forwarded-Encrypted: i=1; AJvYcCV19S3i8JoVSLpDsndnVA2h89JL5xF4ov/BcagLAMSNtPg/BBqPet9vdwsqPfL7IUJfB693DF/qRU5OhUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TrO+8+FZP/jD9iJXN3ywRE47d7IAgexhAcoclqV8Qgon6oZw
	WYWYEylQOTXjhUjgp5ORIl1Cbi5cnQmrGD733KICVR5qpjE35aDVjNFRl1ICRP1SFimqNeVKbAv
	k
X-Google-Smtp-Source: AGHT+IFbfJF6J1NLerOOEjFSrOLoyu7FtfSqVr0k9qMXD7kZr+v8XYpOfZHf8UT9kcO7HZL9AquDwQ==
X-Received: by 2002:a05:6e02:160e:b0:382:64d9:1cba with SMTP id e9e14a558f8ab-39f4f55f3d9mr163683405ab.19.1725458009221;
        Wed, 04 Sep 2024 06:53:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d06a1c5cdesm5424173.81.2024.09.04.06.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:53:28 -0700 (PDT)
Message-ID: <850a38fb-79dc-420e-ad85-1a0168f9e63d@kernel.dk>
Date: Wed, 4 Sep 2024 07:53:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, paolo.valente@unimore.it, mauro.andreolini@unimore.it,
 avanzini.arianna@gmail.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/3/24 7:32 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2024/09/03 23:51, Jens Axboe 写道:
>> On 9/2/24 7:03 AM, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Our syzkaller report a UAF problem(details in patch 1), however it can't
>>> be reporduced. And this set are some corner cases fix that might be
>>> related, and they are found by code review.
>>>
>>> Yu Kuai (4):
>>>    block, bfq: fix possible UAF for bfqq->bic with merge chain
>>>    block, bfq: choose the last bfqq from merge chain in
>>>      bfq_setup_cooperator()
>>>    block, bfq: don't break merge chain in bfq_split_bfqq()
>>>    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
>>>
>>>   block/bfq-cgroup.c  |  7 +------
>>>   block/bfq-iosched.c | 17 +++++++++++------
>>>   block/bfq-iosched.h |  2 ++
>>>   3 files changed, 14 insertions(+), 12 deletions(-)
>>
>> BFQ is effectively unmaintained, and has been for quite a while at
>> this point. I'll apply these, thanks for looking into it, but I think we
>> should move BFQ to an unmaintained state at this point.
> 
> Sorry to hear that, we would be willing to take on the responsibility of
> maintaining this code, please let me know if there are any specific
> guidelines or processes we should follow. We do have customers are using
> bfq in downstream kernels, and we are still running lots of test for
> bfq.

Most important is just reviewing fixes and tending to bug reports, and
then collecting those fixes and sending them out to the list+me for
inclusion. Not much more needs to happen, this series is a good example
of it.

-- 
Jens Axboe



