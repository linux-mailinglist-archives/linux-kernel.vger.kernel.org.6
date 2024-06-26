Return-Path: <linux-kernel+bounces-230657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDC91801C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DD1C23DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9E17FAAE;
	Wed, 26 Jun 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SzPJBgIa"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EA139D04
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402466; cv=none; b=K6lMFTzuijhK88oSCgBiv0yF2O1T0kfG5d6LMVODPyQCrnGHQ08nGcieKvwDR40FFsY6DIY30uGVXbDZ8ciGYJAl0PzMD9du3U0G8a26wkoLGYj5fLpGYWiTsL/tuGEnlwNaQumgl3vWOqfh6W04r2n09YOsIMwmbRk862NYHqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402466; c=relaxed/simple;
	bh=NXvNCfJBiOC4cDVq6wgX5T9ejjikOk/NuWdpeWUTQBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgcV2B7Eqok2U+SGzElOxviABkOmoCHi2YcyPggHoQF+7VyEre1ZP4PhVkzDRC8ERYT0pwP6fvhvUpkSnxt9QRmIG1Kji2MM2NRdDt+0UhyouKy/VdZkNLErAzw8lyPqNI3vU9T0zD/Mjh0VTGbuaDuZgvghj7hiqCtvHrSm4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SzPJBgIa; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h62uoznaDCuRfrbwlBFnF/jPAghomXKtZxy+Vr/1XDM=; b=SzPJBgIamnTpKWWoG0monzc9aw
	6cY8qk9rLdZ8R8htTSG8M8BdwOJ6xz5+RMGGTGXR1LVvlQ2dPvIGKPch5j6JZris9N47BgJdGQWb1
	ljTgc3Vugc6o/k3ka3Uu2/jsa9BWu8kZ8dXvqT4Sm7ObghfO2wHLSpfIFqXoVOFJYhBZd2CGimgY5
	IUuAEEwugt73wILT6s4hOE1izxDx73r9fCNvLix7jygeJhqV/TgDhsAEyfQA3iTo8FwkATof1JkBK
	4VcEQdeezSa1HUX5LdgwF5llH14lqJmkizoJH+pFuoup5ucouCu4PpKfTLjR0yAbub4pWUQdqY7v+
	IJAE6NFg==;
Received: from [84.69.19.168] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sMR7e-007gkC-CJ; Wed, 26 Jun 2024 13:47:34 +0200
Message-ID: <679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
Date: Wed, 26 Jun 2024 12:47:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tvrtko Ursulin <tursulin@igalia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
 <2024062627-curler-unlucky-51e0@gregkh>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <2024062627-curler-unlucky-51e0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Greg,

On 26/06/2024 08:38, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote:
>> From: Maíra Canal <mcanal@igalia.com>
>>
>> Add some common code for splitting the memory into N emulated NUMA memory
>> nodes.
>>
>> Individual architecture can then enable selecting this option and use the
>> existing numa=fake=<N> kernel argument to enable it.
>>
>> Memory is always split into equally sized chunks.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: “Rafael J. Wysocki" <rafael@kernel.org>
>> ---
>>   drivers/base/Kconfig          |  7 ++++
>>   drivers/base/Makefile         |  1 +
>>   drivers/base/arch_numa.c      |  6 ++++
>>   drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
>>   drivers/base/numa_emulation.h | 21 +++++++++++
> 
> Why not just properly describe the numa topology in your bootloader or
> device tree and not need any such "fake" stuff at all?
> 
> Also, you are now asking me to maintain these new files, not something
> I'm comfortable doing at all sorry.

Mostly because ae3c107cd8be ("numa: Move numa implementation to common 
code") and existing common code in drivers/base/arch_numa.c it appeared 
it could be acceptable to add the simple NUMA emulation into the common 
code too. Then building upon the same concept as on x86 where no need 
for firmware changes is needed for experimenting with different 
configurations.

Would folding into arch_numa.c so no new files are added address your 
concern, or your main issue is the emulation in general?

 >> +	if (str_has_prefix(opt, "fake="))
 >> +		return numa_emu_cmdline(opt + 5);
 >
 > You did not document this at all :(

That was indeed an oversight. Just need to "copy with edits" some stuff 
from Documentation/arch/x86/x86_64/boot-options.rst.

Regards,

Tvrtko

