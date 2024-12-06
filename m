Return-Path: <linux-kernel+bounces-434876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7449E6C42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B05C18837CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FF1FC7E5;
	Fri,  6 Dec 2024 10:26:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAA1FCD02
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480783; cv=none; b=XLGUnV1KjFN3ig3wKKad3m6FB4rzbOHt5oLn2gIMr8WYtDsLH97mi9oVGc7TLoHnPhhiMQ8b0zcX8YxAvOLBxIWPMnNj6XcZBPeq881VEqUhcZs+qmLiYP3JJUS7RtYMWRhLWX7aadVugOL2D5XdxCJvV1e2ks1Eb8NTGQXHPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480783; c=relaxed/simple;
	bh=0HMnkTmnS0rb2WpcrG/kQAJJWv4D6/D+2+FAg19qHp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXg0kT28YjzyIkuSWTj3RnQCQx+MbIHiLclHFfLT5mSvyJRLV/38XTgF3QcgEzojC2p1GjSbP4VbkBOjl1aWz8EBAhd4T/wqQ5hjZ/BPyvu76yc5Vy/XT7l7L8whVbSpST1a1v2bTaiugUfbFaL3lpjJBPnIXPrk9MnD/NVmWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9600112FC;
	Fri,  6 Dec 2024 02:26:49 -0800 (PST)
Received: from [10.57.90.201] (unknown [10.57.90.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0063F71E;
	Fri,  6 Dec 2024 02:26:18 -0800 (PST)
Message-ID: <bd4a30ca-6725-4c78-94ba-03581700bdcc@arm.com>
Date: Fri, 6 Dec 2024 10:26:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Petr Tesarik <ptesarik@suse.com>, Michael Kelley <mhklinux@outlook.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241017142752.17f2c816@mordecai.tesarici.cz>
 <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
 <20241205182008.2b36476a@mordecai.tesarici.cz>
 <SN6PR02MB41571E0BD384C44C46127B49D4302@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20241206085026.32c89a03@mordecai.tesarici.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241206085026.32c89a03@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/12/2024 07:50, Petr Tesarik wrote:
> On Thu, 5 Dec 2024 18:52:35 +0000
> Michael Kelley <mhklinux@outlook.com> wrote:
> 
>> From: Petr Tesarik <ptesarik@suse.com> Sent: Thursday, December 5, 2024 9:20 AM
>>>
>>> Hi Ryan,
>>>
>>> On Thu, 17 Oct 2024 13:32:43 +0100
>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>   
>>>> On 17/10/2024 13:27, Petr Tesarik wrote:  
>>>>> On Mon, 14 Oct 2024 11:55:11 +0100
>>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>  
>>>>>> [...]
>>>>>> The series is arranged as follows:
>>>>>>
>>>>>>   - patch 1:	   Add macros required for converting non-arch code to support
>>>>>>   		   boot-time page size selection
>>>>>>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>>>>>>   		   non-arch code  
>>>>>
>>>>> I have just tried to recompile the openSUSE kernel with these patches
>>>>> applied, and I'm running into this:
>>>>>
>>>>>   CC      arch/arm64/hyperv/hv_core.o
>>>>> In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
>>>>> ../include/linux/hyperv.h:158:5: error: variably modified ‘reserved2’ at file scope
>>>>>   u8 reserved2[PAGE_SIZE - 68];
>>>>>      ^~~~~~~~~
>>>>>
>>>>> It looks like one more place which needs a patch, right?  
>>>>
>>>> As mentioned in the cover letter, so far I've only converted enough to get the
>>>> defconfig *image* building (i.e. no modules). If you are compiling a different
>>>> config or compiling the modules for defconfig, you will likely run into these
>>>> types of issues.
>>>>
>>>> That said, I do have some patches to fix Hyper-V, which Michael Kelley was kind
>>>> enough to send me.
>>>>
>>>> I understand that Suse might be able to help with wider performance testing - if
>>>> that's the reason you are trying to compile, you could send me your config and
>>>> I'll start working on fixing up other drivers?  
>>>
>>> This project was de-prioritised for some time, but I have just returned
>>> to it, and one of our test systems uses a Mellanox 5 NIC, which did not build.

No problem - I appreciate all the time you have spent on it so far!

>>>
>>> If you still have time to work on your patch series, please, can you
>>> look into enabling MLX5_CORE_EN?

I've also had other things that have been taking up my time. I'm planning to get
back to this series properly after Christmas and convert all the remaining
module code. I'm hoping that Michael's patch will solve your problem for now?

>>>
>>> Oh, and have you rebased the series to 6.12 yet?

Afraid the latest I have at the moment is based on v6.12-rc3. It also includes
all the changes from the review feedback:

https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/boot-time-page-size-v2-wip

>>>   
>>
>> FWIW, here's what I hacked together to compile and run the mlx5 driver in
>> a Hyper-V VM.  This was against a 6.11 kernel code base.
> 
> Wow! Thank you, Michael. I'll give it a try.

Yes, thanks, Michael - I'll take a look at this and integrate into my tree after
Christmas.

Thanks,
Ryan

> 
> Petr T


