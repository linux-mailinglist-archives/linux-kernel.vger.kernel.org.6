Return-Path: <linux-kernel+bounces-190443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31B8CFE52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF10B20BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1213B5A8;
	Mon, 27 May 2024 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XSr7hJ01"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C813BC1B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806786; cv=none; b=DlDWTBJ+LsZa3ZNHwOIpO3vliJV/GRgK1Rx74qsmnhWWZOrDytGK9muJKHD0zP9zJTixLQNH+m91pHmhnJn8SYPSYZv0H1Q6kIoVloS9ubgx8h3xunNPK7qZzhn2olNcAcmWKYkCfd01BHg94qb9zGWRSGBIDIFnP1lPPs4CP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806786; c=relaxed/simple;
	bh=FuNZk22+jZCWwX+4yEiYRJIWKx8ZL/PckE9EdRBFaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqCDlzCui/dyiT/SoeJscNhWjFDikVu2t5KzeBuWd/6cyTasU8jTCCCmpIvI4UX3PPCaRPBIrroph6e/70gWVxqNW9BxFKHlEvMuj/p9MLXEpKsaLX2/VSuXJky1g//5Zj60haWYf8okCYeHFiA5mKzkmfD1ky3/D7cticFJJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=XSr7hJ01; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6AFE660B21;
	Mon, 27 May 2024 13:46:12 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:e50:b6d:d0ba:2947] (unknown [2a02:6b8:0:419:e50:b6d:d0ba:2947])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id xjM67Q1Ge4Y0-o3SZoNk8;
	Mon, 27 May 2024 13:46:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1716806771;
	bh=foY6hMLRsD6gYR7HtDrQdRpmD7cyxAdDaxwZ8BWPLB8=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=XSr7hJ01t8JJ/ZEXNCVlZO7slr1vojyCXK1+raMxHH63QKJpl0/dAFzcskU7JgnT6
	 UjC/MigE8/igfAvc1N2/YMMvLtAMCyNjL+tQcaKwBRDqvZcJ6OLlmxkVYQF4Q5gEr5
	 yYoHVaXmlkvr4KN5U44ad3NBtfrBJHYXWNdr0bG8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <22da39f0-e73f-4e11-830e-914b5bc04029@yandex-team.ru>
Date: Mon, 27 May 2024 13:45:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <ab3e92eb-d35e-4f5a-8e99-10b3ccb7c2cf@linux.intel.com>
 <20240508051953.oz3q3hdvifo6lb7o@treble>
Content-Language: en-US
From: Maksim Davydov <davydov-max@yandex-team.ru>
In-Reply-To: <20240508051953.oz3q3hdvifo6lb7o@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 08:19, Josh Poimboeuf wrote:
> On Tue, May 07, 2024 at 07:58:07AM -0700, Daniel Sneddon wrote:
>> On 5/6/24 22:30, Josh Poimboeuf wrote:
>>> In cloud environments it can be useful to *only* enable the vmexit
>>> mitigation and leave syscalls vulnerable.  Add that as an option.
>>>
>>> This is similar to the old spectre_bhi=auto option which was removed
>>> with the following commit:
>>>
>>>    36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")
>>>
>>> with the main difference being that this has a more descriptive name and
>>> is disabled by default.
>>>
>>> Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>>> ---
>>
>> Does the KConfig option need to be updated to support this as well?
> 
> In general we don't provide a config option for every possible
> mitigation cmdline option.  If someone requests it we could add it
> later.
> 
>> Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
> 
> Thanks!
> 

I think it will be useful for us to have appropriate Kconfig option. 
Could you please add it to the next version?

-- 
Best regards,
Maksim Davydov

