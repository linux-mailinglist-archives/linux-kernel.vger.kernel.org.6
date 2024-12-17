Return-Path: <linux-kernel+bounces-449839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31F9F56C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBFC1887CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4301F8EFB;
	Tue, 17 Dec 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fQl68Xfh"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D8158DD1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734463286; cv=none; b=RkeRopclvoqqgaFj45Bmq5+u2pA9DWIfunGTj6O9Va5C1dowATbYinQ2vKL6inuNu4ljahQfZ7CosW3l0VQZyznuU36AU1NRfP7J6umEKgWZ8qIxpg8aB0dJkqs3U2YHX2qTB08YZ2Xop8a0mnX/2eRjrOj5Ifdtovi2NuRz1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734463286; c=relaxed/simple;
	bh=6CcAdp1nx2e9nwSc/U1XwGQ3BuIbA8jywZwwffAEepk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ/Lq2U+i31zRjoUmbxpnCOPoqmxpTc7wmwSorYJi1bNLpZDpzzNYOLt5I89ycDC8/dLuw+dJ5V/OcbAeWlWfCzzqBRvMvYLKGVdLtuxn6RimAJtBgtf6B52opcpsHXT6v3chufYXz1rlWVWN7flOic/MMF9HIhMiRGSAuWnfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=fQl68Xfh; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id NE1Tt1d2TqvuoNd6jt0bWl; Tue, 17 Dec 2024 19:19:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Nd6itVXPgMUWvNd6it6OZo; Tue, 17 Dec 2024 19:19:48 +0000
X-Authority-Analysis: v=2.4 cv=MZhquY/f c=1 sm=1 tr=0 ts=6761ced4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=NEAV23lmAAAA:8
 a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8 a=2CB4x1Pav4WkPD-IWn4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/Y0s190Bl4HZOk0MwudyEtYbB/9iLZ8grBg4MhBp2c=; b=fQl68Xfh6HjkK5Bsa5hkzcRDgc
	J3ceafYqGZG9TgS5H+h+lRWt/vl1QtBaABv+Wa1TUNa+Yc9wAh1ueZ41Npd6O2rPHGHPwZQ9tIlTq
	X+l85RTcvbajgdk1+mG1nFqpOZ2+uzLfR8HCPVYpnOZOeDuleiEVafe3f+IhG5adI0+hbLYusj8EB
	QZbtvYmkWTA2ksb5QILJspFYb+jt4GY9hGHVtg0s0f7N5wQzXXwKvMiPNVmAXv2nMQwtMvJvX1IGY
	xT5pKxIWHf/nFOoFEZlynLww0ggTZyzRQZl/nj+yqjNQx6LHzaRHBWbf8Kz14JpG0uvEPnx4gTLTo
	+v2thwFQ==;
Received: from [177.238.21.80] (port=30054 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tNd6h-002XhM-1O;
	Tue, 17 Dec 2024 13:19:47 -0600
Message-ID: <a077e758-44cd-476e-8377-5f6f80923494@embeddedor.com>
Date: Tue, 17 Dec 2024 13:19:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: Christopher Ferris <cferris@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
 <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
 <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
 <b9a20b9e-c871-451d-8b16-0704eec27329@intel.com>
 <49add42f-42d9-4f34-b4ad-cff31e473f40@embeddedor.com>
 <CANtHk4nhH9XJi5+9BAu3kFoL14+4YAZTH7t6QApEvEAeMxdXgw@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CANtHk4nhH9XJi5+9BAu3kFoL14+4YAZTH7t6QApEvEAeMxdXgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tNd6h-002XhM-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:30054
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN62wn1wVEhkYq++l4WjQXjN7gQPzje/aHkIKVf93JKN0U8sO/g121FKCSou/pp4fMN9wwd/ohwcpfvAmfC30X3eFJh7YBQjn05XhUySqh82Wm0I4O9w
 y78WGiDSIAzxKkN651SO8Sm/B25KqBc5BZdgWsNuOGHIumm+HaY7aIv5I/qCl/6TdEYG9VZi1O723KrPNg1cndIx2yBkaJeCIS4As3r9H3i6giU9kmFGCIGW



On 17/12/24 13:10, Christopher Ferris wrote:
> I verified that this does fix the compilation problem on Android. Thanks
> for working on this.

Awesome! :)

Thanks for confirming.

-Gustavo

> 
> Christopher
> 
> On Tue, Dec 17, 2024 at 10:31 AM Gustavo A. R. Silva <gustavo@embeddedor.com>
> wrote:
> 
>>
>>
>> On 17/12/24 10:54, Alexander Lobakin wrote:
>>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> Date: Tue, 17 Dec 2024 10:25:29 -0600
>>>
>>>>
>>>>
>>>> On 17/12/24 10:04, Alexander Lobakin wrote:
>>>>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>> Date: Tue, 17 Dec 2024 09:58:28 -0600
>>>>>
>>>>>>
>>>>>>
>>>>>> On 17/12/24 08:55, Alexander Lobakin wrote:
>>>>>>> From: Kees Cook <kees@kernel.org>
>>>>>>> Date: Mon, 16 Dec 2024 18:59:55 -0800
>>>>>>>
>>>>>>>> This switches to using a manually constructed form of struct tagging
>>>>>>>> to avoid issues with C++ being unable to parse tagged structs within
>>>>>>>> anonymous unions, even under 'extern "C"':
>>>>>>>>
>>>>>>>>       ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct
>>>>>>>> tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous
>>>>>>>> union may only have public non-static data members [-fpermissive]
>>>>>>>
>>>>>>> I worked around that like this in the past: [0]
>>>>>>> As I'm not sure it would be fine to fix every such occurrence
>> manually
>>>>>>> by open-coding.
>>>>>>> What do you think?
>>>>>>
>>>>>> The thing is that, in this particular case, we need a struct tag to
>>>>>> change
>>>>>> the type of an object in another struct. See:
>>>>>
>>>>> But the fix I mentioned still allows you to specify a tag in C code...
>>>>> cxgb4 is for sure not C++.
>>>>
>>>>
>>>> Oh yes, I see what you mean. If it works, then you should probably
>>>> submit that
>>>> patch upstream. :)
>>>
>>> I added it to my CI tree and will wait for a report (24-36 hrs) before
>>> sending. In the meantime, feel free to test whether it solves your issue
>>> and give a Tested-by (or an error report :)).
>>
>> Hopefully, Christopher can confirm whether this[0] resolves the issue he's
>> seeing.
>>
>>>
>>> BTW, I mentioned in the commit message back in 2022 that some C++
>>> standards support tagged structs with anonymous unions (I don't remember
>>> that already). Would it make sense to use a separate #define not for the
>>> whole __cplusplus, but only for certain standards?
>>
>> I'd say entirely preventing C++ from seeing the tag is cleaner and safer
>> for
>> now.
>>
>> Thanks
>> -Gustavo
>>
>> [0]
>> https://github.com/alobakin/linux/commit/2a065c7bae821f5fa85fff6f97fbbd460f4aa0f3
>>
> 


