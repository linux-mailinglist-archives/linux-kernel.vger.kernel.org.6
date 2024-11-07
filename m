Return-Path: <linux-kernel+bounces-400452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28989C0DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD521C2264D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811672170C9;
	Thu,  7 Nov 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gjT+5qAO"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0A20F5DA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004060; cv=none; b=JM/SEk4nY1sI1sLhmcBB1Fm0zk9OW1TLvadn10YBumWQZuaVNoFnrFxrKUMlAKTBkbKGL1/6rTVvK9rfNxtPSDHEWE/jGEezm2x2EqjZ5v6GgGBxCBTJ/BGqIqbKH5CBshZXaK69NqfCC1KLzix/TgGLH8iL22ntJQDr34PdP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004060; c=relaxed/simple;
	bh=20LrKDdXKwohLrR7m/+QaoGSjbWanGlIA0WTQG1VuBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+fAM+ZHp6G8fCYwPuu7bZw9tGZXJtL3+/Brij/EgzMcP4XRfJDIdiLVwNBXahLj7zmvhDamCkGkDsFDSkE9e88MB/Crs29bGxJfbhNLE9cl1js3bTRfrN+QZ0/aDilnA2LhHCeUahtLqVQhherGejjmOTrxhOe+S6tdl0fAKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gjT+5qAO; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29538198f2fso852416fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731004057; x=1731608857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVnaoenE/nrPuz7L1JcnZlXT27mO9irch1BC/+wWZcY=;
        b=gjT+5qAOs6q+hOnTQLfvkunfI2tkPZ9VwKkZIDzUu2L0pYWahtTs8cwco7Pf2qe0sM
         mx7+dQaKkcwEpx6cq6+3VeVOJgBThU4Yx0TSL2CvOI1xNLYjl7oikVhmSCFNKyTj5MFw
         VU6z8LSL4lMtVha4IyXb41aT1LcvQ+f87OsIUlRpX43S3z6sUSEHOv+ghc7ggObIx/z7
         wdPRKnNx9coOdSrl3Tzg8OkeqYwpVoLsbNOBDbfsogk0/txzNVM8gIGT/Q555/+CUb4x
         1Cz9CkvESPRyz5SHYrUNKMbstSRlUI14EKnIpG0MbYqt4+D2j1cBUF19sl+L4spzDyxY
         q/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004057; x=1731608857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVnaoenE/nrPuz7L1JcnZlXT27mO9irch1BC/+wWZcY=;
        b=LFSTMOFcu1HgP9BpikeNpxlsMCloxml26ICaNNHddp870LYpsl6NHamS13w8icFdH4
         ikqMb+NStgumBBD8d07ezyspVf4IoK/nM6QVfgI70fghRnRySGYuGeUbIWv3z9zHRMST
         tl33B3zsOJnnNGOr0XlXZZg9KSx3bq+LpaaPnTRBrtqszJzMroyH1ggHyrJzIuFtBToA
         H3tiCbL4PB76cntkQyzOQO1THXvXZao2NehMrbjjEeF5/3c78fV88lJ0kqHKjRRJvUJF
         1W2/zzciDrGP1z7SFVUJ9QPnYlp7ka7ihP9MunHL/x0f1oLGh5601BHX1Mnd3fFfS34Z
         cQUw==
X-Forwarded-Encrypted: i=1; AJvYcCWA43eE7B+X6k8ECNX2tNkphTWML7VDwg7J0wLxvFgicqSmhv9rbBx/6pFwHk8QYRPWjj9ZXwKYtPmsFko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2llYM+56PBZWF9f78dlYe0RniywGI1ZCiZUBB01kYavvvWJT
	4nXFDDmGFRMKNGcGZ3Mm475fP306IJt2om6Ppw6WqEXrNsu2BOjnaE/zUQXJdAA=
X-Google-Smtp-Source: AGHT+IHmQOgwVXtosc5C3zjOqsrNAr1v/lfSp7QNRqpm1iXYwNBCmnKvsMh+W3pIhyccXko0ObQGvA==
X-Received: by 2002:a05:6871:5891:b0:288:59d3:2a03 with SMTP id 586e51a60fabf-2949f07a886mr21485563fac.39.1731004056679;
        Thu, 07 Nov 2024 10:27:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f3f58dsm490090fac.49.2024.11.07.10.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 10:27:35 -0800 (PST)
Message-ID: <26049689-238e-4f04-9a68-db002ed5c1e0@kernel.dk>
Date: Thu, 7 Nov 2024 11:27:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] bio_split() error handling rework
To: John Garry <john.g.garry@oracle.com>, song@kernel.org,
 yukuai3@huawei.com, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hare@suse.de,
 Johannes.Thumshirn@wdc.com
References: <20241031095918.99964-1-john.g.garry@oracle.com>
 <e0a82859-6c9e-43d4-b6ee-4b96fa193fa9@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e0a82859-6c9e-43d4-b6ee-4b96fa193fa9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 11:49 PM, John Garry wrote:
> On 31/10/2024 09:59, John Garry wrote:
> 
> Hi Jens,
> 
> Could you kindly consider picking up this series via the block tree?
> 
> Please note that the raid 0/1/10 atomic write support in https://lore.kernel.org/linux-block/20241101144616.497602-1-john.g.garry@oracle.com/ depends on this series, so maybe you would also be willing to pick that one up (when it's fully reviewed). Or create a branch with all the block changes, like which was done for the atomic writes XFS support.

The series doesn't apply to for-6.13/block - the 3rd patch for bio
splitting conflicts with:

commit b35243a447b9fe6457fa8e1352152b818436ba5a
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Aug 26 19:37:54 2024 +0200

    block: rework bio splitting

which was in long before for-6.13/block, which it's supposed to be based
on?

Please double check and resend a v4.

-- 
Jens Axboe

