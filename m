Return-Path: <linux-kernel+bounces-255125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DC933C72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E8F1C22141
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15617F4FD;
	Wed, 17 Jul 2024 11:41:39 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4AD17E8FF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216499; cv=none; b=J0ElNwBZKamt/GN3NWjtDDK6kof1bHUqY7TQzfV7Pv37cWcbTmtO8OKCVkbxRHIn43WfeLPOHNrx4pA+GR3qto1un2TsuO7OvLr9TwX/sMxc0Y0cAStngXMVuu8gLCxQSB8bfsiV4CaC6cGfLG8z4FiIHPnRGOsibcKafxTtGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216499; c=relaxed/simple;
	bh=DiauXrfYepIi4O+/hR/SJwBaH9zMgXybpZfpGTMqceM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYMidH+uKpwtgNlGP+158Cu7uMQrqHelmVrMr3VM3K30PQgrtOJp5mHwCei5DsOjVT5Dufu7bv88OCMDGVvEZEM/9fkX089+Jfrd8yP4+LDLQiWBCLENP4+e8Wt0tkPmw+D5COiF+9j+GnESDprzFNGXdh0GO8pwPcBT8rLBlUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C6CA60008;
	Wed, 17 Jul 2024 11:41:23 +0000 (UTC)
Message-ID: <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
Date: Wed, 17 Jul 2024 13:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
 <20240717-synapse-decade-a0d41bd7afce@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240717-synapse-decade-a0d41bd7afce@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 17/07/2024 13:32, Conor Dooley wrote:
> On Wed, Jul 17, 2024 at 01:17:16PM +0200, Alexandre Ghiti wrote:
>> The following build failure happens when using LLVM < 17.0.0:
>>
>> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto statement to one of its possible targets
>>
>> This is a known issue [1] so let's upgrade the minimal requirement for
>> LLVM to the version 17.0.0, which is the first version to contain the
>> fix.
> I think doing this unilaterally is kinda insane, LLVM 17 isn't even a
> year old. Debian testing doesn't have anything later than 16.


Debian will very likely select the qspinlocks when available anyway, so 
they'll need llvm >= 17. And Debian won't ship a kernel >= 6.11 until 
some time right? So they'll probably update their infra to llvm >= 17 
(and they'll probably do to take advantages of the new extensions).


> Why does
> it need to be done unilaterally rather than just when the qspinlock
> stuff is built?


We can do that indeed, it may happen again and we can keep requiring 
llvm 17 on a per-config basis.


>> Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1645979992 [1]
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@intel.com/
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> If Nathan wrote the patch, you need to set him as the author of the
> patch :)


I thought I did, how should I do that then?


>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>
>> This patch was done by Nathan, I'm just sending it as an RFC to get quicker
>> feedbacks.
>>
>> I tested it successfully.
>>
>> Note that the build failure happens on the not-yet merged qspinlock
>> patchset.
>>
>>   scripts/min-tool-version.sh | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
>> index 91c91201212c..e81eb7ed257d 100755
>> --- a/scripts/min-tool-version.sh
>> +++ b/scripts/min-tool-version.sh
>> @@ -28,6 +28,8 @@ llvm)
>>   		echo 15.0.0
>>   	elif [ "$SRCARCH" = loongarch ]; then
>>   		echo 18.0.0
>> +	elif [ "$SRCARCH" = riscv ]; then
>> +		echo 17.0.0
>>   	else
>>   		echo 13.0.1
>>   	fi
>> -- 
>> 2.39.2
>>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

