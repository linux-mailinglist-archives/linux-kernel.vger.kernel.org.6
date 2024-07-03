Return-Path: <linux-kernel+bounces-239016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F3B9254EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F008A2846B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86B137936;
	Wed,  3 Jul 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X6lkPr0L"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA174963C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992847; cv=none; b=sFbkO34q6sWCn0cO/C8KB2ZRgR+m1ec0HcZOmccE2bOhFgwK88vSRXrwlgESTRMEV4SjaROO5spdx4dz1Hjs4Uz+RUIQcYHAlPWbE6GmBur2BvTw34akFh/686SUef5ILYJc5Kfhnx9/+xH1MwduixEoyP0iFHEeKMznzR8jN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992847; c=relaxed/simple;
	bh=oEHIX0th9QXZc3XHaPcLu7VA1oCHGRcgmIY4LU+gPY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PEnRwAYqZSep5xzHtFuhkEtGSiWDbdPOxN4WGpb6bqx8UFOJfYiqFS5sBrNahwVWDPEBKyL1VgMXKICT1D0iRBtSGSiuHyvF8XPAxqKl8uysm0g3vBXOeDmn37zmhJh2NX5stXsLDtDTJgHfnfdv0CzQnB/Xm5AQ4MGnKGNugx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X6lkPr0L; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U8wqaFZL1Wv5rPR7nebfPA7ewssLN2UKabsH+ryj9yM=; b=X6lkPr0LzuBYsZbI9vLcKe9l5z
	kZA8soXqSJABJbd6JnPH5y4RGEPGEwWOT9GbnKh2ZzQTguL5NRX/8kc72zu0nQAp7pdCcvc6zwVyZ
	XhLtO7vT4qiU+vU+NrByWc/GucqgwwHK4tnWw+Q/0HtHWy6MEBxdk3RKlC0C9zc+HqkoqvIUx/tcf
	G8oyiCyy5ojv+h2YeXnQTk74L28a9rMzxvmbQ8/WxgZEIe8PcnAEz8cVQDYe6Al36Lx+FIfZxGXMB
	r49Wpyp5jQGC8po+YLSvisUEqn04GJpeYkboMnXvfw6HnZapTHNVZvlVFnkeZKupvasCSKf4JomlW
	Pm2bHyIw==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sOuhw-00AbWA-Tx; Wed, 03 Jul 2024 09:47:16 +0200
Message-ID: <ec5460f2-83bf-4467-899e-eb7b47c91a23@igalia.com>
Date: Wed, 3 Jul 2024 08:47:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
 <2024062627-curler-unlucky-51e0@gregkh>
 <679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
Content-Language: en-GB
In-Reply-To: <679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Greg,

Gentle reminder on the opens from this thread. Let me re-summarise the 
question below:

On 26/06/2024 12:47, Tvrtko Ursulin wrote:
> 
> Hi Greg,
> 
> On 26/06/2024 08:38, Greg Kroah-Hartman wrote:
>> On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote:
>>> From: Maíra Canal <mcanal@igalia.com>
>>>
>>> Add some common code for splitting the memory into N emulated NUMA 
>>> memory
>>> nodes.
>>>
>>> Individual architecture can then enable selecting this option and use 
>>> the
>>> existing numa=fake=<N> kernel argument to enable it.
>>>
>>> Memory is always split into equally sized chunks.
>>>
>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: “Rafael J. Wysocki" <rafael@kernel.org>
>>> ---
>>>   drivers/base/Kconfig          |  7 ++++
>>>   drivers/base/Makefile         |  1 +
>>>   drivers/base/arch_numa.c      |  6 ++++
>>>   drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
>>>   drivers/base/numa_emulation.h | 21 +++++++++++
>>
>> Why not just properly describe the numa topology in your bootloader or
>> device tree and not need any such "fake" stuff at all?
>>
>> Also, you are now asking me to maintain these new files, not something
>> I'm comfortable doing at all sorry.
> 
> Mostly because ae3c107cd8be ("numa: Move numa implementation to common 
> code") and existing common code in drivers/base/arch_numa.c it appeared 
> it could be acceptable to add the simple NUMA emulation into the common 
> code too. Then building upon the same concept as on x86 where no need 
> for firmware changes is needed for experimenting with different 
> configurations.
> 
> Would folding into arch_numa.c so no new files are added address your 
> concern, or your main issue is the emulation in general?

Re-iterating and slightly re-formulating this question I see three options:

a)
Fold the new simple generic code into the existing arch_numa.c, 
addressing the "no new files" objection, if that was the main objection.

b)
Move completely into arch code - aka you don't want to see it under 
drivers/base at all, ever, regardless of how simple the new code is, or 
that common NUMA code is already there.

c)
Strong nack for either a) or b) - so "do it in the firmware" comment.

Trying to understand your position so we can progress this.

Thanks,

Tvrtko

> 
>  >> +    if (str_has_prefix(opt, "fake="))
>  >> +        return numa_emu_cmdline(opt + 5);
>  >
>  > You did not document this at all :(
> 
> That was indeed an oversight. Just need to "copy with edits" some stuff 
> from Documentation/arch/x86/x86_64/boot-options.rst.
> 
> Regards,
> 
> Tvrtko

