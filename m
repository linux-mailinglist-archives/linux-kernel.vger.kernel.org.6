Return-Path: <linux-kernel+bounces-398281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94079BEEBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7B1F24B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171C11E04B5;
	Wed,  6 Nov 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bE5fWxLD"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95D1E0DC4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899206; cv=none; b=H2ci2g28Bm13Yg4NIlCqiJuJWSNxdU2013u3jOCuPen6Flmb1LsWI74o1o27jRhiXkMjSGxoMOt5vwPVcHodIhJI6hWhqJqV+5oMDNJgxzEfADYq+mLGZDPz5hWMSwSbHLOwYgAkxpSltQhQkl6+FlBnGYyPHDQFxeiU9mu6Ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899206; c=relaxed/simple;
	bh=7u3+xddR9nCOx+K0a3463G+0XOsP7jGEQ/E62EEf2h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am+4/dezg80smhMPk8leYyv/zb6zCl69Q/hH7mSjbNs5/wDz3Hcj64mGWLwgu/CEzVWE19sTwadsIQ5m0wMgNmd6EKTqwup23ZYD37hGIY2Y3zsZKwdSAVsfjicKatVSiGEd8QVw+gSvERSgNkLmkuPoIJcQx+F1vKeUn25rf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bE5fWxLD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <91311377-4cb5-42a4-82fd-c30de56b1121@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730899202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRkADMAh9bk8p6Aa3FaJt7PlQBPpwLcZDpYTIrjEWi0=;
	b=bE5fWxLDPHZuR0Lw9QqNFEDs4rztNFGruAacnpDnjrtbCBwX1Nti3AaxNXDMWw9ncGYcG+
	N6UpuUUU6nUx6GOy4o2Pbc9Cg5NrnfOyD0yGBgTlksx6/1kx2gEBMrGHI8XdQR/TZpvcZq
	dBIR2lXVsnI93M7+c6TzHylYUi2bveA=
Date: Wed, 6 Nov 2024 21:19:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v3] sysctl: simplify the min/max boundary check
To: Joel Granados <joel.granados@kernel.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>,
 Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240905134818.4104-1-wen.yang@linux.dev>
 <5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz>
 <4cce154a-1115-4371-a9f2-8bdb4879ea16@linux.dev>
 <4rrwkbj5sh4anblrxzhehcir2z2w5qhrdxfu4gc4irfg4ubb7q@hjt3e6agz42i>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <4rrwkbj5sh4anblrxzhehcir2z2w5qhrdxfu4gc4irfg4ubb7q@hjt3e6agz42i>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/31 17:39, Joel Granados wrote:
> On Wed, Oct 30, 2024 at 12:26:17AM +0800, Wen Yang wrote:
>>
>>
>> On 2024/10/23 03:12, Joel Granados wrote:
>>> On Thu, Sep 05, 2024 at 09:48:18PM +0800, Wen Yang wrote:
> ...
> 
>>>> @@ -936,10 +921,10 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>>>>    int proc_douintvec_minmax(const struct ctl_table *table, int write,
>>>>    			  void *buffer, size_t *lenp, loff_t *ppos)
>>>>    {
>>>> -	struct do_proc_douintvec_minmax_conv_param param = {
>>>> -		.min = (unsigned int *) table->extra1,
>>>> -		.max = (unsigned int *) table->extra2,
>>>> -	};
>>>> +	struct proc_minmax_conv_param param;
>>>> +
>>>> +	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
>>>> +	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
>>> This is one of the cases where there is potential issues. Here, if the
>>>   value of table->extra{1,2}'s value is greater than when
>>> the maximum value of a signed long, then the value assigned would be
>>> incorrect. Note that the problem does not go away if you remove the
>>> "unsigned" qualifier; it remains if table->extra{1,2} are originally
>>> unsigned.
>>>
>>
>> I set up a CentOS 7.9 32-bit VM on Virtuanbox:
>> # uname  -a
>> Linux osboxes.org 3.10.0-1160.2.2.el7.centos.plus.i686 #1 SMP Mon Oct 26
>> 11:56:29 UTC 2020 i686 i686 i386 GNU/Linux
>>
>> And the following test code:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> int main()
>> {
>> 	unsigned int i = 4294967294;
>> 	long j = i;
>>
>> 	printf("original hex(i) = 0x%x\n", i);
>> 	printf("unsigned int(i) = %lu\n", i);
>> 	printf("---------------------\n");
>> 	printf("hex(j) = 0x%x\n", j);
>> 	printf("long(j) = %ld\n", j);
>> 	printf("unsigned long(j) = %lu\n", j);
>> 	printf("int(j) = %d\n", j);
>> 	printf("unsigned int(j) = %lu\n", j);
>> 	return 0;
>> }
>>
>>
>> ./a.out
>>
>> original hex(i) = 0xfffffffe
>> unsigned int(i) = 4294967294
>> ---------------------
>> hex(j) = 0xfffffffe
>> long(j) = -2
> This ^^^^^ is exactly what I expected. Thx for the test!
> 
> When you transfer that to your patch, it means that for certain cases
> [1] the value resulting from the interpretation of param.{min,max}
> (signed long) is going to be different than the value resulting from the
> interpretation of table-extra{1,2} (unsigned int).
> 
> Here is another way of thinking about it:
> We are avoiding bugs where a developer thinks they are handling longs,
> when in reality they are handling unsinged ints; The result of
> subtracting 1 from (-2) is very different from subtracting 1 from
> 4294967294.
> 
>> unsigned long(j) = 4294967294
>> int(j) = -2
>> unsigned int(j) = 4294967294
>>
>>
>> The original hexadecimal values are the same, using unsigned int, int,
>> unsigned long, or long is just interpreted in different ways.
> Exactly. Hex remains the same but the interpretation changes. And it is
> there where pain lies.
> 
> Please re-work the patch without merging everything into
> do_proc_douintvec_minmax_conv_param
> 

Thanks.
I will make the modifications according to your suggestions and send v4 
soon.

--
Best wishes,
Wen


