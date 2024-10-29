Return-Path: <linux-kernel+bounces-387307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65E9B4F45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BD71C20D18
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D161990CD;
	Tue, 29 Oct 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dMIM15a4"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B02107
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219199; cv=none; b=FrydU9wQ3wQSd/TEXaSXOBBUh3YDb9dYpOJscUybQTXaEE36yVoFiy7d999JWmnTV2PsP20MgKiyi4u/WGxv7xMt6Nl9giosbqLWxu0lHs7b6S+XEnv+wDjZebcacoI09Hn2EU9SSxP2BpvYgkiu23073rOhhEKfW/oYXhAlzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219199; c=relaxed/simple;
	bh=SjbABfLBo4hzIup6rCmtJhqjVs3h1hKpoTPhMIQWOuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3yTiQdzLWom6D2dNbv6/4JUwuT6vEQihaIDHopzZ1ESaVTsa7SMhZ3zsSgtgdg+OqrqYQqCGd2nBv+EKbO5nv5H3gNZGVI/Ln+fjHLdTHyo8vNkLcsgf0XKaz2rLKaCz7RfVtEKx1qPTQcgbyb4sQTSxtthdPcIZT5GIlOHKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dMIM15a4; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4cce154a-1115-4371-a9f2-8bdb4879ea16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730219194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3SIO11gAxzBORUAwmF5PxUYgrfzJbpOJQSZlkW2Wfg=;
	b=dMIM15a4oH0M/peynmJ4cMC0vmvM4fsyNmowbgFZpCH+xQokc19h2vEPK/GB6Im5ZZvAH/
	JC/YMO4FH9AU7xo3EUyZmWaRJMqPuMLFrgEPlhRTtTb6pNamM8UbdyG3Q3NMz1a30XY/OP
	Pn3NpHRfWeToJdml1Dl8J6og/gmGgNI=
Date: Wed, 30 Oct 2024 00:26:17 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/23 03:12, Joel Granados wrote:
> On Thu, Sep 05, 2024 at 09:48:18PM +0800, Wen Yang wrote:
>> The do_proc_dointvec_minmax_conv_param structure provides the minimum and
>> maximum values for doing range checking for the proc_dointvec_minmax()
>> handler, while the do_proc_douintvec_minmax_conv_param structure also
>> provides these min/max values for doing range checking for the
>> proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.
> Finally got around to reviewing this. Sorry for the wait. Thx for the
> patch but I don't like how this looks in terms of Integer promotion in
> 32b architectures.
> 
Yes, thank you for pointing it out.
We will explain it later.

>>
>> To avoid duplicate code, a new proc_minmax_conv_param structure has been
> I'm not seeing duplicate code here as one is handling the int case and
> the other is handling the uint case. And it is making sure that all
> assignments and comparisons are without any Integer Promotion issues.
> I'm not saying that it cannot be done, but it has to address Integer
> Promotion issues in 32b architectures.
> 
>> introduced to replace both do_proc_dointvec_minmax_conv_param and
>> do_proc_douintvec_minmax_conv_param mentioned above.
>>
>> This also prepares for the removal of sysctl_vals and sysctl_long_vals.
> If I'm not mistaken this is another patchset that you sent separetly. Is
> it "sysctl: encode the min/max values directly in the table entry"?
> 

Yes.

> ...
> 
>> @@ -904,8 +890,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>>   		return ret;
>>   
>>   	if (write) {
>> -		if ((param->min && *param->min > tmp) ||
>> -		    (param->max && *param->max < tmp))
>> +		if ((param->min > tmp) || (param->max < tmp))
>>   			return -ERANGE;
>>   
>>   		WRITE_ONCE(*valp, tmp);
>> @@ -936,10 +921,10 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>>   int proc_douintvec_minmax(const struct ctl_table *table, int write,
>>   			  void *buffer, size_t *lenp, loff_t *ppos)
>>   {
>> -	struct do_proc_douintvec_minmax_conv_param param = {
>> -		.min = (unsigned int *) table->extra1,
>> -		.max = (unsigned int *) table->extra2,
>> -	};
>> +	struct proc_minmax_conv_param param;
>> +
>> +	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
>> +	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
> This is one of the cases where there is potential issues. Here, if the
>  value of table->extra{1,2}'s value is greater than when
> the maximum value of a signed long, then the value assigned would be
> incorrect. Note that the problem does not go away if you remove the
> "unsigned" qualifier; it remains if table->extra{1,2} are originally
> unsigned.
> 

I set up a CentOS 7.9 32-bit VM on Virtuanbox:
# uname  -a
Linux osboxes.org 3.10.0-1160.2.2.el7.centos.plus.i686 #1 SMP Mon Oct 26 
11:56:29 UTC 2020 i686 i686 i386 GNU/Linux

And the following test code:

#include <stdio.h>
#include <stdlib.h>

int main()
{
	unsigned int i = 4294967294;
	long j = i;

	printf("original hex(i) = 0x%x\n", i);
	printf("unsigned int(i) = %lu\n", i);
	printf("---------------------\n");
	printf("hex(j) = 0x%x\n", j);
	printf("long(j) = %ld\n", j);
	printf("unsigned long(j) = %lu\n", j);
	printf("int(j) = %d\n", j);
	printf("unsigned int(j) = %lu\n", j);
	return 0;
}


./a.out

original hex(i) = 0xfffffffe
unsigned int(i) = 4294967294
---------------------
hex(j) = 0xfffffffe
long(j) = -2
unsigned long(j) = 4294967294
int(j) = -2
unsigned int(j) = 4294967294


The original hexadecimal values are the same, using unsigned int, int, 
unsigned long, or long is just interpreted in different ways.

We also ensure consistency in numerical writing and type conversion in 
the patch. For example, in proc_rointvec_jiffies, convert to int; And in 
proc_rouintvec_minmax, it is converted to unsigned int.


--
Best wishes,
Wen


> I'm not sure if there are more, but just having one of these things
> around make me uncomfortable. Please re-work the patch in order to
> remove this issue in order to continue review.
> 
> best
> 

