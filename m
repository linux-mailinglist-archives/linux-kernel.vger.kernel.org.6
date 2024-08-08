Return-Path: <linux-kernel+bounces-279052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942594B84B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9974EB25C70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4C188CC8;
	Thu,  8 Aug 2024 07:54:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A5187848
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103670; cv=none; b=Np1WjyzwvmP2O0MqeNeALuNi+zIbL8m0eQl8xN7hwYbU99S0Nn9kKhjdL2wduPm7K9+Tw0v2A3bEL2q39a4CNnYKU+sq+FoTfhx9fQ6F8EY3CN2wgKcR08aCXmWYyzQzHVi0aZXXtoUauAkLIkzXYSGNQk6+16C0pxV7+XvQ22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103670; c=relaxed/simple;
	bh=ITZtZD71fc4nlAKzrj0YXe7LMi+VRbBWPaNNR1MgRVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4aSKtqDrUbQ/UVxaUbr7wLJYeqPjs3jQoEIoyMfYNVuQFw9yDMVQBzyKpOVAvsT+3gtzgV56ebatXUSwEvPNd2zmnbEr4adoSN2etqDeSAvPfOGQwzzfNNxSP7VJnV/gqwlKJzW7HNO9W5V3a+7klPee3q8oA5vrKQSKUl35Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FE9FEC;
	Thu,  8 Aug 2024 00:54:53 -0700 (PDT)
Received: from [10.1.36.15] (PF4Q20KV.arm.com [10.1.36.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03A93F71E;
	Thu,  8 Aug 2024 00:54:24 -0700 (PDT)
Message-ID: <52439ce5-6946-4369-891b-f1c3272234a3@arm.com>
Date: Thu, 8 Aug 2024 08:54:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, scclevenger@os.amperecomputing.com,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/6/2024 5:14 PM, James Clark wrote:

[...]

>>> Although one change we should make to the script is change the example
>>> to use kcore. We can leave in one vmlinux one as an example if kcore
>>> isn't available, but add a note that it will fail if any patched code is
>>> traced (which is almost always).
>>
>> James, you may recall the year old thread
>> https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2Fed8cea4c-a261-60ca-f4e1-333ec73cca8f%40os.amperecomputing.com&data=05%7C02%7Cleo.yan%40arm.com%7C263b6739000948cc6b1308dcb632df73%7Cf34e597957d94aaaad4db122a662184d%7C0%7C0%7C638585576843676468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=kYXL6KuIv3n1UwA%2BxmEbm6V2E0g2fOtt7Iv%2B%2BMb%2B%2FQ0%3D&reserved=0.
>> I described there an awkward workaround Ampere has used to solve the
>> patched code problem. At the time, it sounded like the maintainers were
>> interested in getting away from using the python script, mostly for
>> speed purposes. I didn't see the discussion go any further.
>>
> 
> Oh yes thanks for the reminder. I wasn't thinking about the source code
> lines and debug symbols in this thread. I suppose your merging of kcore
> and vmlinux gives both the correct image and the symbols, but I was only
> focused on the image being correct, so only kcore was enough.
> 
> It looks like everything we want to do from your previous thread is in
> addition to the fixes from this one. Even if we auto merge kcore +
> symbols and move the disassembly into Perf, we still want to detect
> decode issues earlier and not have IPs jumping backwards. Whether it's
> the script or Perf doing that the behavior should be the same.
> 
> To summarise I think these are the changes to make:
> 
>   * Improve bad decode detection in OpenCSD
>   * Get the script to auto merge kcore and vmlinux
>     * Maybe we could get Perf to do this if both a kcore folder and -k
>       vmlinux are used?

We need firstly make clear what's the purpose for using kcore and vmlinux.
The kcore contains the latest instructions, so it is used for disassembly.
The vmlinux contains the debug info for locating source file and lines.

If so, this is a common issue for perf, it might not necessary to merge
two files. Alternatively, we need to check how the perf to use kcore
and vmlinux at the same time.

Thanks,
Leo 

>   * Improve the performance, either in the script or move more
>     functionality into Perf

