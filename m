Return-Path: <linux-kernel+bounces-566954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A1A67EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BC3189AC45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFB205E3C;
	Tue, 18 Mar 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b="j5pm5ULW"
Received: from mail.mixaill.net (mail.mixaill.net [144.76.234.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E71DE4FE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.234.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334045; cv=none; b=Z4e5gLeo/ow/QRf2BwsApD2lgIZ77iRiDye24AiZ0K4OmPmJy9ZR+OipxRQhnSYNhkjdsNmsSjTTnIQCFBb44fqxjrRs7nQeaEH5IKnA6l+x5aiQHuBdrIS44AId7ZY4o/MZJk16X6J5Elpr8A7ku7ytIsmYEFvOjCKU8NRgJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334045; c=relaxed/simple;
	bh=K7ab2a/K3NfL+x9Bfn8GCsSpy9aAASBCpiP6IqCjW1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VXB4CbNkNMEllSLbixxsa+1TLe1s86DuNcwCLH/rMLcdMZGKhnQzkAIxuGE5Lt6ps1StZMOGskAJL1ZZNSjjUeHT9ypzf9gZujo+0uXoGDBvaa2bbV6S8Uwqx2C57ZWdOO+1hAHYuuQy144zWTnNHOgdC+kUkia3FztHuZv8pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net; spf=pass smtp.mailfrom=mixaill.net; dkim=pass (2048-bit key) header.d=mixaill.net header.i=@mixaill.net header.b=j5pm5ULW; arc=none smtp.client-ip=144.76.234.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mixaill.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mixaill.net
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5163267D23;
	Tue, 18 Mar 2025 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mixaill.net; s=dkim;
	t=1742334035; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=s/CMtGUKiwFiq6qWBR0zKkGljH1gIOOZu3YPRc+pJDI=;
	b=j5pm5ULWQH640UX0RR/5+5B9SC7I6CnQ284KJ3PBDg5oAimpJbH/rTN8IvWnUSqsEwzZAF
	jOau0LC1itv4GdMD5w6d+3qkPHUpx1NfqpiAcXnXHIQjdly131B6IqUYt13dYgaLLqlqkX
	AL6nDY954oaVaR+MopfvCXFezBD42jVxZU2tt9Mdko1uqrh2J8kME8fsHkx8tdL3KSMqLG
	p3o+5wXt+pGv4Xz+tUmliHlMWLMAM0AgSOQCrybZp88HTPVdXbEoZgTLGsXuhSp0LlFAtV
	AFzovOfUdg/EOomsU+6u73WuzdQs50lS4p40eQghSvGS1wFHtfJwSzRBiCxzIA==
Message-ID: <aa6b15c8-45e9-47b7-8280-84cbacd9aa4c@mixaill.net>
Date: Wed, 19 Mar 2025 00:40:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/rdrand: implement sanity check for RDSEED
To: Mario Limonciello <mario.limonciello@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20250312123130.8290-1-me@mixaill.net>
 <980f8828-1cf8-4ff2-a0d2-f6c9739a7dcc@amd.com>
Content-Language: en-US
From: Mikhail Paulyshka <me@mixaill.net>
In-Reply-To: <980f8828-1cf8-4ff2-a0d2-f6c9739a7dcc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 3/18/25 11:50 PM, Mario Limonciello wrote:
> On 3/12/2025 07:31, Mikhail Paulyshka wrote:
>> On the AMD Cyan Skillfish (Family 0x17 Model 0x47 Stepping 0x0), which
>> is a Zen2-based APU found on the AMD BC-250 board, there is a situation
>> where RDRAND works fine, but RDSEED generates FF. This leads to some
>> applications that use RDSEED to generate random numbers (such as
>> Qt and KDE) into a nearly unusable state.
>>
>> Although AMD has fixed the Zen2 RDRAND issues in 2019 with a 
>> microcode update,
>> no such update has been released for the Family 0x17 Model 0x47 core.
>>
>> This patchset introduces an separate sanity check for RDSEED and 
>> hides the
>> RDSEED and RDRAND from CPUID on AMD platforms in the case of a 
>> malfunction.
>>
>> Mikhail Paulyshka (2):
>>    x86/rdrand: implement sanity check for RDSEED
>>    x86/rdrand: hide RDRAND and RDSEED from CPUID in case of a 
>> malfunction
>>
>>   arch/x86/include/asm/archrandom.h      |  1 +
>>   arch/x86/include/asm/msr-index.h       |  1 +
>>   arch/x86/kernel/cpu/common.c           |  1 +
>>   arch/x86/kernel/cpu/rdrand.c           | 48 ++++++++++++++++++++++++--
>>   tools/arch/x86/include/asm/msr-index.h |  1 +
>>   5 files changed, 49 insertions(+), 3 deletions(-)
>>
>
> Can you please share more about the BIOS firmware version on your device?
>
> /sys/class/dmi/id/bios_version
>
> Thanks,

#cat /sys/class/dmi/id/bios_version
P5.00

I have tried P4.00G and P5.00, both have the same microcode and behavior.



