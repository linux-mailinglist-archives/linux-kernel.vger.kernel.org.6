Return-Path: <linux-kernel+bounces-283449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8394F4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD13B2817B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C36186E5E;
	Mon, 12 Aug 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mFBWl7GI"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD115C127
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480556; cv=none; b=Aj22oO7IlGNg589SBsHrcvR9UHbMpAbQvbV1MHKLu4p43LeTIzLLvBTDAI0CyI9edWPE2kZemm0BVKmsBgvBGEAJ8ZDyTf7UAcd+xQ4jo6Nc+WdSracANA4syPGPQO3F6Vw3P0dwYTDjPodBxYT5w1dkjK3sPKh9ML/KOqjWPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480556; c=relaxed/simple;
	bh=HlcZgCIr5xdNeS/eKm8d+zW4DS0BY32FtTrPWQMms60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fygx8Qf2CGr3OAB7C3g2/SW707Myym7+Zgg1UUkTq67mrqykBBFMPNwG66rWubnznTQE1G3CUSfHvaAQKEyU7J0usgBT/C3+sOcsLdHjWhcTjS21m3cX4YZFNDoMOvSBHGUpAHc6YIMekG/idGWTMXylk6Z0l1W6/cHJv4CUU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mFBWl7GI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xNJVQCM+ycvH27G53O8s0UL/fHpVWBgt3pS5rumTY0I=; b=mFBWl7GI4S7d8ju4xV852jskiC
	BhFpCGBIN3kqVvpkVZPnNdTUyEZ48MP/UYoZRe8UBkjdFj4tZQD40cAsXZoSKrINFuuDB7INngYlv
	O3fCakumI9pqF3f9Z0dMMGFWksoMXTbMIigdI0VgaeUS0r1S7kpQ5SSb2J4SDQBN1OJYDdM+UCLrU
	86kVR4DuxXgbXWJMvXFH2de1q3TB6S+0i4tMLD+bLfnnNbRylpApyCwQTEWpYSprqtREhV/zkG9WZ
	SHxxC81dPz2hQLTYj70T8OIyouCP+Y89I8zs1RWZD9qEnmMhnGWjEkStFHYlbwM9G1ZYeVVkE5OT3
	hC7oaZIQ==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sdY16-00BaIy-Fz; Mon, 12 Aug 2024 18:35:32 +0200
Message-ID: <7673fb84-5fe8-4d80-865d-95df3f519528@igalia.com>
Date: Mon, 12 Aug 2024 17:35:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tvrtko Ursulin <tursulin@igalia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
 <2024062627-curler-unlucky-51e0@gregkh>
 <679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
 <54b357b2-2132-4fd6-89db-7a60617dc859@igalia.com>
 <20240808172726.0000154a@Huawei.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20240808172726.0000154a@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Jonathan,

On 08/08/2024 17:27, Jonathan Cameron wrote:
> On Thu, 8 Aug 2024 12:56:44 +0100
> Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> 
>> [Please excuse the re-send, but as I heard nothing concern is it did not
>> get lost in your busy mailbox.]
>>
>> Hi Greg,
>>
>> Gentle reminder on the opens from this thread. Let me re-summarise the
>> question below:
>>
>> On 26/06/2024 12:47, Tvrtko Ursulin wrote:
>>>
>>> Hi Greg,
>>>
>>> On 26/06/2024 08:38, Greg Kroah-Hartman wrote:
>>>> On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote:
>>>>> From: Maíra Canal <mcanal@igalia.com>
>>>>>
>>>>> Add some common code for splitting the memory into N emulated NUMA
>>>>> memory
>>>>> nodes.
>>>>>
>>>>> Individual architecture can then enable selecting this option and use
>>>>> the
>>>>> existing numa=fake=<N> kernel argument to enable it.
>>>>>
>>>>> Memory is always split into equally sized chunks.
>>>>>
>>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: “Rafael J. Wysocki" <rafael@kernel.org>
>>>>> ---
>>>>>    drivers/base/Kconfig          |  7 ++++
>>>>>    drivers/base/Makefile         |  1 +
>>>>>    drivers/base/arch_numa.c      |  6 ++++
>>>>>    drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
>>>>>    drivers/base/numa_emulation.h | 21 +++++++++++
>>>>
>>>> Why not just properly describe the numa topology in your bootloader or
>>>> device tree and not need any such "fake" stuff at all?
>>>>
>>>> Also, you are now asking me to maintain these new files, not something
>>>> I'm comfortable doing at all sorry.
>>>
>>> Mostly because ae3c107cd8be ("numa: Move numa implementation to common
>>> code") and existing common code in drivers/base/arch_numa.c it appeared
>>> it could be acceptable to add the simple NUMA emulation into the common
>>> code too. Then building upon the same concept as on x86 where no need
>>> for firmware changes is needed for experimenting with different
>>> configurations.
>>>
>>> Would folding into arch_numa.c so no new files are added address your
>>> concern, or your main issue is the emulation in general?
>>
>> Re-iterating and slightly re-formulating this question I see three options:
>>
>> a)
>> Fold the new simple generic code into the existing arch_numa.c,
>> addressing the "no new files" objection, if that was the main objection.
>>
>> b)
>> Move completely into arch code - aka you don't want to see it under
>> drivers/base at all, ever, regardless of how simple the new code is, or
>> that common NUMA code is already there.
>>
>> c)
>> Strong nack for either a) or b) - so "do it in the firmware" comment.
>>
>> Trying to understand your position so we can progress this.
> 
> See:
> https://lore.kernel.org/all/20240807064110.1003856-20-rppt@kernel.org/
> and rest of thread
> https://lore.kernel.org/all/20240807064110.1003856-1-rppt@kernel.org/
> [PATCH v4 00/26] mm: introduce numa_memblks
> 
> Much larger rework and unification set from Mike Rapoport
> that happens to end up adding numa emulation as part of making
> the x86 numa_memblk work for arm64 etc.
> 
> It's in mm-unstable now so getting some test coverage etc.
> 
> Sorry, I'd kind of assumed this also went to linux-mm so
> the connection would have been made.

This is great - I did not see it since I don't read linux-mm regularly!

I gave Mike's implementation a spin on top of RPi 6.11 kernel and it 
mostly works fine.

Is the decision that this is going in pretty much set, that is, high 
level acks are there?

One area to potentially improve is working around CMA areas when they 
are put by the firmware at a range which straddles two nodes. In my 
series, albeit not the one I yet posted, I have some code to fudge that 
so that CMA ends up wholly in one node and so CMA initialisation can 
succeed.

I can try and adapt that patch to this series and post as a RFC.

Then there are some odd things about NUMA, memory pressure and swap 
behaviour, but that is not specific to this series and not something I 
got to the bottom off just yet. Could be specific to my board and IO for 
instance.

Regards,

Tvrtko

