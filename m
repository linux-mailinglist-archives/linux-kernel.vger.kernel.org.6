Return-Path: <linux-kernel+bounces-319490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE8B96FD4B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF31C22F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8521586CF;
	Fri,  6 Sep 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sZqUAMe2"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DCB158520
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657950; cv=none; b=QJ+D3UaYZf4FZS3kD8skXs6S7fV7/kbOA0n+q9JC8GBJWrIiZqOC1qfcexJWFCseaMezQ0s2ydcqY2nczEE1fF1nODpXxw7pwe+/UnC6Z/2tSqNDJEVEyt2Ffi55iowQoxI7rFACQE1F+OaBLKl7a5NLDK/jnugmuoW/eAmolrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657950; c=relaxed/simple;
	bh=kVBleOAYpdplNqF4P647DVGr6MgOjIPyIFwxCafWG1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkqRyNXrwyuM21h05UJCPbI40RZFMfmVht/IiyA75xiC3o1UyaOFWB8nv+jKDtGesbQdPrVOtrIWcbNZVJ3FkaPHOUWI9/fIP++ILJ4n46J1802vqCvB4x3eKHlJL6CnUQIESzItTQtLkpyEcB02efmy25IAdAEF0WJ5z0giaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sZqUAMe2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EE4920B7436;
	Fri,  6 Sep 2024 14:25:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EE4920B7436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725657949;
	bh=m070efsv4GXX1DcyIjCX6a/Cjuzt6IboRhe/Dn/rGU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZqUAMe2lAecyF8BRZo8eATdUVaI/ffDASPOKQP2P5J3grvf1AqjfrvcAm6p8yGes
	 CAT0aDZ14FQpDNl8v981bFwS3WjiibrUdI6U36Rz8XlUjToqWMTlzb4CDetbqd5IH1
	 Gn39YhrEU6mLBVQty9/3NRROKq0AIRGSZR0mKLe4=
Message-ID: <7cabfc9f-398a-41c2-898b-296e53a048de@linux.microsoft.com>
Date: Fri, 6 Sep 2024 14:25:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
 <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
 <20240906205436.GA2417@redhat.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240906205436.GA2417@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/6/2024 1:55 PM, Oleg Nesterov wrote:
> Well, I leave this to you and Linus (and other reviewers), but if it was not
> clear I too do not really like this feature, that is why I added cc's.
> 
Appreciate you time and help in understanding the Linux kernel code
better!

> Perhaps it makes sense to discuss the alternatives? Say, a process can have a
> please_insert_the_breakpoint_here() function implemented in asm which just does
> asm(ret).
> 
> Then something like
> 
> 	#define breakpoint_if_debugging()	\
> 		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);
> 
> if the process is ptraced, debugger can insert the breakoint into
> please_insert_the_breakpoint_here(). Otherwise breakpoint_if_debugging()
> is a cheap nop.
> 
> Not that I think this is a good idea, but std::breakpoint_if_debugging()
> looks even more strange to me...
Can't speak for everyone obviously, I've found that convenient
when making sense of large (unknown) codebases instead of setting
up breakpoints and adding prints/logs, and when the process
can't/doesn't fault when it encounters a fatal error.

> 
> Oleg.
> 
> On 09/06, Roman Kisel wrote:
>>
>> All told, let me know if I may proceed with fixing the code as Oleg
>> suggested, or this piece should go into the waste basket. I could make
>> an argument that providing the way to get the tracer PID only via
>> proc FS through parsing text is more like shell/Perl/Python interface
>> to the kernel, and for compiled languages could have what's easier in
>> that setting (there is an easy syscall for getting PID, and there could
>> be code changing the logic on the PID being odd or even for the sake
>> of argument).
>>
>>>
>>>                 Linus
>>
>> -- 
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


