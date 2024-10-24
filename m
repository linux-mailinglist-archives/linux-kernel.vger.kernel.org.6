Return-Path: <linux-kernel+bounces-379721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A99AE2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2753B2209F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83451C0DE2;
	Thu, 24 Oct 2024 10:34:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F11C1753
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766069; cv=none; b=OqNWpBU1fAMDhGLE9PZzwymOPw4ok9vX+sd7blABKz1e1o39paABqhx0dyTCuPaPFz9UFmQYP7En5GR6YFgkCyaqeCguGfOo+7GwObtQO1qFrPb4vdd92ANLIi2CEx9LvKRIIhGs9UIzPsBqF0XBBkgaah94hycdBZiUdz6mUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766069; c=relaxed/simple;
	bh=wnuHN52HqTziMgk5laSF7P1kHtltZdBjaJsRhXEmqWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bc5kJThvL42gcoMCISbvG3iTrDDRV/xtv6I7DnMeEFVULjA236yanW6zjpDZoOsDI8tL7wKc/9Gl3knTbFkFQDrcrj+gjzZR3SyuhjAFfwaeS2U4a3QtyQgZicOA1BJWZjY8d0DT4anMIXFG7zqt7n/c2IMwcROju9E/x4giR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3905497;
	Thu, 24 Oct 2024 03:34:52 -0700 (PDT)
Received: from [10.57.88.37] (unknown [10.57.88.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7373F7C5;
	Thu, 24 Oct 2024 03:34:20 -0700 (PDT)
Message-ID: <aef00d9d-0b1d-43f9-90d5-ee1b524ff8c8@arm.com>
Date: Thu, 24 Oct 2024 11:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Neal Gompa <neal@gompa.dev>
Cc: Nick Chan <towinchenmi@gmail.com>, Eric Curtin <ecurtin@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, asahi@lists.linux.dev
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <4623805.lGaqSPkdTl@skuld-framework>
 <09e480d7-3ef6-4352-a484-91733ad7d231@arm.com>
 <CAOgh=FwEv3LjA7bfcOvWK7kZEcKRyLpQmTqWn5WDsSsYwGqu+A@mail.gmail.com>
 <649d7aa6-4163-4969-ba14-777f0e9cddb1@arm.com>
 <CAEg-Je9phqMqXCVAEjtXKadKGUmZcuSnFLDn=7C4+MaUu9KpYw@mail.gmail.com>
 <872f1c9c-9fb2-4372-810d-abe5419c4bd8@arm.com>
 <CAEg-Je9RpGGmw_pto7seYj_JGNUjSTKtcjLToQ8Mbp2_zrLGoQ@mail.gmail.com>
 <2174ff43-3ab6-409b-a8a8-bd319a134d86@gmail.com>
 <997f1826-ec45-4d47-ad94-33c0d194b5a4@arm.com>
 <CAEg-Je85pnstdRCxocZ3D0sLtZiCPAB+jHKyW+K-H2rFeVwP7Q@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAEg-Je85pnstdRCxocZ3D0sLtZiCPAB+jHKyW+K-H2rFeVwP7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2024 18:30, Neal Gompa wrote:

[...]

>>>>>>>>>>
>>>>>>>>>> This is a generally very exciting patch set! I'm looking forward to seeing it
>>>>>>>>>> land so I can take advantage of it for Fedora ARM and Fedora Asahi Remix.
>>>>>>>>>>
>>>>>>>>>> That said, I have a couple of questions:
>>>>>>>>>>
>>>>>>>>>> * Going forward, how would we handle drivers/modules that require a particular
>>>>>>>>>> page size? For example, the Apple Silicon IOMMU driver code requires the
>>>>>>>>>> kernel to operate in 16k page size mode, and it would need to be disabled in
>>>>>>>>>> other page sizes.
>>>>>>>>>
>>>>>>>>> I think these drivers would want to check PAGE_SIZE at probe time and fail if an
>>>>>>>>> unsupported page size is in use. Do you see any issue with that?
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> * How would we handle an invalid selection at boot?
>>>>>>>>>
>>>>>>>>> What do you mean by invalid here? The current policy validates that the
>>>>>>>>> requested page size is supported by the HW by checking mmfr0. If no page size is
>>>>>>>>> passed on the command line, or the passed value is not supported by the HW, then
>>>>>>>>> the we default to the largest page size supported by the HW (so for Apple
>>>>>>>>> Silicon that would be 16k since the HW doesn't support 64k). Although I think it
>>>>>>>>> may be better to change that policy to use the smallest page size in this case;
>>>>>>>>> 4k is the safer bet for compat and will waste much less memory than 64k.
>>>>>>>>>
>>>>>>>>>> Can we program in a
>>>>>>>>>> fallback when the "wrong" mode is selected for a chip or something similar?
>>>>>>>>>
>>>>>>>>> Do you mean effectively add a machanism to force 16k if the detected HW is Apple
>>>>>>>>> Silicon? The trouble is that we need to select the page size, very early in
>>>>>>>>> boot, before start_kernel() is called, so we really only have generic arch code
>>>>>>>>> and the command line with which to make the decision.
>>>>>>>>
>>>>>>>> Yes... I think a build-time CONFIG for default page size, which can be
>>>>>>>> overridden by a karg makes sense... Even on platforms like Apple
>>>>>>>> Silicon you may want to test very specific things in 4k by overriding
>>>>>>>> with a karg.
>>>>>>>
>>>>>>> Ahh, yes, that would certainly work. I'll work it into the next version.
>>>>>>>
>>>>>>
>>>>>> Could we maybe extend to have some kind of way to include a table of
>>>>>> SoC IDs that certain modes are disabled (e.g. 64k on Apple Silicon)
>>>>>
>>>>> 64k is already disabled on Apple Silicon because mmfr0 reports that 64k is not
>>>>> supported.
>>>>>
>>>>>> and preferred modes when no arg is set (16k for Apple Silicon)? That
>>>>>
>>>>> And it's not obvious that we should hard-code a page size preference to a SoC
>>>>> ID. If the CPU can support multiple page sizes, it should be up to the SW stack
>>>>> to decide, not the SoC.
>>>>>
>>>>> I'm guessing your desire is to have a single kernel build that will boot 16k by
>>>>> default on Apple Silicon and 4k by default on other systems, all without needing
>>>>> to modify the command line? Personally I think it's cleaner to just require
>>>>> setting the page size on the command line in these cases.
>>>>>
>>>>>> way it'd work something like this:
>>>>>>
>>>>>> 1. Table identification of 4/16/64 depending on identified SoC
>>>>> So I'd prefer not to have this
>>>>>
>>>>>> 2. Unidentified ones follow build-time default
>>>>>> 3. karg forces a mode regardless
>>>>> But keep these 2.
>>>>>
>>>>
>>> Since we are talking about Apple Silicon and page size, I would like to
>>> add that on the Apple Silicon SoCs I am working on, the situation is like
>>> this:
>>>
>>> Apple A7 (s5l8960x), A8 (T7000), A8X (T7001): CPU MMU support 4K and 64K
>>> page sizes.
>>>
>>> Apple A9 (s8000/s8003), A9X (s8001), A10 (t8010), A10X (t8011), A11 (t8015):
>>> CPU MMU Support 16K and 64K page sizes.
>>>
>>> However, all of them have 4K page DART IOMMUs.
>>>
>>>> I think it makes sense to have it, because it's not just Apple Silicon
>>>> where such a preference/requirement may be necessary. Apple Silicon
>>>> technically works at 4k, but is completely broken at 4k because Linux
>>>> cannot do 16k IOMMU with 4k everything else, so being able to at least
>>>> prefer 16k out of the box is important. And SoCs like the NVIDIA Grace
>>>> Hopper platform prefer 64k over other options (though I am unaware of
>>>> a gross incompatibility that effectively requires it like Apple
>>>> Silicon has).
>>>>
>>>> When we're trying to get to "single generic image that works
>>>> everywhere", stuff like this matters and I would really like you to
>>>> consider it from the lens of "we want things to work as automagic as
>>>> they do on x86".
>>> For me, in order to get to this level of automagic, there do need to be
>>> a table of which SoC should use which page size table.
>>
>> OK, but it's not clear to me that this table needs to be in the kernel. Could it
>> not be something in user space (e.g. during installation) that configures the
>> kernel command line?
>>
> 
> This is not compatible with using things like ISOs with UEFI+ACPI
> enabled desktop/server systems. We need to be able to safely,
> automatically, and correctly boot up and support hardware. The only
> place to do that early enough is in the kernel. But this can wait
> until the core stuff is in.

OK got it.

> 
>> Regardless, the hard work here is getting the boot-time page size selection
>> mechanism in place. Once that's there, follow up patches can add the desired
>> policy. I'd rather leave it out for now to avoid anything slowing down the core
>> work.
>>
> 
> Sure, this can be done afterward.

Thanks! I understand the problem a bit better now. I'm sure we can find a
solution once we have landed the core mechanism.

Thanks,
Ryan



