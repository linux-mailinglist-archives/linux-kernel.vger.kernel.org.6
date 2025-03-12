Return-Path: <linux-kernel+bounces-557935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D3A5DF83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5429F170C59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94724BC07;
	Wed, 12 Mar 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pi2BwBdS"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012C248874
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791294; cv=none; b=sG+tBV1/1DM9wwD2HT2KjqHPF83nKryU5Q9Mq/ovOcNV4Ts21dFjKcHK8ACHsbU4NgWUtWHY1kFeNaOlDucq9UP4H+y6eLnu1sadWWoGnYezhEk0fytHAMmm2CJ7oZ0nXAz7rOVLUDhN6cjGgLwt8B+F3W01c6E2RqU2zvNFuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791294; c=relaxed/simple;
	bh=Av4UqIzjXlTODRswKg47iqNd5/ryiT/X6stv/NBmE2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHju2RdXEZu67FUlM6XpAZuEX7g4sW+ejRbB3oO0PWUXDfRajwWUgzi1nTdnIXn10Rqg7b2Gz6pzMj1WSwh7pt7oW5DnJRvBWwS07Yi5RusS/28bwEq1kAv7sjDsz8h15IdRMW65SGM8LBV6IzP4O0MGw1wes/KIRg4MFMt/Yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pi2BwBdS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7bb4c95-28ff-4a84-8027-f8bce25b0a30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741791289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0AGjYTULko4lI8filPga5Si/Ncs5FPx8HIlhtYJdPA=;
	b=Pi2BwBdSqOkN3GgnNBZDNcCpn4C3uJxyxejTmVDJq/Df8nHOeO304BhT/kky/24AhidSIy
	5tKtN2pEwQJw0rGlt8lUtb37ZiR54181Hwv5Xtycu/PuJp1X8ZPjzc2IHSRLetZUYiEmno
	oj2fRbr+QJ84nIQNT1FRiom7z70SQW4=
Date: Wed, 12 Mar 2025 22:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
To: Joel Granados <joel.granados@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org
References: <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
 <e861fc51-f244-4645-af72-56416a422060@linux.dev>
 <qpuf3nepmmkiqt7spcdpyrdnbyzbztr3jgabwou7bjyl746czs@c2iimb3bekr4>
 <806ee13d-cb97-4c27-b645-763c02b51713@linux.dev>
 <csfegppvkhnl33x37335dsxdxmlzn7jairgsucxl5rdo3d6yzi@2z3nfgtcy7eg>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <csfegppvkhnl33x37335dsxdxmlzn7jairgsucxl5rdo3d6yzi@2z3nfgtcy7eg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/3/10 22:25, Joel Granados wrote:
> On Thu, Mar 06, 2025 at 09:33:39PM +0800, Wen Yang wrote:
>>
>>
>> On 2025/3/3 17:26, Joel Granados wrote:
>>> On Thu, Jan 30, 2025 at 10:32:14PM +0800, Wen Yang wrote:
>>>>
>>>>
>>>> On 2025/1/28 01:51, Eric W. Biederman wrote:
>>>>> Joel Granados <joel.granados@kernel.org> writes:
>>>>>
>>>>>> On Thu, Jan 23, 2025 at 12:30:25PM -0600, Eric W. Biederman wrote:
>>>>>>> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>>>>>>>
>>>>>>>> Joel Granados <joel.granados@kernel.org> writes:
>>>>>>>>
>>>>>>>>> On Sun, Jan 19, 2025 at 10:59:21PM +0800, Wen Yang wrote:
>>> ...
> ...
>>> Quick question: Do you have a systemic way of identifying these? Do you
>>> have a grep or awk scripts somewhere? I'm actually very interested in
>>> finding out what is the impact of this.
>>>
>>
>> Thanks, we may use the following simple scripts:
>>
>> - the extra {1,2} as pointers to some objects:
>> $ grep "\.extra1\|\.extra2" * -R | grep -v "SYSCTL_" | grep -v "\&"
> This is actually pretty nice. Thx for that. I executed it a bit
> differently:
> 
> $  git grep "\.extra1\|\.extra2" | grep -v "SYSCTL_" | grep -v "&"
> 
> I also went and did something way more complicated :). I created an
> smatch check [1] and ran it on a allyes config. This gave me all of your
> results except the openat2 selftests. This might be something to
> consider for when this is finished to add a check so that ppl don't just
> add an int or a long to a extra
> 
> Best
> 
> [1]: https://github.com/Joelgranados/smatch/tree/jag/extra_ptr
> 

Thanks.
This is an excellent approach!
We will also learn to apply it in our code.

--
Best wishes,
Wen

> 
>>
>> - the extra {1,2} as pointers to elements in the shared constant array:
>> $ grep "\.extra1\|\.extra2" * -R | grep "SYSCTL_"
>>
>> - the extra {1,2} as pointers to additional constant variables:
>> $ grep "\.extra1\|\.extra2" * -R | grep "\&"
>>
>>
>> --
>> Best wishes,
>> Wen
>>
>>
>>>
>>>
>>>>
>>>>
>>>> So could we modify it in this way to make it compatible with these two
>>>> situations:
>>>>
>>>> @@ -137,8 +137,16 @@ struct ctl_table {
>>>>           umode_t mode;
>>>>           proc_handler *proc_handler;     /* Callback for text formatting */
>>>>           struct ctl_table_poll *poll;
>>>> -       void *extra1;
>>>> -       void *extra2;
>>>> +       union {
>>>> +               struct {
>>>> +                       void *extra1;
>>>> +                       void *extra2;
>>>> +               };
>>>> +               struct {
>>>> +                       unsigned long min;
>>>> +                       unsigned long max;
>>>> +               };
>>>> +       };
>>>>    } __randomize_layout;
>>>>
>>>>
>>>> --
>>>> Best wishes,
>>>> Wen
>>>>
>>>
> 

