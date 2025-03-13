Return-Path: <linux-kernel+bounces-560045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3528A5FCF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12A617F8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAE1552FA;
	Thu, 13 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vIhwNBwy"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C2153801
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885407; cv=none; b=uLUHIznLTsA8StL0aAoqmVyPe8Y36+JXmlZE0eMvMDswlmgEWiG5EwLMRWEDSxAxrHj2yovUSIm11gB0xeNdbc04dyy1Ef1GgEvPg8ocjTZFsehvHvqQvlZoabocKVVaYzg26M9IAi/l18+6LmML2ZRkUkBc6A818nWhJ7yLc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885407; c=relaxed/simple;
	bh=rHd91RDVZblAGkL9tzN0XV7AHBKS9VBYY+yYlPibRN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNWtcsI/sr691NvfjYFHDMqlL7LZVFTdUVrDaLZOmyUJ8xnvwCwV0TlzYR99omFWpmZU5uYEhhA6xot4ifdhWjYZ62YLFqT0uFrF2EZMnhk0MNGp72FjzYLf4OwtC6sRAPDVscVCePKTHIQdMWFlwNZo46yo6V4uYTiC5jx1rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vIhwNBwy; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741885402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wcq4k6tGNSE5Yn0/7eafZbLAzGJWuw56xZay697EIM4=;
	b=vIhwNBwyHcr4PEAJ+pjazisIdLm3yG/A5zwei8NPmLqDjQ6IOTHy01O/9FtFgD6hh3KdfR
	+7fCO5ZSKg4n0VsNshOry0CZdgerepmy+4FyKS8bDo2lstBFkYTAa/fXRAaJlV8/jMZwbn
	bUTKZu4eXRYgg2qhMFH5982CoukTRy4=
Date: Fri, 14 Mar 2025 01:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z9Kt57aAC7XET7Na@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/13 18:05, Ingo Molnar 写道:
> 
> * Tao Chen <chen.dylane@linux.dev> wrote:
> 
>> The poll man page says POLLRDNORM is equivalent to POLLIN,
>> so add EPOLLRDNORM here.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/events/ring_buffer.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> index 59a52b1a1..5130b119d 100644
>> --- a/kernel/events/ring_buffer.c
>> +++ b/kernel/events/ring_buffer.c
>> @@ -19,7 +19,7 @@
>>   
>>   static void perf_output_wakeup(struct perf_output_handle *handle)
>>   {
>> -	atomic_set(&handle->rb->poll, EPOLLIN);
>> +	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
> 
> So what does EPOLLRDNORM mean to begin with? There doesn't seem to be
> separate/specific handling of it anywhere in the kernel that I can
> see...
> 

It seems that if user set pollfd with POLLRDNORM, perf_poll will not 
return until timeout even if perf_output_wakeup called, whereas POLLIN 
returns.

> Thanks,
> 
> 	Ingo


-- 
Best Regards
Tao Chen

