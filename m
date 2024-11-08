Return-Path: <linux-kernel+bounces-402259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520F9C258B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B84B1C22A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC511AA1F8;
	Fri,  8 Nov 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="r/8jhKZt"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA31AA1C1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093996; cv=none; b=Huz2CYyEgflEgOe2sraMLpC0Q6Gf35RhYXcCY1BzQTPPsuBjOgT7ZIjJ35v/jD9Zl4mzFcxSX2RsQnfAHIYzEZGrb98qKgM8PvMX6F+P4c0bq3Ip2bKYvDGsNSpLUyEVUkM5IP0biPGxs7RJChLjwCmow7j0musLRhZSOmsvWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093996; c=relaxed/simple;
	bh=33UbHbLKPpEwiyTVv36SF1QwVT9hVHQNqM5/3cP4sYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuWQOK96RhUyUa6QUjKkTK90QtI1+xTKcO7FXONmmOGMMtSQUyhejxbDV3B165KNq9lKCo55eILIVxSeS5VL4IVI0dOJW4r/D7zgbhTPWFi8U9lC8RUW/yZ7+Q8x/BzOJd15ve3TJ3mRhBIcceexA4TJKgpxCXW72lpyZinzy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=r/8jhKZt; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2887326be3dso1334813fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731093994; x=1731698794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agqhAPagizBXPK2hVPeT+VJofGCRxLOLIbcGDBqo4DI=;
        b=r/8jhKZt/VCQOt1POBP7GPThd1VKrrVvEdF/xqwTOORfXJegcg+ZvrSHSoPa3uG3NN
         c7IrzA0eZU2nQFVKyAVo3EIWejfrNcYJG9f1Tsw7oRYSBEkj5PAebtrdEoA0qrs22aqH
         R/mpkU9KcWJ5rxANdDUOS4hEN/jlVF7RNctpEwhZqh6jUlMaZvWaEfAf2ZQRfh88qcJp
         EebGvwgfbGoUNFtbHuHBTZuWgehrThYpTL/o53J37fVvBYGsB2r+Tn08f4sTUk3qkCrH
         I0dRxsKwTwnl8b9eDsxKqyeTrwjeFphRrZzqkq5hgpsPylA5Pf0BR0n/606tDEMVVpex
         VecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093994; x=1731698794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agqhAPagizBXPK2hVPeT+VJofGCRxLOLIbcGDBqo4DI=;
        b=wQojDa1ASrQDQ8xe/toyMzXPbUajxbjtSkfz08gxRG+KnKacEd11nBo2uKB27gUSe9
         64eTALF7d/j3zbuvB2HDLVUYBUzLzRhNOJmJQbn2yVuTw1gxhk8WMsGHGsIXKT7WDcDf
         7DnW8nZ2N+3dWQLTPbDnUYgNAHgAYJK+YNxw8KLV6vUMbmmc3+rnO23pxMxOgEHN4dL6
         9wHVdV8VJS0j5Gfgj3xAvUixmzeEkbHk9CmAlOZ8HrTVm9FXmG+eRBWk/uHGb+ARLxVu
         oeLTfjS1Li6WtZZTawclhXLNmlhfOkT74vWt1kKUc4Bxc08uidaJ9HGD7JXau3ErnOej
         CvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUa3CRiPrm5MDqhgfpaAE6pXlwLXuy1rcqiSBkN75Z3a0XOC6YW8prwaT1qsr3gVk0lAplk81rPYIqFaJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzzU72VQ6YLHq4RUvxPPh23RqiQJ7a0iFWI9cagICbVFK7sc6
	NvmXrUSiB9khqqT0dMb8FPjtGyK2XStnOPVh9Z0GcsABNriU9gOW29C2HfWLoWk=
X-Google-Smtp-Source: AGHT+IFuE6qpV/r1tyq6OqSn95Xx492UVUc2q5pIHqiwaOotZ114pdhQNU8Qog2j6qdVD8wuXOnlmA==
X-Received: by 2002:a05:6870:af83:b0:288:851a:d562 with SMTP id 586e51a60fabf-29560008f6fmr4367258fac.5.1731093994467;
        Fri, 08 Nov 2024 11:26:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f4884cbsm3886867a12.3.2024.11.08.11.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:26:33 -0800 (PST)
Message-ID: <45ac1a3c-7198-4f5b-b6e3-c980c425f944@kernel.dk>
Date: Fri, 8 Nov 2024 12:26:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
 <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/24 11:46 AM, Matthew Wilcox wrote:
> On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
>> +++ b/fs/iomap/buffered-io.c
>> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>>  		}
>>  		if (iter->iomap.flags & IOMAP_F_STALE)
>>  			break;
>> +		if (iter->flags & IOMAP_UNCACHED)
>> +			folio_set_uncached(folio);
> 
> This seems like it'd convert an existing page cache folio into being
> uncached?  Is this just leftover from a previous version or is that a
> design decision you made?

I'll see if we can improve that. Currently both the read and write side
do drop whatever it touches. We could feasibly just have it drop
newly instantiated pages - iow, uncached just won't create new persistent
folios, but it'll happily use the ones that are there already.

-- 
Jens Axboe


