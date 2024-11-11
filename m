Return-Path: <linux-kernel+bounces-404253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA059C4173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485B02839CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9674D8CE;
	Mon, 11 Nov 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Pk5AIIoc"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C91E481
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337526; cv=none; b=F07qXUHaqNQ+FsAwUI0j28JQ7i0tKpWBkWRnDS8SodjipVPbdpxVFPOm+/E2UtDBqrkMa2TLhmUx6x0oa/Fnwyh5UVnL1RNbqQ5IOKSt4qWG9RQgu/jpZzOUzWh4pAAbcF2sUKNcB7JN3fuqpQS1aOrvmwWkyXMCJPPwnkPtuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337526; c=relaxed/simple;
	bh=pLCBWyOsezbkGbKj20wKcVS9Rh7859sxQ8iqgYIhwsk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZKTRgy32yuFpHAPOGuBCsZjTVvCkIFxY+a1L+/36EV27O/1lWa4XDngXRwXQO+LjgMfwzZtGVhQKOLwOSoDW2v6dNvOMW6ouPQPd884y4ZLYyRWNq0Vw16isvIOsUF28/AKrE8jQwVLCaD3EGxu+2y4qSXXlqJoMsmFD+flMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Pk5AIIoc; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e600add5dcso2111114b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731337523; x=1731942323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FANAFwLPA6uDqavKV1Ik7k6rIhcZlXUpeawJn43pCcQ=;
        b=Pk5AIIocAqFuw/NP+bFB+ao672vk2LV5UOBozrznBZ3WlA+a8Zjl5ySF5v9rfFkwH8
         RAiGGsr9ZDLhex3eOaQtnwBVftJ7J9o0pQNhBGyB43P6n7zemjg07xppUV3SHgbQ9/H+
         iXTETe/O34BashTVMMC48c+KRfCI/Ub+PWSu6p/h9hAgABIgckY8ctj25woeWfvz/EYo
         sUA8HNDDrTyPbnQI8reeI9xk2lvIR/SFJnDWpGpVbBMFQS6Okm3t/zmbPvK7k6/P2BdH
         q9S+Yg/7fIRjE5DMb983Ewg56p3uOkb4SmCtkooMxHCp8KnX4EfmM5tRgdIOF9vHPDK+
         zmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731337523; x=1731942323;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FANAFwLPA6uDqavKV1Ik7k6rIhcZlXUpeawJn43pCcQ=;
        b=iuhJl1SzHZPxx7s9XTblys0utovf77NZYLTeK3QD2SgC5l8ai6kw8JYI9aICXXsct/
         C0OFM7opjitX91JQsUiqY46hWMnaxPdAzr5TXPzfGJcCS/dnGTIrVdo4ubAYOggWmEk0
         9MFxq6AaiV+K2iO4dQsMa74+D3n9ZzYY6Mp2ZaHw69WsBYENGvqAhUi6C1uW7dun2ZQK
         qFMnRedn41h6oSjGsWD3ljtLuPa1rqHcFhGeM5oIOVmSfYteNbM9vOjEQjpFsJ4oaQ3f
         OZuKaL2PZd88cBfZWPZswdJzppUobrOinSGuDee5zq8Gdr51RA+mIR+hZ4qSf3eujsSK
         mIUg==
X-Forwarded-Encrypted: i=1; AJvYcCUzu52K+YEYX6jG7OT/7yIStBlwFX0aIABOHh94MMeHKbT9CjE6LHls4JzROj9U5UjImJWNNI7G2W5c8w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnuxaK6YiKaMcMB80s3G5K8LDgb1lEcxmMUillUHHjU1o7/5r
	Ynnj26/zL9ICFckPq5Fg2bRqYArtK9fmHE6PXRcq3VnxxylalO2ndf3QIUmAMXY=
X-Google-Smtp-Source: AGHT+IF4w0LezImfqUcdRk269iIRvUC3rDvyBtvyPDo1aUTBP1jSwl4AHjLVgkaGbGSvT/MFoIohTQ==
X-Received: by 2002:a05:6808:1919:b0:3e6:ccc:2d91 with SMTP id 5614622812f47-3e794721891mr10371106b6e.29.1731337523644;
        Mon, 11 Nov 2024 07:05:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78ccb845csm2096711b6e.28.2024.11.11.07.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 07:05:22 -0800 (PST)
Message-ID: <76edefe6-fb20-4169-8cbe-d8b864b04c7a@kernel.dk>
Date: Mon, 11 Nov 2024 08:05:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v4] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Metzmacher <metze@samba.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <63af3bba-c824-4b2c-a670-6329eeb232aa@samba.org>
 <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
Content-Language: en-US
In-Reply-To: <00c51f80-7033-44a0-b007-ca36842e35a5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 7:08 AM, Jens Axboe wrote:
> On 11/11/24 5:55 AM, Stefan Metzmacher wrote:
>> Hi Jens,
>>
>> I'm wondering about the impact on memory mapped files.
>>
>> Let's say one (or more) process(es) called mmap on a file in order to
>> use the content of the file as persistent shared memory.
>> As far as I understand pages from the page cache are used for this.
>>
>> Now another process uses RWF_UNCACHED for a read of the same file.
>> What happens if the pages are removed from the page cache?
>> Or is the removal deferred based on some refcount?
> 
> For mmap, if a given page isn't in page cache, it'll get faulted in.
> Should be fine to have mmap and uncached IO co-exist. If an uncached
> read IO instantiates a page, it'll get reaped when the data has been
> copied. If an uncached IO hits an already existing page (eg mmap faulted
> it in), then it won't get touched. Same thing happens with mixing
> buffered and uncached IO. The latter will only reap parts it
> instantiated to satisfy the operation. That doesn't matter in terms of
> data integrity, only in terms of the policy of uncached leaving things
> alone it didn't create to satisfy the operation.
> 
> This is really no different than say using mmap and evicting pages, they
> will just get faulted in if needed.

Turns out that was nonsense, as per Kiril's comments on the other thread.
For pages that are actually mapped, we'll have to skip the invalidation
as it's not safe to do so.

-- 
Jens Axboe


