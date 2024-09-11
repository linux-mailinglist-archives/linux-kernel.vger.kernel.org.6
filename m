Return-Path: <linux-kernel+bounces-325581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D533C975BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68525284AED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEC61BB686;
	Wed, 11 Sep 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KzKL9rCT"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9D7E583
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086313; cv=none; b=pMNLy9QQ0/3KkTM5Ki6M8KplorUoHrAiyhcKfU+u/02IBYZzOy30ONdjujOpISV6svMAROx+JUpDd0cP+Yy6OJg+F9v9OuLIdtXXK5Gv312FmovoAHMHVCDctJSLW8JvOYV6cWsiarmlqMsOWukIoH5Go3XQc0Q0KmTc75M+Sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086313; c=relaxed/simple;
	bh=6Ztf6Fut+s9uSBjgknsUU0bf1ZYuD8QOdC29weh7W4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE5bcjmaCNAmRCkyt3xisEraZxeRo4Jyte+V48SDJ3NPTBaTUW2STBIH3arq+nKuQW2jz9hKtbGqfkhERVQiklIvyzj0+8ChMzD9TGUpveRmJ5KWGpT/Wb21X2ZudoraYOym1nLphT6hLvjPal/G5XVtDT7jhvx+Dox8O22ELrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KzKL9rCT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9319520B9A86;
	Wed, 11 Sep 2024 13:25:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9319520B9A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726086311;
	bh=f0TJcqeGrAcLFya+4l6Tf52TB2rq9aI8YvI+7Uiv5UM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KzKL9rCTmfmH/rue5GDVdfUp7U01fFnU5sBIwWezppr4D9+INZzpk+vHUEiQw//+y
	 XCN4tT5XBMGYYz/HZhYZMADp0Xe11v55H6cwBc4aDFRFSKdD36BdpLEkdqN2ghVtVq
	 PN1KdJonVJvq2Xjx0UheDq+m2oarup0KzmYFru8U=
Message-ID: <041120ef-aa82-46f9-9a0e-3dc7e00ccc01@linux.microsoft.com>
Date: Wed, 11 Sep 2024 13:25:12 -0700
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
Cc: akpm@linux-foundation.org, apais@microsoft.com, benhill@microsoft.com,
 ebiederm@xmission.com, linux-kernel@vger.kernel.org, ssengar@microsoft.com,
 sunilmut@microsoft.com, torvalds@linux-foundation.org, vdso@hexbites.dev,
 workingjubilee@gmail.com
References: <20240911144412.GA16954@redhat.com>
 <20240911174107.1217693-1-romank@linux.microsoft.com>
 <20240911195311.GA16757@redhat.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240911195311.GA16757@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/2024 12:53 PM, Oleg Nesterov wrote:
> Roman,
> 
> I can only repeat that we can't understand each other. Quite possibly my bad.
> 

Oleg,

I'll re-read the whole thread to see where I can improve.
Didn't mean to cause the undue burden for you. My apologies, will make a
note to myself to be crisper and more concise at the very least.

> On 09/11, Roman Kisel wrote:
>>
>> On 09/11, Oleg Nesterov wrote:
>>
>>> On 09/10, Roman Kisel wrote:
>>>>
>>>> On 09/09, Oleg wrote:
>>>>
>>>
>>>>> Yet another thing in this discussion I can't understand... sorry, I tried.
>>>>> You do not need to teach, say, gdb to recognize this pattern. You can just do
>>>>>
>>>>> 	$ gdb -ex 'b please_insert_the_breakpoint_here' ...
>>>>>
>>>>> Nevermind, as I have already said you can safely ignore me. I still do not
>>>>> see any "real" use-case for breakpoint_if_debugging(), but I guess that is
>>>>> due to my ignorance and lack of imagination.
>>>>
>>>> I've started this so let me butt in and take up the gaunlet.
>>>>
>>>> Lambda's would be the most prominent example to me[1]. The toolchain
>>>> doesn't give them the user-accesible type and the name as it does for
>>>> the functions.
>>>
>>> And?
>>
>> You wanted an example of '"real" use-case for breakpoint_if_debugging()':
> 
> Then why does your email explain that c++ lambdas don't have a good name?
> Why doesi it mention lambdas at all?
> 

I was making the point that setting a breakpoint on the lambda is quite
laborious, and instead one can put "breakpoint_if_debugging()" inside
of it.

>>>>> Nevermind, as I have already said you can safely ignore me. I still do not
>>>>> see any "real" use-case for breakpoint_if_debugging(), but I guess that is
>>>>> due to my ignorance and lack of imagination.
>>
>> I have provided them, and illustrated how it is tiresome to set the breakpoint
>> in the debugger in these cases so can add a call to breakpoint_if_debugging()
>> to these places instead.
> 
> Instead of what??? Instead of
> 
> 	#define breakpoint_if_debugging()	\
> 		asm volatile ("call please_insert_the_breakpoint_here" : ASM_CALL_CONSTRAINT);
> 
> plus -ex 'b please_insert_the_breakpoint_here'???
> 
> If you say that this is ugly I won't even argue. But instead of what?
> 
> Roman, I am leaving this thread, sorry. But let me try to summarize.
> Your patch was buggy and you seem to agree. Feel free to send V2 and I will
> be happy to review it correctness-wise. But:
> 
> 	- please keep Eric/Linus cc'ed
> 
> 	- please try to make your changelog more convincing. And in particular,
> 	  please explain why !!current->ptrace is not enough and this feature
> 	  needs the tracer's pid.
> 
> 	  If possible, please provide a clear/simple/artificial/whatever example
> 	  of the (pseudo)code which can justify this feature.

Oleg,

I owe you a great deal of gratitude for giving my arguments a chance! I
won't reply more to this thread, too. Will use the relevant points
from the list you kindly provided where that applies when posting
to LKML in the future.

> Oleg.

-- 
Thank you,
Roman


