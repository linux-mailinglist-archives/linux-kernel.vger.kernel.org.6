Return-Path: <linux-kernel+bounces-319075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A196F76E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F231C212D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C31D1F56;
	Fri,  6 Sep 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1jCn0htg"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3F1D1F7B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634262; cv=none; b=t8tDB7eWbDgiur63SJwIANwGdBXqDpa4thuNv0JA6OgkCD7KGteX20EJME7+2/B9N+atZJo92+cfBP8awTmDLio5sobMtBD9RAah+nfEHdcQe+psl44hwvOFS168W3K7KijcuuQLVIPMjkMNXzYwQdAcYf/A6fd9jUFPuXH+2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634262; c=relaxed/simple;
	bh=Bg9hJ5AL+IvxGCWyvU8rqLJ6yreb3n3IQc5S28odOj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUqZRFKcq/nVj9gIpblGgvIg9nn5zFxjEa4WbuvcQ9oOBFB17mZXFUl43qPDsfBCokFbWl69rEpp7izGon2u2T7K+45dtZqrZp9gh4Eb0NmkKbxPGS/CElOiky1W64vz/PCJbyJnJBsaVMZxeMXeT8HyOHEn+YXfEcat+R098HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1jCn0htg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so634030a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725634260; x=1726239060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lBMEQHLKMaF3jRPCocf543Y2cCOhdzZyzb/i804/c=;
        b=1jCn0htg9rIKVG3gr4RyvBW2xerbZqNoisHQnPRG3iEK14vJmz7L+TWa6jhp/zEyOn
         XBEM7LhlinIvDP54mlsId1BJ9NCGfEsXam4H9q+r2aQP5ei7jiw8aq2lAZsUNf9Td6lL
         LQ9ftrpH46BRFmXFj/iCgLdxyYNWlABeEpzNigeazYPsFyMZpCB/K4IcOHNtBsUx5adF
         TYdp2cScJ6QpzWlSsW5/vEoGW2SHWXQMblHIYZnmVhlSAOCQ+yDAQZjWyIwLbw9wzXxp
         ZFKVWoxtVJrvAixbsfWr4CPQMnl2pTYX/EkUL4j9NhITGqas0Y0l3iVwwDMfsidti9O/
         W+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634260; x=1726239060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5lBMEQHLKMaF3jRPCocf543Y2cCOhdzZyzb/i804/c=;
        b=XT6XsAlKGjmGQU0WAZmHyVvB0GDABoDSLnI+dYM5SwimosXmDGSW8x5Lht/9ZSN/6A
         +lJ7IITFTCvrxeF+2Get8vIBsp02m+uZtTWHX/CfUBieSUMbQ+PYFRPzh4bh8GmXJ2fJ
         q+plYUkuW2Nkmu+y6tUYKIo+1HsmadiQ4opG48RSJXMLWVfm4umGRzlG9PPznsvX72WB
         gJvoOv0jNOoHIxVoWzPFi5VhXPXXoF6TQsRsI5mcLB4F2f3xzDOzlaN8Y4vDMGlQIoE9
         HN/vwMuY6eF1+StBNB9lkfp7xVXhDzqpif5Azwuw22n2G+lq7GxKENchA7NWJrDJtsH4
         hFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjGf2WajRjvpDsE5KQUs4ScrQgE5GglIhh+xdcuSUi/W8fyxrMbYyHGGnYHfsQeaGViRR27GRPKRWvUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJz0ltUUfpALMLTWCixgnKwiWLONZdc/vmzKFKlZDdDC5b0Eg
	ogsz766fdenpPknFbHbfJg4ZnuAueth+uNTMes4qL0KCepo4u+cxHKx6eGEHYSs=
X-Google-Smtp-Source: AGHT+IEsBiV55U4YTmFuWCBXZ4clh9+5GpKkqbHGl45VMScWAVU6JAkZCc2jfIndMU3vKbc1JBztKg==
X-Received: by 2002:a17:90b:1083:b0:2d8:89c3:1b57 with SMTP id 98e67ed59e1d1-2da8f2f3f81mr15557313a91.15.1725634259950;
        Fri, 06 Sep 2024 07:50:59 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc07681asm1657102a91.33.2024.09.06.07.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:50:59 -0700 (PDT)
Message-ID: <ce1999f3-4b30-4e12-bbb9-9b0c090a7092@kernel.dk>
Date: Fri, 6 Sep 2024 08:50:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] zram: Replace bit spinlocks with a spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mike Galbraith <umgwanakikbuti@gmail.com>, Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20240906141520.730009-1-bigeasy@linutronix.de>
 <feb77bdc-512a-4f59-8a9e-1dc7751a2fa7@kernel.dk>
 <20240906144849.HrQCoqvn@linutronix.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906144849.HrQCoqvn@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 8:48 AM, Sebastian Andrzej Siewior wrote:
> On 2024-09-06 08:31:23 [-0600], Jens Axboe wrote:
>> On 9/6/24 8:14 AM, Sebastian Andrzej Siewior wrote:
>>> Hi,
>>>
>>> this is follow up to the previous posting, making the lock
>>> unconditionally. The original problem with bit spinlock is that it
>>> disabled preemption and the following operations (within the atomic
>>> section) perform operations that may sleep on PREEMPT_RT. Mike expressed
>>> that he would like to keep using zram on PREEMPT_RT.
>>
>> Looks good to me:
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Thank you.
> This is routed via your tree, right?

I can certainly take it - Minchan let me know if you have concerns.

-- 
Jens Axboe


