Return-Path: <linux-kernel+bounces-255276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFA933E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0DB211A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02E181308;
	Wed, 17 Jul 2024 14:21:08 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCD2D61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226067; cv=none; b=NQRwC66uoxoqcPwQEZ4DqesyO6MAu6rXhlOYPcPzcSqYsJWLt/ecZkVBmB+xNGLotdj6GkvnOBoBK7KMM+hi5z+5V+AWQj/bWKhaEQAHzmjpwHXbZ1C/BHrrbIYQcb7bg1mKPy/JZSKXIVO2+ceZymTuhFc3nFm8yG1AxLv/mdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226067; c=relaxed/simple;
	bh=EtLmjlZiTNxrB8ZmwQCXdIpqZUxofP8AeXV/qcdd77M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mSbrZh+C0cOthio8Pk8W7a5TfXzE5t4fQ19DRpHKOVv3YCZJQn4sSWh86YAIdneVV4eON5IMcnvCFbp31gWWK/wo7utTCHPp4XgrqE6Wrv7imTLxar7QoglsP2C4sPhBnpRhhhZ+wTrS8qUo7AqLJw3wQwBUZKiBCHRJ90DgagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E88F20003;
	Wed, 17 Jul 2024 14:20:59 +0000 (UTC)
Message-ID: <442ee5ba-8826-4a0c-8205-31b12c7877c8@ghiti.fr>
Date: Wed, 17 Jul 2024 16:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
 <20240717-synapse-decade-a0d41bd7afce@spud>
 <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
In-Reply-To: <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

On 17/07/2024 13:41, Alexandre Ghiti wrote:
> Hi Conor,
>
> On 17/07/2024 13:32, Conor Dooley wrote:
>> On Wed, Jul 17, 2024 at 01:17:16PM +0200, Alexandre Ghiti wrote:
>>> The following build failure happens when using LLVM < 17.0.0:
>>>
>>> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto 
>>> statement to one of its possible targets
>>>
>>> This is a known issue [1] so let's upgrade the minimal requirement for
>>> LLVM to the version 17.0.0, which is the first version to contain the
>>> fix.
>> I think doing this unilaterally is kinda insane, LLVM 17 isn't even a
>> year old. Debian testing doesn't have anything later than 16.
>
>
> Debian will very likely select the qspinlocks when available anyway, 
> so they'll need llvm >= 17. And Debian won't ship a kernel >= 6.11 
> until some time right? So they'll probably update their infra to llvm 
> >= 17 (and they'll probably do to take advantages of the new extensions).
>
>
>> Why does
>> it need to be done unilaterally rather than just when the qspinlock
>> stuff is built?
>
>
> We can do that indeed, it may happen again and we can keep requiring 
> llvm 17 on a per-config basis.
>
>
>>> Link: 
>>> https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1645979992 
>>> [1]
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: 
>>> https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@intel.com/
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> If Nathan wrote the patch, you need to set him as the author of the
>> patch :)
>
>
> I thought I did, how should I do that then?
>
>
>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>
>>> This patch was done by Nathan, I'm just sending it as an RFC to get 
>>> quicker
>>> feedbacks.
>>>
>>> I tested it successfully.
>>>
>>> Note that the build failure happens on the not-yet merged qspinlock
>>> patchset.
>>>
>>>   scripts/min-tool-version.sh | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
>>> index 91c91201212c..e81eb7ed257d 100755
>>> --- a/scripts/min-tool-version.sh
>>> +++ b/scripts/min-tool-version.sh
>>> @@ -28,6 +28,8 @@ llvm)
>>>           echo 15.0.0
>>>       elif [ "$SRCARCH" = loongarch ]; then
>>>           echo 18.0.0
>>> +    elif [ "$SRCARCH" = riscv ]; then
>>> +        echo 17.0.0
>>>       else
>>>           echo 13.0.1
>>>       fi
>>> -- 
>>> 2.39.2
>>>
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


So we discussed that during the patchwork meeting and this patch is not 
wanted, the idea is rather to get rid of the build error.

I was given a few ideas so I'll try those and we'll see what the 
resulting code looks like, hopefully not ugly otherwise I'll re-open the 
discussion :)

Thanks Nathan for the patch,

Alex


